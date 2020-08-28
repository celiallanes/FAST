"use strict";

//Indica el id de la ultima nota cuyo detalle se ha mostrado
var ultid=-1;

//Esta funcion sirve para mostrar un mensaje mientras se obtienen los detalles
function updateColor(color){
	var new_option = document.createElement("option");
	new_option.innerHTML = "Preferencia " + cont;
	cont++;
	var sel_color = document.getElementById("sel-color");
	sel_color.appendChild(new_option);
	new_option.setAttribute("value", color);
	new_option.setAttribute("selected", "selected");
	var nota = document.getElementById("nota");
	nota.style.backgroundColor = color;	
};

function cambiarFondoNota(color){
	var nota = document.getElementById("nota");
	nota.style.backgroundColor = color;	
	var picker = document.getElementById("color-picker");
	picker.setAttribute("value", color)
}

function verFondoNota(color){
	var nota = document.getElementById("nota");
	nota.style.backgroundColor = color;	
}

function nuevaCategoria(){
	var categoria = prompt("Introduce nueva categoría","");
	event.preventDefault();
	var sel_cat = document.getElementById("sel-cat");
	var new_option = document.createElement("option");
	new_option.innerHTML = categoria;
	new_option.setAttribute("selected", "selected")
	sel_cat.appendChild(new_option);
};

var cont = 1;

