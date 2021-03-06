{
{-# OPTIONS -w #-}

-- Copyright (c) 2006-2011
--         The President and Fellows of Harvard College.
--
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions
-- are met:
-- 1. Redistributions of source code must retain the above copyright
--    notice, this list of conditions and the following disclaimer.
-- 2. Redistributions in binary form must reproduce the above copyright
--    notice, this list of conditions and the following disclaimer in the
--    documentation and/or other materials provided with the distribution.
-- 3. Neither the name of the University nor the names of its contributors
--    may be used to endorse or promote products derived from this software
--    without specific prior written permission.

-- THIS SOFTWARE IS PROVIDED BY THE UNIVERSITY AND CONTRIBUTORS ``AS IS'' AND
-- ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-- IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
-- ARE DISCLAIMED.  IN NO EVENT SHALL THE UNIVERSITY OR CONTRIBUTORS BE LIABLE
-- FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
-- DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
-- OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
-- HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
-- LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
-- OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
-- SUCH DAMAGE.

--------------------------------------------------------------------------------
-- |
-- Module      :  Language.C.Parser.Parser
-- Copyright   :  (c) Harvard University 2006-2011
-- License     :  BSD-style
-- Maintainer  :  mainland@eecs.harvard.edu
--
--------------------------------------------------------------------------------

module Language.C.Parser.Parser where

import Control.Monad (forM_,
                      when)
import Control.Monad.Exception
import Data.List (intersperse)
import Data.Loc
import Data.Maybe (catMaybes)
import Text.PrettyPrint.Mainland

import Language.C.Parser.Lexer
import Language.C.Parser.Monad
import qualified Language.C.Parser.Tokens as T
import Language.C.Pretty
import Language.C.Syntax
import qualified Language.C.Syntax as C
}

%token
 CHAR        { L _ (T.TcharConst _) }
 STRING      { L _ (T.TstringConst _) }
 INT         { L _ (T.TintConst _) }
 LONG        { L _ (T.TlongIntConst _) }
 LONG_LONG   { L _ (T.TlongLongIntConst _) }
 FLOAT       { L _ (T.TfloatConst _) }
 DOUBLE      { L _ (T.TdoubleConst _) }
 LONG_DOUBLE { L _ (T.TlongDoubleConst _) }
 ID          { L _ (T.Tidentifier _) }
 NAMED       { L _ (T.Tnamed _) }

 '('    { L _ T.Tlparen }
 ')'    { L _ T.Trparen }
 '['    { L _ T.Tlbrack }
 ']'    { L _ T.Trbrack }
 '{'    { L _ T.Tlbrace }
 '}'    { L _ T.Trbrace }
 ','    { L _ T.Tcomma }
 ';'    { L _ T.Tsemi }
 ':'    { L _ T.Tcolon }
 '?'    { L _ T.Tquestion }
 '.'    { L _ T.Tdot }
 '->'   { L _ T.Tarrow }
 '...'  { L _ T.Tellipses }

 '+'   { L _ T.Tplus }
 '-'   { L _ T.Tminus }
 '*'   { L _ T.Tstar }
 '/'   { L _ T.Tdiv }
 '%'   { L _ T.Tmod }
 '~'   { L _ T.Tnot }
 '&'   { L _ T.Tand }
 '|'   { L _ T.Tor }
 '^'   { L _ T.Txor }
 '<<'  { L _ T.Tlsh }
 '>>'  { L _ T.Trsh }
 '++'  { L _ T.Tinc }
 '--'  { L _ T.Tdec }

 '!'   { L _ T.Tlnot }
 '&&'  { L _ T.Tland }
 '||'  { L _ T.Tlor }

 '=='  { L _ T.Teq }
 '!='  { L _ T.Tne }
 '<'   { L _ T.Tlt }
 '>'   { L _ T.Tgt }
 '<='  { L _ T.Tle }
 '>='  { L _ T.Tge }

 '='   { L _ T.Tassign }
 '+='  { L _ T.Tadd_assign }
 '-='  { L _ T.Tsub_assign }
 '*='  { L _ T.Tmul_assign }
 '/='  { L _ T.Tdiv_assign }
 '%='  { L _ T.Tmod_assign }
 '<<=' { L _ T.Tlsh_assign }
 '>>=' { L _ T.Trsh_assign }
 '&='  { L _ T.Tand_assign }
 '|='  { L _ T.Tor_assign }
 '^='  { L _ T.Txor_assign }

 'auto'       { L _ T.Tauto }
 'break'      { L _ T.Tbreak }
 'case'       { L _ T.Tcase }
 'char'       { L _ T.Tchar }
 'const'      { L _ T.Tconst }
 'continue'   { L _ T.Tcontinue }
 'default'    { L _ T.Tdefault }
 'do'         { L _ T.Tdo }
 'double'     { L _ T.Tdouble }
 'else'       { L _ T.Telse }
 'enum'       { L _ T.Tenum }
 'extern'     { L _ T.Textern }
 'float'      { L _ T.Tfloat }
 'for'        { L _ T.Tfor }
 'goto'       { L _ T.Tgoto }
 'if'         { L _ T.Tif }
 'inline'     { L _ T.Tinline }
 'int'        { L _ T.Tint }
 'long'       { L _ T.Tlong }
 'register'   { L _ T.Tregister }
 'restrict'   { L _ T.Trestrict }
 'return'     { L _ T.Treturn }
 'short'      { L _ T.Tshort }
 'signed'     { L _ T.Tsigned }
 'sizeof'     { L _ T.Tsizeof }
 'static'     { L _ T.Tstatic }
 'struct'     { L _ T.Tstruct }
 'switch'     { L _ T.Tswitch }
 'typedef'    { L _ T.Ttypedef }
 'union'      { L _ T.Tunion }
 'unsigned'   { L _ T.Tunsigned }
 'void'       { L _ T.Tvoid }
 'volatile'   { L _ T.Tvolatile }
 'while'      { L _ T.Twhile }
 '_Bool'      { L _ T.TBool }
 '_Complex'   { L _ T.TComplex }
 '_Imaginary' { L _ T.TImaginary }

 '__asm__'           { L _ T.Tasm }
 '__attribute__'     { L _ T.Tattribute }
 '__extension__'     { L _ T.Textension }
 '__builtin_va_arg'  { L _ T.Tbuiltin_va_arg }
 '__builtin_va_list' { L _ T.Tbuiltin_va_list }
 '__typeof__'        { L _ T.Ttypeof }

 '<<<'           { L _ T.T3lt }
 '>>>'           { L _ T.T3gt }
 '__device__'    { L _ T.Tdevice }
 '__global__'    { L _ T.Tglobal }
 '__host__'      { L _ T.Thost }
 '__constant__'  { L _ T.Tconstant }
 '__shared__'    { L _ T.Tshared }
 '__noinline__'  { L _ T.Tnoinline }

 'private'      { L _ T.TCLPrivate }
 '__private'    { L _ T.TCLPrivate }
 'local'        { L _ T.TCLLocal }
 '__local'      { L _ T.TCLLocal }
 'global'       { L _ T.TCLGlobal }
 '__global'     { L _ T.TCLGlobal }
 'constant'     { L _ T.TCLConstant }
 '__constant'   { L _ T.TCLConstant }
 'read_only'    { L _ T.TCLReadOnly }
 '__read_only'  { L _ T.TCLReadOnly }
 'write_only'   { L _ T.TCLWriteOnly }
 '__write_only' { L _ T.TCLWriteOnly }
 'kernel'       { L _ T.TCLKernel }
 '__kernel'     { L _ T.TCLKernel }

 'typename'       { L _ T.Ttypename }

 ANTI_ID          { L _ (T.Tanti_id _) }
 ANTI_INT         { L _ (T.Tanti_int _) }
 ANTI_UINT        { L _ (T.Tanti_uint _) }
 ANTI_LINT        { L _ (T.Tanti_lint _) }
 ANTI_ULINT       { L _ (T.Tanti_ulint _) }
 ANTI_FLOAT       { L _ (T.Tanti_float _) }
 ANTI_DOUBLE      { L _ (T.Tanti_double _) }
 ANTI_LONG_DOUBLE { L _ (T.Tanti_long_double _) }
 ANTI_CHAR        { L _ (T.Tanti_char _) }
 ANTI_STRING      { L _ (T.Tanti_string _) }
 ANTI_EXP         { L _ (T.Tanti_exp _) }
 ANTI_FUNC        { L _ (T.Tanti_func _) }
 ANTI_ARGS        { L _ (T.Tanti_args _) }
 ANTI_DECL        { L _ (T.Tanti_decl _) }
 ANTI_DECLS       { L _ (T.Tanti_decls _) }
 ANTI_SDECL       { L _ (T.Tanti_sdecl _) }
 ANTI_SDECLS      { L _ (T.Tanti_sdecls _) }
 ANTI_ENUM        { L _ (T.Tanti_enum _) }
 ANTI_ENUMS       { L _ (T.Tanti_enums _) }
 ANTI_ESC         { L _ (T.Tanti_esc _) }
 ANTI_EDECL       { L _ (T.Tanti_edecl _) }
 ANTI_EDECLS      { L _ (T.Tanti_edecls _) }
 ANTI_ITEM        { L _ (T.Tanti_item _) }
 ANTI_ITEMS       { L _ (T.Tanti_items _) }
 ANTI_STM         { L _ (T.Tanti_stm _) }
 ANTI_STMS        { L _ (T.Tanti_stms _) }
 ANTI_SPEC        { L _ (T.Tanti_spec _) }
 ANTI_TYPE        { L _ (T.Tanti_type _) }
 ANTI_PARAM       { L _ (T.Tanti_param _) }
 ANTI_PARAMS      { L _ (T.Tanti_params _) }

%expect 1

%monad { P } { >>= } { return }
%lexer { lexer } { L _ T.Teof }
%tokentype { (L T.Token) }
%error { happyError }

%name parseExp        expression

%name parseEdecl      external_declaration
%name parseDecl       declaration
%name parseStructDecl struct_declaration
%name parseEnum       enumerator

%name parseType       type_declaration
%name parseParam      parameter_declaration
%name parseInit       initializer

%name parseStm        statement

%name parseUnit       translation_unit
%name parseFunc       function_definition

%right NAMED
%%

{------------------------------------------------------------------------------
 -
 - Identifiers
 -
 ------------------------------------------------------------------------------}

identifier :: { Id }
identifier :
    ID       { Id (getID $1) (locOf $1) }
  | ANTI_ID  { AntiId (getANTI_ID $1) (locOf $1) }

identifier_or_typedef :: { Id }
identifier_or_typedef :
    identifier  { $1 }
  | NAMED       { Id (getNAMED $1) (locOf $1) }

{------------------------------------------------------------------------------
 -
 - Constants
 -
 ------------------------------------------------------------------------------}

constant :: {  Const }
constant :
    INT               { let (s, sign, n) = getINT $1
                        in
                          IntConst s sign n (locOf $1)
                      }
  | LONG              { let (s, sign, n) = getLONG $1
                        in
                          LongIntConst s sign n (locOf $1)
                      }
  | LONG_LONG         { let (s, sign, n) = getLONG_LONG $1
                        in
                          LongLongIntConst s sign n (locOf $1)
                      }
  | FLOAT             { let (s, n) = getFLOAT $1
                        in
                          FloatConst s n (locOf $1)
                      }
  | DOUBLE            { let (s, n) = getDOUBLE $1
                        in
                          DoubleConst s n (locOf $1)
                      }
  | LONG_DOUBLE       { let (s, n) = getLONG_DOUBLE $1
                        in
                          LongDoubleConst s n (locOf $1)
                      }
  | CHAR              { let (s, c) = getCHAR $1
                        in
                          CharConst s c (locOf $1)
                      }
  | ANTI_INT          { AntiInt (getANTI_INT $1) (locOf $1) }
  | ANTI_UINT         { AntiUInt (getANTI_UINT $1) (locOf $1) }
  | ANTI_LINT         { AntiLInt (getANTI_LINT $1) (locOf $1) }
  | ANTI_ULINT        { AntiULInt (getANTI_ULINT $1) (locOf $1) }
  | ANTI_FLOAT        { AntiFloat (getANTI_FLOAT $1) (locOf $1) }
  | ANTI_DOUBLE       { AntiDouble (getANTI_DOUBLE $1) (locOf $1) }
  | ANTI_LONG_DOUBLE  { AntiLongDouble (getANTI_LONG_DOUBLE $1) (locOf $1) }
  | ANTI_CHAR         { AntiChar (getANTI_CHAR $1) (locOf $1) }
  | ANTI_STRING       { AntiString (getANTI_STRING $1) (locOf $1) }


{------------------------------------------------------------------------------
 -
 - Expressions
 -
 ------------------------------------------------------------------------------}

primary_expression :: { Exp }
primary_expression :
    identifier
      { Var $1 (locOf $1) }
  | constant
      { Const $1 (locOf $1) }
  | string_constant
      { let  {  ss   = rev $1
             ;  loc  = locOf ss
             ;  raw  = map (fst . unLoc) ss
             ;  s    = (concat . intersperse " " . map (snd . unLoc)) ss
             }
        in
          Const (StringConst raw s loc) loc
      }
  | '(' expression ')'
      { $2 }
  | '(' expression error
      {% unclosed ($1 <--> $2) "(" }
  | '(' compound_statement ')'
      { let Block items _ = $2
        in
          StmExpr items ($1 <--> $3)
      }
  | ANTI_EXP
      { AntiExp (getANTI_EXP $1) (locOf $1) }

string_constant :: { RevList (L (String, String)) }
string_constant :
    STRING                  { rsingleton (L (getLoc $1) (getSTRING $1)) }
    {- Extension: GCC -}
  | string_constant STRING  { rcons (L (getLoc $2) (getSTRING $2)) $1 }

postfix_expression :: { Exp }
postfix_expression :
    primary_expression
      { $1 }
  | postfix_expression '[' error
      {% unclosed (locOf $1) "[" }
  | postfix_expression '[' expression ']'
      { Index $1 $3 ($1 <--> $4) }

  | postfix_expression '(' error
      {% unclosed (locOf $2) "(" }
  | postfix_expression '(' ')'
      { FnCall $1 [] ($1 <--> $3) }
  | postfix_expression '(' argument_expression_list error
      {% unclosed ($2 <--> rev $3) "(" }
  | postfix_expression '(' argument_expression_list ')'
      { FnCall $1 (rev $3) ($1 <--> $4) }

  | postfix_expression '<<<' execution_configuration error
      {% unclosed ($2 <--> $3) "<<<" }
  | postfix_expression '<<<' execution_configuration '>>>' '(' ')'
      { CudaCall $1 $3 [] ($1 <--> $6) }
  | postfix_expression '<<<' execution_configuration '>>>'
                       '(' argument_expression_list error
      {% unclosed ($5 <--> rev $6) "(" }
  | postfix_expression '<<<' execution_configuration '>>>'
                       '(' argument_expression_list ')'
      { CudaCall $1 $3 (rev $6) ($1 <--> $7) }

  | postfix_expression '.' identifier_or_typedef
      { Member $1 $3 ($1 <--> $3) }
  | postfix_expression '->' identifier_or_typedef
      { PtrMember $1 $3 ($1 <--> $3) }
  | postfix_expression '++'
      { PostInc $1 ($1 <--> $2) }
  | postfix_expression '--'
      { PostDec $1 ($1 <--> $2) }
  | '(' type_name ')' '{' initializer_list '}'
      { CompoundLit ($2 :: Type) (rev $5) ($1 <--> $6) }
  | '(' type_name ')' '{' initializer_list ',' '}'
      { CompoundLit $2 (rev $5) ($1 <--> $7) }
  {- Extension: GCC -}
  | '__builtin_va_arg' '(' assignment_expression ',' type_declaration ')'
      { BuiltinVaArg $3 $5 ($1 <--> $6) }

{- Extension: CUDA -}
execution_configuration :: { ExeConfig }
execution_configuration :
  argument_expression_list
    {%do {  let args = rev $1
         ;  when (length args < 2 || length args > 4) $
                badExecutionContext (getLoc args) args
         ;  return $
            case args of
              [gridDim, blockDim] ->
                  ExeConfig  gridDim blockDim
                             Nothing Nothing
                             (locOf args)
              [gridDim, blockDim, sharedSize] ->
                  ExeConfig  gridDim blockDim
                             (Just sharedSize) Nothing
                             (locOf args)
              [gridDim, blockDim, sharedSize, exeStream] ->
                  ExeConfig  gridDim blockDim
                             (Just sharedSize) (Just exeStream)
                             (locOf args)
         }
    }

argument_expression_list :: { RevList Exp }
argument_expression_list :
    assignment_expression
      { rsingleton $1 }
  | ANTI_ARGS
      { rsingleton (AntiArgs (getANTI_ARGS $1) (locOf $1)) }
  | argument_expression_list ',' assignment_expression
      { rcons $3 $1}
  | argument_expression_list ',' ANTI_ARGS
      { rcons (AntiArgs (getANTI_ARGS $3) (locOf $3)) $1 }

unary_expression :: { Exp }
unary_expression :
    postfix_expression            { $1 }
  | '++' unary_expression         { PreInc $2 ($1 <--> $2) }
  | '--' unary_expression         { PreDec $2 ($1 <--> $2) }
  | '&' cast_expression           { UnOp AddrOf $2 ($1 <--> $2) }
  | '*' cast_expression           { UnOp Deref $2 ($1 <--> $2) }
  | '+' cast_expression           { UnOp Positive $2 ($1 <--> $2) }
  | '-' cast_expression           { UnOp Negate $2 ($1 <--> $2) }
  | '~' cast_expression           { UnOp Not $2 ($1 <--> $2) }
  | '!' cast_expression           { UnOp Lnot $2 ($1 <--> $2) }
  | 'sizeof' unary_expression     { SizeofExp $2 ($1 <--> $2) }
  | 'sizeof' '(' type_name ')'    { SizeofType $3 ($1 <--> $4) }
  | 'sizeof' '(' type_name error  {% unclosed ($2 <--> $3) "(" }

cast_expression :: { Exp }
cast_expression :
    unary_expression                   { $1 }
  | '(' type_name ')' cast_expression  { Cast $2 $4 ($1 <--> $4) }
  | '(' type_name error                {% unclosed ($1 <--> $2) "(" }

multiplicative_expression :: { Exp }
multiplicative_expression :
    cast_expression
      { $1 }
  | multiplicative_expression '*' cast_expression
      { BinOp Mul $1 $3 ($1 <--> $3) }
  | multiplicative_expression '/' cast_expression
      { BinOp Div $1 $3 ($1 <--> $3) }
  | multiplicative_expression '%' cast_expression
      { BinOp Mod $1 $3 ($1 <--> $3) }

additive_expression :: { Exp }
additive_expression :
    multiplicative_expression
      { $1 }
  | additive_expression '+' multiplicative_expression
      { BinOp Add $1 $3 ($1 <--> $3) }
  | additive_expression '-' multiplicative_expression
      { BinOp Sub $1 $3 ($1 <--> $3) }

shift_expression :: { Exp }
shift_expression :
    additive_expression
      { $1 }
  | shift_expression '<<' additive_expression
      { BinOp Lsh $1 $3 ($1 <--> $3) }
  | shift_expression '>>' additive_expression
      { BinOp Rsh $1 $3 ($1 <--> $3) }

relational_expression :: { Exp }
relational_expression :
    shift_expression
      { $1 }
  | relational_expression '<' shift_expression
      { BinOp Lt $1 $3 ($1 <--> $3) }
  | relational_expression '>' shift_expression
      { BinOp Gt $1 $3 ($1 <--> $3) }
  | relational_expression '<=' shift_expression
      { BinOp Le $1 $3 ($1 <--> $3) }
  | relational_expression '>=' shift_expression
      { BinOp Ge $1 $3 ($1 <--> $3) }

equality_expression :: { Exp }
equality_expression :
    relational_expression
      { $1 }
  | equality_expression '==' relational_expression
      { BinOp Eq $1 $3 ($1 <--> $3) }
  | equality_expression '!=' relational_expression
      { BinOp Ne $1 $3 ($1 <--> $3) }

and_expression :: { Exp }
and_expression :
    equality_expression
      { $1 }
  | and_expression '&' equality_expression
      { BinOp And $1 $3 ($1 <--> $3) }

exclusive_or_expression :: { Exp }
exclusive_or_expression :
    and_expression
      { $1 }
  | exclusive_or_expression '^' and_expression
      { BinOp Xor $1 $3 ($1 <--> $3) }

inclusive_or_expression :: { Exp }
inclusive_or_expression :
    exclusive_or_expression
      { $1 }
  | inclusive_or_expression '|' exclusive_or_expression
      { BinOp Or $1 $3 ($1 <--> $3) }

logical_and_expression :: { Exp }
logical_and_expression :
    inclusive_or_expression
      { $1 }
  | logical_and_expression '&&' inclusive_or_expression
      { BinOp Land $1 $3 ($1 <--> $3) }

logical_or_expression :: { Exp }
logical_or_expression :
    logical_and_expression
      { $1 }
  | logical_or_expression '||' logical_and_expression
      { BinOp Lor $1 $3 ($1 <--> $3) }

conditional_expression :: { Exp }
conditional_expression :
    logical_or_expression
      { $1 }
  | logical_or_expression '?' expression ':' conditional_expression
      { Cond $1 $3 $5 ($1 <--> $5) }

assignment_expression :: { Exp }
assignment_expression :
    conditional_expression
      { $1 }
  | unary_expression '=' assignment_expression
      { Assign $1 JustAssign $3 ($1 <--> $3) }
  | unary_expression '*=' assignment_expression
      { Assign $1 MulAssign $3 ($1 <--> $3) }
  | unary_expression '/=' assignment_expression
      { Assign $1 DivAssign $3 ($1 <--> $3) }
  | unary_expression '%=' assignment_expression
      { Assign $1 ModAssign $3 ($1 <--> $3) }
  | unary_expression '+=' assignment_expression
      { Assign $1 AddAssign $3 ($1 <--> $3) }
  | unary_expression '-=' assignment_expression
      { Assign $1 SubAssign $3 ($1 <--> $3) }
  | unary_expression '<<=' assignment_expression
      { Assign $1 LshAssign $3 ($1 <--> $3) }
  | unary_expression '>>=' assignment_expression
      { Assign $1 RshAssign $3 ($1 <--> $3) }
  | unary_expression '&=' assignment_expression
      { Assign $1 AndAssign $3 ($1 <--> $3) }
  | unary_expression '^=' assignment_expression
      { Assign $1 XorAssign $3 ($1 <--> $3) }
  | unary_expression '|=' assignment_expression
      { Assign $1 OrAssign $3 ($1 <--> $3) }

expression :: { Exp }
expression :
    assignment_expression                 { $1 }
  | expression ',' assignment_expression  { Seq $1 $3 ($1 <--> $3) }

maybe_expression :: { Maybe Exp  }
maybe_expression:
    {- empty -}  { Nothing }
  | expression   { Just $1 }

constant_expression :: { Exp }
constant_expression :
  conditional_expression { $1 }

{------------------------------------------------------------------------------
 -
 - Declarations
 -
 ------------------------------------------------------------------------------}

{-
-- XXX: This is an awful hack to get around problems with the interaction
-- between lexer feedback and the one-token lookahead that happy does. If we
-- encounter a typedef and the next token is the newly typedef'd type, we get an
-- error if we include the terminal semicolon directly in the productions for
-- declaration. By splitting the semicolon out, the lookahead token is
-- guaranteed not to be a typedef use :)
-}

declaration :: { InitGroup }
declaration :
    declaration_ ';' { $1 }

declaration_ :: { InitGroup }
declaration_ :
    declaration_specifiers
      {% do{ let (dspec, decl)  = $1
           ; checkInitGroup dspec decl [] []
           }
      }
  | declaration_specifiers attributes
      {% do{ let (dspec, decl)  = $1
           ; checkInitGroup dspec decl $2 []
           }
      }
  | declaration_specifiers init_declarator_list
      {% do{ let (dspec, decl)  = $1
           ; let inits          = rev $2
           ; checkInitGroup dspec decl [] (rev $2)
           }
      }
  | declaration_specifiers attributes init_declarator_list
      {% do{ let (dspec, decl) = $1
           ; checkInitGroup dspec decl $2 (rev $3)
           }
      }
  | declaration_specifiers error
      {% do{ let (_, decl)  = $1
           ; expected (locOf decl) ["';'"]
           }
      }
  | ANTI_DECL
      { AntiDecl (getANTI_DECL $1) (locOf $1) }

declaration_specifiers :: { (DeclSpec, Decl) }
declaration_specifiers :
    ANTI_TYPE
      { let  {  v    = getANTI_TYPE $1
             ;  loc  = locOf $1
             }
        in
          (AntiTypeDeclSpec [] [] v loc, AntiTypeDecl v loc)
      }
  | storage_qualifier_specifiers ANTI_TYPE
      { let { storage   = mkStorage $1
            ; typeQuals = mkTypeQuals $1
            ; v         = getANTI_TYPE $2
            ; loc       = $1 <--> $2
            }
        in
          (AntiTypeDeclSpec storage typeQuals v loc, AntiTypeDecl v loc)
      }
  | nontypedef_declaration_specifiers
      { $1 }
  | typedef_declaration_specifiers
      { $1 }

nontypedef_declaration_specifiers :: { (DeclSpec, Decl) }
nontypedef_declaration_specifiers :
    ANTI_SPEC
      { let dspec = AntiDeclSpec (getANTI_SPEC $1) (locOf $1)
        in
          (dspec, DeclRoot (locOf $1))
      }
  | storage_qualifier_specifiers %prec NAMED
      {% do{ dspec <- mkDeclSpec $1
           ; return (dspec, DeclRoot (locOf $1))
           }
      }
  | type_specifier
      {% do{ dspec <- mkDeclSpec [$1]
           ; return (dspec, DeclRoot (locOf $1) )
           }
      }
  | type_specifier declaration_specifiers_
      {% do{ dspec <- mkDeclSpec ($1 : $2)
           ; return (dspec, DeclRoot ($1 <--> $2))
           }
      }
  | storage_qualifier_specifiers type_specifier
      {% do{ dspec <- mkDeclSpec ($1 ++ [$2])
           ; return $(dspec, DeclRoot ($1 <--> $2))
           }
      }
  | storage_qualifier_specifiers type_specifier declaration_specifiers_
      {% do{ dspec <- mkDeclSpec ($1 ++ $2 : $3)
           ; return (dspec, DeclRoot ($1 <--> $3))
           }
      }

typedef_declaration_specifiers :: { (DeclSpec, Decl) }
typedef_declaration_specifiers :
    typedef_name
      {% do{ dspec <- mkDeclSpec [$1]
           ; return (dspec, DeclRoot (locOf $1))
           }
      }
  | typedef_name storage_qualifier_specifiers
      {% do{ dspec <- mkDeclSpec ($1 : $2)
           ; return (dspec, DeclRoot ($1 <--> $2))
           }
      }
  | storage_qualifier_specifiers typedef_name
      {% do{ dspec <- mkDeclSpec ($1 ++ [$2])
           ; return (dspec, DeclRoot ($1 <--> $2))
           }
      }
  | storage_qualifier_specifiers typedef_name storage_qualifier_specifiers
      {% do{ dspec <- mkDeclSpec ($1 ++ $2 : $3)
           ; return (dspec, DeclRoot ($1 <--> $3))
           }
      }

declaration_specifiers_ :: { [TySpec] }
declaration_specifiers_ :
    storage_class_specifier %prec NAMED              { [$1] }
  | storage_class_specifier declaration_specifiers_  { $1 : $2 }
  | type_specifier %prec NAMED                       { [$1] }
  | type_specifier declaration_specifiers_           { $1 : $2 }
  | type_qualifier %prec NAMED                       { [$1] }
  | type_qualifier declaration_specifiers_           { $1 : $2 }

-- | This production allows us to add storage class specifiers and type
-- qualifiers to an anti-quoted type.

storage_qualifier_specifiers :: { [TySpec] }
storage_qualifier_specifiers :
    storage_class_specifier %prec NAMED                   { [$1]}
  | storage_class_specifier storage_qualifier_specifiers  { $1 : $2 }
  | type_qualifier %prec NAMED                            { [$1] }
  | type_qualifier storage_qualifier_specifiers           { $1 : $2 }

init_declarator_list :: { RevList Init }
init_declarator_list :
    init_declarator                           { rsingleton $1 }
  | init_declarator_list ',' init_declarator  { rcons $3 $1 }

maybe_asmlabel :: { Maybe AsmLabel }
maybe_asmlabel :
     {- empty -}             { Nothing }
  | '__asm__' '(' STRING ')' { Just ((fst . getSTRING) $3) }

init_declarator :: { Init }
init_declarator :
    declarator maybe_asmlabel
      { let  {  (ident, declToDecl) = $1
             ;  decl                = declToDecl (declRoot ident)
             }
        in
          Init ident decl $2 Nothing [] (ident <--> decl)
      }
  | declarator attributes maybe_asmlabel
      { let  { (ident, declToDecl) = $1
             ;  decl               = declToDecl (declRoot ident)
             }
        in
          Init ident decl $3 Nothing $2 (ident <--> decl)
      }
  | declarator maybe_asmlabel '=' initializer
      { let  {  (ident, declToDecl) = $1
             ;  decl                = declToDecl (declRoot ident)
             }
        in
          Init ident decl $2 (Just $4) [] (ident <--> $4)
      }
  | declarator maybe_asmlabel '=' attributes initializer
      { let  {  (ident, declToDecl) = $1
             ;  decl                = declToDecl (declRoot ident)
             }
        in
          Init ident decl $2 (Just $5) $4 (ident <--> $5)
      }
  | declarator error
      {% do{  let (ident, declToDecl) = $1
           ;  let decl                = declToDecl (declRoot ident)
           ;  expected (locOf decl) ["'='"]
           }
      }

storage_class_specifier :: { TySpec }
storage_class_specifier :
    'auto'           { TSauto (locOf $1) }
  | 'register'       { TSregister (locOf $1) }
  | 'static'         { TSstatic (locOf $1) }
  | 'extern'         { TSextern (locOf $1) }
  | 'extern' STRING  { TSexternL ((snd . getSTRING) $2) (locOf $1) }
  | 'typedef'        { TStypedef (locOf $1) }

type_specifier :: { TySpec }
type_specifier :
    'void'                    { TSvoid (locOf $1) }
  | 'char'                    { TSchar (locOf $1) }
  | 'short'                   { TSshort (locOf $1) }
  | 'int'                     { TSint (locOf $1) }
  | 'long'                    { TSlong (locOf $1) }
  | 'float'                   { TSfloat (locOf $1) }
  | 'double'                  { TSdouble (locOf $1) }
  | 'signed'                  { TSsigned (locOf $1) }
  | 'unsigned'                { TSunsigned (locOf $1) }
  | struct_or_union_specifier { $1 }
  | enum_specifier            { $1 }

  {- Extension: GCC -}
  | '__builtin_va_list' { TSva_list (locOf $1) }

struct_or_union_specifier :: { TySpec }
struct_or_union_specifier :
    struct_or_union identifier_or_typedef
      { (unLoc $1) (Just $2) Nothing [] ($1 <--> $2) }
  | struct_or_union attributes identifier_or_typedef
      { (unLoc $1) (Just $3) Nothing $2 ($1 <--> $3) }
  | struct_or_union '{' struct_declaration_list '}'
      { (unLoc $1) Nothing (Just (rev $3)) [] ($1 <--> $4) }
  | struct_or_union '{' struct_declaration_list error
      {% unclosed ($1 <--> rev $3) "{" }
  | struct_or_union identifier_or_typedef '{' struct_declaration_list '}'
      { (unLoc $1) (Just $2) (Just (rev $4)) [] ($1 <--> $5) }
  | struct_or_union identifier_or_typedef '{' struct_declaration_list error
      {% unclosed ($1 <--> rev $4) "{" }
  | struct_or_union attributes identifier_or_typedef '{' struct_declaration_list '}'
      { (unLoc $1) (Just $3) (Just (rev $5)) $2 ($1 <--> $6) }
  | struct_or_union attributes identifier_or_typedef '{' struct_declaration_list error
      {% unclosed ($1 <--> rev $5) "{" }

struct_or_union :: { L (Maybe Id -> Maybe [FieldGroup] -> [Attr] -> SrcLoc -> TySpec) }
struct_or_union :
    'struct' { L (getLoc $1) TSstruct }
  | 'union'  { L (getLoc $1) TSunion }

struct_declaration_list :: { RevList FieldGroup }
struct_declaration_list :
    struct_declaration
      { rsingleton $1 }
  | ANTI_SDECLS
      { rsingleton (AntiSdecls (getANTI_SDECLS $1) (locOf $1)) }
  | struct_declaration_list struct_declaration
      { rcons $2 $1 }
  | struct_declaration_list ANTI_SDECLS
      { rcons (AntiSdecls (getANTI_SDECLS $2) (locOf $2)) $1 }

struct_declaration :: { FieldGroup }
struct_declaration :
    ANTI_SPEC struct_declarator_list ';'
      { let dspec = AntiDeclSpec (getANTI_SPEC $1) (locOf $1)
        in
          FieldGroup dspec (rev $2) ($1 <--> $3)
      }
  | specifier_qualifier_list struct_declarator_list ';'
      {%  do{ dspec <- mkDeclSpec $1
            ; return $ FieldGroup dspec (rev $2) ($1 <--> $3)
            }
      }
  | ANTI_TYPE identifier_or_typedef ';'
      {%  do{ let v     = getANTI_TYPE $1
            ; let dspec = AntiTypeDeclSpec [] [] v (locOf $1)
            ; let decl  = AntiTypeDecl v (locOf $1)
            ; let field = Field (Just $2) (Just decl) Nothing ($1 <--> $2)
            ; return $ FieldGroup dspec [field] ($1 <--> $3)
            }
      }
  | ANTI_SDECL
      { AntiSdecl (getANTI_SDECL $1) (locOf $1) }

specifier_qualifier_list :: { [TySpec] }
specifier_qualifier_list :
    type_specifier specifier_qualifier_list_
      { $1 : $2 }
  | type_qualifier_list type_specifier specifier_qualifier_list_
      { rev $1 ++ [$2] ++ $3 }
  | typedef_name
      { [$1] }
  | typedef_name type_qualifier_list
      { $1 : rev $2 }
  | type_qualifier_list typedef_name
      { rev $1 ++ [$2] }
  | type_qualifier_list typedef_name type_qualifier_list
      { rev $1 ++ [$2] ++ rev $3 }

specifier_qualifier_list_ :: { [TySpec] }
specifier_qualifier_list_ :
    {- empty -} %prec NAMED                  { [] }
  | type_specifier %prec NAMED               { [$1] }
  | type_specifier specifier_qualifier_list  { $1 : $2 }
  | type_qualifier %prec NAMED               { [$1] }
  | type_qualifier specifier_qualifier_list  { $1 : $2 }

struct_declarator_list :: { RevList Field }
struct_declarator_list :
    struct_declarator                            { rsingleton $1 }
  | struct_declarator_list ',' struct_declarator { rcons $3 $1 }

struct_declarator :: { Field }
struct_declarator :
    declarator
        { let { (ident, declToDecl) = $1
              ; decl                = declToDecl (declRoot ident)
              }
          in
            Field (Just ident) (Just decl) Nothing (locOf decl)
        }
  | declarator attributes
        { let { (ident, declToDecl) = $1
              ; decl                = declToDecl (declRoot ident)
              }
          in
            Field (Just ident) (Just decl) Nothing (locOf decl)
        }
  | ':' constant_expression
        { Field Nothing Nothing (Just $2) ($1 <--> $2) }
  | declarator ':' constant_expression
        { let { (ident, declToDecl) = $1
              ; decl                = declToDecl (declRoot ident)
              }
          in
            Field (Just ident) (Just decl) (Just $3) (locOf decl)
        }

enum_specifier :: { TySpec }
enum_specifier :
    'enum' identifier_or_typedef
      { TSenum (Just $2) [] [] ($1 <--> $2) }
  | 'enum' attributes identifier_or_typedef
      { TSenum (Just $3) [] $2 ($1 <--> $3) }
  | 'enum' '{' enumerator_list '}'
      { TSenum Nothing (rev $3) [] ($1 <--> $4) }
  | 'enum' identifier_or_typedef '{' enumerator_list '}'
      { TSenum (Just $2) (rev $4) [] ($1 <--> $5)}

enumerator_list :: { RevList CEnum }
enumerator_list :
    enumerator
      { rsingleton $1 }
  | ANTI_ENUMS
      { rsingleton (AntiEnums (getANTI_ENUMS $1) (locOf $1)) }
  | enumerator_list ','
      { $1 }
  | enumerator_list ',' enumerator
      { rcons $3 $1 }
  | enumerator_list ',' ANTI_ENUMS
      { rcons (AntiEnums (getANTI_ENUMS $3) (locOf $3)) $1 }

enumerator :: { CEnum }
enumerator:
    identifier
      { CEnum $1 Nothing (locOf $1)}
  | identifier '=' constant_expression
      { CEnum $1 (Just $3) ($1 <--> $3) }
  | ANTI_ENUM
      { AntiEnum (getANTI_ENUM $1) (locOf $1) }

type_qualifier :: { TySpec }
type_qualifier :
    'const'    { TSconst (locOf $1) }
  | 'inline'   { TSinline (locOf $1) }
  | 'restrict' { TSrestrict (locOf $1) }
  | 'volatile' { TSvolatile (locOf $1) }

  {- Extension: CUDA -}
  | '__device__'   { TSdevice (locOf $1) }
  | '__global__'   { TSglobal (locOf $1) }
  | '__host__'     { TShost (locOf $1) }
  | '__constant__' { TSconstant (locOf $1) }
  | '__shared__'   { TSshared (locOf $1) }
  | '__noinline__' { TSnoinline (locOf $1) }

  {- Extension: OpenCL -}
  | 'private'      { TSCLPrivate (locOf $1) }
  | '__private'    { TSCLPrivate (locOf $1) }
  | 'local'        { TSCLLocal (locOf $1) }
  | '__local'      { TSCLLocal (locOf $1) }
  | 'global'       { TSCLGlobal (locOf $1) }
  | '__global'     { TSCLGlobal (locOf $1) }
  | 'constant'     { TSCLConstant (locOf $1) }
  | '__constant'   { TSCLConstant (locOf $1) }
  | 'read_only'    { TSCLReadOnly (locOf $1) }
  | '__read_only'  { TSCLReadOnly (locOf $1) }
  | 'write_only'   { TSCLWriteOnly (locOf $1) }
  | '__write_only' { TSCLWriteOnly (locOf $1) }
  | 'kernel'       { TSCLKernel (locOf $1) }
  | '__kernel'     { TSCLKernel (locOf $1) }

-- Consider the following C program:
--
-- typedef struct foo {
--     int a;
-- } foo;
--
-- void f(foo* (foo));
--
-- In the grammar in the C99 standard, a parameter declaration can result from
-- either a declarator or an abstract declarator. This produces an ambiguity
-- when a typedef name appears after '(' because we can't tell whether or not it
-- is an item in a parmeter list for a function that is part of an abstract
-- declarator, or if is just a parenthesized (standard) declarator. This
-- ambiguity exists in the definition of f in the above program.
--
-- To solve this ambiguity, we split the the declarator rule to handle the
-- identifier and typedef name cases separately, and, furthermore, copy the
-- typedef name declarator rule and remove the cases that leads to ambiguity
-- when a declarator is used in a parameter list declaration.

identifier_declarator :: { (Id, Decl -> Decl) }
identifier_declarator :
    identifier_direct_declarator
      { $1 }
  | pointer identifier_direct_declarator
      { let (ident, dirDecl) = $2
        in
          (ident, dirDecl . $1)
      }

identifier_direct_declarator :: { (Id, Decl -> Decl) }
identifier_direct_declarator :
    identifier
      { ($1, id) }
  | '(' identifier_declarator ')'
      { $2 }
  | '(' identifier_declarator error
      {%do  {  let (ident, declToDecl) = $2
            ;  let decl                = declToDecl (declRoot ident)
            ;  unclosed ($1 <--> decl) "("
            }
      }
  | identifier_direct_declarator array_declarator
      { let (ident, declToDecl) = $1
        in
           (ident, declToDecl . $2)
      }
  | identifier_direct_declarator '(' ')'
      { let { (ident, declToDecl) = $1
            ; proto = mkOldProto []
            }
        in
          (ident, declToDecl . proto)
      }
  | identifier_direct_declarator '(' parameter_type_list ')'
      { let { (ident, declToDecl) = $1
            ; proto = mkProto $3
            }
        in
          (ident, declToDecl . proto)
      }
  | identifier_direct_declarator '(' identifier_list ')'
      { let { (ident, declToDecl) = $1
            ; proto = mkOldProto (rev $3)
            }
        in
          (ident, declToDecl . proto)
      }

typedef_declarator :: { (Id, Decl -> Decl) }
typedef_declarator :
    typedef_direct_declarator
      { $1 }
  | pointer typedef_direct_declarator
      { let (ident, dirDecl) = $2
        in
          (ident, dirDecl . $1)
      }

typedef_direct_declarator :: { (Id, Decl -> Decl) }
typedef_direct_declarator :
    NAMED
      { (Id (getNAMED $1) (locOf $1), id) }
  | '(' typedef_declarator ')'
      { $2 }
  | '(' typedef_declarator error
      {%do  {  let (ident, declToDecl) = $2
            ;  let decl                = declToDecl (declRoot ident)
            ;  unclosed ($1 <--> decl) "("
            }
      }
  | typedef_direct_declarator array_declarator
      { let (ident, declToDecl) = $1
        in
           (ident, declToDecl . $2)
      }
  | typedef_direct_declarator '(' ')'
      { let { (ident, declToDecl) = $1
            ; proto = mkOldProto []
            }
        in
          (ident, declToDecl . proto)
      }
  | typedef_direct_declarator '(' parameter_type_list ')'
      { let { (ident, declToDecl) = $1
            ; proto = mkProto $3
            }
        in
          (ident, declToDecl . proto)
      }
  | typedef_direct_declarator '(' identifier_list ')'
      { let { (ident, declToDecl) = $1
            ; proto = mkOldProto (rev $3)
            }
        in
          (ident, declToDecl . proto)
      }

declarator :: { (Id, Decl -> Decl) }
declarator :
    identifier_declarator
      { $1 }
  | typedef_declarator
      { $1 }

parameter_typedef_declarator :: { (Id, Decl -> Decl) }
parameter_typedef_declarator :
    parameter_typedef_direct_declarator
      { $1 }
  | pointer parameter_typedef_direct_declarator
      { let (ident, dirDecl) = $2
        in
          (ident, dirDecl . $1)
      }

parameter_typedef_direct_declarator :: { (Id, Decl -> Decl) }
parameter_typedef_direct_declarator :
    NAMED
      { (Id (getNAMED $1) (locOf $1), id) }
  | '(' pointer parameter_typedef_direct_declarator ')'
      { let (ident, dirDecl) = $3
        in
          (ident, dirDecl . $2)
      }
  | parameter_typedef_direct_declarator array_declarator
      { let (ident, declToDecl) = $1
        in
           (ident, declToDecl . $2)
      }
  | parameter_typedef_direct_declarator '(' ')'
      { let { (ident, declToDecl) = $1
            ; proto = mkOldProto []
            }
        in
          (ident, declToDecl . proto)
      }
  | parameter_typedef_direct_declarator '(' parameter_type_list ')'
      { let { (ident, declToDecl) = $1
            ; proto = mkProto $3
            }
        in
          (ident, declToDecl . proto)
      }
  | parameter_typedef_direct_declarator '(' identifier_list ')'
      { let { (ident, declToDecl) = $1
            ; proto = mkOldProto (rev $3)
            }
        in
          (ident, declToDecl . proto)
      }

parameter_declarator :: { (Id, Decl -> Decl) }
parameter_declarator :
    identifier_declarator
      { $1 }
  | parameter_typedef_declarator
      { $1 }

array_declarator :: { Decl -> Decl }
array_declarator :
    '[' ']'
      { mkArray [] (NoArraySize ($1 <--> $2)) }
  | '[' error
      {% unclosed (getLoc $1) "[" }
  | '[' type_qualifier_list ']'
      { mkArray (rev $2) (NoArraySize ($1 <--> $3)) }
  | '[' assignment_expression ']'
      { mkArray [] (ArraySize False $2 (locOf $2)) }
  | '[' type_qualifier_list assignment_expression ']'
      { mkArray (rev $2) (ArraySize False $3 (locOf $3)) }
  | '[' 'static' assignment_expression ']'
      { mkArray [] (ArraySize True $3 (locOf $3)) }
  | '[' 'static' type_qualifier_list assignment_expression ']'
      { mkArray (rev $3) (ArraySize True $4 (locOf $4)) }
  | '[' type_qualifier_list 'static' assignment_expression ']'
      { mkArray (rev $2) (ArraySize True $4 (locOf $4)) }
  | '[' '*' ']'
      { mkArray [] (VariableArraySize ($1 <--> $3)) }
  | '[' type_qualifier_list  '*' ']'
      { mkArray (rev $2) (VariableArraySize ($1 <--> $4)) }

pointer :: { Decl -> Decl }
pointer :
    '*'                              { mkPtr [] }
  | '*' type_qualifier_list          { mkPtr (rev $2) }
  | '*' pointer                      { $2 . mkPtr [] }
  | '*' type_qualifier_list pointer  { $3 . mkPtr (rev $2) }

type_qualifier_list :: { RevList TySpec }
type_qualifier_list :
    type_qualifier                     { rsingleton $1 }
  | type_qualifier_list type_qualifier { rcons $2 $1 }

parameter_type_list :: { Params }
parameter_type_list :
    parameter_list
      { let params = rev $1
        in
          Params params False (locOf params)
      }
  | parameter_list ',' '...'
      { let params = rev $1
        in
          Params params True (params <--> $3)
      }

parameter_list :: { RevList Param }
parameter_list:
    parameter_declaration
      { rsingleton $1 }
  | ANTI_PARAMS
      { rsingleton (AntiParams (getANTI_PARAMS $1) (locOf $1)) }
  | parameter_list ',' parameter_declaration
      { rcons $3 $1 }
  | parameter_list ',' ANTI_PARAMS
      { rcons (AntiParams (getANTI_PARAMS $3) (locOf $3))  $1 }

parameter_declaration :: { Param }
parameter_declaration:
    declaration_specifiers
      { let (dspec, decl) = $1
        in
          Param Nothing dspec decl (dspec <--> decl)
      }
  | declaration_specifiers parameter_declarator
      { let  {  (dspec, declRoot)   = $1
             ;  (ident, declToDecl) = $2
             ;  decl                = declToDecl declRoot
             }
        in
          Param (Just ident) dspec decl (ident <--> decl)
      }
  | declaration_specifiers abstract_declarator
      { let  {  (dspec, declRoot)  = $1
             ;  decl                  = $2 declRoot
             }
        in
          Param Nothing dspec decl (dspec <--> decl)
      }
  | ANTI_PARAM
      { AntiParam (getANTI_PARAM $1) (locOf $1) }

-- The type_declaration rule is the parameter_declaration rule without the
-- ANTI_PARAM option. This allows us to parse type declarations easily for later
-- antiquoting.

type_declaration :: { Type }
type_declaration:
    declaration_specifiers
      { let (dspec, decl) = $1
        in
          Type dspec decl (dspec <--> decl)
      }
  | declaration_specifiers parameter_declarator
      { let  {  (dspec, declRoot)   = $1
             ;  (ident, declToDecl) = $2
             ;  decl                = declToDecl declRoot
             }
        in
          Type dspec decl (dspec <--> decl)
      }
  | declaration_specifiers abstract_declarator
      { let  {  (dspec, declRoot)  = $1
             ;  decl                  = $2 declRoot
             }
        in
          Type dspec decl (dspec <--> decl)
      }

identifier_list :: { RevList Id }
identifier_list :
    identifier                      { rsingleton $1 }
  | identifier_list ',' identifier  { rcons $3 $1 }

type_name :: { Type }
type_name :
    ANTI_SPEC
      { let dspec = AntiDeclSpec (getANTI_SPEC $1) (locOf $1)
        in
          Type dspec (declRoot $1) (locOf $1)
      }
  | specifier_qualifier_list
      {% do{ dspec <- mkDeclSpec $1
           ; return $ Type dspec (declRoot $1) (locOf $1)
           }
      }
  | ANTI_SPEC abstract_declarator
      { let { dspec = AntiDeclSpec (getANTI_SPEC $1) (locOf $1)
            ; decl = $2 (declRoot $1)
            }
        in
          Type dspec decl (dspec <--> decl)
      }
  | specifier_qualifier_list abstract_declarator
      {% do{ let decl = $2 (declRoot $1)
           ; dspec <- mkDeclSpec $1
           ; return $ Type dspec decl (dspec <--> decl)
           }
      }
  | ANTI_TYPE
      { AntiType (getANTI_TYPE $1) (locOf $1) }
  | ANTI_TYPE abstract_declarator
      { let  {  v     = getANTI_TYPE $1
             ;  decl  = $2 (AntiTypeDecl v (locOf $1))
             }
        in
          Type (AntiTypeDeclSpec [] [] v (locOf $1)) decl ($1 <--> decl)
      }

abstract_declarator :: { Decl -> Decl }
abstract_declarator :
    pointer                             { $1 }
  | direct_abstract_declarator          { $1 }
  | pointer direct_abstract_declarator  { $2 . $1 }

direct_abstract_declarator :: { Decl -> Decl }
direct_abstract_declarator :
    '(' abstract_declarator ')'
      { $2 }
  | '(' abstract_declarator error
      {% do{ let decl = $2 (declRoot $1)
           ; unclosed ($1 <--> decl) "("
           }
      }
  | array_declarator
      { $1 }
  | direct_abstract_declarator array_declarator
      { $1 . $2 }
  | '(' ')'
      { mkOldProto [] }
  | '(' parameter_type_list ')'
      { mkProto $2 }
  | direct_abstract_declarator '(' ')'
      { $1 . mkOldProto [] }
  | direct_abstract_declarator '(' parameter_type_list ')'
      { $1 . mkProto $3 }

typedef_name :: { TySpec }
typedef_name :
    NAMED
      { TSnamed (Id (getNAMED $1) (locOf $1)) (locOf $1) }
  | 'typename' identifier
      { TSnamed $2 ($1 <--> $2) }
  | 'typename' error
      {% expected (locOf $1) ["identifier"] }
  | '__typeof__' '(' unary_expression ')'
      { TStypeofExp $3 ($1 <--> $4) }
  | '__typeof__' '(' type_name ')'
      { TStypeofType $3 ($1 <--> $4) }
  | '__typeof__' '(' type_name error
      {% unclosed ($2 <--> $3) "(" }

initializer :: { Initializer }
initializer :
    assignment_expression
      { ExpInitializer $1 (locOf $1) }
  | '{' initializer_list '}'
      { CompoundInitializer (rev $2) ($1 <--> $3) }
  | '{' initializer_list error
      {% do{  let (_, inits) = unzip (rev $2)
           ;  unclosed ($1 <--> inits) "{"
           }
      }
  | '{' initializer_list ',' '}'
      { CompoundInitializer (rev $2) ($1 <--> $4) }
  | '{' initializer_list ',' error
      {% unclosed ($1 <--> $3) "{" }

initializer_list :: { RevList (Maybe Designation, Initializer) }
initializer_list :
    initializer
      { rsingleton (Nothing, $1) }
  | designation initializer
      { rsingleton (Just $1, $2) }
  | initializer_list ',' initializer
      { rcons (Nothing, $3) $1 }
  | initializer_list ',' designation initializer
      { rcons (Just $3, $4) $1 }

designation :: { Designation }
designation :
    designator_list '='
      { let designators = rev $1
        in
          Designation designators (designators <--> $2)
      }

designator_list :: { RevList Designator }
designator_list :
    designator                 { rsingleton $1 }
  | designator_list designator { rcons $2 $1 }

designator :: { Designator }
designator :
    '[' constant_expression ']'
      { IndexDesignator $2 ($1 <--> $3) }
  | '.' identifier
      { MemberDesignator $2 ($1 <--> $2) }

{------------------------------------------------------------------------------
 -
 - Statements
 -
 ------------------------------------------------------------------------------}

statement :: { Stm }
statement :
    labeled_statement    { $1 }
  | compound_statement   { $1 }
  | expression_statement { $1 }
  | selection_statement  { $1 }
  | iteration_statement  { $1 }
  | jump_statement       { $1 }
  | asm_statement        { $1 }
  | ANTI_STM             { AntiStm (getANTI_STM $1) (locOf $1) }

labeled_statement :: { Stm }
labeled_statement :
    identifier ':' statement                  { Label $1 $3 ($1 <--> $3) }
  | 'case' constant_expression ':' statement  { Case $2 $4 ($1 <--> $4) }
  | 'default' ':' statement                   { Default $3 ($1 <--> $3) }

compound_statement :: { Stm }
compound_statement:
    '{' begin_scope end_scope '}'
      { Block [] ($1 <--> $4) }
  | '{' begin_scope error
      {% unclosed (locOf $3) "{" }
  | '{' begin_scope block_item_list end_scope '}'
      { Block (rev $3) ($1 <--> $5) }

block_item_list :: { RevList BlockItem }
block_item_list :
     block_item                 { rsingleton $1 }
  |  block_item_list block_item { rcons $2 $1 }

block_item  :: { BlockItem }
block_item :
     declaration { BlockDecl $1 }
  |  statement   { BlockStm $1 }
  |  ANTI_DECLS  { BlockDecl (AntiDecls (getANTI_DECLS $1) (locOf $1)) }
  |  ANTI_STMS   { BlockStm (AntiStms (getANTI_STMS $1) (locOf $1)) }
  |  ANTI_ITEM   { AntiBlockItem (getANTI_ITEM $1) (locOf $1) }
  |  ANTI_ITEMS  { AntiBlockItems (getANTI_ITEMS $1)  (locOf $1) }

begin_scope :: { () }
begin_scope : {% pushScope }

end_scope :: { () }
end_scope : {% popScope }

declaration_list :: { RevList InitGroup }
declaration_list :
    declaration
      { rsingleton $1 }
  | ANTI_DECLS
      { rsingleton (AntiDecls (getANTI_DECLS $1) (locOf $1)) }
  | declaration_list declaration
      { rcons $2 $1 }
  | declaration_list ANTI_DECLS
      { rcons (AntiDecls (getANTI_DECLS $2) (locOf $2)) $1 }

expression_statement :: { Stm }
expression_statement:
    ';'               { Exp Nothing (locOf $1) }
  | expression ';'    { Exp (Just $1) ($1 <--> $2) }
  | expression error  {% expected (locOf $1) ["';'"] }

selection_statement :: { Stm }
selection_statement :
    'if' '(' expression ')' statement
      { If $3 $5 Nothing ($1 <--> $5) }
  | 'if' '(' expression ')' statement 'else' statement
      { If $3 $5 (Just $7) ($1 <--> $7) }
  | 'if' '(' expression error
      {% unclosed ($2 <--> $3) "(" }
  | 'switch' '(' expression ')' statement
      { Switch $3 $5 ($1 <--> $5) }
  | 'switch' '(' expression error
      {% unclosed ($2 <--> $3) "(" }

iteration_statement :: { Stm }
iteration_statement :
    'while' '(' expression ')' statement
      { While $3 $5 ($1 <--> $5) }
  | 'while' '(' expression error
      {% unclosed ($2 <--> $3) "(" }
  | 'do' statement 'while' '(' expression ')' ';'
      { DoWhile $2 $5 ($1 <--> $7) }
  | 'do' statement 'while' '(' expression error
      {% unclosed ($4 <--> $5) "(" }
  | 'for' '(' error
      {% expected (locOf $2) ["expression", "declaration"] }
  | 'for' '(' declaration maybe_expression ';' ')' statement
      { For (Left $3) $4 Nothing $7 ($1 <--> $7) }
  | 'for' '(' maybe_expression ';' maybe_expression ';' ')' statement
      { For (Right $3) $5 Nothing $8 ($1 <--> $8) }
  | 'for' '(' maybe_expression ';' maybe_expression ';' error
      {% unclosed ($2 <--> $6) "(" }
  | 'for' '(' declaration maybe_expression ';' expression ')' statement
      { For (Left $3) $4 (Just $6) $8 ($1 <--> $8) }
  | 'for' '(' maybe_expression ';' maybe_expression ';' expression ')' statement
      { For (Right $3) $5 (Just $7) $9 ($1 <--> $9) }
  | 'for' '(' maybe_expression ';' maybe_expression ';' expression error
      {% unclosed ($2 <--> $7) "(" }

jump_statement :: { Stm }
jump_statement :
    'goto' identifier ';'      { Goto $2 ($1 <--> $3) }
  | 'goto' error               {% expected (locOf $1) ["identifier"] }
  | 'goto' identifier error    {% expected (locOf $2) ["';'"] }
  | 'continue' ';'             { Continue ($1 <--> $2) }
  | 'continue' error           {% expected (locOf $1) ["';'"] }
  | 'break' ';'                { Break ($1 <--> $2) }
  | 'break' error              {% expected (locOf $1) ["';'"] }
  | 'return' ';'               { Return Nothing ($1 <--> $2) }
  | 'return' error             {% expected (locOf $1) ["';'"] }
  | 'return' expression ';'    { Return (Just $2) ($1 <--> $3) }
  | 'return' expression error  {% expected (locOf $2) ["';'"] }

{------------------------------------------------------------------------------
 -
 - External definitions
 -
 ------------------------------------------------------------------------------}

translation_unit :: { [Definition] }
translation_unit :
    {- empty -}
      { [] }
  | translation_unit_ { rev $1 }

translation_unit_ :: { RevList Definition }
translation_unit_ :
    external_declaration
      { rsingleton $1 }
  | ANTI_EDECLS
      { rsingleton (AntiEdecls (getANTI_EDECLS $1) (locOf $1)) }
  | translation_unit_ external_declaration
      { rcons $2 $1 }
  | translation_unit_ ANTI_EDECLS
      { rcons (AntiEdecls (getANTI_EDECLS $2) (locOf $2)) $1 }

external_declaration :: { Definition }
external_declaration :
    function_definition
      { FuncDef $1 (locOf $1) }
  | declaration
      { DecDef $1 (locOf $1) }
  | ANTI_FUNC
      { AntiFunc (getANTI_FUNC $1) (locOf $1) }
  | ANTI_ESC
      { AntiEsc (getANTI_ESC $1) (locOf $1) }
  | ANTI_EDECL
      { AntiEdecl (getANTI_EDECL $1) (locOf $1) }

function_definition :: { Func }
function_definition :
    declaration_specifiers declarator compound_statement
      {% do{ let (dspec, declRoot)   =  $1
           ; let (ident, declToDecl) =  $2
           ; let Block blockItems _  =  $3
           ; let decl                =  declToDecl declRoot
           ; case decl of
               { Proto protoDecl args _ -> return $
                     Func dspec ident protoDecl args
                          blockItems
                          (decl <--> blockItems)
               ; OldProto protoDecl args _ -> return $
                     OldFunc dspec ident protoDecl args Nothing
                             blockItems
                             (decl <--> blockItems)
               ; _ -> failAt (decl <--> blockItems :: Loc)
                             "bad function declaration"
               }
           }
      }
  | declaration_specifiers declarator declaration_list compound_statement
      {% do{ let (dspec, declRoot)   =  $1
           ; let (ident, declToDecl) =  $2
           ; let argDecls            =  $3
           ; let Block blockItems _  =  $4
           ; let decl                =  declToDecl declRoot
           ; case decl of
               { OldProto protoDecl args _ -> return $
                     OldFunc dspec ident protoDecl args (Just (rev argDecls))
                             blockItems
                             (decl <--> blockItems)
               ; _ -> failAt (decl <--> blockItems :: Loc)
                             "bad function declaration"
               }
           }
      }

{------------------------------------------------------------------------------
 -
 - GCC extensions
 -
 ------------------------------------------------------------------------------}

attributes :: { [Attr] }
attributes :
    attribute            { $1 }
  | attributes attribute { $1 ++ $2 }

attribute :: { [Attr] }
attribute :
    '__attribute__' '(' '(' attribute_list ')' ')' { rev $4 }

attribute_list :: { RevList Attr }
attribute_list :
    attrib                    { rsingleton $1 }
  | attribute_list ',' attrib { rcons $3 $1 }

attrib :: { Attr }
attrib :
    attrib_name
      { Attr $1 [] (locOf $1)}
  | attrib_name '(' argument_expression_list ')'
      { Attr $1 (rev $3) ($1 <--> $4) }

attrib_name :: { Id }
attrib_name :
    identifier_or_typedef { $1 }
  | 'static'              { Id "static" (locOf $1) }
  | 'extern'              { Id "extern" (locOf $1) }
  | 'register'            { Id "register" (locOf $1) }
  | 'typedef'             { Id "typedef" (locOf $1) }
  | 'inline'              { Id "inline" (locOf $1) }
  | 'auto'                { Id "auto" (locOf $1) }
  | 'const'               { Id "const" (locOf $1) }
  | 'volatile'            { Id "volatile" (locOf $1) }
  | 'unsigned'            { Id "unsigned" (locOf $1) }
  | 'long'                { Id "long" (locOf $1) }
  | 'short'               { Id "short" (locOf $1) }
  | 'signed'              { Id "signed" (locOf $1) }
  | 'int'                 { Id "int" (locOf $1) }
  | 'char'                { Id "char" (locOf $1) }
  | 'float'               { Id "float" (locOf $1) }
  | 'double'              { Id "double" (locOf $1) }
  | 'void'                { Id "void" (locOf $1) }

maybe_volatile :: { Bool }
maybe_volatile :
     {- empty -} { False}
  |  'volatile'  { True}

asm_statement :: { Stm }
asm_statement :
    '__asm__' maybe_volatile '(' asm_template ')' ';'
      { Asm $2 [] (rev $4) [] [] [] ($1 <--> $5) }
  | '__asm__' maybe_volatile '(' asm_template ':' asm_inouts ')' ';'
      { Asm $2 [] (rev $4) $6 [] [] ($1 <--> $7) }
  | '__asm__' maybe_volatile '(' asm_template ':' asm_inouts
                                              ':' asm_inouts ')' ';'
      { Asm $2 [] (rev $4) $6 $8 [] ($1 <--> $9) }
  | '__asm__' maybe_volatile '(' asm_template ':' asm_inouts
                                              ':' asm_inouts
                                              ':' asm_clobbers ')' ';'
      { Asm $2 [] (rev $4) $6 $8 $10 ($1 <--> $11) }

asm_template :: { RevList String }
asm_template :
    STRING               { rsingleton ((fst . getSTRING) $1) }
  | asm_template STRING  { rcons ((fst . getSTRING) $2) $1 }

asm_inouts :: { [(String, Exp)] }
asm_inouts :
    {- empty -}    { [] }
  | asm_inouts_ne  { rev $1 }

asm_inouts_ne :: { RevList (String, Exp) }
asm_inouts_ne:
    asm_inout                    { rsingleton $1 }
  | asm_inouts_ne ',' asm_inout  { rcons $3 $1 }

asm_inout :: { (String, Exp) }
asm_inout :
    STRING '(' expression ')' { ((fst . getSTRING) $1, $3) }

asm_clobbers :: { [String] }
asm_clobbers :
    {- empty -}      { [] }
  | asm_clobbers_ne  { rev $1 }

asm_clobbers_ne :: { RevList String }
asm_clobbers_ne :
    asm_clobber                      { rsingleton $1 }
  | asm_clobbers_ne ',' asm_clobber  { rcons $3 $1 }

asm_clobber :: { String }
asm_clobber :
    STRING { (fst . getSTRING) $1 }

{
happyError :: L T.Token -> P a
happyError (L (Loc start _) _) =
    throw $ ParserException (Loc start start) (text "parse error")

getCHAR        (L _ (T.TcharConst x))        = x
getSTRING      (L _ (T.TstringConst x))      = x
getINT         (L _ (T.TintConst x))         = x
getLONG        (L _ (T.TlongIntConst x))     = x
getLONG_LONG   (L _ (T.TlongLongIntConst x)) = x
getFLOAT       (L _ (T.TfloatConst x))       = x
getDOUBLE      (L _ (T.TdoubleConst x))      = x
getLONG_DOUBLE (L _ (T.TlongDoubleConst x))  = x
getID          (L _ (T.Tidentifier id))      = id
getNAMED       (L _ (T.Tnamed id))           = id

getANTI_ID          (L _ (T.Tanti_id v))          = v
getANTI_INT         (L _ (T.Tanti_int v))         = v
getANTI_UINT        (L _ (T.Tanti_uint v))        = v
getANTI_LINT        (L _ (T.Tanti_lint v))        = v
getANTI_ULINT       (L _ (T.Tanti_ulint v))       = v
getANTI_FLOAT       (L _ (T.Tanti_float v))       = v
getANTI_DOUBLE      (L _ (T.Tanti_double v))      = v
getANTI_LONG_DOUBLE (L _ (T.Tanti_long_double v)) = v
getANTI_CHAR        (L _ (T.Tanti_char v))        = v
getANTI_STRING      (L _ (T.Tanti_string v))      = v
getANTI_EXP         (L _ (T.Tanti_exp v))         = v
getANTI_FUNC        (L _ (T.Tanti_func v))        = v
getANTI_ARGS        (L _ (T.Tanti_args v))        = v
getANTI_DECL        (L _ (T.Tanti_decl v))        = v
getANTI_DECLS       (L _ (T.Tanti_decls v))       = v
getANTI_SDECL       (L _ (T.Tanti_sdecl v))       = v
getANTI_SDECLS      (L _ (T.Tanti_sdecls v))      = v
getANTI_ENUM        (L _ (T.Tanti_enum v))        = v
getANTI_ENUMS       (L _ (T.Tanti_enums v))       = v
getANTI_ESC         (L _ (T.Tanti_esc v))         = v
getANTI_EDECL       (L _ (T.Tanti_edecl v))       = v
getANTI_EDECLS      (L _ (T.Tanti_edecls v))      = v
getANTI_ITEM        (L _ (T.Tanti_item v))         = v
getANTI_ITEMS       (L _ (T.Tanti_items v))        = v
getANTI_STM         (L _ (T.Tanti_stm v))         = v
getANTI_STMS        (L _ (T.Tanti_stms v))        = v
getANTI_TYPE        (L _ (T.Tanti_type v))        = v
getANTI_SPEC        (L _ (T.Tanti_spec v))        = v
getANTI_PARAM       (L _ (T.Tanti_param v))       = v
getANTI_PARAMS      (L _ (T.Tanti_params v))      = v

lexer :: (L T.Token -> P a) -> P a
lexer cont =
    lexToken >>= cont

locate :: Loc -> (SrcLoc -> a) -> L a
locate loc f = L loc (f (SrcLoc loc))

data DeclTySpec = DeclTySpec DeclSpec !SrcLoc
                | AntiDeclTySpec String !SrcLoc

data TySpec = TSauto !SrcLoc
            | TSregister !SrcLoc
            | TSstatic !SrcLoc
            | TSextern !SrcLoc
            | TSexternL String !SrcLoc
            | TStypedef !SrcLoc

            | TSconst !SrcLoc
            | TSvolatile !SrcLoc
            | TSinline !SrcLoc

            | TSsigned !SrcLoc
            | TSunsigned !SrcLoc

            | TSvoid !SrcLoc
            | TSchar !SrcLoc
            | TSshort !SrcLoc
            | TSint !SrcLoc
            | TSlong !SrcLoc
            | TSfloat !SrcLoc
            | TSdouble !SrcLoc

            | TSstruct (Maybe Id) (Maybe [FieldGroup]) [Attr] !SrcLoc
            | TSunion (Maybe Id) (Maybe [FieldGroup]) [Attr] !SrcLoc
            | TSenum (Maybe Id) [CEnum] [Attr] !SrcLoc
            | TSnamed Id !SrcLoc

            | TStypeofExp Exp !SrcLoc
            | TStypeofType Type !SrcLoc
            | TSva_list !SrcLoc

            -- C99
            | TSrestrict !SrcLoc

            -- CUDA
            | TSdevice !SrcLoc
            | TSglobal !SrcLoc
            | TShost !SrcLoc
            | TSconstant !SrcLoc
            | TSshared !SrcLoc
            | TSnoinline !SrcLoc

            -- OpenCL
            | TSCLPrivate !SrcLoc
            | TSCLLocal !SrcLoc
            | TSCLGlobal !SrcLoc
            | TSCLConstant !SrcLoc
            | TSCLReadOnly !SrcLoc
            | TSCLWriteOnly !SrcLoc
            | TSCLKernel !SrcLoc

instance Located DeclTySpec where
    getLoc (DeclTySpec _ loc)      = getLoc loc
    getLoc (AntiDeclTySpec _ loc)  = getLoc loc

instance Located TySpec where
    getLoc (TSauto loc)          = getLoc loc
    getLoc (TSregister loc)      = getLoc loc
    getLoc (TSstatic loc)        = getLoc loc
    getLoc (TSextern loc)        = getLoc loc
    getLoc (TSexternL _ loc)     = getLoc loc
    getLoc (TStypedef loc)       = getLoc loc

    getLoc (TSconst loc)         = getLoc loc
    getLoc (TSvolatile loc)      = getLoc loc
    getLoc (TSinline loc)        = getLoc loc

    getLoc (TSsigned loc)        = getLoc loc
    getLoc (TSunsigned loc)      = getLoc loc

    getLoc (TSvoid loc)          = getLoc loc
    getLoc (TSchar loc)          = getLoc loc
    getLoc (TSshort loc)         = getLoc loc
    getLoc (TSint loc)           = getLoc loc
    getLoc (TSlong loc)          = getLoc loc
    getLoc (TSfloat loc)         = getLoc loc
    getLoc (TSdouble loc)        = getLoc loc

    getLoc (TSstruct _ _ _ loc)  = getLoc loc
    getLoc (TSunion _ _ _ loc)   = getLoc loc
    getLoc (TSenum _ _ _ loc)    = getLoc loc
    getLoc (TSnamed _ loc)       = getLoc loc

    getLoc (TStypeofExp _ loc)   = getLoc loc
    getLoc (TStypeofType _ loc)  = getLoc loc
    getLoc (TSva_list loc)       = getLoc loc

    getLoc (TSrestrict loc)      = getLoc loc

    getLoc (TSdevice loc)        = getLoc loc
    getLoc (TSglobal loc)        = getLoc loc
    getLoc (TShost loc)          = getLoc loc
    getLoc (TSconstant loc)      = getLoc loc
    getLoc (TSshared loc)        = getLoc loc
    getLoc (TSnoinline loc)      = getLoc loc

    getLoc (TSCLPrivate loc)     = getLoc loc
    getLoc (TSCLLocal loc)       = getLoc loc
    getLoc (TSCLGlobal loc)      = getLoc loc
    getLoc (TSCLConstant loc)    = getLoc loc
    getLoc (TSCLReadOnly loc)    = getLoc loc
    getLoc (TSCLWriteOnly loc)   = getLoc loc
    getLoc (TSCLKernel loc)      = getLoc loc

instance Pretty TySpec where
    ppr (TSauto _)       = text "auto"
    ppr (TSregister _)   = text "register"
    ppr (TSstatic _)     = text "static"
    ppr (TSextern _)     = text "extern"
    ppr (TSexternL l _)  = text "extern" <+> ppr l
    ppr (TStypedef _)    = text "typedef"

    ppr (TSconst _)    = text "const"
    ppr (TSinline _)   = text "inline"
    ppr (TSrestrict _) = text "restrict"
    ppr (TSvolatile _) = text "volatile"

    ppr (TSsigned _)   = text "signed"
    ppr (TSunsigned _) = text "unsigned"

    ppr (TSvoid _)     = text "void"
    ppr (TSchar _)     = text "char"
    ppr (TSshort _)    = text "short"
    ppr (TSint _)      = text "int"
    ppr (TSlong _)     = text "long"
    ppr (TSfloat _)    = text "float"
    ppr (TSdouble _)   = text "double"

    ppr (TSstruct maybe_id maybe_fields attrs _) =
        pprStructOrUnion "struct" maybe_id maybe_fields attrs

    ppr (TSunion maybe_id maybe_fields attrs _) =
        pprStructOrUnion "union" maybe_id maybe_fields attrs

    ppr (TSenum maybe_id cenums attrs _) =
        pprEnum maybe_id cenums attrs

    ppr (TStypeofExp e _)   = text "__typeof__" <> parens (ppr e)
    ppr (TStypeofType ty _) = text "__typeof__" <> parens (ppr ty)
    ppr (TSnamed ident _)   = ppr ident

    ppr (TSva_list _)   = text "__builtin_va_list"

    ppr (TSdevice _)    = text "__device__"
    ppr (TSglobal _)    = text "__global__"
    ppr (TShost _)      = text "__host__"
    ppr (TSconstant _)  = text "__constant__"
    ppr (TSshared _)    = text "__shared__"
    ppr (TSnoinline _)  = text "__noinline__"

    ppr (TSCLPrivate _)     = text "private"
    ppr (TSCLLocal _)       = text "local"
    ppr (TSCLGlobal _)      = text "global"
    ppr (TSCLConstant _)    = text "constant"
    ppr (TSCLReadOnly _)    = text "read_only"
    ppr (TSCLWriteOnly _)   = text "write_only"
    ppr (TSCLKernel _)      = text "kernel"
    
isStorage :: TySpec -> Bool
isStorage (TSauto _)      = True
isStorage (TSregister _)  = True
isStorage (TSstatic _)    = True
isStorage (TSextern _)    = True
isStorage (TSexternL _ _) = True
isStorage (TStypedef _)   = True
isStorage _               = False

mkStorage :: [TySpec] -> [Storage]
mkStorage specs = map mk (filter isStorage specs)
    where
      mk :: TySpec -> Storage
      mk (TSauto loc)      = Tauto loc
      mk (TSregister loc)  = Tregister loc
      mk (TSstatic loc)    = Tstatic loc
      mk (TSextern loc)    = Textern loc
      mk (TSexternL l loc) = TexternL l loc
      mk (TStypedef loc)   = Ttypedef loc
      mk _                 = error "internal error in mkStorage"

isTypeQual :: TySpec -> Bool
isTypeQual (TSconst _)       = True
isTypeQual (TSvolatile _)    = True
isTypeQual (TSinline _)      = True
isTypeQual (TSrestrict _)    = True
isTypeQual (TSdevice _)      = True
isTypeQual (TSglobal _)      = True
isTypeQual (TShost _)        = True
isTypeQual (TSconstant _)    = True
isTypeQual (TSshared _)      = True
isTypeQual (TSnoinline _)    = True
isTypeQual (TSCLPrivate _)   = True
isTypeQual (TSCLLocal _)     = True
isTypeQual (TSCLGlobal _)    = True
isTypeQual (TSCLConstant _)  = True
isTypeQual (TSCLReadOnly _)  = True
isTypeQual (TSCLWriteOnly _) = True
isTypeQual (TSCLKernel _)    = True
isTypeQual _                 = False

mkTypeQuals :: [TySpec] -> [TypeQual]
mkTypeQuals specs = map mk (filter isTypeQual specs)
    where
      mk :: TySpec -> TypeQual
      mk (TSconst loc)       = Tconst loc
      mk (TSvolatile loc)    = Tvolatile loc
      mk (TSinline loc)      = Tinline loc
      mk (TSrestrict loc)    = Trestrict loc
      mk (TSdevice loc)      = Tdevice loc
      mk (TSglobal loc)      = Tglobal loc
      mk (TShost loc)        = Thost loc
      mk (TSconstant loc)    = Tconstant loc
      mk (TSshared loc)      = Tshared loc
      mk (TSnoinline loc)    = Tnoinline loc
      mk (TSCLPrivate loc)   = TCLPrivate loc
      mk (TSCLLocal loc)     = TCLLocal loc
      mk (TSCLGlobal loc)    = TCLGlobal loc
      mk (TSCLConstant loc)  = TCLConstant loc
      mk (TSCLReadOnly loc)  = TCLReadOnly loc
      mk (TSCLWriteOnly loc) = TCLWriteOnly loc
      mk (TSCLKernel loc)    = TCLKernel loc
      mk _                   = error "internal error in mkTypeQual"

isSign :: TySpec -> Bool
isSign (TSsigned _)    = True
isSign (TSunsigned _)  = True
isSign _               = False

hasSign :: [TySpec] -> Bool
hasSign specs = any isSign specs

mkSign :: [TySpec] -> P (Maybe Sign)
mkSign specs =
    case filter isSign specs of
      [] ->                return Nothing
      [TSunsigned loc] ->  return (Just (Tunsigned loc))
      [TSsigned loc] ->    return (Just (Tsigned loc))
      [_] ->               fail "internal error in mkSign"
      _ ->                 fail "multiple signs specified"

checkNoSign :: [TySpec] -> String -> P ()
checkNoSign spec msg  | hasSign spec  = fail msg
                      | otherwise     = return ()

composeDecls :: Decl -> Decl -> Decl
composeDecls (DeclRoot _) root =
    root

composeDecls (C.Ptr quals decl loc) root =
    C.Ptr quals (composeDecls decl root) loc

composeDecls (Array quals size decl loc) root =
    Array quals size (composeDecls decl root) loc

composeDecls (Proto decl args loc) root =
    Proto (composeDecls decl root) args loc

composeDecls (OldProto decl args loc) root =
    OldProto (composeDecls decl root) args loc

mkDeclSpec :: [TySpec] -> P DeclSpec
mkDeclSpec specs =
    go rest
  where
    storage ::[Storage]
    storage = mkStorage specs

    quals :: [TypeQual]
    quals = mkTypeQuals specs

    rest :: [TySpec]
    rest = [x  |  x <- specs
               ,  not (isStorage x) && not (isTypeQual x) && not (isSign x)]

    go :: [TySpec] -> P DeclSpec
    go [TSvoid loc] = do
        checkNoSign specs "sign specified for void type"
        return $ cdeclSpec storage quals (Tvoid loc)

    go [TSchar loc] = do
        sign <- mkSign specs
        return $ cdeclSpec storage quals (Tchar sign loc)

    go [TSshort loc] = do
        sign <- mkSign specs
        return $ cdeclSpec storage quals (Tshort sign loc)

    go [TSshort _, TSint _] = do
        sign <- mkSign specs
        return $ cdeclSpec storage quals (Tshort sign (locOf rest))

    go [TSint _, TSshort _] = do
        sign <- mkSign specs
        return $ cdeclSpec storage quals (Tshort sign (locOf rest))

    go [TSint loc] = do
        sign <- mkSign specs
        return $ cdeclSpec storage quals (Tint sign loc)

    go [TSlong loc] = do
        sign <- mkSign specs
        return $ cdeclSpec storage quals (Tlong sign loc)

    go [TSlong _, TSint _] = do
        sign <- mkSign specs
        return $ cdeclSpec storage quals (Tlong sign (locOf rest))

    go [TSint _, TSlong _] = do
        sign <- mkSign specs
        return $ cdeclSpec storage quals (Tlong sign (locOf rest))

    go [TSlong _, TSlong _] = do
        sign <- mkSign specs
        return $ cdeclSpec storage quals (Tlong_long sign (locOf rest))

    go [TSlong _, TSlong _, TSint _] = do
        sign <- mkSign specs
        return $ cdeclSpec storage quals (Tlong_long sign (locOf rest))

    go [TSlong _, TSint _, TSlong _] = do
        sign <- mkSign specs
        return $ cdeclSpec storage quals (Tlong_long sign (locOf rest))

    go [TSint _, TSlong _, TSlong _] = do
        sign <- mkSign specs
        return $ cdeclSpec storage quals (Tlong_long sign (locOf rest))

    go [TSfloat loc] = do
        checkNoSign specs "sign specified for float type"
        return $ cdeclSpec storage quals (Tfloat loc)

    go [TSdouble loc] = do
        checkNoSign specs "sign specified for double type"
        return $ cdeclSpec storage quals (Tdouble loc)

    go [TSlong _, TSdouble _] = do
        checkNoSign specs "sign specified for long double type"
        return $ cdeclSpec storage quals (Tlong_double (locOf rest))

    go [TSdouble _, TSlong _] = do
        checkNoSign specs "sign specified for long double type"
        return $ cdeclSpec storage quals (Tlong_double (locOf rest))

    go [TSstruct ident fields attrs loc] = do
        checkNoSign specs "sign specified for struct type"
        return $ cdeclSpec storage quals (Tstruct ident fields attrs loc)

    go [TSunion ident fields attrs loc] = do
        checkNoSign specs "sign specified for union type"
        return $ cdeclSpec storage quals (Tunion ident fields attrs loc)

    go [TSenum ident enums attrs loc] = do
        checkNoSign specs "sign specified for enum type"
        return $ cdeclSpec storage quals (Tenum ident enums attrs loc)

    go [TSnamed ident loc] = do
        checkNoSign specs "sign specified for named type"
        return $ cdeclSpec storage quals (Tnamed ident loc)

    go [TStypeofExp e loc] = do
        checkNoSign specs "sign specified for typeof"
        return $ cdeclSpec storage quals (TtypeofExp e loc)

    go [TStypeofType ty loc] = do
        checkNoSign specs "sign specified for typeof"
        return $ cdeclSpec storage quals (TtypeofType ty loc)

    go [TSva_list loc] = do
        checkNoSign specs "sign specified for __builtin_va_list"
        return $ cdeclSpec storage quals (Tva_list loc)

    go [] = do
        sign <- mkSign specs
        return $ cdeclSpec storage quals (Tint sign (storage <--> quals))

    go tyspecs =
        throw $ ParserException loc
            (text "bad type:" <+> spread (map ppr tyspecs))
      where
        loc = getLoc tyspecs

mkPtr :: [TySpec] -> Decl -> Decl
mkPtr specs decl = C.Ptr quals decl (specs <--> decl)
  where
    quals = mkTypeQuals specs

mkArray :: [TySpec] -> ArraySize -> Decl -> Decl
mkArray specs size decl = Array quals size decl (specs <--> decl)
  where
    quals = mkTypeQuals specs

mkProto :: Params -> Decl -> Decl
mkProto args decl = Proto decl args (args <--> decl)

mkOldProto :: [Id] -> Decl -> Decl
mkOldProto args decl = OldProto decl args (args <--> decl)

checkInitGroup :: DeclSpec -> Decl -> [Attr] -> [Init] -> P InitGroup
checkInitGroup dspec decl attrs inits =
    go dspec
  where
    go :: DeclSpec -> P InitGroup
    go (DeclSpec storage quals tspec _) | any isTypedef storage = do
        typedefs    <-  mapM checkInit inits'
        let dspec'  =   cdeclSpec storage' quals tspec
        return $ ctypedefGroup dspec' attrs typedefs
      where
        storage' :: [Storage]
        storage' = [x | x <- storage, (not . isTypedef) x]

        isTypedef :: Storage -> Bool
        isTypedef (Ttypedef _)  = True
        isTypedef _             = False

        checkInit :: Init -> P Typedef
        checkInit init@(Init ident _  _ (Just _) _ _)=
            throw $ ParserException (getLoc init) $
                text "typedef" <+>
                squotes (ppr ident) <+>
                text "is illegaly initialized"

        checkInit (Init ident@(Id name _) decl _ _ attrs _) = do
            addTypedef name
            return $ ctypedef ident decl attrs

        checkInit (Init ident@(AntiId _ _) decl _ _ attrs _) =
            return $ ctypedef ident decl attrs

    go _ = do
        mapM_ checkInit inits'
        return $ cinitGroup dspec attrs inits'
      where
        checkInit :: Init -> P ()
        checkInit (Init (Id name _) _ _ _ _ _)   = addVariable name
        checkInit (Init (AntiId _ _) _ _ _ _ _)  = return ()

    composeInitDecl :: Decl -> Init -> Init
    composeInitDecl decl (Init ident initDecl maybe_asmlabel maybe_exp attrs loc) =
        Init ident (composeDecls initDecl decl) maybe_asmlabel maybe_exp attrs loc

    inits' = map (composeInitDecl decl) inits

    loc :: Loc
    loc = (dspec <--> attrs :: Loc) <--> inits

declRoot :: Located a => a -> Decl
declRoot x = DeclRoot (locOf x)

data RevList a  =  RNil
                |  RCons a (RevList a)

rnil :: RevList a
rnil = RNil

rsingleton :: a -> RevList a
rsingleton x = RCons x RNil

rcons :: a -> RevList a -> RevList a
rcons x xs  = RCons x xs

rev :: RevList a -> [a]
rev xs = go [] xs
  where
    go  l  RNil          = l
    go  l  (RCons x xs)  = go (x : l) xs

expected  ::  Loc
          ->  [String]
          ->  P a
expected loc alts =
    throw $ ParserException (locEnd loc)
        (text "unclosed" <+> go alts)
  where
    go :: [String] -> Doc
    go []       = empty
    go [x]      = text x
    go [x, y]   = text x <+> text "or" <+> text y
    go (x : xs) = text x <> comma <+> go xs

unclosed  ::  Loc
          ->  String
          ->  P a
unclosed loc x =
    throw $ ParserException (locEnd loc)
        (text "unclosed" <+> squotes (text x))

badExecutionContext  ::  Loc
                     ->  [Exp]
                     ->  P a
badExecutionContext loc es =
    throw $ ParserException (locEnd loc) $
    text "execution context should have 2-4 arguments, but saw" <+>
    ppr (length es)

badFunctionDeclaration  ::  Loc
                        ->  [Exp]
                        ->  P a
badFunctionDeclaration loc es =
    throw $ ParserException (locEnd loc) $
    text "execution context should have 2-4 arguments, but saw" <+>
    ppr (length es)
}
