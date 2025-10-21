package com.trip.user.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.test.util.DBUtil;
import com.trip.user.model.UserDTO;

public class UserDAO {

	private DBUtil util;
	private Connection conn;
	private Statement stat;
	private PreparedStatement pstat;
	private ResultSet rs;

	public UserDAO() {
		try {
			util = new DBUtil();
			conn = util.open();
			stat = conn.createStatement();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public UserDTO login(UserDTO dto) {
		//queryParamDTOReturn
				try {
							
					
					String sql = "select * from tblUser where username = ? and password = ?";
					
					pstat = conn.prepareStatement(sql);
					pstat.setString(1, dto.getId());
					pstat.setString(2, dto.getPw());
					
					/*
					 * String q1 =
					 * "SELECT COUNT(*) cnt FROM tblUser WHERE LOWER(username)=LOWER(?)"; try
					 * (PreparedStatement ps = conn.prepareStatement(q1)) { ps.setString(1,
					 * dto.getId()); try (ResultSet r = ps.executeQuery()) { if (r.next())
					 * System.out.println("[diag] ID 일치 건수: " + r.getInt("cnt")); } }
					 * 
					 * // 2) ID+PW 둘 다 맞는지 String q2 =
					 * "SELECT COUNT(*) cnt FROM tblUser WHERE LOWER(username)=LOWER(?) AND pw=?";
					 * try (PreparedStatement ps = conn.prepareStatement(q2)) { ps.setString(1,
					 * dto.getId()); ps.setString(2, dto.getPw()); try (ResultSet r =
					 * ps.executeQuery()) { if (r.next()) System.out.println("[diag] ID+PW 일치 건수: "
					 * + r.getInt("cnt")); } }
					 */

					
					rs = pstat.executeQuery();
					
					
					if (rs.next()) {
						System.out.println("test1");

						UserDTO result = new UserDTO();
						
						result.setId(rs.getString("username"));
						result.setNickName(rs.getString("nickname"));
						result.setName(rs.getString("real_name"));
						result.setSeq(rs.getString("user_id"));
						return result;
						
						
					}	
					
				} catch (Exception e) {
					e.printStackTrace();
				}
						
				
				return null;
			}

	public UserDTO userInfo(UserDTO dto, String seq) {
		//queryParamDTOReturn
		try {
					
			
			String sql = "select * from tblUser where user_id = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, seq);
			
			/*
			 * String q1 =
			 * "SELECT COUNT(*) cnt FROM tblUser WHERE LOWER(username)=LOWER(?)"; try
			 * (PreparedStatement ps = conn.prepareStatement(q1)) { ps.setString(1,
			 * dto.getId()); try (ResultSet r = ps.executeQuery()) { if (r.next())
			 * System.out.println("[diag] ID 일치 건수: " + r.getInt("cnt")); } }
			 * 
			 * // 2) ID+PW 둘 다 맞는지 String q2 =
			 * "SELECT COUNT(*) cnt FROM tblUser WHERE LOWER(username)=LOWER(?) AND pw=?";
			 * try (PreparedStatement ps = conn.prepareStatement(q2)) { ps.setString(1,
			 * dto.getId()); ps.setString(2, dto.getPw()); try (ResultSet r =
			 * ps.executeQuery()) { if (r.next()) System.out.println("[diag] ID+PW 일치 건수: "
			 * + r.getInt("cnt")); } }
			 */

			
			rs = pstat.executeQuery();
			
			
			if (rs.next()) {
				System.out.println("test1");

				UserDTO result = new UserDTO();
				
				result.setSeq(rs.getString("user_id"));
				result.setId(rs.getString("username"));
				result.setNickName(rs.getString("nickname"));
				result.setName(rs.getString("real_name"));
				result.setEmail(rs.getString("email"));
				result.setAddress(rs.getString("address"));
				result.setGender(rs.getString("gender"));
				result.setHeight(rs.getString("height"));
				result.setWeight(rs.getString("weight"));
				result.setHealthGoals(rs.getString("health_goals"));
				result.setPhoneNumber(rs.getString("phone_number"));
				return result;
			}	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
				
		
		return null;
	}

	public int userEdit(UserDTO dto, String seq) {
		try {

			String sql = "  update tblUser set real_name = ?, phone_number = ?, username = ?, password = ?, email = ?, nickname = ?, address = ?, gender = ?, height = ?, weight = ?, health_goals =? where user_id = ?";

			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getName());
			pstat.setString(2, dto.getPhoneNumber());
			pstat.setString(3, dto.getId());
			pstat.setString(4, dto.getPw());
			pstat.setString(5, dto.getEmail());
			pstat.setString(6, dto.getNickName());
			pstat.setString(7, dto.getAddress());
			pstat.setString(8, dto.getGender());
			pstat.setString(9, dto.getHeight());
			pstat.setString(10, dto.getWeight());
			pstat.setString(11, dto.getHealthGoals());
			pstat.setString(12, dto.getSeq());

			return pstat.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	public int register(UserDTO dto) {
		//queryParamNoReturn
				try {

					String sql = "insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals) values (seqUser.nextVal, 1, ?, ?, ?, ?, ?, ?, ?, ?, sysdate, null, ?,  ?, ?, ?)";

					pstat = conn.prepareStatement(sql);
					pstat.setString(1, dto.getName());
					pstat.setString(2, dto.getSsn());
					pstat.setString(3, dto.getPhoneNumber());
					pstat.setString(4, dto.getId());
					pstat.setString(5, dto.getPw());
					pstat.setString(6, dto.getEmail());
					pstat.setString(7, dto.getNickName());
					pstat.setString(8, dto.getAddress());
					pstat.setString(9, dto.getGender());
					pstat.setString(10, dto.getHeight());
					pstat.setString(11, dto.getWeight());
					pstat.setString(12, dto.getHealthGoals());
					return pstat.executeUpdate();

				} catch (Exception e) {
					e.printStackTrace();
				}
				
				return 0;
	}


	public int  userDelCheck(UserDTO dto) {
		try {
			
			
			String sql = "select * from tblUser where user_id = ? and password = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getSeq());
			pstat.setString(2, dto.getPw());
		
			
			rs = pstat.executeQuery();
			
			
			if (rs.next()) {
				System.out.println("test1");

				UserDTO result = new UserDTO();
				
				result.setId(rs.getString("username"));
				result.setNickName(rs.getString("nickname"));
				result.setName(rs.getString("real_name"));
				result.setSeq(rs.getString("user_id"));
				return 1;
			}	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
				
		
		return 0;
	}

	public int userDel(UserDTO dto) {
		try {

			String sql = "update tblUser set user_status_id = 2 where user_id = ? and password = ?";

			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getSeq());
			pstat.setString(2, dto.getPw());

			return pstat.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
		
	}

	public int loginCheck(UserDTO dto) {
		try {
			
			
			String sql = "select * from tblUser where user_id = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getSeq());
			
			/*
			 * String q1 =
			 * "SELECT COUNT(*) cnt FROM tblUser WHERE LOWER(username)=LOWER(?)"; try
			 * (PreparedStatement ps = conn.prepareStatement(q1)) { ps.setString(1,
			 * dto.getId()); try (ResultSet r = ps.executeQuery()) { if (r.next())
			 * System.out.println("[diag] ID 일치 건수: " + r.getInt("cnt")); } }
			 * 
			 * // 2) ID+PW 둘 다 맞는지 String q2 =
			 * "SELECT COUNT(*) cnt FROM tblUser WHERE LOWER(username)=LOWER(?) AND pw=?";
			 * try (PreparedStatement ps = conn.prepareStatement(q2)) { ps.setString(1,
			 * dto.getId()); ps.setString(2, dto.getPw()); try (ResultSet r =
			 * ps.executeQuery()) { if (r.next()) System.out.println("[diag] ID+PW 일치 건수: "
			 * + r.getInt("cnt")); } }
			 */

			
			rs = pstat.executeQuery();
			
			
			if (rs.next()) {

				UserDTO result = new UserDTO();
				
				System.out.println("확인용 : "+rs.getInt("user_status_id"));
				
				return rs.getInt("user_status_id");
			}	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
				
		
		return 0;
		
	}

	public int emailCheck(String email) {
		try {
			
			
			String sql = "select * from tblUser where email = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, email);
			
			/*
			 * String q1 =
			 * "SELECT COUNT(*) cnt FROM tblUser WHERE LOWER(username)=LOWER(?)"; try
			 * (PreparedStatement ps = conn.prepareStatement(q1)) { ps.setString(1,
			 * dto.getId()); try (ResultSet r = ps.executeQuery()) { if (r.next())
			 * System.out.println("[diag] ID 일치 건수: " + r.getInt("cnt")); } }
			 * 
			 * // 2) ID+PW 둘 다 맞는지 String q2 =
			 * "SELECT COUNT(*) cnt FROM tblUser WHERE LOWER(username)=LOWER(?) AND pw=?";
			 * try (PreparedStatement ps = conn.prepareStatement(q2)) { ps.setString(1,
			 * dto.getId()); ps.setString(2, dto.getPw()); try (ResultSet r =
			 * ps.executeQuery()) { if (r.next()) System.out.println("[diag] ID+PW 일치 건수: "
			 * + r.getInt("cnt")); } }
			 */

			
			rs = pstat.executeQuery();
			
			
			if (rs.next()) {
				System.out.println("test1");
				return 1;
				
				
			}	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
				
		
		return 0;
	}

	public int idCheck(String id) {
try {
			
			
			String sql = "select * from tblUser where username = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, id);
			
			/*
			 * String q1 =
			 * "SELECT COUNT(*) cnt FROM tblUser WHERE LOWER(username)=LOWER(?)"; try
			 * (PreparedStatement ps = conn.prepareStatement(q1)) { ps.setString(1,
			 * dto.getId()); try (ResultSet r = ps.executeQuery()) { if (r.next())
			 * System.out.println("[diag] ID 일치 건수: " + r.getInt("cnt")); } }
			 * 
			 * // 2) ID+PW 둘 다 맞는지 String q2 =
			 * "SELECT COUNT(*) cnt FROM tblUser WHERE LOWER(username)=LOWER(?) AND pw=?";
			 * try (PreparedStatement ps = conn.prepareStatement(q2)) { ps.setString(1,
			 * dto.getId()); ps.setString(2, dto.getPw()); try (ResultSet r =
			 * ps.executeQuery()) { if (r.next()) System.out.println("[diag] ID+PW 일치 건수: "
			 * + r.getInt("cnt")); } }
			 */

			
			rs = pstat.executeQuery();
			
			
			if (rs.next()) {
				System.out.println("test1");
				return 1;
				
				
			}	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
				
		
		return 0;
	}

	public String idSelect(String email, String name) {
try {
			
			
			String sql = "select * from tblUser where email = ? and real_name = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, email);
			pstat.setString(2, name);
			
			rs = pstat.executeQuery();
			
			
			if (rs.next()) {
				System.out.println("test1");

				return rs.getString("username");
			}	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
				
		
		return null;
	}

	public String PwSelect(String email, String id) {
try {
		String sql = "select * from tblUser where email = ? and username = ?";
		
		pstat = conn.prepareStatement(sql);
		pstat.setString(1, email);
		pstat.setString(2, id);
		
		rs = pstat.executeQuery();
		
		
		if (rs.next()) {
			System.out.println("test1");

			return rs.getString("username");
		}	
		
	} catch (Exception e) {
		e.printStackTrace();
	}
			
	
	return null;
	}

	public void PwUpdate(String email, String id, String validNumber) {
		try {

			
			String sql = "update tblUser set password = ? where TRIM(email) = ? and TRIM(username) = ?";

			pstat = conn.prepareStatement(sql);
			pstat.setString(1, validNumber);
			pstat.setString(2, email);
			pstat.setString(3, id);

			System.out.println(validNumber);
			System.out.println(email);
			System.out.println(id);

			pstat.executeUpdate();
			

		} catch (Exception e) {
			e.printStackTrace();
		}

		
		
	}
	


	
}
