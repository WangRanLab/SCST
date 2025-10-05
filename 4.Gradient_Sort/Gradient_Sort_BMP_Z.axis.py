import pandas as pd
import os
import sys

# Check Python version
print("Python version: " + sys.version)

def read_txt_with_header(file_path):
    """
    Read txt file with header
    First row is column names, first column is cell names
    """
    try:
        # Read txt file, first row as header
        df = pd.read_csv(file_path, sep='\t', header=0)
        return df
    except Exception as e:
        print("Error reading file: " + str(e))
        return None

def quicksort_dataframe_by_column(df, sort_column, descending=True):
    """
    Use quicksort to sort DataFrame by specified column
    Keep cell names and all other columns
    """
    # Get values from specified column and original indices
    values = df[sort_column].tolist()
    indices = range(len(values))
    
    def quicksort_indices(left, right):
        """
        Quicksort recursive function
        """
        if left < right:
            # Partition operation, return correct position of pivot
            pivot_index = partition(left, right)
            # Recursively sort left part
            quicksort_indices(left, pivot_index - 1)
            # Recursively sort right part
            quicksort_indices(pivot_index + 1, right)
    
    def partition(left, right):
        """
        Partition function
        """
        # Select rightmost element as pivot
        pivot_value = values[right]
        
        # Pointer for smaller elements
        i = left - 1
        
        for j in range(left, right):
            # Compare elements based on sort direction
            if descending:
                # Descending sort: swap when current element >= pivot
                if values[j] >= pivot_value:
                    i += 1
                    # Swap elements in values and indices
                    values[i], values[j] = values[j], values[i]
                    indices[i], indices[j] = indices[j], indices[i]
            else:
                # Ascending sort: swap when current element <= pivot
                if values[j] <= pivot_value:
                    i += 1
                    values[i], values[j] = values[j], values[i]
                    indices[i], indices[j] = indices[j], indices[i]
        
        # Place pivot in correct position
        values[i + 1], values[right] = values[right], values[i + 1]
        indices[i + 1], indices[right] = indices[right], indices[i + 1]
        return i + 1
    
    # Execute quicksort
    quicksort_indices(0, len(values) - 1)
    
    # Rearrange DataFrame based on sorted indices
    sorted_df = df.iloc[indices].reset_index(drop=True)
    return sorted_df

def extract_and_sort_xyz_by_z(df):
    """
    Extract X, Y, Z columns and sort them by Z column in descending order
    Returns a new DataFrame with only X, Y, Z columns sorted by Z
    """
    # Extract only X, Y, Z columns
    xyz_df = df[['X', 'Y', 'Z']].copy()
    
    # Use quicksort to sort by Z column in descending order
    sorted_xyz = quicksort_dataframe_by_column(xyz_df, 'Z', descending=True)
    
    return sorted_xyz

def save_with_header(df, output_file):
    """
    Save DataFrame with header
    """
    df.to_csv(output_file, sep='\t', index=False)
    print("Data saved to: " + output_file + " (with header)")

def display_formatted_data(df, title):
    """
    Format and display data with header
    """
    print("\n" + title)
    print("-" * 60)
    
    # Display header
    headers = df.columns.tolist()
    header_line = "\t".join(headers)
    print(header_line)
    
    # Display data rows
    for index, row in df.iterrows():
        row_data = []
        for col in headers:
            value = row[col]
            # Format if numeric
            if isinstance(value, (int, float)):
                if abs(value) < 0.001 or abs(value) >= 10000:
                    row_data.append("{:.2E}".format(value))
                else:
                    row_data.append("{:.4f}".format(value))
            else:
                row_data.append(str(value))
        print("\t".join(row_data))

def main():
    # Specific file path and name
    file_path = "D:\\Data_analysis\\Single_Cell\\TenX\\Methodology\\Manuscript\\Co-submit\\ISCIENCE\\Code\\Gradient_Sort\\Gene_Expr.txt"
    
    # Check if file exists
    if not os.path.exists(file_path):
        print("Error: File does not exist - " + file_path)
        return
    
    print("Reading file: " + file_path)
    df = read_txt_with_header(file_path)
    
    if df is None:
        print("Cannot read file, please check file path and format")
        return
    
    print("Original gene expression data:")
    display_formatted_data(df, "Original Data")
    print("Data shape: " + str(df.shape))
    print("\n" + "="*70)
    
    # Check if Bmp4 column exists
    if 'Bmp4' not in df.columns:
        print("Error: Bmp4 column not found in data")
        print("Available columns: " + str(list(df.columns)))
        return
    
    # Step 1: Use quicksort to sort by Bmp4 column in descending order
    print("STEP 1: Sorting by Bmp4 column in descending order using quicksort...")
    sorted_by_bmp4 = quicksort_dataframe_by_column(df, 'Bmp4', descending=True)
    
    print("\nRESULT 1 - Sorted by Bmp4 (descending):")
    display_formatted_data(sorted_by_bmp4, "Bmp4 Sorted Data")
    
    # Verify Bmp4 sorting results
    print("\nVerifying Bmp4 column descending order:")
    bmp4_values = sorted_by_bmp4['Bmp4'].tolist()
    formatted_bmp4 = []
    for x in bmp4_values:
        if isinstance(x, float):
            formatted_bmp4.append("{:.4f}".format(x))
        else:
            formatted_bmp4.append(str(x))
    print(" -> ".join(formatted_bmp4))
    
    is_bmp4_descending = all(bmp4_values[i] >= bmp4_values[i+1] for i in range(len(bmp4_values)-1))
    print("Bmp4 sorting verification: " + ('Success' if is_bmp4_descending else 'Failed'))
    
    # Display Bmp4 sorted cell order
    print("\nBmp4 sorted cell order:")
    cell_column = df.columns[0]
    bmp4_sorted_cells = sorted_by_bmp4[cell_column].tolist()
    for i, cell in enumerate(bmp4_sorted_cells, 1):
        print("{:2d}. {}".format(i, cell))
    
    # Save Bmp4 sorted results
    output_dir = "D:\\Data_analysis\\Single_Cell\\TenX\\Methodology\\Manuscript\\Co-submit\\ISCIENCE\\Code\\Gradient_Sort"
    bmp4_output_file = os.path.join(output_dir, "Sorted_Gene_Expr_By_Bmp4.txt")
    save_with_header(sorted_by_bmp4, bmp4_output_file)
    
    print("\n" + "="*70)
    print("STEP 2: Extracting X, Y, Z columns and sorting by Z column in descending order...")
    
    # Step 2: Extract X, Y, Z columns and sort by Z column
    sorted_xyz = extract_and_sort_xyz_by_z(sorted_by_bmp4)
    
    print("\nRESULT 2 - X, Y, Z columns sorted by Z (descending):")
    display_formatted_data(sorted_xyz, "XYZ Sorted by Z")
    
    # Verify Z column sorting
    print("\nVerifying Z column descending order:")
    z_values = sorted_xyz['Z'].tolist()
    formatted_z = []
    for x in z_values:
        if isinstance(x, float):
            formatted_z.append("{:.4f}".format(x))
        else:
            formatted_z.append(str(x))
    print(" -> ".join(formatted_z))
    
    is_z_descending = all(z_values[i] >= z_values[i+1] for i in range(len(z_values)-1))
    print("Z column sorting verification: " + ('Success' if is_z_descending else 'Failed'))
    
    # Display the sorted XYZ data with corresponding cell names
    print("\nXYZ data with corresponding cell names (sorted by Z):")
    print("Cell\t\tX\t\tY\t\tZ")
    print("-" * 60)
    for i, (index, row) in enumerate(sorted_xyz.iterrows()):
        cell_name = bmp4_sorted_cells[i]  # Use the same order as Bmp4 sorted cells
        x_val = row['X']
        y_val = row['Y']
        z_val = row['Z']
        print("{}\t{:.2E}\t{:.2E}\t{:.2E}".format(cell_name, x_val, y_val, z_val))
    
    # Save sorted XYZ results
    xyz_output_file = os.path.join(output_dir, "Sorted_XYZ_By_Z.txt")
    save_with_header(sorted_xyz, xyz_output_file)
    
    # Create a combined file with Cell names and sorted XYZ
    print("\n" + "="*70)
    print("STEP 3: Creating combined file with Cell names and sorted XYZ data...")
    
    combined_df = pd.DataFrame()
    combined_df['Cell'] = bmp4_sorted_cells
    combined_df['X'] = sorted_xyz['X'].values
    combined_df['Y'] = sorted_xyz['Y'].values
    combined_df['Z'] = sorted_xyz['Z'].values
    combined_df['Bmp4'] = sorted_by_bmp4['Bmp4'].values
    
    print("\nRESULT 3 - Combined data (Cell + sorted XYZ + Bmp4):")
    display_formatted_data(combined_df, "Combined Sorted Data")
    
    # Save combined results
    combined_output_file = os.path.join(output_dir, "Combined_Sorted_Data.txt")
    save_with_header(combined_df, combined_output_file)
    
    # Display saved file contents
    print("\n" + "="*70)
    print("SAVED FILE PREVIEWS:")
    
    print("\n1. Bmp4 sorted file preview:")
    try:
        with open(bmp4_output_file, 'r') as f:
            content = f.read()
            print(content)
    except Exception as e:
        print("Error reading Bmp4 sorted file: " + str(e))
    
    print("\n2. XYZ sorted file preview:")
    try:
        with open(xyz_output_file, 'r') as f:
            content = f.read()
            print(content)
    except Exception as e:
        print("Error reading XYZ sorted file: " + str(e))
    
    print("\n3. Combined sorted file preview:")
    try:
        with open(combined_output_file, 'r') as f:
            content = f.read()
            print(content)
    except Exception as e:
        print("Error reading combined sorted file: " + str(e))

# Execute main function if script is run directly
if __name__ == "__main__":
    print("Gene Expression Data Sorting Program - Python 2.7.13")
    print("=" * 70)
    print("This program will:")
    print("1. First sort rows by Bmp4 column (descending) using quicksort")
    print("2. Then extract X, Y, Z columns and sort by Z column (descending)")
    print("3. Output separate files for each sorting step")
    print("=" * 70)
    
    # Specific file path
    file_path = "D:\\Data_analysis\\Single_Cell\\TenX\\Methodology\\Manuscript\\Co-submit\\ISCIENCE\\Code\\Gradient_Sort\\Gene_Expr.txt"
    
    # Check if file exists
    if not os.path.exists(file_path):
        print("Error: File does not exist - " + file_path)
        print("Please check file path")
    else:
        # Run the main function
        main()