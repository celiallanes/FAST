<%@page import="fast.bloc.Usuario"%>
<%@page import="fast.bloc.UsuariosDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"
		import="java.util.List, fast.bloc.Nota, fast.bloc.DAOException,
		 java.sql.Timestamp, java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>

<jsp:useBean id="usuario" class="fast.bloc.Usuario" scope="session" />
<jsp:useBean id="usuarios" class="fast.bloc.UsuariosDAO" scope="application" />
<jsp:useBean id="user" class="fast.bloc.Usuario" />
<jsp:setProperty property="*" name="user"/>

<!DOCTYPE html>
<html>
<head>
	<title>Bloc de Notas - FAST: Crear usuario</title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="../css/estilo.css" />
	<script src="js/crearusuario.js"></script>
</head>
<body>
	<jsp:include page="../usuarios/cabecera.jsp" />
	<%
	if (user.getNombre() != null){
		Usuario us = new Usuario();
		us = usuarios.existe(user.getNombre());
		String mensajeError = "";
		if (us == null) {//Usuario no existe, lo creo
			try {
				// el nombre de usuario se obtiene del atributo de sesión usuario
				long millis = System.currentTimeMillis();
       			System.out.println(millis);
        		Timestamp fecha_hora = new Timestamp(millis);
				user.setFecha_hora(fecha_hora);

				if ( !usuarios.insertar(user) ) {
					mensajeError = "No se ha podido insertar la nota";
				}		
			} catch (DAOException e) {
				mensajeError = e.getMessage();
			}
		}else{ //Usuario ya existe
			String[] fechaYhora = us.getFecha_hora_format();
			mensajeError = "El usuario "+us.getNombre()+ " fue creado el "+fechaYhora[0]+" a las "+fechaYhora[1];	
		}
		//Muestra error o exito
		if ( ! mensajeError.isEmpty() ) {
		%>
		<div id="error"><p> ERROR: <%= mensajeError %></p></div>
		<%
		} else { %>
		<div id="exito"><p> El usuario <%=user.getNombre()%> ha sido creado</p></div>
		<%
		}		
	}	
	%>	
	<div id="crear">
		<h1>Crear usuario</h1>
		<div id="formcrear">
			<form method="post" action="">
				<div class="nombre-div">
					<label for="nombre"><strong>Nombre usuario</strong></label>
					<input id="nombre" type="text" value="" name="nombre" maxlength="20" 
						required="required"></input>
				</div>
				<div class="clave-div">
					<label for="clave"><strong>Clave</strong></label>
					<input id="clave" type="password" value="" name="clave" required="required" 
						onchange="borrar_repclave()" style="width: 100%;"></input>
				</div>
				<div class="repclave-div">
					<label for="repclave"><strong> Repita clave</strong></label>
					<input id="repclave" type="password" value="" required="required" 
					onchange="coincide_clave()"style="width: 100%;"></input>
					<div id="nocoinciden" style="display: none;"><span>Claves no coinciden</span></div>
				</div>
				<div class="imagen-div">
					<label for="urlimagen"><strong>Imagen</strong></label>
					<select id="urlimagen"  name="urlimagen" required="required">
						<option selected="selected" disabled="disabled">Seleccione imagen</option>
						<option value="imagenes/imagen1.png">Imagen1</option>
						<option value="imagenes/imagen2.png">Imagen2</option>
					</select>
				</div>
				<div class="rol-div">
					<label for="rol"><strong>Rol</strong></label>
					<select id="rol"  name="urlimagen" required="required">
						<option selected="selected" disabled="disabled">Seleccione rol</option>
						<option value="<%=Usuario.VISOR%>">Visor</option>
						<option value="<%=Usuario.VISOR_EDITOR%>">Visor y editor</option>
					</select>
				</div>
				<input class="boton" id="enviarusuario" type="submit" value="Crear" name="enviarusuario"></input>
				<input class="boton" id="limpiar" type="reset" value="Limpiar datos" name="limpiar"></input>		
			</form>			
		</div>
	</div>
	<%@include file="../pie.jsp"%>
  </body>
</html>