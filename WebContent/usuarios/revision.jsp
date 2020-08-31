<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.List, fast.bloc.Nota"%>
	
<jsp:useBean id="usuario" class="fast.bloc.Usuario" scope="session" />
<jsp:useBean id="notas" class="fast.bloc.NotasDAO" scope="application" />
<%
List<Nota> lista_notas = notas.obtener(usuario.getNombre());
List<String> categorias = notas.obtenerCategorias(usuario.getNombre());
%>


<!DOCTYPE html>
<html>
  <head>
    <title>Bloc de Notas - FAST: Revisión</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="../css/estilo.css" />
    <link rel="stylesheet" type="text/css" href="../css/estilo-revision.css" />
    <script src="js/filtros.js"></script>
    
  </head>
  <body>	
	<jsp:include page="cabecera.jsp" />

	
	<div id="rev-tabla-rev" style="padding-bottom: 2.5rem;">
		<table id=tabla-revision>
			<tr>
				<th class="id">Id</th>				
				<th class="categoria">Categoría</th>
				<th class="color">Color</th>
				<th class="titulo"> Título</th>
				<th class="textarea">Texto</th>
				<th class="imagen">Imagen</th>
			<tr>
			<%
			for (Nota nota: lista_notas) {
					//Generamos tabla
			%>
			<tr class="fila" id='rev-fila-<%=nota.getId()%>'>
				<td class="id"><strong><%=nota.getId()%></strong></td>
				<td class="categoria"><p><%=nota.getCategoria()%></p></td>
				<td class="color"><p style="color:<%=nota.getColor()%>"><%=nota.getColor()%></p></td>
				<td class="titulo"><p><%=nota.getTitulo()%></p></td>
				<td class="textarea"><p><%=nota.getNota()%></p></td>
				<td class="imagen"><img alt="Sin imagen" src="<%=nota.getUrlimagen()%>"></img></td>	
			</tr>
			<%
			}
			%>
		</table>
	</div>
	<%@include file="../pie.jsp"%>
  </body>
</html>

