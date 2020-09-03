package fast.bloc;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuariosDAO {
	private DataSource ds = null;
	
	public UsuariosDAO() {
	}
	
	public UsuariosDAO(DataSource ds) {
		super();
		this.ds = ds;
	}

	public void setDs(DataSource ds) {
		this.ds = ds;
	}

	public DataSource getDs() {
		return ds;
	}
	
	/**
	 * Comprueba si un usuario existe y la clave es correcta.
	 * Devuelve objeto Usuario relleno si existe
	 * @param nombre Nombre del usuario
	 * @param clave Clave del usuario
	 * @return Objeto Usuario relleno o null si no existe.
	 */
	public Usuario existe(String nombre, String contra) {
		
		Usuario usuario = null; 
		Connection conn;
		try {
			System.out.println("Se va a comprobar el usuario="+nombre+" y la clave="+contra);
			conn = ds.getConnection();
			String sql = "SELECT * FROM usuarios WHERE nombre=? AND clave=?";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, nombre);
			st.setString(2, contra);
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				System.out.println("Se ha encontrado el usuario y la clave coincide.");
				usuario = new Usuario();
				usuario.setNombre(nombre);
				usuario.setTipo_usu(rs.getInt(3));
				usuario.setUrlimagen(rs.getString(4));
				usuario.setRol(rs.getInt(5));
				System.out.println("El tipo de usuario es="+usuario.getTipo_usu()+" y el rol es="+usuario.getRol());
			}
			else {
				System.out.println("No se ha encontrado el usuario o la clave no coincide.");
			}
			rs.close();
			st.close();
			conn.close();	
		}
		catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Error de acceso a la base de datos. UsuariosDAO.");
		}

		return usuario;
	}
	
	
	/**
	 * Comprueba si un usuario existe.
	 * Devuelve objeto Usuario relleno si existe
	 * @param nombre Nombre del usuario
	 * @return Objeto Usuario relleno o null si no existe.
	 */
	public Usuario existe(String nombre) {
		
		Usuario usuario = null; 
		Connection conn;
		try {
			System.out.println("Se va a comprobar el usuario="+nombre);
			conn = ds.getConnection();
			String sql = "SELECT fecha_hora FROM usuarios WHERE nombre=?";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, nombre);
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				System.out.println("Se ha encontrado el usuario.");
				usuario = new Usuario();
				usuario.setNombre(nombre);
				usuario.setFecha_hora(rs.getTimestamp(1));
				String[] fechaYhora = usuario.getFecha_hora_format();
				System.out.println("Usuario "+nombre+" fue creado el "+fechaYhora[0]+" a las "+fechaYhora[1]);
			}
			else {
				System.out.println("No se ha encontrado el usuario.");
			}
			rs.close();
			st.close();
			conn.close();	
		}
		catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Error de acceso a la base de datos. UsuariosDAO.");
		}

		return usuario;
	}
	
	
	
	/**
	 * inserta un nuevo usuario en la bbdd.
	 * Devuelve si se ha podido insertar
	 * @param user Usuario
	 * @return true/false
	 */
	public boolean insertar(Usuario user) throws DAOException {
		Connection conn;
		boolean resultado=false;
		
		try {
			conn = ds.getConnection();
			String sql = "INSERT INTO usuarios (nombre, clave, tipo_usu, urlimagen, rol, fecha_hora) VALUES (?,?,?,?,?,?)";
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, user.getNombre());
			st.setString(2, user.getClave());
			st.setInt(3, user.getTipo_usu());
			st.setString(4, user.getUrlimagen());
			st.setInt(5, user.getRol());
			st.setTimestamp(6, user.getFecha_hora());
			System.out.println("Se va a insertar el usuario="+user.getNombre());
			int contador = st.executeUpdate();
			if (contador == 1) {
				System.out.println("Se ha insertado el usuario="+user.getNombre());
				resultado=true;
			}
			st.close();
			conn.close();	
		}
		catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Error de acceso a la base de datos. UsuariosDAO.");
			throw (new DAOException("Error en insertar(usuario) de UsuariosDAO"));
		}
		return resultado;
	}
}


	
