assert = chai.assert

describe 'hand', ->
  deck = null
  hand = null
  fakeAce = null


  beforeEach ->
    fakeAce = new Card(
      rank: 1
      suit: 0
    )
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hit', ->
    it 'should add a card to player hand on hit', ->
      hand.hit()
      assert.strictEqual hand.length, 3

  describe 'has Ace', ->
    it 'should detect an Ace in player hand', ->
      hand.add(fakeAce)
      assert.strictEqual hand.hasAce(), true

    it 'should not detect an Ace if there is none', ->
      assert.strictEqual hand.hasAce(), false

