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
        echo  "${YELLOW_BOLD}[!] '$appname' is set as your App's name ${CLEAR}"
fi

npm create vite@latest $appname -- --template react-ts > '/dev/null' 2>&1
projdir=$(readlink -f .)
echo "\n${BOLD}Scaffolding project in '${projdir}/$appname/'${CLEAR}\n${GREEN_BOLD}[✓] Done${CLEAR}\n"

# Installing dependencies
echo "\n${BOLD}Installing dependencies ...${CLEAR}"
cd $appname
npm install

# Installing and setting up Tailwind CSS
echo "\n\n${BOLD}Setting up tailwindcss for you app ...${CLEAR}"
npm install tailwindcss postcss autoprefixer
npx tailwindcss init -p

# Set up Tailwind's config file
sed -i "s/content: \[\],/content: [\n   '.index.html',\n '.\/src\/**\/*.{js,ts,jsx,tsx}',\n],/" tailwind.config.js

# Adding Tailwind directives to index.css
echo "@tailwind base;\n@tailwind components;\n@tailwind utilities;\n" > src/index.css

# Deleting Vite boilerplate code and testing TailwindCSS
echo "export default function App() {\n   return(\n      <h1 className='text-3xl font-bold underline'> Hello World! </h1>\n   );\n}" > src/App.tsx
rm src/App.css

echo  "\n\n${GREEN_BOLD}[✓] App is set up and ready${CLEAR}\n"
