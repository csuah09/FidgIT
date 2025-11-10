import pandas as pd

# Load the Excel file
df = pd.read_excel("LTSMDATA.xlsx")

# Convert to JSON and save
df.to_json("fullLTSM.json", orient="records", date_format="iso")
print("Excel data has been converted to JSON and saved as 'combined_data.json'")
