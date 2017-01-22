# Supersparsamer Skylake Server mit Debian Jessie

Die Zeitschrift c't hat in Ausgabe 08/2016 (ab Seite 100) unter dem Titel "Wünsch Dir was Supersparsames -
Bauvorschlag für einen lüfterlosen und sparsamen Heim-Server" einen Bauvorschlag für einen super sparsamen Heimserver auf Skylake Basis veröffentlicht.

Dieser **Artikel** kann [hier](https://heise.de/-3151451) als PDF erworben werden.<br>
Eine **aktualisierte Teileliste** zum Nachbau habe ich bei bei [geizhals.de](https://geizhals.de/?cat=WL-718937) veröffentlicht.<br>
[Gesammelte Tipps / FAQ zu D3400 und D3417](FUJITSU-D34XX-FAQ.md).

## Stromverbrauch unter Linux
In der Einleitung heißt es:
> "Unsere Basiskonfiguration des Server-Bauvorschlags mit kleiner SSD und sparsamer 2,5"-Festplatte kommt bei ruhender Platte mit 8,7 Watt aus. **Mit Ubuntu 15.10 [...] sind es zwar 4,4 Watt und damit fast 50 Prozent mehr**, dafür spart man jedoch die 100 Euro teure Windows-Lizenz."

#### Fast 50 Prozent Mehrverbrauch unter Ubuntu/Linux? Das muss auch besser gehen!

Also los....

### Zutaten:

 * Die Hardware wie beschrieben (siehe Teileliste)
 * Debian 8 (Jessie)
 * Ein aktueller Kernel (derzeit 4.9.x)
 * Ein kleines Shellscript mit den Stromsparoptionen
 * Realtek Firmware


##### Ergebnis: 8,1 Watt<sup>[1](#stromverbrauch)</sup> :smiley:

### Zubereitung:

Arbeitszeit: ca. 90 Min. / Schwierigkeitsgrad: mittel
<br>**Wichtig: Alle Befehle müssen als root ausgeführt werden!**

1.) Die Hardware gemäß [Teileliste](https://geizhals.de/?cat=WL-718937) kaufen und zusammenbauen.

2.) [Debian 8 Firmware ISO](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/) herunterladen und installieren.
<br>Hinweis: Dank Firmware ISO funktioniert das Netzwerk bereits während der Installation!

3.) Repositories (Projekt und Debian Backports) hinzufügen:
```bash
apt-key adv --keyserver keys.gnupg.net --recv-keys 24BFF712

echo "deb http://ct-server-2016-jessie.tech-network.de jessie main" > /etc/apt/sources.list.d/ct-server-2016-jessie.list
echo "deb http://ftp.debian.org/debian jessie-backports main contrib non-free" > /etc/apt/sources.list.d/jessie-backports.list
```

4.) Auf Kernel 4.9.x upgraden:
```bash
aptitude update && aptitude upgrade
```

5.) Realtek Firmware installieren (Debian Backports):
```bash
aptitude -t jessie-backports install firmware-realtek
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
