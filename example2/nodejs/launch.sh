#!/bin/bash

export IMAGE=eloycoto/nodeapp
export NAME=nodeapp
export RUN_OPTIONS="-h ${NAME} -p 3000:3000 --link redis_primary:redis_primary"

build(){
    echo "Build $IMAGE"
    docker build -t ${IMAGE} .
}

debug(){
   echo "Debug ${IMAGE}"
   echo "docker run --rm -t -i ${RUN_OPTIONS} ${IMAGE} /bin/bash"
   docker run -t -i ${IMAGE} /bin/bash
}

run(){
   echo "Run ${IMAGE}"
   docker kill ${NAME}
   docker rm ${NAME}
   local run_script="docker run -d ${RUN_OPTIONS} --name ${NAME} ${IMAGE}"
   echo "${run_script}"
   $run_script
}

kill_docker(){
   echo "kill ${IMAGE}"
   docker kill ${NAME}
}

usage(){
    echo "Usage: $0"
    echo "      -b: build image"
    echo "      -d: debug image with bash"
    echo "      -r: Run"
    echo "      -k: Kill"
    exit 1;
}

while getopts ":bhdrk" opt; do
    case $opt in
        b)
            build
            exit 1
            ;;
        d)
            debug
            exit 1
            ;;
        r)
            run
            exit 1
            ;;
        h)
            usage
            exit 1
            ;;
        k)
            kill_docker
            exit 1
            ;;
        \?)
            usage
            exit 1
            ;;
    esac
done

usage
