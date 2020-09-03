"use strict"

function borrar_repclave(){
	repclave = document.querySelector("input#repclave");
	repclave.value = "";
}


function coincide_clave(){
	clave = document.querySelector("input#clave");
	repclave = document.querySelector("input#repclave");
	if (clave.value != repclave.value){
		document.getElementById("nocoinciden").style.display="block";
		repclave.value = "";
	}else{
		document.getElementById("nocoinciden").style.display="none";
	}
	
}

/*
crear_usuario(){
	var nombre = document.querySelector("input#nombre").value;
	var clave = document.querySelector("input#clave").value;
	var urlimagen = document.querySelector("select#urlimagen").value;
	var rol = document.querySelector("selectt#rol").value;
	//Para evitar que se oculte el detalle
	//if(event) event.stopPropagation();
	//Peticion AJAX
 	var peticion="/crear_usuario";	
 	var xmlhttp = new XMLHttpRequest();
	xmlhttp.open("POST",peticion,true);
	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlhttp.onreadystatechange = function(){ 
		if (xmlhttp.readyState==4) {
			if (xmlhttp.status==200) { 
				//Respuesta recibida completamente (4) y sin
				//errores del servidor (codigo HTTP 200) 
				//Analizamos
				var resultadoCrear = JSON.parse(xmlhttp.responseText);
				}
			}
		  };
		xmlhttp.send("nombre="+nombre + "clave=" + clave + "urlimagen="urlimagen + "rol="rol); //enviamos	
}
*/