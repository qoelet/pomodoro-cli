module Pomodoro where

data PState
  = Work
  | Rest
  | Halt
  deriving (Eq, Show)

data PCycle
  = Cycle Int
  | Forever
  deriving (Eq, Show)

newtype WorkDuration = WorkDuration Int
  deriving (Eq, Show)

newtype RestDuration = RestDuration Int
  deriving (Eq, Show)

data Pomodoro = Pomodoro {
  state :: PState
, cycle :: PCycle
, workDuration :: WorkDuration
, restDuration :: RestDuration
} deriving (Eq, Show)

mkPomodoro :: WorkDuration -> RestDuration -> PCycle -> Pomodoro
mkPomodoro work rest cycle = Pomodoro Work cycle work rest

unMkWorkDuration :: WorkDuration -> Int
unMkWorkDuration (WorkDuration n) = n

unMkRestDuration :: RestDuration -> Int
unMkRestDuration (RestDuration n) = n

runPomodoro :: Pomodoro -> Pomodoro
runPomodoro (Pomodoro Work (Cycle n) w r ) = Pomodoro Rest (Cycle n) w r
runPomodoro (Pomodoro Rest c@(Cycle n) w r )
  | n > 1 = Pomodoro Work (Cycle $ n - 1) w r
  | otherwise = Pomodoro Halt c w r
runPomodoro (Pomodoro x Forever w r)
  | x == Work = Pomodoro Rest Forever w r
  | otherwise = Pomodoro Work Forever w r
