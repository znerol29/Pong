# Remake des klassischen Spiels "Pong" von Atari (1972)
*Projekt für das Fach Informatik Klasse 11  
Steuerung des Hauptmenüs mit der Maus*

## Verwendung:
1. pong.pde in Processing öffnen
2. Ausführen
3. Ggf. für 1-Spieler-Modus die **Schwierigkeit** auswählen
4. **Spielmodus** auswählen

### Spieler vs Spieler:
- Linke Steuerung **W / A**
- Rechte Steuerung Pfeiltaste **Hoch / Runter**
- Ein Punkt wird erreicht, wenn der Gegner den Ball **nicht trifft** und dieser die rechte / linke Wand berührt
- Das Spiel endet nach **12 Punkten**

### Spieler vs Computer:
- Schwierigkeit begrenzt Geschwindikeit des Schlägers des Computers
- Der Spielmodus "Unendlich" hebt jegliche Begrenzung der Geschwindikeit auf (Computer bewegt sich schneller als Spieler)
- Der Spieler nutzt den **linken Schläger** (W / A)
- Ein Punkt wird erreicht, wenn der Gegner den Ball **nicht trifft** und dieser die rechte / linke Wand berührt
- Das Spiel endet nach **12 Punkten**

### Spieler vs Wand:
- Spieler kann gegen eine Wand spielen
- Jedes mal, wenn der **Schläger den Ball berührt**, wird ein Punkt erziehlt
- Der **Highscore** wird in den Projektdateien gespeichert
