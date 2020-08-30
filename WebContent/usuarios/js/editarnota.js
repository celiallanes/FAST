"use strict";


function notaBBDD(note) {
	if (note.error != null && note.error !="") {
		alert("Error al obtener detalles de la nota.");
	} else {
		var tit = note.titulo;
		var url = note.imagen;
		var cat = note.categoria;
		var col = note.color;
		var nt = note.nota;		
	
		var titulo = document.getElementById("titulo");
		var urlimagen = document.getElementById("urlimagen");
		var categoria = document.getElementById("sel-cat");
		var color= document.getElementById("sel-color");
		var nota = document.getElementById("nota");
		var colors = document.getElementsByClassName("color");
		var categorias = document.getElementsByClassName("categoria");
		var i;
		if(tit != null) titulo.value = tit;
		if(url!=null) urlimagen.value = url;
		if(cat!=null) { categoria.value = cat; 
			//for(i=0; i<categorias.length; i++)
				//if (categorias[i].value == cat) categorias[i].setAttribute("selected", "selected");
		}
		if(col!=null) { color.value = col;
			//for(i=0; i<colors.length; i++)
				//if (colors[i].value == col) colors[i].setAttribute("selected", "selected");
			nota.style.backgroundColor = col;
			color_picker(col);
		}
		if(nt!=null) nota.value= nt;
	}
};

function obtenerNota(id){
	//Peticion AJAX
	var peticion="nota"; 
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.open("POST",peticion,true);
	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlhttp.onreadystatechange = function(){ 
		if (xmlhttp.readyState==4) {
			if (xmlhttp.status==200) { 
				//Respuesta recibida completamente (4) y sin
				//errores del servidor (codigo HTTP 200) 
				//Analizamos
				var detalleNota = JSON.parse(xmlhttp.responseText);
				notaBBDD(detalleNota);
			}
		}
	  };
	xmlhttp.send("id="+id); //enviamos
};

function mostrarDetalle(note) {
	var tit = "";
	var url = "";
	var cat = "";
	var col = "";
	var nt = "";
	if (note.error != null && note.error !="") {
		alert("Error al obtener detalles de la nota.");
	} else {
		tit = nota.titulo;
		url = nota.urlimagen;
		cat = nota.categoria;
		col = nota.color;
		nt = nota.nota;		
		colorFondoNota(nt.color, nt.id);
	}
	return note
}