
!!!      Advectio-Diffusion equation         
!!! Finite difference | Implicit time scheme 


program purediffanalytical

IMPLICIT NONE


!!!!    definition of variables    

integer ::i,mesh_size
double precision :: L,T,dx,rho_imax,D
double precision,dimension(:),allocatable :: rho


!!!!    read input data      


open(1,file='inputcoefficients.txt') ! Never put number 6
read(1,*) D
read(1,*) L
read(1,*) mesh_size
read(1,*) T
read(1,*) rho_imax


!!! debug use, verifing variable value
print*, 'Diffusion coefficient'
print*, D
print*, 'length of domain'
print*, L
print*, 'mesh size'
print*, mesh_size
print*, 'simulation time'
print*, T
print*, 'Boundary condition rho_imax'
print*, rho_imax


close(1)

!! allocate memory for following variable
allocate(rho(mesh_size))

!!!!    Definiton of matrix elements   

!!! Mesh size
dx = L/mesh_size

!!!!    compute RHO    

do i=0, int(mesh_size)

rho(i)=rho_imax-rho_imax*erf((i*dx)/(2*sqrt(D*T)))

end do

print*, '                               '
print*, '**********************************************'
print*, 'calculation succed'
print*, 'end of the program'
print*, '**********************************************'
print*, '                               '

!!!!    output     


open (11,file="result.txt",action="write",status="replace")
do i=0,mesh_size
write(11,*) dble(i)*dx, rho(i) !converti en double précision
end do
close (11)


end

