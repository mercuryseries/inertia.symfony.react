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
    composer require twig-bundle encore serializer debug process
    composer require rompetomp/inertia-bundle
    composer require friendsofsymfony/jsrouting-bundle
    composer require maker --dev
    rm templates/base.html.twig
    git clone https://github.com/mercuryseries/inertia.symfony.react.git stubs
    composer require laravel/pint --dev
    cat ./stubs/stubs/pint.json > pint.json
    cat ./stubs/stubs/prettierignore-webpack > .prettierignore
    cat ./stubs/stubs/gitignore-webpack > .gitignore
    cat ./stubs/stubs/prettier.config.js > prettier.config.js
    mkdir scripts
    cat ./stubs/stubs/format.sh > scripts/format.sh
    chmod +x scripts/format.sh
    cat ./stubs/stubs/app-webpack.html.twig > templates/app.html.twig
    cat ./stubs/stubs/webpack.config.js > webpack.config.js
    mkdir assets/img
    echo '' > assets/img/.gitignore
    mkdir assets/js
    cat ./stubs/stubs/app.css > assets/styles/app.css
    rm -r assets/{app.js,bootstrap.js,controllers,controllers.json}
    cat ./stubs/stubs/app-webpack.js > assets/js/app.js
    cat ./stubs/stubs/ssr-webpack.js > assets/js/ssr.js
    php -r "file_put_contents('assets/js/app.js', str_replace('[TO_REPLACE]', ucwords(str_replace(['-', '_', '.'], ' ', '$PROJECT_NAME')), file_get_contents('assets/js/app.js')));"
    php -r "file_put_contents('assets/js/ssr.js', str_replace('[TO_REPLACE]', ucwords(str_replace(['-', '_', '.'], ' ', '$PROJECT_NAME')), file_get_contents('assets/js/ssr.js')));"
    symfony console make:controller pages --no-template
    cat ./stubs/stubs/PagesController.php > src/Controller/PagesController.php
    mkdir src/Command
    cat ./stubs/stubs/StartInertiaSsrCommand.php > src/Command/StartInertiaSsrCommand.php
    cat ./stubs/stubs/StopInertiaSsrCommand.php > src/Command/StopInertiaSsrCommand.php
    mkdir src/Service
    cat ./stubs/stubs/BundleDetector-webpack.php > src/Service/BundleDetector.php
    cat ./stubs/stubs/services-webpack.yaml > config/services.yaml
    cat ./stubs/stubs/rompetomp_inertia.yaml > config/packages/rompetomp_inertia.yaml
    cat ./stubs/stubs/webpack.ssr.config.js > webpack.ssr.config.js
    cat ./stubs/stubs/jsconfig.json > jsconfig.json
    cat ./stubs/stubs/package-webpack.json > package.json
    mkdir assets/js/components
    cat ./stubs/stubs/Layout-full-webpack.js > assets/js/components/Layout.js
    mkdir assets/js/pages
    cat ./stubs/stubs/Home-webpack.js > assets/js/pages/Home.js
    cat ./stubs/stubs/About-webpack.js > assets/js/pages/About.js
    rm -r stubs
    npm install --legacy-peer-deps
    bash scripts/format.sh
    npm run dev
    composer config --json extra.symfony.allow-contrib false
    git add -A
    git commit -m "Setup Inertia"
    symfony console cache:clear

    WHITE='\033[1;37m'
    NC='\033[0m'

    echo -e "${WHITE}Thank you! We hope you build something incredible. Dive in with:${NC} cd $PROJECT_NAME && symfony serve -d && symfony open:local && npm run watch"
}

args=("$@")
inertia.symfony.react ${args[0]}
