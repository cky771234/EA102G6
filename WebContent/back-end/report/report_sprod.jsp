<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.rep_sprod.model.*"%>

<%
	Rep_sprodService rspSvc = new Rep_sprodService();
	List<Rep_sprodVO> list = rspSvc.getAll();
	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="sprodSvc" scope="page" class="com.shop_product.model.Shop_productService" />
<jsp:useBean id="memberSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="vendorSvc" scope="page" class="com.vendor.model.VendorService" />

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" 	 content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" 	 content="">
<title>檢舉管理 - 商城</title>

<!-- Custom fonts for this template -->
<link href="<%=request.getContextPath()%>/back-end/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="<%=request.getContextPath()%>/back-end/css/sb-admin-2.min.css" rel="stylesheet">
<!-- Custom styles for this page -->
<link href="<%=request.getContextPath()%>/back-end/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/back-end/css/back-main.css" rel="stylesheet">

<style>
th {
	font-weight: bold;
	font-size: 20px;
}
</style>
</head>

<body id="page-top">

	<div class="showBox">
		<div class="showCancel">
			<input type="reset" name="cancel" value="X">
		</div>
		<p></p>
	</div>

	<div class="changeText" name="changeBox">
		<div class="showCancel">
			<input type="reset" name="cancel" value="X">
		</div>
	</div>
	<!-- Page Wrapper -->
	<div id="wrapper">
		
		<%@ include file="sidebar.file" %>
		
		<!-- Begin Page Content -->
        <div class="container-fluid">

		<!-- Page Heading -->
        <h1 class="h3 mb-2 text-gray-800" style="margin-top: 35px; font-weight:bold;">商城檢舉審核</h1>

		<!-- DataTales Example -->
        <div class="card shadow mb-4">
        <div class="content" style="margin-top:20px;">
				<div class="animated fadeIn" style="height:700px;">
					<ul class="nav nav-tabs" id="myTab" role="tablist">
						<li class="nav-item">
							<a class="nav-link active" id="home-tab"
							   data-toggle="tab" href="#rep_sprod" role="tab"
							   aria-controls="home" aria-selected="true">
							審核商城檢舉</a></li>
					</ul>

					<div class="tab-content" id="myTabContent">

						<div class="tab-pane fade show active" id="rep_sprod"
							 role="tabpanel" aria-labelledby="home-tab">
							<div class="row" style="margin-top: 20px;">
								<div class="col-md-12">
									<div class="card">
										<div class="card-body">
										<table id="bootstrap-data-table" class="table table-striped table-bordered">
                                    		<thead>
                                       			<tr>
								                    <th>檢舉編號</th>
								                    <th>商品名稱</th>
								                    <th>廠商</th>
								                    <th>上架時間</th>
								                    <th>檢舉原因</th>
								                    <th>檢舉狀態</th>
								                    <th>檢舉處理</th>
							                    </tr>
                                    		</thead>
		                                    <tbody>
							                  	<c:forEach var="repsprodVO" items="${list}">
							                    <tr>
							                      <td><h6>${repsprodVO.repNo}</h6></td>
							                      <td>
							                      	<c:forEach var="sprodVO" items="${sprodSvc.all}">
							                    		<c:if test="${repsprodVO.prodNo==sprodVO.prodNo}">
								                    		<h6>${sprodVO.prodName}</h6>
							                    		</c:if>
							                		</c:forEach>
							                      </td>
							                      <td>
							                      	<c:forEach var="sprodVO" items="${sprodSvc.all}">
							                    		<c:if test="${repsprodVO.prodNo==sprodVO.prodNo}">
									                      	<c:forEach var="venVO" items="${vendorSvc.all}">
									                    		<c:if test="${sprodVO.venNo==venVO.venNo}">
										                    		<h6>${venVO.venName}</h6>
									                    		</c:if>
									                		</c:forEach>
							                			</c:if>
							                		</c:forEach>
							                	  </td>
							                      <td>
							                      	<fmt:formatDate value="${repsprodVO.repTime}" pattern="yyyy-MM-dd"/><br>
										    		<fmt:formatDate value="${repsprodVO.repTime}" pattern="HH:mm:ss"/>
							                      </td>
							                      <td><h6>${repsprodVO.repReason}</h6></td>
							                      <td>
							                      	<c:if test="${repsprodVO.repStatus=='0'}"><h6>未處理</h6></c:if>
							                      	<c:if test="${repsprodVO.repStatus=='1'}"><h6>檢舉通過</h6></c:if>
							                      	<c:if test="${repsprodVO.repStatus=='2'}"><h6>檢舉未通過</h6></c:if>
							                      </td>
							                      <td>
							                      	<button type="button" class="btn btn-primary"
															data-toggle="modal"
															data-target="#${repsprodVO.repNo}"
															style="background-color: #E7AB3C; border: #E7AB3C;">審核檢舉</button>
													<!-- Modal -->
													<div class="modal fade" id="${repsprodVO.repNo}"
														 tabindex="-1" role="dialog"
														 aria-labelledby="exampleModalCenterTitle"
														 aria-hidden="true">
														<div class="modal-dialog modal-dialog-centered"
															 role="document">
															<div class="modal-content">
																<div class="modal-header">
																	<h5 class="modal-title"	id="exampleModalCenterTitle"
																		style="font-weight:bold; font-size:26px;">審核結果</h5>
																	<button type="button" class="close"
																			data-dismiss="modal" aria-label="Close">
																		<span aria-hidden="true">&times;</span>
																	</button>
																</div>
																<div class="modal-body" style="text-align: center;">
																	<button type="button" style="margin-right:20px; font-size:14px;"
																			class="btn btn-primary rep_submit" value="addEval"
																			data-dismiss="modal">檢舉未通過</button>
																		<input type="hidden" class="repno"  value="${repsprodVO.repNo}">
																		<input type="hidden" class="action" value="..."> 
																	<button type="button" style="background-color: red; border:red; 
																								 margin-left:20px; font-size:14px;"
																			class="btn btn-secondary rep_submit"
																			data-dismiss="modal">檢舉通過</button>
																		<input type="hidden" class="action" value="...">
																</div>
															</div>
														</div>
												  	</div>
							                      </td>
							                    </tr>
							                    </c:forEach>
							                  </tbody>
							                  <tfoot>
							                  	<tr>
								                    <th>檢舉編號</th>
								                    <th>商品名稱</th>
								                    <th>廠商</th>
								                    <th>上架時間</th>
								                    <th>檢舉原因</th>
								                    <th>檢舉狀態</th>
								                    <th>檢舉處理</th>
							                    </tr>
							                  </tfoot>
                                		</table>
										</div>
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
        </div>

		<!-- Footer -->
		<footer class="sticky-footer bg-white">
			<div class="container my-auto">
				<div class="copyright text-center my-auto">
					<span>Copyright &copy; EA102-G6 2020</span>
				</div>
			</div>
		</footer>
		<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> 
		<i	class="fas fa-angle-up"></i>
	</a>

	<!-- Logout Modal-->
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">確定要登出嗎?</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">選取登出選項確認登出</div>
				<div class="modal-footer">
				<FORM METHOD="post" ACTION="emp.do" name="logout">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">取消</button>
					<input type="hidden" name="action" value="logout" style=""display=none;">
					<input type="submit" class="btn btn-primary" value="登出" id='logout'>
				</FORM>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript-->
	<script src="<%=request.getContextPath()%>/back-end/vendor/jquery/jquery.min.js"></script>
	<script	src="<%=request.getContextPath()%>/back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script	src="<%=request.getContextPath()%>/back-end/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="<%=request.getContextPath()%>/back-end/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script	src="<%=request.getContextPath()%>/back-end/vendor/datatables/jquery.dataTables.min.js"></script>
	<script	src="<%=request.getContextPath()%>/back-end/vendor/datatables/dataTables.bootstrap4.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="<%=request.getContextPath()%>/back-end/js/demo/datatables-demo.js"></script>
	<script src="https://kit.fontawesome.com/dd027c1f63.js"	crossorigin="anonymous"></script>
	<script src="<%=request.getContextPath()%>/back-end/js/demo/datatables-demo.js"></script>
	<script src="<%=request.getContextPath()%>/back-end/js/back-Main.js"></script>
	
</body>
</html>
