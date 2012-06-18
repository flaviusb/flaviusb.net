{-# Language TemplateHaskell, QuasiQuotes, FlexibleContexts, DeriveDataTypeable #-}

module IokeGrammar
(ioke, Ioke(..)) where
import Data.Data
import Data.Typeable
import qualified Data.Map as Map
import qualified Data.List as List
import Text.Peggy 
import Data.Maybe

data Ioke = Cell Name Message | Symbol Name | Dict [DictElem] | IList [IListElem] | Comment String | LiteralString LitS | QuotedMessage | QuasiQuotedMessage | UnQuotedMessage | Ret | Fullstop | ISpace Int | BangLine String | MethodComment String | Key String  deriving (Show, Data, Eq, Typeable)

data DictElem = KV String String | Hash String String | DictMessage Message deriving (Show, Data, Eq, Typeable)

data IListElem = IListElem Message deriving (Show, Data, Eq, Typeable)

data Message = Message Name [MessageLine] deriving (Show, Data, Eq, Typeable)

data MessageLine = [Message] deriving (Show, Data, Eq, Typeable)

data LitS = SquareString [Chunk] | QuotedString [Chunk] deriving (Show, Data, Eq, Typeable)

data Chunk = Lit String | Escape String | Interpolate Message deriving (Show, Data, Eq, Typeable)

data Name = String deriving (Show, Data, Eq, Typeable)

[peggy|
ioke :: [Ioke]
  = (ret / dot / comment / hashbang / ispace)*

ret :: Ioke
  = [\r\n] { Ret }

dot :: Ioke
  = '.'    { Fullstop }

comment :: Ioke
  = (';' [^\n\r]+) { Comment (";" ++ $1) }

hashbang :: Ioke
  = ('#!/' [^\n\r]+) { BangLine ("#!/" ++ $1) }

ispace :: Ioke
  = [ ]+ { ISpace (length $1) }

|]
