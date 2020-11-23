// var bbox = turf.bbox(features);
var pos1 = { lat: 21.152639, lng: -101.6250 };
var mymap = L.map('mapL').setView(pos1, 10);
L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    id: 'mapbox/streets-v11',
    tileSize: 512,
    zoomOffset: -1,
    accessToken: 'pk.eyJ1IjoiZ2VyYXJkb2pjciIsImEiOiJja2V0MWxqeXoxcjQxMnlwbmQ0eTljOTB6In0.OhFaqrajYvHIwkGoGoG5Ug'
}).addTo(mymap);
var puntos = []
mymap.on("click", (e) => {

    const arr = [e.latlng.lng, e.latlng.lat]
    puntos.push(arr);


    if (puntos.length > 1) {
        var line = turf.lineString(puntos);
        var options = { units: 'miles' };
        var along = turf.along(line, 200, options);
        console.log(typeof JSON.stringify(line))
        L.geoJSON(JSON.parse(JSON.stringify(line))).addTo(mymap)
    }



    L.marker(e.latlng).addTo(mymap);

})
var select = document.getElementById("mySelect");
var label = document.getElementById("label");
select.addEventListener('change', (e) => {

    if (select.value == "along") {
        if (puntos.length > 1) {
            var line = turf.lineString(puntos);

            L.geoJSON(JSON.parse(JSON.stringify(line))).addTo(mymap)
        }

    }
    if (select.value == "area") {


        if (puntos.length > 1) {
            puntos.push(puntos[0])
            var polygon = turf.polygon([puntos]);
            var area = turf.area(polygon);
            label.innerHTML = "Area " + area.toString() + "km^2";
            L.geoJSON(JSON.parse(JSON.stringify(polygon))).addTo(mymap)
        }


    }
    if (select.value == "bbox") {
        if (puntos.length > 1) {
           
            var line = turf.lineString(puntos);
            var bbox = turf.bbox(line);
            var bboxPolygon = turf.bboxPolygon(bbox);
            L.geoJSON(JSON.parse(JSON.stringify(bboxPolygon))).addTo(mymap)
        }

    }
    if (select.value == "distance") {
        if (puntos.length == 2) {
            var from = turf.point(puntos[0]);
            var to = turf.point(puntos[1]);
            var distance = turf.distance(from, to);
            label.innerHTML = "distancia " + distance.toString() + "km";
            
        }
    }
})

