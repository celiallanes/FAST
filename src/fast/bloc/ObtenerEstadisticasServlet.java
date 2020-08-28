package fast.bloc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AccederServlet
 */
@WebServlet("/usuarios/estadisticas")
public class ObtenerEstadisticasServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ObtenerEstadisticasServlet() {
        super();
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Usuario usuario = (Usuario) req.getSession().getAttribute("usuario");
		NotasDAO notas = (NotasDAO) getServletContext().getAttribute("notas");
		int tipo_us = usuario.getTipo_usu();
		String query_str = req.getQueryString();
		int numMensajes = 0;
		int mediaMensajes = 0;
		int[] result; 
		
		System.out.println(query_str);
		System.out.println(query_str.contains("todos"));
		//System.out.println(query_str.contains("&todos"));
		if (tipo_us == Usuario.ADMINISTRADOR && query_str.contains("todos")) {
			result = notas.num_media_msg_todos();
			numMensajes = result[0];
			mediaMensajes = result[1];
		} else {
			result = notas.num_media_msg_us(usuario.getNombre());
			numMensajes = result[0];
			mediaMensajes = result[1];			
		}
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
	    resp.getWriter().println(
	    		"{ \"numMensajes\":\"" + numMensajes + "\", \"mediaMensajes\":\""+mediaMensajes+"\" }");		
	}
}
