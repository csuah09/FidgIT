import numpy as np
import pandas as pd

# Load the Excel file and set 'Time' as the index
df = pd.read_excel('correct_data.xlsx')
df['Time'] = pd.to_datetime(df['Time'], format='%H:%M:%S')
df.set_index('Time', inplace=True)

# Select the input features (button, X_Axis, Y_Axis, Spin_Rate)
X = df[['button', 'X_Axis', 'Y_Axis', 'Spin_Rate']]

# Define the window size for sequences
window_size = 10

# Function to create sequences
def create_sequences(data, window_size):
    X_seq = []
    for i in range(len(data) - window_size):
        X_seq.append(data[i:i + window_size].values)  # Sequence of features
    return np.array(X_seq)

# Create sequences for the "stressed" data
X_seq = create_sequences(X, window_size)

np.save('X_seq.npy', X_seq)

# Check the shape of the resulting data
print("Shape of X_seq:", X_seq.shape)
print("Shape of a single sequence:", X_seq[0].shape)
print("First sequence:\n", X_seq[0])
print("Shape of a single time step in a sequence:", X_seq[0][0].shape)

