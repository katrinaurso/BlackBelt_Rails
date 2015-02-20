$(document).ready(function(){
	$('form.lend').submit(function(){
		$.post(
			$(this).attr('action'),
			$(this).serialize(),
			function(data){
				$('.borrowers').append(
					"<tr>"+
						"<td>"+data.first_name+" "+data.last_name+"</td>"+
						"<td>"+data.purpose+"</td>"+
						"<td>"+data.description+"</td>"+
						"<td>$ "+data.money+"</td>"+
						"<td>$ "+data.raised+"</td>"+
						"<td>$ "+data.amount+"</td>"+
					"</tr>");
			},
			"json"
		);
		return false;
	});
});