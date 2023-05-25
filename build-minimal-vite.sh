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

    symfony new $PROJECT_NAME
    cd $PROJECT_NAME
    composer config --json extra.symfony.allow-contrib true
    composer require twig-bundle pentatrion/vite-bundle serializer debug process
    composer require rompetomp/inertia-bundle
    composer require friendsofsymfony/jsrouting-bundle
    mv templates/base.html.twig templates/app.html.twig
    git clone https://github.com/mercuryseries/inertia.symfony.react.git stubs
    composer require laravel/pint --dev
    cat ./stubs/stubs/pint.json > pint.json
    cat ./stubs/stubs/.prettierignore-vite > .prettierignore
    cat ./stubs/stubs/prettier.config.js > prettier.config.js
    mkdir scripts
    cat ./stubs/stubs/format.sh > scripts/format.sh
    chmod +x scripts/format.sh
    cat ./stubs/stubs/app-vite.html.twig > templates/app.html.twig
    cat ./stubs/stubs/vite.config.js > vite.config.js
    mkdir assets/img
    echo '' > assets/img/.gitignore
    mkdir assets/js
    rm -r assets/app.js
    mkdir assets/styles
    mv assets/app.css assets/styles/app.css
    cat ./stubs/stubs/app-vite.jsx > assets/js/app.jsx
    cat ./stubs/stubs/ssr-vite.jsx > assets/js/ssr.jsx
    php -r "file_put_contents('assets/js/app.jsx', str_replace('[TO_REPLACE]', ucwords(str_replace(['-', '_', '.'], ' ', '$PROJECT_NAME')), file_get_contents('assets/js/app.jsx')));"
    php -r "file_put_contents('assets/js/ssr.jsx', str_replace('[TO_REPLACE]', ucwords(str_replace(['-', '_', '.'], ' ', '$PROJECT_NAME')), file_get_contents('assets/js/ssr.jsx')));"
    mkdir src/Command
    # touch src/Command/StartInertiaSsrCommand.php
    # touch src/Command/StopInertiaSsrCommand.php
    cat ./stubs/stubs/StartInertiaSsrCommand.php > src/Command/StartInertiaSsrCommand.php
    cat ./stubs/stubs/StopInertiaSsrCommand.php > src/Command/StopInertiaSsrCommand.php
    mkdir src/Service
    # touch src/Service/BundleDetector.php
    cat ./stubs/stubs/BundleDetector.php > src/Service/BundleDetector.php
    cat ./stubs/stubs/services.yaml > config/services.yaml
    # touch config/packages/rompetomp_inertia.yaml
    cat ./stubs/stubs/rompetomp_inertia.yaml > config/packages/rompetomp_inertia.yaml
    cat ./stubs/stubs/jsconfig.json > jsconfig.json
    cat ./stubs/stubs/package-vite.json > package.json
    mkdir assets/js/components
    # touch assets/js/components/Layout.jsx
    cat ./stubs/stubs/Layout2-vite.jsx > assets/js/components/Layout.jsx
    mkdir assets/js/pages
    rm -r stubs
    npm install --legacy-peer-deps
    bash scripts/format.sh
    composer config --json extra.symfony.allow-contrib false
    git add -A
    git commit -m "Setup Inertia"

    WHITE='\033[1;37m'
    NC='\033[0m'

    echo -e "${WHITE}Thank you! We hope you build something incredible. Dive in with:${NC} cd $PROJECT_NAME && symfony serve -d && symfony open:local && npm run dev"
}

args=("$@")
inertia.symfony.react ${args[0]}
