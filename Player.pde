class Player{
  
  public String name;
  private boolean out;
  private ArrayList<Card> hand;
  
  public Player(String n){
    name = n;
    out = false;
    hand = new ArrayList<Card>();
  }
  
  public int getHandCount(){
    return hand.size();
  }
  
  public void addCard(Card card){
    hand.add(card);
  }
  
  public Card getCard(int index){
    return hand.size() == 0 ? null : hand.get(index);
  }
  
  public Card popCard(){
    if(hand.size() == 0){
      return null;
    }
    Card card = hand.get(0);
    hand.remove(card);
    return card;
  }
  
  public void shuffleHand(){
    ArrayList<Card> newHand = new ArrayList<Card>();
    for(Card card : hand){
      newHand.add((int)random(newHand.size()), card);
    }
    hand = newHand;
  }
}
