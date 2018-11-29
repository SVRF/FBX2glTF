#/bin/sh

if [[ ! -f ./sdk/fbx20181_1_fbxsdk_linux.tar.gz ]]; then
  mkdir -p sdk
  wget http://download.autodesk.com/us/fbx/2018/2018.1.1/fbx20181_1_fbxsdk_linux.tar.gz \
       -O ./sdk/fbx20181_1_fbxsdk_linux.tar.gz
fi

# build the npm package
docker build -f ./Dockerfile -t fbx2gltf-builder:latest .

# copy it to the local artifacts folder
docker run --rm -v "$(pwd)/artifacts:/tmp/artifacts" fbx2gltf-builder:latest sh -c "cp /tmp/FBX2glTF/npm/*.tgz /tmp/artifacts"

# echo where the new package lives
echo "built $(pwd)/$(find artifacts -name "fbx2gltf*.tgz" | tail -n 1)"
