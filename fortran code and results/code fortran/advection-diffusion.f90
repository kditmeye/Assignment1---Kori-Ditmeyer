
!!!      Advectio-Diffusion equation         
!!! Finite difference | Implicit time scheme 

program modeladvdiff

IMPLICIT NONE

!!!!    definition of variables    

integer ::i,mesh_size
double precision :: L,nb_node,nb_step,dx,dt,T,rho_0,rho_L,DD,nu
double precision,dimension(:),allocatable :: rho_new,rho_old
double precision,dimension(:),allocatable :: a,b,c,Bmat
double precision :: d
CHARACTER(*), PARAMETER :: fileplace = "/resultats/"

!!!!    read input data      

open(1,file='inputcoefficients.txt') ! Never put number 6
read(1,*) DD
read(1,*) nu
read(1,*) L
read(1,*) mesh_size
read(1,*) T
read(1,*) rho_0
read(1,*) rho_L

!!! debug use, verifing variable value
print*, 'Diffusion coefficient'
print*, DD
print*, 'mass velocity'
print*, nu
print*, 'length of domain'
print*, L
print*, 'mesh size'
print*, mesh_size
print*, 'simulation time'
print*, T
print*, 'Boundary condition at x=0'
print*, rho_0
print*, 'Boundary condition at x=L'
print*, rho_L

close(1)

!! allocate memory for following variable
allocate(rho_new(mesh_size-1))
allocate(rho_old(mesh_size-1))
allocate(a(mesh_size-1))
allocate(b(mesh_size-1))
allocate(c(mesh_size-1))
allocate(Bmat(mesh_size-1))

!!! time step
dt = 0.01
nb_step = T/dt

!! Initial condition
rho_old = 0

!!! Mesh size
dx = L/mesh_size
nb_node = mesh_size + 1

!!!!    Definiton of matrix elements  

!!! Define matrix coefficients of tridiagonal linear solver
a = -dt*dx*nu-dt*DD
b = nu*dt*dx + 2*DD*dt + dx**2
c = -dt*DD
d = dx**2

!! for adapting tridiagonal solver, the alpha,
!!gamma array should be the same size as beta-diagonal
a(1) = 0
c(mesh_size-1) = 0


!!!!    compute RHO    

do i=1,int(nb_step)

!! Create B which is in A*RHO=B
Bmat = d * rho_old
Bmat(1) = Bmat(1) - rho_0*a(3)
Bmat(mesh_size-1) = Bmat(mesh_size-1) - c(3)*rho_L

!compute the new density in this time step by
! using Tridiagonal solver
call solve_tridiag(a,b,c,Bmat,rho_new,mesh_size-1)
rho_old = rho_new


end do
print*, '                               '
print*, '**********************************************'
print*, 'number of time step', nb_step
print*, 'calculation succed'
print*, 'end of the program'
print*, '**********************************************'
print*, '                               '

!!!!    output     

open (11,file="result.txt",action="write",status="replace")
write (11,*) '0',rho_0
do i=1,mesh_size-1
write(11,*) dble(i)*dx, rho_new(i) 
end do
write(11,*) L,rho_L
close (11)


end



!!!!!   subroutine tridiagonal matrix linear solver     


subroutine solve_tridiag(a,b,c,d,x,n)
implicit none
!	 a - sub-diagonal (means it is the diagonal below the main diagonal)
!	 b - the main diagonal
!	 c - sup-diagonal (means it is the diagonal above the main diagonal)
!	 d - right part
!	 x - the answer
!	 n - number of equations

integer,intent(in) :: n
real(8),dimension(n),intent(in) :: a,b,c,d
real(8),dimension(n),intent(out) :: x
real(8),dimension(n) :: cp,dp
real(8) :: m
integer i

! initialize c-prime and d-prime
cp(1) = c(1)/b(1)
dp(1) = d(1)/b(1)
! solve for vectors c-prime and d-prime
do i = 2,n
m = b(i)-cp(i-1)*a(i)
cp(i) = c(i)/m
dp(i) = (d(i)-dp(i-1)*a(i))/m
enddo
! initialize x
x(n) = dp(n)
! solve for x from the vectors c-prime and d-prime
do i = n-1, 1, -1
x(i) = dp(i)-cp(i)*x(i+1)
end do

end subroutine solve_tridiag
