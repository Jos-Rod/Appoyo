function initMap(){
    var map = new google.maps.Map(document.getElementById("map"), {
        center: {lat: 21.152639, lng: -101.711598},
        zoom: 10
    });

    var pos1 =  {lat: 21.152639, lng: -101.6250};
    var pos2 =  {lat: 21.18520, lng: -101.711598};
    var pos3 =  {lat: 21.25478, lng: -101.8584};
    
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
    
    var icono2 = {
        url: "https://www.kirshhelmets.com/wp-content/uploads/2020/03/Hotspot-Tech.gif",
        scaledSize: new google.maps.Size(30, 30),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(0, 0)
    }

    var marker2 = new google.maps.Marker({
        position: pos2,
        icon: icono2,
        scaledSize: new google.maps.Size(25, 25),
        map: map
    });
    
    marker2.addListener("click", function (){
        var informacion = new google.maps.InfoWindow;

        var infoBody = '<div class="row p-0"><div class="col-12 text-center"><h5>Contenido del InfoWindow</h5></div></div>' +
        '<div class="row p-0 pt-2">' +
        '<div class="col-12 col-lg-2 py-2 text-center"><img width=50px src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Info_Sign.svg/512px-Info_Sign.svg.png"></div>'+
        '<div class="col-12 col-lg-10 py-2 text-center"><p>Este es el contenido de un InfoWindow, puede agregar html en esta ventana</p></div>'+
        '</div>'
        informacion.setPosition(pos2);
        informacion.setContent(infoBody);
        informacion.open(map);
    });

    var icono3 = {
        url: "https://static.wixstatic.com/media/464da3_7f6773f984b44bb091027282e99c3023~mv2.gif",
        scaledSize: new google.maps.Size(30, 30),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(0, 0)
    }

    var marker3 = new google.maps.Marker({
        position: pos3,
        icon: icono3,
        scaledSize: new google.maps.Size(25, 25),
        map: map
    });
    
    marker3.addListener("click", function (){
        var informacion = new google.maps.InfoWindow;

        var infoBody = '<div class="row p-0"><div class="col-12 text-center"><h5>Contenido del InfoWindow</h5></div></div>' +
        '<div class="row p-0 pt-2">' +
        '<div class="col-12 col-lg-2 py-2 text-center"><img width=50px src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Info_Sign.svg/512px-Info_Sign.svg.png"></div>'+
        '<div class="col-12 col-lg-10 py-2 text-center"><p>Este es el contenido de un InfoWindow, puede agregar html en esta ventana</p></div>'+
        '</div>'
        informacion.setPosition(pos3);
        informacion.setContent(infoBody);
        informacion.open(map);
    });


    map.setCenter(map.center);
}