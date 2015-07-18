class window.AppView extends Backbone.View
  className: 'app'
  template: _.template '
    <div class="button hit-button">Hit</div> <div class="button stand-button">Stand</div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> 
      console.log('standing')
      @model.get('playerHand').stand()
    'click .new-game-button': -> @model.newGame()

  initialize: ->
    @model.on 'newGameStart', => @render()
    @model.on 'finalCard', (message) => 
      @$el.prepend("<div class='message'>#{message}</div><div class='button new-game-button'>Play Again</div>")
      @$('.hit-button').css('display', 'none')
      @$('.stand-button').css('display', 'none')
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

