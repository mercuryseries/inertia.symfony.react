#!/usr/bin/env sh
echo "Formatting PHP Files"
./vendor/bin/pint

echo "Formatting JS Files"
npx prettier --write .
