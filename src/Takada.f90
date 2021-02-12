PROGRAM Takada

   USE basic_operations
   USE array_operations
   USE string_operations
   USE cosmology_functions
   USE HMx

   IMPLICIT NONE

   INTEGER :: ik, inu
   INTEGER :: ihm, icos
   REAL :: Q, Q1, Q2, Q3, M
   REAL, ALLOCATABLE :: k(:)
   INTEGER :: u
   TYPE(cosmology) :: cosm
   TYPE(halomod) :: hmod
   CHARACTER(len=256) :: outfile
   REAL, PARAMETER :: kmin = 1e-3
   REAL, PARAMETER :: kmax = 1e0
   INTEGER, PARAMETER :: nk = 128
   REAL, PARAMETER :: a = 1.
   REAL, PARAMETER :: nu_base = 1.
   REAL, PARAMETER :: nu(4) = [1., 1.5, 2., 2.5]
   INTEGER, PARAMETER :: nnu = size(nu)
   REAL, PARAMETER :: rv1 = 0.
   REAL, PARAMETER :: rv2 = rv1
   INTEGER, PARAMETER :: icos_def = 37
   INTEGER, PARAMETER :: ihm_def = 3
   LOGICAL, PARAMETER :: verbose = .TRUE.
   CHARACTER(len=256), PARAMETER :: outbase = 'results/Takada_nu'

   ! Fill wavenumber array
   CALL fill_array(kmin, kmax, k, nk, ilog=.FALSE.)

   ! Assign and init cosmology
   icos = icos_def
   CALL assign_init_cosmology(icos, cosm, verbose)

   ! Assign and init halo model
   ihm = ihm_def
   CALL assign_init_halomod(ihm, a, hmod, cosm, verbose)

   ! Loop over peak heights
   DO inu = 1, nnu


      ! Loop over wavenumbers and do calculation at each
      outfile = trim(outbase)//trim(real_to_string(nu(inu), 1, 1))//'.dat'
      OPEN(newunit=u, file=outfile)
      DO ik = 1, nk
         Q1 = 1.+BNL(k(ik), nu_base, nu(inu), rv1, rv2, hmod, cosm)
         Q2 = 1.+BNL(k(ik), nu_base, nu_base, rv1, rv2, hmod, cosm)
         Q3 = 1.+BNL(k(ik), nu(inu), nu(inu), rv1, rv2, hmod, cosm)
         Q = Q1/sqrt(Q2*Q3)
         WRITE(u, *) k(ik), Q
      END DO
      CLOSE(u)

      M = M_nu(nu(inu), hmod)
      WRITE(*, *) 'Nu, halo mass [log10(Msun/h)]:', nu(inu), log10(M)

   END DO

   WRITE(*, *)

END PROGRAM Takada