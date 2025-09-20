#!/bin/bash

# Module Initialization Script for InfoTech.io Platform
# This script helps set up a new educational module from the template

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_info() {
    echo -e "${BLUE}ℹ INFO:${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓ SUCCESS:${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠ WARNING:${NC} $1"
}

print_error() {
    echo -e "${RED}✗ ERROR:${NC} $1"
}

# Check if required tools are available
check_dependencies() {
    print_info "Checking dependencies..."

    if ! command -v git &> /dev/null; then
        print_error "git is required but not installed"
        exit 1
    fi

    if ! command -v node &> /dev/null; then
        print_warning "node.js not found - validation will be skipped"
    fi

    print_success "Dependencies check completed"
}

# Get user input
get_module_info() {
    print_info "Setting up new module configuration..."
    echo

    # Module name
    while true; do
        read -p "Module name (kebab-case, e.g., 'python-basics'): " MODULE_NAME
        if [[ $MODULE_NAME =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
            break
        else
            print_error "Invalid format. Use only lowercase letters, numbers, and hyphens"
        fi
    done

    # Module title
    read -p "Module title (e.g., 'Основы Python'): " MODULE_TITLE

    # Module description
    read -p "Module description (20-500 characters): " MODULE_DESCRIPTION

    # Author
    read -p "Author name: " AUTHOR_NAME

    # Difficulty
    echo "Select difficulty level:"
    echo "1) beginner"
    echo "2) intermediate"
    echo "3) advanced"
    echo "4) expert"
    read -p "Choose (1-4): " DIFFICULTY_CHOICE

    case $DIFFICULTY_CHOICE in
        1) DIFFICULTY="beginner" ;;
        2) DIFFICULTY="intermediate" ;;
        3) DIFFICULTY="advanced" ;;
        4) DIFFICULTY="expert" ;;
        *) DIFFICULTY="beginner" ;;
    esac

    # Estimated time
    read -p "Estimated completion time (e.g., '30 hours'): " ESTIMATED_TIME

    # Tags
    read -p "Tags (comma-separated, e.g., 'python,programming,beginner'): " TAGS_INPUT

    # Convert module name to different formats
    MODULE_NAME_UNDERSCORE=${MODULE_NAME//-/_}

    # Convert tags
    IFS=',' read -ra TAGS_ARRAY <<< "$TAGS_INPUT"
    TAG1=${TAGS_ARRAY[0]:-"tag1"}
    TAG2=${TAGS_ARRAY[1]:-"tag2"}
    TAG3=${TAGS_ARRAY[2]:-"tag3"}

    print_success "Module information collected"
}

# Replace placeholders in module.json
update_module_json() {
    print_info "Updating module.json..."

    local current_date=$(date +%Y-%m-%d)

    # Create backup
    cp module.json module.json.backup

    # Replace placeholders
    sed -i "s/{{MODULE_NAME}}/$MODULE_NAME/g" module.json
    sed -i "s/{{MODULE_TITLE}}/$MODULE_TITLE/g" module.json
    sed -i "s/{{MODULE_DESCRIPTION}}/$MODULE_DESCRIPTION/g" module.json
    sed -i "s/{{MODULE_NAME_UNDERSCORE}}/$MODULE_NAME_UNDERSCORE/g" module.json
    sed -i "s/{{DIFFICULTY}}/$DIFFICULTY/g" module.json
    sed -i "s/{{ESTIMATED_TIME}}/$ESTIMATED_TIME/g" module.json
    sed -i "s/{{TAG1}}/$TAG1/g" module.json
    sed -i "s/{{TAG2}}/$TAG2/g" module.json
    sed -i "s/{{TAG3}}/$TAG3/g" module.json
    sed -i "s/{{CURRENT_DATE}}/$current_date/g" module.json

    # Replace author placeholder in the description if using InfoTech.io Team
    if [[ "$AUTHOR_NAME" != "InfoTech.io Team" ]]; then
        sed -i "s/InfoTech.io Team/$AUTHOR_NAME/g" module.json
    fi

    print_success "module.json updated"
}

# Validate module.json
validate_module() {
    print_info "Validating module.json..."

    if command -v node &> /dev/null; then
        # Try to find validation script
        if [[ -f "../../infotecha/scripts/validate-module.js" ]]; then
            if node ../../infotecha/scripts/validate-module.js module.json; then
                print_success "Module validation passed"
            else
                print_error "Module validation failed"
                return 1
            fi
        else
            print_warning "Validation script not found - manual validation recommended"
        fi
    else
        print_warning "Node.js not available - skipping validation"
    fi
}

# Update README.md
update_readme() {
    print_info "Updating README.md..."

    if [[ -f "README.md" ]]; then
        # Create backup
        cp README.md README.md.backup

        # Update README with module information
        sed -i "s/# Module Template/# $MODULE_TITLE/g" README.md
        sed -i "s/This is a template/This module: $MODULE_DESCRIPTION/g" README.md

        print_success "README.md updated"
    fi
}

# Clean up template files
cleanup_template_files() {
    print_info "Cleaning up template files..."

    # Remove script itself after use
    rm -f scripts/init-module.sh

    # Remove backup files
    rm -f module.json.backup
    rm -f README.md.backup

    print_success "Template files cleaned up"
}

# Main function
main() {
    echo "================================================================"
    echo "          InfoTech.io Module Initialization Script"
    echo "================================================================"
    echo

    check_dependencies
    get_module_info
    update_module_json

    if validate_module; then
        update_readme

        echo
        print_success "Module initialization completed!"
        echo
        print_info "Next steps:"
        echo "  1. Review and test module.json"
        echo "  2. Update content/ directory with your educational materials"
        echo "  3. Commit and push to your repository"
        echo "  4. The module will be automatically discovered by the platform"
        echo
        print_info "Module URLs:"
        echo "  Production: https://$MODULE_NAME.infotecha.ru"
        echo "  Repository: https://github.com/info-tech-io/mod_$MODULE_NAME_UNDERSCORE"
        echo

        # Ask about cleanup
        read -p "Remove template initialization files? (y/N): " CLEANUP_CHOICE
        if [[ $CLEANUP_CHOICE =~ ^[Yy]$ ]]; then
            cleanup_template_files
        fi

    else
        print_error "Initialization failed due to validation errors"
        print_info "Please fix the issues and run the script again"
        exit 1
    fi
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi