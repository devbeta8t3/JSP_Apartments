package db.beans;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	
	public static Connection getConnection() throws Exception
	{
		System.out.println("DB 드라이버 로드");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		System.out.println("DB 연결 중");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "apt", "1234");
		System.out.println("DB 연결 성공");
		return conn;
	}
}