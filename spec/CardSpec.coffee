assert = chai.assert

describe "deck constructor", ->

  it "should create a card collection with two decks", ->
    collection = new Deck()
    assert.strictEqual collection.length, 104