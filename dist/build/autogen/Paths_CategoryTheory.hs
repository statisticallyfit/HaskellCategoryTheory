module Paths_CategoryTheory (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [1,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/developer/.cabal/bin"
libdir     = "/home/developer/.cabal/lib/x86_64-linux-ghc-7.10.3/CategoryTheory-1.0-9iWbccPtzdx3AKaH2vi4PY"
datadir    = "/home/developer/.cabal/share/x86_64-linux-ghc-7.10.3/CategoryTheory-1.0"
libexecdir = "/home/developer/.cabal/libexec"
sysconfdir = "/home/developer/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "CategoryTheory_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "CategoryTheory_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "CategoryTheory_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "CategoryTheory_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "CategoryTheory_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
