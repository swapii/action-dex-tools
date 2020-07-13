FROM adoptopenjdk/openjdk8:jdk8u252-b09-alpine-slim

RUN VERSION=2.0 && \
    FILE_NAME=dex-tools-${VERSION}.zip && \
    DIR=/opt/dex-tools && \
    FILE_PATH=$DIR/lib/$FILE_NAME && \
    FILE_URL=https://github.com/pxb1988/dex2jar/releases/download/${VERSION}/${FILE_NAME} && \
    apk add --no-cache curl && curl -L -o /opt/$FILE_NAME $FILE_URL && apk del curl && \
    apk add --no-cache unzip && unzip -d /opt/ /opt/$FILE_NAME && apk del unzip && rm /opt/$FILE_NAME && \
    mv /opt/dex2jar-$VERSION $DIR && \
    rm $DIR/*.bat && \
    chmod +x $DIR/*.sh && \
    mkdir -p /usr/local/bin/ && \
    for file in $(cd $DIR && ls *.sh); do echo $file && ln -s $DIR/$file /usr/local/bin/`echo $file | sed 's/.sh$//'`; done
