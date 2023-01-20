#!/usr/bin/env bash

function inertia.symfony.react {
    symfony version > /dev/null 2>&1

    # Ensure that the Symfony Client is available...
    if [ $? -ne 0 ]; then
        echo "The Symfony Client must be installed!"

        exit 1
    fi

    git --version > /dev/null 2>&1

    # Ensure that git is available...
    if [ $? -ne 0 ]; then
        echo "git must be installed!"

        exit 1
    fi

    npm --version > /dev/null 2>&1

    # Ensure that npm is available...
    if [ $? -ne 0 ]; then
        echo "npm must be installed!"

        exit 1
    fi

    PROJECT_NAME=$1

    symfony new $PROJECT_NAME --webapp
    cd $PROJECT_NAME
    composer config --json extra.symfony.allow-contrib true
    composer require encore
    composer require rompetomp/inertia-bundle
    composer require friendsofsymfony/jsrouting-bundle
    mv templates/base.html.twig templates/app.html.twig
    git clone https://github.com/mercuryseries/inertia.symfony.react.git stubs
    composer require laravel/pint --dev
    cat ./stubs/stubs/pint.json > pint.json
    cat ./stubs/stubs/.prettierignore > .prettierignore
    cat ./stubs/stubs/prettier.config.js > prettier.config.js
    mkdir scripts
    cat ./stubs/stubs/format.sh > scripts/format.sh
    chmod +x scripts/format.sh
    cat ./stubs/stubs/app2.html.twig > templates/app.html.twig
    php -r "file_put_contents('templates/app.html.twig', str_replace('[TO_REPLACE]', ucwords(str_replace(['-', '_', '.'], ' ', '$PROJECT_NAME')), file_get_contents('templates/app.html.twig')));"
    cat ./stubs/stubs/webpack.config.js > webpack.config.js
    mkdir assets/img
    echo '' > assets/img/.gitignore
    mkdir assets/js
    mv assets/app.js assets/js/app.js
    mv assets/styles assets/css
    rm -r assets/{controllers,controllers.json,bootstrap.js}
    cat ./stubs/stubs/app2.js > assets/js/app.js
    cat ./stubs/stubs/package.json > package.json
    mkdir assets/js/shared
    touch assets/js/shared/Layout.js
    cat ./stubs/stubs/Layout2.js > assets/js/shared/Layout.js
    mkdir assets/js/pages
    rm -r stubs
    npm install --legacy-peer-deps
    bash scripts/format.sh
    npm run dev
    composer config --json extra.symfony.allow-contrib false
    git add -A
    git commit -m "Setup Inertia"

    WHITE='\033[1;37m'
    NC='\033[0m'

    echo -e "${WHITE}Thank you! We hope you build something incredible. Dive in with:${NC} cd $PROJECT_NAME && symfony serve -d && symfony open:local && npm run watch"
}

args=("$@")
inertia.symfony.react ${args[0]}
