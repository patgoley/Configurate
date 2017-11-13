FROM ibmcom/swift-ubuntu

WORKDIR /package

COPY . ./

RUN swift package resolve
RUN swift package clean
RUN swift test --parallel
