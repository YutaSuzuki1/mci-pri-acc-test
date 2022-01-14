FROM ubuntu:18.04

RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
  sudo curl wget apt-transport-https gnupg \
  ca-certificates language-pack-ja \
  gcc build-essential git vim 

RUN update-locale LANG=ja_JP.UTF-8

ENV LANG="ja_JP.UTF-8" \ 
    LANGUAGE="ja_JP:ja" \ 
    LC_ALL="ja_JP.UTF-8" \ 
    LC_ALL="ja_JP.UTF-8" \ 
    TZ="JST-9" \ 
    TERM="xterm"

ARG username=hoge
ARG wkdir=/home/work

# echo "username:password" | chpasswd
# root password is "p@ssw0rd"


RUN echo "root:p@ssw0rd" | chpasswd && \
    adduser --disabled-password --gecos "" "${username}" && \
    echo "${username}:${username}" | chpasswd && \
    echo "%${username}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${username} && \
    chmod 0440 /etc/sudoers.d/${username} 
    
WORKDIR ${wkdir}
RUN chown ${username}:${username} ${wkdir}
USER ${username}

CMD ["bash"]