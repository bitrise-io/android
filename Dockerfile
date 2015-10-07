FROM ubuntu:14.04

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git mercurial curl rsync ruby sudo

ENV CI true

#
# Install Bitrise CLI
RUN curl -fL https://github.com/bitrise-io/bitrise/releases/download/1.2.1/bitrise-$(uname -s)-$(uname -m) > /usr/local/bin/bitrise
RUN chmod +x /usr/local/bin/bitrise
RUN bitrise setup --minimal

RUN mkdir -p /bitrise
WORKDIR /bitrise

CMD ls -alh
