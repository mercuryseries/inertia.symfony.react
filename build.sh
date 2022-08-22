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

    PROJECT_NAME=$1

    symfony new $PROJECT_NAME --webapp
    cd $PROJECT_NAME
    composer require encore
    composer require rompetomp/inertia-bundle
    mv templates/base.html.twig templates/app.html.twig
    git clone https://github.com/mercuryseries/inertia.symfony.react.git generator
    cat ./generator/stubs/app.html.twig > templates/app.html.twig
    cat ./generator/stubs/webpack.config.js > webpack.config.js
    mkdir assets/js
    mv assets/app.js assets/js/app.js
    mv assets/styles assets/css
    rm -r assets/{controllers,controllers.json,bootstrap.js}
    cat ./generator/stubs/app.js > assets/js/app.js
    symfony console make:controller pages --no-template
    cat ./generator/stubs/PagesController.php > src/Controller/PagesController.php
    cat ./generator/stubs/package.json > package.json
    mkdir assets/js/pages
    touch assets/js/pages/Home.js
    cat ./generator/stubs/Home.js > assets/js/pages/Home.js
    cat ./generator/stubs/About.js > assets/js/pages/About.js
    npm install --legacy-peer-deps
    npm run dev
    rm -r stubs

    WHITE='\033[1;37m'
    NC='\033[0m'

    echo -e "${WHITE}Thank you! We hope you build something incredible. Dive in with:${NC} cd $PROJECT_NAME && symfony serve -d && symfony open:local && npm run watch"
}

args=("$@")
inertia.symfony.react ${args[0]}
