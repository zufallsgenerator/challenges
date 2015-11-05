import Control.Arrow
import qualified Crypto.Hash.SHA1 as SHA1
import qualified Data.ByteString.Base16 as Base16
import qualified Data.ByteString.Char8 as Char8
import Data.List (find)
import Text.Printf (printf)

-- Format my email with variable part
fmtEmail :: String -> String
fmtEmail i = "example+" ++ i ++ "@example.com"

-- Enumerated email generator
emails :: [(Integer, String)]
emails = map (id &&& fmtEmail . show) [0..]

-- Enumerated email and hash generator
hashes :: [(Integer, (String, Char8.ByteString))]
hashes = map (id *** (id &&& SHA1.hash . Char8.pack)) emails

-- Coffee bytes
coffee :: Char8.ByteString
coffee = fst $ Base16.decode $ Char8.pack "c0ffee"

isCoffee :: Char8.ByteString -> Bool
isCoffee = Char8.isPrefixOf coffee

-- Display final result
display :: (Integer, (String, Char8.ByteString)) -> IO ()
display (i, (email, hash)) =
  let hex = Char8.unpack $ Base16.encode hash
  in printf "Found %s with hash %s after %d tries\n" email hex i

main :: IO ()
main = case find (isCoffee . snd . snd) hashes of
  Just match -> display match
  Nothing -> putStrLn "Congratulations, you just reach the end of infinity"
