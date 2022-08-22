#!/usr/bin/env bash

function inertia.symfony.react {
    symfony version > /dev/null 2>&1

    # Ensure that the Symfony Client is available...
    if [ $? -ne 0 ]; then
        echo "The Symfony Client must be installed!"

        exit 1
    fi

    node --version > /dev/null 2>&1

    # Ensure that npm is available...
    if [ $? -ne 0 ]; then
        echo "npm must be installed!"

        exit 1
    fi

    symfony new $1 --webapp
    cd $1
    composer require encore
    composer require rompetomp/inertia-bundle
    mv templates/base.html.twig templates/app.html.twig
    cat https://raw.githubusercontent.com/mercuryseries/inertia.symfony.react/main/stubs/app.html.twig > templates/app.html.twig
    cat https://raw.githubusercontent.com/mercuryseries/inertia.symfony.react/main/stubs/webpack.config.js > webpack.config.js
    mkdir assets/js
    mv assets/app.js assets/js/app.js
    mv assets/styles assets/css
    rm -r assets/{controllers,controllers.json,bootstrap.js}
    cat https://raw.githubusercontent.com/mercuryseries/inertia.symfony.react/main/stubs/app.js > assets/js/app.js
    symfony console make:controller pages --no-template
    cat https://raw.githubusercontent.com/mercuryseries/inertia.symfony.react/main/stubs/PagesController.php > src/Controller/PagesController.php
    cat https://raw.githubusercontent.com/mercuryseries/inertia.symfony.react/main/stubs/package.json > package.json
    mkdir assets/js/pages
    touch assets/js/pages/Home.js
    cat https://raw.githubusercontent.com/mercuryseries/inertia.symfony.react/main/stubs/Home.js > assets/js/pages/Home.js
    cat https://raw.githubusercontent.com/mercuryseries/inertia.symfony.react/main/stubs/About.js > assets/js/pages/About.js
    npm install --legacy-peer-deps
    npm run dev

    WHITE='\033[1;37m'
    NC='\033[0m'

    echo -e "${WHITE}Thank you! We hope you build something incredible. Dive in with:${NC} cd $1 && symfony serve -d && symfony open:local && npm run watch"
}

args=("$@")
inertia.symfony.react ${args[0]}
