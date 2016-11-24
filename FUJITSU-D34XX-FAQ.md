# Gesammelte Tipps / FAQ zu D3400 und D3417

Mit freundlicher Genehmigung von "juggernaut" aus dem [heise Forum](https://www.heise.de/forum/p-29433680/) übernommen, danke!

## RAM-Empfehlung
Original-Module von Micron, Samsung, Hynix. Achtung, speziell bei ECC-RAM: **Die CPUs unterstützen nur "Unbuffered" (nicht "Registered"!)**

ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Products/Mainboards/Industrial&ExtendedLifetime/D3402-B_D3417-B/Documentation/Specification/Skylake_Recommended_DDR4_Memory_Brands.pdf

Also quasi...

**Unbuffered Non-ECC:**<br>
http://www.heise.de/preisvergleich/?cat=ramddr3&xf=1126_Micron~1126_SK+Hynix~1126_Samsung~5828_DDR4~5830_UDIMM1~5831_DIMM

**Unbuffered ECC:**<br>
http://www.heise.de/preisvergleich/?cat=ramddr3&xf=1126_Micron~1126_SK+Hynix~1126_Samsung~5828_DDR4~5830_unbuffered+ECC+(UDIMM)~5831_DIMM

## Alternative Mainboardtypen
Es gibt diverse Varianten der Boards, die ähnlich dem lowest-End D3400 oder dem highest-End D3417 sind. Hier eine Übersicht:

**D3400** = 2 DIMM-Design H110 mit Realtek-LAN, 1x DP + DVI-D, Intel-Chipsatz-TPM 2.0, max. 65W-CPUs

**D3410** = wie D3400 aber B150: 2x DP +DVI-D, für 24/7 gedacht, 3 statt 2 unabhängige Monitore, 2x USB2 im IO-Shield mehr

**D3401** = 4 DIMM-Design Q150 mit Intel i219V LAN. Weitere Unterschiede gegenüber D3410: sparsamere Spannungswandler, m.2 mit 2 PCIe Lanes oder SATA3, 2 USB3 mehr im IO-Shield, LPT/Parallelport-Pfostenleiste onboard, mehr bzw. mit mehr Lanes belegte PCIe-Steckplätze, 5 SATA3 statt 4, Intel Standard Manageability möglich (außer Celeron CPUs), höherwertige Lüfterregelung (unter Anderem Linux-support über LM-Sensors)

**D3402** = Wie D3401 aber Q170, i219LM LAN (dadurch Treiber für Windows Server), onboard USB-Sockel für Stick, m.2 mit 4 PCIe-Lanes oder SATA3, SATA RAID möglich, Infineon TPM 2.0, volles iAMT und vPro 2015 möglich mit passender CPU, Hardware-Watchdogs für BIOS, POST und OS, 3 statt nur 2 Lüfteranschlüsse, PCH Heatsink, Längere Mainboard-Verfügbarkeit

**D3417** = wie D3402 aber C236, dadurch XEON und ECC-Unterstützung, bis zu 80W CPUs, 6 statt 5 SATA3, m.2 nur PCIe kein SATA, vPro nur mit XEON

#### Auswahltipps:

Wer kein ECC benötigt, dafür aber vPro auch mit billigeren CPUs (i5, i7) haben möchte, hier das Schwester-Mainboard der D3417 mit Q170-Chipsatz D3402-B: https://www.heise.de/preisvergleich/fujitsu-d3402-b-a1346654.html

Und noch billiger mit Q150-Chipsatz das D3401-B, aber immer noch 4 DIMMs: https://www.heise.de/preisvergleich/fujitsu-d3401-b-a1382666.html

Und das kleinere Board mit nur 2 DIMMS wie D3400-B, aber mit etwas höherwertigerem B150- Chipsatz (für 3 statt 2 unabhängige Displays) heißt D3410-B: https://www.heise.de/preisvergleich/fujitsu-d3410-b-a1377592.html

**M.2-SSD**<br>
Auf D3417 wird m.2 nur mit PCIe, nicht SATA unterstützt.

Folgende NVMe-Module sind nun von Fujitsu auf D3417 getestet und freigegeben. Achtung, gaaaanz genau auf die Bestellbezeichnungen achten!

**MZVPV128HDGM** http://www.heise.de/preisvergleich/samsung-ssd-sm951-nvme-128gb-mzvpv128hdgm-00000-a1301791.html

**MZVPV256HDGL** http://www.heise.de/preisvergleich/samsung-ssd-sm951-nvme-256gb-mzvpv256hdgl-00000-a1257077.html

**MZVPV512HDGL** http://www.heise.de/preisvergleich/samsung-ssd-sm951-nvme-512gb-mzvpv512hdgl-00000-a1257071.html

Andere NVMe-Module, auch vom selben Hersteller, laufen höchst wahrscheinlich nicht zuverlässig!

Siehe Approved m.2 modules hier (achtung, enthälkt auch SATA-Module für die Varianten D3401/D3402): ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Products/Mainboards/Industrial&ExtendedLifetime/D3402-B_D3417-B/Documentation/Specification/

## Netzteil
Es sollte ein aktuelles sein: es muss eine Minimallast von 0.05A auf 12V (12V1+12V2 zählen zusammen!) verkraften. So verlangt das auch Intel für Haswell und Skylake. Wenn Du das nicht im Datenblatt des Netzteils findest, nehm besser ein anderes, wo das gescheit dokumentiert ist. Sonst gibt es Symptome wie "wieder Einschalten nach dem Ausschalten" oder "An-Aus-Schleife beim Starten bis man CMOS-Batterie entfernt". Letzteres kann man eventuell ablindern indem man "Power Failure Recovery" auf "Disabled" stellt - aber lieber ein geeignetes Netzteil.

## Win7-Installation
Die uralten Win 7-Installationsmedien haben keine XHCI-USB-Treiber im Bauch. Skylake-Ccipsätze haben nur XHCI-Controller für USB, nicht mehr optional auch EHCI wie die Vorgänger. Du kannst diese also auf Skylake-Boards (die nur XHCI-Controller für USB haben) nicht so einfach über USB-Medien installieren. Am einfachsten nimm ein SATA-DVD-Laufwerk und PS/2 Keyboard&Maus. USB Keyboard&Maus kannst Du aber auch benutzen, wenn Du BIOS 1.11.0 oder neuer benutzt - da ist eine "PS/2-Emulation" eingebaut.

Fortgeschrittene können auch die XHCI-Treiber ins Installationsmedium reinpatchen, tool z.B. von AsRock: http://www.asrock.com.tw/microsite/Win7Install/

## Downloads

**BIOS**<br>
ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Products/Mainboards/ClassicDesktop/D3400_D3410/BIOS_D3400_D3410/BIOS_D3400-B/

ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Products/Mainboards/Industrial&ExtendedLifetime/D3402-B_D3417-B/BIOS/BIOS_D3417-B/

**Treiber**<br>
ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Products/Mainboards/ClassicDesktop/D3400_D3410/Drivers_D3400_D3410/

ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Products/Mainboards/Industrial&ExtendedLifetime/D3402-B_D3417-B/Drivers_D3402_D3417/

**Datenblätter incl. Netzteil-Anforderungen**<br>
ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Products/Mainboards/Industrial&ExtendedLifetime/D3402-B_D3417-B/Documentation/DS_D3417-B.pdf

ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Products/Mainboards/ClassicDesktop/D3400_D3410/Documentation/DS_D3400-B.pdf

**Kurz-Handbuch**<br>
ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Products/Mainboards/Industrial&ExtendedLifetime/D3402-B_D3417-B/Documentation/Manual_D3401_D3402_D3417.pdf

ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Products/Mainboards/ClassicDesktop/D3400_D3410/Documentation/FTS_Mainboard_D3400_D3410_Short_description.PDF

**Ausführlicheres Handbuch/Doku**<br>
Für D3417. Die Pinbelegungen von Features, die auch auf D3400 verfügbar sind, sind übertragbar:

ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Products/Mainboards/Industrial&ExtendedLifetime/D3402-B_D3417-B/Documentation/TechNotes/

**BIOS-Handbuch**<br>
ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Products/Mainboards/Industrial&ExtendedLifetime/D3402-B_D3417-B/Documentation/BIOS-Manual_Skylake-Desktop_GER.pdf

**AMT-Beschreibung**<br>
Beschreibung der möglichen Funktionen mit vPro, AMT11 und Standard Manageability, Beschreibung wie man in die MEBX kommt und wie das neu zu vergebende Passwort aussehen muss:

ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Products/Mainboards/Industrial&ExtendedLifetime/D3402-B_D3417-B/Documentation/Manual_iAMT11.pdf

**CPU-Kompatibilität**<br>
ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Services/Compatibility_CPU_x_Board/Compatibility_CPUxBoard.pdf

**Grafische KVM redirection über vPro/AMT im Headless-Betrieb**<br>
Ist auf D3417 mit vPro-fähiger CPU XEON mit integrierter Grafikeinheit möglich. Achtung, seit Skylake muss dazu ein Monitor angeschlossen sein, weil sonst die Grafik komplett deaktiviert wird. Für Headless-Betrieb muss man einige Umwege machen, eine Idee dazu hier: http://www.heise.de/forum/p-28698373/ + wie man die Widerstände einsteckt hier: https://rumorscity.com/2013/12/06/how-to-create-dummy-plugs-for-your-graphics-cards/

**Standard Manageability**<br>
D3417 + Nicht-XEON-CPU (außer Celeron und i7-K) = Intel Standard Manageability. Mit celeron kommt zwar immer mit CTRL-P die Meldung dass das Einstellungsmenü dafür "MEBX" aufgerufen würde, aber da Standard manageability mit Celeron nicht möglich ist kommt man nicht in das Menü.

**Sensoren auslesen unter Windows**<br>
Tool SystemGuard: ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Services/Software&Tools/Common-Mainboard-Tools/SystemGuard/

**Sensoren auslesen unter Linux**<br>
Nur für D3417: ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Services/Software&Tools/Linux_SystemMonitoring&Watchdog&GPIO/
