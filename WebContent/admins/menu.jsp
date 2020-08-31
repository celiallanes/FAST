<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<jsp:useBean id="usuario" class="fast.bloc.Usuario" scope="session" />

<!DOCTYPE html>
<html>
  <head>
    <title>Bloc de Notas - FAST: Menú</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="/bloc/css/estilo.css" />
  </head>
  <body>
	<jsp:include page="../usuarios/cabecera.jsp" />
	<div id="menu">
		<h1>Menú de Administradores</h1>
		<ol>
		<li>
			<a href="/bloc/usuarios/crearnota.jsp"><span class="fondo">
				<span class="textoopcion">Nueva</span>
			</span></a>
		</li>
		<li>
			<a href="/bloc/usuarios/listarnotas.jsp"><span class="fondo">
				<span class="textoopcion">Mostrar propias</span>
			</span></a>
		</li>
		<li>
			<a href="/bloc/admins/listarnotasTodas.jsp"><span class="fondo">
				<span class="textoopcion">Mostrar todas</span>
			</span></a>
		</li>
		<li>
			<a href=""><span class="fondo">
				<span class="textoopcion">Gestión de usuarios</span>
			</span></a>
		</li>
		<li>
			<a href="/bloc/usuarios/revision.jsp"><span class="fondo">
				<span class="textoopcion">Revisión</span>
			</span></a>
		</li>
		</ol>
	</div>


	<%@include file="../pie.jsp"%>
  </body>
</html>