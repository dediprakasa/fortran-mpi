program send_receive

    use mpi
    implicit none

    integer :: ierr, rank, nprocs
    integer, dimension(MPI_STATUS_SIZE) :: status1
    character*(MPI_MAX_PROCESSOR_NAME) :: hostname
    integer :: namesize
    integer :: data0 = 1, data1 = 0


    call MPI_INIT(ierr)
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nprocs, ierr)
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr)
    call MPI_GET_PROCESSOR_NAME(hostname, namesize, ierr)

    print*, "Host name ", hostname(1:namesize), " with rank ", rank, " of ", nprocs, " process(es)"

    ! Invoke master process
    if (rank == 0) then
        data0 = 50
        print*, "Rank ", rank, "Data 0 = ", data0
        
        ! Send data to Rank 1
        ! Syntax: call MPI_SEND(start_address, count, datatype, destination rank, tag, communicator, ierr)
        call MPI_SEND(data0, 1, MPI_INT, 1, 1, MPI_COMM_WORLD, ierr)
        print*, "Rank ", rank, "Sent data0 to rank 1"

        ! Receive data1 from rank 1
        call MPI_RECV(data0, 1, MPI_INT, 1, 2, MPI_COMM_WORLD, status1, ierr)
        print*, "Rank ", rank, "Received data1 from rank 1 as data0, data0 = ", data0
        
    end if  

    ! Invoke slave process (rank = 1)
    if (rank == 1) then
        ! Receive data0 from rank 0
        ! Syntax: call MPI_RECV(start_address, count, datatype, source rank, tag, communicator, status, ierr)
        call MPI_RECV(data1, 1, MPI_INT, 0, 1, MPI_COMM_WORLD, status1, ierr)
        print*, "Rank ", rank, "Received data0 from rank 0 as data1. data1 = ", data1

        ! Assign a new data value
        data1 = 100
        print*, "Rank ", rank, "Modified data1. The new value of data1 = ", data1

        ! Send data to rank 0
        call MPI_SEND(data1, 1, MPI_INT, 0, 2, MPI_COMM_WORLD, ierr)
        print*, "Rank ", rank, "Sent data1 to rank 0"

    end if

    call MPI_FINALIZE(ierr)

end program send_receive
