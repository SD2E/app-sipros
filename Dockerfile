FROM sd2e/base:centos7

RUN yum -y update \
    && yum -y groupinstall "Development Tools" \
    && yum -y install glibc-static \
    && yum -y install libstdc++-static

RUN yum -y install epel-release \
    && yum -y update \
    && yum -y install python-pip \
    && pip install numpy==1.11.2 \
    && pip install scipy==0.13.3 \
    && pip install scikit-learn==0.17.1

RUN curl -LO https://github.com/guo-xuan/Sipros-Ensemble/archive/v1.3.tar.gz \
    && tar -xzf v1.3.tar.gz \
    && cd Sipros-Ensemble-1.3 \
    && make openmp

ENV PATH="/Sipros-Ensemble-1.3/bin:${PATH}"

