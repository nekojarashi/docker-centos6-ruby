FROM ac3agrtp/centos6-glusterfs:3.12
LABEL maintainer="y-okubo"

ENV CONFIGURE_OPTS --disable-install-doc

ADD ./mongodb-org-4.0.repo /etc/yum.repos.d/mongodb-org-4.0.repo
ADD http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro /rpm/
ADD http://li.nux.ro/download/nux/dextop/el6/x86_64/nux-dextop-release-0-2.el6.nux.noarch.rpm /rpm/
ADD http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm /rpm/
ADD http://rpms.famillecollet.com/enterprise/remi-release-6.rpm /rpm/
ADD https://github.com/feedforce/ruby-rpm/releases/download/2.3.3/ruby-2.3.3-1.el6.x86_64.rpm /rpm/

RUN rpm --import /rpm/RPM-GPG-KEY-nux.ro \
 && rpm -Uvh /rpm/nux-dextop-release-0-2.el6.nux.noarch.rpm \
 && yum install -y /rpm/mysql-community-release-el6-5.noarch.rpm \
 && yum install -y epel-release \
 && yum install -y \
 cups \
 dtach \
 ffmpeg-devel \
 ffmpeg \
 git \
 hash-slinger \
 httpd-devel \
 libcurl-devel \
 libexif-devel \
 libexif \
 libffi-devel \
 libfontconfig.so.1 \
 libfreetype.so.6 \
 libsndfile-devel \
 libsndfile \
 libstdc++.so.6 \
 libxslt-devel \
 libyaml-devel \
 mongodb-org \
 mysql-community-client \
 mysql-community-devel \
 mysql-utilities \
 npm \
 perl-Image-ExifTool \
 readline-devel \
 redis \
 sqlite-devel \
 sudo \
 wget \
 # Install ImageMagick
 && rpm -Uvh /rpm/remi-release-6.rpm \
 && yum -y install --enablerepo=remi \
 ImageMagick6 \
 ImageMagick6-devel \
 # Install Ruby
 && yum install -y /rpm/ruby-2.3.3-1.el6.x86_64.rpm \
 && /usr/bin/gem install bundler foreman mailcatcher \
 # Clean
 && rm -rf /rpm \
 && rm -rf /var/cache/yum/* \
 && yum clean all