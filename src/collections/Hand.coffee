class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @on 'add', => if @scores() > 21 and not @isDealer
      @trigger 'busted'

  hit: ->
    @add(@deck.pop())
    @last()

  hasAce: -> @reduce (memo, card) ->
    memo or (card.get('revealed') and card.get('value') is 1)
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    if @hasAce() and @minScore() + 10 > 21
      @minScore()
    else
      @minScore() + 10 * @hasAce()

  dealerScore: -> @reduce (score, card) ->
    score + card.get 'value'
  , 0

  stand: -> @trigger 'dealersTurn'

  finishGame: -> 
    @at(0).flip()
    while @scores() < 17
      @hit()
    if @scores() < 22
      @trigger 'gameOver'
    else
      @trigger 'busted'