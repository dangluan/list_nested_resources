// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

// function reOrder(self,e){
// 		e.preventDefault();
// 		$("#list").html('');
// 		$('#list-checked').hide();
// 		$("#list").load(self.attr('href'),function(){
// 			$('.parent').sortable({
// 				stop: function(event, ui){
// 					$(".parent").children().each(function(index) {
// 						$(this).find("input[name='position-item']").val(index);
// 					});
// 
// 					var positions = [];
// 					$(":hidden[name^='position-item']").each(
// 						function (){
// 							//alert($(this).val());
// 							positions.push($(this).val());
// 						}
// 					);
// 
// 					var id_items = [];
// 					$(":hidden[name^='item-id']").each(function(){
// 						id_items.push($(this).val());
// 					});
// 
// 					var text ="";
// 					for(var j=0 ; j < positions.length && id_items.length;j++){
// 						text += "{" + "'id':'" + id_items[j] + "','position':'" + positions[j] + "'},";
// 					}
// 
// 					var json = "[" + text + "]";
// 					var json_object = eval(json);
// 					$.ajax(
// 						{
// 							url:'/todolists/' + $('#todolist_id_data').html() + '/items/update_position',
// 							type:'PUT',
// 							data:{json:json_object,todolist_id: $("#todolist_id_data").html() },
// 							success:function(response){
// 								
// 							}
// 						}
// 					);
// 				}	
// 			});//end sortable
// });
// }
// 
// function updateData(self,e){
// 	e.preventDefault();
// 	var list_name = [];
// 		var list_id = [];
// 		//get all values of fields
// 		$(":text[name^='list-name']").each(
// 		  function (){
// 			list_name.push($(this).val());
// 		  }
// 		);
// 		$(":hidden[name^='list-id']").each(
// 		  function (){
// 			//alert($(this).val());
// 			list_id.push($(this).val());
// 		  }
// 		);
// 		var str = "";
// 		for(var i = 0;i < list_name.length && list_id.length ;i++){
// 			str += "{'id':" + "'" + list_id[i] + "'" + ",'name':" + "'" + list_name[i] + "'},";
// 
// 		}
// 		var j="[" + str + "]";
// 
// 		var js = j.substr(0,j.length-2) + "]";
// 		var json = eval("(" + js + ")");
// 		$.ajax(
// 			{
// 				url:self.attr('href'),
// 				type:self.data('type'),
// 				data:{json:json},
// 				success:function(response){
// 					$.get(response, function(response) {
// 						$("body").html(response);
// 					});										
// 				}
// 			}
// 		);
// }
// function formEditMultiple(self,e){
// 	e.preventDefault();
// 	$('.back-to-index').show();
// 	$('#form-edit').show();
// 	$.ajax(
// 		{
// 			url:self.attr('href'),
// 			type:self.data('type'),
// 			success:function(response){
// 				$('#list').hide();
// 				$('#form-edit').html(response);
// 			}
// 		}
// 	);
// 	return false;
// }
// 
// function saveList(self,e){
// 	e.preventDefault();
// 	$.ajax(
// 		{
// 			url:self.attr('href'),
// 			type:self.data('type'),
// 			data:{'name':$('#new-name').attr('value')},
// 			success:function(response){
// 				var str = response;
// 				var getIndexOfColon = parseInt(str.indexOf(':'));
// 				var parent = str.substr(0,getIndexOfColon);
// 				var href = str.substr(getIndexOfColon + 1);
// 				$.get(href,function(response){
// 					$(parent).html(response);
// 				});
// 				$(".new-form").find('input[type=text]').val('');
// 				return false;
// 			}
// 		}
// 	);
// }
// function closeForm(self,e){
// 	e.preventDefault();
// 	$(self.data('id')).hide();
// }
// function loadForm(self,e){
// 	e.preventDefault();
// 	$(self.data("id")).show();
// 	$.ajax(
// 		{
// 			url:self.attr('href'),
// 			type:self.data('type'),
// 			data: {is_ajax: true},
// 			success:function(response){
// 				$(self.data("id")).html(response);	
// 			}
// 		}
// 	);
// 	return false;
// }
// 
// function deleteElement(self,e){
// 	e.preventDefault();
// 	self.html('Deleting ....');
// 	$.ajax(
// 		{
// 			url:self.attr('href'),
// 			type:self.data('type'),
// 			success:function(){
// 				self.parents('li:first').fadeOut();
// 			}
// 		}
// 	);
// }
// 
// function assignEventForItemCheckboxes(todolist_id) {
// 	$('div#list').delegate(":checkbox", "change", function() {
// 		var self = this;
// 		
// 		$.ajax(
// 			{
// 				url:'/todolists/' + todolist_id + '/items/'+ $(self).attr('myid'),
// 				type:'PUT',
// 				data:{'item[done]':($(this).is(':checked'))?"1":"0",todolist_id:todolist_id},
// 				success:function(response){
// 				
// 				}
// 			}
// 		);
// 		var container = $("#uncheck");
// 		if($(this).is(':checked')){
// 			container = $("#checked");
// 		}
// 		container.append($(this).parents('.item'));
// 	});
// }
// 
// function loadData(self,e){
// 	e.preventDefault();
// 	$(".index-todolist-menu").hide();
// 	$('#list').load(self.attr('href'),function(){
// 		assignEventForItemCheckboxes($('#todolist_id_data').html());
// 	});
// 	$(".index-form").hide();
// 	
// 
// }
// 
// function backFunction(self,e){
// 	e.preventDefault();
// 	$('#form-edit').hide();
// 	$('#list').show();
// 	$('.back-to-index').hide();
// }
// function backIndex(self,e){
// 	e.preventDefault();
// 	$('body').load(self.attr('href'));
// }
//      
// function backToShow(self,e){
// 	e.preventDefault();
// 	$('#list').load(self.attr('href'));
// }
// 
// $(document).ready(function(){
// 
// 	$(document.body).delegate('.ajax-link','click',function(e){	
// 		var self = $(this);
// 		window[$(this).data('callback-method')](self,e);
// 		
// 	});
// 	
// 	$(document.body).delegate(".new-form input", "keyup", function(e) {
// 		if(e.keyCode == 13) {
// 		$(this).parents('.new-form').find('a.create-list').click();
// 			e.preventDefault();
// 		}
// 	});
// 	
// 	$(document.body).delegate('input:text:first','focus',function(e){
// 		 var $inp = $('input:text');
//       $inp.bind('keydown', function(e) {
//           //var key = (e.keyCode ? e.keyCode : e.charCode);
//           var key = e.which;
//           if (key == 13) {
//               e.preventDefault();
//               var nxtIdx = $inp.index(this) + 1;
//               $(":input:text:eq(" + nxtIdx + ")").focus();
//           }
//       });
// 	});
// 	
// 	return false;
// });