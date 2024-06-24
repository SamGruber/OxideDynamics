#include "AnisotropicSumDiffusion.h"

registerMooseObject("MarmotApp", AnisotropicSumDiffusion);

InputParameters
AnisotropicSumDiffusion::validParams()
{
  InputParameters p = Kernel::validParams();
  p.addClassDescription("Anisotropic diffusion kernel using material property.");
  return p;
}

AnisotropicSumDiffusion::AnisotropicSumDiffusion(const InputParameters & parameters)
  : Kernel(parameters), 
    _K(getMaterialProperty<RealTensorValue>("K"))
{
}

Real
AnisotropicSumDiffusion::computeQpResidual()
{
  return (_K[_qp] * _grad_u[_qp]) * _grad_test[_i][_qp];
}

Real
AnisotropicSumDiffusion::computeQpJacobian()
{
  return (_K[_qp] * _grad_phi[_j][_qp]) * _grad_test[_i][_qp];
}