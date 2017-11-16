#!/bin/bash

#  run_tests.sh
#  Configurate
#
#  Created by Patrick Goley on 11/15/17.
#  

set -ev

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    sh docker_linux_test.sh
else
    xctool -project Configurate.xcodeproj -scheme Configurate build test -sdk iphonesimulator GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES
    bash <(curl -s https://codecov.io/bash)
fi
