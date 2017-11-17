#!/bin/sh

#  run_tests.sh
#  Configurate
#
#  Created by Patrick Goley on 11/15/17.
#  

OS=""

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then 
  OS="linux"
else
  OS="${2}"
fi

if [[ "$OS" == "linux" ]]; then
    docker build . --tag configurate
else
    xcodebuild test -project Configurate.xcodeproj -scheme Configurate-Package ONLY_ACTIVE_ARCH=NO GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES
    curl -s https://codecov.io/bash | bash
fi
