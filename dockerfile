######################
##https://github.com/agaveplatform/SC17-container-tutorial/blob/master/06-Containerizing-Existing-Applications.md
##build using:
# docker build -t funwave-tvd:latest .  (if using latest code)
# docker build -t funwave-tvd:3.5 .  (if using latest given release)
#
#   example usage 1: 
#
# **cannot easily change examples test cases
# docker  run -it funwave-tvd:3.5 
# cd /FUNWAVE-TVD-Version_3.5/simple_cases/rip_2d/work
# compile for the model for that example
# make 
# mpirun -np 4 --allow-run-as-root ./funwave--gnu-parallel-single input.txt
#
#   example usage 2: 
#
# ***mount code from local repo inside docker to be able to change (e.g. nb of cores)
# docker  run -it -v /home/simon/Documents/GitHub/FUNWAVE-TVD/:/model_local/ funwave-tvd:3.5 
# cd ../model_local/cd simple_cases/rip_2d/work
# compile for the model for that example
# make 
# mpirun -np 2 --allow-run-as-root ./funwave--gnu-parallel-single input.txt
#
# ** may need to add 
#export OMPI_MCA_btl_vader_single_copy_mechanism=none 
#
#to get rid of error message : "Read -1, expected 256000, errno = 1"
#######################

FROM ubuntu:16.04

MAINTAINER Rion Dooley <dooley@tacc.utexas.edu>

# add build tools and python to the sandbox
RUN apt-get update
RUN apt-get install -y --allow-unauthenticated build-essential findutils python3 python3-pip wget make git patch flex gfortran unzip && \
    cd /home && \
    wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.3.tar.gz && \
    tar xzvf openmpi-4.0.3.tar.gz

# add openmpi 2.1.1
RUN cd /home/openmpi-4.0.3 && \
    ./configure

RUN cd /home/openmpi-4.0.3 && \
    make -j 5 install

ENV LD_LIBRARY_PATH /usr/local/lib

WORKDIR /model

# add application funwave-tvd code & compile the model
#
# Option 1 : use a released version (may need to edit number)
#
# to download a given release instead..something along these lines :
# see here https://hub.docker.com/r/lsucrc/funwave-tvd/dockerfile/

RUN wget --secure-protocol=auto https://github.com/fengyanshi/FUNWAVE-TVD/archive/Version_3.5.zip && \
    unzip Version_3.5.zip && \
    cd FUNWAVE-TVD-Version_3.5 && \
    perl -p -i -e 's/FLAG_8 = -DCOUPLING/#$&/' Makefile && \
    make

# Option 2 : cloning the "dev" version
# 
#RUN cd /model && \
#    git clone https://github.com/fengyanshi/FUNWAVE-TVD && \
#    cd FUNWAVE-TVD/ && \
#    perl -p -i -e 's/FLAG_8 = -DCOUPLING/#$&/' Makefile && \
#    make



