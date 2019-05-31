<%@page import="com.helper.FileUploadDownloadHelper"%>
<%@page import="com.constant.ServerConstants"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="com.helper.HttpHelper"%>
<%@page import="java.util.List"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="com.helper.UserModel"%>
<%@page import="java.io.ObjectOutputStream"%>
<%@page import="com.database.ConnectionManager"%>

<%@page import="com.helper.StringHelper"%>  
<%@page import="java.util.HashMap"%>
<%@ page trimDirectiveWhitespaces="true" %>    
<%
	String sMethod = StringHelper.n2s(request  
	.getParameter("methodId"));
	String returnString = "";
	System.out.println("HIIIII");
	boolean bypasswrite=false;
	HashMap parameters = StringHelper.displayRequest(request);
	System.out.println("HIIIII parameters List:"+parameters);
	if (sMethod.equalsIgnoreCase("registerNewUser")) { 
		returnString = ConnectionManager.insertUser(parameters);
		}

else if (sMethod.equalsIgnoreCase("update")) { 
		returnString = ConnectionManager.updateUser(parameters);
	}else if (sMethod.equalsIgnoreCase("uploadFile")) { 
		HashMap uploadMap=HttpHelper.parseMultipartRequest(request);
		uploadMap.putAll(parameters);
		if(session.getAttribute("USER_MODEL")==null){
			 request.getRequestDispatcher("../pages/login.jsp").forward(request, response);
		}
		UserModel um=(UserModel)session.getAttribute("USER_MODEL");
		FileItem fi=(FileItem)uploadMap.get("filenameITEM");
		System.out.println(uploadMap);
		try{
		System.out.println(new File(ServerConstants.LOCAL_UPLOAD).getCanonicalPath());   
		}catch(Exception e){
			
		}
		
		String message=ConnectionManager.uploadDocument(fi,um.getUid(),um.getRole(),um.getName(), um.getUserkey());
		request.setAttribute("MESSAGE", message);
		 request.getRequestDispatcher("../pages/fileUpload.jsp").forward(request, response);
	}
	else if (sMethod.equalsIgnoreCase("deleteFile")) { 
	
		if(session.getAttribute("USER_MODEL")==null){
			 request.getRequestDispatcher("../pages/login.jsp").forward(request, response);
		}
		UserModel um=(UserModel)session.getAttribute("USER_MODEL");
 		parameters.put("userId", um.getUid());
// 		ConnectionManager.deleteDoCument(parameters);  
		  
		 response.sendRedirect(request.getContextPath()+"/pages/fileList.jsp");
	}
	else if (sMethod.equalsIgnoreCase("deleteUser")) { 
		
		String resp = ConnectionManager.deleteUser(parameters);    
		request.setAttribute("MESSAGE", resp);
		request.getRequestDispatcher("../pages/userList.jsp").forward(request, response);
	}

	else if (sMethod.equalsIgnoreCase("decryptCipher")) { 
		returnString = ConnectionManager.decrypt(parameters);   
	}else if (sMethod.equalsIgnoreCase("decryptKey")) { 
		String fid=request.getParameter("fid");
		UserModel um=(UserModel)session.getAttribute("USER_MODEL");
		
		returnString = ConnectionManager.decryptKey(fid,um.getPrivatekey());   
	}

else if (sMethod.equalsIgnoreCase("viewFile")) { 
		
		String fid = StringHelper.n2s(request.getParameter("fileId"));
		String key = StringHelper.n2s(request.getParameter("key"));
		String path = ConnectionManager.getOrigianlFilePath(fid,key);
		FileUploadDownloadHelper.downloadFile(path, response);
	}
else if (sMethod.equalsIgnoreCase("viewFilesharefile")) { 
		
		String fid = StringHelper.n2s(request.getParameter("fileId"));
		String key = StringHelper.n2s(request.getParameter("key"));
		String path = ConnectionManager.getFilePath(fid,key);
		FileUploadDownloadHelper.downloadFile(path, response);
	}
else if (sMethod.equalsIgnoreCase("viewGrpsharedfile")) { 
	
	String gid = StringHelper.n2s(request.getParameter("gid"));
	String key = StringHelper.n2s(request.getParameter("key"));
	String path = ConnectionManager.getGrpSharedFilePath(gid,key);
	FileUploadDownloadHelper.downloadFile(path, response);
}  

	else if (sMethod.equalsIgnoreCase("sendFileToGrp")) { 
			
	 		String uids[]=request.getParameterValues("uid");
	 		String docId=request.getParameter("docId");
	 		String edate=request.getParameter("edate");
	 		String permission=request.getParameter("permission");
			
	 		returnString= ConnectionManager.sendFileToGroup(uids,docId,edate,permission);
			
	 	}
	else if (sMethod.equalsIgnoreCase("approveFile")) { 
	
	
		String resp = ConnectionManager.approveFile(parameters);  
		request.setAttribute("MESSAGE", resp);
		request.getRequestDispatcher("../pages/pendingApprovals.jsp").forward(request, response);
	}
	else if (sMethod.equalsIgnoreCase("approveFileWrite")) { 
	
	
		String resp = ConnectionManager.approveFileWrite(parameters);   
		request.setAttribute("MESSAGE", resp);
		request.getRequestDispatcher("../pages/pendingApprovals.jsp").forward(request, response);
	}
	else if (sMethod.equalsIgnoreCase("downloadFile")) { 
	
		String fid = StringHelper.n2s(request.getParameter("fileId"));
		String key = StringHelper.n2s(request.getParameter("key"));
		String path = ConnectionManager.getFilePath(fid,key); 
		FileUploadDownloadHelper.downloadFile(path, response);

	}
else if (sMethod.equalsIgnoreCase("downloadOriginaldFile")) { 
	
		String fid = StringHelper.n2s(request.getParameter("fileId"));
		String key = StringHelper.n2s(request.getParameter("key"));
		String path = ConnectionManager.getOrigianlFilePath(fid, key); 
		FileUploadDownloadHelper.downloadFile(path, response);

	}
else if (sMethod.equalsIgnoreCase("downloadFilesharefile")) { 
	
		String fid = StringHelper.n2s(request.getParameter("fileId"));
		String key = StringHelper.n2s(request.getParameter("key"));
		String path = ConnectionManager.getFilePath(fid,key); 
		FileUploadDownloadHelper.downloadFile(path, response);
	}
else if (sMethod.equalsIgnoreCase("downloadGrpShareFile")) { 

	String gid = StringHelper.n2s(request.getParameter("gid"));
	String key = StringHelper.n2s(request.getParameter("key"));
	String path = ConnectionManager.getGrpSharedFilePath(gid,key); 
	FileUploadDownloadHelper.downloadFile(path, response);
}
	else if (sMethod.equalsIgnoreCase("requestFile")) { 
	
	
		String resp = ConnectionManager.requestFile(parameters); 
		request.setAttribute("MESSAGE", resp);
		request.getRequestDispatcher("../pages/search.jsp").forward(request, response);
	}
	else if (sMethod.equalsIgnoreCase("checkLogin")) {
		UserModel um= ConnectionManager.checkLogin(parameters);
		if(um!=null){
	session.setAttribute("USER_MODEL", um);
	returnString="1";
		}else{ 
	returnString="2";
		}
	}
	else if (sMethod.equalsIgnoreCase("logout")) {
	session.removeAttribute("USER_MODEL");
	bypasswrite=true;
%>
			<script>
			window.location.href='<%=request.getContextPath()%>/pages/login.jsp';
			</script>   
			<%
	}
	if(!bypasswrite){
	out.println(returnString);
	}
%>