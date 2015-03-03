
var cards = null;
var numbersDrawn = [];

function drawCard()
{
	// Load cards if necessary
	if ( cards == null )
	{
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function () {
			if ( xhr.readyState == 4 ) {
				cards = jsyaml.load( xhr.responseText )['cards'];
				if ( cards != null )
					drawCard();
				else
					alert('Error loading cards.');
			}
		};
		xhr.open('GET', 'cards.yaml', true );
		xhr.send();
		return;
	}

	if ( numbersDrawn.length == 0 ) {
		for ( var i = 0; i < cards.length; i++ ) {
			numbersDrawn.push(i);
		}
	}

	numbersDrawn = shuffle( numbersDrawn );
	var number = 0;
	if ( isWithReplacement() ) {
		number = numbersDrawn[0];
	}
	else {
		number = numbersDrawn.pop();
	}

	document.getElementById('card-title').innerHTML = cards[number]['title'];
	text = cards[number]['text'];
	text.replace('\n', '<br/>')
	document.getElementById('card-text').innerHTML = text;
	if ( 'flavor_text' in cards[number] ) {
		document.getElementById('card-flavor-text').innerHTML = cards[number]['flavor_text'];
	}
	else {
		document.getElementById('card-flavor-text').innerHTML = '';
	}
}

function isWithReplacement() {
	return $('input[name="draw-style"]:checked').val() == 'replacement';
}

function shuffle( array ) {
	var index = array.length;
	var temp, rIndex;

	while ( 0 != index ) {
		rIndex = Math.floor( Math.random() * index );
		index -= 1;

		temp = array[index];
		array[index]  = array[rIndex];
		array[rIndex] = temp;
	}

	return array;
}
