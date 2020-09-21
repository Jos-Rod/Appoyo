
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

getLocations();

if(navigator.geolocation){
    navigator.geolocation.watchPosition(posicion => {
        var pos = {
            lat: posicion.coords.latitude,
            lng: posicion.coords.longitude
        }
    
        MapView.flyTo(pos, 16)
        var marker = L.marker(pos, {icon:currentIcon}).addTo(MapView);
    
        saveLocation(pos, "getLocation");
    }, 
    err => {
        Swal.fire({
            title: 'No se pudo obtener tu ubicación',
            text: "Escribe tus coordenadas en el siguiente fomrato: lat,lng",
            input: 'text',
            icon: 'warning',
            showCancelButton: false,
            confirmButtonColor: '#3085d6',
            confirmButtonText: 'Ok'
        }).then((result) => {
            console.log(result)
            var latlngStr = result.value.split(",", 2);
            var lat = parseFloat(latlngStr[0]);
            var lng = parseFloat(latlngStr[1]);
            MapView.flyTo([lat, lng], 16)
            var marker = L.marker([lat, lng], {icon:currentIcon}).addTo(MapView);
            saveLocation({lat: lat, lng: lng}, "input");
        });
        console.warn('ERROR(' + err.code + '): ' + err.message);
    },
    {
        timeout: 3000,
        maximumAge: 0
    });
}
else
{
    Swal.fire({
        title: 'Error!',
        text: 'Do you want to continue',
        icon: 'error',
        confirmButtonText: 'Cool'
    })
}

function saveLocation(location, type){
    db.collection("Localizaciones").add({
        lat: location.lat,
        lng: location.lng,
        type: type     
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
                if(change.doc.data().type == "input")
                {
                    var marker = L.marker([change.doc.data().lat, change.doc.data().lng], {icon:inputIcon}).addTo(MapView);
                }
                else
                {
                    var marker = L.marker([change.doc.data().lat, change.doc.data().lng], {icon:newIcon}).addTo(MapView);
                }
                
            }
        });
    });
}
