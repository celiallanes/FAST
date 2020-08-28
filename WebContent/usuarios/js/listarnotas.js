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
				"</div>" + 
				"<button class='boton' onclick='borrar(event, ultid);'>Borrar</button>" +
				"<button class='boton' onclick='editar(event, ultid);'><a href='editarnota.jsp' target='_blank'>Editar<a></editar>";
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

//Muestra informacion sobre la nota con el identificador pasado
function borrar(event, id) {
	
	//Para evitar que se oculte el detalle
	if(event) event.stopPropagation();
	
	if (!event || ultid == id) { //en este caso, borramos
		
		
		//Peticion AJAX
		var peticion="borranota";
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.open("POST",peticion,true);
		xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xmlhttp.onreadystatechange = function(){ 
			if (xmlhttp.readyState==4) {
			if (xmlhttp.status==200) { 
					//Respuesta recibida completamente (4) y sin
					//errores del servidor (codigo HTTP 200) 
					//Analizamos
					var resultadoBorrar = JSON.parse(xmlhttp.responseText);
					procesarResultadoBorrar(resultadoBorrar);
				}
			}
		  };
		xmlhttp.send("id="+id); //enviamos
	}
	
}

//Procesa resultados de borrar obtenidos mediante AJAX.
//resultadoBorrar, tiene que ser un objeto con las siguientes propiedades:
//	id: identificador numérico de la nota
//error: texto con el error producido al borrar nota. 
//        Es una cadena vacía si se borró correctamente.
function procesarResultadoBorrar(resultadoBorrar) {
	//Si tiene mensaje de error, mostramos como mensaje emergente.
	if (resultadoBorrar.error) {
		alert(resultadoBorrar.error);
	} else {
		//Eliminamos elemento de la tabla
		var fila = document.getElementById("fila-"+resultadoBorrar.id);
		fila.parentNode.removeChild(fila);
		//cambiamos ultid
		ultid = -1;
	}
}


function borrar_seleccionadas(){
	var notas = document.getElementsByClassName("seleccion");
	var seleccionada = false;
	var borrar_control = false;
	var lista_borrar = [];
	var i;
	//Compruebo si hay alguna nota marcada
	for ( i=0; i<notas.length; i++){
		if (notas[i].checked){
			seleccionada = true;
			lista_borrar.push(notas[i].id.substring(5,6));			
		}		
	}
	if (seleccionada)
		borrar_control = confirm("¿Desea borrar todas las notas seleccionadas?");
	else
		alert("No se ha seleccionado ninguna nota");
	if (borrar_control){
		for (i =0 ; i<lista_borrar.length; i++){
			borrar(null, lista_borrar[i]);
			
		}
		
	}		
}


function des_marcar_todas(){
	var notas = document.getElementsByClassName("seleccion");
	var marcado = document.getElementById("lista-tabla").className;
	var i;
	if (marcado == "desmarcar"){
		for (i=0; i<notas.length; i++)
			notas[i].checked = false;
		document.getElementById("lista-tabla").className = "marcar";
	} else{
		for (i=0; i<notas.length; i++)
			notas[i].checked = true;
		document.getElementById("lista-tabla").className = "desmarcar";	
	}	
}


window.addEventListener("load", function() {
	var infos = document.querySelectorAll(".infonota");
	for(var i=0; i< infos.length; i++) {
		infos[i].onclick=mostrar;
	}
	var notas = document.getElementsByClassName("seleccion");
	for (i=0; i<notas.length; i++)
		notas[i].checked = false;
});

