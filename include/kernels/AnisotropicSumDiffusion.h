#pragma once

#include "Kernel.h"

/**
 * This kernel implements the Laplacian operator
 * multiplied by a 2nd order tensor giving
 * anisotropic (direction specific) diffusion:
 * $\overline K \cdot \nabla u \cdot \nabla \phi_i$
 * 
 * 
 */
class AnisotropicSumDiffusion : public Kernel
{
public:
  static InputParameters validParams();

  AnisotropicSumDiffusion(const InputParameters & parameters);

protected:
  virtual Real computeQpResidual() override;

  virtual Real computeQpJacobian() override;

  const MaterialProperty<RealTensorValue> & _K;
};