#pragma once

#include "Material.h"
#include "SplitCHWResBase.h"
#include "RankTwoTensor.h"

/**
 * TensorSumSplitCHWRes creates the residual for the chemical
 * potential in the split form of the Cahn-Hilliard
 * equation with a tensorial mobility.
 */

class TensorSumSplitCHWRes : public SplitCHWResBase<Real>
{
public:
  TensorSumSplitCHWRes(const InputParameters & parameters);

  static InputParameters validParams();

protected:
  // virtual Real computeQpResidual() override;

  const MaterialProperty<RealTensorValue> & _K;
};
