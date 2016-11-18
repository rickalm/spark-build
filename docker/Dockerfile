#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Create snapshot builds with:
# docker build -t spark:git-`git rev-parse --short HEAD` .

# Basing from Mesos image so the Mesos native library is present.
#FROM mesosphere/mesos-modules-private:git-e348e3f
FROM mesosphere/mesos:0.25.0-0.2.70.ubuntu1404
MAINTAINER Michael Gummelt <mgummelt@mesosphere.io>

# Set environment variables.
ENV \
  HADOOP_CONF_DIR=/etc/hadoop \
  DEBIAN_FRONTEND=noninteractive \
  DEBCONF_NONINTERACTIVE_SEEN=true \
  JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
  MESOS_NATIVE_JAVA_LIBRARY=/usr/local/lib/libmesos.so

WORKDIR /opt/spark/dist

# Upgrade package index and install basic commands.
RUN \
  apt-get update \
    || exit 1; \
  apt-get install -y software-properties-common \
    || exit 1; \
  add-apt-repository ppa:openjdk-r/ppa \
    || exit 1; \
  apt-get update \
    || exit 1; \
  apt-get install -y runit nginx openjdk-8-jdk curl \
    || exit 1; \
  apt-get clean -y \
    || exit 1; \
  mkdir /etc/hadoop \
    || exit 1; \
  true

ADD dist /opt/spark/dist
ADD hadoop/* /etc/hadoop/
ADD runit/service /var/lib/runit/service
ADD runit/init.sh /sbin/init.sh
ADD nginx /etc/nginx

#RUN ln -sf /usr/lib/libmesos.so /usr/lib/libmesos-0.23.1.so

# The following symlinks are hacks to make spark-class work under the
# restricted PATH (/usr/bin) set by the DCOS
# --executor-environment-variables option
RUN \
  ln -s /bin/bash /usr/bin/bash \
    || exit 1; \
  ln -s /bin/ls /usr/bin/ls \
    || exit 1; \
  ln -s /bin/grep /usr/bin/grep \
    || exit 1; \
  ln -s /var/lib/runit/service/spark /etc/service/spark \
    || exit 1; \
  ln -s /var/lib/runit/service/nginx /etc/service/nginx \
    || exit 1; \
  true
