# Supersparsamer Skylake Server mit Debian Jessie

Die Zeitschrift c't hat in Ausgabe 08/2016 (ab Seite 100) unter dem Titel "Wünsch Dir was Supersparsames -
Bauvorschlag für einen lüfterlosen und sparsamen Heim-Server" einen Bauvorschlag für einen super sparsamen Heimserver auf Skylake Basis veröffentlicht.

Dieser **Artikel** kann [hier](http://heise.de/-3151451) als PDF erworben werden.<br>
Eine **aktualisierte Teileliste** zum Nachbau habe ich bei bei [geizhals.de](http://geizhals.de/?cat=WL-718937) veröffentlicht.

## Stromverbrauch unter Linux
In der Einleitung heißt es:
> "Unsere Basiskonfiguration des Server-Bauvorschlags mit kleiner SSD und sparsamer 2,5"-Festplatte kommt bei ruhender Platte mit 8,7 Watt aus. **Mit Ubuntu 15.10 [...] sind es zwar 4,4 Watt und damit fast 50 Prozent mehr**, dafür spart man jedoch die 100 Euro teure Windows-Lizenz."

#### Fast 50 Prozent Mehrverbrauch unter Ubuntu/Linux? Das muss auch besser gehen!

Also los....

### Zutaten:

 * Die Hardware wie beschrieben (siehe Teileliste)
 * Debian 8 (Jessie)
 * Ein aktueller Kernel (derzeit 4.8.x)
 * Ein kleines Shellscript mit den Stromsparoptionen
 * Realtek und i915 Firmware


##### Ergebnis: 8,1 Watt<sup>[1](#stromverbrauch)</sup> :smiley:

### Zubereitung:

Arbeitszeit: ca. 90 Min. / Schwierigkeitsgrad: mittel

1.) Die Hardware gemäß [Teileliste](http://geizhals.de/?cat=WL-718937) kaufen und zusammenbauen.

2.) [Debian 8 Firmware ISO](http://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/8.6.0+nonfree/amd64/iso-cd/) herunterladen und installieren.
<br>Hinweis: Dank Firmware ISO funktioniert das Netzteil bereits während der Installation!

3.) Repositories (Projekt und Debian Backports) hinzufügen:
```bash
apt-key adv --keyserver keys.gnupg.net --recv-keys 24BFF712

echo "deb http://ct-server-2016-jessie.tech-network.de jessie main" > /etc/apt/sources.list.d/ct-server-2016-jessie.list
echo "deb http://ftp.debian.org/debian jessie-backports main contrib non-free" > /etc/apt/sources.list.d/jessie-backports.list
```

4.) Auf Kernel 4.8.x upgraden:
```bash
aptitude update && aptitude upgrade
```

5.) Realtek und i915 (Intel GPU) Firmware installieren (Debian Backports):
```bash
aptitude -t jessie-backports install firmware-misc-nonfree firmware-realtek
```

6.) Die "/etc/rc.local" ersetzen mit [dieser Datei](etc/rc.local):
```
wget -O /etc/rc.local https://raw.githubusercontent.com/Bananian/ct-server-2016-jessie/master/etc/rc.local
```
7.) Neustart
```bash
shutdown -r now
```

## TODO
* hdparm Konfiguration beschreiben

## Anmerkungen, Verbesserungsvorschläge, Merge Requests oder Fragen?
Immer her damit! Ich freue mich über jedes Feedback!

---
<a name="stromverbrauch">1</a>: Stromverbrauch im Idle, beide Festplatten im Standby, die SSD in Betrieb. Gemessen mit Brennenstuhl Primera-Line PM 231 E.
