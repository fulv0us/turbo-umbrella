FROM ubuntu:20.04

RUN apt update && apt install -y \
    gnupg locales wget iptables python3

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A \
    && echo "deb http://repo.pritunl.com/stable/apt focal main" | tee /etc/apt/sources.list.d/pritunl.list

RUN apt update && apt install -y pritunl

COPY pritunl.conf /etc/pritunl.conf

USER root

CMD [ "pritunl" ]