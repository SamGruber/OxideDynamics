[Mesh]
    type = GeneratedMesh
    dim = 2          # Use 2 for 2D, 3 for 3D
    nx = 10          # Number of elements in the x-direction
    ny = 10          # Number of elements in the y-direction
    # nz = 10          Only include if dim = 3
  []
  
  [Variables]
    [u]
      initial_condition = 0.0
      family = LAGRANGE
      order = FIRST
    []
  []
  
  [Kernels]
    [diffusion]
      type = AnisotropicSumDiffusion
      variable = u
      tensor_anisotropic = '0.1 0 0 
                            0 0.1 0 
                            0 0 1'  # 3x3 identity matrix as an example
      tensor_isotropic = '0.5 0 0
                          0 0.5 0
                          0 0 0.5'  # Another 3x3 tensor as an example
      alpha = 0.5
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
  []
  
  [Outputs]
    exodus = True
  []  