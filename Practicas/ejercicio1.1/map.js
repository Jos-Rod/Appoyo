
var db = firebase.firestore();

const tilesProvider = 'http://{s}.tile.stamen.com/toner/{z}/{x}/{y}.png';
//http://a.tile.stamen.com/toner/${z}/${x}/${y}.png
//https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png

let MapView = L.map('MapView').setView([21.152150, -101.711284], 13);
MapView.doubleClickZoom.disable();

var quantityPoints = 0;
var array = [];
var contador = 0;

L.tileLayer(tilesProvider, {
    maxZoom: 17,
}).addTo(MapView);

var newIcon = L.icon({
    iconUrl: 'location.png',
    iconSize: [60, 60],
    iconAnchor: [30, 60],
    popupAnchor: [-3, -76]
});
var newIcon2 = L.icon({
    iconUrl: 'location2.png',
    iconSize: [60, 60],
    iconAnchor: [30, 60],
    popupAnchor: [-3, -76]
});

MapView.on('dblclick', (e) => {
    contador ++;
    let latLng = MapView.mouseEventToLatLng(e.originalEvent);
    if (contador % 2 == 0){
        L.marker([latLng.lat, latLng.lng], {icon:newIcon}).addTo(MapView);

    }else{
        L.marker([latLng.lat, latLng.lng], {icon:newIcon2}).addTo(MapView);
    }
    
    


    

    array.push(latLng);
    
 

    if (array.length >= quantityPoints) {
        array.forEach(element => {
            db.collection("Puntos").add({
                lat: element.lat,
                lng: element.lng,
                
            })
            .then(function(docRef) {
                console.log("Document written with ID: ", docRef.id);
            })
            .catch(function(error) {
                console.error("Error adding document: ", error);
            });
            
        });
        var polygon = L.polygon(array).addTo(MapView);
        array = [];
    }

});

function realizarPoligono() {
    let n = document.getElementById('cantPuntos');
    quantityPoints = parseInt(n.value);
    n.value = '';
}