#!/bin/bash

# settings
baseport="8181"


function buildandrun(){
    fn=${1}
    port=${2}
    suffix=$(echo ${fn} | grep -Po "[^_]+$")
    tag="rdmo_${suffix}"
    echo -e "\nBuilding ${tag}..."
    sudo docker build -t ${tag} -f ${fn} .
    sudo docker run -d \
        --publish 127.0.0.1:${port}:80 \
        --name ${tag} \
        ${tag}
}

arr=($(find . -regex ".*\/dockerfile.*"))

# display selection menu or don't
if [[ "${1}" != "-b" ]]; then
echo -e "\nAvailable docker files..."
    for ((i=0; i<${#arr[@]}; i++)); do
        echo -e "${i}\t${arr[${i}]}"
    done
    echo -e "a\tfor all of them"
    echo ""
    read -p "Which one do you want to build?   " input
else
    input="${2}"
fi

# building
if [[ ${input} == "a" ]]; then
    for ((i=0; i<${#arr[@]}; i++)); do
        port=$(echo "scale=0; ${baseport}+${i}" | bc)
        buildandrun ${arr[${i}]} ${port}
    done
elif [[ "${input}" =~ ^dockerfile_ ]]; then
    buildandrun ${input} ${baseport}
else
    buildandrun ${arr[${input}]} ${baseport}
fi

# feedback
if [[ "$?" == "0" ]]; then
    echo -e "\n\nFinished. Rdmo should be available at localhost:${port}.\n"
fi
