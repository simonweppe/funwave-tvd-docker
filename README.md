# funwave-tvd-docker
Dockerfile for **funwave-tvd** model 
- https://github.com/fengyanshi/FUNWAVE-TVD/
- https://fengyanshi.github.io 

*using examples from :*
- https://hub.docker.com/r/lsucrc/funwave-tvd/dockerfile/
- https://hub.docker.com/r/lsucrc/crcbase/dockerfile/
- https://github.com/agaveplatform/SC17-container-tutorial/blob/master/06-Containerizing-Existing-Applications.md#docker-build


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
# cd ../model_local/FUNWAVE-TVD-Version_3.5/simple_cases/rip_2d/work
# compile for the model for that example
# make 
# mpirun -np 2 --allow-run-as-root ./funwave--gnu-parallel-single input.txt
#######################