Anw1: Hier wird die Speicheradresse von VariableA:0x2000000c in das Register gespeichert, um fortlaufend mit dieser Speicheradresse arbeiten zu können

Anw2: Hier wird das erste Byte aus der Speicheradresse VariableA mit dem Wert:0xef in das Register 2 gespeichert

Anw3: Hier wird das zweite Byte aus der Speicheradresse Variable A mit dem Wert 0xbe in das Register 3 gespeichert

Anw4: Mit diesem Befehl wird der Wert aus register 2 um 8 Bits (2 Bytes) nach links geschoben, wodurch sich der Wert von "0xef" zu "0xef00" vergrößert.

Anw5: Durch diesen Befehl werden die Binärwerte in Register 2 und Register3 abgeglichen und zusammengefügt und der neue Wert in Register 2 gechrieben

Anw6: Hier wird der neue Wert, der nun in Register 2 steht, wieder zurück in den Speicher an die Adresse 0x2000000c geladen und der alte Wert überschrieben, somit steht schließlich im Speicher "beef"   