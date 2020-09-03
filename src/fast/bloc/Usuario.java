package fast.bloc;
import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;

public class Usuario {

	public static final int ADMINISTRADOR = 0;
	public static final int CLIENTE = 1;
	public static final int ADMIN = 0;
	public static final int VISOR_EDITOR = 1;
	public static final int VISOR = 2;
	
	private String nombre;
	private String clave;
	private int tipo_usu;
	private String urlimagen;
	private int rol;
	private Timestamp fecha_hora;
	

	public int getTipo_usu() {
		return tipo_usu;
	}

	public void setTipo_usu(int tipo_usu) {
		this.tipo_usu = tipo_usu;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public Usuario() {

	}
	
	public Usuario(String nombre) {
		this.nombre = nombre;
	}

	public String getUrlimagen() {
		return urlimagen;
	}

	public void setUrlimagen(String urlimagen) {
		this.urlimagen = urlimagen;
	}

	public int getRol() {
		return rol;
	}

	public void setRol(int rol) {
		this.rol = rol;
	}

	public String getClave() {
		return clave;
	}

	public void setClave(String clave) {
		this.clave = clave;
	}

	public Timestamp getFecha_hora() {
		return fecha_hora;
	}
	public String[] getFecha_hora_format() {
	     DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyy HH:mm");
	     String formattedDate = formatter.format(fecha_hora.toLocalDateTime());
	     String[] fechaYhora = formattedDate.split(" ");
	     return fechaYhora; //fechaYhora[0]=fecha, fechaYhora[1]=hora
	}	

	public void setFecha_hora(Timestamp fecha_hora) {
		this.fecha_hora = fecha_hora;
	}
	
}
