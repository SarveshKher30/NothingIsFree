
<%@page import="com.helper.UserModel"%>

<!-- Navigation -->
<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header page-scroll">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand page-scroll" href="<%=request.getContextPath()%>/pages/home.jsp">Semantic Search</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav navbar-right">

				<%UserModel um=(UserModel)session.getAttribute("USER_MODEL");
				//System.out.println(um.getRole());
            		if(um!=null){
            			
            			
            			if(um.getRole().equalsIgnoreCase("1")){
            				System.out.println("test");
            				%>

				<!-- Collect the nav links, forms, and other content for toggling -->


				<li><a class="page-scroll" href="<%=request.getContextPath()%>/pages/home.jsp">Home</a></li>
				<li><a class="page-scroll" href="<%=request.getContextPath()%>/pages/userList.jsp">User List</a></li>
				
				<!-- /.navbar-collapse -->

				<%
            			} else if(um.getRole().equalsIgnoreCase("2")){
            				%>
				<!-- Collect the nav links, forms, and other content for toggling -->

				<li class="hidden"><a href="#page-top"></a></li>
<%-- 				<li><a class="page-scroll" href="<%=request.getContextPath()%>/pages/pendingApprovals.jsp">Request</a></li> --%>
				<li><a class="page-scroll" href="<%=request.getContextPath()%>/pages/fileList.jsp">My Uploads</a></li>
				
				<li><a class="page-scroll" href="<%=request.getContextPath()%>/pages/fileUpload.jsp">Upload</a></li>
				<li><a class="page-scroll" href="<%=request.getContextPath()%>/pages/search.jsp">Search</a></li>
<%-- 				<li><a class="page-scroll" href="<%=request.getContextPath()%>/pages/viewShareFile.jsp">Shared File</a></li> --%>
				<li><a class="page-scroll" href="<%=request.getContextPath()%>/pages/viewFiles.jsp">File Status</a></li>
				<li><a class="page-scroll" href="<%=request.getContextPath()%>/pages/recievedKeys.jsp">Received</a></li>
<%-- 				<li><a class="page-scroll" href="<%=request.getContextPath()%>/pages/fileUpload.jsp">Re-Upload File</a></li> --%>
				<!-- /.navbar-collapse -->

				<%}%>
				<li><a class="page-scroll" href="<%=request.getContextPath()%>/pages/profile.jsp">Edit Profile</a></li>
				<li><a class="page-scroll" href="<%=request.getContextPath()%>/tiles/ajax.jsp?methodId=logout">Logout</a></li>
				<%
            		}else{
            			%>
				<li><a class="page-scroll" href="<%=request.getContextPath()%>/pages/login.jsp">Login</a></li>
				<li><a class="page-scroll" href="<%=request.getContextPath()%>/pages/registration.jsp">Register</a></li>

				<%
            		}



%>
			</ul>
		</div>

	</div>
	<!-- /.container-fluid -->
</nav>
