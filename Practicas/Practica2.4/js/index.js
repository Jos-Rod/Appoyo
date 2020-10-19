var title = document.getElementById("Titulo");
var description = document.getElementById("Descripcion");
var map = document.getElementById("mapa");

var info = [
    {
        title: "Hipsográfico",
        description: "1",
        url: "http://localhost:8000/maps/20/embed"
    },
    {
        title: "Volcanes",
        description: "Ubicación de los volcanes existentes en México.",
        url: "http://localhost:8000/maps/22/embed"
    },
    {
        title: "Magnitud Sísmica",
        description: "3",
        url: "http://localhost:8000/maps/21/embed"
    },
    {
        title: "Erosión Costera",
        description: "4",
        url: "http://localhost:8000/maps/24/embed"
    },
    {
        title: "Movimiento en Masa",
        description: "5",
        url: "http://localhost:8000/maps/25/embed"
    }
];

document.querySelectorAll(".btn").forEach(element => {
    element.addEventListener("click", function() {
        title.innerHTML = info[element.id - 1].title;
        description.innerHTML = info[element.id - 1].description;
        map.src = info[element.id - 1].url;
    });
});