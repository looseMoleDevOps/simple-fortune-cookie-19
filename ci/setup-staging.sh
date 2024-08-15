DIR=./k8s-manifests/test
if [ ! -d "$DIR" ]; then
    pwd
    mkdir ./k8s-manifests/test
fi


cp -r ./k8s-manifests/backend/* ./k8s-manifests/test/
cp -r ./k8s-manifests/frontend/* ./k8s-manifests/test/

FILE=./k8s-manifests/redis
if [ -d "$FILE" ]; then
    echo "There is a redis folder."
    cp -r ./k8s-manifests/redis/* ./k8s-manifests/test/
fi

rm ./k8s-manifests/test/frontend-ingress.yml