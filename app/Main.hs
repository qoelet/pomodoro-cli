{-# LANGUAGE RecordWildCards #-}

module Main where

import           Control.Monad (when)
import           Data.Coerce (coerce)
import           Data.Maybe (fromMaybe, fromJust, isJust)
import           System.Exit (exitSuccess)
import           System.Posix.Unistd (sleep)
import           System.Process (callCommand)
import           WithCli (withCli)

import           Pomodoro

main :: IO ()
main = withCli run

run :: Int -> Int -> Maybe Int -> Maybe FilePath -> IO ()
run w r c alarm = do
  let cycle = fromMaybe Forever (Cycle <$> c)
      pomodoro = mkPomodoro (WorkDuration w) (RestDuration r) cycle
  iterateM (\p -> case state p of
    Halt -> putStrLn "Completed" >> exitSuccess
    _ -> printAndSleep p alarm >> return (runPomodoro p)) pomodoro

iterateM ::Monad m => (a -> m a) -> a -> m b
iterateM f a = f a >>= iterateM f

printAndSleep :: Pomodoro -> Maybe FilePath -> IO ()
printAndSleep Pomodoro{..} alarm
  | state == Work = go state (coerce workDuration)
  | otherwise = do
      go state (coerce restDuration)
      when (isJust alarm) (callCommand ("mpg123 -q " ++ fromJust alarm))
  where
    go state duration
      = print state >> sleep duration >> return ()
