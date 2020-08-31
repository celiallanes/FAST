"use strict"

function obtener_select(cat){
	var categoria = document.querySelectorAll("th.categoria")[0];
	var select_elem = document.createElement("select");
	var opcion;
	var opciones = [];
	var opcion_def = document.createElement("option");
	opcion_def.selected = true; opcion_def.disabled = "disabled"; opcion_def.innerHTML = "Categorias";
	select_elem.appendChild(opcion_def);
	for (var i=0; i<cat.length; i++){
		opcion = document.createElement("option");
		opcion.value = cat[i]; opcion.innerHTML = cat[i];
		select_elem.appendChild(opcion);		
	}
	categoria.removeChild(categoria.childNodes[0]);
	categoria.appendChild(select_elem);	
}


function contiene_elem(elem, tabla){
	var contiene = false;
	for (var i=0; i<tabla.length; i++){
		if (elem == tabla[i]){
			contiene = true;			
		}		
	}	
	return contiene;
}


function ocultar_notas(){
	var filas = document.getElementsByClassName("fila");
	for (var i=0; i<filas.length; i++){
		filas[i].style.display = "none";
	}	
	//Establezco evento al select para que se llame a la función notas_por_categoria cada vez que cambie de valor
	var sel = document.getElementsByTagName("select");
	sel[0].onchange = function(){return filtrafilas(document.getElementsByTagName("select")[0].value);};
}


function filtrafilas(cat){
	var filas = document.getElementsByClassName("fila");
	if (cat == "*")
		for (var i=0; i<filas.length; i++){
			filas[i].style.display = "";
		}
	else{
		for (var i=0; i<filas.length; i++){
			var categoria = filas[i].querySelector("td.categoria");
			if (categoria.textContent == cat)
				filas[i].style.display = "";
			else
				filas[i].style.display = "none"
		}
	}
}


window.addEventListener("load", function() {
	var cat = ["*"];
	var categorias = [];
	categorias = document.querySelectorAll("td.categoria");
	for(var i=0; i< categorias.length; i++) {
		if (!contiene_elem(categorias[i].textContent, cat) && categorias[i].textContent!="null")
			cat.push(categorias[i].textContent);
	}
	obtener_select(cat);
	ocultar_notas();
});