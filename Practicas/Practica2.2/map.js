const tilesProvider = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
//http://a.tile.stamen.com/toner/${z}/${x}/${y}.png
//https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png

let MapView = L.map('MapView').setView([21.152150, -101.711284], 13);
MapView.doubleClickZoom.disable();

var tilesArray = ["http://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png", "http://{s}.tile.stamen.com/watercolor/{z}/{x}/{y}.jpg", "http://{s}.tile.stamen.com/toner/{z}/{x}/{y}.png"];
var array = [];

L.tileLayer(tilesProvider, {
    maxZoom: 17,
}).addTo(MapView);

var newIcon = L.icon({
    iconUrl: 'location.png',
    iconSize: [60, 60],
    iconAnchor: [30, 60],
    popupAnchor: [-3, -76]
});
var inputIcon = L.icon({
    iconUrl: 'input.png',
    iconSize: [60, 60],
    iconAnchor: [30, 60],
    popupAnchor: [-3, -76]
});
var currentIcon = L.icon({
    iconUrl: 'red_dot.gif',
    iconSize: [60, 60],
    iconAnchor: [30, 60],
    popupAnchor: [-3, -76]
});
const iconsArray = [newIcon, inputIcon, currentIcon];
var count = 0;
var arrayItem = 0;
MapView.on('dblclick', (e) => {
    count++;
    if (count < 4) {
        arrayItem = 0;
    } else if (count < 7) {
        arrayItem = 1;
    } else if (count < 10) {
        arrayItem = 2;
    }
    if (count == 9) {
        count = 0;
    }
    let latLng = MapView.mouseEventToLatLng(e.originalEvent);
    L.marker([latLng.lat, latLng.lng], {icon: iconsArray[arrayItem]}).addTo(MapView);
    
});

function cambioDeTile() {
    const select = document.getElementById('selectTiles');
    console.log(select.value);

    L.tileLayer(select.value, {
        maxZoom: 17,
    }).addTo(MapView);
}

function reiniciar() {
    count = 0;
    MapView.eachLayer((layer) => {
        layer.remove();
    });
    L.tileLayer(tilesProvider, {
        maxZoom: 17,
    }).addTo(MapView);
}