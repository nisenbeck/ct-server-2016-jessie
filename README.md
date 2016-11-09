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

* Die Hardware gemäß Teileliste kaufen und zusammenbauen.
* Debian 8 herunterladen und installieren.<br>**Tipp:** Die inofizielle [Firmware ISO](http://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/8.6.0+nonfree/amd64/iso-cd/) verwenden, damit das Netzwerk direkt bei der Installation funktioniert.
* Kernel 4.8.x installieren:
```bash
wget https://github.com/Bananian/ct-server-2016-jessie/raw/master/deb/linux-image-4.8.6-skylake_4.8.6-1_amd64.deb
dpkg -i linux-image-4.8.6-skylake_4.8.6-1_amd64.deb
``` 
* Die "/etc/rc.local" ersetzen mit [dieser Datei](etc/rc.local)
* Realtek und i915 Firmware installieren (Debian Backports):
```bash
echo "deb http://ftp.debian.org/debian jessie-backports main contrib non-free" > /etc/apt/sources.list.d/jessie-backports.list
aptitude update && aptitude -t jessie-backports install firmware-misc-nonfree firmware-realtek
```
* Neustart

## TODO
* Repository aufsetzen
* hdparm Konfiguration beschreiben

---
<a name="stromverbrauch">1</a>: Stromverbrauch im Idle, beide Festplatten im Standby, die SSD in Betrieb. Gemessen mit Brennenstuhl Primera-Line PM 231 E.
