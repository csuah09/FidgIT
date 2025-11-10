# convert_model.py

import tensorflow as tf
import coremltools as ct

from binary_definition import create_model

# Define input shape based on the data
input_shape = (10, 4)  # Adjust this to match your training input shape

# Recreate the model architecture
model = create_model(input_shape=input_shape)

# Load the saved weights
model.load_weights("fidget_cnn_lstm_binary_model_weights.h5")

# Convert the model to Core ML format
mlmodel = ct.convert(model, inputs=[ct.TensorType(shape=(1, *input_shape))])

# Save the Core ML model
mlmodel.save("fidget_cnn_lstm_binary_model.mlpackage")
print("Model successfully converted and saved as 'fidget_cnn_lstm_binary_model.mlpackage'")

