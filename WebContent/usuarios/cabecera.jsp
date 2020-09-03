	<div id="cabecera">
		<div id="logotipo" style="width:24%; float:left;">
				<a href="/bloc/menu.jsp">
				<img src="${pageContext.request.contextPath}/imagenes/blocnotasfast-p.png" alt="Bloc de Notas FAST" />
				</a>
		</div>
		
		<div style="width:24%; float:right;">
		<a href="${pageContext.request.contextPath}/index.jsp?salir"><span class="acceso">Cerrar sesión</span></a>
		<span class='acceso' id='nombreusuario'>${usuario.nombre}</span>
		<img height="24px" width="29px" style="float: right; padding-top: 5px;" src="${pageContext.request.contextPath}/${usuario.urlimagen}"></img>
		
		</div>
	</div>
