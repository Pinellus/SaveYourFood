<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page session="true"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Save Your Food</title>
    
    <link rel="stylesheet" href="<c:url value="/vendor/fontawesome/css/font-awesome.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/vendor/animate.css/animate.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/vendor/bootstrap/css/bootstrap.css"/>"/>
    
    <%-- <link rel="stylesheet" href="<c:url value="/vendor/datepicker/bootstrap-datepicker3.min.css"/>"/> --%>

    <link rel="stylesheet" href="<c:url value="/vendor/pickadatejs/lib/themes/default.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/vendor/pickadatejs/lib/themes/default.date.css"/>"/>
    
    <link rel="stylesheet" href="<c:url value="css/base.css"/>">
</head>
<body>
<section id="todoapp">
    <header id="header">
        <h1>Save Your Food</h1>
        
        <div class="panel-body">
            <div class="row">
                <div class="col-xs-12 col-md-12 text-center">
                
	                  <a href="<c:url value="/all"/>" class="btn btn-primary btn-lg" role="button"><span class="glyphicon glyphicon-list"></span> <br/>N° Prodotti<br/> <h2>${prodotti}</h2></a>
	                  <a href="<c:url value="/scadenza"/>" class="btn btn-warning btn-lg" role="button"><span class="glyphicon glyphicon-warning-sign"></span> <br/> In Scadenza<br/><h2>${inscadenza}</h2></a>
	                  <a href="<c:url value="/scaduti"/>" class="btn btn-danger btn-lg" role="button"><span class="glyphicon glyphicon-remove-sign"></span> <br/>Scaduti<br/><h2>${scaduti}</h2></a>
                  
                </div>
                <br/>
                <div class="col-xs-12 col-md-12 text-center">
                
	                  <a href="<c:url value="/all"/>" class="btn btn btn<c:if test="${filter == 'all'}"> btn_underline</c:if>" role="button"></a>
	                  <a href="<c:url value="/scadenza"/>" class="btn btn btn<c:if test="${filter == 'scadenza'}"> btn_underline</c:if>" role="button"></a>
	                 <a href="<c:url value="/scaduti"/>" class="btn btn btn<c:if test="${filter == 'scaduti'}"> btn_underline</c:if>" role="button"></a>
                  
                </div>
            </div>
        </div>
        
        <hr/>
        
        <form action="<c:url value="insert"/>" method="POST" id="eanCode">
            <input type="hidden" name="filter" value="${filter}"/>
            <input id="ean" name="ean" placeholder="Cosa hai acquistato?">
            <input type="hidden" id="name" name="name"/>
            <input type="hidden" id="datascadenza" name="datascadenza"/>
        </form>
    </header>
    <section id="main">
        <input id="toggle-all" type="checkbox">
        <label for="toggle-all">Mark all as complete</label>
        <ul id="todo-list">
            <c:forEach var="toDoItem" items="${items}" varStatus="status">
                <%-- <li id="toDoItem_${status.count}" class="<c:if test="${toDoItem.completed}">completed</c:if>" ondblclick="javascript:document.getElementById('toDoItem_${status.count}').className += ' editing';document.getElementById('toDoItemName_${status.count}').focus();"> --%>
                    <li id="toDoItem_${status.count}" >
                    <div class="view">
                    	<%-- 
                        <form id="toggleForm_${status.count}" action="<c:url value="toggleStatus"/>" method="POST">
                            <input type="hidden" name="id" value="${toDoItem.id}"/>
                            <input type="hidden" name="filter" value="${filter}"/>
                            <input class="toggle" name="toggle" type="checkbox" <c:if test="${toDoItem.completed}">checked</c:if> onchange="javascript:document.getElementById('toggleForm_${status.count}').submit();">
                        </form>
                        --%>
                        
                        <label>
	                        <div class="col-xs-12 col-sm-6 col-lg-8">
	          					${toDoItem.name}
	          				</div>
	                        <div class="col-xs-6 col-md-4 alignme">
	                        	<img src="<c:url value="/img/icons8-schedule-50.png"/>" class="img-responsive pull-left" style="width:30px;height:30px;"/>
	                        	<p>&nbsp;<fmt:formatDate value="${toDoItem.dataScadenza}" pattern="dd-MMM-yyyy"/></p>
	          				</div>
                       
                        </label>
                        <form action="<c:url value="delete"/>" method="POST">
                            <input type="hidden" name="id" value="${toDoItem.id}"/>
                            <input type="hidden" name="filter" value="${filter}"/>
                            <button class="destroy"></button>
                        </form>
                    </div>
                   
                    <form id="updateForm_${status.count}" action="<c:url value="update"/>" method="POST">
                        <input type="hidden" name="id" value="${toDoItem.id}"/>
                        <input type="hidden" name="filter" value="${filter}"/>
                        <input class="edit" id="toDoItemName_${status.count}" name="name" value="${toDoItem.name}" onblur="javascript:document.getElementById('updateForm_${status.count}').submit();"/>
                    </form>
                </li>
            </c:forEach>
        </ul>
    </section>
    <footer id="footer">
        <c:if test="${stats.all > 0}">
            <span id="todo-count"><strong><c:out value="${stats.active}" /></strong>
            <c:choose>
                <c:when test="${stats.active == 1}">
                    item
                </c:when>
                <c:otherwise>
                    items
                </c:otherwise>
            </c:choose>
            left</span>
            <ul id="filters">
                <li>
                    <a <c:if test="${filter == 'all'}">class="selected"</c:if> href="<c:url value="/all"/>">All</a>
                </li>
                <li>
                    <a <c:if test="${filter == 'active'}">class="selected"</c:if> href="<c:url value="active"/>">Active</a>
                </li>
                <li>
                    <a <c:if test="${filter == 'completed'}">class="selected"</c:if> href="<c:url value="completed"/>">Completed</a>
                </li>
            </ul>
            <c:if test="${stats.completed > 0}">
                <form action="<c:url value="clearCompleted"/>" method="POST">
                    <input type="hidden" name="filter" value="${filter}"/>
                    <button id="clear-completed">Clear completed (<c:out value="${stats.completed}" />)</button>
                </form>
            </c:if>
        </c:if>
    </footer>
</section>
<div id="info">
    <p>Double-click to edit a todo</p>
</div>

<div class="modal fade modal-fullscreen" tabindex="-1" role="dialog" id="myModal">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h1 class="modal-title">Inserire Data di Scadenza</h1>
      </div>
      <div class="modal-body">
	      <div class="form-group">
	        <div class="input-group">
	        	<span class="input-group-addon">Nome Prodotto</span>
	        	<input type="text" class="form-control input-lg" id="prodName"/>
	        </div>
	       </div>
	       <div class="form-group"> 
	        <div class="input-group">
	        	<span class="input-group-addon">Data Scadenza</span>
	        	<input type="text" class="form-control input-lg" id="scadenza"/>
	        </div>
	      </div>
      </div>
      <div class="modal-footer center-block">
	      <div class="row">
	      	<div class="col-sm-6">
	        	<button type="button" class="btn btn-primary btn-lg btn-block btn-huge" data-dismiss="modal">Annulla</button>
	        </div>
	        <div class="col-sm-6">
	        	<button type="button" class="btn btn-primary btn-lg btn-block btn-huge" id="SaveModal">Aggiungi Prodotto</button>
	        </div>
	      </div>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script src="<c:url value="/vendor/jquery/dist/jquery.min.js"/>"></script>
<script src="<c:url value="/vendor/bootstrap/js/bootstrap.min.js"/>"></script>

<%-- <script src="<c:url value="/js/bootstrap-datepicker.min.js"/>"></script> --%>
<script src="<c:url value="/vendor/pickadatejs/lib/picker.js"/>"></script>
<script src="<c:url value="/vendor/pickadatejs/lib/picker.date.js"/>"></script>
<script src="<c:url value="/vendor/pickadatejs/lib/translations/it_IT.js"/>"></script>

<script>

$('#scadenza').pickadate({
	format: 'dd/mm/yyyy',
    formatSubmit: 'dd/mm/yyyy',
    selectYears: true,
    selectMonths: true,
    min: new Date(),
    onStart: function() {
        var date = new Date()
        this.set('select', [date.getFullYear(), date.getMonth(), date.getDate()]);
    }
});
<%--
$('#scadenza').datepicker({
    autoclose: true,
    format: "dd/mm/yyyy",
    todayHighlight: true,
    orientation: "bottom auto",
    toggleActive: true
});
--%>

$(document).ready(function(){
	$('#ean').focus();
    $("#myModal").on('shown.bs.modal', function(){
    	setTimeout(function (){
    		$('#prodName').focus();
        }, 300);
    });
    
    $('#myModal').on('hidden.bs.modal', function () {
    	$('#ean').val('');
    	setTimeout(function (){
    		$('#ean').focus();
        }, 300);
    })
});

$.fn.modal.Constructor.prototype.enforceFocus = function() {};

//trigger when form is submitted
$('#eanCode').on('submit', function(e){
	
	if($('#ean').val() != ''){
		
		$.ajax({
	        type: "POST",
	        url: "/getProductName",
	        data: { ean: $('#ean').val().trim()},
	        success: function(result) {
	        	
	        	$('#prodName').val(result);
	            
	        } //END success fn
	    }); //END $.ajax
		
		
	    $('#myModal').modal('show');
	    
	    
	}
	
	e.preventDefault();
});


//Save Button
$('#SaveModal').on('click', function() {
	
	if($('#prodName').val() != ''){
	
		var datascadenza = $('#scadenza').val();
		var nomeprodotto = $('#prodName').val();
		
		$('#datascadenza').val(datascadenza);
		$('#name').val(nomeprodotto);
		
		document.getElementById("eanCode").submit();
	} else {
		
		$('#prodName').parent().parent().addClass('has-error');
		setTimeout(function (){
    		$('#prodName').focus();
        }, 300);
		
	}
	
}); //END Save Button


(($ => {
	  $(() => {
	    $.prototype.fullscreen = function()
	    {
	      var $e = $(this);
	      if(!$e.hasClass('modal-fullscreen')) return;
	      bind($e);
	    }
	    
	    function cssn($e, props) {
	      let sum = 0;
	      props.forEach(p => {
	        sum += parseInt($e.css(p).match(/\d+/)[0]);
	      });
	      return sum;
	    }
	    function g($e)
	    {
	      return {
	        width: cssn($e, ['margin-left', 'margin-right', 'padding-left', 'padding-right', 'border-left-width', 'border-right-width']),
	        height: cssn($e, ['margin-top', 'margin-bottom', 'padding-top', 'padding-bottom', 'border-top-width', 'border-bottom-width']),
	      };
	    }
	    function calc($e)
	    {
	      const wh = $(window).height();
	      const ww = $(window).width();
	      const $d = $e.find('.modal-dialog');
	      $d.css('width', 'initial');
	      $d.css('height', 'initial');
	      $d.css('max-width', 'initial');
	      $d.css('margin', '5px');
	      const d = g($d);
	      const $h = $e.find('.modal-header');
	      const $f = $e.find('.modal-footer');
	      const $b = $e.find('.modal-body');
	      $b.css('overflow-y', 'scroll');
	      const bh = wh - $h.outerHeight() - $f.outerHeight() - ($b.outerHeight()-$b.height()) - d.height;
	      $b.height(bh);
	    }
	    function bind($e)
	    {
	       $e.on('show.bs.modal', e => {
	        const $e = $(e.currentTarget).css('visibility', 'hidden');
	       });
	       $e.on('shown.bs.modal', e => {
	        calc($(e.currentTarget));
	        const $e = $(e.currentTarget).css('visibility', 'visible');   
	       });
	    }
	    $(window).resize(() => {
	      calc($('.modal.modal-fullscreen.in'));
	    });
	    bind($('.modal-fullscreen'));
	  });
	}))(jQuery);
</script>

</body>
</html>