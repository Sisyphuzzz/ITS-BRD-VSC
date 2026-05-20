Analyse der Aufgabenstellung:

;* Schritt 1 Sieb bauen: 

;* zuerst werden im Speicherplatz 1000 Felder mit der Zahl 1 gefüllt
;* ein Algorythmus musserstellt werden, welcher alle Stellen im Speicher, die 
keine Primzahlen sind, mit dem Wert "0" überschreibt


;* Schritt 2 Ausleser bauen:

;* folglich muss ich ein Algorythmus erstellen, der im angelegten Speicher die
Adressen mit dem Wert "1" ausliest.
,* Dieser muss dann jeder Adresse, auf der eine 1 steht, die jeweilge Primzahl zuordnen.
;* Die bestimmten Primzahlen müssen schließlich in einen neu angelegten Speicher geschrieben werden
;* in dieser Speicheradresse stehen jetzt nacheinander in richtiger Reihenfolge die Werte, welche Primzaheln sind




Java Programm:

import java.util.Arrays;

public class PrimzahlSieb {
    public static void SucheundFinde (int[] Feld, int[] Primzahlen) {
    
    Feld[0] = 0;
    Feld[1] = 0;
    int y = -1;

    for (int all = 2; all < Feld.length; all++ ) {
        Feld[all] = 1;
    }
    for (int yes = 2; yes < Feld.length; yes++) {
        if (Feld[yes] == 1){
            for (int no = yes * yes; no < Feld.length; no = no + yes)
                Feld[no] = 0;
        } 
    }
        for (int yes = 2; yes < Feld.length; yes++) {
        if (Feld[yes] == 1) {
            if (y < 167) {
                Primzahlen[y = y + 1] = yes;
            }
        }
    }
    System.out.println(Arrays.toString(Feld));
    System.out.println(Arrays.toString(Primzahlen));
    }

    public static void main(String[] args){
        int[] Feld = new int[1001];
        int[] Primzahlen = new int [168];
        SucheundFinde(Feld,Primzahlen);
    }
}



   
Welche Felder und welcher Typ?:

Das Auslesefeld beliebig im Speicher angelegt:
1001 1 Byte Elemente, da nur mit 0 und 1 gearbeitet wird

Das Primzahlfeld wird an das Auslesefeld anschließend gelegt, 
damit dieses nicht überschrieben wird:
168 2 Byte Elemente, da die größten Primzahlen bis 1000 2 Byte speicherplatz benötigen