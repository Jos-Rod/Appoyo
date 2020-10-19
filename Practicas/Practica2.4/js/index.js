var items = document.getElementById("items");
var map = document.getElementById("mapa");

var info = [
    {
        title: "Hipsográfico",
        description: "Muestra la elevación de la superficie del país.",
        url: "http://localhost:8000/maps/20/embed"
    },
    {
        title: "Volcanes",
        description: "Ubicación de los volcanes existentes en México.",
        url: "http://localhost:8000/maps/22/embed"
    },
    {
        title: "Magnitud Sísmica",
        description: "Se muestran las áreas con la respectiva actividad sísmica en México.",
        url: "http://localhost:8000/maps/21/embed"
    },
    {
        title: "Erosión Costera",
        description: "Se muestra la erosión se que ha tenido en la zona costera.",
        url: "http://localhost:8000/maps/24/embed"
    },
    {
        title: "Movimiento en Masa",
        description: "Se muestra el respectivo movimiento me masa que ha habido en el país.",
        url: "http://localhost:8000/maps/25/embed"
    }
];

document.querySelectorAll(".btn").forEach(element => {
    element.addEventListener("click", function() {
        items.innerHTML = "";
        for(var i = 0; i < element.id; i++){
            items.innerHTML += `
            <div class="col-4">
                <h1>${info[i].title}</h1>
                <p>${info[i].description}</p>
            </div>` 
        }
        map.src = info[element.id - 1].url;
    });
});