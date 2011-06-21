{-# OPTIONS_GHC -fno-warn-overlapping-patterns #-}
{-# OPTIONS -fglasgow-exts -cpp #-}
{-# OPTIONS -w #-}

-- Copyright (c) 2006-2010
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
-- Copyright   :  (c) Harvard University 2006-2010
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
#if __GLASGOW_HASKELL__ >= 503
import qualified Data.Array as Happy_Data_Array
#else
import qualified Array as Happy_Data_Array
#endif
#if __GLASGOW_HASKELL__ >= 503
import qualified GHC.Exts as Happy_GHC_Exts
#else
import qualified GlaExts as Happy_GHC_Exts
#endif

-- parser produced by Happy Version 1.18.4

newtype HappyAbsSyn  = HappyAbsSyn HappyAny
#if __GLASGOW_HASKELL__ >= 607
type HappyAny = Happy_GHC_Exts.Any
#else
type HappyAny = forall a . a
#endif
happyIn14 :: (Id) -> (HappyAbsSyn )
happyIn14 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn14 #-}
happyOut14 :: (HappyAbsSyn ) -> (Id)
happyOut14 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut14 #-}
happyIn15 :: (Id) -> (HappyAbsSyn )
happyIn15 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn15 #-}
happyOut15 :: (HappyAbsSyn ) -> (Id)
happyOut15 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut15 #-}
happyIn16 :: (Const) -> (HappyAbsSyn )
happyIn16 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn16 #-}
happyOut16 :: (HappyAbsSyn ) -> (Const)
happyOut16 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut16 #-}
happyIn17 :: (Exp) -> (HappyAbsSyn )
happyIn17 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn17 #-}
happyOut17 :: (HappyAbsSyn ) -> (Exp)
happyOut17 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut17 #-}
happyIn18 :: (RevList (L (String, String))) -> (HappyAbsSyn )
happyIn18 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn18 #-}
happyOut18 :: (HappyAbsSyn ) -> (RevList (L (String, String)))
happyOut18 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut18 #-}
happyIn19 :: (Exp) -> (HappyAbsSyn )
happyIn19 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn19 #-}
happyOut19 :: (HappyAbsSyn ) -> (Exp)
happyOut19 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut19 #-}
happyIn20 :: (ExeConfig) -> (HappyAbsSyn )
happyIn20 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn20 #-}
happyOut20 :: (HappyAbsSyn ) -> (ExeConfig)
happyOut20 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut20 #-}
happyIn21 :: (RevList Exp) -> (HappyAbsSyn )
happyIn21 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn21 #-}
happyOut21 :: (HappyAbsSyn ) -> (RevList Exp)
happyOut21 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut21 #-}
happyIn22 :: (Exp) -> (HappyAbsSyn )
happyIn22 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn22 #-}
happyOut22 :: (HappyAbsSyn ) -> (Exp)
happyOut22 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut22 #-}
happyIn23 :: (Exp) -> (HappyAbsSyn )
happyIn23 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn23 #-}
happyOut23 :: (HappyAbsSyn ) -> (Exp)
happyOut23 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut23 #-}
happyIn24 :: (Exp) -> (HappyAbsSyn )
happyIn24 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn24 #-}
happyOut24 :: (HappyAbsSyn ) -> (Exp)
happyOut24 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut24 #-}
happyIn25 :: (Exp) -> (HappyAbsSyn )
happyIn25 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn25 #-}
happyOut25 :: (HappyAbsSyn ) -> (Exp)
happyOut25 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut25 #-}
happyIn26 :: (Exp) -> (HappyAbsSyn )
happyIn26 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn26 #-}
happyOut26 :: (HappyAbsSyn ) -> (Exp)
happyOut26 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut26 #-}
happyIn27 :: (Exp) -> (HappyAbsSyn )
happyIn27 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn27 #-}
happyOut27 :: (HappyAbsSyn ) -> (Exp)
happyOut27 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut27 #-}
happyIn28 :: (Exp) -> (HappyAbsSyn )
happyIn28 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn28 #-}
happyOut28 :: (HappyAbsSyn ) -> (Exp)
happyOut28 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut28 #-}
happyIn29 :: (Exp) -> (HappyAbsSyn )
happyIn29 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn29 #-}
happyOut29 :: (HappyAbsSyn ) -> (Exp)
happyOut29 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut29 #-}
happyIn30 :: (Exp) -> (HappyAbsSyn )
happyIn30 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn30 #-}
happyOut30 :: (HappyAbsSyn ) -> (Exp)
happyOut30 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut30 #-}
happyIn31 :: (Exp) -> (HappyAbsSyn )
happyIn31 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn31 #-}
happyOut31 :: (HappyAbsSyn ) -> (Exp)
happyOut31 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut31 #-}
happyIn32 :: (Exp) -> (HappyAbsSyn )
happyIn32 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn32 #-}
happyOut32 :: (HappyAbsSyn ) -> (Exp)
happyOut32 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut32 #-}
happyIn33 :: (Exp) -> (HappyAbsSyn )
happyIn33 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn33 #-}
happyOut33 :: (HappyAbsSyn ) -> (Exp)
happyOut33 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut33 #-}
happyIn34 :: (Exp) -> (HappyAbsSyn )
happyIn34 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn34 #-}
happyOut34 :: (HappyAbsSyn ) -> (Exp)
happyOut34 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut34 #-}
happyIn35 :: (Exp) -> (HappyAbsSyn )
happyIn35 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn35 #-}
happyOut35 :: (HappyAbsSyn ) -> (Exp)
happyOut35 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut35 #-}
happyIn36 :: (Exp) -> (HappyAbsSyn )
happyIn36 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn36 #-}
happyOut36 :: (HappyAbsSyn ) -> (Exp)
happyOut36 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut36 #-}
happyIn37 :: (Maybe Exp) -> (HappyAbsSyn )
happyIn37 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn37 #-}
happyOut37 :: (HappyAbsSyn ) -> (Maybe Exp)
happyOut37 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut37 #-}
happyIn38 :: (Exp) -> (HappyAbsSyn )
happyIn38 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn38 #-}
happyOut38 :: (HappyAbsSyn ) -> (Exp)
happyOut38 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut38 #-}
happyIn39 :: (InitGroup) -> (HappyAbsSyn )
happyIn39 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn39 #-}
happyOut39 :: (HappyAbsSyn ) -> (InitGroup)
happyOut39 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut39 #-}
happyIn40 :: (InitGroup) -> (HappyAbsSyn )
happyIn40 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn40 #-}
happyOut40 :: (HappyAbsSyn ) -> (InitGroup)
happyOut40 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut40 #-}
happyIn41 :: ((DeclSpec, Decl)) -> (HappyAbsSyn )
happyIn41 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn41 #-}
happyOut41 :: (HappyAbsSyn ) -> ((DeclSpec, Decl))
happyOut41 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut41 #-}
happyIn42 :: ((DeclSpec, Decl)) -> (HappyAbsSyn )
happyIn42 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn42 #-}
happyOut42 :: (HappyAbsSyn ) -> ((DeclSpec, Decl))
happyOut42 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut42 #-}
happyIn43 :: ((DeclSpec, Decl)) -> (HappyAbsSyn )
happyIn43 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn43 #-}
happyOut43 :: (HappyAbsSyn ) -> ((DeclSpec, Decl))
happyOut43 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut43 #-}
happyIn44 :: ([TySpec]) -> (HappyAbsSyn )
happyIn44 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn44 #-}
happyOut44 :: (HappyAbsSyn ) -> ([TySpec])
happyOut44 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut44 #-}
happyIn45 :: ([TySpec]) -> (HappyAbsSyn )
happyIn45 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn45 #-}
happyOut45 :: (HappyAbsSyn ) -> ([TySpec])
happyOut45 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut45 #-}
happyIn46 :: (RevList Init) -> (HappyAbsSyn )
happyIn46 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn46 #-}
happyOut46 :: (HappyAbsSyn ) -> (RevList Init)
happyOut46 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut46 #-}
happyIn47 :: (Maybe AsmLabel) -> (HappyAbsSyn )
happyIn47 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn47 #-}
happyOut47 :: (HappyAbsSyn ) -> (Maybe AsmLabel)
happyOut47 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut47 #-}
happyIn48 :: (Init) -> (HappyAbsSyn )
happyIn48 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn48 #-}
happyOut48 :: (HappyAbsSyn ) -> (Init)
happyOut48 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut48 #-}
happyIn49 :: (TySpec) -> (HappyAbsSyn )
happyIn49 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn49 #-}
happyOut49 :: (HappyAbsSyn ) -> (TySpec)
happyOut49 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut49 #-}
happyIn50 :: (TySpec) -> (HappyAbsSyn )
happyIn50 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn50 #-}
happyOut50 :: (HappyAbsSyn ) -> (TySpec)
happyOut50 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut50 #-}
happyIn51 :: (TySpec) -> (HappyAbsSyn )
happyIn51 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn51 #-}
happyOut51 :: (HappyAbsSyn ) -> (TySpec)
happyOut51 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut51 #-}
happyIn52 :: (L (Maybe Id -> Maybe [FieldGroup] -> [Attr] -> SrcLoc -> TySpec)) -> (HappyAbsSyn )
happyIn52 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn52 #-}
happyOut52 :: (HappyAbsSyn ) -> (L (Maybe Id -> Maybe [FieldGroup] -> [Attr] -> SrcLoc -> TySpec))
happyOut52 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut52 #-}
happyIn53 :: (RevList FieldGroup) -> (HappyAbsSyn )
happyIn53 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn53 #-}
happyOut53 :: (HappyAbsSyn ) -> (RevList FieldGroup)
happyOut53 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut53 #-}
happyIn54 :: (FieldGroup) -> (HappyAbsSyn )
happyIn54 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn54 #-}
happyOut54 :: (HappyAbsSyn ) -> (FieldGroup)
happyOut54 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut54 #-}
happyIn55 :: ([TySpec]) -> (HappyAbsSyn )
happyIn55 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn55 #-}
happyOut55 :: (HappyAbsSyn ) -> ([TySpec])
happyOut55 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut55 #-}
happyIn56 :: ([TySpec]) -> (HappyAbsSyn )
happyIn56 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn56 #-}
happyOut56 :: (HappyAbsSyn ) -> ([TySpec])
happyOut56 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut56 #-}
happyIn57 :: (RevList Field) -> (HappyAbsSyn )
happyIn57 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn57 #-}
happyOut57 :: (HappyAbsSyn ) -> (RevList Field)
happyOut57 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut57 #-}
happyIn58 :: (Field) -> (HappyAbsSyn )
happyIn58 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn58 #-}
happyOut58 :: (HappyAbsSyn ) -> (Field)
happyOut58 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut58 #-}
happyIn59 :: (TySpec) -> (HappyAbsSyn )
happyIn59 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn59 #-}
happyOut59 :: (HappyAbsSyn ) -> (TySpec)
happyOut59 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut59 #-}
happyIn60 :: (RevList CEnum) -> (HappyAbsSyn )
happyIn60 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn60 #-}
happyOut60 :: (HappyAbsSyn ) -> (RevList CEnum)
happyOut60 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut60 #-}
happyIn61 :: (CEnum) -> (HappyAbsSyn )
happyIn61 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn61 #-}
happyOut61 :: (HappyAbsSyn ) -> (CEnum)
happyOut61 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut61 #-}
happyIn62 :: (TySpec) -> (HappyAbsSyn )
happyIn62 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn62 #-}
happyOut62 :: (HappyAbsSyn ) -> (TySpec)
happyOut62 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut62 #-}
happyIn63 :: ((Id, Decl -> Decl)) -> (HappyAbsSyn )
happyIn63 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn63 #-}
happyOut63 :: (HappyAbsSyn ) -> ((Id, Decl -> Decl))
happyOut63 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut63 #-}
happyIn64 :: ((Id, Decl -> Decl)) -> (HappyAbsSyn )
happyIn64 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn64 #-}
happyOut64 :: (HappyAbsSyn ) -> ((Id, Decl -> Decl))
happyOut64 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut64 #-}
happyIn65 :: ((Id, Decl -> Decl)) -> (HappyAbsSyn )
happyIn65 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn65 #-}
happyOut65 :: (HappyAbsSyn ) -> ((Id, Decl -> Decl))
happyOut65 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut65 #-}
happyIn66 :: ((Id, Decl -> Decl)) -> (HappyAbsSyn )
happyIn66 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn66 #-}
happyOut66 :: (HappyAbsSyn ) -> ((Id, Decl -> Decl))
happyOut66 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut66 #-}
happyIn67 :: ((Id, Decl -> Decl)) -> (HappyAbsSyn )
happyIn67 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn67 #-}
happyOut67 :: (HappyAbsSyn ) -> ((Id, Decl -> Decl))
happyOut67 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut67 #-}
happyIn68 :: ((Id, Decl -> Decl)) -> (HappyAbsSyn )
happyIn68 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn68 #-}
happyOut68 :: (HappyAbsSyn ) -> ((Id, Decl -> Decl))
happyOut68 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut68 #-}
happyIn69 :: ((Id, Decl -> Decl)) -> (HappyAbsSyn )
happyIn69 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn69 #-}
happyOut69 :: (HappyAbsSyn ) -> ((Id, Decl -> Decl))
happyOut69 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut69 #-}
happyIn70 :: ((Id, Decl -> Decl)) -> (HappyAbsSyn )
happyIn70 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn70 #-}
happyOut70 :: (HappyAbsSyn ) -> ((Id, Decl -> Decl))
happyOut70 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut70 #-}
happyIn71 :: (Decl -> Decl) -> (HappyAbsSyn )
happyIn71 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn71 #-}
happyOut71 :: (HappyAbsSyn ) -> (Decl -> Decl)
happyOut71 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut71 #-}
happyIn72 :: (Decl -> Decl) -> (HappyAbsSyn )
happyIn72 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn72 #-}
happyOut72 :: (HappyAbsSyn ) -> (Decl -> Decl)
happyOut72 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut72 #-}
happyIn73 :: (RevList TySpec) -> (HappyAbsSyn )
happyIn73 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn73 #-}
happyOut73 :: (HappyAbsSyn ) -> (RevList TySpec)
happyOut73 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut73 #-}
happyIn74 :: (Params) -> (HappyAbsSyn )
happyIn74 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn74 #-}
happyOut74 :: (HappyAbsSyn ) -> (Params)
happyOut74 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut74 #-}
happyIn75 :: (RevList Param) -> (HappyAbsSyn )
happyIn75 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn75 #-}
happyOut75 :: (HappyAbsSyn ) -> (RevList Param)
happyOut75 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut75 #-}
happyIn76 :: (Param) -> (HappyAbsSyn )
happyIn76 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn76 #-}
happyOut76 :: (HappyAbsSyn ) -> (Param)
happyOut76 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut76 #-}
happyIn77 :: (Type) -> (HappyAbsSyn )
happyIn77 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn77 #-}
happyOut77 :: (HappyAbsSyn ) -> (Type)
happyOut77 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut77 #-}
happyIn78 :: (RevList Id) -> (HappyAbsSyn )
happyIn78 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn78 #-}
happyOut78 :: (HappyAbsSyn ) -> (RevList Id)
happyOut78 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut78 #-}
happyIn79 :: (Type) -> (HappyAbsSyn )
happyIn79 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn79 #-}
happyOut79 :: (HappyAbsSyn ) -> (Type)
happyOut79 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut79 #-}
happyIn80 :: (Decl -> Decl) -> (HappyAbsSyn )
happyIn80 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn80 #-}
happyOut80 :: (HappyAbsSyn ) -> (Decl -> Decl)
happyOut80 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut80 #-}
happyIn81 :: (Decl -> Decl) -> (HappyAbsSyn )
happyIn81 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn81 #-}
happyOut81 :: (HappyAbsSyn ) -> (Decl -> Decl)
happyOut81 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut81 #-}
happyIn82 :: (TySpec) -> (HappyAbsSyn )
happyIn82 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn82 #-}
happyOut82 :: (HappyAbsSyn ) -> (TySpec)
happyOut82 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut82 #-}
happyIn83 :: (Initializer) -> (HappyAbsSyn )
happyIn83 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn83 #-}
happyOut83 :: (HappyAbsSyn ) -> (Initializer)
happyOut83 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut83 #-}
happyIn84 :: (RevList (Maybe Designation, Initializer)) -> (HappyAbsSyn )
happyIn84 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn84 #-}
happyOut84 :: (HappyAbsSyn ) -> (RevList (Maybe Designation, Initializer))
happyOut84 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut84 #-}
happyIn85 :: (Designation) -> (HappyAbsSyn )
happyIn85 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn85 #-}
happyOut85 :: (HappyAbsSyn ) -> (Designation)
happyOut85 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut85 #-}
happyIn86 :: (RevList Designator) -> (HappyAbsSyn )
happyIn86 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn86 #-}
happyOut86 :: (HappyAbsSyn ) -> (RevList Designator)
happyOut86 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut86 #-}
happyIn87 :: (Designator) -> (HappyAbsSyn )
happyIn87 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn87 #-}
happyOut87 :: (HappyAbsSyn ) -> (Designator)
happyOut87 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut87 #-}
happyIn88 :: (Stm) -> (HappyAbsSyn )
happyIn88 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn88 #-}
happyOut88 :: (HappyAbsSyn ) -> (Stm)
happyOut88 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut88 #-}
happyIn89 :: (Stm) -> (HappyAbsSyn )
happyIn89 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn89 #-}
happyOut89 :: (HappyAbsSyn ) -> (Stm)
happyOut89 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut89 #-}
happyIn90 :: (Stm) -> (HappyAbsSyn )
happyIn90 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn90 #-}
happyOut90 :: (HappyAbsSyn ) -> (Stm)
happyOut90 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut90 #-}
happyIn91 :: (RevList BlockItem) -> (HappyAbsSyn )
happyIn91 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn91 #-}
happyOut91 :: (HappyAbsSyn ) -> (RevList BlockItem)
happyOut91 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut91 #-}
happyIn92 :: (BlockItem) -> (HappyAbsSyn )
happyIn92 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn92 #-}
happyOut92 :: (HappyAbsSyn ) -> (BlockItem)
happyOut92 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut92 #-}
happyIn93 :: (()) -> (HappyAbsSyn )
happyIn93 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn93 #-}
happyOut93 :: (HappyAbsSyn ) -> (())
happyOut93 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut93 #-}
happyIn94 :: (()) -> (HappyAbsSyn )
happyIn94 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn94 #-}
happyOut94 :: (HappyAbsSyn ) -> (())
happyOut94 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut94 #-}
happyIn95 :: (RevList InitGroup) -> (HappyAbsSyn )
happyIn95 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn95 #-}
happyOut95 :: (HappyAbsSyn ) -> (RevList InitGroup)
happyOut95 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut95 #-}
happyIn96 :: (Stm) -> (HappyAbsSyn )
happyIn96 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn96 #-}
happyOut96 :: (HappyAbsSyn ) -> (Stm)
happyOut96 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut96 #-}
happyIn97 :: (Stm) -> (HappyAbsSyn )
happyIn97 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn97 #-}
happyOut97 :: (HappyAbsSyn ) -> (Stm)
happyOut97 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut97 #-}
happyIn98 :: (Stm) -> (HappyAbsSyn )
happyIn98 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn98 #-}
happyOut98 :: (HappyAbsSyn ) -> (Stm)
happyOut98 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut98 #-}
happyIn99 :: (Stm) -> (HappyAbsSyn )
happyIn99 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn99 #-}
happyOut99 :: (HappyAbsSyn ) -> (Stm)
happyOut99 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut99 #-}
happyIn100 :: ([Definition]) -> (HappyAbsSyn )
happyIn100 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn100 #-}
happyOut100 :: (HappyAbsSyn ) -> ([Definition])
happyOut100 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut100 #-}
happyIn101 :: (RevList Definition) -> (HappyAbsSyn )
happyIn101 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn101 #-}
happyOut101 :: (HappyAbsSyn ) -> (RevList Definition)
happyOut101 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut101 #-}
happyIn102 :: (Definition) -> (HappyAbsSyn )
happyIn102 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn102 #-}
happyOut102 :: (HappyAbsSyn ) -> (Definition)
happyOut102 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut102 #-}
happyIn103 :: (Func) -> (HappyAbsSyn )
happyIn103 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn103 #-}
happyOut103 :: (HappyAbsSyn ) -> (Func)
happyOut103 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut103 #-}
happyIn104 :: ([Attr]) -> (HappyAbsSyn )
happyIn104 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn104 #-}
happyOut104 :: (HappyAbsSyn ) -> ([Attr])
happyOut104 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut104 #-}
happyIn105 :: ([Attr]) -> (HappyAbsSyn )
happyIn105 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn105 #-}
happyOut105 :: (HappyAbsSyn ) -> ([Attr])
happyOut105 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut105 #-}
happyIn106 :: (RevList Attr) -> (HappyAbsSyn )
happyIn106 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn106 #-}
happyOut106 :: (HappyAbsSyn ) -> (RevList Attr)
happyOut106 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut106 #-}
happyIn107 :: (Attr) -> (HappyAbsSyn )
happyIn107 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn107 #-}
happyOut107 :: (HappyAbsSyn ) -> (Attr)
happyOut107 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut107 #-}
happyIn108 :: (Id) -> (HappyAbsSyn )
happyIn108 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn108 #-}
happyOut108 :: (HappyAbsSyn ) -> (Id)
happyOut108 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut108 #-}
happyIn109 :: (Bool) -> (HappyAbsSyn )
happyIn109 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn109 #-}
happyOut109 :: (HappyAbsSyn ) -> (Bool)
happyOut109 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut109 #-}
happyIn110 :: (Stm) -> (HappyAbsSyn )
happyIn110 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn110 #-}
happyOut110 :: (HappyAbsSyn ) -> (Stm)
happyOut110 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut110 #-}
happyIn111 :: (RevList String) -> (HappyAbsSyn )
happyIn111 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn111 #-}
happyOut111 :: (HappyAbsSyn ) -> (RevList String)
happyOut111 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut111 #-}
happyIn112 :: ([(String, Exp)]) -> (HappyAbsSyn )
happyIn112 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn112 #-}
happyOut112 :: (HappyAbsSyn ) -> ([(String, Exp)])
happyOut112 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut112 #-}
happyIn113 :: (RevList (String, Exp)) -> (HappyAbsSyn )
happyIn113 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn113 #-}
happyOut113 :: (HappyAbsSyn ) -> (RevList (String, Exp))
happyOut113 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut113 #-}
happyIn114 :: ((String, Exp)) -> (HappyAbsSyn )
happyIn114 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn114 #-}
happyOut114 :: (HappyAbsSyn ) -> ((String, Exp))
happyOut114 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut114 #-}
happyIn115 :: ([String]) -> (HappyAbsSyn )
happyIn115 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn115 #-}
happyOut115 :: (HappyAbsSyn ) -> ([String])
happyOut115 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut115 #-}
happyIn116 :: (RevList String) -> (HappyAbsSyn )
happyIn116 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn116 #-}
happyOut116 :: (HappyAbsSyn ) -> (RevList String)
happyOut116 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut116 #-}
happyIn117 :: (String) -> (HappyAbsSyn )
happyIn117 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn117 #-}
happyOut117 :: (HappyAbsSyn ) -> (String)
happyOut117 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut117 #-}
happyInTok :: ((L T.Token)) -> (HappyAbsSyn )
happyInTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn ) -> ((L T.Token))
happyOutTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOutTok #-}


happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\xf2\x10\x6d\x07\x5d\x08\x19\x09\x53\x00\xad\x08\x7c\x06\xf6\x0f\xda\x03\x1d\x07\xad\x08\xc3\x04\x00\x00\x31\x01\x00\x00\x00\x00\x4f\x09\xf7\x16\xcf\x16\x00\x00\x27\x01\x00\x00\xf7\x16\xf7\x16\x3f\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe0\x00\xc7\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb9\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x14\x00\x00\x00\x00\x00\x00\x00\xa8\x04\x15\x01\x2e\x04\xcd\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa5\x04\x00\x00\x00\x00\xb5\x04\x13\x02\x9b\x09\x00\x00\xec\x03\xf8\x03\xed\x03\x6e\x03\xd1\x03\x97\x04\x90\x04\x95\x04\x89\x04\xfa\xff\x00\x00\x00\x00\x27\x00\x23\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xec\x02\x00\x00\x00\x00\xf2\x10\xf2\x10\xf2\x10\xf2\x10\xf2\x10\xb8\x10\xb8\x10\x91\x10\xb3\x01\x91\x10\x53\x01\x9a\x04\xda\x03\x9c\x04\x0d\x00\x9b\x04\x42\x0c\x57\x10\x91\x04\x8d\x04\x3c\x04\x81\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x07\x04\xf5\x0d\x1b\x01\x07\x04\x00\x00\x1b\x01\x07\x04\x5b\x04\xf5\x03\x00\x00\x54\x17\xf5\x03\x18\x01\x00\x00\x50\x11\xd4\x07\x00\x00\x18\x01\x57\x00\xf5\x03\x15\x01\xf5\x03\x0b\x00\x30\x10\x00\x00\x75\x04\x00\x00\x00\x00\x9c\x03\x00\x00\x86\x03\x7d\x01\x6c\x01\xae\x00\x00\x00\x00\x00\x00\x00\x23\x01\x58\x03\x74\x04\x00\x00\x6c\x04\x00\x00\xdc\x03\x00\x00\x88\x00\x30\x10\xd4\x07\x54\x17\x00\x00\xd4\x07\xb6\x03\x50\x11\x00\x00\x50\x11\x30\x10\x00\x00\x00\x00\x64\x03\x00\x00\x00\x00\xfd\x00\x00\x00\x33\x03\x00\x00\x38\x04\x2b\x0b\x00\x00\x00\x00\x00\x00\x34\x01\xf6\x0f\x02\x00\x00\x00\x30\x10\x0c\x00\x30\x10\x6f\x04\x00\x00\x30\x10\x30\x10\x00\x00\xec\x02\x20\x00\x00\x00\x00\x00\x30\x10\xd2\x00\x00\x00\x8a\x00\x1c\x04\xda\x03\x00\x00\x00\x00\x00\x00\x00\x00\x65\x04\x00\x00\x00\x00\x00\x00\x00\x00\xec\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\xef\x03\xe2\x01\x78\x02\x67\x04\xe2\x01\xe2\x01\x00\x00\x00\x00\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\x30\x10\xbc\x09\x69\x0c\x57\x00\x57\x00\x00\x00\x00\x00\xfc\x0a\x00\x00\xda\x03\x00\x00\x00\x00\x05\x01\x00\x00\x00\x00\x00\x00\x63\x03\x00\x00\x63\x04\x54\x00\x2d\x00\x00\x00\x00\x00\x61\x04\x54\x00\xe3\x08\x00\x00\xcf\x16\xcf\x16\xcf\x16\x00\x00\xcf\x16\xf7\x16\x00\x00\x0d\x08\x00\x00\x00\x00\xbd\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf8\x01\x00\x00\x00\x00\x60\x04\x00\x00\xe3\x08\xa7\x03\x00\x00\x00\x00\x00\x00\x2d\x00\x62\x04\x4d\x02\x29\x04\x3e\x03\x00\x00\x4a\x04\x00\x00\x18\x00\x43\x04\x00\x00\x00\x00\x00\x00\x00\x00\x8b\x02\x00\x00\xe4\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xec\x03\xec\x03\x6b\x03\x6b\x03\x25\x03\x25\x03\x25\x03\x25\x03\x6e\x03\x6e\x03\xda\x02\x40\x04\x39\x04\x37\x04\x2d\x04\x1f\x03\x13\x03\x00\x00\x82\x05\x00\x00\x00\x00\x00\x00\xcf\x0f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x64\x02\x00\x00\x36\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x34\x04\xda\x03\x00\x00\x33\x04\x2c\x04\x28\x04\x30\x10\x00\x00\x00\x00\x00\x00\x92\x03\x00\x00\x00\x00\x1b\x02\x79\x03\x27\x03\x35\x04\x1e\x04\x00\x00\x27\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa3\x0b\x25\x04\xe0\x0c\x00\x00\x00\x00\x58\x0f\x57\x0d\xc8\x01\xfd\x00\x21\x04\x1b\x04\x00\x00\x37\x01\x38\x04\x00\x00\x00\x00\x00\x00\x2a\x06\x0d\x03\xd9\x02\xb6\x02\x00\x00\x2e\x05\x00\x00\x00\x00\x00\x00\xab\x00\x00\x00\xd4\x07\x00\x00\x00\x00\xc8\x03\x30\x10\x00\x00\x00\x00\x1a\x04\x00\x00\x58\x03\x99\x00\x13\x04\x03\x01\x00\x00\xdc\x04\x00\x00\x8a\x04\x96\x00\x00\x00\x00\x00\x00\x00\x17\x04\xd4\x02\x00\x00\x0f\x04\xd1\x02\x00\x00\x00\x00\x00\x00\x00\x00\x31\x11\x00\x00\x00\x00\x06\x04\x87\x02\x00\x00\x01\x04\x00\x00\x2a\x00\x00\x00\x00\x00\xd8\x05\x00\x00\xdb\x03\x00\x00\x00\x00\xf6\x03\x57\x0d\x00\x00\xee\x03\x00\x00\x31\x0f\x30\x10\x00\x00\x00\x00\xba\x0e\x00\x00\x00\x00\x00\x00\xad\x08\xd4\x01\x00\x00\x00\x00\xda\x03\x00\x00\xda\x03\x00\x00\xe7\x03\x00\x00\xda\x03\xdf\x03\x30\x10\x30\x10\x00\x00\xae\x03\x00\x00\x00\x00\xa5\x03\x00\x00\xf5\x0d\x30\x10\x00\x00\x00\x00\x83\x0a\x00\x00\x00\x00\xa4\x03\xa8\x03\x00\x00\x1c\x0e\x00\x00\x00\x00\x00\x00\x6a\x02\x00\x00\x2b\x00\xa7\x01\xe3\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x56\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1c\x0e\x8a\x03\xe3\x09\x00\x00\x00\x00\x00\x00\x45\x02\x00\x00\x19\x03\x77\x03\x93\x0e\x3c\x03\x00\x00\x00\x00\x00\x00\x68\x03\x4e\x03\x35\x03\x00\x00\x2c\x03\x00\x00\x00\x00\x26\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0c\x00\x00\x00\x00\x00\x47\x02\x00\x00\x21\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5c\x0a\x1a\x03\x31\x11\x00\x00\x00\x00\x00\x00\x00\x00\xbd\x01\x0c\x03\x00\x00\xd8\x02\x00\x00\xda\x03\x11\x02\xda\x03\xca\x0b\x00\x00\xfc\x02\x00\x00\x7e\x0d\x83\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf5\x01\x00\x00\xda\x03\x00\x00\xda\x03\x00\x00\x30\x10\x05\x03\xca\x02\xc2\x02\x00\x00\x00\x00\xdd\x01\x00\x00\xaf\x00\x00\x00\x00\x00\x1e\x00\x00\x00\x00\x00\x00\x00\xda\x03\x00\x00\x00\x00\x94\x02\x93\x02\x50\x02\x3b\x02\x00\x00\x00\x00\x00\x00\x42\x02\x2c\x02\x00\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\x5c\x19\x95\x0a\x2e\x0e\x9e\x14\x8b\x01\xcd\x0e\x20\x13\xf0\x05\x8b\x14\xf5\x09\xe6\x03\x00\x00\x00\x00\x17\x03\x00\x00\x00\x00\x4c\x02\x27\x02\x38\x06\x00\x00\xb1\x00\x00\x00\x19\x02\x02\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x28\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x3a\x02\x00\x00\x00\x00\x00\x00\x00\x00\x77\x04\x00\x00\xd0\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x35\x15\xe1\x01\x00\x00\x21\x0c\xd7\x0b\x38\x0b\xf0\x09\x75\x09\x1c\x0a\xf7\x06\x3f\x09\x00\x00\x2f\x18\x00\x00\x00\x00\x32\x14\x00\x00\x1c\x02\x00\x00\x45\x19\xa5\x06\x00\x00\x00\x00\x9c\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x90\x15\x54\x02\x00\x00\x00\x00\x95\x01\x00\x00\x00\x00\x00\x00\x00\x00\xb6\x07\x00\x00\xe1\x02\x00\x00\xdb\x02\x22\x02\x00\x00\x47\x01\x03\x02\x00\x00\xe5\x01\x00\x00\x00\x00\xff\x1a\x00\x00\x00\x00\x00\x00\x00\x00\xba\x01\x00\x00\xad\x01\x69\x01\x7e\x01\x17\x06\x00\x00\x00\x00\x00\x00\xf9\x01\x8f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x42\x01\x18\x18\x9a\x01\x0c\x04\x00\x00\xf6\x01\x00\x00\x28\x15\x00\x00\xe3\x14\x01\x18\x00\x00\x00\x00\x82\x01\x00\x00\x00\x00\xa8\x01\x00\x00\x71\x01\x00\x00\x08\x16\xf0\x16\x00\x00\x00\x00\x00\x00\x00\x00\x9e\x05\x6b\x01\x00\x00\xea\x17\x89\x01\xe9\x1a\x00\x00\x00\x00\x2e\x19\x17\x19\x00\x00\xf0\x14\x00\x00\x00\x00\x00\x00\x00\x19\x00\x00\x00\x00\xf0\x15\x00\x00\x1b\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xab\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xbd\x11\x00\x00\x86\x02\x00\x00\x00\x00\x58\x02\xd2\x01\x00\x00\x00\x00\xe9\x18\xd8\x0d\x56\x0b\x14\x0f\xab\x09\xdd\x0a\x66\x0a\x3d\x0a\x73\x0c\x7e\x0b\x06\x0b\x8d\x0a\xc9\x0c\x4e\x0c\x2c\x08\x50\x06\x09\x09\xb9\x08\x69\x08\xd3\x1a\xbd\x1a\xa7\x1a\x91\x1a\x7b\x1a\x65\x1a\x4f\x1a\x39\x1a\x23\x1a\x0d\x1a\xf7\x19\xb5\x19\xd2\x18\x61\x01\x38\x01\x00\x00\x00\x00\x73\x19\x00\x00\x04\x14\x00\x00\x00\x00\x9c\x16\x00\x00\x00\x00\x00\x00\x83\x16\x00\x00\x00\x00\x29\x01\x87\x01\x00\x00\x00\x00\x00\x00\xe5\x00\xca\x11\x00\x00\x98\x04\xf9\x03\x52\x03\x00\x00\xfe\x02\xb2\x01\x00\x00\xdc\x0b\x00\x00\x00\x00\x7b\x0c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x23\x12\x00\x00\x00\x00\x00\x00\x00\x00\xe3\x0c\x00\x00\x00\x00\x00\x00\x00\x00\xee\x00\x00\x00\x00\x00\x00\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa5\x00\x00\x00\xa5\x17\x00\x00\x00\x00\x00\x00\x79\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x16\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xab\x13\x00\x00\x00\x00\x00\x00\x00\x00\x5e\x18\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x22\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa6\x15\x00\x00\x79\x17\x00\x00\x00\x00\xd8\x06\x3c\x11\x00\x00\x5f\x01\x00\x00\x00\x00\x00\x00\x00\x00\xf2\x0c\x00\x00\x00\x00\x00\x00\x5f\x08\x30\x01\x20\x01\x13\x01\x00\x00\x5c\x16\x00\x00\x00\x00\x00\x00\x5f\x07\x00\x00\xa8\x00\x00\x00\x00\x00\x5f\x00\xcb\x16\x00\x00\x00\x00\x00\x00\x00\x00\x6a\x01\x00\x00\x00\x00\x6d\x00\x00\x00\x32\x16\x00\x00\x7e\x06\x0c\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x22\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd0\x00\x00\x00\x00\x00\x99\x12\x00\x00\x65\x00\x00\x00\x00\x00\x00\x00\x63\x17\x00\x00\x00\x00\x00\x00\xd8\x06\xe1\x19\x00\x00\x00\x00\x4d\x05\x00\x00\x00\x00\x00\x00\xb0\x08\x00\x00\x00\x00\x00\x00\x94\x13\x00\x00\x7d\x13\x00\x00\x00\x00\x00\x00\x24\x13\x00\x00\x46\x18\xbb\x18\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7a\x15\x15\x1b\x00\x00\x00\x00\xcb\x19\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x58\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9d\x00\x23\x12\x67\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x23\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf8\x04\x00\x00\x9f\x19\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa4\x18\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9a\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x66\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x89\x19\x00\x00\xbc\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0d\x13\x00\x00\xf6\x12\x8d\x18\x00\x00\x00\x00\x00\x00\xa6\x15\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9d\x12\x00\x00\x86\x12\x00\x00\x76\x18\xdf\xff\x00\x00\x96\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6f\x12\x00\x00\x00\x00\x00\x00\xc7\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xab\xff\x00\x00\x00\x00\x00\x00\x00\x00"#

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\xfe\x00\x00\x00\x00\xf4\xff\x00\x00\x79\xff\x78\xff\x76\xff\x67\xff\x75\xff\x4b\xff\x00\x00\x4a\xff\x65\xff\x71\xff\x00\x00\xc1\xfe\x5a\xff\x53\xff\x19\xff\x4e\xff\x00\x00\x57\xff\x4f\xff\x18\xff\x51\xff\x50\xff\x59\xff\x17\xff\x52\xff\x4d\xff\x58\xff\x40\xff\x55\xff\x3f\xff\x4c\xff\x54\xff\x16\xff\x49\xff\x00\x00\x15\xff\x14\xff\x13\xff\x12\xff\x11\xff\x10\xff\x00\x00\x77\xff\x7b\xff\x6c\xfe\x00\x00\x00\x00\x00\x00\x72\xfe\x71\xfe\x6d\xfe\x6b\xfe\x7c\xff\x6a\xfe\x69\xfe\x70\xfe\xe0\xff\xdf\xff\xd7\xff\xde\xff\xc0\xff\xb4\xff\xb1\xff\xad\xff\xaa\xff\xa7\xff\xa2\xff\x9f\xff\x9d\xff\x9b\xff\x99\xff\x97\xff\x95\xff\x93\xff\x87\xff\x00\x00\x00\x00\xad\xfe\xac\xfe\xab\xfe\xaa\xfe\xa9\xfe\xa8\xfe\xa7\xfe\xea\xff\xd9\xff\xf0\xff\xef\xff\xee\xff\xed\xff\xec\xff\xeb\xff\x00\x00\x97\xfe\x91\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x4d\xfe\x00\x00\xf3\xff\xe9\xff\xe8\xff\xe7\xff\xe6\xff\xe5\xff\xe4\xff\xe3\xff\xe2\xff\xe1\xff\xda\xff\xa6\xfe\xe0\xff\xbb\xfe\x00\x00\x00\x00\xdb\xfe\x00\x00\xd8\xfe\xd7\xfe\x00\x00\x1c\xff\x00\x00\x1a\xff\x30\xff\x00\x00\x00\x00\xe3\xfe\x00\x00\x34\xff\x37\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0d\xff\x7f\xff\x63\xff\xfd\xfe\x0f\xff\xfc\xfe\x06\xff\x00\x00\x00\x00\x80\xff\x66\xfe\x7d\xff\x04\xff\x00\x00\xe7\xfe\x00\x00\xf2\xff\x00\x00\xf1\xff\x00\x00\x2b\xff\x29\xff\x00\x00\x33\xff\x30\xff\xe2\xfe\x32\xff\x00\x00\x2f\xff\x36\xff\x2d\xff\x00\x00\xf3\xfe\xf2\xfe\xfb\xfe\xd6\xfe\xc7\xfe\xcc\xfe\xd5\xfe\xcb\xfe\xf9\xfe\x00\x00\x00\x00\xda\xfe\xd9\xfe\xb6\xfe\x00\x00\x00\x00\x00\x00\xb1\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x4c\xfe\x00\x00\x00\x00\xb7\xff\x00\x00\x00\x00\x76\xfe\x77\xfe\x00\x00\x00\x00\x7d\xfe\x00\x00\x00\x00\x00\x00\x7a\xfe\x7b\xfe\xb4\xff\x83\xff\x00\x00\x78\xfe\x79\xfe\xb8\xff\xbe\xff\x00\x00\xbf\xff\xbd\xff\xb9\xff\xbc\xff\xba\xff\xbb\xff\x00\x00\x00\x00\xd1\xfe\x00\x00\x00\x00\xd2\xfe\xce\xfe\x8f\xfe\x90\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xca\xff\xc9\xff\x00\x00\xd8\xff\x00\x00\x6f\xfe\x6e\xfe\x00\x00\x82\xff\xc0\xfe\xbf\xfe\x00\x00\x56\xff\x25\xff\x00\x00\x00\x00\x70\xff\x64\xff\x48\xff\x00\x00\x00\x00\x74\xff\x6d\xff\x6b\xff\x69\xff\x66\xff\x73\xff\x6f\xff\x7a\xff\x00\x00\x95\xfe\x68\xfe\x00\x00\x94\xfe\x6e\xff\x72\xff\x68\xff\x6a\xff\x6c\xff\x00\x00\x3e\xff\x3d\xff\x47\xff\x65\xfe\x00\x00\x00\x00\x21\xff\x20\xff\x24\xff\x00\x00\x00\x00\x00\x00\x5f\xff\x61\xff\x5b\xff\x00\x00\xa5\xfe\x00\x00\xc5\xff\xc4\xff\xc3\xff\xcb\xff\xcc\xff\x00\x00\xd6\xff\x00\x00\xd4\xff\xd3\xff\x89\xff\x88\xff\x8a\xff\x8b\xff\x8c\xff\x8f\xff\x90\xff\x91\xff\x8d\xff\x8e\xff\x92\xff\xae\xff\xaf\xff\xb0\xff\xab\xff\xac\xff\xa8\xff\xa9\xff\xa3\xff\xa4\xff\xa5\xff\xa6\xff\xa0\xff\xa1\xff\x9e\xff\x9c\xff\x9a\xff\x98\xff\x96\xff\x00\x00\xcc\xfe\xcd\xfe\x00\x00\xd0\xfe\xdb\xff\xb2\xff\x00\x00\xcf\xfe\xdc\xff\xdd\xff\x9d\xfe\x9c\xfe\x96\xfe\x9f\xfe\x00\x00\xa1\xfe\x9b\xfe\x99\xfe\x98\xfe\x9a\xfe\x00\x00\x00\x00\xa3\xfe\x00\x00\x84\xff\x00\x00\x85\xff\x85\xfe\x7c\xfe\x7e\xfe\x00\x00\x74\xfe\x75\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xae\xfe\x00\x00\xb0\xfe\xb2\xfe\xb5\xfe\xb9\xfe\xba\xfe\x00\x00\x00\x00\x00\x00\xf0\xfe\xf1\xfe\x00\x00\x00\x00\x00\x00\xcc\xfe\x00\x00\xe1\xfe\xdf\xfe\x00\x00\x00\x00\xc5\xfe\xde\xfe\xc6\xfe\x00\x00\x0e\xff\xfa\xfe\xca\xfe\xf7\xfe\x00\x00\x1b\xff\x2c\xff\x2e\xff\x00\x00\x39\xff\x31\xff\x35\xff\x27\xff\x28\xff\x00\x00\x3a\xff\x38\xff\x00\x00\xe5\xfe\xe6\xfe\x00\x00\x7e\xff\x05\xff\x01\xff\x00\x00\x0a\xff\x00\x00\x00\x00\x86\xff\x62\xff\xd4\xfe\x00\x00\x00\x00\x09\xff\x00\x00\x00\x00\x00\xff\x02\xff\x03\xff\xe4\xfe\x00\x00\x26\xff\x2a\xff\x00\x00\x00\x00\xf6\xfe\x00\x00\xc3\xfe\xcc\xfe\xc8\xfe\xc9\xfe\x00\x00\xc4\xfe\x00\x00\x0b\xff\x0c\xff\x00\x00\x00\x00\xe9\xfe\x00\x00\xef\xfe\x00\x00\x00\x00\xee\xfe\xb4\xfe\x00\x00\xb7\xfe\xb8\xfe\xaf\xfe\x00\x00\x00\x00\x47\xfe\x88\xfe\x00\x00\x8a\xfe\x00\x00\xb5\xff\xb6\xff\x8c\xfe\x00\x00\x00\x00\x85\xff\x00\x00\xa4\xfe\x00\x00\xa2\xfe\x9e\xfe\x00\x00\xb3\xff\x00\x00\x00\x00\xd2\xff\xd1\xff\x00\x00\xd5\xff\xd0\xff\x00\x00\x00\x00\x5e\xff\x00\x00\xbc\xfe\xbd\xfe\xbe\xfe\x00\x00\x23\xff\x1f\xff\x00\x00\x00\x00\x3c\xff\x45\xff\x46\xff\x3b\xff\x93\xfe\x67\xfe\x92\xfe\x00\x00\x43\xff\x44\xff\x1e\xff\x1d\xff\x22\xff\x5d\xff\x00\x00\x00\x00\x00\x00\xc2\xff\xc1\xff\x94\xff\x00\x00\xa0\xfe\x00\x00\x00\x00\x00\x00\x8e\xfe\x8b\xfe\x89\xfe\x46\xfe\x00\x00\x45\xfe\x00\x00\xb3\xfe\x00\x00\xe8\xfe\xed\xfe\x00\x00\xec\xfe\xf8\xfe\xdd\xfe\xe0\xfe\xdc\xfe\xc2\xfe\xf4\xfe\x00\x00\xf5\xfe\x5f\xfe\x00\x00\x63\xfe\x61\xfe\x59\xfe\x51\xfe\x58\xfe\x4f\xfe\x5d\xfe\x50\xfe\x5a\xfe\x52\xfe\x55\xfe\x5c\xfe\x54\xfe\x53\xfe\x5e\xfe\x5b\xfe\x56\xfe\x4e\xfe\x57\xfe\xfe\xfe\xff\xfe\x07\xff\x08\xff\x00\x00\x00\x00\x00\x00\xd3\xfe\xeb\xfe\xea\xfe\xc6\xff\x00\x00\x44\xfe\x43\xfe\x00\x00\x4b\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x86\xfe\x00\x00\xc8\xff\x00\x00\x00\x00\xcf\xff\x60\xff\x5c\xff\x41\xff\x42\xff\xce\xff\xcd\xff\xc7\xff\x87\xfe\x00\x00\x82\xfe\x00\x00\x84\xfe\x00\x00\x8d\xfe\x00\x00\x00\x00\x00\x00\x45\xfe\x62\xfe\x64\xfe\x00\x00\x60\xfe\x00\x00\x4a\xfe\x42\xfe\x00\x00\x81\xfe\x83\xfe\x7f\xfe\x00\x00\x80\xfe\x41\xfe\x00\x00\x40\xfe\x00\x00\x3f\xfe\x3e\xfe\x3c\xfe\x49\xfe\x00\x00\x00\x00\x48\xfe\x3d\xfe"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x00\x00\x14\x00\x0d\x00\x0f\x00\x10\x00\x67\x00\x12\x00\x00\x00\x09\x00\x09\x00\x15\x00\x00\x00\x18\x00\x19\x00\x1a\x00\x11\x00\x09\x00\x1d\x00\x1e\x00\x00\x00\x27\x00\x00\x00\x01\x00\x23\x00\x24\x00\x25\x00\x00\x00\x00\x00\x01\x00\x0c\x00\x21\x00\x65\x00\x66\x00\x67\x00\x11\x00\x2e\x00\x11\x00\x12\x00\x09\x00\x09\x00\x0b\x00\x09\x00\x0d\x00\x11\x00\x12\x00\x39\x00\x3a\x00\x3b\x00\x3c\x00\x3d\x00\x3e\x00\x3f\x00\x40\x00\x41\x00\x64\x00\x43\x00\x44\x00\x45\x00\x46\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x5a\x00\x09\x00\x09\x00\x0a\x00\x5e\x00\x09\x00\x0a\x00\x61\x00\x62\x00\x63\x00\x5b\x00\x00\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x6d\x00\x6d\x00\x7a\x00\x7b\x00\x65\x00\x5c\x00\x5d\x00\x5e\x00\x6d\x00\x5a\x00\x5b\x00\x83\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x8b\x00\x6d\x00\x6d\x00\x00\x00\x6d\x00\x13\x00\x12\x00\x00\x00\x39\x00\x09\x00\x0a\x00\x0b\x00\x18\x00\x19\x00\x1a\x00\x0c\x00\x39\x00\x1d\x00\x1e\x00\x7e\x00\x7f\x00\x7e\x00\x7f\x00\x23\x00\x24\x00\x25\x00\x1a\x00\x00\x00\x01\x00\x5f\x00\x09\x00\x0a\x00\x0b\x00\x09\x00\x0a\x00\x0b\x00\x5b\x00\x0c\x00\x00\x00\x01\x00\x13\x00\x30\x00\x6d\x00\x6d\x00\x13\x00\x39\x00\x6d\x00\x1a\x00\x3c\x00\x3d\x00\x1a\x00\x3a\x00\x3b\x00\x41\x00\x2f\x00\x43\x00\x44\x00\x45\x00\x00\x00\x7e\x00\x00\x00\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\x30\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x39\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x12\x00\x00\x00\x01\x00\x5f\x00\x43\x00\x09\x00\x0a\x00\x61\x00\x62\x00\x63\x00\x00\x00\x0f\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x32\x00\x6d\x00\x7a\x00\x00\x00\x09\x00\x0a\x00\x0b\x00\x39\x00\x0d\x00\x5a\x00\x5b\x00\x5f\x00\x0b\x00\x0a\x00\x0d\x00\x87\x00\x88\x00\x43\x00\x0f\x00\x00\x00\x11\x00\x12\x00\x6d\x00\x5d\x00\x5e\x00\x6d\x00\x2e\x00\x2f\x00\x09\x00\x0a\x00\x0b\x00\x09\x00\x0a\x00\x0b\x00\x09\x00\x0a\x00\x0b\x00\x12\x00\x0d\x00\x00\x00\x01\x00\x13\x00\x09\x00\x0a\x00\x0b\x00\x1a\x00\x09\x00\x0a\x00\x1a\x00\x2e\x00\x00\x00\x1a\x00\x0f\x00\x00\x00\x00\x00\x01\x00\x09\x00\x0a\x00\x0b\x00\x1a\x00\x39\x00\x5f\x00\x5b\x00\x3c\x00\x3d\x00\x0c\x00\x10\x00\x11\x00\x41\x00\x00\x00\x43\x00\x44\x00\x45\x00\x1a\x00\x39\x00\x6d\x00\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\x00\x00\x4f\x00\x50\x00\x00\x00\x52\x00\x53\x00\x39\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x00\x00\x0a\x00\x00\x00\x01\x00\x5e\x00\x5f\x00\x12\x00\x10\x00\x62\x00\x63\x00\x39\x00\x6d\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\x2b\x00\x2c\x00\x5f\x00\x09\x00\x0a\x00\x0b\x00\x31\x00\x32\x00\x33\x00\x34\x00\x35\x00\x00\x00\x00\x00\x7a\x00\x7b\x00\x3a\x00\x6d\x00\x61\x00\x5b\x00\x6d\x00\x5f\x00\x00\x00\x6d\x00\x00\x00\x21\x00\x00\x00\x87\x00\x88\x00\x11\x00\x12\x00\x6d\x00\x32\x00\x3c\x00\x3d\x00\x6d\x00\x00\x00\x37\x00\x41\x00\x39\x00\x43\x00\x30\x00\x45\x00\x5a\x00\x5b\x00\x6d\x00\x49\x00\x4a\x00\x4b\x00\x43\x00\x4d\x00\x3a\x00\x4f\x00\x50\x00\x00\x00\x00\x00\x53\x00\x39\x00\x2e\x00\x56\x00\x57\x00\x58\x00\x59\x00\x32\x00\x0a\x00\x34\x00\x00\x00\x49\x00\x2e\x00\x2f\x00\x10\x00\x62\x00\x63\x00\x2f\x00\x39\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\x5a\x00\x5b\x00\x12\x00\x31\x00\x32\x00\x00\x00\x0c\x00\x30\x00\x36\x00\x37\x00\x38\x00\x39\x00\x3a\x00\x13\x00\x1f\x00\x7c\x00\x7d\x00\x0c\x00\x23\x00\x02\x00\x42\x00\x43\x00\x6d\x00\x32\x00\x5e\x00\x5f\x00\x87\x00\x88\x00\x37\x00\x0c\x00\x39\x00\x30\x00\x3c\x00\x3d\x00\x00\x00\x39\x00\x13\x00\x41\x00\x0c\x00\x43\x00\x43\x00\x45\x00\x0b\x00\x11\x00\x0d\x00\x49\x00\x4a\x00\x4b\x00\x39\x00\x4d\x00\x00\x00\x4f\x00\x50\x00\x00\x00\x00\x00\x53\x00\x5f\x00\x1a\x00\x56\x00\x57\x00\x58\x00\x59\x00\x0c\x00\x0a\x00\x00\x00\x01\x00\x20\x00\x11\x00\x22\x00\x10\x00\x62\x00\x63\x00\x39\x00\x3a\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\x42\x00\x43\x00\x31\x00\x32\x00\x33\x00\x34\x00\x35\x00\x00\x00\x00\x00\x0c\x00\x0b\x00\x3a\x00\x0d\x00\x1f\x00\x11\x00\x7c\x00\x7d\x00\x23\x00\x30\x00\x0c\x00\x15\x00\x16\x00\x31\x00\x32\x00\x33\x00\x34\x00\x87\x00\x88\x00\x4f\x00\x3b\x00\x30\x00\x3a\x00\x3c\x00\x3d\x00\x23\x00\x24\x00\x1f\x00\x41\x00\x00\x00\x43\x00\x23\x00\x45\x00\x12\x00\x5a\x00\x5b\x00\x49\x00\x4a\x00\x4b\x00\x02\x00\x4d\x00\x1f\x00\x4f\x00\x50\x00\x30\x00\x23\x00\x53\x00\x11\x00\x00\x00\x56\x00\x57\x00\x58\x00\x59\x00\x30\x00\x0c\x00\x00\x00\x10\x00\x11\x00\x30\x00\x11\x00\x0c\x00\x62\x00\x63\x00\x0c\x00\x3b\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x24\x00\x25\x00\x26\x00\x0f\x00\x7c\x00\x7d\x00\x12\x00\x64\x00\x00\x00\x2d\x00\x10\x00\x11\x00\x18\x00\x19\x00\x1a\x00\x87\x00\x88\x00\x1d\x00\x1e\x00\x00\x00\x0c\x00\x31\x00\x32\x00\x23\x00\x24\x00\x25\x00\x36\x00\x37\x00\x38\x00\x39\x00\x3a\x00\x0c\x00\x44\x00\x39\x00\x3a\x00\x0c\x00\x11\x00\x02\x00\x42\x00\x43\x00\x11\x00\x0e\x00\x42\x00\x43\x00\x11\x00\x39\x00\x3a\x00\x3b\x00\x3c\x00\x3d\x00\x3e\x00\x3f\x00\x40\x00\x41\x00\x12\x00\x43\x00\x44\x00\x45\x00\x46\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x5a\x00\x39\x00\x3a\x00\x0b\x00\x5e\x00\x0d\x00\x02\x00\x61\x00\x62\x00\x63\x00\x42\x00\x43\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x12\x00\x0c\x00\x7a\x00\x7b\x00\x0c\x00\x00\x00\x11\x00\x0b\x00\x0b\x00\x11\x00\x0d\x00\x83\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x62\x00\x63\x00\x64\x00\x0f\x00\x62\x00\x63\x00\x64\x00\x24\x00\x25\x00\x26\x00\x28\x00\x29\x00\x18\x00\x19\x00\x1a\x00\x02\x00\x2d\x00\x1d\x00\x1e\x00\x30\x00\x2b\x00\x2c\x00\x12\x00\x23\x00\x24\x00\x25\x00\x31\x00\x32\x00\x33\x00\x34\x00\x35\x00\x00\x00\x0b\x00\x00\x00\x0d\x00\x3a\x00\x1e\x00\x11\x00\x0b\x00\x44\x00\x0d\x00\x23\x00\x24\x00\x25\x00\x26\x00\x0c\x00\x0c\x00\x00\x00\x3c\x00\x3d\x00\x11\x00\x2d\x00\x0b\x00\x41\x00\x30\x00\x43\x00\x11\x00\x45\x00\x13\x00\x0c\x00\x0e\x00\x49\x00\x4a\x00\x4b\x00\x11\x00\x4d\x00\x0e\x00\x4f\x00\x50\x00\x51\x00\x0b\x00\x53\x00\x0d\x00\x0c\x00\x56\x00\x57\x00\x58\x00\x59\x00\x21\x00\x22\x00\x31\x00\x32\x00\x33\x00\x34\x00\x35\x00\x61\x00\x62\x00\x63\x00\x02\x00\x3a\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0b\x00\x1e\x00\x0d\x00\x1a\x00\x87\x00\x88\x00\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\x12\x00\x18\x00\x19\x00\x1a\x00\x42\x00\x2d\x00\x1d\x00\x1e\x00\x30\x00\x18\x00\x19\x00\x0c\x00\x23\x00\x24\x00\x25\x00\x12\x00\x11\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x29\x00\x0b\x00\x00\x00\x0d\x00\x2d\x00\x3d\x00\x0c\x00\x30\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x5e\x00\x5f\x00\x0c\x00\x3c\x00\x3d\x00\x49\x00\x3b\x00\x11\x00\x41\x00\x4d\x00\x43\x00\x0b\x00\x45\x00\x0d\x00\x02\x00\x44\x00\x49\x00\x4a\x00\x4b\x00\x0b\x00\x4d\x00\x59\x00\x4f\x00\x50\x00\x51\x00\x10\x00\x53\x00\x10\x00\x11\x00\x56\x00\x57\x00\x58\x00\x59\x00\x0f\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x61\x00\x62\x00\x63\x00\x11\x00\x12\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x00\x00\x0b\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x87\x00\x88\x00\x12\x00\x11\x00\x12\x00\x00\x00\x0c\x00\x12\x00\x18\x00\x19\x00\x1a\x00\x11\x00\x0f\x00\x1d\x00\x1e\x00\x28\x00\x29\x00\x0c\x00\x0e\x00\x23\x00\x24\x00\x25\x00\x11\x00\x1b\x00\x1c\x00\x1d\x00\x0e\x00\x1f\x00\x1a\x00\x1b\x00\x1c\x00\x23\x00\x24\x00\x25\x00\x26\x00\x0c\x00\x21\x00\x22\x00\x18\x00\x19\x00\x0c\x00\x2d\x00\x3a\x00\x3b\x00\x30\x00\x1e\x00\x3e\x00\x3f\x00\x40\x00\x0c\x00\x23\x00\x24\x00\x25\x00\x26\x00\x46\x00\x47\x00\x48\x00\x0c\x00\x11\x00\x0b\x00\x2d\x00\x5f\x00\x4e\x00\x30\x00\x44\x00\x51\x00\x11\x00\x0c\x00\x54\x00\x11\x00\x24\x00\x25\x00\x26\x00\x0e\x00\x5a\x00\x0e\x00\x2a\x00\x02\x00\x5e\x00\x2d\x00\x12\x00\x61\x00\x30\x00\x11\x00\x0b\x00\x59\x00\x0c\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x10\x00\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x1a\x00\x26\x00\x11\x00\x0b\x00\x1f\x00\x2e\x00\x00\x00\x20\x00\x02\x00\x03\x00\x04\x00\x05\x00\x1e\x00\x85\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x0c\x00\x0f\x00\x0f\x00\x39\x00\x0f\x00\x0c\x00\x3c\x00\x3d\x00\x5a\x00\x00\x00\x13\x00\x41\x00\x0b\x00\x43\x00\x44\x00\x45\x00\x12\x00\x0b\x00\x8b\x00\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\x11\x00\x4f\x00\x50\x00\x2e\x00\x52\x00\x53\x00\x0b\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x8b\x00\x09\x00\x0a\x00\x59\x00\x0c\x00\x20\x00\x0b\x00\x22\x00\x62\x00\x63\x00\x0b\x00\x45\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\x6d\x00\x0b\x00\x0b\x00\x31\x00\x32\x00\x33\x00\x34\x00\x35\x00\x13\x00\x8b\x00\x26\x00\x20\x00\x3a\x00\x5a\x00\x5b\x00\x1f\x00\x1e\x00\x1e\x00\x02\x00\x13\x00\x8b\x00\x12\x00\x23\x00\x24\x00\x25\x00\x26\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x39\x00\x0b\x00\x2d\x00\x3c\x00\x3d\x00\x30\x00\x02\x00\x8b\x00\x41\x00\x09\x00\x43\x00\x44\x00\x45\x00\xff\xff\x5a\x00\x5b\x00\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\xff\xff\x4f\x00\x50\x00\xff\xff\x52\x00\x53\x00\xff\xff\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\xff\xff\x09\x00\x0a\x00\xff\xff\x0c\x00\xff\xff\xff\xff\xff\xff\x62\x00\x63\x00\xff\xff\xff\xff\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\x6d\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\xff\xff\xff\xff\xff\xff\x87\x00\x88\x00\x89\x00\x8a\x00\x39\x00\xff\xff\xff\xff\x3c\x00\x3d\x00\xff\xff\xff\xff\xff\xff\x41\x00\xff\xff\x43\x00\x44\x00\x45\x00\xff\xff\xff\xff\xff\xff\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\xff\xff\x4f\x00\x50\x00\xff\xff\x52\x00\x53\x00\xff\xff\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\xff\xff\x09\x00\x0a\x00\xff\xff\x0c\x00\xff\xff\xff\xff\x45\x00\x62\x00\x63\x00\xff\xff\xff\xff\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\x6d\x00\xff\xff\xff\xff\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\x5b\x00\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x39\x00\xff\xff\xff\xff\x3c\x00\x3d\x00\xff\xff\xff\xff\xff\xff\x41\x00\xff\xff\x43\x00\x44\x00\x45\x00\xff\xff\xff\xff\xff\xff\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\xff\xff\x4f\x00\x50\x00\xff\xff\x52\x00\x53\x00\xff\xff\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\xff\xff\xff\xff\xff\xff\xff\xff\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x62\x00\x63\x00\x45\x00\xff\xff\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\x6d\x00\x1a\x00\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\xff\xff\x87\x00\x88\x00\x89\x00\x8a\x00\xff\xff\xff\xff\x39\x00\xff\xff\xff\xff\x3c\x00\x3d\x00\xff\xff\xff\xff\xff\xff\x41\x00\xff\xff\x43\x00\x44\x00\x45\x00\xff\xff\xff\xff\xff\xff\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\xff\xff\x4f\x00\x50\x00\xff\xff\x52\x00\x53\x00\xff\xff\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x0a\x00\x45\x00\x62\x00\x63\x00\xff\xff\xff\xff\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\x17\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\xff\xff\xff\xff\xff\xff\x87\x00\x88\x00\x89\x00\x8a\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\xff\xff\xff\xff\x3c\x00\x3d\x00\xff\xff\x00\x00\xff\xff\x41\x00\xff\xff\x43\x00\x44\x00\x45\x00\xff\xff\xff\xff\xff\xff\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\xff\xff\x4f\x00\x50\x00\xff\xff\x52\x00\x53\x00\xff\xff\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\xff\xff\xff\xff\x0a\x00\x45\x00\x0c\x00\x20\x00\xff\xff\x22\x00\x62\x00\x63\x00\xff\xff\xff\xff\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\xff\xff\xff\xff\xff\xff\x31\x00\x32\x00\x33\x00\x34\x00\x35\x00\xff\xff\xff\xff\xff\xff\x00\x00\x3a\x00\x02\x00\x03\x00\x04\x00\x05\x00\x1e\x00\xff\xff\x08\x00\x09\x00\x0a\x00\x23\x00\x24\x00\x25\x00\x26\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x39\x00\xff\xff\x2d\x00\x3c\x00\x3d\x00\x30\x00\xff\xff\xff\xff\x41\x00\xff\xff\x43\x00\x44\x00\x45\x00\xff\xff\xff\xff\x5b\x00\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\xff\xff\x4f\x00\x50\x00\xff\xff\x52\x00\x53\x00\x00\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\xff\xff\xff\xff\x0a\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x62\x00\x63\x00\xff\xff\xff\xff\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\xff\xff\xff\xff\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\x2d\x00\xff\xff\x08\x00\x30\x00\xff\xff\xff\xff\x87\x00\x88\x00\x89\x00\x8a\x00\x39\x00\xff\xff\xff\xff\x3c\x00\x3d\x00\x3c\x00\x3d\x00\x3e\x00\x41\x00\x40\x00\x43\x00\x44\x00\x45\x00\x44\x00\xff\xff\xff\xff\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\xff\xff\x4f\x00\x50\x00\xff\xff\x52\x00\x53\x00\xff\xff\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\xff\xff\x0a\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\x62\x00\x63\x00\x08\x00\x09\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\x2d\x00\xff\xff\x08\x00\x30\x00\xff\xff\xff\xff\x87\x00\x88\x00\x89\x00\x39\x00\xff\xff\xff\xff\x3c\x00\x3d\x00\xff\xff\x00\x00\xff\xff\x41\x00\xff\xff\x43\x00\x44\x00\x45\x00\xff\xff\x44\x00\xff\xff\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\xff\xff\x4f\x00\x50\x00\xff\xff\x52\x00\x53\x00\xff\xff\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x0a\x00\x58\x00\x59\x00\xff\xff\xff\xff\xff\xff\xff\xff\x22\x00\x62\x00\x63\x00\xff\xff\xff\xff\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\xff\xff\xff\xff\xff\xff\x31\x00\x32\x00\x33\x00\x34\x00\x35\x00\xff\xff\xff\xff\xff\xff\x78\x00\x3a\x00\x7a\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x80\x00\x81\x00\x82\x00\xff\xff\xff\xff\xff\xff\xff\xff\x87\x00\x88\x00\x39\x00\xff\xff\xff\xff\x3c\x00\x3d\x00\xff\xff\xff\xff\xff\xff\x41\x00\x00\x00\x43\x00\x44\x00\x45\x00\xff\xff\xff\xff\xff\xff\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\xff\xff\x4f\x00\x50\x00\xff\xff\x52\x00\x53\x00\xff\xff\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x0a\x00\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\x62\x00\x63\x00\x08\x00\x09\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\xff\xff\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\x31\x00\x32\x00\x33\x00\x34\x00\x35\x00\x78\x00\xff\xff\x7a\x00\xff\xff\x3a\x00\xff\xff\xff\xff\xff\xff\x80\x00\x81\x00\x82\x00\xff\xff\xff\xff\xff\xff\xff\xff\x87\x00\x88\x00\x39\x00\xff\xff\xff\xff\x3c\x00\x3d\x00\xff\xff\xff\xff\xff\xff\x41\x00\xff\xff\x43\x00\x44\x00\x45\x00\xff\xff\xff\xff\xff\xff\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\xff\xff\x4f\x00\x50\x00\xff\xff\x52\x00\x53\x00\xff\xff\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x0a\x00\xff\xff\xff\xff\xff\xff\xff\xff\x0f\x00\xff\xff\xff\xff\x62\x00\x63\x00\xff\xff\xff\xff\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\x24\x00\x25\x00\x26\x00\xff\xff\xff\xff\xff\xff\x2a\x00\xff\xff\xff\xff\x2d\x00\xff\xff\x78\x00\x30\x00\x7a\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x80\x00\x81\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x87\x00\x88\x00\x39\x00\xff\xff\xff\xff\x3c\x00\x3d\x00\xff\xff\xff\xff\xff\xff\x41\x00\xff\xff\x43\x00\x44\x00\x45\x00\xff\xff\xff\xff\xff\xff\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\xff\xff\x4f\x00\x50\x00\xff\xff\x52\x00\x53\x00\x3d\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x0a\x00\xff\xff\xff\xff\xff\xff\xff\xff\x0f\x00\x49\x00\xff\xff\x62\x00\x63\x00\x4d\x00\xff\xff\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\xff\xff\xff\xff\x00\x00\x59\x00\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x7a\x00\x7b\x00\xff\xff\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\xff\xff\xff\xff\xff\xff\xff\xff\x87\x00\x88\x00\x39\x00\xff\xff\xff\xff\x3c\x00\x3d\x00\xff\xff\xff\xff\xff\xff\x41\x00\xff\xff\x43\x00\x44\x00\x45\x00\xff\xff\xff\xff\xff\xff\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\xff\xff\x4f\x00\x50\x00\xff\xff\x52\x00\x53\x00\xff\xff\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x0a\x00\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\x62\x00\x63\x00\x08\x00\x09\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\x26\x00\xff\xff\x7a\x00\x7b\x00\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\xff\xff\xff\xff\xff\xff\xff\xff\x87\x00\x88\x00\x39\x00\xff\xff\xff\xff\x3c\x00\x3d\x00\x3c\x00\x3d\x00\x3e\x00\x41\x00\xff\xff\x43\x00\x44\x00\x45\x00\x44\x00\xff\xff\xff\xff\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\xff\xff\x4f\x00\x50\x00\xff\xff\x52\x00\x53\x00\xff\xff\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x0a\x00\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\x62\x00\x63\x00\x08\x00\x09\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\xff\xff\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\x26\x00\x7a\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\xff\xff\xff\xff\xff\xff\x87\x00\x88\x00\x39\x00\xff\xff\xff\xff\x3c\x00\x3d\x00\xff\xff\xff\xff\x0a\x00\x41\x00\x3f\x00\x43\x00\x44\x00\x45\x00\xff\xff\x44\x00\xff\xff\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\xff\xff\x4f\x00\x50\x00\xff\xff\x52\x00\x53\x00\xff\xff\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\xff\xff\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\x62\x00\x63\x00\x08\x00\x09\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x3c\x00\x3d\x00\xff\xff\xff\xff\x0a\x00\x41\x00\xff\xff\x43\x00\xff\xff\x45\x00\xff\xff\xff\xff\xff\xff\x49\x00\x4a\x00\x4b\x00\xff\xff\x4d\x00\xff\xff\x4f\x00\x50\x00\x87\x00\x88\x00\x53\x00\xff\xff\xff\xff\x56\x00\x57\x00\x58\x00\x59\x00\xff\xff\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\x62\x00\x63\x00\x08\x00\x09\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x3c\x00\x3d\x00\xff\xff\xff\xff\x0a\x00\x41\x00\xff\xff\x43\x00\xff\xff\x45\x00\x7c\x00\x7d\x00\xff\xff\x49\x00\x4a\x00\x4b\x00\xff\xff\x4d\x00\xff\xff\x4f\x00\x50\x00\x87\x00\x88\x00\x53\x00\xff\xff\xff\xff\x56\x00\x57\x00\x58\x00\x59\x00\xff\xff\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\x62\x00\x63\x00\x08\x00\x09\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x3c\x00\xff\xff\xff\xff\xff\xff\xff\xff\x41\x00\xff\xff\x43\x00\xff\xff\x45\x00\x7c\x00\xff\xff\xff\xff\xff\xff\x4a\x00\x4b\x00\xff\xff\xff\xff\xff\xff\x4f\x00\x50\x00\x87\x00\x88\x00\x53\x00\xff\xff\xff\xff\x56\x00\x57\x00\x58\x00\xff\xff\xff\xff\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\x62\x00\x63\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x6c\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\x0c\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x18\x00\x19\x00\x1a\x00\x88\x00\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\x0c\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\xff\xff\xff\xff\x51\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\x61\x00\x02\x00\x03\x00\x04\x00\x05\x00\x2d\x00\xff\xff\x08\x00\x30\x00\xff\xff\xff\xff\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x51\x00\x79\x00\xff\xff\xff\xff\xff\xff\x44\x00\xff\xff\xff\xff\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x61\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x56\x00\x57\x00\x58\x00\x59\x00\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\xff\xff\x79\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x00\x00\x0b\x00\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x00\x00\x0b\x00\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\xff\xff\xff\xff\x51\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\x26\x00\xff\xff\x61\x00\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\xff\xff\xff\xff\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x51\x00\x79\x00\xff\xff\xff\xff\xff\xff\x44\x00\xff\xff\xff\xff\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x61\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\xff\xff\x58\x00\x59\x00\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\xff\xff\x79\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x00\x00\x0b\x00\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\xff\xff\x00\x00\x0e\x00\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\x51\x00\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x61\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x3d\x00\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x49\x00\x79\x00\xff\xff\xff\xff\x4d\x00\xff\xff\xff\xff\xff\xff\x51\x00\x52\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\x59\x00\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\xff\xff\x61\x00\xff\xff\xff\xff\xff\xff\xff\xff\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\xff\xff\x0d\x00\xff\xff\x0f\x00\x10\x00\xff\xff\xff\xff\xff\xff\xff\xff\x15\x00\xff\xff\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\x0c\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\xff\xff\xff\xff\x51\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\x26\x00\xff\xff\x61\x00\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\xff\xff\xff\xff\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x51\x00\xff\xff\xff\xff\xff\xff\xff\xff\x44\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x4c\x00\x08\x00\x09\x00\x61\x00\xff\xff\x51\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\x12\x00\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x00\x00\x0b\x00\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\xff\xff\xff\xff\x51\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\x26\x00\xff\xff\x61\x00\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\xff\xff\xff\xff\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x51\x00\xff\xff\xff\xff\xff\xff\xff\xff\x44\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x4c\x00\xff\xff\x00\x00\x61\x00\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\xff\xff\xff\xff\x0e\x00\xff\xff\xff\xff\xff\xff\x00\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x29\x00\x1b\x00\x1c\x00\x1d\x00\x2d\x00\x1f\x00\xff\xff\x30\x00\xff\xff\x23\x00\x24\x00\x25\x00\x26\x00\xff\xff\xff\xff\xff\xff\xff\xff\x3d\x00\x3b\x00\x2d\x00\xff\xff\xff\xff\x30\x00\x31\x00\x32\x00\xff\xff\xff\xff\x44\x00\xff\xff\x49\x00\xff\xff\x39\x00\x3a\x00\x4d\x00\x3c\x00\x3d\x00\x3e\x00\x51\x00\x52\x00\xff\xff\x42\x00\x43\x00\x44\x00\xff\xff\xff\xff\x59\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x61\x00\xff\xff\xff\xff\xff\xff\xff\xff\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\xff\xff\x0d\x00\xff\xff\x0f\x00\x10\x00\xff\xff\xff\xff\xff\xff\xff\xff\x15\x00\x3d\x00\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\x49\x00\x23\x00\x24\x00\x25\x00\x4d\x00\xff\xff\xff\xff\xff\xff\x51\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x59\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x61\x00\xff\xff\xff\xff\xff\xff\xff\xff\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x51\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x61\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\xff\xff\x0d\x00\xff\xff\x0f\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x15\x00\xff\xff\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\xff\xff\xff\xff\xff\xff\x0f\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\xff\xff\xff\xff\x51\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\x26\x00\xff\xff\x61\x00\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\xff\xff\xff\xff\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x51\x00\xff\xff\xff\xff\xff\xff\xff\xff\x44\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x5f\x00\xff\xff\x61\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\x0c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\xff\xff\xff\xff\xff\xff\x0f\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\xff\xff\xff\xff\x51\x00\xff\xff\xff\xff\xff\xff\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\x26\x00\x61\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\xff\xff\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x51\x00\x3f\x00\xff\xff\xff\xff\xff\xff\xff\xff\x44\x00\xff\xff\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x61\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\xff\xff\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\xff\xff\xff\xff\x0e\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\xff\xff\xff\xff\x0e\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\xff\xff\xff\xff\x51\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x61\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x51\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x61\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\xff\xff\xff\xff\xff\xff\x0f\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\xff\xff\xff\xff\xff\xff\x0f\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\xff\xff\xff\xff\x51\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x61\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x51\x00\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\x61\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\xff\xff\xff\xff\x51\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x61\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x51\x00\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\x61\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\xff\xff\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\xff\xff\xff\xff\xff\xff\x51\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x61\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x51\x00\x18\x00\x19\x00\x1a\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\xff\xff\x61\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x09\x00\x0a\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x51\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\xff\xff\x61\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x0a\x00\xff\xff\xff\xff\xff\xff\xff\xff\x6d\x00\x6e\x00\x6f\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x76\x00\x77\x00\x39\x00\xff\xff\x30\x00\x3c\x00\x3d\x00\xff\xff\xff\xff\xff\xff\x41\x00\xff\xff\xff\xff\x44\x00\x45\x00\x3b\x00\xff\xff\xff\xff\x49\x00\x4a\x00\x4b\x00\x4c\x00\xff\xff\xff\xff\x4f\x00\x50\x00\xff\xff\x52\x00\xff\xff\xff\xff\x55\x00\xff\xff\x57\x00\x58\x00\x59\x00\xff\xff\x3c\x00\x3d\x00\xff\xff\xff\xff\xff\xff\x41\x00\xff\xff\x43\x00\xff\xff\x45\x00\xff\xff\xff\xff\xff\xff\x49\x00\x4a\x00\x4b\x00\xff\xff\x4d\x00\x6d\x00\x4f\x00\x50\x00\xff\xff\xff\xff\x53\x00\xff\xff\xff\xff\x56\x00\x57\x00\x58\x00\x59\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x62\x00\x63\x00\xff\xff\xff\xff\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x6c\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\xff\xff\xff\xff\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\x26\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x29\x00\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x44\x00\xff\xff\xff\xff\xff\xff\x3b\x00\xff\xff\x4a\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\xff\xff\x50\x00\x44\x00\x52\x00\x53\x00\x54\x00\x55\x00\xff\xff\xff\xff\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x60\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\xff\xff\xff\xff\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\x26\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\x24\x00\x25\x00\x26\x00\xff\xff\x28\x00\x29\x00\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x44\x00\xff\xff\xff\xff\xff\xff\x3b\x00\xff\xff\x4a\x00\x4b\x00\x4c\x00\xff\xff\x4e\x00\xff\xff\x50\x00\x44\x00\x52\x00\x53\x00\x54\x00\x55\x00\xff\xff\xff\xff\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x60\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\x4a\x00\x4b\x00\x4c\x00\x23\x00\x24\x00\x25\x00\x26\x00\xff\xff\x52\x00\x53\x00\x54\x00\x55\x00\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x60\x00\x4a\x00\x4b\x00\x4c\x00\xff\xff\xff\xff\xff\xff\xff\xff\x3e\x00\x52\x00\x53\x00\x54\x00\x55\x00\xff\xff\x44\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x60\x00\x4a\x00\x4b\x00\x4c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x52\x00\x53\x00\x54\x00\x55\x00\xff\xff\xff\xff\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x60\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\x4a\x00\x4b\x00\x4c\x00\x23\x00\x24\x00\x25\x00\x26\x00\xff\xff\x52\x00\x53\x00\x54\x00\x55\x00\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x60\x00\x4a\x00\x4b\x00\x4c\x00\xff\xff\xff\xff\xff\xff\xff\xff\x3e\x00\x52\x00\x53\x00\x54\x00\x55\x00\xff\xff\x44\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x60\x00\x4a\x00\x4b\x00\x4c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x52\x00\x53\x00\x54\x00\x55\x00\xff\xff\xff\xff\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x60\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x4a\x00\x4b\x00\x4c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x52\x00\x53\x00\x54\x00\x55\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x60\x00\x4a\x00\x4b\x00\x4c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x52\x00\x53\x00\x54\x00\x55\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x60\x00\x4a\x00\x4b\x00\x4c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x52\x00\x53\x00\x54\x00\x55\x00\xff\xff\xff\xff\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x60\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x4a\x00\x4b\x00\x4c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x52\x00\x53\x00\x54\x00\x55\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x60\x00\x4a\x00\x4b\x00\x4c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x52\x00\x53\x00\x54\x00\x55\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x60\x00\x4a\x00\x4b\x00\x4c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x52\x00\x53\x00\x54\x00\x55\x00\xff\xff\xff\xff\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x60\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x24\x00\x25\x00\x26\x00\xff\xff\x28\x00\x29\x00\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\x24\x00\x25\x00\x26\x00\xff\xff\xff\xff\x29\x00\x4a\x00\x4b\x00\x4c\x00\x2d\x00\x3b\x00\xff\xff\x30\x00\xff\xff\x52\x00\x53\x00\x54\x00\x55\x00\xff\xff\x44\x00\xff\xff\xff\xff\xff\xff\x3b\x00\xff\xff\xff\xff\xff\xff\xff\xff\x60\x00\x41\x00\xff\xff\xff\xff\x44\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x4c\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x24\x00\x25\x00\x26\x00\xff\xff\xff\xff\x29\x00\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\x24\x00\x25\x00\x26\x00\xff\xff\xff\xff\x29\x00\xff\xff\xff\xff\xff\xff\x2d\x00\x3b\x00\xff\xff\x30\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x44\x00\xff\xff\xff\xff\xff\xff\x3b\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x41\x00\xff\xff\xff\xff\x44\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x4c\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x24\x00\x25\x00\x26\x00\xff\xff\xff\xff\x29\x00\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\x24\x00\x25\x00\x26\x00\xff\xff\xff\xff\x29\x00\xff\xff\xff\xff\xff\xff\x2d\x00\x3b\x00\xff\xff\x30\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x44\x00\xff\xff\xff\xff\xff\xff\x3b\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x41\x00\xff\xff\xff\xff\x44\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x4c\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\xff\xff\xff\xff\xff\xff\x45\x00\x46\x00\x47\x00\x48\x00\x49\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x45\x00\x46\x00\x47\x00\x48\x00\x49\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x45\x00\xff\xff\x47\x00\x48\x00\x49\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x00\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\x26\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\xff\xff\xff\xff\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\x26\x00\xff\xff\xff\xff\xff\xff\x00\x00\xff\xff\x44\x00\x2d\x00\xff\xff\xff\xff\x30\x00\x31\x00\x32\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x3a\x00\xff\xff\x3c\x00\x3d\x00\x3e\x00\xff\xff\xff\xff\xff\xff\x42\x00\x43\x00\x44\x00\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\x26\x00\xff\xff\xff\xff\xff\xff\x00\x00\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x3c\x00\x3d\x00\x3e\x00\xff\xff\x40\x00\xff\xff\xff\xff\xff\xff\x44\x00\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\x2d\x00\xff\xff\x08\x00\x30\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x3c\x00\x3d\x00\x3e\x00\xff\xff\x40\x00\xff\xff\xff\xff\xff\xff\x44\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x24\x00\x25\x00\x26\x00\xff\xff\xff\xff\x29\x00\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\xff\xff\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\xff\xff\x21\x00\x3b\x00\x23\x00\x24\x00\x25\x00\x26\x00\xff\xff\x41\x00\xff\xff\xff\xff\x44\x00\xff\xff\x2d\x00\xff\xff\x00\x00\x30\x00\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x44\x00\xff\xff\xff\xff\x18\x00\xff\xff\xff\xff\xff\xff\xff\xff\x4c\x00\xff\xff\xff\xff\xff\xff\xff\xff\x51\x00\xff\xff\xff\xff\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\x5a\x00\x5b\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\xff\xff\xff\xff\x39\x00\xff\xff\xff\xff\x3c\x00\x3d\x00\xff\xff\xff\xff\xff\xff\x41\x00\xff\xff\x43\x00\x44\x00\x45\x00\xff\xff\xff\xff\xff\xff\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\xff\xff\x4f\x00\x50\x00\x30\x00\x52\x00\x53\x00\xff\xff\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\xff\xff\xff\xff\x3b\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x62\x00\xff\xff\xff\xff\x3d\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x44\x00\xff\xff\xff\xff\xff\xff\xff\xff\x49\x00\xff\xff\xff\xff\x4c\x00\x4d\x00\xff\xff\xff\xff\xff\xff\xff\xff\x52\x00\xff\xff\xff\xff\x55\x00\xff\xff\xff\xff\xff\xff\x59\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\xff\xff\x3c\x00\x3d\x00\xff\xff\x30\x00\xff\xff\x41\x00\xff\xff\x43\x00\xff\xff\x45\x00\xff\xff\xff\xff\xff\xff\x49\x00\x4a\x00\x4b\x00\xff\xff\x4d\x00\xff\xff\x4f\x00\x50\x00\xff\xff\xff\xff\x53\x00\xff\xff\x30\x00\x56\x00\x57\x00\x58\x00\x59\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x62\x00\xff\xff\xff\xff\xff\xff\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x6b\x00\x1b\x00\x1c\x00\x1d\x00\xff\xff\x1f\x00\xff\xff\xff\xff\xff\xff\x23\x00\x24\x00\x25\x00\x26\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\x30\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x3a\x00\xff\xff\x3c\x00\x3d\x00\x3e\x00\xff\xff\xff\xff\xff\xff\x42\x00\x43\x00\x44\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\xff\xff\xff\xff\x00\x00\x18\x00\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\xff\xff\xff\xff\x00\x00\x18\x00\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\xff\xff\xff\xff\x00\x00\x18\x00\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\xff\xff\xff\xff\x00\x00\x18\x00\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x07\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x07\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\x07\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x00\x00\xff\xff\x02\x00\x03\x00\x04\x00\x05\x00\xff\xff\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x9a\x01\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x1a\x00\x6b\x00\xea\x00\x07\x01\xdc\x00\x6c\x00\x96\xfe\xbc\x02\x6d\x00\x33\x01\x0d\x00\x0d\x00\xdd\x00\x29\x02\x6e\x00\x6f\x00\x70\x00\xa9\x00\x0d\x00\x71\x00\x72\x00\xaa\x01\x08\x01\xb9\x00\x63\x02\x73\x00\x74\x00\x75\x00\x05\x01\xb9\x00\x35\x01\xb2\x02\x2b\x02\xb4\x02\xb5\x02\xb6\x02\xa9\x00\xb4\x01\xa9\x00\xab\x01\x0d\x00\x0d\x00\xc5\x01\x0d\x00\xd4\x00\xa9\x00\x06\x01\x1b\x00\x76\x00\x77\x00\x1c\x00\x1d\x00\x78\x00\x79\x00\x7a\x00\x1e\x00\xaa\x02\x1f\x00\x20\x00\x21\x00\x7b\x00\x7c\x00\x7d\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x7e\x00\x27\x00\x28\x00\x7f\x00\x29\x00\x2a\x00\x80\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x81\x00\x0d\x00\x0d\x00\xbc\x00\x82\x00\x0d\x00\xbc\x00\x83\x00\x30\x00\x31\x00\x53\x01\x7f\x02\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x84\x00\x84\x00\x43\x00\x9b\x01\x2a\x02\x64\x02\x65\x02\x66\x02\x84\x00\x36\x01\xb3\x00\x9c\x01\x9d\x01\x8f\x00\x9e\x01\x39\x00\x3a\x00\xa6\x01\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x1a\x00\x6b\x00\xff\xff\x84\x00\x84\x00\xef\x01\x84\x00\xd8\x01\x85\xff\x98\x00\xcc\x01\x0d\x00\xb6\x00\xb7\x00\x6e\x00\x6f\x00\x70\x00\xf0\x01\xe0\x01\x71\x00\x72\x00\x9b\x00\x41\x02\x9b\x00\x58\x01\x73\x00\x74\x00\x75\x00\xb8\x00\xb9\x00\x3a\x01\xb9\x00\x0d\x00\xb6\x00\xb7\x00\x0d\x00\xb6\x00\xb7\x00\x53\x01\xb3\x02\xb9\x00\x63\x02\xc0\x00\x9e\x00\x84\x00\x84\x00\xb4\x02\x1b\x00\x84\x00\xb8\x00\x1c\x00\x1d\x00\xb8\x00\xdb\x01\xdc\x01\x1e\x00\x3f\x02\x1f\x00\x20\x00\x21\x00\xa9\x00\x9b\x00\xa7\x01\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\xc2\x00\x27\x00\x28\x00\x7f\x00\x29\x00\x2a\x00\xcd\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\xa8\x01\xb9\x00\x52\x01\xb9\x00\xcb\x01\x0d\x00\xbc\x00\x83\x00\x30\x00\x31\x00\x98\x00\x38\x01\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\xc9\x01\x84\x00\x43\x00\x5f\x01\x0d\x00\xd2\x00\xd3\x00\xcd\x00\xd4\x00\x3b\x01\xb3\x00\xb9\x00\xe2\x01\x1a\x00\xd4\x00\x39\x00\x3a\x00\xcb\x01\x6c\x00\xb5\x00\x61\xff\x61\xff\x84\x00\xa4\x02\x66\x02\x84\x00\x30\x02\x56\x01\x0d\x00\xb6\x00\xb7\x00\x0d\x00\xb6\x00\xb7\x00\x0d\x00\xd2\x00\xd3\x00\x81\xff\xd4\x00\xb9\x00\x58\x01\xc0\x00\x0d\x00\xb6\x00\xb7\x00\xb8\x00\x0d\x00\xbc\x00\xb8\x00\x61\xff\xb6\x01\xb8\x00\x3d\x01\xfb\x01\xb9\x00\x65\x01\x0d\x00\xb6\x00\xb7\x00\xb8\x00\x1b\x00\xb9\x00\x53\x01\x1c\x00\x1d\x00\xfc\x01\xb7\x01\xb8\x01\x1e\x00\xa9\x00\x1f\x00\x20\x00\x21\x00\xb8\x00\xc7\x01\x84\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\xee\x00\x27\x00\x28\x00\x95\x02\x29\x00\x2a\x00\xcc\x01\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\xa9\x00\x1a\x00\xb9\x00\x66\x01\x60\x01\xb9\x00\xef\x00\x96\x02\x30\x00\x31\x00\xe2\x01\x84\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\xbc\x00\xbd\x00\xb9\x00\x0d\x00\xb6\x00\xb7\x00\xac\x00\xad\x00\xae\x00\xaf\x00\xbe\x00\x5f\x01\xa9\x00\x43\x00\x4a\x01\xb1\x00\x84\x00\x0f\x02\x53\x01\x84\x00\xb9\x00\x98\x00\x84\x00\xb0\x01\x5c\x01\x98\x00\x39\x00\x3a\x00\x61\xff\x61\xff\x84\x00\xc9\x01\x1c\x00\x1d\x00\x84\x00\xa9\x00\xfe\x01\x1e\x00\xcd\x00\x1f\x00\xc2\x00\x21\x00\xd6\x01\xb3\x00\x84\x00\x22\x00\x23\x00\x24\x00\xcb\x01\x26\x00\xf0\x01\x27\x00\x28\x00\x3e\x02\xa9\x00\x2a\x00\xc7\x01\x61\xff\x2c\x00\x2d\x00\x2e\x00\x2f\x00\xc9\x01\x1a\x00\xdf\x01\xf3\x00\xb2\x01\x55\x01\x56\x01\x3f\x02\x30\x00\x31\x00\x99\x00\xcc\x01\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x5d\x01\xb3\x00\xf4\x00\xc9\x00\xad\x00\x00\x02\xa3\x02\xc2\x00\xca\x00\xcb\x00\xcc\x00\xcd\x00\xce\x00\xa4\x02\x4a\x01\xa2\x00\x39\x02\x01\x02\x11\x00\x52\x02\xcf\x00\xd0\x00\x84\x00\xc9\x01\x60\x01\xb9\x00\xa3\x00\xa4\x00\xca\x01\x53\x02\xcd\x00\x16\x00\x1c\x00\x1d\x00\xa9\x00\xe0\x01\x54\x02\x1e\x00\xa8\x02\x1f\x00\xcb\x01\x21\x00\x8d\x01\x27\x02\xd4\x00\x22\x00\x23\x00\x24\x00\xe2\x01\x26\x00\xaf\x02\x27\x00\x28\x00\x37\x02\xa9\x00\x2a\x00\xde\x00\xb8\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\xb0\x02\x1a\x00\xb9\x00\xba\x00\xaa\x00\xa9\x00\xab\x00\x38\x02\x30\x00\x31\x00\xcd\x00\x8a\x01\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x8b\x01\xd0\x00\xac\x00\xad\x00\xae\x00\xaf\x00\xb0\x00\x16\x02\xe8\x00\x9f\x02\x25\x01\xb1\x00\x26\x01\x38\x01\xa9\x00\xa2\x00\x39\x02\x11\x00\x9e\x00\x17\x02\x27\x01\x28\x01\xbe\x01\xad\x00\xdd\x01\xaf\x00\xa3\x00\xa4\x00\xfd\x00\xd3\x01\x16\x00\xb1\x00\x1c\x00\x1d\x00\x29\x01\x2a\x01\x39\x01\x1e\x00\x31\x01\x1f\x00\x11\x00\x21\x00\xbc\x02\xb2\x00\xb3\x00\x22\x00\x23\x00\x24\x00\xb8\x02\x26\x00\x41\x01\x27\x00\x28\x00\x16\x00\x11\x00\x2a\x00\xba\x02\x2e\x02\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x9e\x00\x7e\x02\xa9\x00\x8f\x02\x90\x02\x16\x00\x7f\x02\x2f\x02\x30\x00\x31\x00\xbb\x02\xc0\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x1a\x00\x6b\x00\x42\x01\x13\x00\x14\x00\x6c\x00\xa2\x00\x39\x02\x6d\x00\x2b\x01\x90\x01\x15\x00\x42\x02\x33\x02\x6e\x00\x6f\x00\x70\x00\xa3\x00\xa4\x00\x71\x00\x72\x00\x97\x02\x91\x01\xc9\x00\xad\x00\x73\x00\x74\x00\x75\x00\xca\x00\xcb\x00\xd4\x00\xcd\x00\xce\x00\x98\x02\x43\x01\xcd\x00\x8a\x01\x61\x02\x27\x02\xb8\x02\xd5\x00\xd0\x00\x62\x02\x28\x02\x8d\x01\xd0\x00\xa9\x00\x1b\x00\x76\x00\x77\x00\x1c\x00\x1d\x00\x78\x00\x79\x00\x7a\x00\x1e\x00\xb9\x02\x1f\x00\x20\x00\x21\x00\x7b\x00\x7c\x00\x7d\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x7e\x00\x27\x00\x28\x00\x7f\x00\x29\x00\x2a\x00\x80\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x81\x00\xcd\x00\x8a\x01\xc9\x01\x82\x00\xd4\x00\x87\x02\x83\x00\x30\x00\x31\x00\x91\x01\xd0\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\xaa\x02\x79\x02\x43\x00\x9b\x01\x7b\x02\xa9\x00\x62\x02\xa1\x02\xce\x01\x62\x02\xd4\x00\x9c\x01\x9d\x01\x8f\x00\x9e\x01\x39\x00\x3a\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x1a\x00\x6b\x00\xa8\x02\x84\x02\x85\x02\x6c\x00\x83\x02\x84\x02\x85\x02\xc1\x00\x13\x00\x14\x00\x0d\x01\x0e\x01\x6e\x00\x6f\x00\x70\x00\x87\x02\x15\x00\x71\x00\x72\x00\xc2\x00\xc4\x00\xbd\x00\x9a\x02\x73\x00\x74\x00\x75\x00\xac\x00\xad\x00\xae\x00\xaf\x00\xbe\x00\xa9\x00\xe4\x01\x8d\x02\xd4\x00\xb1\x00\x4b\x01\xa2\x02\x8d\x01\xc3\x00\xd4\x00\x3e\x01\x3f\x01\x13\x00\x14\x00\x8e\x02\xa6\x02\x12\x02\x1c\x00\x1d\x00\xa9\x00\x15\x00\x7d\x02\x1e\x00\x40\x01\x1f\x00\xa9\x00\x21\x00\x24\x02\x13\x02\x81\x02\x22\x00\x23\x00\x24\x00\xa9\x00\x26\x00\x82\x02\x27\x00\x28\x00\x7f\x00\xc9\x01\x2a\x00\xd4\x00\x83\x02\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x13\x01\x14\x01\xac\x00\xad\x00\xae\x00\xaf\x00\x45\x01\x83\x00\x30\x00\x31\x00\x87\x02\xb1\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x1a\x00\xf7\x00\xce\x01\x4c\x01\xd4\x00\xb8\x00\x03\x01\x04\x01\x3e\x01\x3f\x01\x13\x00\x14\x00\x14\x02\x88\x02\x6e\x00\x6f\x00\x70\x00\x89\x02\x15\x00\x71\x00\x72\x00\x40\x01\x15\x01\x16\x01\x15\x02\x73\x00\x74\x00\x75\x00\x8c\x02\xa9\x00\x9b\x00\x13\x00\x14\x00\x3c\x02\x50\x01\x9d\x00\xe2\x01\x18\x02\xd4\x00\x15\x00\x1d\x00\x93\x02\x9e\x00\x0f\x01\x10\x01\x11\x01\x12\x01\x60\x01\xb9\x00\x19\x02\x1c\x00\x1d\x00\x22\x00\x9f\x00\xa9\x00\x1e\x00\x26\x00\x1f\x00\xe4\x01\x21\x00\xd4\x00\x45\x02\xa0\x00\x22\x00\x23\x00\x24\x00\x46\x02\x26\x00\x2f\x00\x27\x00\x28\x00\x7f\x00\x4b\x02\x2a\x00\x32\x02\x33\x02\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x23\x02\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x83\x00\x30\x00\x31\x00\xd2\x01\xd3\x01\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x25\x02\x6b\x00\xce\x01\x5c\x02\xd4\x00\x6c\x00\x03\x01\x04\x01\x6d\x00\xd2\x01\xd9\x01\x93\x01\x26\x02\x4e\x02\x6e\x00\x6f\x00\x70\x00\x27\x02\x23\x02\x71\x00\x72\x00\x0d\x01\x0e\x01\x94\x01\x59\x02\x73\x00\x74\x00\x75\x00\xa9\x00\x0d\x00\x0e\x00\x0f\x00\x5b\x02\x10\x00\x17\x01\x18\x01\x19\x01\x11\x00\x12\x00\x13\x00\x14\x00\x60\x02\x13\x01\x14\x01\x15\x01\x16\x01\x63\x02\x15\x00\x76\x00\x77\x00\x16\x00\x4d\x01\x78\x00\x79\x00\x7a\x00\x7a\x02\x3e\x01\x3f\x01\x13\x00\x14\x00\x7b\x00\x7c\x00\x7d\x00\x7c\x02\xe5\x01\xf2\x01\x15\x00\xb9\x00\x7e\x00\x40\x01\x17\x00\x7f\x00\xfd\x01\xfe\x01\x80\x00\x0f\x02\xc5\x00\x13\x00\x14\x00\x09\x02\x81\x00\x0e\x02\xd4\x01\x11\x02\x82\x00\x15\x00\x1b\x02\x83\x00\xc7\x00\xa9\x00\x1c\x02\x18\x00\x1e\x02\x0d\x00\x1a\x00\xc5\x01\xc6\x01\xd4\x00\x1f\x02\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\xb8\x00\x09\x01\x27\x02\x2b\x02\x0a\x01\x2d\x02\x8f\x00\x0b\x01\x47\x00\x48\x00\x49\x00\x4a\x00\x0c\x01\x8f\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x90\x00\x30\x02\x35\x02\x55\x01\x1b\x00\x5a\x01\x8f\x01\x1c\x00\x1d\x00\xa2\x01\xa9\x00\xa0\x01\x1e\x00\xaf\x01\x1f\x00\x20\x00\x21\x00\xda\x01\xdb\x01\xff\xff\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\xe5\x01\x27\x00\x28\x00\xc9\x00\x29\x00\x2a\x00\xde\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\xff\xff\x0d\x00\x1a\x00\xe0\x00\xeb\x01\xaa\x00\xe1\x00\xab\x00\x30\x00\x31\x00\xe2\x00\x42\x02\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x84\x00\xe8\x00\xeb\x00\xac\x00\xad\x00\xae\x00\xaf\x00\x2f\x01\xed\x00\xff\xff\x09\x01\x0b\x01\xb1\x00\x43\x02\xb3\x00\x0a\x01\x0c\x01\x4e\x01\x2c\x01\x2d\x01\xff\xff\x31\x01\x3e\x01\x3f\x01\x13\x00\x14\x00\x39\x00\x3a\x00\x96\x00\xc7\x01\x1b\x00\x34\x01\x15\x00\x1c\x00\x1d\x00\x40\x01\x35\x01\xff\xff\x1e\x00\x0d\x00\x1f\x00\x20\x00\x21\x00\x00\x00\xb2\x00\xb3\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\x27\x00\x28\x00\x00\x00\x29\x00\x2a\x00\x00\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x00\x00\x0d\x00\x1a\x00\x00\x00\xee\x01\x00\x00\x00\x00\x00\x00\x30\x00\x31\x00\x00\x00\x00\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x84\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x90\x00\x00\x00\x00\x00\x00\x00\x39\x00\x3a\x00\x96\x00\xc7\x01\x1b\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\x00\x00\x00\x00\x00\x00\x1e\x00\x00\x00\x1f\x00\x20\x00\x21\x00\x00\x00\x00\x00\x00\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\x27\x00\x28\x00\x00\x00\x29\x00\x2a\x00\x00\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x00\x00\x0d\x00\x1a\x00\x00\x00\xf7\x01\x00\x00\x00\x00\x93\x02\x30\x00\x31\x00\x00\x00\x00\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x84\x00\x00\x00\x00\x00\x00\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x53\x01\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x90\x00\x39\x00\x3a\x00\x96\x00\xc7\x01\x1b\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\x00\x00\x00\x00\x00\x00\x1e\x00\x00\x00\x1f\x00\x20\x00\x21\x00\x00\x00\x00\x00\x00\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\x27\x00\x28\x00\x00\x00\x29\x00\x2a\x00\x00\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1a\x00\x8d\x01\xc6\x01\xd4\x00\x30\x00\x31\x00\x55\x02\x00\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x84\x00\xb8\x00\x00\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x90\x00\x00\x00\x39\x00\x3a\x00\x96\x00\xc7\x01\x00\x00\x00\x00\x1b\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\x00\x00\x00\x00\x00\x00\x1e\x00\x00\x00\x1f\x00\x20\x00\x21\x00\x00\x00\x00\x00\x00\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\x27\x00\x28\x00\x00\x00\x29\x00\x2a\x00\x00\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1a\x00\xb4\x01\x30\x00\x31\x00\x00\x00\x00\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x5e\x02\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x90\x00\x00\x00\x00\x00\x00\x00\x39\x00\x3a\x00\x96\x00\xc7\x01\x00\x00\x00\x00\x00\x00\x00\x00\x1b\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\x00\x00\xa9\x00\x00\x00\x1e\x00\x00\x00\x1f\x00\x20\x00\x21\x00\x00\x00\x00\x00\x00\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\x27\x00\x28\x00\x00\x00\x29\x00\x2a\x00\x00\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x00\x00\x00\x00\x1a\x00\x91\x00\xf9\x01\xde\x01\x00\x00\xab\x00\x30\x00\x31\x00\x00\x00\x00\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x00\x00\x00\x00\x00\x00\xac\x00\xad\x00\xae\x00\xaf\x00\xb0\x00\x00\x00\x00\x00\x00\x00\x8f\x00\xb1\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x3d\x01\x00\x00\xef\x00\x4c\x00\x7a\x01\x3e\x01\x3f\x01\x13\x00\x14\x00\x39\x00\x3a\x00\x96\x00\x5f\x02\x1b\x00\x00\x00\x15\x00\x1c\x00\x1d\x00\x40\x01\x00\x00\x00\x00\x1e\x00\x00\x00\x1f\x00\x20\x00\x21\x00\x00\x00\x00\x00\x53\x01\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\x27\x00\x28\x00\x00\x00\x29\x00\x2a\x00\xe7\x01\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x00\x00\x00\x00\x1a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x30\x00\x31\x00\x00\x00\x00\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x00\x00\x00\x00\x93\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x11\x00\x12\x00\x13\x00\x14\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x15\x00\x00\x00\xe2\x00\x16\x00\x00\x00\x00\x00\x39\x00\x3a\x00\x96\x00\xc7\x01\x1b\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\xe8\x01\xc1\x01\xc2\x01\x1e\x00\xe9\x01\x1f\x00\x20\x00\x21\x00\x17\x00\x00\x00\x00\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\x27\x00\x28\x00\x00\x00\x29\x00\x2a\x00\x00\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x00\x00\x1a\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x30\x00\x31\x00\xef\x00\xfa\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x3a\x00\x3b\x00\x3c\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x11\x00\x12\x00\x13\x00\x14\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x15\x00\x00\x00\xf5\x00\x16\x00\x00\x00\x00\x00\x39\x00\x3a\x00\x96\x00\x1b\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\x00\x00\xa9\x00\x00\x00\x1e\x00\x00\x00\x1f\x00\x20\x00\x21\x00\x00\x00\x17\x00\x00\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\x27\x00\x28\x00\x00\x00\x29\x00\x2a\x00\x00\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x1a\x00\x2d\x01\x40\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe6\x01\x30\x00\x31\x00\x00\x00\x00\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x00\x00\x00\x00\x00\x00\xac\x00\xad\x00\xae\x00\xaf\x00\xb0\x00\x00\x00\x00\x00\x00\x00\x42\x00\xb1\x00\x43\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x44\x00\x45\x00\x2f\x01\x00\x00\x00\x00\x00\x00\x00\x00\x39\x00\x3a\x00\x1b\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\x00\x00\x00\x00\x00\x00\x1e\x00\xa9\x00\x1f\x00\x20\x00\x21\x00\x00\x00\x00\x00\x00\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\x27\x00\x28\x00\x00\x00\x29\x00\x2a\x00\x00\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x1a\x00\x00\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x30\x00\x31\x00\xef\x00\x21\x02\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x00\x00\xf3\x01\x00\x00\x00\x00\x00\x00\x00\x00\xac\x00\xad\x00\xae\x00\xaf\x00\xbe\x00\x42\x00\x00\x00\x43\x00\x00\x00\xb1\x00\x00\x00\x00\x00\x00\x00\x44\x00\x45\x00\x46\x00\x00\x00\x00\x00\x00\x00\x00\x00\x39\x00\x3a\x00\x1b\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\x00\x00\x00\x00\x00\x00\x1e\x00\x00\x00\x1f\x00\x20\x00\x21\x00\x00\x00\x00\x00\x00\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\x27\x00\x28\x00\x00\x00\x29\x00\x2a\x00\x00\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x1a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6c\x00\x00\x00\x00\x00\x30\x00\x31\x00\x00\x00\x00\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\xc5\x00\x13\x00\x14\x00\x00\x00\x00\x00\x00\x00\xc6\x00\x00\x00\x00\x00\x15\x00\x00\x00\x42\x00\xc7\x00\x43\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x44\x00\x45\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x39\x00\x3a\x00\x1b\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\x00\x00\x00\x00\x00\x00\x1e\x00\x00\x00\x1f\x00\x20\x00\x21\x00\x00\x00\x00\x00\x00\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\x27\x00\x28\x00\x00\x00\x29\x00\x2a\x00\x1d\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x1a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6c\x00\x22\x00\x00\x00\x30\x00\x31\x00\x26\x00\x00\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x00\x00\x00\x00\x8f\x00\x2f\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\xef\x00\x4c\x00\x7b\x01\x43\x00\x3c\x02\x00\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x00\x00\x00\x00\x00\x00\x00\x00\x39\x00\x3a\x00\x1b\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\x00\x00\x00\x00\x00\x00\x1e\x00\x00\x00\x1f\x00\x20\x00\x21\x00\x00\x00\x00\x00\x00\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\x27\x00\x28\x00\x00\x00\x29\x00\x2a\x00\x00\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x1a\x00\x00\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x30\x00\x31\x00\xef\x00\x77\x01\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x93\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x43\x00\x4a\x01\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x16\x00\x00\x00\x00\x00\x00\x00\x00\x00\x39\x00\x3a\x00\x1b\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\xf7\x01\xc1\x01\xc2\x01\x1e\x00\x00\x00\x1f\x00\x20\x00\x21\x00\x17\x00\x00\x00\x00\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\x27\x00\x28\x00\x00\x00\x29\x00\x2a\x00\x00\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x1a\x00\x00\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x30\x00\x31\x00\xef\x00\x78\x01\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x00\x00\x96\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x11\x00\x12\x00\x13\x00\x14\x00\x43\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x16\x00\x00\x00\x00\x00\x00\x00\x39\x00\x3a\x00\x1b\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\x00\x00\x00\x00\x1a\x00\x1e\x00\x54\x02\x1f\x00\x20\x00\x21\x00\x00\x00\x17\x00\x00\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\x27\x00\x28\x00\x00\x00\x29\x00\x2a\x00\x00\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x00\x00\x00\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x30\x00\x31\x00\xef\x00\x79\x01\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\x00\x00\x00\x00\x1a\x00\x1e\x00\x00\x00\x1f\x00\x00\x00\x21\x00\x00\x00\x00\x00\x00\x00\x22\x00\x23\x00\x24\x00\x00\x00\x26\x00\x00\x00\x27\x00\x28\x00\x39\x00\x3a\x00\x2a\x00\x00\x00\x00\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x00\x00\x00\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x30\x00\x31\x00\xef\x00\xf4\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\x00\x00\x00\x00\x1a\x00\x1e\x00\x00\x00\x1f\x00\x00\x00\x21\x00\xa2\x00\x52\x01\x00\x00\x22\x00\x23\x00\x24\x00\x00\x00\x26\x00\x00\x00\x27\x00\x28\x00\xa3\x00\xa4\x00\x2a\x00\x00\x00\x00\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x00\x00\x00\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x30\x00\x31\x00\xef\x00\xf8\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1e\x00\x00\x00\x1f\x00\x00\x00\x21\x00\xa2\x00\x00\x00\x00\x00\x00\x00\x23\x00\x24\x00\x00\x00\x00\x00\x00\x00\x27\x00\x28\x00\xa3\x00\xa4\x00\x2a\x00\x00\x00\x00\x00\x2c\x00\x2d\x00\x2e\x00\x00\x00\x00\x00\x00\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x30\x00\x31\x00\xef\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x85\x01\x38\x00\x6b\x01\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x6c\x01\x1a\x01\x1b\x01\x1c\x01\x1d\x01\x1e\x01\x1f\x01\x20\x01\x21\x01\x22\x01\x23\x01\x24\x01\x6e\x00\x6f\x00\x70\x00\x45\x01\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x92\x02\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\xef\x00\xf9\x00\x00\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7f\x00\x3a\x00\x3b\x00\x3c\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x11\x00\x12\x00\x13\x00\x14\x00\x8f\x00\x83\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x15\x00\x00\x00\xf7\x00\x16\x00\x00\x00\x00\x00\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x7f\x00\x65\x01\x00\x00\x00\x00\x00\x00\x17\x00\x00\x00\x00\x00\x00\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x83\x00\xef\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x82\x01\x3d\x00\x3e\x00\x3f\x00\x40\x00\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x00\x00\x65\x01\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x8f\x00\x6b\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\xef\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x83\x01\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x8f\x00\x6b\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\xef\x00\x4c\x00\x4d\x00\x4e\x00\x7e\x01\x00\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7f\x00\x3a\x00\x3b\x00\x3c\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x83\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x16\x00\x00\x00\x00\x00\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x7f\x00\x65\x01\x00\x00\x00\x00\x00\x00\x17\x00\x00\x00\x00\x00\x00\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x83\x00\xef\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x84\x01\x00\x00\xa6\x00\x40\x00\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x00\x00\x48\x02\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x8f\x00\x6b\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\xef\x00\x4c\x00\x4d\x00\x4e\x00\x7f\x01\x00\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xbb\x01\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x00\x00\x8f\x00\xbc\x01\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\xef\x00\xfa\x00\x00\x00\x6e\x00\x6f\x00\xbd\x01\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x7f\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x83\x00\xef\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x87\x01\x1d\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x22\x00\x65\x01\x00\x00\x00\x00\x26\x00\x00\x00\x00\x00\x00\x00\x7f\x00\xbe\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x2f\x00\x00\x00\xef\x00\x4c\x00\x4d\x00\x4e\x00\x80\x01\x00\x00\x83\x00\x00\x00\x00\x00\x00\x00\x00\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x0c\x02\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x00\x00\xdc\x00\x00\x00\x93\x00\x0d\x02\x00\x00\x00\x00\x00\x00\x00\x00\xdd\x00\x00\x00\x00\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x9c\x02\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x9d\x02\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\xef\x00\xfb\x00\x00\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7f\x00\x46\x01\x3b\x00\xa5\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x83\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x16\x00\x00\x00\x00\x00\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x7f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x17\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x47\x01\xef\x00\xfc\x00\x83\x00\x00\x00\x48\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\xe6\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\xe7\x00\x00\x00\xef\x00\x4c\x00\x4d\x00\x7c\x01\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x69\x01\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x8f\x00\x6b\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\xef\x00\x4c\x00\x4d\x00\x4e\x00\x81\x01\x00\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7f\x00\x39\x02\x3b\x00\xa5\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x83\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x16\x00\x00\x00\x00\x00\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x7f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x17\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x3a\x02\x00\x00\x8f\x00\x83\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\xef\x00\x4c\x00\x4d\x00\x7d\x01\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x00\x00\x00\x00\x06\x02\x00\x00\x00\x00\x00\x00\xa9\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6e\x00\x6f\x00\x07\x02\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x9b\x00\x13\x00\x14\x00\x33\x02\x50\x01\x9d\x00\x93\x00\x0e\x00\x0f\x00\x15\x00\x10\x00\x00\x00\x9e\x00\x00\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1d\x00\x9f\x00\x15\x00\x00\x00\x00\x00\x16\x00\xbe\x01\xad\x00\x00\x00\x00\x00\xa0\x00\x00\x00\x22\x00\x00\x00\xcd\x00\xf9\x01\x26\x00\xc0\x01\xc1\x01\xc2\x01\x7f\x00\x08\x02\x00\x00\xc3\x01\xd0\x00\x17\x00\x00\x00\x00\x00\x2f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x83\x00\x00\x00\x00\x00\x00\x00\x00\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x00\x00\xdc\x00\x00\x00\x93\x00\x99\x02\x00\x00\x00\x00\x00\x00\x00\x00\xdd\x00\x1d\x00\x00\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x22\x00\x73\x00\x74\x00\x75\x00\x26\x00\x00\x00\x00\x00\x00\x00\x7f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x83\x00\x00\x00\x00\x00\x00\x00\x00\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x7f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x83\x00\xef\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x88\x01\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x00\x00\xdc\x00\x00\x00\x93\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xdd\x00\x00\x00\x00\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x00\x00\x00\x00\x00\x00\x93\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7f\x00\xa4\x00\x3b\x00\xa5\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x83\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x16\x00\x00\x00\x00\x00\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x7f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x17\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb9\x00\x00\x00\x83\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x8b\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x00\x00\x00\x00\x00\x00\x93\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7f\x00\x00\x00\x00\x00\x00\x00\x96\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x11\x00\x12\x00\x13\x00\x14\x00\x83\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x16\x00\x00\x00\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x7f\x00\x97\x00\x00\x00\x00\x00\x00\x00\x00\x00\x17\x00\x00\x00\x00\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x83\x00\xef\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x86\x01\x00\x00\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x00\x00\x00\x00\x58\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x00\x00\x00\x00\x04\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x83\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x7f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x83\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x00\x00\x00\x00\x00\x00\x23\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x00\x00\x00\x00\x00\x00\x93\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x83\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x7f\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x83\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\xe4\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x00\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x83\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x7f\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x83\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\xf7\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x00\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x83\x00\x63\x00\x64\x00\x65\x00\x66\x00\x67\x00\x68\x00\x69\x00\x6a\x00\x0d\x00\x00\x00\x6b\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x7f\x00\x6e\x00\x6f\x00\x70\x00\x00\x00\x00\x00\x71\x00\x72\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x74\x00\x75\x00\x00\x00\x83\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0d\x00\xbc\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x7f\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x01\x02\x00\x00\x83\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x84\x00\x85\x00\x86\x00\x87\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x8d\x00\x8e\x00\x68\x02\x00\x00\x9e\x00\x69\x02\x6a\x02\x00\x00\x00\x00\x00\x00\x6b\x02\x00\x00\x00\x00\x6c\x02\x6d\x02\x02\x02\x00\x00\x00\x00\x6e\x02\x6f\x02\x70\x02\x71\x02\x00\x00\x00\x00\x72\x02\x73\x02\x00\x00\x74\x02\x00\x00\x00\x00\x75\x02\x00\x00\x76\x02\x77\x02\x78\x02\x00\x00\x1c\x00\x1d\x00\x00\x00\x00\x00\x00\x00\x1e\x00\x00\x00\x1f\x00\x00\x00\x21\x00\x00\x00\x00\x00\x00\x00\x22\x00\x23\x00\x24\x00\x00\x00\x26\x00\x84\x00\x27\x00\x28\x00\x00\x00\x00\x00\x2a\x00\x00\x00\x00\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x30\x00\x31\x00\x00\x00\x00\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x38\x00\x46\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x00\x00\x00\x00\x94\x01\x3b\x00\xa5\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x16\x00\x9b\x00\x13\x00\x14\x00\x4f\x01\x50\x01\x9d\x00\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x9e\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x17\x00\x00\x00\x00\x00\x00\x00\x9f\x00\x00\x00\x95\x01\x5b\x00\x5c\x00\x96\x01\x97\x01\x00\x00\x98\x01\xa0\x00\x5d\x00\x5e\x00\x5f\x00\x60\x00\x00\x00\x00\x00\x00\x00\x46\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x61\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x00\x00\x00\x00\x94\x01\x3b\x00\xa5\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x16\x00\x9b\x00\x13\x00\x14\x00\x00\x00\x35\x02\x9d\x00\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x9e\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x17\x00\x00\x00\x00\x00\x00\x00\x9f\x00\x00\x00\x95\x01\x5b\x00\x5c\x00\x00\x00\x1f\x02\x00\x00\x20\x02\xa0\x00\x5d\x00\x5e\x00\x5f\x00\x60\x00\x00\x00\x00\x00\x00\x00\x46\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x61\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x46\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x46\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x93\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\xb0\x02\x5b\x00\x5c\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x5d\x00\x5e\x00\x5f\x00\x60\x00\x00\x00\x15\x00\x00\x00\x00\x00\x16\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x61\x00\xac\x02\x5b\x00\x5c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5c\x02\x5d\x00\x5e\x00\x5f\x00\x60\x00\x00\x00\x17\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x61\x00\xad\x02\x5b\x00\x5c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5d\x00\x5e\x00\x5f\x00\x60\x00\x00\x00\x00\x00\x00\x00\x46\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x61\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x46\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x46\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x93\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x9d\x02\x5b\x00\x5c\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x5d\x00\x5e\x00\x5f\x00\x60\x00\x00\x00\x15\x00\x00\x00\x00\x00\x16\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x61\x00\x9f\x02\x5b\x00\x5c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x94\x00\x5d\x00\x5e\x00\x5f\x00\x60\x00\x00\x00\x17\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x61\x00\x4e\x02\x5b\x00\x5c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5d\x00\x5e\x00\x5f\x00\x60\x00\x00\x00\x00\x00\x00\x00\x46\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x61\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x46\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x46\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x4f\x02\x5b\x00\x5c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5d\x00\x5e\x00\x5f\x00\x60\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x61\x00\x50\x02\x5b\x00\x5c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5d\x00\x5e\x00\x5f\x00\x60\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x61\x00\x1c\x02\x5b\x00\x5c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5d\x00\x5e\x00\x5f\x00\x60\x00\x00\x00\x00\x00\x00\x00\x46\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x61\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x46\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x46\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x60\x01\x5b\x00\x5c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5d\x00\x5e\x00\x5f\x00\x60\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x61\x00\xa0\x01\x5b\x00\x5c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5d\x00\x5e\x00\x5f\x00\x60\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x61\x00\xeb\x00\x5b\x00\x5c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5d\x00\x5e\x00\x5f\x00\x60\x00\x00\x00\x00\x00\x00\x00\x46\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x61\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x59\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\xfe\x00\x9b\x00\x13\x00\x14\x00\x00\x00\x9c\x00\x9d\x00\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x9e\x00\x9b\x00\x13\x00\x14\x00\x00\x00\x00\x00\xff\x00\x5a\x00\x5b\x00\x5c\x00\x15\x00\x9f\x00\x00\x00\x9e\x00\x00\x00\x5d\x00\x5e\x00\x5f\x00\x60\x00\x00\x00\xa0\x00\x00\x00\x00\x00\x00\x00\x9f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x61\x00\x9e\x01\x00\x00\x00\x00\xa0\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x01\x01\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\xfe\x00\x9b\x00\x13\x00\x14\x00\x00\x00\x00\x00\xcf\x01\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x9e\x00\x9b\x00\x13\x00\x14\x00\x00\x00\x00\x00\xff\x00\x00\x00\x00\x00\x00\x00\x15\x00\x9f\x00\x00\x00\x9e\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa0\x00\x00\x00\x00\x00\x00\x00\x9f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xab\x01\x00\x00\x00\x00\xa0\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x01\x01\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\xfe\x00\x9b\x00\x13\x00\x14\x00\x00\x00\x00\x00\xd0\x01\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x9e\x00\x9b\x00\x13\x00\x14\x00\x00\x00\x00\x00\xff\x00\x00\x00\x00\x00\x00\x00\x15\x00\x9f\x00\x00\x00\x9e\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa0\x00\x00\x00\x00\x00\x00\x00\x9f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\xa0\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x01\x01\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x90\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x90\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x90\x00\x00\x00\x00\x00\x00\x00\xd6\x00\x49\x02\xd8\x00\xd9\x00\xda\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd6\x00\xd7\x00\xd8\x00\xd9\x00\xda\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x09\x02\x00\x00\x0a\x02\xd9\x00\xda\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\xa2\x01\xa3\x01\xa9\x00\xa4\x01\x3b\x00\xa5\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x16\x00\x00\x00\x00\x00\x93\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x00\x00\x00\x00\xe7\x01\x00\x00\x17\x00\x15\x00\x00\x00\x00\x00\x16\x00\xbe\x01\xad\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xcd\x00\xbf\x01\x00\x00\xc0\x01\xc1\x01\xc2\x01\x00\x00\x00\x00\x00\x00\xc3\x01\xd0\x00\x17\x00\x93\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x00\x00\x00\x00\xe7\x01\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x16\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xeb\x01\xc1\x01\xc2\x01\x00\x00\xec\x01\x00\x00\x00\x00\x00\x00\x17\x00\x93\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x11\x00\x12\x00\x13\x00\x14\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x15\x00\x00\x00\x5a\x01\x16\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf4\x01\xc1\x01\xc2\x01\x00\x00\xf5\x01\x00\x00\x00\x00\x00\x00\x17\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9b\x00\x13\x00\x14\x00\x00\x00\x00\x00\xff\x00\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x9e\x00\x00\x00\x46\x01\x3b\x00\xa5\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x5c\x01\x9f\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x5b\x01\x00\x00\x00\x00\xa0\x00\x00\x00\x15\x00\x00\x00\x8f\x00\x16\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\xef\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\xf0\x00\x17\x00\x00\x00\x00\x00\xf2\x01\x00\x00\x00\x00\x00\x00\x00\x00\x47\x01\x00\x00\x00\x00\x00\x00\x00\x00\x48\x01\x00\x00\x00\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x5d\x01\xb3\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\xb8\x01\x00\x00\x00\x00\x1b\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\x00\x00\x00\x00\x00\x00\x1e\x00\x00\x00\x1f\x00\x20\x00\x21\x00\x00\x00\x00\x00\x00\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x00\x00\x27\x00\x28\x00\x9e\x00\x29\x00\x2a\x00\x00\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x00\x00\x00\x00\xb9\x01\x00\x00\x00\x00\x00\x00\x00\x00\x1b\x00\x30\x00\x00\x00\x00\x00\x1d\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x22\x00\x00\x00\x00\x00\x25\x00\x26\x00\x00\x00\x00\x00\x00\x00\x00\x00\x29\x00\x00\x00\x00\x00\x2b\x00\x00\x00\x00\x00\x00\x00\x2f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x59\x02\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x04\x02\x00\x00\x1c\x00\x1d\x00\x00\x00\xc2\x00\x00\x00\x1e\x00\x00\x00\x1f\x00\x00\x00\x21\x00\x00\x00\x00\x00\x00\x00\x22\x00\x23\x00\x24\x00\x00\x00\x26\x00\x00\x00\x27\x00\x28\x00\x00\x00\x00\x00\x2a\x00\x00\x00\xc2\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x30\x00\x00\x00\x00\x00\x00\x00\x32\x00\x33\x00\x34\x00\x35\x00\x36\x00\x37\x00\x93\x00\x0e\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x16\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xcd\x00\x8a\x01\x00\x00\xc0\x01\xc1\x01\xc2\x01\x00\x00\x00\x00\x00\x00\xc3\x01\xd0\x00\x17\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\xef\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\xf0\x00\x00\x00\x00\x00\x8f\x00\xb1\x01\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\xef\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\xf0\x00\x00\x00\x00\x00\x8f\x00\xce\x01\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\xef\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\xf0\x00\x00\x00\x00\x00\x8f\x00\xd5\x01\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\xef\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\xf0\x00\x00\x00\x00\x00\x8f\x00\xf1\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\xa2\x01\x4c\x02\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\xa2\x01\x19\x02\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\xab\x02\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x9a\x02\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x89\x02\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x4b\x02\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x67\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\x89\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\xa8\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\xac\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\xad\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\xe4\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x58\x00\xa7\x00\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x61\x01\x62\x01\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x63\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\xa6\x02\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x63\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x90\x02\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x63\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x69\x01\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x63\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x46\x02\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x56\x02\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x6c\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x6d\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x6e\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x6f\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x70\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x71\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x72\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x73\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x74\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x75\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\x76\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\xaf\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x57\x00\xe5\x01\x8f\x00\x00\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x00\x00\x00\x00\xef\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x53\x00\x54\x00\x55\x00\x56\x00\x48\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = Happy_Data_Array.array (11, 451) [
	(11 , happyReduce_11),
	(12 , happyReduce_12),
	(13 , happyReduce_13),
	(14 , happyReduce_14),
	(15 , happyReduce_15),
	(16 , happyReduce_16),
	(17 , happyReduce_17),
	(18 , happyReduce_18),
	(19 , happyReduce_19),
	(20 , happyReduce_20),
	(21 , happyReduce_21),
	(22 , happyReduce_22),
	(23 , happyReduce_23),
	(24 , happyReduce_24),
	(25 , happyReduce_25),
	(26 , happyReduce_26),
	(27 , happyReduce_27),
	(28 , happyReduce_28),
	(29 , happyReduce_29),
	(30 , happyReduce_30),
	(31 , happyReduce_31),
	(32 , happyReduce_32),
	(33 , happyReduce_33),
	(34 , happyReduce_34),
	(35 , happyReduce_35),
	(36 , happyReduce_36),
	(37 , happyReduce_37),
	(38 , happyReduce_38),
	(39 , happyReduce_39),
	(40 , happyReduce_40),
	(41 , happyReduce_41),
	(42 , happyReduce_42),
	(43 , happyReduce_43),
	(44 , happyReduce_44),
	(45 , happyReduce_45),
	(46 , happyReduce_46),
	(47 , happyReduce_47),
	(48 , happyReduce_48),
	(49 , happyReduce_49),
	(50 , happyReduce_50),
	(51 , happyReduce_51),
	(52 , happyReduce_52),
	(53 , happyReduce_53),
	(54 , happyReduce_54),
	(55 , happyReduce_55),
	(56 , happyReduce_56),
	(57 , happyReduce_57),
	(58 , happyReduce_58),
	(59 , happyReduce_59),
	(60 , happyReduce_60),
	(61 , happyReduce_61),
	(62 , happyReduce_62),
	(63 , happyReduce_63),
	(64 , happyReduce_64),
	(65 , happyReduce_65),
	(66 , happyReduce_66),
	(67 , happyReduce_67),
	(68 , happyReduce_68),
	(69 , happyReduce_69),
	(70 , happyReduce_70),
	(71 , happyReduce_71),
	(72 , happyReduce_72),
	(73 , happyReduce_73),
	(74 , happyReduce_74),
	(75 , happyReduce_75),
	(76 , happyReduce_76),
	(77 , happyReduce_77),
	(78 , happyReduce_78),
	(79 , happyReduce_79),
	(80 , happyReduce_80),
	(81 , happyReduce_81),
	(82 , happyReduce_82),
	(83 , happyReduce_83),
	(84 , happyReduce_84),
	(85 , happyReduce_85),
	(86 , happyReduce_86),
	(87 , happyReduce_87),
	(88 , happyReduce_88),
	(89 , happyReduce_89),
	(90 , happyReduce_90),
	(91 , happyReduce_91),
	(92 , happyReduce_92),
	(93 , happyReduce_93),
	(94 , happyReduce_94),
	(95 , happyReduce_95),
	(96 , happyReduce_96),
	(97 , happyReduce_97),
	(98 , happyReduce_98),
	(99 , happyReduce_99),
	(100 , happyReduce_100),
	(101 , happyReduce_101),
	(102 , happyReduce_102),
	(103 , happyReduce_103),
	(104 , happyReduce_104),
	(105 , happyReduce_105),
	(106 , happyReduce_106),
	(107 , happyReduce_107),
	(108 , happyReduce_108),
	(109 , happyReduce_109),
	(110 , happyReduce_110),
	(111 , happyReduce_111),
	(112 , happyReduce_112),
	(113 , happyReduce_113),
	(114 , happyReduce_114),
	(115 , happyReduce_115),
	(116 , happyReduce_116),
	(117 , happyReduce_117),
	(118 , happyReduce_118),
	(119 , happyReduce_119),
	(120 , happyReduce_120),
	(121 , happyReduce_121),
	(122 , happyReduce_122),
	(123 , happyReduce_123),
	(124 , happyReduce_124),
	(125 , happyReduce_125),
	(126 , happyReduce_126),
	(127 , happyReduce_127),
	(128 , happyReduce_128),
	(129 , happyReduce_129),
	(130 , happyReduce_130),
	(131 , happyReduce_131),
	(132 , happyReduce_132),
	(133 , happyReduce_133),
	(134 , happyReduce_134),
	(135 , happyReduce_135),
	(136 , happyReduce_136),
	(137 , happyReduce_137),
	(138 , happyReduce_138),
	(139 , happyReduce_139),
	(140 , happyReduce_140),
	(141 , happyReduce_141),
	(142 , happyReduce_142),
	(143 , happyReduce_143),
	(144 , happyReduce_144),
	(145 , happyReduce_145),
	(146 , happyReduce_146),
	(147 , happyReduce_147),
	(148 , happyReduce_148),
	(149 , happyReduce_149),
	(150 , happyReduce_150),
	(151 , happyReduce_151),
	(152 , happyReduce_152),
	(153 , happyReduce_153),
	(154 , happyReduce_154),
	(155 , happyReduce_155),
	(156 , happyReduce_156),
	(157 , happyReduce_157),
	(158 , happyReduce_158),
	(159 , happyReduce_159),
	(160 , happyReduce_160),
	(161 , happyReduce_161),
	(162 , happyReduce_162),
	(163 , happyReduce_163),
	(164 , happyReduce_164),
	(165 , happyReduce_165),
	(166 , happyReduce_166),
	(167 , happyReduce_167),
	(168 , happyReduce_168),
	(169 , happyReduce_169),
	(170 , happyReduce_170),
	(171 , happyReduce_171),
	(172 , happyReduce_172),
	(173 , happyReduce_173),
	(174 , happyReduce_174),
	(175 , happyReduce_175),
	(176 , happyReduce_176),
	(177 , happyReduce_177),
	(178 , happyReduce_178),
	(179 , happyReduce_179),
	(180 , happyReduce_180),
	(181 , happyReduce_181),
	(182 , happyReduce_182),
	(183 , happyReduce_183),
	(184 , happyReduce_184),
	(185 , happyReduce_185),
	(186 , happyReduce_186),
	(187 , happyReduce_187),
	(188 , happyReduce_188),
	(189 , happyReduce_189),
	(190 , happyReduce_190),
	(191 , happyReduce_191),
	(192 , happyReduce_192),
	(193 , happyReduce_193),
	(194 , happyReduce_194),
	(195 , happyReduce_195),
	(196 , happyReduce_196),
	(197 , happyReduce_197),
	(198 , happyReduce_198),
	(199 , happyReduce_199),
	(200 , happyReduce_200),
	(201 , happyReduce_201),
	(202 , happyReduce_202),
	(203 , happyReduce_203),
	(204 , happyReduce_204),
	(205 , happyReduce_205),
	(206 , happyReduce_206),
	(207 , happyReduce_207),
	(208 , happyReduce_208),
	(209 , happyReduce_209),
	(210 , happyReduce_210),
	(211 , happyReduce_211),
	(212 , happyReduce_212),
	(213 , happyReduce_213),
	(214 , happyReduce_214),
	(215 , happyReduce_215),
	(216 , happyReduce_216),
	(217 , happyReduce_217),
	(218 , happyReduce_218),
	(219 , happyReduce_219),
	(220 , happyReduce_220),
	(221 , happyReduce_221),
	(222 , happyReduce_222),
	(223 , happyReduce_223),
	(224 , happyReduce_224),
	(225 , happyReduce_225),
	(226 , happyReduce_226),
	(227 , happyReduce_227),
	(228 , happyReduce_228),
	(229 , happyReduce_229),
	(230 , happyReduce_230),
	(231 , happyReduce_231),
	(232 , happyReduce_232),
	(233 , happyReduce_233),
	(234 , happyReduce_234),
	(235 , happyReduce_235),
	(236 , happyReduce_236),
	(237 , happyReduce_237),
	(238 , happyReduce_238),
	(239 , happyReduce_239),
	(240 , happyReduce_240),
	(241 , happyReduce_241),
	(242 , happyReduce_242),
	(243 , happyReduce_243),
	(244 , happyReduce_244),
	(245 , happyReduce_245),
	(246 , happyReduce_246),
	(247 , happyReduce_247),
	(248 , happyReduce_248),
	(249 , happyReduce_249),
	(250 , happyReduce_250),
	(251 , happyReduce_251),
	(252 , happyReduce_252),
	(253 , happyReduce_253),
	(254 , happyReduce_254),
	(255 , happyReduce_255),
	(256 , happyReduce_256),
	(257 , happyReduce_257),
	(258 , happyReduce_258),
	(259 , happyReduce_259),
	(260 , happyReduce_260),
	(261 , happyReduce_261),
	(262 , happyReduce_262),
	(263 , happyReduce_263),
	(264 , happyReduce_264),
	(265 , happyReduce_265),
	(266 , happyReduce_266),
	(267 , happyReduce_267),
	(268 , happyReduce_268),
	(269 , happyReduce_269),
	(270 , happyReduce_270),
	(271 , happyReduce_271),
	(272 , happyReduce_272),
	(273 , happyReduce_273),
	(274 , happyReduce_274),
	(275 , happyReduce_275),
	(276 , happyReduce_276),
	(277 , happyReduce_277),
	(278 , happyReduce_278),
	(279 , happyReduce_279),
	(280 , happyReduce_280),
	(281 , happyReduce_281),
	(282 , happyReduce_282),
	(283 , happyReduce_283),
	(284 , happyReduce_284),
	(285 , happyReduce_285),
	(286 , happyReduce_286),
	(287 , happyReduce_287),
	(288 , happyReduce_288),
	(289 , happyReduce_289),
	(290 , happyReduce_290),
	(291 , happyReduce_291),
	(292 , happyReduce_292),
	(293 , happyReduce_293),
	(294 , happyReduce_294),
	(295 , happyReduce_295),
	(296 , happyReduce_296),
	(297 , happyReduce_297),
	(298 , happyReduce_298),
	(299 , happyReduce_299),
	(300 , happyReduce_300),
	(301 , happyReduce_301),
	(302 , happyReduce_302),
	(303 , happyReduce_303),
	(304 , happyReduce_304),
	(305 , happyReduce_305),
	(306 , happyReduce_306),
	(307 , happyReduce_307),
	(308 , happyReduce_308),
	(309 , happyReduce_309),
	(310 , happyReduce_310),
	(311 , happyReduce_311),
	(312 , happyReduce_312),
	(313 , happyReduce_313),
	(314 , happyReduce_314),
	(315 , happyReduce_315),
	(316 , happyReduce_316),
	(317 , happyReduce_317),
	(318 , happyReduce_318),
	(319 , happyReduce_319),
	(320 , happyReduce_320),
	(321 , happyReduce_321),
	(322 , happyReduce_322),
	(323 , happyReduce_323),
	(324 , happyReduce_324),
	(325 , happyReduce_325),
	(326 , happyReduce_326),
	(327 , happyReduce_327),
	(328 , happyReduce_328),
	(329 , happyReduce_329),
	(330 , happyReduce_330),
	(331 , happyReduce_331),
	(332 , happyReduce_332),
	(333 , happyReduce_333),
	(334 , happyReduce_334),
	(335 , happyReduce_335),
	(336 , happyReduce_336),
	(337 , happyReduce_337),
	(338 , happyReduce_338),
	(339 , happyReduce_339),
	(340 , happyReduce_340),
	(341 , happyReduce_341),
	(342 , happyReduce_342),
	(343 , happyReduce_343),
	(344 , happyReduce_344),
	(345 , happyReduce_345),
	(346 , happyReduce_346),
	(347 , happyReduce_347),
	(348 , happyReduce_348),
	(349 , happyReduce_349),
	(350 , happyReduce_350),
	(351 , happyReduce_351),
	(352 , happyReduce_352),
	(353 , happyReduce_353),
	(354 , happyReduce_354),
	(355 , happyReduce_355),
	(356 , happyReduce_356),
	(357 , happyReduce_357),
	(358 , happyReduce_358),
	(359 , happyReduce_359),
	(360 , happyReduce_360),
	(361 , happyReduce_361),
	(362 , happyReduce_362),
	(363 , happyReduce_363),
	(364 , happyReduce_364),
	(365 , happyReduce_365),
	(366 , happyReduce_366),
	(367 , happyReduce_367),
	(368 , happyReduce_368),
	(369 , happyReduce_369),
	(370 , happyReduce_370),
	(371 , happyReduce_371),
	(372 , happyReduce_372),
	(373 , happyReduce_373),
	(374 , happyReduce_374),
	(375 , happyReduce_375),
	(376 , happyReduce_376),
	(377 , happyReduce_377),
	(378 , happyReduce_378),
	(379 , happyReduce_379),
	(380 , happyReduce_380),
	(381 , happyReduce_381),
	(382 , happyReduce_382),
	(383 , happyReduce_383),
	(384 , happyReduce_384),
	(385 , happyReduce_385),
	(386 , happyReduce_386),
	(387 , happyReduce_387),
	(388 , happyReduce_388),
	(389 , happyReduce_389),
	(390 , happyReduce_390),
	(391 , happyReduce_391),
	(392 , happyReduce_392),
	(393 , happyReduce_393),
	(394 , happyReduce_394),
	(395 , happyReduce_395),
	(396 , happyReduce_396),
	(397 , happyReduce_397),
	(398 , happyReduce_398),
	(399 , happyReduce_399),
	(400 , happyReduce_400),
	(401 , happyReduce_401),
	(402 , happyReduce_402),
	(403 , happyReduce_403),
	(404 , happyReduce_404),
	(405 , happyReduce_405),
	(406 , happyReduce_406),
	(407 , happyReduce_407),
	(408 , happyReduce_408),
	(409 , happyReduce_409),
	(410 , happyReduce_410),
	(411 , happyReduce_411),
	(412 , happyReduce_412),
	(413 , happyReduce_413),
	(414 , happyReduce_414),
	(415 , happyReduce_415),
	(416 , happyReduce_416),
	(417 , happyReduce_417),
	(418 , happyReduce_418),
	(419 , happyReduce_419),
	(420 , happyReduce_420),
	(421 , happyReduce_421),
	(422 , happyReduce_422),
	(423 , happyReduce_423),
	(424 , happyReduce_424),
	(425 , happyReduce_425),
	(426 , happyReduce_426),
	(427 , happyReduce_427),
	(428 , happyReduce_428),
	(429 , happyReduce_429),
	(430 , happyReduce_430),
	(431 , happyReduce_431),
	(432 , happyReduce_432),
	(433 , happyReduce_433),
	(434 , happyReduce_434),
	(435 , happyReduce_435),
	(436 , happyReduce_436),
	(437 , happyReduce_437),
	(438 , happyReduce_438),
	(439 , happyReduce_439),
	(440 , happyReduce_440),
	(441 , happyReduce_441),
	(442 , happyReduce_442),
	(443 , happyReduce_443),
	(444 , happyReduce_444),
	(445 , happyReduce_445),
	(446 , happyReduce_446),
	(447 , happyReduce_447),
	(448 , happyReduce_448),
	(449 , happyReduce_449),
	(450 , happyReduce_450),
	(451 , happyReduce_451)
	]

happy_n_terms = 140 :: Int
happy_n_nonterms = 104 :: Int

happyReduce_11 = happySpecReduce_1  0# happyReduction_11
happyReduction_11 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn14
		 (Id (getID happy_var_1) (locOf happy_var_1)
	)}

happyReduce_12 = happySpecReduce_1  0# happyReduction_12
happyReduction_12 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn14
		 (AntiId (getANTI_ID happy_var_1) (locOf happy_var_1)
	)}

happyReduce_13 = happySpecReduce_1  1# happyReduction_13
happyReduction_13 happy_x_1
	 =  case happyOut14 happy_x_1 of { happy_var_1 -> 
	happyIn15
		 (happy_var_1
	)}

happyReduce_14 = happySpecReduce_1  1# happyReduction_14
happyReduction_14 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn15
		 (Id (getNAMED happy_var_1) (locOf happy_var_1)
	)}

happyReduce_15 = happySpecReduce_1  2# happyReduction_15
happyReduction_15 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (let (s, sign, n) = getINT happy_var_1
                        in
                          IntConst s sign n (locOf happy_var_1)
	)}

happyReduce_16 = happySpecReduce_1  2# happyReduction_16
happyReduction_16 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (let (s, sign, n) = getLONG happy_var_1
                        in
                          LongIntConst s sign n (locOf happy_var_1)
	)}

happyReduce_17 = happySpecReduce_1  2# happyReduction_17
happyReduction_17 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (let (s, sign, n) = getLONG_LONG happy_var_1
                        in
                          LongLongIntConst s sign n (locOf happy_var_1)
	)}

happyReduce_18 = happySpecReduce_1  2# happyReduction_18
happyReduction_18 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (let (s, n) = getFLOAT happy_var_1
                        in
                          FloatConst s n (locOf happy_var_1)
	)}

happyReduce_19 = happySpecReduce_1  2# happyReduction_19
happyReduction_19 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (let (s, n) = getDOUBLE happy_var_1
                        in
                          DoubleConst s n (locOf happy_var_1)
	)}

happyReduce_20 = happySpecReduce_1  2# happyReduction_20
happyReduction_20 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (let (s, n) = getLONG_DOUBLE happy_var_1
                        in
                          LongDoubleConst s n (locOf happy_var_1)
	)}

happyReduce_21 = happySpecReduce_1  2# happyReduction_21
happyReduction_21 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (let (s, c) = getCHAR happy_var_1
                        in
                          CharConst s c (locOf happy_var_1)
	)}

happyReduce_22 = happySpecReduce_1  2# happyReduction_22
happyReduction_22 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (AntiInt (getANTI_INT happy_var_1) (locOf happy_var_1)
	)}

happyReduce_23 = happySpecReduce_1  2# happyReduction_23
happyReduction_23 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (AntiUInt (getANTI_UINT happy_var_1) (locOf happy_var_1)
	)}

happyReduce_24 = happySpecReduce_1  2# happyReduction_24
happyReduction_24 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (AntiLInt (getANTI_LINT happy_var_1) (locOf happy_var_1)
	)}

happyReduce_25 = happySpecReduce_1  2# happyReduction_25
happyReduction_25 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (AntiULInt (getANTI_ULINT happy_var_1) (locOf happy_var_1)
	)}

happyReduce_26 = happySpecReduce_1  2# happyReduction_26
happyReduction_26 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (AntiFloat (getANTI_FLOAT happy_var_1) (locOf happy_var_1)
	)}

happyReduce_27 = happySpecReduce_1  2# happyReduction_27
happyReduction_27 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (AntiDouble (getANTI_DOUBLE happy_var_1) (locOf happy_var_1)
	)}

happyReduce_28 = happySpecReduce_1  2# happyReduction_28
happyReduction_28 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (AntiLongDouble (getANTI_LONG_DOUBLE happy_var_1) (locOf happy_var_1)
	)}

happyReduce_29 = happySpecReduce_1  2# happyReduction_29
happyReduction_29 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (AntiChar (getANTI_CHAR happy_var_1) (locOf happy_var_1)
	)}

happyReduce_30 = happySpecReduce_1  2# happyReduction_30
happyReduction_30 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (AntiString (getANTI_STRING happy_var_1) (locOf happy_var_1)
	)}

happyReduce_31 = happySpecReduce_1  3# happyReduction_31
happyReduction_31 happy_x_1
	 =  case happyOut14 happy_x_1 of { happy_var_1 -> 
	happyIn17
		 (Var happy_var_1 (locOf happy_var_1)
	)}

happyReduce_32 = happySpecReduce_1  3# happyReduction_32
happyReduction_32 happy_x_1
	 =  case happyOut16 happy_x_1 of { happy_var_1 -> 
	happyIn17
		 (Const happy_var_1 (locOf happy_var_1)
	)}

happyReduce_33 = happySpecReduce_1  3# happyReduction_33
happyReduction_33 happy_x_1
	 =  case happyOut18 happy_x_1 of { happy_var_1 -> 
	happyIn17
		 (let  {  ss   = rev happy_var_1
             ;  loc  = locOf ss
             ;  raw  = map (fst . unLoc) ss
             ;  s    = (concat . intersperse " " . map (snd . unLoc)) ss
             }
        in
          Const (StringConst raw s loc) loc
	)}

happyReduce_34 = happySpecReduce_3  3# happyReduction_34
happyReduction_34 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut36 happy_x_2 of { happy_var_2 -> 
	happyIn17
		 (happy_var_2
	)}

happyReduce_35 = happyMonadReduce 3# 3# happyReduction_35
happyReduction_35 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_2 of { happy_var_2 -> 
	( unclosed (happy_var_1 <--> happy_var_2) "(")}}
	) (\r -> happyReturn (happyIn17 r))

happyReduce_36 = happySpecReduce_3  3# happyReduction_36
happyReduction_36 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut90 happy_x_2 of { happy_var_2 -> 
	case happyOutTok happy_x_3 of { happy_var_3 -> 
	happyIn17
		 (let Block items _ = happy_var_2
        in
          StmExpr items (happy_var_1 <--> happy_var_3)
	)}}}

happyReduce_37 = happySpecReduce_1  3# happyReduction_37
happyReduction_37 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn17
		 (AntiExp (getANTI_EXP happy_var_1) (locOf happy_var_1)
	)}

happyReduce_38 = happySpecReduce_1  4# happyReduction_38
happyReduction_38 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn18
		 (rsingleton (L (getLoc happy_var_1) (getSTRING happy_var_1))
	)}

happyReduce_39 = happySpecReduce_2  4# happyReduction_39
happyReduction_39 happy_x_2
	happy_x_1
	 =  case happyOut18 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { happy_var_2 -> 
	happyIn18
		 (rcons (L (getLoc happy_var_2) (getSTRING happy_var_2)) happy_var_1
	)}}

happyReduce_40 = happySpecReduce_1  5# happyReduction_40
happyReduction_40 happy_x_1
	 =  case happyOut17 happy_x_1 of { happy_var_1 -> 
	happyIn19
		 (happy_var_1
	)}

happyReduce_41 = happyMonadReduce 3# 5# happyReduction_41
happyReduction_41 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut19 happy_x_1 of { happy_var_1 -> 
	( unclosed (locOf happy_var_1) "[")}
	) (\r -> happyReturn (happyIn19 r))

happyReduce_42 = happyReduce 4# 5# happyReduction_42
happyReduction_42 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut19 happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	case happyOutTok happy_x_4 of { happy_var_4 -> 
	happyIn19
		 (Index happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_4)
	) `HappyStk` happyRest}}}

happyReduce_43 = happyMonadReduce 3# 5# happyReduction_43
happyReduction_43 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_2 of { happy_var_2 -> 
	( unclosed (locOf happy_var_2) "(")}
	) (\r -> happyReturn (happyIn19 r))

happyReduce_44 = happySpecReduce_3  5# happyReduction_44
happyReduction_44 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut19 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_3 of { happy_var_3 -> 
	happyIn19
		 (FnCall happy_var_1 [] (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_45 = happyMonadReduce 4# 5# happyReduction_45
happyReduction_45 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_2 of { happy_var_2 -> 
	case happyOut21 happy_x_3 of { happy_var_3 -> 
	( unclosed (happy_var_2 <--> rev happy_var_3) "(")}}
	) (\r -> happyReturn (happyIn19 r))

happyReduce_46 = happyReduce 4# 5# happyReduction_46
happyReduction_46 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut19 happy_x_1 of { happy_var_1 -> 
	case happyOut21 happy_x_3 of { happy_var_3 -> 
	case happyOutTok happy_x_4 of { happy_var_4 -> 
	happyIn19
		 (FnCall happy_var_1 (rev happy_var_3) (happy_var_1 <--> happy_var_4)
	) `HappyStk` happyRest}}}

happyReduce_47 = happyMonadReduce 4# 5# happyReduction_47
happyReduction_47 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_2 of { happy_var_2 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	( unclosed (happy_var_2 <--> happy_var_3) "<<<")}}
	) (\r -> happyReturn (happyIn19 r))

happyReduce_48 = happyReduce 6# 5# happyReduction_48
happyReduction_48 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut19 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	case happyOutTok happy_x_6 of { happy_var_6 -> 
	happyIn19
		 (CudaCall happy_var_1 happy_var_3 [] (happy_var_1 <--> happy_var_6)
	) `HappyStk` happyRest}}}

happyReduce_49 = happyMonadReduce 7# 5# happyReduction_49
happyReduction_49 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_5 of { happy_var_5 -> 
	case happyOut21 happy_x_6 of { happy_var_6 -> 
	( unclosed (happy_var_5 <--> rev happy_var_6) "(")}}
	) (\r -> happyReturn (happyIn19 r))

happyReduce_50 = happyReduce 7# 5# happyReduction_50
happyReduction_50 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut19 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	case happyOut21 happy_x_6 of { happy_var_6 -> 
	case happyOutTok happy_x_7 of { happy_var_7 -> 
	happyIn19
		 (CudaCall happy_var_1 happy_var_3 (rev happy_var_6) (happy_var_1 <--> happy_var_7)
	) `HappyStk` happyRest}}}}

happyReduce_51 = happySpecReduce_3  5# happyReduction_51
happyReduction_51 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut19 happy_x_1 of { happy_var_1 -> 
	case happyOut15 happy_x_3 of { happy_var_3 -> 
	happyIn19
		 (Member happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_52 = happySpecReduce_3  5# happyReduction_52
happyReduction_52 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut19 happy_x_1 of { happy_var_1 -> 
	case happyOut15 happy_x_3 of { happy_var_3 -> 
	happyIn19
		 (PtrMember happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_53 = happySpecReduce_2  5# happyReduction_53
happyReduction_53 happy_x_2
	happy_x_1
	 =  case happyOut19 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { happy_var_2 -> 
	happyIn19
		 (PostInc happy_var_1 (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_54 = happySpecReduce_2  5# happyReduction_54
happyReduction_54 happy_x_2
	happy_x_1
	 =  case happyOut19 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { happy_var_2 -> 
	happyIn19
		 (PostDec happy_var_1 (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_55 = happyReduce 6# 5# happyReduction_55
happyReduction_55 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut79 happy_x_2 of { happy_var_2 -> 
	case happyOut84 happy_x_5 of { happy_var_5 -> 
	case happyOutTok happy_x_6 of { happy_var_6 -> 
	happyIn19
		 (CompoundLit (happy_var_2 :: Type) (rev happy_var_5) (happy_var_1 <--> happy_var_6)
	) `HappyStk` happyRest}}}}

happyReduce_56 = happyReduce 7# 5# happyReduction_56
happyReduction_56 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut79 happy_x_2 of { happy_var_2 -> 
	case happyOut84 happy_x_5 of { happy_var_5 -> 
	case happyOutTok happy_x_7 of { happy_var_7 -> 
	happyIn19
		 (CompoundLit happy_var_2 (rev happy_var_5) (happy_var_1 <--> happy_var_7)
	) `HappyStk` happyRest}}}}

happyReduce_57 = happyReduce 6# 5# happyReduction_57
happyReduction_57 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	case happyOut77 happy_x_5 of { happy_var_5 -> 
	case happyOutTok happy_x_6 of { happy_var_6 -> 
	happyIn19
		 (BuiltinVaArg happy_var_3 happy_var_5 (happy_var_1 <--> happy_var_6)
	) `HappyStk` happyRest}}}}

happyReduce_58 = happyMonadReduce 1# 6# happyReduction_58
happyReduction_58 (happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut21 happy_x_1 of { happy_var_1 -> 
	(do {  let args = rev happy_var_1
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
         })}
	) (\r -> happyReturn (happyIn20 r))

happyReduce_59 = happySpecReduce_1  7# happyReduction_59
happyReduction_59 happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	happyIn21
		 (rsingleton happy_var_1
	)}

happyReduce_60 = happySpecReduce_1  7# happyReduction_60
happyReduction_60 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn21
		 (rsingleton (AntiArgs (getANTI_ARGS happy_var_1) (locOf happy_var_1))
	)}

happyReduce_61 = happySpecReduce_3  7# happyReduction_61
happyReduction_61 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn21
		 (rcons happy_var_3 happy_var_1
	)}}

happyReduce_62 = happySpecReduce_3  7# happyReduction_62
happyReduction_62 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_3 of { happy_var_3 -> 
	happyIn21
		 (rcons (AntiArgs (getANTI_ARGS happy_var_3) (locOf happy_var_3)) happy_var_1
	)}}

happyReduce_63 = happySpecReduce_1  8# happyReduction_63
happyReduction_63 happy_x_1
	 =  case happyOut19 happy_x_1 of { happy_var_1 -> 
	happyIn22
		 (happy_var_1
	)}

happyReduce_64 = happySpecReduce_2  8# happyReduction_64
happyReduction_64 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut22 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (PreInc happy_var_2 (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_65 = happySpecReduce_2  8# happyReduction_65
happyReduction_65 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut22 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (PreDec happy_var_2 (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_66 = happySpecReduce_2  8# happyReduction_66
happyReduction_66 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut23 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (UnOp AddrOf happy_var_2 (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_67 = happySpecReduce_2  8# happyReduction_67
happyReduction_67 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut23 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (UnOp Deref happy_var_2 (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_68 = happySpecReduce_2  8# happyReduction_68
happyReduction_68 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut23 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (UnOp Positive happy_var_2 (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_69 = happySpecReduce_2  8# happyReduction_69
happyReduction_69 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut23 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (UnOp Negate happy_var_2 (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_70 = happySpecReduce_2  8# happyReduction_70
happyReduction_70 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut23 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (UnOp Not happy_var_2 (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_71 = happySpecReduce_2  8# happyReduction_71
happyReduction_71 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut23 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (UnOp Lnot happy_var_2 (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_72 = happySpecReduce_2  8# happyReduction_72
happyReduction_72 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut22 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (SizeofExp happy_var_2 (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_73 = happyReduce 4# 8# happyReduction_73
happyReduction_73 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut79 happy_x_3 of { happy_var_3 -> 
	case happyOutTok happy_x_4 of { happy_var_4 -> 
	happyIn22
		 (SizeofType happy_var_3 (happy_var_1 <--> happy_var_4)
	) `HappyStk` happyRest}}}

happyReduce_74 = happyMonadReduce 4# 8# happyReduction_74
happyReduction_74 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_2 of { happy_var_2 -> 
	case happyOut79 happy_x_3 of { happy_var_3 -> 
	( unclosed (happy_var_2 <--> happy_var_3) "(")}}
	) (\r -> happyReturn (happyIn22 r))

happyReduce_75 = happySpecReduce_1  9# happyReduction_75
happyReduction_75 happy_x_1
	 =  case happyOut22 happy_x_1 of { happy_var_1 -> 
	happyIn23
		 (happy_var_1
	)}

happyReduce_76 = happyReduce 4# 9# happyReduction_76
happyReduction_76 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut79 happy_x_2 of { happy_var_2 -> 
	case happyOut23 happy_x_4 of { happy_var_4 -> 
	happyIn23
		 (Cast happy_var_2 happy_var_4 (happy_var_1 <--> happy_var_4)
	) `HappyStk` happyRest}}}

happyReduce_77 = happyMonadReduce 3# 9# happyReduction_77
happyReduction_77 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut79 happy_x_2 of { happy_var_2 -> 
	( unclosed (happy_var_1 <--> happy_var_2) "(")}}
	) (\r -> happyReturn (happyIn23 r))

happyReduce_78 = happySpecReduce_1  10# happyReduction_78
happyReduction_78 happy_x_1
	 =  case happyOut23 happy_x_1 of { happy_var_1 -> 
	happyIn24
		 (happy_var_1
	)}

happyReduce_79 = happySpecReduce_3  10# happyReduction_79
happyReduction_79 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut24 happy_x_1 of { happy_var_1 -> 
	case happyOut23 happy_x_3 of { happy_var_3 -> 
	happyIn24
		 (BinOp Mul happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_80 = happySpecReduce_3  10# happyReduction_80
happyReduction_80 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut24 happy_x_1 of { happy_var_1 -> 
	case happyOut23 happy_x_3 of { happy_var_3 -> 
	happyIn24
		 (BinOp Div happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_81 = happySpecReduce_3  10# happyReduction_81
happyReduction_81 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut24 happy_x_1 of { happy_var_1 -> 
	case happyOut23 happy_x_3 of { happy_var_3 -> 
	happyIn24
		 (BinOp Mod happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_82 = happySpecReduce_1  11# happyReduction_82
happyReduction_82 happy_x_1
	 =  case happyOut24 happy_x_1 of { happy_var_1 -> 
	happyIn25
		 (happy_var_1
	)}

happyReduce_83 = happySpecReduce_3  11# happyReduction_83
happyReduction_83 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut25 happy_x_1 of { happy_var_1 -> 
	case happyOut24 happy_x_3 of { happy_var_3 -> 
	happyIn25
		 (BinOp Add happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_84 = happySpecReduce_3  11# happyReduction_84
happyReduction_84 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut25 happy_x_1 of { happy_var_1 -> 
	case happyOut24 happy_x_3 of { happy_var_3 -> 
	happyIn25
		 (BinOp Sub happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_85 = happySpecReduce_1  12# happyReduction_85
happyReduction_85 happy_x_1
	 =  case happyOut25 happy_x_1 of { happy_var_1 -> 
	happyIn26
		 (happy_var_1
	)}

happyReduce_86 = happySpecReduce_3  12# happyReduction_86
happyReduction_86 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut26 happy_x_1 of { happy_var_1 -> 
	case happyOut25 happy_x_3 of { happy_var_3 -> 
	happyIn26
		 (BinOp Lsh happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_87 = happySpecReduce_3  12# happyReduction_87
happyReduction_87 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut26 happy_x_1 of { happy_var_1 -> 
	case happyOut25 happy_x_3 of { happy_var_3 -> 
	happyIn26
		 (BinOp Rsh happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_88 = happySpecReduce_1  13# happyReduction_88
happyReduction_88 happy_x_1
	 =  case happyOut26 happy_x_1 of { happy_var_1 -> 
	happyIn27
		 (happy_var_1
	)}

happyReduce_89 = happySpecReduce_3  13# happyReduction_89
happyReduction_89 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	case happyOut26 happy_x_3 of { happy_var_3 -> 
	happyIn27
		 (BinOp Lt happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_90 = happySpecReduce_3  13# happyReduction_90
happyReduction_90 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	case happyOut26 happy_x_3 of { happy_var_3 -> 
	happyIn27
		 (BinOp Gt happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_91 = happySpecReduce_3  13# happyReduction_91
happyReduction_91 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	case happyOut26 happy_x_3 of { happy_var_3 -> 
	happyIn27
		 (BinOp Le happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_92 = happySpecReduce_3  13# happyReduction_92
happyReduction_92 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	case happyOut26 happy_x_3 of { happy_var_3 -> 
	happyIn27
		 (BinOp Ge happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_93 = happySpecReduce_1  14# happyReduction_93
happyReduction_93 happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	happyIn28
		 (happy_var_1
	)}

happyReduce_94 = happySpecReduce_3  14# happyReduction_94
happyReduction_94 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	case happyOut27 happy_x_3 of { happy_var_3 -> 
	happyIn28
		 (BinOp Eq happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_95 = happySpecReduce_3  14# happyReduction_95
happyReduction_95 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	case happyOut27 happy_x_3 of { happy_var_3 -> 
	happyIn28
		 (BinOp Ne happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_96 = happySpecReduce_1  15# happyReduction_96
happyReduction_96 happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	happyIn29
		 (happy_var_1
	)}

happyReduce_97 = happySpecReduce_3  15# happyReduction_97
happyReduction_97 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut29 happy_x_1 of { happy_var_1 -> 
	case happyOut28 happy_x_3 of { happy_var_3 -> 
	happyIn29
		 (BinOp And happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_98 = happySpecReduce_1  16# happyReduction_98
happyReduction_98 happy_x_1
	 =  case happyOut29 happy_x_1 of { happy_var_1 -> 
	happyIn30
		 (happy_var_1
	)}

happyReduce_99 = happySpecReduce_3  16# happyReduction_99
happyReduction_99 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	case happyOut29 happy_x_3 of { happy_var_3 -> 
	happyIn30
		 (BinOp Xor happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_100 = happySpecReduce_1  17# happyReduction_100
happyReduction_100 happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	happyIn31
		 (happy_var_1
	)}

happyReduce_101 = happySpecReduce_3  17# happyReduction_101
happyReduction_101 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	case happyOut30 happy_x_3 of { happy_var_3 -> 
	happyIn31
		 (BinOp Or happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_102 = happySpecReduce_1  18# happyReduction_102
happyReduction_102 happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	happyIn32
		 (happy_var_1
	)}

happyReduce_103 = happySpecReduce_3  18# happyReduction_103
happyReduction_103 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut32 happy_x_1 of { happy_var_1 -> 
	case happyOut31 happy_x_3 of { happy_var_3 -> 
	happyIn32
		 (BinOp Land happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_104 = happySpecReduce_1  19# happyReduction_104
happyReduction_104 happy_x_1
	 =  case happyOut32 happy_x_1 of { happy_var_1 -> 
	happyIn33
		 (happy_var_1
	)}

happyReduce_105 = happySpecReduce_3  19# happyReduction_105
happyReduction_105 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	case happyOut32 happy_x_3 of { happy_var_3 -> 
	happyIn33
		 (BinOp Lor happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_106 = happySpecReduce_1  20# happyReduction_106
happyReduction_106 happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	happyIn34
		 (happy_var_1
	)}

happyReduce_107 = happyReduce 5# 20# happyReduction_107
happyReduction_107 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut33 happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	case happyOut34 happy_x_5 of { happy_var_5 -> 
	happyIn34
		 (Cond happy_var_1 happy_var_3 happy_var_5 (happy_var_1 <--> happy_var_5)
	) `HappyStk` happyRest}}}

happyReduce_108 = happySpecReduce_1  21# happyReduction_108
happyReduction_108 happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	happyIn35
		 (happy_var_1
	)}

happyReduce_109 = happySpecReduce_3  21# happyReduction_109
happyReduction_109 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (Assign happy_var_1 JustAssign happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_110 = happySpecReduce_3  21# happyReduction_110
happyReduction_110 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (Assign happy_var_1 MulAssign happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_111 = happySpecReduce_3  21# happyReduction_111
happyReduction_111 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (Assign happy_var_1 DivAssign happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_112 = happySpecReduce_3  21# happyReduction_112
happyReduction_112 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (Assign happy_var_1 ModAssign happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_113 = happySpecReduce_3  21# happyReduction_113
happyReduction_113 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (Assign happy_var_1 AddAssign happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_114 = happySpecReduce_3  21# happyReduction_114
happyReduction_114 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (Assign happy_var_1 SubAssign happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_115 = happySpecReduce_3  21# happyReduction_115
happyReduction_115 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (Assign happy_var_1 LshAssign happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_116 = happySpecReduce_3  21# happyReduction_116
happyReduction_116 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (Assign happy_var_1 RshAssign happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_117 = happySpecReduce_3  21# happyReduction_117
happyReduction_117 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (Assign happy_var_1 AndAssign happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_118 = happySpecReduce_3  21# happyReduction_118
happyReduction_118 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (Assign happy_var_1 XorAssign happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_119 = happySpecReduce_3  21# happyReduction_119
happyReduction_119 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (Assign happy_var_1 OrAssign happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_120 = happySpecReduce_1  22# happyReduction_120
happyReduction_120 happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	happyIn36
		 (happy_var_1
	)}

happyReduce_121 = happySpecReduce_3  22# happyReduction_121
happyReduction_121 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut36 happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn36
		 (Seq happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_122 = happySpecReduce_0  23# happyReduction_122
happyReduction_122  =  happyIn37
		 (Nothing
	)

happyReduce_123 = happySpecReduce_1  23# happyReduction_123
happyReduction_123 happy_x_1
	 =  case happyOut36 happy_x_1 of { happy_var_1 -> 
	happyIn37
		 (Just happy_var_1
	)}

happyReduce_124 = happySpecReduce_1  24# happyReduction_124
happyReduction_124 happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	happyIn38
		 (happy_var_1
	)}

happyReduce_125 = happySpecReduce_2  25# happyReduction_125
happyReduction_125 happy_x_2
	happy_x_1
	 =  case happyOut40 happy_x_1 of { happy_var_1 -> 
	happyIn39
		 (happy_var_1
	)}

happyReduce_126 = happyMonadReduce 1# 26# happyReduction_126
happyReduction_126 (happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut41 happy_x_1 of { happy_var_1 -> 
	( do{ let (dspec, decl)  = happy_var_1
           ; checkInitGroup dspec decl [] []
           })}
	) (\r -> happyReturn (happyIn40 r))

happyReduce_127 = happyMonadReduce 2# 26# happyReduction_127
happyReduction_127 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut104 happy_x_2 of { happy_var_2 -> 
	( do{ let (dspec, decl)  = happy_var_1
           ; checkInitGroup dspec decl happy_var_2 []
           })}}
	) (\r -> happyReturn (happyIn40 r))

happyReduce_128 = happyMonadReduce 2# 26# happyReduction_128
happyReduction_128 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut46 happy_x_2 of { happy_var_2 -> 
	( do{ let (dspec, decl)  = happy_var_1
           ; let inits          = rev happy_var_2
           ; checkInitGroup dspec decl [] (rev happy_var_2)
           })}}
	) (\r -> happyReturn (happyIn40 r))

happyReduce_129 = happyMonadReduce 3# 26# happyReduction_129
happyReduction_129 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut104 happy_x_2 of { happy_var_2 -> 
	case happyOut46 happy_x_3 of { happy_var_3 -> 
	( do{ let (dspec, decl) = happy_var_1
           ; checkInitGroup dspec decl happy_var_2 (rev happy_var_3)
           })}}}
	) (\r -> happyReturn (happyIn40 r))

happyReduce_130 = happyMonadReduce 2# 26# happyReduction_130
happyReduction_130 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut41 happy_x_1 of { happy_var_1 -> 
	( do{ let (_, decl)  = happy_var_1
           ; expected (locOf decl) ["';'"]
           })}
	) (\r -> happyReturn (happyIn40 r))

happyReduce_131 = happySpecReduce_1  26# happyReduction_131
happyReduction_131 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn40
		 (AntiDecl (getANTI_DECL happy_var_1) (locOf happy_var_1)
	)}

happyReduce_132 = happySpecReduce_1  27# happyReduction_132
happyReduction_132 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn41
		 (let  {  v    = getANTI_TYPE happy_var_1
             ;  loc  = locOf happy_var_1
             }
        in
          (AntiTypeDeclSpec [] [] v loc, AntiTypeDecl v loc)
	)}

happyReduce_133 = happySpecReduce_2  27# happyReduction_133
happyReduction_133 happy_x_2
	happy_x_1
	 =  case happyOut45 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { happy_var_2 -> 
	happyIn41
		 (let { storage   = mkStorage happy_var_1
            ; typeQuals = mkTypeQuals happy_var_1
            ; v         = getANTI_TYPE happy_var_2
            ; loc       = happy_var_1 <--> happy_var_2
            }
        in
          (AntiTypeDeclSpec storage typeQuals v loc, AntiTypeDecl v loc)
	)}}

happyReduce_134 = happySpecReduce_1  27# happyReduction_134
happyReduction_134 happy_x_1
	 =  case happyOut42 happy_x_1 of { happy_var_1 -> 
	happyIn41
		 (happy_var_1
	)}

happyReduce_135 = happySpecReduce_1  27# happyReduction_135
happyReduction_135 happy_x_1
	 =  case happyOut43 happy_x_1 of { happy_var_1 -> 
	happyIn41
		 (happy_var_1
	)}

happyReduce_136 = happySpecReduce_1  28# happyReduction_136
happyReduction_136 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn42
		 (let dspec = AntiDeclSpec (getANTI_SPEC happy_var_1) (locOf happy_var_1)
        in
          (dspec, DeclRoot (locOf happy_var_1))
	)}

happyReduce_137 = happyMonadReduce 1# 28# happyReduction_137
happyReduction_137 (happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut45 happy_x_1 of { happy_var_1 -> 
	( do{ dspec <- mkDeclSpec happy_var_1
           ; return (dspec, DeclRoot (locOf happy_var_1))
           })}
	) (\r -> happyReturn (happyIn42 r))

happyReduce_138 = happyMonadReduce 1# 28# happyReduction_138
happyReduction_138 (happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut50 happy_x_1 of { happy_var_1 -> 
	( do{ dspec <- mkDeclSpec [happy_var_1]
           ; return (dspec, DeclRoot (locOf happy_var_1) )
           })}
	) (\r -> happyReturn (happyIn42 r))

happyReduce_139 = happyMonadReduce 2# 28# happyReduction_139
happyReduction_139 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut50 happy_x_1 of { happy_var_1 -> 
	case happyOut44 happy_x_2 of { happy_var_2 -> 
	( do{ dspec <- mkDeclSpec (happy_var_1 : happy_var_2)
           ; return (dspec, DeclRoot (happy_var_1 <--> happy_var_2))
           })}}
	) (\r -> happyReturn (happyIn42 r))

happyReduce_140 = happyMonadReduce 2# 28# happyReduction_140
happyReduction_140 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut45 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_2 of { happy_var_2 -> 
	( do{ dspec <- mkDeclSpec (happy_var_1 ++ [happy_var_2])
           ; return $(dspec, DeclRoot (happy_var_1 <--> happy_var_2))
           })}}
	) (\r -> happyReturn (happyIn42 r))

happyReduce_141 = happyMonadReduce 3# 28# happyReduction_141
happyReduction_141 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut45 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_2 of { happy_var_2 -> 
	case happyOut44 happy_x_3 of { happy_var_3 -> 
	( do{ dspec <- mkDeclSpec (happy_var_1 ++ happy_var_2 : happy_var_3)
           ; return (dspec, DeclRoot (happy_var_1 <--> happy_var_3))
           })}}}
	) (\r -> happyReturn (happyIn42 r))

happyReduce_142 = happyMonadReduce 1# 29# happyReduction_142
happyReduction_142 (happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut82 happy_x_1 of { happy_var_1 -> 
	( do{ dspec <- mkDeclSpec [happy_var_1]
           ; return (dspec, DeclRoot (locOf happy_var_1))
           })}
	) (\r -> happyReturn (happyIn43 r))

happyReduce_143 = happyMonadReduce 2# 29# happyReduction_143
happyReduction_143 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut82 happy_x_1 of { happy_var_1 -> 
	case happyOut45 happy_x_2 of { happy_var_2 -> 
	( do{ dspec <- mkDeclSpec (happy_var_1 : happy_var_2)
           ; return (dspec, DeclRoot (happy_var_1 <--> happy_var_2))
           })}}
	) (\r -> happyReturn (happyIn43 r))

happyReduce_144 = happyMonadReduce 2# 29# happyReduction_144
happyReduction_144 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut45 happy_x_1 of { happy_var_1 -> 
	case happyOut82 happy_x_2 of { happy_var_2 -> 
	( do{ dspec <- mkDeclSpec (happy_var_1 ++ [happy_var_2])
           ; return (dspec, DeclRoot (happy_var_1 <--> happy_var_2))
           })}}
	) (\r -> happyReturn (happyIn43 r))

happyReduce_145 = happyMonadReduce 3# 29# happyReduction_145
happyReduction_145 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut45 happy_x_1 of { happy_var_1 -> 
	case happyOut82 happy_x_2 of { happy_var_2 -> 
	case happyOut45 happy_x_3 of { happy_var_3 -> 
	( do{ dspec <- mkDeclSpec (happy_var_1 ++ happy_var_2 : happy_var_3)
           ; return (dspec, DeclRoot (happy_var_1 <--> happy_var_3))
           })}}}
	) (\r -> happyReturn (happyIn43 r))

happyReduce_146 = happySpecReduce_1  30# happyReduction_146
happyReduction_146 happy_x_1
	 =  case happyOut49 happy_x_1 of { happy_var_1 -> 
	happyIn44
		 ([happy_var_1]
	)}

happyReduce_147 = happySpecReduce_2  30# happyReduction_147
happyReduction_147 happy_x_2
	happy_x_1
	 =  case happyOut49 happy_x_1 of { happy_var_1 -> 
	case happyOut44 happy_x_2 of { happy_var_2 -> 
	happyIn44
		 (happy_var_1 : happy_var_2
	)}}

happyReduce_148 = happySpecReduce_1  30# happyReduction_148
happyReduction_148 happy_x_1
	 =  case happyOut50 happy_x_1 of { happy_var_1 -> 
	happyIn44
		 ([happy_var_1]
	)}

happyReduce_149 = happySpecReduce_2  30# happyReduction_149
happyReduction_149 happy_x_2
	happy_x_1
	 =  case happyOut50 happy_x_1 of { happy_var_1 -> 
	case happyOut44 happy_x_2 of { happy_var_2 -> 
	happyIn44
		 (happy_var_1 : happy_var_2
	)}}

happyReduce_150 = happySpecReduce_1  30# happyReduction_150
happyReduction_150 happy_x_1
	 =  case happyOut62 happy_x_1 of { happy_var_1 -> 
	happyIn44
		 ([happy_var_1]
	)}

happyReduce_151 = happySpecReduce_2  30# happyReduction_151
happyReduction_151 happy_x_2
	happy_x_1
	 =  case happyOut62 happy_x_1 of { happy_var_1 -> 
	case happyOut44 happy_x_2 of { happy_var_2 -> 
	happyIn44
		 (happy_var_1 : happy_var_2
	)}}

happyReduce_152 = happySpecReduce_1  31# happyReduction_152
happyReduction_152 happy_x_1
	 =  case happyOut49 happy_x_1 of { happy_var_1 -> 
	happyIn45
		 ([happy_var_1]
	)}

happyReduce_153 = happySpecReduce_2  31# happyReduction_153
happyReduction_153 happy_x_2
	happy_x_1
	 =  case happyOut49 happy_x_1 of { happy_var_1 -> 
	case happyOut45 happy_x_2 of { happy_var_2 -> 
	happyIn45
		 (happy_var_1 : happy_var_2
	)}}

happyReduce_154 = happySpecReduce_1  31# happyReduction_154
happyReduction_154 happy_x_1
	 =  case happyOut62 happy_x_1 of { happy_var_1 -> 
	happyIn45
		 ([happy_var_1]
	)}

happyReduce_155 = happySpecReduce_2  31# happyReduction_155
happyReduction_155 happy_x_2
	happy_x_1
	 =  case happyOut62 happy_x_1 of { happy_var_1 -> 
	case happyOut45 happy_x_2 of { happy_var_2 -> 
	happyIn45
		 (happy_var_1 : happy_var_2
	)}}

happyReduce_156 = happySpecReduce_1  32# happyReduction_156
happyReduction_156 happy_x_1
	 =  case happyOut48 happy_x_1 of { happy_var_1 -> 
	happyIn46
		 (rsingleton happy_var_1
	)}

happyReduce_157 = happySpecReduce_3  32# happyReduction_157
happyReduction_157 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut46 happy_x_1 of { happy_var_1 -> 
	case happyOut48 happy_x_3 of { happy_var_3 -> 
	happyIn46
		 (rcons happy_var_3 happy_var_1
	)}}

happyReduce_158 = happySpecReduce_0  33# happyReduction_158
happyReduction_158  =  happyIn47
		 (Nothing
	)

happyReduce_159 = happyReduce 4# 33# happyReduction_159
happyReduction_159 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_3 of { happy_var_3 -> 
	happyIn47
		 (Just ((fst . getSTRING) happy_var_3)
	) `HappyStk` happyRest}

happyReduce_160 = happySpecReduce_2  34# happyReduction_160
happyReduction_160 happy_x_2
	happy_x_1
	 =  case happyOut67 happy_x_1 of { happy_var_1 -> 
	case happyOut47 happy_x_2 of { happy_var_2 -> 
	happyIn48
		 (let  {  (ident, declToDecl) = happy_var_1
             ;  decl                = declToDecl (declRoot ident)
             }
        in
          Init ident decl happy_var_2 Nothing [] (ident <--> decl)
	)}}

happyReduce_161 = happySpecReduce_3  34# happyReduction_161
happyReduction_161 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut67 happy_x_1 of { happy_var_1 -> 
	case happyOut104 happy_x_2 of { happy_var_2 -> 
	case happyOut47 happy_x_3 of { happy_var_3 -> 
	happyIn48
		 (let  { (ident, declToDecl) = happy_var_1
             ;  decl               = declToDecl (declRoot ident)
             }
        in
          Init ident decl happy_var_3 Nothing happy_var_2 (ident <--> decl)
	)}}}

happyReduce_162 = happyReduce 4# 34# happyReduction_162
happyReduction_162 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut67 happy_x_1 of { happy_var_1 -> 
	case happyOut47 happy_x_2 of { happy_var_2 -> 
	case happyOut83 happy_x_4 of { happy_var_4 -> 
	happyIn48
		 (let  {  (ident, declToDecl) = happy_var_1
             ;  decl                = declToDecl (declRoot ident)
             }
        in
          Init ident decl happy_var_2 (Just happy_var_4) [] (ident <--> happy_var_4)
	) `HappyStk` happyRest}}}

happyReduce_163 = happyReduce 5# 34# happyReduction_163
happyReduction_163 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut67 happy_x_1 of { happy_var_1 -> 
	case happyOut47 happy_x_2 of { happy_var_2 -> 
	case happyOut104 happy_x_4 of { happy_var_4 -> 
	case happyOut83 happy_x_5 of { happy_var_5 -> 
	happyIn48
		 (let  {  (ident, declToDecl) = happy_var_1
             ;  decl                = declToDecl (declRoot ident)
             }
        in
          Init ident decl happy_var_2 (Just happy_var_5) happy_var_4 (ident <--> happy_var_5)
	) `HappyStk` happyRest}}}}

happyReduce_164 = happyMonadReduce 2# 34# happyReduction_164
happyReduction_164 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut67 happy_x_1 of { happy_var_1 -> 
	( do{  let (ident, declToDecl) = happy_var_1
           ;  let decl                = declToDecl (declRoot ident)
           ;  expected (locOf decl) ["'='"]
           })}
	) (\r -> happyReturn (happyIn48 r))

happyReduce_165 = happySpecReduce_1  35# happyReduction_165
happyReduction_165 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn49
		 (TSauto (locOf happy_var_1)
	)}

happyReduce_166 = happySpecReduce_1  35# happyReduction_166
happyReduction_166 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn49
		 (TSregister (locOf happy_var_1)
	)}

happyReduce_167 = happySpecReduce_1  35# happyReduction_167
happyReduction_167 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn49
		 (TSstatic (locOf happy_var_1)
	)}

happyReduce_168 = happySpecReduce_1  35# happyReduction_168
happyReduction_168 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn49
		 (TSextern (locOf happy_var_1)
	)}

happyReduce_169 = happySpecReduce_2  35# happyReduction_169
happyReduction_169 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { happy_var_2 -> 
	happyIn49
		 (TSexternL ((snd . getSTRING) happy_var_2) (locOf happy_var_1)
	)}}

happyReduce_170 = happySpecReduce_1  35# happyReduction_170
happyReduction_170 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn49
		 (TStypedef (locOf happy_var_1)
	)}

happyReduce_171 = happySpecReduce_1  36# happyReduction_171
happyReduction_171 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn50
		 (TSvoid (locOf happy_var_1)
	)}

happyReduce_172 = happySpecReduce_1  36# happyReduction_172
happyReduction_172 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn50
		 (TSchar (locOf happy_var_1)
	)}

happyReduce_173 = happySpecReduce_1  36# happyReduction_173
happyReduction_173 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn50
		 (TSshort (locOf happy_var_1)
	)}

happyReduce_174 = happySpecReduce_1  36# happyReduction_174
happyReduction_174 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn50
		 (TSint (locOf happy_var_1)
	)}

happyReduce_175 = happySpecReduce_1  36# happyReduction_175
happyReduction_175 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn50
		 (TSlong (locOf happy_var_1)
	)}

happyReduce_176 = happySpecReduce_1  36# happyReduction_176
happyReduction_176 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn50
		 (TSfloat (locOf happy_var_1)
	)}

happyReduce_177 = happySpecReduce_1  36# happyReduction_177
happyReduction_177 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn50
		 (TSdouble (locOf happy_var_1)
	)}

happyReduce_178 = happySpecReduce_1  36# happyReduction_178
happyReduction_178 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn50
		 (TSsigned (locOf happy_var_1)
	)}

happyReduce_179 = happySpecReduce_1  36# happyReduction_179
happyReduction_179 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn50
		 (TSunsigned (locOf happy_var_1)
	)}

happyReduce_180 = happySpecReduce_1  36# happyReduction_180
happyReduction_180 happy_x_1
	 =  case happyOut51 happy_x_1 of { happy_var_1 -> 
	happyIn50
		 (happy_var_1
	)}

happyReduce_181 = happySpecReduce_1  36# happyReduction_181
happyReduction_181 happy_x_1
	 =  case happyOut59 happy_x_1 of { happy_var_1 -> 
	happyIn50
		 (happy_var_1
	)}

happyReduce_182 = happySpecReduce_1  36# happyReduction_182
happyReduction_182 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn50
		 (TSva_list (locOf happy_var_1)
	)}

happyReduce_183 = happySpecReduce_2  37# happyReduction_183
happyReduction_183 happy_x_2
	happy_x_1
	 =  case happyOut52 happy_x_1 of { happy_var_1 -> 
	case happyOut15 happy_x_2 of { happy_var_2 -> 
	happyIn51
		 ((unLoc happy_var_1) (Just happy_var_2) Nothing [] (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_184 = happySpecReduce_3  37# happyReduction_184
happyReduction_184 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut52 happy_x_1 of { happy_var_1 -> 
	case happyOut104 happy_x_2 of { happy_var_2 -> 
	case happyOut15 happy_x_3 of { happy_var_3 -> 
	happyIn51
		 ((unLoc happy_var_1) (Just happy_var_3) Nothing happy_var_2 (happy_var_1 <--> happy_var_3)
	)}}}

happyReduce_185 = happyReduce 4# 37# happyReduction_185
happyReduction_185 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut52 happy_x_1 of { happy_var_1 -> 
	case happyOut53 happy_x_3 of { happy_var_3 -> 
	case happyOutTok happy_x_4 of { happy_var_4 -> 
	happyIn51
		 ((unLoc happy_var_1) Nothing (Just (rev happy_var_3)) [] (happy_var_1 <--> happy_var_4)
	) `HappyStk` happyRest}}}

happyReduce_186 = happyMonadReduce 4# 37# happyReduction_186
happyReduction_186 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut52 happy_x_1 of { happy_var_1 -> 
	case happyOut53 happy_x_3 of { happy_var_3 -> 
	( unclosed (happy_var_1 <--> rev happy_var_3) "{")}}
	) (\r -> happyReturn (happyIn51 r))

happyReduce_187 = happyReduce 5# 37# happyReduction_187
happyReduction_187 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut52 happy_x_1 of { happy_var_1 -> 
	case happyOut15 happy_x_2 of { happy_var_2 -> 
	case happyOut53 happy_x_4 of { happy_var_4 -> 
	case happyOutTok happy_x_5 of { happy_var_5 -> 
	happyIn51
		 ((unLoc happy_var_1) (Just happy_var_2) (Just (rev happy_var_4)) [] (happy_var_1 <--> happy_var_5)
	) `HappyStk` happyRest}}}}

happyReduce_188 = happyMonadReduce 5# 37# happyReduction_188
happyReduction_188 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut52 happy_x_1 of { happy_var_1 -> 
	case happyOut53 happy_x_4 of { happy_var_4 -> 
	( unclosed (happy_var_1 <--> rev happy_var_4) "{")}}
	) (\r -> happyReturn (happyIn51 r))

happyReduce_189 = happyReduce 6# 37# happyReduction_189
happyReduction_189 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut52 happy_x_1 of { happy_var_1 -> 
	case happyOut104 happy_x_2 of { happy_var_2 -> 
	case happyOut15 happy_x_3 of { happy_var_3 -> 
	case happyOut53 happy_x_5 of { happy_var_5 -> 
	case happyOutTok happy_x_6 of { happy_var_6 -> 
	happyIn51
		 ((unLoc happy_var_1) (Just happy_var_3) (Just (rev happy_var_5)) happy_var_2 (happy_var_1 <--> happy_var_6)
	) `HappyStk` happyRest}}}}}

happyReduce_190 = happyMonadReduce 6# 37# happyReduction_190
happyReduction_190 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut52 happy_x_1 of { happy_var_1 -> 
	case happyOut53 happy_x_5 of { happy_var_5 -> 
	( unclosed (happy_var_1 <--> rev happy_var_5) "{")}}
	) (\r -> happyReturn (happyIn51 r))

happyReduce_191 = happySpecReduce_1  38# happyReduction_191
happyReduction_191 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn52
		 (L (getLoc happy_var_1) TSstruct
	)}

happyReduce_192 = happySpecReduce_1  38# happyReduction_192
happyReduction_192 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn52
		 (L (getLoc happy_var_1) TSunion
	)}

happyReduce_193 = happySpecReduce_1  39# happyReduction_193
happyReduction_193 happy_x_1
	 =  case happyOut54 happy_x_1 of { happy_var_1 -> 
	happyIn53
		 (rsingleton happy_var_1
	)}

happyReduce_194 = happySpecReduce_1  39# happyReduction_194
happyReduction_194 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn53
		 (rsingleton (AntiSdecls (getANTI_SDECLS happy_var_1) (locOf happy_var_1))
	)}

happyReduce_195 = happySpecReduce_2  39# happyReduction_195
happyReduction_195 happy_x_2
	happy_x_1
	 =  case happyOut53 happy_x_1 of { happy_var_1 -> 
	case happyOut54 happy_x_2 of { happy_var_2 -> 
	happyIn53
		 (rcons happy_var_2 happy_var_1
	)}}

happyReduce_196 = happySpecReduce_2  39# happyReduction_196
happyReduction_196 happy_x_2
	happy_x_1
	 =  case happyOut53 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { happy_var_2 -> 
	happyIn53
		 (rcons (AntiSdecls (getANTI_SDECLS happy_var_2) (locOf happy_var_2)) happy_var_1
	)}}

happyReduce_197 = happySpecReduce_3  40# happyReduction_197
happyReduction_197 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut57 happy_x_2 of { happy_var_2 -> 
	case happyOutTok happy_x_3 of { happy_var_3 -> 
	happyIn54
		 (let dspec = AntiDeclSpec (getANTI_SPEC happy_var_1) (locOf happy_var_1)
        in
          FieldGroup dspec (rev happy_var_2) (happy_var_1 <--> happy_var_3)
	)}}}

happyReduce_198 = happyMonadReduce 3# 40# happyReduction_198
happyReduction_198 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut55 happy_x_1 of { happy_var_1 -> 
	case happyOut57 happy_x_2 of { happy_var_2 -> 
	case happyOutTok happy_x_3 of { happy_var_3 -> 
	(  do{ dspec <- mkDeclSpec happy_var_1
            ; return $ FieldGroup dspec (rev happy_var_2) (happy_var_1 <--> happy_var_3)
            })}}}
	) (\r -> happyReturn (happyIn54 r))

happyReduce_199 = happyMonadReduce 3# 40# happyReduction_199
happyReduction_199 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut15 happy_x_2 of { happy_var_2 -> 
	case happyOutTok happy_x_3 of { happy_var_3 -> 
	(  do{ let v     = getANTI_TYPE happy_var_1
            ; let dspec = AntiTypeDeclSpec [] [] v (locOf happy_var_1)
            ; let decl  = AntiTypeDecl v (locOf happy_var_1)
            ; let field = Field (Just happy_var_2) (Just decl) Nothing (happy_var_1 <--> happy_var_2)
            ; return $ FieldGroup dspec [field] (happy_var_1 <--> happy_var_3)
            })}}}
	) (\r -> happyReturn (happyIn54 r))

happyReduce_200 = happySpecReduce_1  40# happyReduction_200
happyReduction_200 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn54
		 (AntiSdecl (getANTI_SDECL happy_var_1) (locOf happy_var_1)
	)}

happyReduce_201 = happySpecReduce_2  41# happyReduction_201
happyReduction_201 happy_x_2
	happy_x_1
	 =  case happyOut50 happy_x_1 of { happy_var_1 -> 
	case happyOut56 happy_x_2 of { happy_var_2 -> 
	happyIn55
		 (happy_var_1 : happy_var_2
	)}}

happyReduce_202 = happySpecReduce_3  41# happyReduction_202
happyReduction_202 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut73 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_2 of { happy_var_2 -> 
	case happyOut56 happy_x_3 of { happy_var_3 -> 
	happyIn55
		 (rev happy_var_1 ++ [happy_var_2] ++ happy_var_3
	)}}}

happyReduce_203 = happySpecReduce_1  41# happyReduction_203
happyReduction_203 happy_x_1
	 =  case happyOut82 happy_x_1 of { happy_var_1 -> 
	happyIn55
		 ([happy_var_1]
	)}

happyReduce_204 = happySpecReduce_2  41# happyReduction_204
happyReduction_204 happy_x_2
	happy_x_1
	 =  case happyOut82 happy_x_1 of { happy_var_1 -> 
	case happyOut73 happy_x_2 of { happy_var_2 -> 
	happyIn55
		 (happy_var_1 : rev happy_var_2
	)}}

happyReduce_205 = happySpecReduce_2  41# happyReduction_205
happyReduction_205 happy_x_2
	happy_x_1
	 =  case happyOut73 happy_x_1 of { happy_var_1 -> 
	case happyOut82 happy_x_2 of { happy_var_2 -> 
	happyIn55
		 (rev happy_var_1 ++ [happy_var_2]
	)}}

happyReduce_206 = happySpecReduce_3  41# happyReduction_206
happyReduction_206 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut73 happy_x_1 of { happy_var_1 -> 
	case happyOut82 happy_x_2 of { happy_var_2 -> 
	case happyOut73 happy_x_3 of { happy_var_3 -> 
	happyIn55
		 (rev happy_var_1 ++ [happy_var_2] ++ rev happy_var_3
	)}}}

happyReduce_207 = happySpecReduce_0  42# happyReduction_207
happyReduction_207  =  happyIn56
		 ([]
	)

happyReduce_208 = happySpecReduce_1  42# happyReduction_208
happyReduction_208 happy_x_1
	 =  case happyOut50 happy_x_1 of { happy_var_1 -> 
	happyIn56
		 ([happy_var_1]
	)}

happyReduce_209 = happySpecReduce_2  42# happyReduction_209
happyReduction_209 happy_x_2
	happy_x_1
	 =  case happyOut50 happy_x_1 of { happy_var_1 -> 
	case happyOut55 happy_x_2 of { happy_var_2 -> 
	happyIn56
		 (happy_var_1 : happy_var_2
	)}}

happyReduce_210 = happySpecReduce_1  42# happyReduction_210
happyReduction_210 happy_x_1
	 =  case happyOut62 happy_x_1 of { happy_var_1 -> 
	happyIn56
		 ([happy_var_1]
	)}

happyReduce_211 = happySpecReduce_2  42# happyReduction_211
happyReduction_211 happy_x_2
	happy_x_1
	 =  case happyOut62 happy_x_1 of { happy_var_1 -> 
	case happyOut55 happy_x_2 of { happy_var_2 -> 
	happyIn56
		 (happy_var_1 : happy_var_2
	)}}

happyReduce_212 = happySpecReduce_1  43# happyReduction_212
happyReduction_212 happy_x_1
	 =  case happyOut58 happy_x_1 of { happy_var_1 -> 
	happyIn57
		 (rsingleton happy_var_1
	)}

happyReduce_213 = happySpecReduce_3  43# happyReduction_213
happyReduction_213 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut57 happy_x_1 of { happy_var_1 -> 
	case happyOut58 happy_x_3 of { happy_var_3 -> 
	happyIn57
		 (rcons happy_var_3 happy_var_1
	)}}

happyReduce_214 = happySpecReduce_1  44# happyReduction_214
happyReduction_214 happy_x_1
	 =  case happyOut67 happy_x_1 of { happy_var_1 -> 
	happyIn58
		 (let { (ident, declToDecl) = happy_var_1
              ; decl                = declToDecl (declRoot ident)
              }
          in
            Field (Just ident) (Just decl) Nothing (locOf decl)
	)}

happyReduce_215 = happySpecReduce_2  44# happyReduction_215
happyReduction_215 happy_x_2
	happy_x_1
	 =  case happyOut67 happy_x_1 of { happy_var_1 -> 
	happyIn58
		 (let { (ident, declToDecl) = happy_var_1
              ; decl                = declToDecl (declRoot ident)
              }
          in
            Field (Just ident) (Just decl) Nothing (locOf decl)
	)}

happyReduce_216 = happySpecReduce_2  44# happyReduction_216
happyReduction_216 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut38 happy_x_2 of { happy_var_2 -> 
	happyIn58
		 (Field Nothing Nothing (Just happy_var_2) (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_217 = happySpecReduce_3  44# happyReduction_217
happyReduction_217 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut67 happy_x_1 of { happy_var_1 -> 
	case happyOut38 happy_x_3 of { happy_var_3 -> 
	happyIn58
		 (let { (ident, declToDecl) = happy_var_1
              ; decl                = declToDecl (declRoot ident)
              }
          in
            Field (Just ident) (Just decl) (Just happy_var_3) (locOf decl)
	)}}

happyReduce_218 = happySpecReduce_2  45# happyReduction_218
happyReduction_218 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut15 happy_x_2 of { happy_var_2 -> 
	happyIn59
		 (TSenum (Just happy_var_2) [] [] (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_219 = happySpecReduce_3  45# happyReduction_219
happyReduction_219 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut104 happy_x_2 of { happy_var_2 -> 
	case happyOut15 happy_x_3 of { happy_var_3 -> 
	happyIn59
		 (TSenum (Just happy_var_3) [] happy_var_2 (happy_var_1 <--> happy_var_3)
	)}}}

happyReduce_220 = happyReduce 4# 45# happyReduction_220
happyReduction_220 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut60 happy_x_3 of { happy_var_3 -> 
	case happyOutTok happy_x_4 of { happy_var_4 -> 
	happyIn59
		 (TSenum Nothing (rev happy_var_3) [] (happy_var_1 <--> happy_var_4)
	) `HappyStk` happyRest}}}

happyReduce_221 = happyReduce 5# 45# happyReduction_221
happyReduction_221 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut15 happy_x_2 of { happy_var_2 -> 
	case happyOut60 happy_x_4 of { happy_var_4 -> 
	case happyOutTok happy_x_5 of { happy_var_5 -> 
	happyIn59
		 (TSenum (Just happy_var_2) (rev happy_var_4) [] (happy_var_1 <--> happy_var_5)
	) `HappyStk` happyRest}}}}

happyReduce_222 = happySpecReduce_1  46# happyReduction_222
happyReduction_222 happy_x_1
	 =  case happyOut61 happy_x_1 of { happy_var_1 -> 
	happyIn60
		 (rsingleton happy_var_1
	)}

happyReduce_223 = happySpecReduce_1  46# happyReduction_223
happyReduction_223 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn60
		 (rsingleton (AntiEnums (getANTI_ENUMS happy_var_1) (locOf happy_var_1))
	)}

happyReduce_224 = happySpecReduce_2  46# happyReduction_224
happyReduction_224 happy_x_2
	happy_x_1
	 =  case happyOut60 happy_x_1 of { happy_var_1 -> 
	happyIn60
		 (happy_var_1
	)}

happyReduce_225 = happySpecReduce_3  46# happyReduction_225
happyReduction_225 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut60 happy_x_1 of { happy_var_1 -> 
	case happyOut61 happy_x_3 of { happy_var_3 -> 
	happyIn60
		 (rcons happy_var_3 happy_var_1
	)}}

happyReduce_226 = happySpecReduce_3  46# happyReduction_226
happyReduction_226 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut60 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_3 of { happy_var_3 -> 
	happyIn60
		 (rcons (AntiEnums (getANTI_ENUMS happy_var_3) (locOf happy_var_3)) happy_var_1
	)}}

happyReduce_227 = happySpecReduce_1  47# happyReduction_227
happyReduction_227 happy_x_1
	 =  case happyOut14 happy_x_1 of { happy_var_1 -> 
	happyIn61
		 (CEnum happy_var_1 Nothing (locOf happy_var_1)
	)}

happyReduce_228 = happySpecReduce_3  47# happyReduction_228
happyReduction_228 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut14 happy_x_1 of { happy_var_1 -> 
	case happyOut38 happy_x_3 of { happy_var_3 -> 
	happyIn61
		 (CEnum happy_var_1 (Just happy_var_3) (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_229 = happySpecReduce_1  47# happyReduction_229
happyReduction_229 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn61
		 (AntiEnum (getANTI_ENUM happy_var_1) (locOf happy_var_1)
	)}

happyReduce_230 = happySpecReduce_1  48# happyReduction_230
happyReduction_230 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn62
		 (TSconst (locOf happy_var_1)
	)}

happyReduce_231 = happySpecReduce_1  48# happyReduction_231
happyReduction_231 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn62
		 (TSinline (locOf happy_var_1)
	)}

happyReduce_232 = happySpecReduce_1  48# happyReduction_232
happyReduction_232 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn62
		 (TSrestrict (locOf happy_var_1)
	)}

happyReduce_233 = happySpecReduce_1  48# happyReduction_233
happyReduction_233 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn62
		 (TSvolatile (locOf happy_var_1)
	)}

happyReduce_234 = happySpecReduce_1  48# happyReduction_234
happyReduction_234 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn62
		 (TSdevice (locOf happy_var_1)
	)}

happyReduce_235 = happySpecReduce_1  48# happyReduction_235
happyReduction_235 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn62
		 (TSglobal (locOf happy_var_1)
	)}

happyReduce_236 = happySpecReduce_1  48# happyReduction_236
happyReduction_236 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn62
		 (TShost (locOf happy_var_1)
	)}

happyReduce_237 = happySpecReduce_1  48# happyReduction_237
happyReduction_237 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn62
		 (TSconstant (locOf happy_var_1)
	)}

happyReduce_238 = happySpecReduce_1  48# happyReduction_238
happyReduction_238 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn62
		 (TSshared (locOf happy_var_1)
	)}

happyReduce_239 = happySpecReduce_1  48# happyReduction_239
happyReduction_239 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn62
		 (TSnoinline (locOf happy_var_1)
	)}

happyReduce_240 = happySpecReduce_1  49# happyReduction_240
happyReduction_240 happy_x_1
	 =  case happyOut64 happy_x_1 of { happy_var_1 -> 
	happyIn63
		 (happy_var_1
	)}

happyReduce_241 = happySpecReduce_2  49# happyReduction_241
happyReduction_241 happy_x_2
	happy_x_1
	 =  case happyOut72 happy_x_1 of { happy_var_1 -> 
	case happyOut64 happy_x_2 of { happy_var_2 -> 
	happyIn63
		 (let (ident, dirDecl) = happy_var_2
        in
          (ident, dirDecl . happy_var_1)
	)}}

happyReduce_242 = happySpecReduce_1  50# happyReduction_242
happyReduction_242 happy_x_1
	 =  case happyOut14 happy_x_1 of { happy_var_1 -> 
	happyIn64
		 ((happy_var_1, id)
	)}

happyReduce_243 = happySpecReduce_3  50# happyReduction_243
happyReduction_243 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut63 happy_x_2 of { happy_var_2 -> 
	happyIn64
		 (happy_var_2
	)}

happyReduce_244 = happyMonadReduce 3# 50# happyReduction_244
happyReduction_244 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut63 happy_x_2 of { happy_var_2 -> 
	(do  {  let (ident, declToDecl) = happy_var_2
            ;  let decl                = declToDecl (declRoot ident)
            ;  unclosed (happy_var_1 <--> decl) "("
            })}}
	) (\r -> happyReturn (happyIn64 r))

happyReduce_245 = happySpecReduce_2  50# happyReduction_245
happyReduction_245 happy_x_2
	happy_x_1
	 =  case happyOut64 happy_x_1 of { happy_var_1 -> 
	case happyOut71 happy_x_2 of { happy_var_2 -> 
	happyIn64
		 (let (ident, declToDecl) = happy_var_1
        in
           (ident, declToDecl . happy_var_2)
	)}}

happyReduce_246 = happySpecReduce_3  50# happyReduction_246
happyReduction_246 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut64 happy_x_1 of { happy_var_1 -> 
	happyIn64
		 (let { (ident, declToDecl) = happy_var_1
            ; proto = mkOldProto []
            }
        in
          (ident, declToDecl . proto)
	)}

happyReduce_247 = happyReduce 4# 50# happyReduction_247
happyReduction_247 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut64 happy_x_1 of { happy_var_1 -> 
	case happyOut74 happy_x_3 of { happy_var_3 -> 
	happyIn64
		 (let { (ident, declToDecl) = happy_var_1
            ; proto = mkProto happy_var_3
            }
        in
          (ident, declToDecl . proto)
	) `HappyStk` happyRest}}

happyReduce_248 = happyReduce 4# 50# happyReduction_248
happyReduction_248 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut64 happy_x_1 of { happy_var_1 -> 
	case happyOut78 happy_x_3 of { happy_var_3 -> 
	happyIn64
		 (let { (ident, declToDecl) = happy_var_1
            ; proto = mkOldProto (rev happy_var_3)
            }
        in
          (ident, declToDecl . proto)
	) `HappyStk` happyRest}}

happyReduce_249 = happySpecReduce_1  51# happyReduction_249
happyReduction_249 happy_x_1
	 =  case happyOut66 happy_x_1 of { happy_var_1 -> 
	happyIn65
		 (happy_var_1
	)}

happyReduce_250 = happySpecReduce_2  51# happyReduction_250
happyReduction_250 happy_x_2
	happy_x_1
	 =  case happyOut72 happy_x_1 of { happy_var_1 -> 
	case happyOut66 happy_x_2 of { happy_var_2 -> 
	happyIn65
		 (let (ident, dirDecl) = happy_var_2
        in
          (ident, dirDecl . happy_var_1)
	)}}

happyReduce_251 = happySpecReduce_1  52# happyReduction_251
happyReduction_251 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn66
		 ((Id (getNAMED happy_var_1) (locOf happy_var_1), id)
	)}

happyReduce_252 = happySpecReduce_3  52# happyReduction_252
happyReduction_252 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut65 happy_x_2 of { happy_var_2 -> 
	happyIn66
		 (happy_var_2
	)}

happyReduce_253 = happyMonadReduce 3# 52# happyReduction_253
happyReduction_253 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut65 happy_x_2 of { happy_var_2 -> 
	(do  {  let (ident, declToDecl) = happy_var_2
            ;  let decl                = declToDecl (declRoot ident)
            ;  unclosed (happy_var_1 <--> decl) "("
            })}}
	) (\r -> happyReturn (happyIn66 r))

happyReduce_254 = happySpecReduce_2  52# happyReduction_254
happyReduction_254 happy_x_2
	happy_x_1
	 =  case happyOut66 happy_x_1 of { happy_var_1 -> 
	case happyOut71 happy_x_2 of { happy_var_2 -> 
	happyIn66
		 (let (ident, declToDecl) = happy_var_1
        in
           (ident, declToDecl . happy_var_2)
	)}}

happyReduce_255 = happySpecReduce_3  52# happyReduction_255
happyReduction_255 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut66 happy_x_1 of { happy_var_1 -> 
	happyIn66
		 (let { (ident, declToDecl) = happy_var_1
            ; proto = mkOldProto []
            }
        in
          (ident, declToDecl . proto)
	)}

happyReduce_256 = happyReduce 4# 52# happyReduction_256
happyReduction_256 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut66 happy_x_1 of { happy_var_1 -> 
	case happyOut74 happy_x_3 of { happy_var_3 -> 
	happyIn66
		 (let { (ident, declToDecl) = happy_var_1
            ; proto = mkProto happy_var_3
            }
        in
          (ident, declToDecl . proto)
	) `HappyStk` happyRest}}

happyReduce_257 = happyReduce 4# 52# happyReduction_257
happyReduction_257 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut66 happy_x_1 of { happy_var_1 -> 
	case happyOut78 happy_x_3 of { happy_var_3 -> 
	happyIn66
		 (let { (ident, declToDecl) = happy_var_1
            ; proto = mkOldProto (rev happy_var_3)
            }
        in
          (ident, declToDecl . proto)
	) `HappyStk` happyRest}}

happyReduce_258 = happySpecReduce_1  53# happyReduction_258
happyReduction_258 happy_x_1
	 =  case happyOut63 happy_x_1 of { happy_var_1 -> 
	happyIn67
		 (happy_var_1
	)}

happyReduce_259 = happySpecReduce_1  53# happyReduction_259
happyReduction_259 happy_x_1
	 =  case happyOut65 happy_x_1 of { happy_var_1 -> 
	happyIn67
		 (happy_var_1
	)}

happyReduce_260 = happySpecReduce_1  54# happyReduction_260
happyReduction_260 happy_x_1
	 =  case happyOut69 happy_x_1 of { happy_var_1 -> 
	happyIn68
		 (happy_var_1
	)}

happyReduce_261 = happySpecReduce_2  54# happyReduction_261
happyReduction_261 happy_x_2
	happy_x_1
	 =  case happyOut72 happy_x_1 of { happy_var_1 -> 
	case happyOut69 happy_x_2 of { happy_var_2 -> 
	happyIn68
		 (let (ident, dirDecl) = happy_var_2
        in
          (ident, dirDecl . happy_var_1)
	)}}

happyReduce_262 = happySpecReduce_1  55# happyReduction_262
happyReduction_262 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn69
		 ((Id (getNAMED happy_var_1) (locOf happy_var_1), id)
	)}

happyReduce_263 = happyReduce 4# 55# happyReduction_263
happyReduction_263 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut72 happy_x_2 of { happy_var_2 -> 
	case happyOut69 happy_x_3 of { happy_var_3 -> 
	happyIn69
		 (let (ident, dirDecl) = happy_var_3
        in
          (ident, dirDecl . happy_var_2)
	) `HappyStk` happyRest}}

happyReduce_264 = happySpecReduce_2  55# happyReduction_264
happyReduction_264 happy_x_2
	happy_x_1
	 =  case happyOut69 happy_x_1 of { happy_var_1 -> 
	case happyOut71 happy_x_2 of { happy_var_2 -> 
	happyIn69
		 (let (ident, declToDecl) = happy_var_1
        in
           (ident, declToDecl . happy_var_2)
	)}}

happyReduce_265 = happySpecReduce_3  55# happyReduction_265
happyReduction_265 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut69 happy_x_1 of { happy_var_1 -> 
	happyIn69
		 (let { (ident, declToDecl) = happy_var_1
            ; proto = mkOldProto []
            }
        in
          (ident, declToDecl . proto)
	)}

happyReduce_266 = happyReduce 4# 55# happyReduction_266
happyReduction_266 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut69 happy_x_1 of { happy_var_1 -> 
	case happyOut74 happy_x_3 of { happy_var_3 -> 
	happyIn69
		 (let { (ident, declToDecl) = happy_var_1
            ; proto = mkProto happy_var_3
            }
        in
          (ident, declToDecl . proto)
	) `HappyStk` happyRest}}

happyReduce_267 = happyReduce 4# 55# happyReduction_267
happyReduction_267 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut69 happy_x_1 of { happy_var_1 -> 
	case happyOut78 happy_x_3 of { happy_var_3 -> 
	happyIn69
		 (let { (ident, declToDecl) = happy_var_1
            ; proto = mkOldProto (rev happy_var_3)
            }
        in
          (ident, declToDecl . proto)
	) `HappyStk` happyRest}}

happyReduce_268 = happySpecReduce_1  56# happyReduction_268
happyReduction_268 happy_x_1
	 =  case happyOut63 happy_x_1 of { happy_var_1 -> 
	happyIn70
		 (happy_var_1
	)}

happyReduce_269 = happySpecReduce_1  56# happyReduction_269
happyReduction_269 happy_x_1
	 =  case happyOut68 happy_x_1 of { happy_var_1 -> 
	happyIn70
		 (happy_var_1
	)}

happyReduce_270 = happySpecReduce_2  57# happyReduction_270
happyReduction_270 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { happy_var_2 -> 
	happyIn71
		 (mkArray [] (NoArraySize (happy_var_1 <--> happy_var_2))
	)}}

happyReduce_271 = happyMonadReduce 2# 57# happyReduction_271
happyReduction_271 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { happy_var_1 -> 
	( unclosed (getLoc happy_var_1) "[")}
	) (\r -> happyReturn (happyIn71 r))

happyReduce_272 = happySpecReduce_3  57# happyReduction_272
happyReduction_272 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut73 happy_x_2 of { happy_var_2 -> 
	case happyOutTok happy_x_3 of { happy_var_3 -> 
	happyIn71
		 (mkArray (rev happy_var_2) (NoArraySize (happy_var_1 <--> happy_var_3))
	)}}}

happyReduce_273 = happySpecReduce_3  57# happyReduction_273
happyReduction_273 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut35 happy_x_2 of { happy_var_2 -> 
	happyIn71
		 (mkArray [] (ArraySize False happy_var_2 (locOf happy_var_2))
	)}

happyReduce_274 = happyReduce 4# 57# happyReduction_274
happyReduction_274 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut73 happy_x_2 of { happy_var_2 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn71
		 (mkArray (rev happy_var_2) (ArraySize False happy_var_3 (locOf happy_var_3))
	) `HappyStk` happyRest}}

happyReduce_275 = happyReduce 4# 57# happyReduction_275
happyReduction_275 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn71
		 (mkArray [] (ArraySize True happy_var_3 (locOf happy_var_3))
	) `HappyStk` happyRest}

happyReduce_276 = happyReduce 5# 57# happyReduction_276
happyReduction_276 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut73 happy_x_3 of { happy_var_3 -> 
	case happyOut35 happy_x_4 of { happy_var_4 -> 
	happyIn71
		 (mkArray (rev happy_var_3) (ArraySize True happy_var_4 (locOf happy_var_4))
	) `HappyStk` happyRest}}

happyReduce_277 = happyReduce 5# 57# happyReduction_277
happyReduction_277 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut73 happy_x_2 of { happy_var_2 -> 
	case happyOut35 happy_x_4 of { happy_var_4 -> 
	happyIn71
		 (mkArray (rev happy_var_2) (ArraySize True happy_var_4 (locOf happy_var_4))
	) `HappyStk` happyRest}}

happyReduce_278 = happySpecReduce_3  57# happyReduction_278
happyReduction_278 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_3 of { happy_var_3 -> 
	happyIn71
		 (mkArray [] (VariableArraySize (happy_var_1 <--> happy_var_3))
	)}}

happyReduce_279 = happyReduce 4# 57# happyReduction_279
happyReduction_279 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut73 happy_x_2 of { happy_var_2 -> 
	case happyOutTok happy_x_4 of { happy_var_4 -> 
	happyIn71
		 (mkArray (rev happy_var_2) (VariableArraySize (happy_var_1 <--> happy_var_4))
	) `HappyStk` happyRest}}}

happyReduce_280 = happySpecReduce_1  58# happyReduction_280
happyReduction_280 happy_x_1
	 =  happyIn72
		 (mkPtr []
	)

happyReduce_281 = happySpecReduce_2  58# happyReduction_281
happyReduction_281 happy_x_2
	happy_x_1
	 =  case happyOut73 happy_x_2 of { happy_var_2 -> 
	happyIn72
		 (mkPtr (rev happy_var_2)
	)}

happyReduce_282 = happySpecReduce_2  58# happyReduction_282
happyReduction_282 happy_x_2
	happy_x_1
	 =  case happyOut72 happy_x_2 of { happy_var_2 -> 
	happyIn72
		 (happy_var_2 . mkPtr []
	)}

happyReduce_283 = happySpecReduce_3  58# happyReduction_283
happyReduction_283 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut73 happy_x_2 of { happy_var_2 -> 
	case happyOut72 happy_x_3 of { happy_var_3 -> 
	happyIn72
		 (happy_var_3 . mkPtr (rev happy_var_2)
	)}}

happyReduce_284 = happySpecReduce_1  59# happyReduction_284
happyReduction_284 happy_x_1
	 =  case happyOut62 happy_x_1 of { happy_var_1 -> 
	happyIn73
		 (rsingleton happy_var_1
	)}

happyReduce_285 = happySpecReduce_2  59# happyReduction_285
happyReduction_285 happy_x_2
	happy_x_1
	 =  case happyOut73 happy_x_1 of { happy_var_1 -> 
	case happyOut62 happy_x_2 of { happy_var_2 -> 
	happyIn73
		 (rcons happy_var_2 happy_var_1
	)}}

happyReduce_286 = happySpecReduce_1  60# happyReduction_286
happyReduction_286 happy_x_1
	 =  case happyOut75 happy_x_1 of { happy_var_1 -> 
	happyIn74
		 (let params = rev happy_var_1
        in
          Params params False (locOf params)
	)}

happyReduce_287 = happySpecReduce_3  60# happyReduction_287
happyReduction_287 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut75 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_3 of { happy_var_3 -> 
	happyIn74
		 (let params = rev happy_var_1
        in
          Params params True (params <--> happy_var_3)
	)}}

happyReduce_288 = happySpecReduce_1  61# happyReduction_288
happyReduction_288 happy_x_1
	 =  case happyOut76 happy_x_1 of { happy_var_1 -> 
	happyIn75
		 (rsingleton happy_var_1
	)}

happyReduce_289 = happySpecReduce_1  61# happyReduction_289
happyReduction_289 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn75
		 (rsingleton (AntiParams (getANTI_PARAMS happy_var_1) (locOf happy_var_1))
	)}

happyReduce_290 = happySpecReduce_3  61# happyReduction_290
happyReduction_290 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut75 happy_x_1 of { happy_var_1 -> 
	case happyOut76 happy_x_3 of { happy_var_3 -> 
	happyIn75
		 (rcons happy_var_3 happy_var_1
	)}}

happyReduce_291 = happySpecReduce_3  61# happyReduction_291
happyReduction_291 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut75 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_3 of { happy_var_3 -> 
	happyIn75
		 (rcons (AntiParams (getANTI_PARAMS happy_var_3) (locOf happy_var_3))  happy_var_1
	)}}

happyReduce_292 = happySpecReduce_1  62# happyReduction_292
happyReduction_292 happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	happyIn76
		 (let (dspec, decl) = happy_var_1
        in
          Param Nothing dspec decl (dspec <--> decl)
	)}

happyReduce_293 = happySpecReduce_2  62# happyReduction_293
happyReduction_293 happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut70 happy_x_2 of { happy_var_2 -> 
	happyIn76
		 (let  {  (dspec, declRoot)   = happy_var_1
             ;  (ident, declToDecl) = happy_var_2
             ;  decl                = declToDecl declRoot
             }
        in
          Param (Just ident) dspec decl (ident <--> decl)
	)}}

happyReduce_294 = happySpecReduce_2  62# happyReduction_294
happyReduction_294 happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut80 happy_x_2 of { happy_var_2 -> 
	happyIn76
		 (let  {  (dspec, declRoot)  = happy_var_1
             ;  decl                  = happy_var_2 declRoot
             }
        in
          Param Nothing dspec decl (dspec <--> decl)
	)}}

happyReduce_295 = happySpecReduce_1  62# happyReduction_295
happyReduction_295 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn76
		 (AntiParam (getANTI_PARAM happy_var_1) (locOf happy_var_1)
	)}

happyReduce_296 = happySpecReduce_1  63# happyReduction_296
happyReduction_296 happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	happyIn77
		 (let (dspec, decl) = happy_var_1
        in
          Type dspec decl (dspec <--> decl)
	)}

happyReduce_297 = happySpecReduce_2  63# happyReduction_297
happyReduction_297 happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut70 happy_x_2 of { happy_var_2 -> 
	happyIn77
		 (let  {  (dspec, declRoot)   = happy_var_1
             ;  (ident, declToDecl) = happy_var_2
             ;  decl                = declToDecl declRoot
             }
        in
          Type dspec decl (dspec <--> decl)
	)}}

happyReduce_298 = happySpecReduce_2  63# happyReduction_298
happyReduction_298 happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut80 happy_x_2 of { happy_var_2 -> 
	happyIn77
		 (let  {  (dspec, declRoot)  = happy_var_1
             ;  decl                  = happy_var_2 declRoot
             }
        in
          Type dspec decl (dspec <--> decl)
	)}}

happyReduce_299 = happySpecReduce_1  64# happyReduction_299
happyReduction_299 happy_x_1
	 =  case happyOut14 happy_x_1 of { happy_var_1 -> 
	happyIn78
		 (rsingleton happy_var_1
	)}

happyReduce_300 = happySpecReduce_3  64# happyReduction_300
happyReduction_300 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut78 happy_x_1 of { happy_var_1 -> 
	case happyOut14 happy_x_3 of { happy_var_3 -> 
	happyIn78
		 (rcons happy_var_3 happy_var_1
	)}}

happyReduce_301 = happySpecReduce_1  65# happyReduction_301
happyReduction_301 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn79
		 (let dspec = AntiDeclSpec (getANTI_SPEC happy_var_1) (locOf happy_var_1)
        in
          Type dspec (declRoot happy_var_1) (locOf happy_var_1)
	)}

happyReduce_302 = happyMonadReduce 1# 65# happyReduction_302
happyReduction_302 (happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut55 happy_x_1 of { happy_var_1 -> 
	( do{ dspec <- mkDeclSpec happy_var_1
           ; return $ Type dspec (declRoot happy_var_1) (locOf happy_var_1)
           })}
	) (\r -> happyReturn (happyIn79 r))

happyReduce_303 = happySpecReduce_2  65# happyReduction_303
happyReduction_303 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut80 happy_x_2 of { happy_var_2 -> 
	happyIn79
		 (let { dspec = AntiDeclSpec (getANTI_SPEC happy_var_1) (locOf happy_var_1)
            ; decl = happy_var_2 (declRoot happy_var_1)
            }
        in
          Type dspec decl (dspec <--> decl)
	)}}

happyReduce_304 = happyMonadReduce 2# 65# happyReduction_304
happyReduction_304 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut55 happy_x_1 of { happy_var_1 -> 
	case happyOut80 happy_x_2 of { happy_var_2 -> 
	( do{ let decl = happy_var_2 (declRoot happy_var_1)
           ; dspec <- mkDeclSpec happy_var_1
           ; return $ Type dspec decl (dspec <--> decl)
           })}}
	) (\r -> happyReturn (happyIn79 r))

happyReduce_305 = happySpecReduce_1  65# happyReduction_305
happyReduction_305 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn79
		 (AntiType (getANTI_TYPE happy_var_1) (locOf happy_var_1)
	)}

happyReduce_306 = happySpecReduce_2  65# happyReduction_306
happyReduction_306 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut80 happy_x_2 of { happy_var_2 -> 
	happyIn79
		 (let  {  v     = getANTI_TYPE happy_var_1
             ;  decl  = happy_var_2 (AntiTypeDecl v (locOf happy_var_1))
             }
        in
          Type (AntiTypeDeclSpec [] [] v (locOf happy_var_1)) decl (happy_var_1 <--> decl)
	)}}

happyReduce_307 = happySpecReduce_1  66# happyReduction_307
happyReduction_307 happy_x_1
	 =  case happyOut72 happy_x_1 of { happy_var_1 -> 
	happyIn80
		 (happy_var_1
	)}

happyReduce_308 = happySpecReduce_1  66# happyReduction_308
happyReduction_308 happy_x_1
	 =  case happyOut81 happy_x_1 of { happy_var_1 -> 
	happyIn80
		 (happy_var_1
	)}

happyReduce_309 = happySpecReduce_2  66# happyReduction_309
happyReduction_309 happy_x_2
	happy_x_1
	 =  case happyOut72 happy_x_1 of { happy_var_1 -> 
	case happyOut81 happy_x_2 of { happy_var_2 -> 
	happyIn80
		 (happy_var_2 . happy_var_1
	)}}

happyReduce_310 = happySpecReduce_3  67# happyReduction_310
happyReduction_310 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut80 happy_x_2 of { happy_var_2 -> 
	happyIn81
		 (happy_var_2
	)}

happyReduce_311 = happyMonadReduce 3# 67# happyReduction_311
happyReduction_311 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut80 happy_x_2 of { happy_var_2 -> 
	( do{ let decl = happy_var_2 (declRoot happy_var_1)
           ; unclosed (happy_var_1 <--> decl) "("
           })}}
	) (\r -> happyReturn (happyIn81 r))

happyReduce_312 = happySpecReduce_1  67# happyReduction_312
happyReduction_312 happy_x_1
	 =  case happyOut71 happy_x_1 of { happy_var_1 -> 
	happyIn81
		 (happy_var_1
	)}

happyReduce_313 = happySpecReduce_2  67# happyReduction_313
happyReduction_313 happy_x_2
	happy_x_1
	 =  case happyOut81 happy_x_1 of { happy_var_1 -> 
	case happyOut71 happy_x_2 of { happy_var_2 -> 
	happyIn81
		 (happy_var_1 . happy_var_2
	)}}

happyReduce_314 = happySpecReduce_2  67# happyReduction_314
happyReduction_314 happy_x_2
	happy_x_1
	 =  happyIn81
		 (mkOldProto []
	)

happyReduce_315 = happySpecReduce_3  67# happyReduction_315
happyReduction_315 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut74 happy_x_2 of { happy_var_2 -> 
	happyIn81
		 (mkProto happy_var_2
	)}

happyReduce_316 = happySpecReduce_3  67# happyReduction_316
happyReduction_316 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut81 happy_x_1 of { happy_var_1 -> 
	happyIn81
		 (happy_var_1 . mkOldProto []
	)}

happyReduce_317 = happyReduce 4# 67# happyReduction_317
happyReduction_317 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut81 happy_x_1 of { happy_var_1 -> 
	case happyOut74 happy_x_3 of { happy_var_3 -> 
	happyIn81
		 (happy_var_1 . mkProto happy_var_3
	) `HappyStk` happyRest}}

happyReduce_318 = happySpecReduce_1  68# happyReduction_318
happyReduction_318 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn82
		 (TSnamed (Id (getNAMED happy_var_1) (locOf happy_var_1)) (locOf happy_var_1)
	)}

happyReduce_319 = happySpecReduce_2  68# happyReduction_319
happyReduction_319 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut14 happy_x_2 of { happy_var_2 -> 
	happyIn82
		 (TSnamed happy_var_2 (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_320 = happyMonadReduce 2# 68# happyReduction_320
happyReduction_320 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { happy_var_1 -> 
	( expected (locOf happy_var_1) ["identifier"])}
	) (\r -> happyReturn (happyIn82 r))

happyReduce_321 = happyReduce 4# 68# happyReduction_321
happyReduction_321 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut22 happy_x_3 of { happy_var_3 -> 
	case happyOutTok happy_x_4 of { happy_var_4 -> 
	happyIn82
		 (TStypeofExp happy_var_3 (happy_var_1 <--> happy_var_4)
	) `HappyStk` happyRest}}}

happyReduce_322 = happyReduce 4# 68# happyReduction_322
happyReduction_322 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut79 happy_x_3 of { happy_var_3 -> 
	case happyOutTok happy_x_4 of { happy_var_4 -> 
	happyIn82
		 (TStypeofType happy_var_3 (happy_var_1 <--> happy_var_4)
	) `HappyStk` happyRest}}}

happyReduce_323 = happyMonadReduce 4# 68# happyReduction_323
happyReduction_323 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_2 of { happy_var_2 -> 
	case happyOut79 happy_x_3 of { happy_var_3 -> 
	( unclosed (happy_var_2 <--> happy_var_3) "(")}}
	) (\r -> happyReturn (happyIn82 r))

happyReduce_324 = happySpecReduce_1  69# happyReduction_324
happyReduction_324 happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	happyIn83
		 (ExpInitializer happy_var_1 (locOf happy_var_1)
	)}

happyReduce_325 = happySpecReduce_3  69# happyReduction_325
happyReduction_325 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut84 happy_x_2 of { happy_var_2 -> 
	case happyOutTok happy_x_3 of { happy_var_3 -> 
	happyIn83
		 (CompoundInitializer (rev happy_var_2) (happy_var_1 <--> happy_var_3)
	)}}}

happyReduce_326 = happyMonadReduce 3# 69# happyReduction_326
happyReduction_326 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut84 happy_x_2 of { happy_var_2 -> 
	( do{  let (_, inits) = unzip (rev happy_var_2)
           ;  unclosed (happy_var_1 <--> inits) "{"
           })}}
	) (\r -> happyReturn (happyIn83 r))

happyReduce_327 = happyReduce 4# 69# happyReduction_327
happyReduction_327 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut84 happy_x_2 of { happy_var_2 -> 
	case happyOutTok happy_x_4 of { happy_var_4 -> 
	happyIn83
		 (CompoundInitializer (rev happy_var_2) (happy_var_1 <--> happy_var_4)
	) `HappyStk` happyRest}}}

happyReduce_328 = happyMonadReduce 4# 69# happyReduction_328
happyReduction_328 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_3 of { happy_var_3 -> 
	( unclosed (happy_var_1 <--> happy_var_3) "{")}}
	) (\r -> happyReturn (happyIn83 r))

happyReduce_329 = happySpecReduce_1  70# happyReduction_329
happyReduction_329 happy_x_1
	 =  case happyOut83 happy_x_1 of { happy_var_1 -> 
	happyIn84
		 (rsingleton (Nothing, happy_var_1)
	)}

happyReduce_330 = happySpecReduce_2  70# happyReduction_330
happyReduction_330 happy_x_2
	happy_x_1
	 =  case happyOut85 happy_x_1 of { happy_var_1 -> 
	case happyOut83 happy_x_2 of { happy_var_2 -> 
	happyIn84
		 (rsingleton (Just happy_var_1, happy_var_2)
	)}}

happyReduce_331 = happySpecReduce_3  70# happyReduction_331
happyReduction_331 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut84 happy_x_1 of { happy_var_1 -> 
	case happyOut83 happy_x_3 of { happy_var_3 -> 
	happyIn84
		 (rcons (Nothing, happy_var_3) happy_var_1
	)}}

happyReduce_332 = happyReduce 4# 70# happyReduction_332
happyReduction_332 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut84 happy_x_1 of { happy_var_1 -> 
	case happyOut85 happy_x_3 of { happy_var_3 -> 
	case happyOut83 happy_x_4 of { happy_var_4 -> 
	happyIn84
		 (rcons (Just happy_var_3, happy_var_4) happy_var_1
	) `HappyStk` happyRest}}}

happyReduce_333 = happySpecReduce_2  71# happyReduction_333
happyReduction_333 happy_x_2
	happy_x_1
	 =  case happyOut86 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { happy_var_2 -> 
	happyIn85
		 (let designators = rev happy_var_1
        in
          Designation designators (designators <--> happy_var_2)
	)}}

happyReduce_334 = happySpecReduce_1  72# happyReduction_334
happyReduction_334 happy_x_1
	 =  case happyOut87 happy_x_1 of { happy_var_1 -> 
	happyIn86
		 (rsingleton happy_var_1
	)}

happyReduce_335 = happySpecReduce_2  72# happyReduction_335
happyReduction_335 happy_x_2
	happy_x_1
	 =  case happyOut86 happy_x_1 of { happy_var_1 -> 
	case happyOut87 happy_x_2 of { happy_var_2 -> 
	happyIn86
		 (rcons happy_var_2 happy_var_1
	)}}

happyReduce_336 = happySpecReduce_3  73# happyReduction_336
happyReduction_336 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut38 happy_x_2 of { happy_var_2 -> 
	case happyOutTok happy_x_3 of { happy_var_3 -> 
	happyIn87
		 (IndexDesignator happy_var_2 (happy_var_1 <--> happy_var_3)
	)}}}

happyReduce_337 = happySpecReduce_2  73# happyReduction_337
happyReduction_337 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut14 happy_x_2 of { happy_var_2 -> 
	happyIn87
		 (MemberDesignator happy_var_2 (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_338 = happySpecReduce_1  74# happyReduction_338
happyReduction_338 happy_x_1
	 =  case happyOut89 happy_x_1 of { happy_var_1 -> 
	happyIn88
		 (happy_var_1
	)}

happyReduce_339 = happySpecReduce_1  74# happyReduction_339
happyReduction_339 happy_x_1
	 =  case happyOut90 happy_x_1 of { happy_var_1 -> 
	happyIn88
		 (happy_var_1
	)}

happyReduce_340 = happySpecReduce_1  74# happyReduction_340
happyReduction_340 happy_x_1
	 =  case happyOut96 happy_x_1 of { happy_var_1 -> 
	happyIn88
		 (happy_var_1
	)}

happyReduce_341 = happySpecReduce_1  74# happyReduction_341
happyReduction_341 happy_x_1
	 =  case happyOut97 happy_x_1 of { happy_var_1 -> 
	happyIn88
		 (happy_var_1
	)}

happyReduce_342 = happySpecReduce_1  74# happyReduction_342
happyReduction_342 happy_x_1
	 =  case happyOut98 happy_x_1 of { happy_var_1 -> 
	happyIn88
		 (happy_var_1
	)}

happyReduce_343 = happySpecReduce_1  74# happyReduction_343
happyReduction_343 happy_x_1
	 =  case happyOut99 happy_x_1 of { happy_var_1 -> 
	happyIn88
		 (happy_var_1
	)}

happyReduce_344 = happySpecReduce_1  74# happyReduction_344
happyReduction_344 happy_x_1
	 =  case happyOut110 happy_x_1 of { happy_var_1 -> 
	happyIn88
		 (happy_var_1
	)}

happyReduce_345 = happySpecReduce_1  74# happyReduction_345
happyReduction_345 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn88
		 (AntiStm (getANTI_STM happy_var_1) (locOf happy_var_1)
	)}

happyReduce_346 = happySpecReduce_3  75# happyReduction_346
happyReduction_346 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut14 happy_x_1 of { happy_var_1 -> 
	case happyOut88 happy_x_3 of { happy_var_3 -> 
	happyIn89
		 (Label happy_var_1 happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_347 = happyReduce 4# 75# happyReduction_347
happyReduction_347 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut38 happy_x_2 of { happy_var_2 -> 
	case happyOut88 happy_x_4 of { happy_var_4 -> 
	happyIn89
		 (Case happy_var_2 happy_var_4 (happy_var_1 <--> happy_var_4)
	) `HappyStk` happyRest}}}

happyReduce_348 = happySpecReduce_3  75# happyReduction_348
happyReduction_348 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut88 happy_x_3 of { happy_var_3 -> 
	happyIn89
		 (Default happy_var_3 (happy_var_1 <--> happy_var_3)
	)}}

happyReduce_349 = happyReduce 4# 76# happyReduction_349
happyReduction_349 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_4 of { happy_var_4 -> 
	happyIn90
		 (Block [] (happy_var_1 <--> happy_var_4)
	) `HappyStk` happyRest}}

happyReduce_350 = happyMonadReduce 3# 76# happyReduction_350
happyReduction_350 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_3 of { happy_var_3 -> 
	( unclosed (locOf happy_var_3) "{")}
	) (\r -> happyReturn (happyIn90 r))

happyReduce_351 = happyReduce 5# 76# happyReduction_351
happyReduction_351 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut91 happy_x_3 of { happy_var_3 -> 
	case happyOutTok happy_x_5 of { happy_var_5 -> 
	happyIn90
		 (Block (rev happy_var_3) (happy_var_1 <--> happy_var_5)
	) `HappyStk` happyRest}}}

happyReduce_352 = happySpecReduce_1  77# happyReduction_352
happyReduction_352 happy_x_1
	 =  case happyOut92 happy_x_1 of { happy_var_1 -> 
	happyIn91
		 (rsingleton happy_var_1
	)}

happyReduce_353 = happySpecReduce_2  77# happyReduction_353
happyReduction_353 happy_x_2
	happy_x_1
	 =  case happyOut91 happy_x_1 of { happy_var_1 -> 
	case happyOut92 happy_x_2 of { happy_var_2 -> 
	happyIn91
		 (rcons happy_var_2 happy_var_1
	)}}

happyReduce_354 = happySpecReduce_1  78# happyReduction_354
happyReduction_354 happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	happyIn92
		 (BlockDecl happy_var_1
	)}

happyReduce_355 = happySpecReduce_1  78# happyReduction_355
happyReduction_355 happy_x_1
	 =  case happyOut88 happy_x_1 of { happy_var_1 -> 
	happyIn92
		 (BlockStm happy_var_1
	)}

happyReduce_356 = happySpecReduce_1  78# happyReduction_356
happyReduction_356 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn92
		 (BlockDecl (AntiDecls (getANTI_DECLS happy_var_1) (locOf happy_var_1))
	)}

happyReduce_357 = happySpecReduce_1  78# happyReduction_357
happyReduction_357 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn92
		 (BlockStm (AntiStms (getANTI_STMS happy_var_1) (locOf happy_var_1))
	)}

happyReduce_358 = happySpecReduce_1  78# happyReduction_358
happyReduction_358 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn92
		 (AntiBlockItem (getANTI_ITEM happy_var_1) (locOf happy_var_1)
	)}

happyReduce_359 = happySpecReduce_1  78# happyReduction_359
happyReduction_359 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn92
		 (AntiBlockItems (getANTI_ITEMS happy_var_1)  (locOf happy_var_1)
	)}

happyReduce_360 = happyMonadReduce 0# 79# happyReduction_360
happyReduction_360 (happyRest) tk
	 = happyThen (( pushScope)
	) (\r -> happyReturn (happyIn93 r))

happyReduce_361 = happyMonadReduce 0# 80# happyReduction_361
happyReduction_361 (happyRest) tk
	 = happyThen (( popScope)
	) (\r -> happyReturn (happyIn94 r))

happyReduce_362 = happySpecReduce_1  81# happyReduction_362
happyReduction_362 happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	happyIn95
		 (rsingleton happy_var_1
	)}

happyReduce_363 = happySpecReduce_1  81# happyReduction_363
happyReduction_363 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn95
		 (rsingleton (AntiDecls (getANTI_DECLS happy_var_1) (locOf happy_var_1))
	)}

happyReduce_364 = happySpecReduce_2  81# happyReduction_364
happyReduction_364 happy_x_2
	happy_x_1
	 =  case happyOut95 happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_2 of { happy_var_2 -> 
	happyIn95
		 (rcons happy_var_2 happy_var_1
	)}}

happyReduce_365 = happySpecReduce_2  81# happyReduction_365
happyReduction_365 happy_x_2
	happy_x_1
	 =  case happyOut95 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { happy_var_2 -> 
	happyIn95
		 (rcons (AntiDecls (getANTI_DECLS happy_var_2) (locOf happy_var_2)) happy_var_1
	)}}

happyReduce_366 = happySpecReduce_1  82# happyReduction_366
happyReduction_366 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn96
		 (Exp Nothing (locOf happy_var_1)
	)}

happyReduce_367 = happySpecReduce_2  82# happyReduction_367
happyReduction_367 happy_x_2
	happy_x_1
	 =  case happyOut36 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { happy_var_2 -> 
	happyIn96
		 (Exp (Just happy_var_1) (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_368 = happyMonadReduce 2# 82# happyReduction_368
happyReduction_368 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut36 happy_x_1 of { happy_var_1 -> 
	( expected (locOf happy_var_1) ["';'"])}
	) (\r -> happyReturn (happyIn96 r))

happyReduce_369 = happyReduce 5# 83# happyReduction_369
happyReduction_369 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	case happyOut88 happy_x_5 of { happy_var_5 -> 
	happyIn97
		 (If happy_var_3 happy_var_5 Nothing (happy_var_1 <--> happy_var_5)
	) `HappyStk` happyRest}}}

happyReduce_370 = happyReduce 7# 83# happyReduction_370
happyReduction_370 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	case happyOut88 happy_x_5 of { happy_var_5 -> 
	case happyOut88 happy_x_7 of { happy_var_7 -> 
	happyIn97
		 (If happy_var_3 happy_var_5 (Just happy_var_7) (happy_var_1 <--> happy_var_7)
	) `HappyStk` happyRest}}}}

happyReduce_371 = happyMonadReduce 4# 83# happyReduction_371
happyReduction_371 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_2 of { happy_var_2 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	( unclosed (happy_var_2 <--> happy_var_3) "(")}}
	) (\r -> happyReturn (happyIn97 r))

happyReduce_372 = happyReduce 5# 83# happyReduction_372
happyReduction_372 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	case happyOut88 happy_x_5 of { happy_var_5 -> 
	happyIn97
		 (Switch happy_var_3 happy_var_5 (happy_var_1 <--> happy_var_5)
	) `HappyStk` happyRest}}}

happyReduce_373 = happyMonadReduce 4# 83# happyReduction_373
happyReduction_373 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_2 of { happy_var_2 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	( unclosed (happy_var_2 <--> happy_var_3) "(")}}
	) (\r -> happyReturn (happyIn97 r))

happyReduce_374 = happyReduce 5# 84# happyReduction_374
happyReduction_374 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	case happyOut88 happy_x_5 of { happy_var_5 -> 
	happyIn98
		 (While happy_var_3 happy_var_5 (happy_var_1 <--> happy_var_5)
	) `HappyStk` happyRest}}}

happyReduce_375 = happyMonadReduce 4# 84# happyReduction_375
happyReduction_375 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_2 of { happy_var_2 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	( unclosed (happy_var_2 <--> happy_var_3) "(")}}
	) (\r -> happyReturn (happyIn98 r))

happyReduce_376 = happyReduce 7# 84# happyReduction_376
happyReduction_376 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut88 happy_x_2 of { happy_var_2 -> 
	case happyOut36 happy_x_5 of { happy_var_5 -> 
	case happyOutTok happy_x_7 of { happy_var_7 -> 
	happyIn98
		 (DoWhile happy_var_2 happy_var_5 (happy_var_1 <--> happy_var_7)
	) `HappyStk` happyRest}}}}

happyReduce_377 = happyMonadReduce 6# 84# happyReduction_377
happyReduction_377 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_4 of { happy_var_4 -> 
	case happyOut36 happy_x_5 of { happy_var_5 -> 
	( unclosed (happy_var_4 <--> happy_var_5) "(")}}
	) (\r -> happyReturn (happyIn98 r))

happyReduce_378 = happyMonadReduce 3# 84# happyReduction_378
happyReduction_378 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_2 of { happy_var_2 -> 
	( expected (locOf happy_var_2) ["expression", "declaration"])}
	) (\r -> happyReturn (happyIn98 r))

happyReduce_379 = happyReduce 7# 84# happyReduction_379
happyReduction_379 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_3 of { happy_var_3 -> 
	case happyOut37 happy_x_4 of { happy_var_4 -> 
	case happyOut88 happy_x_7 of { happy_var_7 -> 
	happyIn98
		 (For (Left happy_var_3) happy_var_4 Nothing happy_var_7 (happy_var_1 <--> happy_var_7)
	) `HappyStk` happyRest}}}}

happyReduce_380 = happyReduce 8# 84# happyReduction_380
happyReduction_380 (happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut37 happy_x_3 of { happy_var_3 -> 
	case happyOut37 happy_x_5 of { happy_var_5 -> 
	case happyOut88 happy_x_8 of { happy_var_8 -> 
	happyIn98
		 (For (Right happy_var_3) happy_var_5 Nothing happy_var_8 (happy_var_1 <--> happy_var_8)
	) `HappyStk` happyRest}}}}

happyReduce_381 = happyMonadReduce 7# 84# happyReduction_381
happyReduction_381 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_2 of { happy_var_2 -> 
	case happyOutTok happy_x_6 of { happy_var_6 -> 
	( unclosed (happy_var_2 <--> happy_var_6) "(")}}
	) (\r -> happyReturn (happyIn98 r))

happyReduce_382 = happyReduce 8# 84# happyReduction_382
happyReduction_382 (happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_3 of { happy_var_3 -> 
	case happyOut37 happy_x_4 of { happy_var_4 -> 
	case happyOut36 happy_x_6 of { happy_var_6 -> 
	case happyOut88 happy_x_8 of { happy_var_8 -> 
	happyIn98
		 (For (Left happy_var_3) happy_var_4 (Just happy_var_6) happy_var_8 (happy_var_1 <--> happy_var_8)
	) `HappyStk` happyRest}}}}}

happyReduce_383 = happyReduce 9# 84# happyReduction_383
happyReduction_383 (happy_x_9 `HappyStk`
	happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut37 happy_x_3 of { happy_var_3 -> 
	case happyOut37 happy_x_5 of { happy_var_5 -> 
	case happyOut36 happy_x_7 of { happy_var_7 -> 
	case happyOut88 happy_x_9 of { happy_var_9 -> 
	happyIn98
		 (For (Right happy_var_3) happy_var_5 (Just happy_var_7) happy_var_9 (happy_var_1 <--> happy_var_9)
	) `HappyStk` happyRest}}}}}

happyReduce_384 = happyMonadReduce 8# 84# happyReduction_384
happyReduction_384 (happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_2 of { happy_var_2 -> 
	case happyOut36 happy_x_7 of { happy_var_7 -> 
	( unclosed (happy_var_2 <--> happy_var_7) "(")}}
	) (\r -> happyReturn (happyIn98 r))

happyReduce_385 = happySpecReduce_3  85# happyReduction_385
happyReduction_385 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut14 happy_x_2 of { happy_var_2 -> 
	case happyOutTok happy_x_3 of { happy_var_3 -> 
	happyIn99
		 (Goto happy_var_2 (happy_var_1 <--> happy_var_3)
	)}}}

happyReduce_386 = happyMonadReduce 2# 85# happyReduction_386
happyReduction_386 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { happy_var_1 -> 
	( expected (locOf happy_var_1) ["identifier"])}
	) (\r -> happyReturn (happyIn99 r))

happyReduce_387 = happyMonadReduce 3# 85# happyReduction_387
happyReduction_387 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut14 happy_x_2 of { happy_var_2 -> 
	( expected (locOf happy_var_2) ["';'"])}
	) (\r -> happyReturn (happyIn99 r))

happyReduce_388 = happySpecReduce_2  85# happyReduction_388
happyReduction_388 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { happy_var_2 -> 
	happyIn99
		 (Continue (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_389 = happyMonadReduce 2# 85# happyReduction_389
happyReduction_389 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { happy_var_1 -> 
	( expected (locOf happy_var_1) ["';'"])}
	) (\r -> happyReturn (happyIn99 r))

happyReduce_390 = happySpecReduce_2  85# happyReduction_390
happyReduction_390 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { happy_var_2 -> 
	happyIn99
		 (Break (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_391 = happyMonadReduce 2# 85# happyReduction_391
happyReduction_391 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { happy_var_1 -> 
	( expected (locOf happy_var_1) ["';'"])}
	) (\r -> happyReturn (happyIn99 r))

happyReduce_392 = happySpecReduce_2  85# happyReduction_392
happyReduction_392 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { happy_var_2 -> 
	happyIn99
		 (Return Nothing (happy_var_1 <--> happy_var_2)
	)}}

happyReduce_393 = happyMonadReduce 2# 85# happyReduction_393
happyReduction_393 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { happy_var_1 -> 
	( expected (locOf happy_var_1) ["';'"])}
	) (\r -> happyReturn (happyIn99 r))

happyReduce_394 = happySpecReduce_3  85# happyReduction_394
happyReduction_394 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_2 of { happy_var_2 -> 
	case happyOutTok happy_x_3 of { happy_var_3 -> 
	happyIn99
		 (Return (Just happy_var_2) (happy_var_1 <--> happy_var_3)
	)}}}

happyReduce_395 = happyMonadReduce 3# 85# happyReduction_395
happyReduction_395 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut36 happy_x_2 of { happy_var_2 -> 
	( expected (locOf happy_var_2) ["';'"])}
	) (\r -> happyReturn (happyIn99 r))

happyReduce_396 = happySpecReduce_0  86# happyReduction_396
happyReduction_396  =  happyIn100
		 ([]
	)

happyReduce_397 = happySpecReduce_1  86# happyReduction_397
happyReduction_397 happy_x_1
	 =  case happyOut101 happy_x_1 of { happy_var_1 -> 
	happyIn100
		 (rev happy_var_1
	)}

happyReduce_398 = happySpecReduce_1  87# happyReduction_398
happyReduction_398 happy_x_1
	 =  case happyOut102 happy_x_1 of { happy_var_1 -> 
	happyIn101
		 (rsingleton happy_var_1
	)}

happyReduce_399 = happySpecReduce_1  87# happyReduction_399
happyReduction_399 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn101
		 (rsingleton (AntiEdecls (getANTI_EDECLS happy_var_1) (locOf happy_var_1))
	)}

happyReduce_400 = happySpecReduce_2  87# happyReduction_400
happyReduction_400 happy_x_2
	happy_x_1
	 =  case happyOut101 happy_x_1 of { happy_var_1 -> 
	case happyOut102 happy_x_2 of { happy_var_2 -> 
	happyIn101
		 (rcons happy_var_2 happy_var_1
	)}}

happyReduce_401 = happySpecReduce_2  87# happyReduction_401
happyReduction_401 happy_x_2
	happy_x_1
	 =  case happyOut101 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { happy_var_2 -> 
	happyIn101
		 (rcons (AntiEdecls (getANTI_EDECLS happy_var_2) (locOf happy_var_2)) happy_var_1
	)}}

happyReduce_402 = happySpecReduce_1  88# happyReduction_402
happyReduction_402 happy_x_1
	 =  case happyOut103 happy_x_1 of { happy_var_1 -> 
	happyIn102
		 (FuncDef happy_var_1 (locOf happy_var_1)
	)}

happyReduce_403 = happySpecReduce_1  88# happyReduction_403
happyReduction_403 happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	happyIn102
		 (DecDef happy_var_1 (locOf happy_var_1)
	)}

happyReduce_404 = happySpecReduce_1  88# happyReduction_404
happyReduction_404 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn102
		 (AntiFunc (getANTI_FUNC happy_var_1) (locOf happy_var_1)
	)}

happyReduce_405 = happySpecReduce_1  88# happyReduction_405
happyReduction_405 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn102
		 (AntiEsc (getANTI_ESC happy_var_1) (locOf happy_var_1)
	)}

happyReduce_406 = happySpecReduce_1  88# happyReduction_406
happyReduction_406 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn102
		 (AntiEdecl (getANTI_EDECL happy_var_1) (locOf happy_var_1)
	)}

happyReduce_407 = happyMonadReduce 3# 89# happyReduction_407
happyReduction_407 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut67 happy_x_2 of { happy_var_2 -> 
	case happyOut90 happy_x_3 of { happy_var_3 -> 
	( do{ let (dspec, declRoot)   =  happy_var_1
           ; let (ident, declToDecl) =  happy_var_2
           ; let Block blockItems _  =  happy_var_3
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
           })}}}
	) (\r -> happyReturn (happyIn103 r))

happyReduce_408 = happyMonadReduce 4# 89# happyReduction_408
happyReduction_408 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut67 happy_x_2 of { happy_var_2 -> 
	case happyOut95 happy_x_3 of { happy_var_3 -> 
	case happyOut90 happy_x_4 of { happy_var_4 -> 
	( do{ let (dspec, declRoot)   =  happy_var_1
           ; let (ident, declToDecl) =  happy_var_2
           ; let argDecls            =  happy_var_3
           ; let Block blockItems _  =  happy_var_4
           ; let decl                =  declToDecl declRoot
           ; case decl of
               { OldProto protoDecl args _ -> return $
                     OldFunc dspec ident protoDecl args (Just (rev argDecls))
                             blockItems
                             (decl <--> blockItems)
               ; _ -> failAt (decl <--> blockItems :: Loc)
                             "bad function declaration"
               }
           })}}}}
	) (\r -> happyReturn (happyIn103 r))

happyReduce_409 = happySpecReduce_1  90# happyReduction_409
happyReduction_409 happy_x_1
	 =  case happyOut105 happy_x_1 of { happy_var_1 -> 
	happyIn104
		 (happy_var_1
	)}

happyReduce_410 = happySpecReduce_2  90# happyReduction_410
happyReduction_410 happy_x_2
	happy_x_1
	 =  case happyOut104 happy_x_1 of { happy_var_1 -> 
	case happyOut105 happy_x_2 of { happy_var_2 -> 
	happyIn104
		 (happy_var_1 ++ happy_var_2
	)}}

happyReduce_411 = happyReduce 6# 91# happyReduction_411
happyReduction_411 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut106 happy_x_4 of { happy_var_4 -> 
	happyIn105
		 (rev happy_var_4
	) `HappyStk` happyRest}

happyReduce_412 = happySpecReduce_1  92# happyReduction_412
happyReduction_412 happy_x_1
	 =  case happyOut107 happy_x_1 of { happy_var_1 -> 
	happyIn106
		 (rsingleton happy_var_1
	)}

happyReduce_413 = happySpecReduce_3  92# happyReduction_413
happyReduction_413 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut106 happy_x_1 of { happy_var_1 -> 
	case happyOut107 happy_x_3 of { happy_var_3 -> 
	happyIn106
		 (rcons happy_var_3 happy_var_1
	)}}

happyReduce_414 = happySpecReduce_1  93# happyReduction_414
happyReduction_414 happy_x_1
	 =  case happyOut108 happy_x_1 of { happy_var_1 -> 
	happyIn107
		 (Attr happy_var_1 [] (locOf happy_var_1)
	)}

happyReduce_415 = happyReduce 4# 93# happyReduction_415
happyReduction_415 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut108 happy_x_1 of { happy_var_1 -> 
	case happyOut21 happy_x_3 of { happy_var_3 -> 
	case happyOutTok happy_x_4 of { happy_var_4 -> 
	happyIn107
		 (Attr happy_var_1 (rev happy_var_3) (happy_var_1 <--> happy_var_4)
	) `HappyStk` happyRest}}}

happyReduce_416 = happySpecReduce_1  94# happyReduction_416
happyReduction_416 happy_x_1
	 =  case happyOut15 happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (happy_var_1
	)}

happyReduce_417 = happySpecReduce_1  94# happyReduction_417
happyReduction_417 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (Id "static" (locOf happy_var_1)
	)}

happyReduce_418 = happySpecReduce_1  94# happyReduction_418
happyReduction_418 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (Id "extern" (locOf happy_var_1)
	)}

happyReduce_419 = happySpecReduce_1  94# happyReduction_419
happyReduction_419 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (Id "register" (locOf happy_var_1)
	)}

happyReduce_420 = happySpecReduce_1  94# happyReduction_420
happyReduction_420 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (Id "typedef" (locOf happy_var_1)
	)}

happyReduce_421 = happySpecReduce_1  94# happyReduction_421
happyReduction_421 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (Id "inline" (locOf happy_var_1)
	)}

happyReduce_422 = happySpecReduce_1  94# happyReduction_422
happyReduction_422 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (Id "auto" (locOf happy_var_1)
	)}

happyReduce_423 = happySpecReduce_1  94# happyReduction_423
happyReduction_423 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (Id "const" (locOf happy_var_1)
	)}

happyReduce_424 = happySpecReduce_1  94# happyReduction_424
happyReduction_424 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (Id "volatile" (locOf happy_var_1)
	)}

happyReduce_425 = happySpecReduce_1  94# happyReduction_425
happyReduction_425 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (Id "unsigned" (locOf happy_var_1)
	)}

happyReduce_426 = happySpecReduce_1  94# happyReduction_426
happyReduction_426 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (Id "long" (locOf happy_var_1)
	)}

happyReduce_427 = happySpecReduce_1  94# happyReduction_427
happyReduction_427 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (Id "short" (locOf happy_var_1)
	)}

happyReduce_428 = happySpecReduce_1  94# happyReduction_428
happyReduction_428 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (Id "signed" (locOf happy_var_1)
	)}

happyReduce_429 = happySpecReduce_1  94# happyReduction_429
happyReduction_429 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (Id "int" (locOf happy_var_1)
	)}

happyReduce_430 = happySpecReduce_1  94# happyReduction_430
happyReduction_430 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (Id "char" (locOf happy_var_1)
	)}

happyReduce_431 = happySpecReduce_1  94# happyReduction_431
happyReduction_431 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (Id "float" (locOf happy_var_1)
	)}

happyReduce_432 = happySpecReduce_1  94# happyReduction_432
happyReduction_432 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (Id "double" (locOf happy_var_1)
	)}

happyReduce_433 = happySpecReduce_1  94# happyReduction_433
happyReduction_433 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn108
		 (Id "void" (locOf happy_var_1)
	)}

happyReduce_434 = happySpecReduce_0  95# happyReduction_434
happyReduction_434  =  happyIn109
		 (False
	)

happyReduce_435 = happySpecReduce_1  95# happyReduction_435
happyReduction_435 happy_x_1
	 =  happyIn109
		 (True
	)

happyReduce_436 = happyReduce 6# 96# happyReduction_436
happyReduction_436 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut109 happy_x_2 of { happy_var_2 -> 
	case happyOut111 happy_x_4 of { happy_var_4 -> 
	case happyOutTok happy_x_5 of { happy_var_5 -> 
	happyIn110
		 (Asm happy_var_2 [] (rev happy_var_4) [] [] [] (happy_var_1 <--> happy_var_5)
	) `HappyStk` happyRest}}}}

happyReduce_437 = happyReduce 8# 96# happyReduction_437
happyReduction_437 (happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut109 happy_x_2 of { happy_var_2 -> 
	case happyOut111 happy_x_4 of { happy_var_4 -> 
	case happyOut112 happy_x_6 of { happy_var_6 -> 
	case happyOutTok happy_x_7 of { happy_var_7 -> 
	happyIn110
		 (Asm happy_var_2 [] (rev happy_var_4) happy_var_6 [] [] (happy_var_1 <--> happy_var_7)
	) `HappyStk` happyRest}}}}}

happyReduce_438 = happyReduce 10# 96# happyReduction_438
happyReduction_438 (happy_x_10 `HappyStk`
	happy_x_9 `HappyStk`
	happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut109 happy_x_2 of { happy_var_2 -> 
	case happyOut111 happy_x_4 of { happy_var_4 -> 
	case happyOut112 happy_x_6 of { happy_var_6 -> 
	case happyOut112 happy_x_8 of { happy_var_8 -> 
	case happyOutTok happy_x_9 of { happy_var_9 -> 
	happyIn110
		 (Asm happy_var_2 [] (rev happy_var_4) happy_var_6 happy_var_8 [] (happy_var_1 <--> happy_var_9)
	) `HappyStk` happyRest}}}}}}

happyReduce_439 = happyReduce 12# 96# happyReduction_439
happyReduction_439 (happy_x_12 `HappyStk`
	happy_x_11 `HappyStk`
	happy_x_10 `HappyStk`
	happy_x_9 `HappyStk`
	happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut109 happy_x_2 of { happy_var_2 -> 
	case happyOut111 happy_x_4 of { happy_var_4 -> 
	case happyOut112 happy_x_6 of { happy_var_6 -> 
	case happyOut112 happy_x_8 of { happy_var_8 -> 
	case happyOut115 happy_x_10 of { happy_var_10 -> 
	case happyOutTok happy_x_11 of { happy_var_11 -> 
	happyIn110
		 (Asm happy_var_2 [] (rev happy_var_4) happy_var_6 happy_var_8 happy_var_10 (happy_var_1 <--> happy_var_11)
	) `HappyStk` happyRest}}}}}}}

happyReduce_440 = happySpecReduce_1  97# happyReduction_440
happyReduction_440 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn111
		 (rsingleton ((fst . getSTRING) happy_var_1)
	)}

happyReduce_441 = happySpecReduce_2  97# happyReduction_441
happyReduction_441 happy_x_2
	happy_x_1
	 =  case happyOut111 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { happy_var_2 -> 
	happyIn111
		 (rcons ((fst . getSTRING) happy_var_2) happy_var_1
	)}}

happyReduce_442 = happySpecReduce_0  98# happyReduction_442
happyReduction_442  =  happyIn112
		 ([]
	)

happyReduce_443 = happySpecReduce_1  98# happyReduction_443
happyReduction_443 happy_x_1
	 =  case happyOut113 happy_x_1 of { happy_var_1 -> 
	happyIn112
		 (rev happy_var_1
	)}

happyReduce_444 = happySpecReduce_1  99# happyReduction_444
happyReduction_444 happy_x_1
	 =  case happyOut114 happy_x_1 of { happy_var_1 -> 
	happyIn113
		 (rsingleton happy_var_1
	)}

happyReduce_445 = happySpecReduce_3  99# happyReduction_445
happyReduction_445 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut113 happy_x_1 of { happy_var_1 -> 
	case happyOut114 happy_x_3 of { happy_var_3 -> 
	happyIn113
		 (rcons happy_var_3 happy_var_1
	)}}

happyReduce_446 = happyReduce 4# 100# happyReduction_446
happyReduction_446 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	happyIn114
		 (((fst . getSTRING) happy_var_1, happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_447 = happySpecReduce_0  101# happyReduction_447
happyReduction_447  =  happyIn115
		 ([]
	)

happyReduce_448 = happySpecReduce_1  101# happyReduction_448
happyReduction_448 happy_x_1
	 =  case happyOut116 happy_x_1 of { happy_var_1 -> 
	happyIn115
		 (rev happy_var_1
	)}

happyReduce_449 = happySpecReduce_1  102# happyReduction_449
happyReduction_449 happy_x_1
	 =  case happyOut117 happy_x_1 of { happy_var_1 -> 
	happyIn116
		 (rsingleton happy_var_1
	)}

happyReduce_450 = happySpecReduce_3  102# happyReduction_450
happyReduction_450 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut116 happy_x_1 of { happy_var_1 -> 
	case happyOut117 happy_x_3 of { happy_var_3 -> 
	happyIn116
		 (rcons happy_var_3 happy_var_1
	)}}

happyReduce_451 = happySpecReduce_1  103# happyReduction_451
happyReduction_451 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn117
		 ((fst . getSTRING) happy_var_1
	)}

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = happyDoAction i tk action sts stk in
	case tk of {
	L _ T.Teof -> happyDoAction 139# tk action sts stk;
	L _ (T.TcharConst _) -> cont 1#;
	L _ (T.TstringConst _) -> cont 2#;
	L _ (T.TintConst _) -> cont 3#;
	L _ (T.TlongIntConst _) -> cont 4#;
	L _ (T.TlongLongIntConst _) -> cont 5#;
	L _ (T.TfloatConst _) -> cont 6#;
	L _ (T.TdoubleConst _) -> cont 7#;
	L _ (T.TlongDoubleConst _) -> cont 8#;
	L _ (T.Tidentifier _) -> cont 9#;
	L _ (T.Tnamed _) -> cont 10#;
	L _ T.Tlparen -> cont 11#;
	L _ T.Trparen -> cont 12#;
	L _ T.Tlbrack -> cont 13#;
	L _ T.Trbrack -> cont 14#;
	L _ T.Tlbrace -> cont 15#;
	L _ T.Trbrace -> cont 16#;
	L _ T.Tcomma -> cont 17#;
	L _ T.Tsemi -> cont 18#;
	L _ T.Tcolon -> cont 19#;
	L _ T.Tquestion -> cont 20#;
	L _ T.Tdot -> cont 21#;
	L _ T.Tarrow -> cont 22#;
	L _ T.Tellipses -> cont 23#;
	L _ T.Tplus -> cont 24#;
	L _ T.Tminus -> cont 25#;
	L _ T.Tstar -> cont 26#;
	L _ T.Tdiv -> cont 27#;
	L _ T.Tmod -> cont 28#;
	L _ T.Tnot -> cont 29#;
	L _ T.Tand -> cont 30#;
	L _ T.Tor -> cont 31#;
	L _ T.Txor -> cont 32#;
	L _ T.Tlsh -> cont 33#;
	L _ T.Trsh -> cont 34#;
	L _ T.Tinc -> cont 35#;
	L _ T.Tdec -> cont 36#;
	L _ T.Tlnot -> cont 37#;
	L _ T.Tland -> cont 38#;
	L _ T.Tlor -> cont 39#;
	L _ T.Teq -> cont 40#;
	L _ T.Tne -> cont 41#;
	L _ T.Tlt -> cont 42#;
	L _ T.Tgt -> cont 43#;
	L _ T.Tle -> cont 44#;
	L _ T.Tge -> cont 45#;
	L _ T.Tassign -> cont 46#;
	L _ T.Tadd_assign -> cont 47#;
	L _ T.Tsub_assign -> cont 48#;
	L _ T.Tmul_assign -> cont 49#;
	L _ T.Tdiv_assign -> cont 50#;
	L _ T.Tmod_assign -> cont 51#;
	L _ T.Tlsh_assign -> cont 52#;
	L _ T.Trsh_assign -> cont 53#;
	L _ T.Tand_assign -> cont 54#;
	L _ T.Tor_assign -> cont 55#;
	L _ T.Txor_assign -> cont 56#;
	L _ T.Tauto -> cont 57#;
	L _ T.Tbreak -> cont 58#;
	L _ T.Tcase -> cont 59#;
	L _ T.Tchar -> cont 60#;
	L _ T.Tconst -> cont 61#;
	L _ T.Tcontinue -> cont 62#;
	L _ T.Tdefault -> cont 63#;
	L _ T.Tdo -> cont 64#;
	L _ T.Tdouble -> cont 65#;
	L _ T.Telse -> cont 66#;
	L _ T.Tenum -> cont 67#;
	L _ T.Textern -> cont 68#;
	L _ T.Tfloat -> cont 69#;
	L _ T.Tfor -> cont 70#;
	L _ T.Tgoto -> cont 71#;
	L _ T.Tif -> cont 72#;
	L _ T.Tinline -> cont 73#;
	L _ T.Tint -> cont 74#;
	L _ T.Tlong -> cont 75#;
	L _ T.Tregister -> cont 76#;
	L _ T.Trestrict -> cont 77#;
	L _ T.Treturn -> cont 78#;
	L _ T.Tshort -> cont 79#;
	L _ T.Tsigned -> cont 80#;
	L _ T.Tsizeof -> cont 81#;
	L _ T.Tstatic -> cont 82#;
	L _ T.Tstruct -> cont 83#;
	L _ T.Tswitch -> cont 84#;
	L _ T.Ttypedef -> cont 85#;
	L _ T.Tunion -> cont 86#;
	L _ T.Tunsigned -> cont 87#;
	L _ T.Tvoid -> cont 88#;
	L _ T.Tvolatile -> cont 89#;
	L _ T.Twhile -> cont 90#;
	L _ T.TBool -> cont 91#;
	L _ T.TComplex -> cont 92#;
	L _ T.TImaginary -> cont 93#;
	L _ T.Tasm -> cont 94#;
	L _ T.Tattribute -> cont 95#;
	L _ T.Textension -> cont 96#;
	L _ T.Tbuiltin_va_arg -> cont 97#;
	L _ T.Tbuiltin_va_list -> cont 98#;
	L _ T.Ttypeof -> cont 99#;
	L _ T.T3lt -> cont 100#;
	L _ T.T3gt -> cont 101#;
	L _ T.Tdevice -> cont 102#;
	L _ T.Tglobal -> cont 103#;
	L _ T.Thost -> cont 104#;
	L _ T.Tconstant -> cont 105#;
	L _ T.Tshared -> cont 106#;
	L _ T.Tnoinline -> cont 107#;
	L _ T.Ttypename -> cont 108#;
	L _ (T.Tanti_id _) -> cont 109#;
	L _ (T.Tanti_int _) -> cont 110#;
	L _ (T.Tanti_uint _) -> cont 111#;
	L _ (T.Tanti_lint _) -> cont 112#;
	L _ (T.Tanti_ulint _) -> cont 113#;
	L _ (T.Tanti_float _) -> cont 114#;
	L _ (T.Tanti_double _) -> cont 115#;
	L _ (T.Tanti_long_double _) -> cont 116#;
	L _ (T.Tanti_char _) -> cont 117#;
	L _ (T.Tanti_string _) -> cont 118#;
	L _ (T.Tanti_exp _) -> cont 119#;
	L _ (T.Tanti_func _) -> cont 120#;
	L _ (T.Tanti_args _) -> cont 121#;
	L _ (T.Tanti_decl _) -> cont 122#;
	L _ (T.Tanti_decls _) -> cont 123#;
	L _ (T.Tanti_sdecl _) -> cont 124#;
	L _ (T.Tanti_sdecls _) -> cont 125#;
	L _ (T.Tanti_enum _) -> cont 126#;
	L _ (T.Tanti_enums _) -> cont 127#;
	L _ (T.Tanti_esc _) -> cont 128#;
	L _ (T.Tanti_edecl _) -> cont 129#;
	L _ (T.Tanti_edecls _) -> cont 130#;
	L _ (T.Tanti_item _) -> cont 131#;
	L _ (T.Tanti_items _) -> cont 132#;
	L _ (T.Tanti_stm _) -> cont 133#;
	L _ (T.Tanti_stms _) -> cont 134#;
	L _ (T.Tanti_spec _) -> cont 135#;
	L _ (T.Tanti_type _) -> cont 136#;
	L _ (T.Tanti_param _) -> cont 137#;
	L _ (T.Tanti_params _) -> cont 138#;
	_ -> happyError' tk
	})

happyError_ tk = happyError' tk

happyThen :: () => P a -> (a -> P b) -> P b
happyThen = (>>=)
happyReturn :: () => a -> P a
happyReturn = (return)
happyThen1 = happyThen
happyReturn1 :: () => a -> P a
happyReturn1 = happyReturn
happyError' :: () => ((L T.Token)) -> P a
happyError' tk = happyError tk

parseExp = happySomeParser where
  happySomeParser = happyThen (happyParse 0#) (\x -> happyReturn (happyOut36 x))

parseEdecl = happySomeParser where
  happySomeParser = happyThen (happyParse 1#) (\x -> happyReturn (happyOut102 x))

parseDecl = happySomeParser where
  happySomeParser = happyThen (happyParse 2#) (\x -> happyReturn (happyOut39 x))

parseStructDecl = happySomeParser where
  happySomeParser = happyThen (happyParse 3#) (\x -> happyReturn (happyOut54 x))

parseEnum = happySomeParser where
  happySomeParser = happyThen (happyParse 4#) (\x -> happyReturn (happyOut61 x))

parseType = happySomeParser where
  happySomeParser = happyThen (happyParse 5#) (\x -> happyReturn (happyOut77 x))

parseParam = happySomeParser where
  happySomeParser = happyThen (happyParse 6#) (\x -> happyReturn (happyOut76 x))

parseInit = happySomeParser where
  happySomeParser = happyThen (happyParse 7#) (\x -> happyReturn (happyOut83 x))

parseStm = happySomeParser where
  happySomeParser = happyThen (happyParse 8#) (\x -> happyReturn (happyOut88 x))

parseUnit = happySomeParser where
  happySomeParser = happyThen (happyParse 9#) (\x -> happyReturn (happyOut100 x))

parseFunc = happySomeParser where
  happySomeParser = happyThen (happyParse 10#) (\x -> happyReturn (happyOut103 x))

happySeq = happyDontSeq


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
lexer cont = do
    tok <- lexToken
    cont tok

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
isTypeQual (TSconst _)     = True
isTypeQual (TSvolatile _)  = True
isTypeQual (TSinline _)    = True
isTypeQual (TSrestrict _)  = True
isTypeQual (TSdevice _)    = True
isTypeQual (TSglobal _)    = True
isTypeQual (TShost _)      = True
isTypeQual (TSconstant _)  = True
isTypeQual (TSshared _)    = True
isTypeQual (TSnoinline _)  = True
isTypeQual _               = False

mkTypeQuals :: [TySpec] -> [TypeQual]
mkTypeQuals specs = map mk (filter isTypeQual specs)
    where
      mk :: TySpec -> TypeQual
      mk (TSconst loc)     = Tconst loc
      mk (TSvolatile loc)  = Tvolatile loc
      mk (TSinline loc)    = Tinline loc
      mk (TSrestrict loc)  = Trestrict loc
      mk (TSdevice loc)    = Tdevice loc
      mk (TSglobal loc)    = Tglobal loc
      mk (TShost loc)      = Thost loc
      mk (TSconstant loc)  = Tconstant loc
      mk (TSshared loc)    = Tshared loc
      mk (TSnoinline loc)  = Tnoinline loc
      mk _                 = error "internal error in mkTypeQual"

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
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 28 "templates/GenericTemplate.hs" #-}


data Happy_IntList = HappyCons Happy_GHC_Exts.Int# Happy_IntList





{-# LINE 49 "templates/GenericTemplate.hs" #-}

{-# LINE 59 "templates/GenericTemplate.hs" #-}

{-# LINE 68 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is 0#, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept 0# tk st sts (_ `HappyStk` ans `HappyStk` _) =
	happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
	(happyTcHack j (happyTcHack st)) (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action



happyDoAction i tk st
	= {- nothing -}


	  case action of
		0#		  -> {- nothing -}
				     happyFail i tk st
		-1# 	  -> {- nothing -}
				     happyAccept i tk st
		n | (n Happy_GHC_Exts.<# (0# :: Happy_GHC_Exts.Int#)) -> {- nothing -}

				     (happyReduceArr Happy_Data_Array.! rule) i tk st
				     where rule = (Happy_GHC_Exts.I# ((Happy_GHC_Exts.negateInt# ((n Happy_GHC_Exts.+# (1# :: Happy_GHC_Exts.Int#))))))
		n		  -> {- nothing -}


				     happyShift new_state i tk st
				     where new_state = (n Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#))
   where off    = indexShortOffAddr happyActOffsets st
	 off_i  = (off Happy_GHC_Exts.+# i)
	 check  = if (off_i Happy_GHC_Exts.>=# (0# :: Happy_GHC_Exts.Int#))
			then (indexShortOffAddr happyCheck off_i Happy_GHC_Exts.==#  i)
			else False
 	 action | check     = indexShortOffAddr happyTable off_i
		| otherwise = indexShortOffAddr happyDefActions st

{-# LINE 127 "templates/GenericTemplate.hs" #-}


indexShortOffAddr (HappyA# arr) off =
#if __GLASGOW_HASKELL__ > 500
	Happy_GHC_Exts.narrow16Int# i
#elif __GLASGOW_HASKELL__ == 500
	Happy_GHC_Exts.intToInt16# i
#else
	Happy_GHC_Exts.iShiftRA# (Happy_GHC_Exts.iShiftL# i 16#) 16#
#endif
  where
#if __GLASGOW_HASKELL__ >= 503
	i = Happy_GHC_Exts.word2Int# (Happy_GHC_Exts.or# (Happy_GHC_Exts.uncheckedShiftL# high 8#) low)
#else
	i = Happy_GHC_Exts.word2Int# (Happy_GHC_Exts.or# (Happy_GHC_Exts.shiftL# high 8#) low)
#endif
	high = Happy_GHC_Exts.int2Word# (Happy_GHC_Exts.ord# (Happy_GHC_Exts.indexCharOffAddr# arr (off' Happy_GHC_Exts.+# 1#)))
	low  = Happy_GHC_Exts.int2Word# (Happy_GHC_Exts.ord# (Happy_GHC_Exts.indexCharOffAddr# arr off'))
	off' = off Happy_GHC_Exts.*# 2#





data HappyAddr = HappyA# Happy_GHC_Exts.Addr#




-----------------------------------------------------------------------------
-- HappyState data type (not arrays)

{-# LINE 170 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state 0# tk st sts stk@(x `HappyStk` _) =
     let i = (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# (i)) -> i }) in
--     trace "shifting the error token" $
     happyDoAction i tk new_state (HappyCons (st) (sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state (HappyCons (st) (sts)) ((happyInTok (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_0 nt fn j tk st@((action)) sts stk
     = happyGoto nt j tk st (HappyCons (st) (sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@((HappyCons (st@(action)) (_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_2 nt fn j tk _ (HappyCons (_) (sts@((HappyCons (st@(action)) (_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_3 nt fn j tk _ (HappyCons (_) ((HappyCons (_) (sts@((HappyCons (st@(action)) (_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) sts of
	 sts1@((HappyCons (st1@(action)) (_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (happyGoto nt j tk st1 sts1 r)

happyMonadReduce k nt fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
        happyThen1 (fn stk tk) (\r -> happyGoto nt j tk st1 sts1 (r `HappyStk` drop_stk))
       where sts1@((HappyCons (st1@(action)) (_))) = happyDrop k (HappyCons (st) (sts))
             drop_stk = happyDropStk k stk

happyMonad2Reduce k nt fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
       happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))
       where sts1@((HappyCons (st1@(action)) (_))) = happyDrop k (HappyCons (st) (sts))
             drop_stk = happyDropStk k stk

             off    = indexShortOffAddr happyGotoOffsets st1
             off_i  = (off Happy_GHC_Exts.+# nt)
             new_state = indexShortOffAddr happyTable off_i




happyDrop 0# l = l
happyDrop n (HappyCons (_) (t)) = happyDrop (n Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) t

happyDropStk 0# l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Happy_GHC_Exts.-# (1#::Happy_GHC_Exts.Int#)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction


happyGoto nt j tk st = 
   {- nothing -}
   happyDoAction j tk new_state
   where off    = indexShortOffAddr happyGotoOffsets st
	 off_i  = (off Happy_GHC_Exts.+# nt)
 	 new_state = indexShortOffAddr happyTable off_i




-----------------------------------------------------------------------------
-- Error recovery (0# is the error token)

-- parse error if we are in recovery and we fail again
happyFail  0# tk old_st _ stk =
--	trace "failing" $ 
    	happyError_ tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  0# tk old_st (HappyCons ((action)) (sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	happyDoAction 0# tk action sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (action) sts stk =
--      trace "entering error recovery" $
	happyDoAction 0# tk action sts ( (Happy_GHC_Exts.unsafeCoerce# (Happy_GHC_Exts.I# (i))) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions


happyTcHack :: Happy_GHC_Exts.Int# -> a -> a
happyTcHack x y = y
{-# INLINE happyTcHack #-}


-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.


{-# NOINLINE happyDoAction #-}
{-# NOINLINE happyTable #-}
{-# NOINLINE happyCheck #-}
{-# NOINLINE happyActOffsets #-}
{-# NOINLINE happyGotoOffsets #-}
{-# NOINLINE happyDefActions #-}

{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
