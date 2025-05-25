import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression, Ridge, Lasso
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import train_test_split
import seaborn as sns
import matplotlib.pyplot as plt

# Set seed for reproducibility
np.random.seed(84)

# Generate synthetic count data
def generate_data(n=638):
    x1 = np.random.poisson(lam=1, size=n)
    x2 = np.random.poisson(lam=1, size=n)
    noise = np.random.normal(0, 1, size=n)
    y = x1 + 0.5 * x2 + noise
    y = np.round(np.abs(y))  # Ensure all counts are non-negative integers
    return y

# Load original merged data
merged_path = "~/Documents/stat155/Project1/data/processdata/mergeddata.csv"
df = pd.read_csv(merged_path)

# Generate synthetic count values
df['count'] = generate_data(n=len(df))

# Save new dataset
output_path = "~/Documents/stat155/Project1/data/processdata/generateddata.csv"
df.to_csv(output_path, index=False)

