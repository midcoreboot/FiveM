$(document).ready(function(){
	window.addEventListener('message', function( event ) {
		if(event.data.action == 'open') {
			var userData = event.data.user[0];
			var sex = userData.sex;
			var sex = 'M';
			$('img').show();
			$('#name').css('color', '#282828');
			if(sex.toLowerCase() == 'm') {
				$('img').attr('src', 'assets/images/male.png');
				$('#sex').text('Man');
			} else {
				$('img').attr('src', 'assets/images/female.png');
				$('#sex').text('Kvinna');
			}
			
			$('#name').text(userData.firstname);
			$('#lastname').text(userData.lastname);
			$('#height').text(userData.height);
			$('#signature').text(userData.firstname + ' ' + userData.lastname); 
			$('#id-card').css('background', 'url(assets/images/bricka_rounded.png');
			$('#id-card').show();
		} else if(event.data.action == 'close'){
			$('#name').text('');
			$('#height').text('');
			$('#signature').text('');
			$('#sex').text('');
			$('#id-card').text('');
		}
	}) 
})