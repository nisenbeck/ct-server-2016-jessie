# Kernel kompilieren - The Debian Way

**Wichtig:** Es gibt keinen Grund den Kernel selbst zu kompilieren, ich biete ein Repository mit aktuellen Kernel Versionen für die vorgestellte Hardware an. Für Details siehe [README](https://github.com/Bananian/ct-server-2016-jessie/blob/master/README.md).

Der Vollständigkeit halber nachfolgend eine stichwortartige Anleitung (am Beispiel 4.8.10) zum selber kompilieren:

**Hinweis: Lediglich zum Installieren (dpkg -i) benötigt man root-Rechte!**

1.) Build-Umgebung und Abhängigkeiten installieren:
```
aptitude install build-essential libssl-dev ncurses-dev libnl-3-dev libnl-genl-3-dev pkg-config libfile-fcntllock-perl
```

2.) Sourcecode herunterladen:
```
wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.8.10.tar.xz
```

3.) Entpacken und in das Verzeichnis wechseln:
```
tar -xaf linux-4.8.10.tar.xz
cd linux-4.8.10
```

4.) Konfiguration (.config) herunterladen und aktualisieren:
```
wget -O .config https://github.com/Bananian/ct-server-2016-jessie/raw/master/kernel/4.8/config/config 
make oldconfig
```

5.) Last but not least - Der Build:
```
make deb-pkg LOCALVERSION=-skylake KDEB_PKGVERSION=$(make kernelversion)-1
```
Anschließend findet man im übergeordneten Verzeichnis (```cd ..```) die Debian Kernel Pakete (linux-image-\*.deb, linux-firmware-image-\*.deb, linux-headers-\*.deb).

6.) Installieren:
```
dpkg -i linux-image-4.8.10-skylake_4.8.10-1_amd64.deb
```
