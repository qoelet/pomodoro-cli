module PomodoroSpec where

import           Test.Hspec

import           Pomodoro

spec :: Spec
spec =
  describe "runPomodoro" $ do
    context "given a forever pomodoro" $
      it "switches between states" $ do
        let w = WorkDuration 5
            r = RestDuration 1
            pW = Pomodoro Work Forever w r
            pR = Pomodoro Rest Forever w r
        runPomodoro pW `shouldBe` pR
        runPomodoro pR `shouldBe` pW
    context "given a k-cycle pomodoro" $
      it "decreases the cycle count" $ do
        let w = WorkDuration 5
            r = RestDuration 1
            pW = Pomodoro Work (Cycle 2) w r
            pR = Pomodoro Rest (Cycle 2) w r
            pW' = Pomodoro Work (Cycle 1) w r
            pR' = Pomodoro Rest (Cycle 1) w r
            p' = Pomodoro Halt (Cycle 1) w r
        runPomodoro pW `shouldBe` pR
        runPomodoro pR `shouldBe` pW'
        runPomodoro pW' `shouldBe` pR'
        runPomodoro pR' `shouldBe` p'
