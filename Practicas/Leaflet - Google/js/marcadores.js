function initMap(){
    var map = new google.maps.Map(document.getElementById("map"), {
        center: {lat: 21.152639, lng: -101.711598},
        zoom: 10
    });

    var pos1 =  {lat: 21.152639, lng: -101.6250};
    
    var icono1 = {
        url: "https://d1s6fstvea5cci.cloudfront.net/content/themes/vtnz/resources/assets/images/pulse_dot.gif",
        scaledSize: new google.maps.Size(30, 30),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(0, 0)
    }

    var marker1 = new google.maps.Marker({
        position: pos1,
        icon: icono1,
        scaledSize: new google.maps.Size(25, 25),
        map: map
    });

    marker1.addListener("click", function (){
        var informacion = new google.maps.InfoWindow;

        var infoBody = '<div class="row p-0"><div class="col-12 text-center"><h5>Contenido del InfoWindow</h5></div></div>' +
        '<div class="row p-0 pt-2">' +
        '<div class="col-12 col-lg-2 py-2 text-center"><img width=50px src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Info_Sign.svg/512px-Info_Sign.svg.png"></div>'+
        '<div class="col-12 col-lg-10 py-2 text-center"><p>Este es el contenido de un InfoWindow, puede agregar html en esta ventana</p></div>'+
        '</div>'
        informacion.setPosition(pos1);
        informacion.setContent(infoBody);
        informacion.open(map);
    });

    map.setCenter(pos1);




    var mymap = L.map('mapL').setView(pos1, 10);
    L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
        maxZoom: 18,
        id: 'mapbox/streets-v11',
        tileSize: 512,
        zoomOffset: -1,
        accessToken: 'pk.eyJ1IjoiZ2VyYXJkb2pjciIsImEiOiJja2V0MWxqeXoxcjQxMnlwbmQ0eTljOTB6In0.OhFaqrajYvHIwkGoGoG5Ug'
    }).addTo(mymap);

    var marker = L.marker(pos1).addTo(mymap);

}