# Upgrade auf Debian 9 - Stretch

Debian 9 (Codename Stretch) wurde am 17. Juni 2017 veröffentlicht und ist der Nachfolger von Debian 8 (Codename Jessie).<br> [Debian 9 Release News](https://www.debian.org/News/2017/20170617)

Diese Anleitung beschreibt wie man die [angepasste Debian 8 Version](https://github.com/nisenbeck/ct-server-2016-jessie) für das NAS auf Debian 9 aktualisiert und auf den offiziellen Debian Kernel (4.9) wechselt.

**Wichtig: Alle Befehle müssen als root ausgeführt werden!**

**Hinweis:** Die angepasste "/etc/rc.local" macht auch unter Debian 9 Sinn (Stromsparen) und sollte nicht angepasst oder entfernt werden.

1.) Alle Fremdquellen auskommentieren:
```bash
sed -i 's/^\([^#].*\)/# \1/g' /etc/apt/sources.list.d/*
```

2.) Debian sources.list aktualisieren (jessie -> stretch):
```bash
sed -i "s/jessie/stretch/g" /etc/apt/sources.list
```
3.) Paketquellen aktualiseren und Debian upgraden:
```bash
apt-get update
apt-get upgrade
apt-get dist-upgrade
```
Details und weitere Informationen zum Debian Upgrade: [Debian 9 Release Notes](https://www.debian.org/releases/stable/i386/release-notes/ch-upgrading.de.html#minimal-upgrade)

4.) Auf den offiziellen Debian Kernel wechseln:
```bash
apt-get remove -y linux-image-amd64 && apt-get install -y linux-image-amd64
apt-get remove -y --purge 'linux*skylake'
```
4.) Neustart:
```bash
shutdown -r now
```
