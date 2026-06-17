Projekt: Stoppuhr 
Dieses Repository enthält die Implementierung einer digitalen Stoppuhr in Assembler.

1. Aufgabenanalyse & Anforderungen

Zentrale Funktionalität:
Das System implementiert eine Stoppuhr, deren gemessene Zeit auf dem TFT-Display ausgegeben wird.  

Die Anzeige auf dem Display erfolgt im Format mm:ss.nn mit einer Darstellungsauflösung von 1/100 Sekunde.  


Taster:
Die Steuerung des Zustandsautomaten erfolgt über drei Taster:  

Taster S7: Startet die Stoppuhr aus dem Initialisierungszustand bzw. setzt die Anzeige nach einer Pause fort.  0x7f

Taster S6: Friert die aktuelle Zeitanzeige ein (Hold-Funktion).  

Taster S5: Setzt die Uhrzeit zurück und führt das System in den Ausgangszustand.  

LEDs:
Zwei LEDs signalisieren den aktuellen Betriebszustand des Systems:  

LED D8 (Bit 0): Leuchtet permanent, solange eine Zeitmessung aktiv läuft (Zustände RUNNING und HOLD).  

LED D9 (Bit 1): Leuchtet, wenn die Anzeige auf dem Display eingefroren wurde (Zustand HOLD).  

2. Zustandsautomat
Die Software wird als Zustandsautomat mit drei Betriebszuständen realisiert:  

INIT:  
Die Uhrzeit ist komplett zurückgesetzt.

LED D8:AUS  
LED D9:AUS  

Zeigt statisch "00:00.00". 


RUNNING:
Die Zeit läuft kontinuierlich im Vordergrund und wird live hochgezählt. 

LED D8:AN  
LED D9:AUS  

Laufende Anzeige im Format "mm:ss.nn". 


HOLD:  
Die Zeitanzeige wird eingefroren, um Zwischenzeiten abzulesen. Im Hintergrund läuft die Zeitmessung ununterbrochen weiter.

LED D8:AN  
LED D9:AN  

Anzeige bleibt auf dem historischen Stopp-Zeitpunkt stehen. 


3. Zentrale Funktionen
das Programm wird in überschaubare Unterprogramme vereinfacht.

main (Super-Loop): Bildet die zentrale while - schleife des Systems. Sie steuert zyklisch die Abfolge aus Zeitaktualisierung, Tasterabfrage, Zustandsautomat-Update, LED-Ansteuerung und Display-Refresh.  


checktimer: Liest den aktuellen Hardware-Zeitstempel aus dem TIMER-Register aus. Durch Subtraktion des vorherigen Zeitstempels wird die Differenz berechnet und zur Gesamtzeit addiert.  


displaytime: Liest die Zeit aus, wandelt die Zeit, die in mikrosekunden hochläuft unter Berücksichtigung von 60-Sekunden-Minuten in Ziffern um und bringt sie zur Anzeige.  