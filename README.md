# mendix_build_image

docker build -t jmadro/dindpython -f "DinD-Dockerfile" .
docker build --build-arg WORKSPACE=appmendixsource -t jmadro/mendixpackage -f "mendixbuild-Dockerfile" .
docker run --privileged jmadro/mendixpackage