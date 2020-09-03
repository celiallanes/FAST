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
	<select id="sel-cat" name="categoria" onchange="cambiarFondoNota(this.value)" >
		<option class="categoria" selected="true" disabled="disabled" >Seleccione una categoria</option>
		<%
		List<String> categorias = notas.obtenerCategorias(usuario.getNombre());
		for (String categoria:categorias){
			if(categoria!=null){
		%>
		<option  class="categoria" value="<%=categoria%>"><%=categoria %></option>
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
		<option class="color" selected="true" disabled="disabled" >Seleccione un color</option>
		<%
		List<String> colores = notas.obtenerColores(usuario.getNombre());
		for (String color:colores){
			if (color!=null){
		%>
		<option class="color" value="<%=color%>" onmouseup="<%=color%>"><%=color%></option>
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