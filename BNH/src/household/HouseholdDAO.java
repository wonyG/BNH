package household;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class HouseholdDAO {

	private Connection conn;
	private ResultSet rs;
	
	public HouseholdDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BNH";
			String dbID = "root";
			String dbPassword ="1111";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
							
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			
		} catch (Exception e) {
			
		}		
		return "";	// DB Error
	}
	
	public int getNext() {
		String SQL = "SELECT householdID FROM household ORDER BY householdID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;	// if First Item
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return -1;	//DB Error
	}
	
	public int write(int householdInOut, String userID, String householdContent, int householdPrice) {
		String SQL = "INSERT INTO Household VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, householdInOut);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, householdContent);
			pstmt.setInt(6, householdPrice);
			pstmt.setInt(7, 1);
			return pstmt.executeUpdate();			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return -1;	//DB Error
	}
	
	public ArrayList<Household> getList(int pageNumber){
		String SQL = "SELECT * FROM Household WHERE HouseholdID < ? AND HouseholdAvailable = 1 ORDER BY householdID DESC LIMIT 10";
		ArrayList<Household> list = new ArrayList<Household>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Household household = new Household();
				household.setHouseholdID(rs.getInt(1));
				household.setHouseholdInOut(rs.getInt(2));
				household.setUserID(rs.getString(3));
				household.setHouseholdDate(rs.getString(4));
				household.setHouseholdContent(rs.getString(5));
				household.setHouseholdPrice(rs.getInt(6));
				household.setHouseholdAvailable(rs.getInt(7));
				list.add(household);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM Household WHERE HouseholdID < ? AND HouseholdAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return false;
	}
	
	public Household getHousehold(int householdID) {
		String SQL = "SELECT * FROM Household WHERE HouseholdID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, householdID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Household household = new Household();
				household.setHouseholdID(rs.getInt(1));
				household.setHouseholdInOut(rs.getInt(2));
				household.setUserID(rs.getString(3));
				household.setHouseholdDate(rs.getString(4));
				household.setHouseholdContent(rs.getString(5));
				household.setHouseholdPrice(rs.getInt(6));
				household.setHouseholdAvailable(rs.getInt(7));
				return household;
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return null;		
	}
	
	public int update(int householdID, int householdInOut, String householdContent, int householdPrice) {
		String SQL = "UPDATE Household SET householdInOut = ?, householdContent = ?, householdPrice = ? WHERE householdID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, householdInOut);
			pstmt.setString(2, householdContent);
			pstmt.setInt(3, householdPrice);
			pstmt.setInt(4, householdID);
			return pstmt.executeUpdate();			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return -1;	//DB Error
	}
	
	public int delete(int householdID) {
		String SQL = "UPDATE household SET householdAvailable = 0 WHERE householdID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, householdID);
			return pstmt.executeUpdate();			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return -1;	//DB Error		
	}

}