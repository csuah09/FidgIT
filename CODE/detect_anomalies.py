import numpy as np
import tensorflow as tf
import pandas as pd

# Load the trained model in .keras format
model = tf.keras.models.load_model('fidget_autoencoder_model.keras')

# Load the processed sequences used to calculate the threshold
X_seq = np.load('X_seq.npy')

# Calculate the reconstruction error for the training data to set the anomaly threshold
reconstructed = model.predict(X_seq)
mse = np.mean(np.mean((X_seq - reconstructed)**2, axis=1), axis=1)  # Compute MSE for each sequence

# Set the threshold as the maximum MSE from the training data
threshold = np.percentile(mse, 95)
print("Anomaly detection threshold:", threshold)

# Function to create sequences, same as in data_processing.py
def create_sequences(data, window_size):
    X_seq = []
    for i in range(len(data) - window_size):
        X_seq.append(data[i:i + window_size].values)
    return np.array(X_seq)

# Load and prepare new data (replace with actual new data source)
new_data_df = pd.read_excel('testData1.xlsx')  # Replace with your new data file
new_data_df['Time'] = pd.to_datetime(new_data_df['Time'], format='%H:%M:%S')
new_data_df.set_index('Time', inplace=True)
new_data = new_data_df[['button', 'X_Axis', 'Y_Axis', 'Spin_Rate']]

# Create sequences for the new data
X_test_seq = create_sequences(new_data, X_seq.shape[1])

# Detect anomalies by calculating reconstruction errors and comparing to threshold
reconstructed = model.predict(X_test_seq)
mse = np.mean(np.mean((X_test_seq - reconstructed)**2, axis=1), axis=1)
anomalies = mse > threshold

# Output the results
print("Anomalies detected:", anomalies)
print("Reconstruction errors (MSE):", mse)
