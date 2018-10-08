program hello_world_mpi

    use mpi
    implicit none
    integer :: ierr, rank, nprocs

    ! Initialize MPI
    call MPI_INIT(ierr)

    ! Communicator size
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nprocs, ierr)

    ! Ranks/IDs for each process
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr)

    print*, "Hello world! Process ", rank, "of ", nprocs, "process(es)"

    ! Finalize MPI

end program hello_world_mpi