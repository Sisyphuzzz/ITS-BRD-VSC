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