# Yocto container

## Build

```bash
docker build -t yocto_container:v1 .
```

## Usage

```bash
export YOCTO_WORKSPACE=path_to_your_yocto_workspace
docker run --rm --group-add sudo --group-add dev --device /dev/net/tun -v /etc/localtime:/etc/localtime:ro -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY --ipc=host -v $HOME/.ssh:/home/dev/.ssh --cap-add=NET_ADMIN -v $YOCTO_WORKSPACE:/home/dev/yocto_workspace --net=host -it yocto_container:v1 bash
# Download poky
git clone git://git.yoctoproject.org/poky -b kirkstone --depth 1
source  ./poky/oe-init-build-env build
bitbake core-image-minimal
runqemu
```
