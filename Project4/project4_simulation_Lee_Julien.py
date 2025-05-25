---
title: "project4_simulation_Lee_Julien"
format: html
---

import numpy as np
import pandas as pd
import statsmodels.api as sm
import statsmodels.formula.api as smf

beta_0 = np.log(2)
beta_1 = 0.05
years = np.arange(30)
n_sim = 100
results = []

for _ in range(n_sim):
    lambda_t = np.exp(beta_0 + beta_1 * years)
    y = np.random.poisson(lambda_t)
    df = pd.DataFrame({'disasters': y, 'years': years})
    model = smf.glm("disasters ~ years", data=df, family=sm.families.Poisson()).fit()
    b1 = model.params['years']
    conf = model.conf_int().loc['years']
    results.append({'b1': b1, 'lower': conf[0], 'upper': conf[1]})
