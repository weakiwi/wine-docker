FROM oott123/novnc:v0.1.1

COPY winhttp_2ksp4.verb coolq.reg luna.msstyles /tmp/
COPY vncmain.sh /app/vncmain.sh
COPY cq /usr/local/bin/cq
COPY cont-init.d /etc/cont-init.d/

RUN apt-get update && \
    apt-get install -y --allow-unauthenticated \
        software-properties-common apt-transport-https \
        cabextract unzip python-numpy \
	fcitx \
	dbus-x11 \
        language-pack-zh-hans tzdata ttf-wqy-microhei && \
    wget -nc https://dl.winehq.org/wine-builds/Release.key -O /tmp/wine.key && \
    apt-key add /tmp/wine.key && rm -f /tmp/wine.key && \
    apt-add-repository -y https://dl.winehq.org/wine-builds/ubuntu && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --allow-unauthenticated --install-recommends winehq-devel && \
    wget -O /usr/local/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && \
    wget -O /tmp/sogoupinyin.deb "http://cdn2.ime.sogou.com/dl/index/1524572264/sogoupinyin_2.2.0.0108_amd64.deb?st=xsrCq3KnDFSBPurJc7ThBQ&e=1563697777&fn=sogoupinyin_2.2.0.0108_amd64.deb" && \
    chmod 755 /usr/local/bin/winetricks && \
    dpkg --force-all -i /tmp/sogoupinyin.deb && \
    apt -f install -y && \
    rm -rf /tmp/sogoupinyin.deb && \
    apt-get clean && \
    chsh -s /bin/bash user && \
    rm -rf /var/lib/apt/lists && \
    sudo -Hu user WINEARCH=win32 /usr/bin/wine wineboot && \
    sudo -Hu user mkdir -p /home/user/.wine/drive_c/windows/Resources/Themes/luna/ && \
    sudo -Hu user cp /tmp/luna.msstyles /home/user/.wine/drive_c/windows/Resources/Themes/luna/luna.msstyles && \
    sudo -Hu user /usr/bin/wine regedit.exe /s /tmp/coolq.reg && \
    sudo -Hu user wineboot && \
    echo 'quiet=on' > /etc/wgetrc && \
    sudo -Hu user /usr/local/bin/winetricks -q win7 && \
    sudo -Hu user /usr/local/bin/winetricks -q /tmp/winhttp_2ksp4.verb && \
    sudo -Hu user /usr/local/bin/winetricks -q msscript && \
    sudo -Hu user /usr/local/bin/winetricks -q fontsmooth=rgb && \
    wget https://dlsec.cqp.me/docker-simsun -O /tmp/simsun.zip && \
    rm /etc/wgetrc && \
    mkdir -p /home/user/.wine/drive_c/windows/Fonts && \
    unzip /tmp/simsun.zip -d /home/user/.wine/drive_c/windows/Fonts && \
    rm -f /tmp/simsun.zip && \
    mkdir /home/user/coolq && \
    rm -rf /home/user/.cache/winetricks

ENV LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    TZ=Asia/Shanghai \
    COOLQ_URL=http://www.haoxg.net/ediary/download/ediary-3.3.6-copy.zip \
    XMODIFIERS=@im=fcitx \
    GTK_IM_MODULE=fcitx \
    QT_IM_MODULE=fcitx \
    XMODIFIERS=@im=fcitx\
    DISPLAY=:11 

VOLUME ["/home/user/coolq"]
