# binary_train.py

from binary_definition import create_model
from binary_dataprocessing import load_and_preprocess_data
import numpy as np

# Load and preprocess data
X_train, X_test, y_train, y_test = load_and_preprocess_data()

# Define and train the model
model = create_model(input_shape=(X_train.shape[1], X_train.shape[2]))
model.fit(X_train, y_train, epochs=20, validation_data=(X_test, y_test))

# Save only the weights for conversion
model.save_weights("fidget_cnn_lstm_binary_model_weights.h5")
print("Model weights saved.")
