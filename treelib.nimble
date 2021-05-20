# Package

version       = "0.1.0"
author        = "Zrean Tofiq"
description   = "A simple tree library"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.4.6"
requires "questionable >= 0.8.0 & < 1.0.0"
requires "result"

task test, "Runs the test suite":
  exec "testament all"