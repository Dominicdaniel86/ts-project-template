#!/bin/bash

# * 1 - Backend Runtime

options=("Node.js" "None")

option_backend=0
option_docker=0
option_licence=0

echo "Please choose a backend runtime:"
select opt in "${options[@]}"
do
    case $opt in
        "Node.js")
            option_backend=1
            break
            ;;
        "None")
            option_backend=2
            break
            ;;
        *)
            echo "Invalid option. Try again."
            ;;
    esac
done

echo ""

# * 2 - Docker Integration

# TODO: Only ask this, if backend = YES

options=("yes" "no")

echo "Enable Docker integration?"
select opt in "${options[@]}"
do
    case $opt in
        "yes")
            echo "Docker integration enabled."
            option_docker=1
            break
            ;;
        "no")
            echo "Docker integration disabled."
            option_docker=2
            break
            ;;
        *)
            echo "Invalid option. Please choose 1 or 2."
            ;;
    esac
done

echo ""

# * 3 - Licence

options=(
  "MIT"
  "Apache-2.0"
  "GPL-3.0"
  "LGPL-3.0"
  "MPL-2.0"
  "Custom Licence"
  "No Licence"
)

echo "Choose a license:"
select opt in "${options[@]}"; do
    case $opt in
        "MIT")
            option_licence=1
            break
            ;;
        "Apache-2.0")
            option_licence=2
            break
            ;;
        "GPL-3.0")
            option_licence=3
            break
            ;;
        "LGPL-3.0")
            option_licence=4
            break
            ;;
        "MPL-2.0")
            option_licence=5
            break
            ;;
        "Custom Licence")
            option_licence=6
            break
            ;;
        "No Licence")
            option_licence=7
            break
            ;;
        *)
            echo "Invalid option. Please choose a number from the list."
            ;;
    esac
done

# Check for selection error

if [ $option_backend -eq 0 ] && [ $option_docker -eq 0 ] && [ $option_licence -eq 0 ]; then
    echo "Error: No valid options selected."
    exit 1
fi

# Remove backend

if [ $option_backend -eq 2 ]; then
    rm -rf backend/
fi

# Docker

# TODO - Docker related files + Nodemon

# Licence

case $option_licence in
    1)
        cp licences/MIT-LICENCE.md LICENCE
        ;;
    2)
        cp licences/Apache-2.0-LICENCE.md LICENCE
        ;;
    3)
        cp licences/GPL-3.0-LICENCE.md LICENCE
        ;;
    4)
        cp licences/LGPL-3.0-LICENCE.md LICENCE
        ;;
    5)
        cp licences/MPL-2.0-LICENCE.md LICENCE
        ;;
    6)
        touch LICENCE
        ;;
    7)
        echo "No LICENCE file will be created."
        ;;
    *)
        echo "Unknown licence option."
        exit 1
        ;;
esac

echo "Setup completed!"

rm -rf /licences/
rm setup.sh
