#!/bin/bash

option_backend=0
option_module=0
option_docker=0
option_licence=0

# * 1 - Backend Runtime
options=("Node.js" "None")

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

# * 2 - Module Type
options=("CommonJS" "ESM")

echo "Please choose a module type:"
select opt in "${options[@]}"
do
    case $opt in
        "CommonJS")
            option_module=1
            break
            ;;
        "ESM")
            option_module=2
            break
            ;;
        *)
            echo "Invalid option. Try again."
            ;;
    esac
done

echo ""

# * 3 - Docker Integration

if [ $option_backend -eq 1 ]; then
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
else
    option_docker=2
fi

# * 4 - Licence

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

####################################################################################################################################
####################################################################################################################################
####################################################################################################################################

# Check for selection error

if [ $option_backend -eq 0 ] || [ $option_docker -eq 0 ] || [ $option_licence -eq 0 ] || [ $option_module -eq 0 ]; then
    echo "Error: No valid options selected."
    exit 1
fi

# * 1 - Remove backend
if [ $option_backend -eq 2 ]; then
    rm -rf backend/
else
    cp backend/.example.env backend/.env
fi

# * 2 - Set module type
if [ $option_module -eq 2 ]; then
    # ESM
    sed -i 's/"type": *"commonjs"/"type": "module"/' backend/package.json
    sed -i 's/"type": *"commonjs"/"type": "module"/' frontend/package.json
fi

# * 3 - Docker
if [ $option_docker -eq 1 ]; then
    rm backend/nodemon-local.json
else
    rm docker-compose.yaml
    rm backend/Dockerfile
    rm backend/nodemon.json
    mv backend/nodemon-local.json backend/nodemon.json
    sed -i 's|--legacy-watch --watch ./src --ext ts --exec '\''node --inspect=0.0.0.0:9229 --nolazy --loader ts-node/esm'\''|--watch ./src --ext ts --exec "node --inspect=9229 --nolazy --loader ts-node/esm"|' backend/package.json
fi

# TODO - Docker related files + Nodemon

# * 4 - Licence

case $option_licence in
    1)
        cp licences/MIT-LICENCE LICENCE
        if [ $option_backend -eq 1 ]; then
            sed -i 's/"license": *""/"license": "MIT"/' backend/package.json
        fi
        sed -i 's/"license": *""/"license": "MIT"/' frontend/package.json
        ;;
    2)
        cp licences/APACHE2.0-LICENCE LICENCE
        if [ $option_backend -eq 1 ]; then
            sed -i 's/"license": *""/"license": "Apache-2.0"/' backend/package.json
        fi
        sed -i 's/"license": *""/"license": "Apache-2.0"/' frontend/package.json
        ;;
    3)
        cp licences/GPL3.0-LICENCE LICENCE
        if [ $option_backend -eq 1 ]; then
            sed -i 's/"license": *""/"license": "GPL-3.0"/' backend/package.json
        fi
        sed -i 's/"license": *""/"license": "GPL-3.0"/' frontend/package.json
        ;;
    4)
        cp licences/LGPL3.0-LICENCE LICENCE
        if [ $option_backend -eq 1 ]; then
            sed -i 's/"license": *""/"license": "LGPL-3.0"/' backend/package.json
        fi
        sed -i 's/"license": *""/"license": "LGPL-3.0"/' frontend/package.json
        ;;
    5)
        cp licences/MPL2.0-LICENCE LICENCE
        if [ $option_backend -eq 1 ]; then
            sed -i 's/"license": *""/"license": "MPL-2.0"/' backend/package.json
        fi
        sed -i 's/"license": *""/"license": "MPL-2.0"/' frontend/package.json
        ;;
    6)
        touch LICENCE
        if [ $option_backend -eq 1 ]; then
            sed -i 's/"license": *""/"license": "UNLICENSED"/' backend/package.json
        fi
        sed -i 's/"license": *""/"license": "UNLICENSED"/' frontend/package.json
        ;;
    7)
        echo "No LICENCE file will be created."
        ;;
    *)
        echo "Unknown licence option."
        exit 1
        ;;
esac

rm -rf licences/

# * 5 - Install packages

cd backend
npm install
cd ../frontend
npm install
cd ..

echo "Setup completed!"
rm setup.sh
