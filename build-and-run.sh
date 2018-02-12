#!/bin/bash

# settings
baseport="8080"

function buildandrun(){
   fn=${1}
   port=${2}
   suffix=$(echo ${fn} | grep -Po "[^_]+$")
   tag="rdmo_${suffix}"
   echo -e "\nBuilding ${tag}..."
   sudo docker build -t ${tag} -f ${fn} .
   sudo docker run -d \
     --publish ${port}:80 \
     --name ${tag} \
     ${tag}
}

# display selection menu
arr=($(find . -regex ".*\/dockerfile.*"))
echo -e "\nAvailable docker files..."
for ((i=0; i<${#arr[@]}; i++)); do
   echo -e "${i}\t${arr[${i}]}"
done
echo -e "a\tfor all of them"
echo ""
read -p "Which one do you want to build?   " input

# building
if [[ ${input} == "a" ]]; then
   for ((i=0; i<${#arr[@]}; i++)); do
      port=$(echo "scale=0; ${baseport}+${i}" | bc)
      buildandrun ${arr[${i}]} ${port}
   done
else
   buildandrun ${arr[${input}]} ${baseport}
fi

# feedback
if [[ "$?" == "0" ]]; then
   echo -e "\n\nFinished. Rdmo should be available at localhost:${port}.\n"
fi
