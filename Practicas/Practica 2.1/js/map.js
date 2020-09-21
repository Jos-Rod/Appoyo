
var db = firebase.firestore();

const tilesProvider = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
//http://a.tile.stamen.com/toner/${z}/${x}/${y}.png
//https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png

let MapView = L.map('MapView').setView([21.152150, -101.711284], 13);

L.tileLayer(tilesProvider, {
    maxZoom: 17,
}).addTo(MapView);

var newIcon = L.icon({
    iconUrl: 'location.png',
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

navigator.geolocation.watchPosition(posicion => {
    var pos = {
        lat: posicion.coords.latitude,
        lng: posicion.coords.longitude
    }

    MapView.flyTo(pos, 16)
    var marker = L.marker(pos, {icon:currentIcon}).addTo(MapView);
    getLocations();

    saveLocation(pos);
}, 
err => {
    console.warn('ERROR(' + err.code + '): ' + err.message);
},
{
    timeout: 3000,
    maximumAge: 0
});

function saveLocation(location){
    db.collection("Localizaciones").add({
        lat: location.lat,
        lng: location.lng,        
    })
    .then(function(docRef) {
        console.log("Document written with ID: ", docRef.id);
    })
    .catch(function(error) {
        console.error("Error adding document: ", error);
    });
}

function getLocations(){
    db.collection('Localizaciones').onSnapshot( snapshot => {
        let changes = snapshot.docChanges();
        changes.forEach(change => {
                console.log(change.doc.data())
            if(change.type == "added")
            {
                var marker = L.marker(change.doc.data(), {icon:newIcon}).addTo(MapView);
            }
        });
    });
}
