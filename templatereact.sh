CLEAR="\e[0m"
BOLD="\e[1m"
YELLOW_BOLD="\e[1;33m"
YELLOW="\e[33m"
GREEN_BOLD="\e[1;32m"
GREEN="\e[32m"

echo  "${BOLD}Enter here the name of your ReactJS App : ${CLEAR}"
read appname
if [ -z "$appname" ] || [ -d "$appname" ]
then
	appname="react-app-"$(tr -dc 'a-f0-9' < /dev/urandom | head -c7)
        echo  "${YELLOW_BOLD}!${CLEAR}${YELLOW} '$appname' is set as your App's name ${CLEAR}"
fi
npm create vite@latest $appname -- --template react-ts
# npm create vite@latest $appname -- --template react-ts > '/dev/null' 2>&1
cd $appname
npm install
npm install tailwindcss postcss autoprefixer
npx tailwindcss init -p

echo "\n${BOLD}Setting up tailwindcss for you app ...${CLEAR}\n"

# Set up Tailwind's config file
sed -i "s/content: \[\],/content: [\n   '.index.html',\n '.\/src\/**\/*.{js,ts,jsx,tsx}',\n],/" tailwind.config.js

# Adding Tailwind directives to index.css
echo "@tailwind base;\n@tailwind components;\n@tailwind utilities;\n" > src/index.css

# Deleting Vite boilerplate code and testing TailwindCSS
echo "export default function App() {\n   return(\n      <h1 className='text-3xl font-bold underline'> Hello World! </h1>\n   );\n}" > src/App.tsx

rm src/App.css
echo  "${GREEN}✓${CLEAR}${GREEN_BOLD} App is set up and ready${CLEAR}\n"
