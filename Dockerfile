FROM centos:6

RUN yum -y update
RUN yum -y install \
  perl perl-core \
  wget
RUN wget -O - https://cpanmin.us | perl - App::cpanminus

RUN cpanm --install-deps .

