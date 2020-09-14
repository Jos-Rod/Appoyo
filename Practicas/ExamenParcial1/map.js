const tilesProvider = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
//http://a.tile.stamen.com/toner/${z}/${x}/${y}.png
//https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png

let MapView = L.map('MapView').setView([21.152150, -101.711284], 13);
let MapView2 = L.map('MapView2').setView([21.152150, -101.711284], 13);
MapView.doubleClickZoom.disable();

var tilesArray = ["http://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png", "http://{s}.tile.stamen.com/watercolor/{z}/{x}/{y}.jpg", "http://{s}.tile.stamen.com/toner/{z}/{x}/{y}.png"];
var array = [];

L.tileLayer(tilesProvider, {
    maxZoom: 17,
}).addTo(MapView);
L.tileLayer(tilesProvider, {
    maxZoom: 17,
}).addTo(MapView2);

var newIcon = L.icon({
    iconUrl: 'location.png',
    iconSize: [60, 60],
    iconAnchor: [30, 60],
    popupAnchor: [-3, -76]
});

MapView.on('dblclick', (e) => {
    let latLng = MapView.mouseEventToLatLng(e.originalEvent);
    L.marker([latLng.lat, latLng.lng], {icon:newIcon}).addTo(MapView);

    array.push(latLng);

    if (array.length == 11) {
        L.polygon(array).addTo(MapView);
        array.forEach((e) => {
            L.marker([e.lat, e.lng], {icon:newIcon}).addTo(MapView2);
        });
        L.tileLayer(tilesArray[Math.floor(Math.random() * 3)], {
            maxZoom: 17,
        }).addTo(MapView);
        L.tileLayer(tilesArray[Math.floor(Math.random() * 3)], {
            maxZoom: 17,
        }).addTo(MapView2);
        alert("Coordenadas: " + array);
        array = [];
        document.getElementById('segundo').style.visibility = "visible";
    }

});