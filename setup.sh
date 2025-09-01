#!/bin/bash

option_backend=0
option_module=0
option_docker=0
option_licence=0
option_commit=0
option_details=0

project_name=""
project_description=""
project_author=""
project_repo_url=""
project_keywords=""

commit_message="Initial commit"

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

echo ""

# * 5 - Add more information

options=(
  "Yes"
  "No"
)

echo "Add additional information for package.json?"
select opt in "${options[@]}"; do
    case $opt in
        "Yes")
            option_details=1
            break
            ;;
        "No")
            option_details=2
            break
            ;;
        *)
            echo "Invalid option. Please choose 1 or 2."
            ;;
    esac
done

echo ""

if [ $option_details -eq 1 ]; then
        echo "Enter project name:"
        read project_name
        echo "Enter project description:"
        read project_description
    if [ $option_licence -eq 1 ] || [ $option_licence -eq 2 ]; then
        while [ -z "$project_author" ]; do
            echo "Enter author name (required for license):"
            read project_author
        done
    else
        echo "Enter author name:"
        read project_author
    fi
        echo "Enter repository URL:"
        read project_repo_url
        echo "Enter keywords (comma-separated):"
        read project_keywords
    echo ""
fi

if [ $option_details -eq 2 ] && { [ $option_licence -eq 1 ] || [ $option_licence -eq 2 ]; }; then
    while [ -z "$project_author" ]; do
        echo "Enter author name (required for license):"
        read project_author
    done
    echo ""
fi

# * 6 - Commit changes

options=(
  "Yes"
  "No"
)

echo "Commit changes?"
select opt in "${options[@]}"; do
    case $opt in
        "Yes")
            option_commit=1
            break
            ;;
        "No")
            option_commit=2
            break
            ;;
        *)
            echo "Invalid option. Please choose 1 or 2."
            ;;
    esac
done

echo ""

# 6.2 Ask for commit message

if [ $option_commit -eq 1 ]; then
    echo "Enter commit message (Default: 'Initial commit'):"
    read custom_commit_message

    if [ -n "$custom_commit_message" ]; then
        commit_message="$custom_commit_message"
    fi
fi

####################################################################################################################################
####################################################################################################################################
####################################################################################################################################

# Check for selection error

if [ $option_backend -eq 0 ] || [ $option_docker -eq 0 ] || [ $option_licence -eq 0 ] || [ $option_module -eq 0 ] || [ $option_commit -eq 0 ]; then
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
    if [ $option_backend -eq 1 ]; then
        sed -i 's/"type": *"commonjs"/"type": "module"/' backend/package.json
    else
        sed -i 's/"type": *"commonjs"/"type": "module"/' frontend/package.json
    fi
fi

# * 3 - Docker
if [ $option_docker -eq 1 ]; then
    rm backend/nodemon-local.json
elif [ $option_backend -eq 1 ]; then
    rm docker-compose.yaml
    rm backend/Dockerfile
    rm backend/nodemon.json
    mv backend/nodemon-local.json backend/nodemon.json
    sed -i 's|--legacy-watch --watch ./src --ext ts --exec '\''node --inspect=0.0.0.0:9229 --nolazy --loader ts-node/esm'\''|--watch ./src --ext ts --exec node --inspect=9229 --nolazy --loader ts-node/esm|' backend/package.json
else
    rm docker-compose.yaml
fi

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

# * 6 - Add information
# Step 1 - package.json - Backend
if [ $option_backend -eq 1 ]; then
    file="backend/package.json"
    if [ -n "$project_name" ]; then
        sed -i "s/\"name\": *\"\"/\"name\": \"$(echo "$project_name" | sed 's/[&|]/\\&/g')-backend\"/" "$file"
        # Also handle case where name is not empty but default (e.g. "backend")
        sed -i "s/\"name\": *\"backend\"/\"name\": \"$(echo "$project_name" | sed 's/[&|]/\\&/g')-backend\"/" "$file"
    fi
    if [ -n "$project_description" ]; then
        sed -i "s/\"description\": *\"\"/\"description\": \"$(echo "$project_description" | sed 's/[&|]/\\&/g')\"/" "$file"
    fi
    if [ -n "$project_author" ]; then
        sed -i "s/\"author\": *\"\"/\"author\": \"$(echo "$project_author" | sed 's/[&|]/\\&/g')\"/" "$file"
    fi
    if [ -n "$project_repo_url" ]; then
        sed -i "s|\"url\": *\"\"|\"url\": \"$(echo "$project_repo_url" | sed 's/[&|]/\\&/g')\"|" "$file"
    fi
    if [ -n "$project_keywords" ]; then
        IFS=',' read -ra keywords_array <<< "$project_keywords"
        keywords_json=$(printf '"%s",' "${keywords_array[@]}")
        keywords_json="[${keywords_json%,}]"
        sed -i "s/\"keywords\": *\[\]/\"keywords\": $keywords_json/" "$file"
    fi
fi
# Step 2 - package.json - Frontend
file="frontend/package.json"
if [ -n "$project_name" ]; then
    sed -i "s/\"name\": *\"\"/\"name\": \"$(echo "$project_name" | sed 's/[&|]/\\&/g')-frontend\"/" "$file"
    # Also handle case where name is not empty but default (e.g. "frontend")
    sed -i "s/\"name\": *\"frontend\"/\"name\": \"$(echo "$project_name" | sed 's/[&|]/\\&/g')-frontend\"/" "$file"
fi
if [ -n "$project_description" ]; then
    sed -i "s/\"description\": *\"\"/\"description\": \"$(echo "$project_description" | sed 's/[&|]/\\&/g')\"/" "$file"
fi
if [ -n "$project_author" ]; then
    sed -i "s/\"author\": *\"\"/\"author\": \"$(echo "$project_author" | sed 's/[&|]/\\&/g')\"/" "$file"
fi
if [ -n "$project_repo_url" ]; then
    sed -i "s|\"url\": *\"\"|\"url\": \"$(echo "$project_repo_url" | sed 's/[&|]/\\&/g')\"|" "$file"
fi
if [ -n "$project_keywords" ]; then
    IFS=',' read -ra keywords_array <<< "$project_keywords"
    keywords_json=$(printf '"%s",' "${keywords_array[@]}")
    keywords_json="[${keywords_json%,}]"
    sed -i "s/\"keywords\": *\[\]/\"keywords\": $keywords_json/" "$file"
fi

# Step 3 - licence
# TODO - Support all Unix based systems (MacOS)
year=$(date +%Y)
file="LICENCE"
if [ $option_licence -eq 1 ]; then
    repl=$(printf 'Copyright (c) %s %s' "$year" "$project_author" | sed 's/[&|]/\\&/g')
    sed -i "3{/^Copyright (c) \[year\] \[fullname\]$/s||$repl|}" "$file"
elif [ $option_licence -eq 2 ]; then
    repl=$(printf 'Copyright %s %s' "$year" "$project_author" | sed 's/[&|]/\\&/g')
    sed -i "189s|^\([[:space:]]*\).*|\1$repl|" "$file"
fi

# * 7 - Install packages
if [ $option_backend -eq 1 ]; then
    cd backend
    npm install
    cd ..
fi

cd frontend
npm install
cd ..

# * 8 - Move frontend directory files up, if no backend exists
if [ $option_backend -eq 2 ]; then
    mv frontend/* .
    rmdir frontend
fi

# * 9 - Commit changes
if [ $option_commit -eq 1 ]; then
    git add .
    git commit -m "$commit_message"
fi

echo "Setup completed!"
rm setup.sh
