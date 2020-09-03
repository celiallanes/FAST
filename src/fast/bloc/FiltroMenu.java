package fast.bloc;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;


/**
 * Servlet Filter implementation class FiltroClientes
 */
@WebFilter("/menu.jsp")
public class FiltroMenu implements Filter {

    /**
     * Default constructor. 
     */
    public FiltroMenu() {
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		Usuario usuario = (Usuario) req.getSession().getAttribute("usuario");
				
		if ( usuario.getTipo_usu() == Usuario.ADMINISTRADOR) {
			req.getRequestDispatcher("admins/menu.jsp").forward(request, response);;
		} 
		if ( usuario.getTipo_usu() == Usuario.CLIENTE &&  usuario.getRol() == Usuario.VISOR_EDITOR) {
			req.getRequestDispatcher("usuarios/menu_editor.jsp").forward(request, response);;
		}
		if ( usuario.getTipo_usu() == Usuario.CLIENTE &&  usuario.getRol() == Usuario.VISOR) {
			req.getRequestDispatcher("usuarios/menu_visor.jsp").forward(request, response);;
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
	}

}
