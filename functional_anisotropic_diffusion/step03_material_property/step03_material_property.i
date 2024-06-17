  [Mesh]
    type = GeneratedMesh
    dim = 3
    xmin = 0
    xmax = 10
    ymin = 0
    ymax = 10
    zmin = 0
    zmax = 10
    nx = 10
    ny = 10
    nz = 10
  []
  
  [Variables]
    [u]
      order = FIRST
      family = LAGRANGE
    []
  []
  
  [Kernels]
    [diffusion]
      type = AnisotropicSumDiffusion
      variable = u
    []
  []
  
  [Materials]
    [diffusion_tensor]
      type = AnisotropicSumDiffusionMaterial
      tensor_anisotropic = '0.1 0 0 
                            0 0.1 0 
                            0 0 1'
      tensor_isotropic = '0.1 0 0 
                          0 0.1 0 
                          0 0 0.1'
      x_min = 0.0
      x_max = 1.0
    []
  []
  
  [BCs]
    [left]
      type = DirichletBC
      variable = u
      boundary = left
      value = 0.0
    []
    [right]
      type = DirichletBC
      variable = u
      boundary = right
      value = 1.0
    []
  []
  
  [Executioner]
    type = Steady
    solve_type = 'NEWTON'
    nl_rel_tol = 1e-6
    l_tol = 1e-10
    l_max_its = 100
  []
  
  [Outputs]
    exodus = true
  []
  