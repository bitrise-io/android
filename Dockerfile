FROM bitriseio/docker-bitrise-base:latest


# # Install java7
RUN apt-get install -y software-properties-common && add-apt-repository -y ppa:webupd8team/java && apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer

# # Install Deps
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --force-yes expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 python curl
#
# # Install Android SDK
RUN cd /opt && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r24.3.3-linux.tgz && tar xzf android-sdk.tgz && rm -f android-sdk.tgz && chown -R root.root android-sdk-linux

# WORKDIR     /opt/
RUN apt-get update
RUN apt-get -f install
RUN apt-get install wget
RUN apt-get install unzip

RUN         wget http://dl.google.com/android/android-sdk_r24.3.4-linux.tgz
RUN         tar -xvf android-sdk_r24.3.4-linux.tgz
RUN         mv android-sdk-linux /opt/android-sdk && \
            rm android-sdk_r24.3.4-linux.tgz

ENV         ANDROID_HOME /opt/android-sdk
ENV         PATH $PATH:$ANDROID_HOME/tools
ENV         PATH $PATH:$ANDROID_HOME/platform-tools
COPY tools /opt/tools
ENV PATH ${PATH}:/opt/tools

RUN ["/opt/tools/android-accept-licenses.sh", "android update sdk --all --no-ui --filter platform-tools,tools,build-tools-21,build-tools-21.0.1,build-tools-21.0.2,build-tools-21.1,build-tools-21.1.1,build-tools-21.1.2,build-tools-22,build-tools-22.0.1,android-21,android-22,addon-google_apis_x86-google-21,extra-android-support,extra-android-m2repository,extra-google-m2repository,extra-google-google_play_services,sys-img-armeabi-v7a-android-21"]

RUN sudo add-apt-repository ppa:cwchien/gradle
RUN sudo apt-get update
# answer licence accept prompt with yes
RUN sudo apt-get -y install gradle

RUN gradle -v
# RUN mkdir -p /bitrise

RUN apt-get -y install golang

COPY ./bitrise /bitrise
WORKDIR /bitrise

CMD ls -alh
