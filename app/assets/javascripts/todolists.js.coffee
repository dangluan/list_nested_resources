$ ->
	$(document.body).delegate '.ajax-link','click', (e) ->
		self = $(@)
		e.preventDefault()
		window[self.data('callback-method')](self)
	
	false
	$(document.body).delegate '.pagination a', 'click', (e) ->
		e.preventDefault()
		$('.pagination').html("Page is loading......")
		$.ajax
			url:@.href
			type:'GET'
			data:
				is_ajax:true
			success: (res) ->
				$("#list").html(res)
		
window.loadForm = (self) ->
	id = $(self.data('id'))
	id.show()
	$.ajax
		url:self.attr('href')
		type:self.attr('type')
		data:
			is_ajax:true
		success: (response) ->
			$(self.data('id')).html response

window.closeForm = (self) ->
	$(self.data('id')).hide()
	
window.saveList = (self) ->
	$.ajax
		url:self.attr('href')
		type:self.data('type')
		data:
			name:$('#new-name').attr('value')
		success: (response) ->
			str = response
			getIndexOfColon = parseInt(str.indexOf(':'))
			parent = str.substr(0,getIndexOfColon)
			href = str.substr(getIndexOfColon + 1)
			$(parent).load(href)
			$('#new-form').find('input[type=text]').val(' ')
			
			
window.deleteElement = (self) ->
	self.html 'deleting ....'
	$.ajax
		url:self.attr('href')
		type:self.data('type')
		success: ->
			self.parents('li:first').fadeOut()
	
window.updateData = (self) ->
	self.html 'updating ......'
	list_name = []
	list_id		= []
	$(':text[name^="list-name"]').each ->
		list_name.push $(@).val()
		
	$(':hidden[name^="list-id"]').each ->
		list_id.push $(@).val()
		
	str = ""
	i = 0
	while i < list_name.length and list_id.length
		str += "{'id':'" + list_id[i] + "','name':'"  + list_name[i] +  "'},"
		i++
	jstr = "[" + str + "]"    
	json = eval("(" + jstr + ")")
	$.ajax
		url:self.attr('href')
		type:self.data('type')
		data:
			json:json
		success: (response) ->
			str = response
			getIndexOfColon = parseInt(str.indexOf(':'))
			parent = str.substr(0,getIndexOfColon)
			href = str.substr(getIndexOfColon + 1)
			$(parent).load(href)
	
window.showList = (self) ->
	$('.index-todolist-menu').hide()
	$('#list').load(self.attr('href'), ->
		eventForCheckbox($('#todolist_id_data').html())
		)
	
window.eventForCheckbox = (todolist_id,self) ->
	$('#list').delegate ':checkbox','change', ->
		$.ajax
			url:'/todolists/' + todolist_id + '/items/' + $(@).attr('myid')
			type:'PUT'
			data:
				'item[done]':if ($(@).is(':checked')) then "1" else "0"
				todolist_id:todolist_id
		container = $("#uncheck")
		container = $('#checked') if($(@).is(":checked"))
		console.log $(@).parents(".item")			
		container.append($(@).parents('.item'))
	
window.goBack = (self) ->
	$('#list').load(self.attr('href'))
	
window.reOrder = (self) ->
	$('#list').load(self.attr('href'), ->
		$('.parent').sortable(
			doneOrdered()
		)
	)

window.doneOrdered = (self) ->
	stop: (event,ui) ->
		$('.parent').children().each (index) ->
			$(@).find('input[name="position-item"]').val(index)
		position = []
		item_id	 = []
		$(':hidden[name^="position-item"]').each ->
			position.push $(@).val()
		$(':hidden[name^="item-id"]').each ->
			item_id.push $(@).val()
		str = ""
		i		 = 0
		while i < position.length and item_id.length
			str += "{'id':'" + item_id[i] + "','position':'" + position[i] + "'},"
			i++
		jstr = "[" + str + "]"
		json = eval(jstr)
		$.ajax
			url:'/todolists/' + $('#todolist_id_data').html() + '/items/update_position'
			type:'PUT'
			data:
				json:json
			success: (response) ->
				
window.search = (self) ->
	alert "ahah"
	
	
	
	
	