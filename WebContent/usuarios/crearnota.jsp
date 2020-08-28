<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"
		import="java.util.List, fast.bloc.Nota, fast.bloc.DAOException"%>

<jsp:useBean id="usuario" class="fast.bloc.Usuario" scope="session" />
<jsp:useBean id="notas" class="fast.bloc.NotasDAO" scope="application" />
<jsp:useBean id="nota" class="fast.bloc.Nota" />
<jsp:setProperty property="*" name="nota"/>

<!DOCTYPE html>
<html>
<head>
	<title>Bloc de Notas - FAST: Crear nota</title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="../css/estilo.css" />
	<script src="js/listarnotas.js"></script>
	<script src="js/crearnota.js"></script>
</head>
<body>
	<jsp:include page="cabecera.jsp" />
	
	<% // Código HTML + JSP  
	//TODO esto se podría hacer con AJAX y se eliminaría el código
	if ( nota.getTitulo() != null) {
		//Creamos notas
		
		String mensajeError = "";
		
		try {
			// el nombre de usuario se obtiene del atributo de sesión usuario
			nota.setNombreUsuario(usuario.getNombre());
			if ( !notas.insertar(nota) ) {
				mensajeError = "No se ha podido insertar la nota";
			}
	
		} catch (DAOException e) {
			mensajeError = e.getMessage();
		}
		
	    //Muestra error o exito
		if ( ! mensajeError.isEmpty() ) {
		%>
			<div id="error"><p> ERROR: 
			<%= mensajeError %>
			</p></div>
		<%
		} else { %>
			<div id="exito"><p> INFO: NOTA CREADA</p></div>
	<%
		}
	} 
	//mostramos formulario
	%>


	<div id="crear">
		<h1>Crear nota</h1>
		<div id="formcrear">
			<form method="post" action="">
			<div class="titulo-div">
				<label for="titulo"><strong>T&iacute;tulo de la nota</strong></label>
				<input id="titulo" type="text" value="" name="titulo" maxlength="100"
					required="required"></input>
			</div>
			<div class="imagen-div">
				<label for="urlimagen"><strong>URL de la imagen</strong></label>
				<input id="urlimagen" type="text" value="" name="urlimagen"></input>
			</div>
			<div class="categoria-div">
				<strong class="campo">Categor&iacute;a</strong>
				<select id="sel-cat" name="categoria" onchange="cambiarFondoNota(this.value)">
				<%
				List<String> categorias = notas.obtenerCategorias(usuario.getNombre());
				for (String categoria:categorias){
					if(categoria!=null){
				%>
				<option value="<%=categoria%>"><%=categoria %></option>
				<%	
					}
				}						
				%>
				</select>
				<button id="mas-cat" onclick="nuevaCategoria()">+</button>
			</div>
			<div class="color-div">			
				<strong class="campo">Color</strong>
				<select id="sel-color" name="color" onchange="cambiarFondoNota(this.value)">
				<%
				List<String> colores = notas.obtenerColores(usuario.getNombre());
				for (String color:colores){
					if (color!=null){
				%>
				<option value="<%=color%>"><%=color%></option>
				<%	
					}
				}						
				%>
				</select>
				+
				<input id="color-picker" type="color" oninput="verFondoNota(this.value)" onchange="updateColor(this.value)"></input>				
			</div>	
			<div class="nota-div">
				<label for="nota"><strong>Nota</strong></label>
				<textarea id="nota" name="nota" cols="100%" rows="100%"></textarea>
			</div>	
			<input class="boton" id="enviarnota" type="submit" value="Crear" name="enviarnota"></input>
			<input class="boton" id="limpiar" type="reset" value="Limpiar datos" name="limpiar"></input>		
			</form>
			
		</div>
	</div>
	

	<%@include file="../pie.jsp"%>
  </body>
</html>