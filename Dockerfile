FROM debian:buster AS base

LABEL maintainer "Mrpandat https://github.com/mrpandat"

# Install RabbitMQ

RUN apt update -y && \
    apt-get install curl gnupg debian-keyring debian-archive-keyring apt-transport-https software-properties-common -y && \
    tee /etc/apt/sources.list.d/rabbitmq.list <<EOF

## Team RabbitMQ's main signing key
RUN apt-key adv --keyserver "hkps://keys.openpgp.org" --recv-keys "0x0A9AF2115F4687BD29803A206B73A36E6026DFCA" && \
    apt-key adv --keyserver "keyserver.ubuntu.com" --recv-keys "F77F1EDA57EBB1CC"  && \
    apt-key adv --keyserver "keyserver.ubuntu.com" --recv-keys "F6609E60DC62814E" && \
    add-apt-repository 'deb http://ppa.launchpad.net/rabbitmq/rabbitmq-erlang/ubuntu/ bionic main' && \
    add-apt-repository 'deb https://packagecloud.io/rabbitmq/rabbitmq-server/ubuntu/ bionic main'

## Install Erlang packages
RUN apt-get update -y && \
    apt-get install -y libssl1.1 erlang-base \
        erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
        erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
        erlang-runtime-tools erlang-snmp erlang-ssl \
        erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl

## Install rabbitmq-server and its dependencies
RUN apt-get install rabbitmq-server -y --fix-missing && \
    rabbitmq-plugins enable rabbitmq_management