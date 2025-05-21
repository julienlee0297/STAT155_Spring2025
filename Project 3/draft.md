# draft


Introduction and Data: As global warming continues to wreak havoc on the
planet, more natural disasters will occur. This is a well known
consequence of greenhouse gas emissions, but it doesn’t take into
account that inadequate infrastructure determines who is most vulnerable
to the reactions of our precarious environment. Lower income communities
have historically been more at risk for property damage and displacement
following natural devastation, and after witnessing the aftermath of the
LA fires

The Flint, Michigan water crisis and the Pajaro Valley flood are two
textbook examples of environmental racism which arose because of
extremely neglected infrastructure in impoverished communities.
Instances of outdated infrastructure endangering communities is not
surprising or new, but I wanted to explore further in the case of a FEMA
data set containing observations on federally declared disasters. Based
on the past case studies mentioned above as well as many others, I
hypothesize that an inverse correlation between median household income
and declared disasters will be found by the use of lasso regression.

-   Describe the data and definitions of key variables
-   EDA for the response variable and a few other interesting variables
    and relationships

Methodology

-   Explain the reasoning for the type of analysis you are running to
    answer your research question, and the variables considered for the
    model
-   show how you arrived at the final answer to your research

``` python
import numpy as np
import pandas as pd
from sklearn.linear_model import Lasso
import matplotlib.pyplot as plt
import os

# Load the data
df = pd.read_csv("~/Documents/stat155/Project 1/data/processdata/mergeddata.csv")

# Fill missing values
df['count'] = df['count'].fillna(0)
df = df.dropna(subset=['weighted_agi_stub'])

# Get list of years
years = sorted(df['Year'].unique())

# Output directory
output_dir = "~/Documents/stat155/Project 3/lasso_plots"
os.makedirs(os.path.expanduser(output_dir), exist_ok=True)

# Generate and save plot per year
for year in years:
    data_year = df[df['Year'] == year]
    
    X = data_year[['weighted_agi_stub']].values
    y = data_year['count'].values

    if len(X) == 0:
        continue  # Skip if no data for this year
    
    model = Lasso(alpha=0.1)
    model.fit(X, y)

    x_range = np.linspace(X.min(), X.max(), 100).reshape(-1, 1)
    y_pred = model.predict(x_range)

    plt.figure(figsize=(8, 6))
    plt.scatter(X, y, alpha=0.6, label='Data')
    plt.plot(x_range, y_pred, color='red', label='Lasso Fit')
    plt.title(f"Lasso Regression: {year}")
    plt.xlabel("Weighted AGI Stub")
    plt.ylabel("Number of Disasters")
    plt.legend()
    plt.grid(True)
    plt.tight_layout()

    file_path = os.path.join(os.path.expanduser(output_dir), f"lasso_disasters_{year}.png")
    plt.savefig(file_path)
    plt.close()
```

Results

Every single plot is a flat line; there is no correlation between a
county’s weighted adjusted gross income and number of federally declared
disasters. I think this is because of the small sample size across both
time and geography. This analysis was performed only on counties in
California over the span of 10 years which is a narrow window for
finding a correlation involving federally declared disasters, seeing
that they do not happen very often. Since the disasters used in this
project were only one that were severe enough to be declared federally
by FEMA, there is a higher threshold for the damage done. Taking that
into account, if analysis was performed on state level disasters I
hypothesize a stronger correlation would be found just from the
increased number of declared natural disasters per county. Expanding the
temporal window of the project could also provide a correlation between
the two variables.
