rm *.exe
mpif90 -o snr.exe send_receive.f90
mpirun -n 2 ./snr.exe