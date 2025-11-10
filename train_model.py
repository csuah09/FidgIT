import numpy as np
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import LSTM, Dense, RepeatVector, TimeDistributed

# Load the processed sequences
X_seq = np.load('X_seq.npy')

# Define the autoencoder model
model = Sequential([
    LSTM(64, activation='relu', input_shape=(X_seq.shape[1], X_seq.shape[2]), return_sequences=True),
    LSTM(32, activation='relu', return_sequences=False),
    RepeatVector(X_seq.shape[1]),
    LSTM(32, activation='relu', return_sequences=True),
    LSTM(64, activation='relu', return_sequences=True),
    TimeDistributed(Dense(X_seq.shape[2]))
])

# Compile the model
model.compile(optimizer='adam', loss='mse')
model.summary()

# Train the model on the "stressed" data
model.fit(X_seq, X_seq, epochs=50, batch_size=32, validation_split=0.1)

# Save the trained model
model.save('fidget_autoencoder_model.keras', save_format="keras")
print("Model saved as 'fidget_autoencoder_model.h5'")
