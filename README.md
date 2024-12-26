# FileGraffitiTool

This project is a set of scripts and a C program that allows users to "graffiti" files by writing a custom string at the end of the file. The tool can process individual files or recursively process directories.

## Features
- **File Graffiti**: Writes a custom string (e.g., the current username) at the end of a file.
- **Recursive Directory Processing**: Processes all files in a directory and its subdirectories.
- **Error Handling**: Checks for file accessibility, size, and other conditions before performing operations.
- **Output Filtering**: Sorts, removes duplicates, and cleans up the output for better readability.

## Files
- **`iwashere.sh`**: The main script that processes files or directories and calls the `filegraffiti` executable.
- **`filegraffiti.c`**: The C program that performs the actual file graffiti operation.
- **`main.sh`**: A wrapper script that sets up the environment and calls `iwashere.sh`.

## How to Use

### Prerequisites
- A Linux environment.
- GCC compiler (for compiling `filegraffiti.c`).
- Bash shell.

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/omerdikyol/FileGraffitiTool.git
   cd FileGraffitiTool
   ```
2. Compile the filegraffiti program:
   ```bash
   gcc -o legal_arts/performances/filegraffiti legal_arts/performances/filegraffiti.c
   ```
3. Make the scripts executable:
   ```bash
   chmod +x legal_arts/iwashere.sh
   chmod +x main.sh
   ```
4. Run the **`main.sh`** script with a directory or file as an argument:
   ```bash
   ./main.sh /path/to/directory_or_file
   ```
## Example Output
The script will output messages like:
   ```bash
   FILE VANDALIZED: /path/to/file
   ```
If a file is too small for the graffiti, it will output:
   ```bash
   CANVAS TOO SMALL
   ```

## Project Structure
**`legal_arts/`**: Contains the iwashere.sh script and the performances/ directory.

**`performances/`**: Contains the filegraffiti.c source code and the compiled filegraffiti executable.

**`main.sh`**: The main script that sets up and runs the tool.

## License
This project is open-source and available under the MIT License.


