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
	<title>Bloc de Notas - FAST: Editar nota</title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="../css/estilo.css" />
	<script src="js/listarnotas.js"></script>
	<script src="js/crearnota.js"></script>
	<script src="js/editarnota.js"></script>
</head>


<body onload="obtenerNota(<%=notas.obtener(Integer.parseInt(request.getQueryString()), usuario.getNombre()).getId()%>)">
	<jsp:include page="cabecera.jsp" />
	
	<% // Código HTML + JSP  
	//TODO esto se podría hacer con AJAX y se eliminaría el código
	if ( nota.getTitulo() != null) {
		//Creamos notas
		
		String mensajeError = "";
		
		try {
			// el nombre de usuario se obtiene del atributo de sesión usuario
			nota.setNombreUsuario(usuario.getNombre());
			nota.setId(Integer.parseInt(request.getQueryString()));
			if ( !notas.actualizar(nota) ) {
				mensajeError = "No se ha podido editar la nota";
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
			<div id="exito"><p> INFO: NOTA EDITADA</p></div>
	<%
		}
	} 
	//mostramos formulario
	%>

	<div id="editar">
		<h1>Editar nota</h1>
		<div id="formeditar">
			<form method="post" action="">
			<%@include file="formularionota.jsp"%>	
			<input class="boton" id="guardar" type="submit" value="Guardar" name="enviarnota"></input>
			<input class="boton" id="recargar" type="reset" value="Regargar Datos Guardados" name="limpiar"
			onclick="obtenerNota(<%=notas.obtener(Integer.parseInt(request.getQueryString()), usuario.getNombre()).getId()%>)"></input>		
			</form>			
		</div>
		</br>
		<a class="boton" id="volver" href="listarnotas.jsp">Volver a la lista</a>	
	</div>
	
	<%@include file="../pie.jsp"%>
  </body>
</html>