import Data.List (find)
import qualified Data.ByteString.Char8 as Char8
import qualified Data.ByteString.Base16 as Base16
import qualified Crypto.Hash.SHA1 as SHA1
import Text.Printf (printf)

-- Format an email given a prefix, suffix, and variable part
fmtEmail prefix suffix i = prefix ++ i ++ suffix

-- Generate a list of all possible integers
bruteIntegers = [0..]

-- Casted as strings
bruteIntegerStrings = map show bruteIntegers

-- Formatted as emails
bruteEmails prefix suffix =
  map fmt bruteIntegerStrings where
    fmt = fmtEmail prefix suffix

-- Bound to my email pattern
bruteMyEmails = bruteEmails "example+" "@example.com"

-- Coffee bytes
coffee = fst $ Base16.decode $ Char8.pack "c0ffee"

-- Test if given bytes begins with coffee bytes
isCoffee bytes = coffee == Char8.take (Char8.length coffee) bytes

-- Hash a string
sha1 str = SHA1.hash $ Char8.pack str

-- Encoded version
sha1hex str = Char8.unpack $ Base16.encode $ sha1 str

-- Test if given hashed email begins with coffee
isCoffeeStr str = isCoffee $ sha1 str

display :: (Integer, String) -> IO ()
display (i, email) =
  let hash = sha1hex email
  in printf "Found %s with hash %s after %d tries\n" email hash i

main =
  let indexedEmails = zip [0..] bruteMyEmails
      match = find (isCoffeeStr . snd) indexedEmails
  in case match of Just match -> display match
