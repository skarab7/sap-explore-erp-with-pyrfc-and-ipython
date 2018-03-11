FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install git python3-pip -qq && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install -U pip && \
    pip3 install ipython

RUN cd /tmp && \
    git clone https://github.com/SAP/PyRFC.git;

RUN cd /tmp/PyRFC/dist && \
	pip3 install pyrfc-1.9.5-cp35-cp35m-linux_x86_64.whl

RUN echo "tput setaf 1;\necho '===\nBefore: iphython\nRun: ldconfig\n==='\ntput sgr0" > /root/.bashrc


#
# mount *nwrfcsdk* as volume under /usr/sap/nwrfcsdk
#
RUN mkdir -p /etc/ld.so.conf.d/ && \
	mkdir -p /usr/sap/ && \
	echo "# include nwrfcsdk" > /etc/ld.so.conf.d/nwrfcsdk.conf && \
	echo "/usr/sap/nwrfcsdk/lib" >> /etc/ld.so.conf.d/nwrfcsdk.conf
