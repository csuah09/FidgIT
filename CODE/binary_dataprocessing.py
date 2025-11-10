# binary_dataprocessing.py
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split

def load_and_preprocess_data():
    # Load data from JSON
    df = pd.read_json("fullLTSM.json")

    # Convert the 'Time' column if it’s in datetime format
    df['Time'] = pd.to_datetime(df['Time'], format='mixed')
    df.set_index('Time', inplace=True)

    # Filter out 'Condition' values if needed (e.g., exclude unused data)
    df = df[df['condition'] != 2]

    # Select relevant columns for training
    data = df[['button', 'X_Axis', 'Y_Axis', 'Spin_Rate', 'condition']]

    # Create sequences from JSON data
    def create_sequences(data, window_size=10):
        X, y = [], []
        for i in range(len(data) - window_size):
            X.append(data.iloc[i:i + window_size, :-1].values)  # Features only
            y.append(data.iloc[i + window_size - 1]['condition'])  # Labels
        return np.array(X), np.array(y)

    # Generate sequences and labels
    X, y = create_sequences(data)

    # Split data into training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, stratify=y, random_state=42)
    return X_train, X_test, y_train, y_test

if __name__ == "__main__":
    X_train, X_test, y_train, y_test = load_and_preprocess_data()
    np.save('X_train.npy', X_train)
    np.save('X_test.npy', X_test)
    np.save('y_train.npy', y_train)
    np.save('y_test.npy', y_test)
    print("Data saved as 'X_train.npy', 'X_test.npy', 'y_train.npy', and 'y_test.npy'")
