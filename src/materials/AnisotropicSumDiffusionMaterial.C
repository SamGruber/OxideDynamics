#include "AnisotropicSumDiffusionMaterial.h"

registerMooseObject("MooseApp", AnisotropicSumDiffusionMaterial);

InputParameters
AnisotropicSumDiffusionMaterial::validParams()
{
  InputParameters params = Material::validParams();
  params.addClassDescription("Anisotropic diffusion tensor material with linear combination: K = K_ani*alpha + K_iso*(1-alpha), where alpha(x) = frac{x-x_min}{x_max-x_min})");
  params.addRequiredParam<RealTensorValue>("tensor_anisotropic", "Anisotropic tensor (K_ani)");
  params.addRequiredParam<RealTensorValue>("tensor_isotropic", "Isotropic tensor (K_iso)");
  params.addRequiredParam<Real>("x_min", "Minimum x-coordinate value");
  params.addRequiredParam<Real>("x_max", "Maximum x-coordinate value");
  return params;
}

AnisotropicSumDiffusionMaterial::AnisotropicSumDiffusionMaterial(const InputParameters & parameters)
  : Material(parameters),
    _K_ani(getParam<RealTensorValue>("tensor_anisotropic")),
    _K_iso(getParam<RealTensorValue>("tensor_isotropic")),
    _x_min(getParam<Real>("x_min")),
    _x_max(getParam<Real>("x_max")),
    _K(declareProperty<RealTensorValue>("K"))
{
}

void
AnisotropicSumDiffusionMaterial::computeQpProperties()
{
  Real x = _q_point[_qp](0) ;
  Real alpha = (x - _x_min) / (_x_max - _x_min);
  _K[_qp] = _K_ani * alpha + _K_iso * (1 - alpha);
}