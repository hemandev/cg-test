#!/bin/bash

# Script to create a test branch and add random changes across the codebase
# Usage: ./scripts/add-random-changes.sh [number_of_files]
# Default: 5 files if no argument provided

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DEFAULT_FILE_COUNT=5
NUM_FILES=${1:-$DEFAULT_FILE_COUNT}
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
BRANCH_NAME="test-changes-${TIMESTAMP}"

# Validate we're in a git repository
if ! \git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}Error: Not in a git repository${NC}"
    exit 1
fi

# Validate argument
if ! [[ "$NUM_FILES" =~ ^[0-9]+$ ]] || [ "$NUM_FILES" -lt 1 ]; then
    echo -e "${RED}Error: Please provide a valid positive number${NC}"
    echo "Usage: $0 [number_of_files]"
    exit 1
fi

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Random File Change Generator${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Create new branch
echo -e "${YELLOW}Creating branch: ${BRANCH_NAME}${NC}"
\git checkout -b "${BRANCH_NAME}"

# Find all files (excluding .git, node_modules, and hidden files)
echo -e "${YELLOW}Finding files in codebase...${NC}"

# Build file list
FILES=()
while IFS= read -r -d '' file; do
    FILES+=("$file")
done < <(\find . -type f \
    ! -path "./.git/*" \
    ! -path "./node_modules/*" \
    ! -path "*/.*" \
    ! -name ".*" \
    ! -name "package-lock.json" \
    ! -name "yarn.lock" \
    ! -name "bun.lockb" \
    -print0)

TOTAL_FILES=${#FILES[@]}

if [ "$TOTAL_FILES" -eq 0 ]; then
    echo -e "${RED}Error: No files found${NC}"
    \git checkout -
    \git branch -d "${BRANCH_NAME}"
    exit 1
fi

echo -e "${GREEN}Found ${TOTAL_FILES} files${NC}"

# Check if requested files exceeds available files
if [ "$NUM_FILES" -gt "$TOTAL_FILES" ]; then
    echo -e "${YELLOW}Warning: Requested ${NUM_FILES} files but only ${TOTAL_FILES} available${NC}"
    NUM_FILES=$TOTAL_FILES
fi

# Randomly select files
echo -e "${YELLOW}Randomly selecting ${NUM_FILES} files...${NC}"

# Shuffle and select files
SELECTED_FILES=($(printf '%s\n' "${FILES[@]}" | shuf -n "$NUM_FILES"))

# Function to add comment based on file type
add_comment() {
    local file=$1
    local timestamp=$2
    local extension="${file##*.}"

    case "$extension" in
        ts|tsx|js|jsx)
            echo "" >> "$file"
            echo "// Test change - ${timestamp}" >> "$file"
            ;;
        md)
            echo "" >> "$file"
            echo "<!-- Test change - ${timestamp} -->" >> "$file"
            ;;
        json)
            # For JSON, we'll add a simple comment-like field
            # This is a bit hacky but safe - adds before the last closing brace
            if [ -s "$file" ]; then
                # Remove last closing brace, add our field, then add brace back
                sed -i '' -e '$ s/}$//' "$file"
                echo "  \"_test_change\": \"${timestamp}\"" >> "$file"
                echo "}" >> "$file"
            fi
            ;;
        yml|yaml)
            echo "" >> "$file"
            echo "# Test change - ${timestamp}" >> "$file"
            ;;
        *)
            # For unknown types, add a generic comment
            echo "" >> "$file"
            echo "# Test change - ${timestamp}" >> "$file"
            ;;
    esac
}

# Track ownership groups affected (using array for bash 3.2 compatibility)
OWNER_GROUPS=()

# Read CODEOWNERS if it exists
CODEOWNERS_FILE=".github/CODEOWNERS"

get_owners() {
    local file=$1
    if [ ! -f "$CODEOWNERS_FILE" ]; then
        echo "unknown"
        return
    fi

    # Simple pattern matching (this is a simplified version)
    # In a real scenario, you'd want more sophisticated parsing
    local owners=""

    # Check file against CODEOWNERS patterns
    while IFS= read -r line; do
        # Skip comments and empty lines
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        [[ -z "$line" ]] && continue

        # Extract pattern and owners
        pattern=$(echo "$line" | awk '{print $1}')
        owner=$(echo "$line" | awk '{for(i=2;i<=NF;i++) printf "%s ", $i; print ""}' | xargs)

        # Check if file matches pattern
        if [[ "$file" == $pattern ]] || [[ "$file" == *"$pattern"* ]]; then
            owners="$owner"
        fi
    done < "$CODEOWNERS_FILE"

    if [ -z "$owners" ]; then
        echo "unknown"
    else
        echo "$owners"
    fi
}

# Helper function to check if array contains value
array_contains() {
    local value="$1"
    shift
    local array=("$@")
    for item in "${array[@]}"; do
        if [ "$item" = "$value" ]; then
            return 0
        fi
    done
    return 1
}

# Apply changes and track
echo ""
echo -e "${GREEN}Applying changes:${NC}"
echo -e "${GREEN}========================================${NC}"

for file in "${SELECTED_FILES[@]}"; do
    add_comment "$file" "$TIMESTAMP"
    owners=$(get_owners "$file")

    # Add to OWNER_GROUPS if not already present
    if ! array_contains "$owners" "${OWNER_GROUPS[@]}"; then
        OWNER_GROUPS+=("$owners")
    fi

    echo -e "  ${BLUE}✓${NC} $file ${YELLOW}(${owners})${NC}"
done

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Summary:${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "  Branch: ${BLUE}${BRANCH_NAME}${NC}"
echo -e "  Files modified: ${BLUE}${NUM_FILES}${NC}"
echo -e "  Owner groups affected: ${BLUE}${#OWNER_GROUPS[@]}${NC}"
echo ""

# List affected owner groups
echo -e "${YELLOW}Affected ownership groups:${NC}"
for group in "${OWNER_GROUPS[@]}"; do
    echo -e "  ${BLUE}•${NC} $group"
done

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Next Steps:${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "1. Review changes: ${BLUE}git diff${NC}"
echo -e "2. Stage changes: ${BLUE}git add .${NC}"
echo -e "3. Commit: ${BLUE}git commit -m \"Test changes for codeowners-git\"${NC}"
echo -e "4. Test your codeowners-git tool"
echo -e "5. Cleanup: ${BLUE}git checkout main && git branch -D ${BRANCH_NAME}${NC}"
echo ""
