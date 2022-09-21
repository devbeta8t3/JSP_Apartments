package db.beans;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class QueryBean {

	Connection conn;
	Statement stmt;
	ResultSet rs;

	public QueryBean() {
		conn = null;
		stmt = null;
		rs = null;
	}

	public void getConnection() {
		try {
			conn = DBConnection.getConnection();
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		try {
			stmt = conn.createStatement();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void closeConnection() {
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	// (참고용 메소드 코드)
	/**
	 * 사용자 ID를 검색하여 사용자 아이디, 이름, 전화번호, 등급, 작성시각을 ArrayList로 리턴하는 함수 
	 * @return (ArrayList) res 
	 */
//	public ArrayList getUserInfo(String user_id) throws Exception {
//
//		StringBuffer sb = new StringBuffer();
//
//		sb.append("SELECT");
//		sb.append("   U_ID, U_NAME, U_PHONE, U_GRADE, WRITE_TIME ");
//		sb.append(" FROM ");
//		sb.append("   USER_INFO_SAMPLE");
//		sb.append(" WHERE ");
//		sb.append("   U_ID LIKE '%"+user_id+"%' ");
//		sb.append(" ORDER BY");
//		sb.append("     WRITE_TIME");
//
//		rs = stmt.executeQuery(sb.toString());
//
//		ArrayList res = new ArrayList();
//		while (rs.next()) {
//
//			res.add(rs.getString(1));
//			res.add(rs.getString(2));
//			res.add(rs.getString(3));
//			res.add(rs.getString(4));
//			res.add(rs.getString(5));
//			
//		}
//		System.out.println(sb.toString());
//		return res;
//	}
	
	/**
	 * 선택된 도이름으로 시군구 이름을 ArrayList로 리턴하는 메소드 
	 * @param doName : select id="doSelect"에서 선택된 value
	 * @return (ArrayList) res : 시군구 리스트
	 * @throws Exception
	 */
	public ArrayList getSiName(String doName) throws Exception {

		StringBuffer sb = new StringBuffer();
		System.out.println("넘어온 doName 값 : " +doName);	
		sb.append("SELECT");
		sb.append("   DISTINCT 시군구명 ");
		sb.append(" FROM ");
		sb.append("   dongcode ");	//테이블명
		sb.append(" WHERE ");
		sb.append("   시도명 = '"+doName+"' AND 시군구명 IS NOT NULL ");
		sb.append(" ORDER BY");
		sb.append("   시군구명");

		rs = stmt.executeQuery(sb.toString());	// Query 실행

		ArrayList res = new ArrayList();
		while (rs.next()) {
			res.add(rs.getString(1));
			//res.add(rs.getString(2));
		}
		
		System.out.println(sb.toString());	// 실행된 쿼리문 출력
		System.out.println(res.toString());	// 실행된 쿼리문 출력
		return res;
	}

	/**
	 * 선택된 시군구 이름으로 읍면동 이름을 ArrayList로 리턴하는 메소드 
	 * @param doName
	 * @return ArrayList res
	 * @throws Exception
	 */
	public ArrayList getDongName(String siName, String doName) throws Exception {

		StringBuffer sb = new StringBuffer();

		sb.append("SELECT");
		sb.append("   DISTINCT 법정동코드, 읍면동명 ");
		sb.append(" FROM ");
		sb.append("   dongcode ");	//테이블명
		sb.append(" WHERE ");
		sb.append("   시군구명 = '"+siName+"' AND 시도명 = '"+doName+"' AND 읍면동명 IS NOT NULL AND 리명 IS NULL ");
		sb.append(" ORDER BY");
		sb.append("   읍면동명");

		rs = stmt.executeQuery(sb.toString());	// Query 실행

		ArrayList res = new ArrayList();
		while (rs.next()) {
			res.add(rs.getString(1));
			res.add(rs.getString(2));
		}
		
		System.out.println(sb.toString());	// 실행된 쿼리문 출력
		System.out.println(res.toString());	// 실행된 쿼리문 출력
		return res;
	}
}