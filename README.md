# funwave-tvd-docker
Dockerfile for **funwave-tvd** model 
- https://github.com/fengyanshi/FUNWAVE-TVD/
- https://fengyanshi.github.io 

*using docker examples from :*
- https://hub.docker.com/r/lsucrc/funwave-tvd/dockerfile/
- https://hub.docker.com/r/lsucrc/crcbase/dockerfile/
- https://github.com/agaveplatform/SC17-container-tutorial/blob/master/06-Containerizing-Existing-Applications.md#docker-build

######################
 Build using:

`docker build -t funwave-tvd:latest .`  (if using latest code)
`docker build -t funwave-tvd:3.6 .`   (if using latest given release)

Run example (option 1) 
`docker  run -it funwave-tvd:3.6` 
`cd /FUNWAVE-TVD-Version_3.6/simple_cases/rip_2d/work
compile for the model for that example
`make` 
`mpirun -np 4 --allow-run-as-root ./funwave--gnu-parallel-single input.txt`


Run example (option 2 )
Here mount your local FUNWAVE repo inside docker to be able to change details of the examples (e.g. nb of cores)
`docker  run -it -v /home/simon/Documents/GitHub/FUNWAVE-TVD/:/model_local/ funwave-tvd:3.6` 
`cd ../model_local/FUNWAVE-TVD-Version_3.5/simple_cases/rip_2d/work`
compile for the model for that example
`make` 
`mpirun -np 2 --allow-run-as-root ./funwave--gnu-parallel-single input.txt`


#######################
See instructions for compiling and running here : 
https://fengyanshi.github.io/build/html/setup.html
and more specifically here :
https://fengyanshi.github.io/build/html/make_and_cml_input.html

The main starting point is to use a Makefile (copied from GNUMake or use one from example)

```
#-----------BEGIN MAKEFILE---------------------------
FUNWAVE_DIR = ../../..
FUNWAVE_DIR = /model/FUNWAVE-TVD-Version_3.5/ # may need to edit this 
WORK_DIR    = .
COMPILER    = gnu  # or ifort // use gnu or ifort compile
PARALLEL    = true # true if model is to be run on multi cores / false is single core ** w
EXEC        = funwave 
PRECISION   = single # or double
...
```

Running `make` will create an executable whose name depends on compilation options (parallel or sequential):
Make sure to run `make clean` if you modify and re-run the make

To run with MPI 		: `mpirun -np 4 --allow-run-as-root ./funwave--gnu-parallel-single input.txt `
To run on single core 	: `./funwave--gnu-sequential-single input.txt`

**Notes

- may need to add `export OMPI_MCA_btl_vader_single_copy_mechanism=none` to get rid of error message : `"Read -1, expected 256000, errno = 1"`
- add `--allow-run-as-root` when running `mpirun -np 9 --allow-run-as-root ./funwave--gnu-parallel-single input.txt`
- may need to set permission of outputs files to chmod 777 *



