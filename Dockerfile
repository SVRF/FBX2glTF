FROM node:carbon-stretch

RUN apt-get update && apt upgrade -y && apt-get install -y build-essential cmake git

# NOTE, you're agreeing to the FBX SDK terms
COPY sdk/fbx20181_1_fbxsdk_linux.tar.gz /tmp/fbxsdk.tar.gz
RUN tar -xf /tmp/fbxsdk.tar.gz -C /tmp \
    && yes yes | /tmp/fbx20181_1_fbxsdk_linux /usr > /dev/null \
    && rm /tmp/*

COPY . /tmp/FBX2glTF

# Build and pack FBX2gltf npm package
RUN cd /tmp/FBX2glTF \
    && cmake -H. -Bbuild -DCMAKE_BUILD_TYPE=Release \
    && make -Cbuild -j8 \
    && cp /tmp/FBX2glTF/build/FBX2glTF /tmp/FBX2glTF/npm/bin/Linux/FBX2glTF \
    && cd /tmp/FBX2glTF/npm \
    && npm pack
