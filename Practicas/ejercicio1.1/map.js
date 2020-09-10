const tilesProvider = 'http://{s}.tile.stamen.com/toner/{z}/{x}/{y}.png';
//http://a.tile.stamen.com/toner/${z}/${x}/${y}.png
//https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png

let MapView = L.map('MapView').setView([21.152150, -101.711284], 13);
MapView.doubleClickZoom.disable();

var quantityPoints = 0;
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

MapView.on('dblclick', (e) => {
    let latLng = MapView.mouseEventToLatLng(e.originalEvent);
    L.marker([latLng.lat, latLng.lng], {icon:newIcon}).addTo(MapView);

    array.push(latLng);

    if (array.length >= quantityPoints) {
        var polygon = L.polygon(array).addTo(MapView);
        array = [];
    }

});

function realizarPoligono() {
    let n = document.getElementById('cantPuntos');
    quantityPoints = parseInt(n.value);
    n.value = '';
}