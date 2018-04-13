# pomodoro-cli

A simple Pomodoro CLI.

```shell
# run 25-5 mins work-rest forever
$ ./pomodoro-cli 1200 300
Work
Rest
...

# run 25-5 mins work-rest cycle 5x
$ ./pomodoro-cli 1200 300 5
Work
Rest
...
Completed

# sound an alarm after each work-rest via mpg123
$ ./pomodoro-cli 1200 300 5 clock.mp3
Work
Rest
# audio file given played
...
```

In a nutshell: `pomodoro-cli <work in secs> <rest in secs> <number of cycles, optional> <mp3 file to play, optional>`

Inspired by [mehdidc/pomodoro](https://github.com/mehdidc/pomodoro).
