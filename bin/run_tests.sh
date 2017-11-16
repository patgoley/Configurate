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
    xcodebuild test -project Configurate.xcodeproj -scheme Configurate-Package ONLY_ACTIVE_ARCH=NO GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES
    bash <(curl -s https://codecov.io/bash)
fi
