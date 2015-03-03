
window.setup_players = ->
    for _ in [1..4]
        add_player()

    $('#step-2').hide()

# Adds a new input field
window.add_player = ->
    window.n_players ?= 0
    window.n_players += 1
    $('#player-inputs').append make_name_input(window.n_players)

# Removes a specific input field
window.remove_player = (n) ->
    return if $('#player-inputs .player').length <= 1

    $("#player-inputs #player-#{n}").remove()
    $('#player-inputs .player label').each (index) ->
        this.innerHTML = "Player #{index+1}"

# Generates the HTML for the input field for player n
make_name_input = (n) ->
    player_id = $('#player-inputs .player').length + 1
    """
        <div class = 'form-group player' id = 'player-#{n}'>
            <label class = 'col-sm-2 control-label' for = 'name-#{n}'>Player #{player_id}</label>
            <div class = 'col-sm-10'>
                <div class = 'input-group'>
                    <input class = 'form-control player-name-input' type = 'name' id = 'name-#{n}' />
                    <span class = 'input-group-btn'>
                        <a class = 'btn btn-default' onclick = 'remove_player(#{n})'>&times;</a>
                    </span>
                </div>
            </div>
        </div>
    """

window.tocard = (n) ->
    $('.card').each (index) ->
        if index == n - 1
            $(this).show()
        else
            $(this).hide()

window.check_names = ->
    t = false
    $('.player-name-input').each (index) ->
        console.log $(this).val()
        t = true if $(this).val() != ''
    return t

window.generate_characters = (callback) ->
    if window.characters is not null and window.characters.length > 0
        callback()
        return
    xhr = new XMLHttpRequest()
    xhr.onreadystatechange = (event) ->
        if xhr.readyState == 4
            window.characters = shuffle(xhr.responseText.split('\n'))
            callback()
    xhr.open 'GET', 'characters.txt', true
    xhr.send null

window.choose_characters = ->
    window.generate_characters ->
        $('#character-list').html('')
        $('.player-name-input').each ->
            name = $(this).val()
            return if name == ''
            $('#character-list').append """
                <div class = 'col-md-4 character-box'>
                    <h3>#{name}</h3>
                    <div class = 'character-description'>#{window.characters.pop()}</div>
                </div>
                """

shuffle = (array) ->
    index = array.length
    while 0 != index
        rIndex = Math.floor(Math.random() * index)
        index -= 1

        [array[index], array[rIndex]] = [array[rIndex], array[index]]

    return array
