#!/bin/bash

# ************************************************************
# ************************************************************
# **                                                        **
# **            BASH SCRIPT TO CLEAN A DIRECTORY            **
# **                                                        **
# ************************************************************
# ************************************************************

RED='\033[0;31m'  # Red Color
BLUE='\033[0;34m' # Blue Color
NC='\033[0m'      # no color

echo -e "${BLUE}  ************************************************************${NC}"
echo -e "${BLUE}  ************************************************************${NC}"
echo -e "${BLUE}  **                                                        **${NC}"
echo -e "${BLUE}  **            BASH SCRIPT TO CLEAN A DIRECTORY            **${NC}"
echo -e "${BLUE}  **                                                        **${NC}"
echo -e "${BLUE}  ************************************************************${NC}"
echo -e "${BLUE}  ************************************************************${NC}"
sleep 2

#Function: getExtensionType()
#
#Brief: find out if the extension in contaitn in the extensions array
#
getExtensionType() {
  ext=$1
  extensions_array=("$@")
  sd=""
  counter=0
  for tmp in ${extensions_array[@]}; do
    if [ "$ext" == "$tmp" ] && [ "$counter" != 0 ]; then
      echo "found"
      break
    fi
    counter=2
  done
}

# Array of image file extensions
image_extensions=("jpg" "jpeg" "png" "gif" "bmp" "svg")

# Array of video file extensions
video_extensions=("mp4" "avi" "mkv" "mov" "wmv")

# Array of document file extensions
document_extensions=("doc" "bibtex" "docx" "xls" "xlsx" "ppt" "pptx" "pdf" "cls" "txt" "odt" "ods" "odp" "odg" "odf" "rtf" "tex" "texi" "tex" "log" "csv" "tsv" "html" "htm" "css" "js" "json" "xml" "sql")

# Array of Windows executable file extensions
executable_extensions=("exe" "msi" "bat" "cmd" "ini" "deb")

# Array of compressed file extensions
compressed_extensions=("zip" "rar" "tar" "gz" "7z")

# Create a 2-dimensional array
extensions_mat=(
  [0]=${image_extensions[@]}
  [1]=${video_extensions[@]}
  [2]=${document_extensions[@]}
  [3]=${executable_extensions[@]}
  [4]=${compressed_extensions[@]}
)

# test if there is a parameter given with the script execution
if [ -z "$1" ]; then
  starter=0
  while [ "$starter" == 0 ]; do
    read -p "would you like to clean the Downloads directory? (y/n): " answer
    case $answer in
    [Nn]*)
      echo -e "Enter the absolute directory path to clean: "
      echo -e "${RED}Example: /mnt/c/Users/user/${NC}"
      read DIR
      starter=1
      ;;
    [Yy]*)
      DIR="${HOST_DIR}/Downloads"
      starter=1
      ;;
    *)
      echo -e "Please Enter the absolute directory path to clean: "
      ;;
    esac
  done
else
  DIR="${HOST_DIR}/Downloads"
fi

echo -e "Cleaning ${RED}${DIR}${NC} directory..."
sleep 2

# Specify the directory path
directory="${DIR}"

not_handled=""
isSorted=0

# Loop over files in the directory (excluding subdirectories)
find "$directory" -maxdepth 1 -type f |
  while read -r file; do
    # read each file
    filename=$(basename "$file")
    extension=$(echo "$file" | rev | cut -d. -f1 | rev)
    isSorted=0
    for ((i = 0; i < 5; ++i)); do
      # echo -e "${RED}$i interation${NC}"
      result=$(getExtensionType $extension ${extensions_mat[i]})
      if [ "$result" == "found" ]; then
        case "$i" in
        "0")
          echo "${filename} is an image."
          if [ ! -d $directory/Pictures ]; then
            mkdir $directory/Pictures
            echo "Pictures directory created"
          fi
          mv "${directory}/${filename}" $directory/Pictures
          isSorted=1
          ;;
        "1")
          echo "${filename} is an video."
          if [ ! -d $directory/Videos ]; then
            mkdir $directory/Videos
            echo "Videos directory created"
          fi
          mv "${directory}/${filename}" $directory/Videos
          isSorted=1
          ;;
        "2")
          echo "${filename} is an document."
          if [ ! -d $directory/Documents ]; then
            mkdir $directory/Documents
            echo "Documents directory created"
          fi
          mv "${directory}/${filename}" $directory/Documents
          isSorted=1
          ;;
        "3")
          echo "${filename} is an executable."
          if [ ! -d $directory/Programs ]; then
            mkdir $directory/Programs
            echo "Programs directory created"
          fi
          mv "${directory}/${filename}" $directory/Programs
          isSorted=1
          ;;
        "4")
          echo "${filename} is an compressed."
          mv "${directory}/${filename}" $directory/Compressed
          isSorted=1
          ;;
        *)
          echo "error"
          ;;
        esac
      fi
    done
    if [ "$isSorted" == 0 ]; then
      echo "${filename} with the extension ${extension} dont match to any known extensions type."
      echo "before: ${not_handled}"
      not_handled="${not_handled} ${filename} |"
      echo -e "${RED}not handled: ${not_handled}${NC}"
    fi
  done

if ["$not_handled" != ""]; then
  echo "The following files were not handled:"
  echo -e "${RED}${not_handled}${NC}"
  echo -e "${BLUE}Please add their extensions to the corresponding array of extensions${NC}"
else
  echo -e "${BLUE}All files were moved to the corresponding directory ^_^${NC}"
fi
