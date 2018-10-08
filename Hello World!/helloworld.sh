rm *.exe

mpif90 -o helloworld.exe helloworld.f90
mpirun -n 2 ./helloworld.exe