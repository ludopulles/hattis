import Arguments
import Control.Applicative
import Control.Monad.Except
import Error
import GetOpt
import Settings
import System.Environment
import System.Exit
import System.IO

main :: IO ()
main = do argv <- getArgs
          (flagsset, (id:files)) <- parseOptions argv defaults usage flags Version versionstr Help
          putStrLn "derp"
          --the flags list contains all flags set, strs is a list of all non flag arguments

getauth :: OptionList Flag -> KattisApp FilePath
getauth flg = joinIO (settingsExist . getOptionOr Config flg <$> settingsLocation)

joinE :: Monad m => m (ExceptT e m a) -> ExceptT e m a
joinE = ExceptT . join . return . (runExceptT =<<) 

versionstr = "0.0.0"
usage = "Usage: kattis [-fvh] [-c KATTISRC] [-m FILE] [-l LANG] PROBLEMID FILES ...\n"
