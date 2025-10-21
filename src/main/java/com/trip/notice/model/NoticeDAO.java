package com.trip.notice.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Map;

import com.test.util.DBUtil;

public class NoticeDAO {

	private DBUtil util;
	private Connection conn;
	private Statement stat;
	private PreparedStatement pstat;
	private ResultSet rs;

	public NoticeDAO() {
		try {
			util = new DBUtil();
			conn = util.open();
			stat = conn.createStatement();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ArrayList<NoticeDTO> getList(Map<String, String> map) {
		ArrayList<NoticeDTO> list = new ArrayList<NoticeDTO>();
		try {
			
			String where = "";
			
			//검색어 O
			if ("y".equals(map.get("search"))) {
				where = String.format("where %s like '%%' || ? || '%%'", map.get("column"));
			}

			String sql = String.format(
					"select * from (select a.*, rownum as rnum from (select * from tblNoticePost %s order by notice_regdate desc) a) where rnum between ? and ?"
					, where
			);

			pstat = conn.prepareStatement(sql);
			
			int index = 1;
			
			if ("y".equals(map.get("search"))) {
				pstat.setString(index++, map.get("word"));
			}
			pstat.setString(index++, map.get("begin"));
			pstat.setString(index++, map.get("end"));

			rs = pstat.executeQuery();
			
			while (rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				
				dto.setRnum(rs.getString("rnum"));
				dto.setNotice_post_id(rs.getString("notice_post_id"));
				dto.setAdmin_id(rs.getString("admin_id"));
				dto.setNotice_header(rs.getString("notice_header"));
				dto.setNotice_view_count(rs.getString("notice_view_count"));
				dto.setNotice_regdate(rs.getString("notice_regdate"));
				
				list.add(dto);	
			}
			
			return list;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public int getTotalCount(Map<String, String> map) {
		
		try {
			String where = "";
			
			if ("y".equals(map.get("search"))) {
				where = String.format("where %s like '%%' || ? || '%%'", map.get("column"));
			}
			
			String sql = "select count(*) as cnt from tblNoticePost" + where;
			
			pstat = conn.prepareStatement(sql);
			
			if("y".equals(map.get("search"))) {
				pstat.setString(1, map.get("word"));
			}
			
			rs = pstat.executeQuery();
			
			if (rs.next()) {

				return rs.getInt("cnt");				
			}	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}

	
}