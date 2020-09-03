"use strict";

//Indica el id de la ultima nota cuyo detalle se ha mostrado
var ultid=-1;

//Esta funcion sirve para mostrar un mensaje mientras se obtienen los detalles
function mostrarEsperando(elemento) {
	var html = "<p><strong>Obteniendo detalles...</strong></p>"+
				"<img src='../imagenes/espera.gif' alt='Espera' />";
	elemento.innerHTML=html;
}
//Muestra los detalles obtenidos mediante AJAX.
//objetoDetalle, tiene que ser un objeto con las siguientes propiedades:
//	nota: texto de la nota
//	imagen: url de la imagen asociada a la nota
//  error: texto con el error producido al buscar los detalles de una nota
function mostrarDetalle(elemento, objetoDetalle) {
	if (objetoDetalle.error != null && objetoDetalle.error !="") {
		//error
		elemento.innerHTML="<p>Error: "+objetoDetalle.error+"</p>";
	} else {
		elemento.innerHTML=
				"<p class='textocategoria'>"+"Categoria: " + objetoDetalle.categoria + "</p>" + 
				"<div id=\"fondoColor-" + objetoDetalle.id + "\">" + 
					"<p class='textonota'>"+ objetoDetalle.nota+"</p>"+ 
					"<img src='"+objetoDetalle.imagen+"' alt='Sin imagen' /><br />" + 
				"</div>";
		colorFondoNota(objetoDetalle.color, objetoDetalle.id);
	}
}

function colorFondoNota(color, id){
	var divColor = document.getElementById("fondoColor-"+id);
	divColor.style.backgroundColor = color;	
}

//Muestra informacion sobre la nota con el identificador pasado
function mostrar() {
	//el padre tiene un id del tipo "fila-num"
	var prefix = "fila-";
	var id = parseInt(this.parentElement.id.substring(prefix.length));
	
	if (ultid > 0) {
		//Ocultamos el anterior detalle
		document.getElementById("detalle-"+ultid).style.display="none";
	}
	if (ultid == id)  //en este caso, no mostramos, solo ocultamos
		ultid = -1; 
	else {
		ultid = id;
		
		//Cambiamos el detalle
		var divDetalle = document.getElementById("detalle-"+ultid);
		mostrarEsperando(divDetalle);
		divDetalle.style.display="block"; //Hacemos visible

		//Peticion AJAX
		var peticion="nota"; //?id="+ultid;
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
					mostrarDetalle(divDetalle, detalleNota);
				}
			}
		  };
		xmlhttp.send("id="+ultid); //enviamos
	}
}


window.addEventListener("load", function() {
	var infos = document.querySelectorAll(".infonota");
	for(var i=0; i< infos.length; i++) {
		infos[i].onclick=mostrar;
	}
});

