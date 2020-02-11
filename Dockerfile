FROM debian:latest

ARG SBCL_VERSION

ENV HOME /root

COPY ./install.lisp $HOME

RUN apt-get update && apt-get install -y make bzip2 wget git build-essential libuv1-dev


RUN echo "Hi23" ${VERSION}

# Install sbcl
RUN wget "http://prdownloads.sourceforge.net/sbcl/sbcl-${SBCL_VERSION}-x86-64-linux-binary.tar.bz2" \
         -O /tmp/sbcl.tar.bz2 && \
    mkdir /tmp/sbcl && \
    tar jxvf /tmp/sbcl.tar.bz2 --strip-components=1 -C /tmp/sbcl && \
    cd /tmp/sbcl && \
    ls -la && \    
    sh install.sh && \
    cd /tmp \
    rm -rf /tmp/sbcl 

# Install deps
RUN mkdir common-lisp
WORKDIR $HOME/common-lisp

# Install quicklisp
WORKDIR $HOME
RUN wget https://beta.quicklisp.org/quicklisp.lisp && \
    sbcl --load install.lisp --non-interactive

