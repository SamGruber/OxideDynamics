import pandas as pd
import matplotlib.pyplot as plt

# Define the path to the CSV file
csv_file_path = '~/projects/marmot/split_cahn_hilliard/step01_basic_splitch/step01_basic_splitch_out.csv'  # Replace with the actual path to your CSV file

# Load the CSV data
data = pd.read_csv(csv_file_path)

# Define the area of the domain
domain_area = 60 * 60

# Normalize integral_c by dividing by the domain area
data['normalized_integral_c'] = data['integral_c'] / domain_area

# Create subplots
fig, axs = plt.subplots(1, 2, figsize=(14, 6))

# Plot the normalized integral_c over time
axs[0].plot(data['time'], data['normalized_integral_c'], marker='o')
axs[0].set_xlabel('Time')
axs[0].set_ylabel('Normalized Integral of c')
axs[0].set_title('Normalized Integral of c Over Time')
axs[0].grid(True)

# Plot the integral_w over time
axs[1].plot(data['time'], data['integral_w'], marker='o', color='orange')
axs[1].set_xlabel('Time')
axs[1].set_ylabel('Integral of w')
axs[1].set_title('Integral of w Over Time')
axs[1].grid(True)

# Adjust layout
plt.tight_layout()
plt.show()