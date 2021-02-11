# Geofence Test
A pályázott iOS fejlesztői pozícióval kapcsolatos project SwiftUI-ban


## Leírás

### 1. Model
- a mentésért és az adatok betöltéséért felel
- először betölti az adatokat tartalmazó json file-t a Bundle-ből, majd ezt elment az alkalmazás dokumentumai közé, hogy a változtatások megmaradjanak az app bezárása után is
- a zoomValue tartja a kívánt span értékét, amit az edit view-ban a gombokkal lehet állítani (illetve a radius módosításával) -> a térkép is ezt használja a span meghatározásához
- a location object alarm value computed properti-je bool-ra fordítja az adott integer értékeket

### 2. View
#### GeofenceListView
- showEditView flag esetés a frame oldalra animál
- medgjeleníti a GeofenceEditView-t
- lista megjelenítése, adatok statusát mutatja
- lista elem választása tap gesture recognizer-rel
- érintés esetén a model data classban frissíti az ideiglenes helyzetet (tempLocation)

#### GeofenceListView
- mentésre csak a mentés gombra kattintva kerül sor, előtte az adatok listájától külön kezeljük a megjelenített elemet
- mentés esetén a model data shouldSaveChanges flagjét állítjuk, amivel meghívjuk a saveChanges funkciót -> ez elmenti az ideiglenes elemet a megjelenített elemek közé

#### GeofenceListView
a ContentView megjeleníti a MapController-t, majd erre modal presentation-nel megnyitja a második réteget a context fölé, hogy látható maradjon alatta a térkép

## Hibák
- MapView map circle view overlay nem vált nagyítás / kicsinyítés esetén
- readius váltásánál ugrik egyet a circle view overlay