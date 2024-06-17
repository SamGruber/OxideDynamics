#pragma once

#include "Material.h"

class AnisotropicSumDiffusionMaterial : public Material
{
public:
  AnisotropicSumDiffusionMaterial(const InputParameters & parameters);
  static InputParameters validParams();
protected:
  virtual void computeQpProperties() override;
private:
  const RealTensorValue & _K_ani;
  const RealTensorValue & _K_iso;
  const Real & _x_min;
  const Real & _x_max;
  MaterialProperty<RealTensorValue> & _K;
};
