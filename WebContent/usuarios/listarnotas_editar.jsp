<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.List, fast.bloc.Nota"%>
	
<jsp:useBean id="usuario" class="fast.bloc.Usuario" scope="session" />
<jsp:useBean id="notas" class="fast.bloc.NotasDAO" scope="application" />
<%
List<Nota> lista = notas.obtenerTitulos(usuario.getNombre());
%>


<!DOCTYPE html>
<html>
  <head>
    <title>Bloc de Notas - FAST: Mostrar notas</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="../css/estilo.css" />
    <script src="js/listarnotas_editar.js"></script>
  </head>
  <body>	
	<jsp:include page="cabecera.jsp" />

	<div id="lista">
		<h1>Lista de notas</h1>
		<div id="lista-div">
				<table id="lista-tabla" class="marcar">
				<%
				for (Nota nota: lista) {
					//Generamos tabla
				%>
					<tr id='fila-<%=nota.getId()%>'>
						<td class="infonota">
							<p><input class="seleccion" type="checkbox"  id="nota-<%=nota.getId()%>" onclick="event.stopPropagation()" />
							<strong class="margen-nota"><%=nota.getTitulo()%></strong></p>
							<div class='detalle' id='detalle-<%=nota.getId()%>'></div>
						</td>
					</tr>
				<%
				}
				%>
				</table>
		</div>
		<div id="botones">
			<button class="boton" id="boton-borrar-selec"  onclick="borrar_seleccionadas()">BORRAR SELECCIONADAS</button>
			<button class="boton" id="boton-des-marcar"    onclick="des_marcar_todas()">DESMARCAR TODAS</button>
		</div>
	</div>
	<%@include file="../pie.jsp"%>
  </body>
</html>