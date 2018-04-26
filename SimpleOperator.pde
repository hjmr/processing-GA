class SimpleOperator implements Mutation, Crossover {

  void crossover(Chromosome a, Chromosome b) {
    int crossoverPoint = int(random(0, a.getLength()));
    for ( int i = crossoverPoint; i < a.getLength(); i++ ) {
      boolean tmp = a.getGeneAtIndex(i);
      a.setGeneAtIndex(i, b.getGeneAtIndex(i));
      b.setGeneAtIndex(i, tmp);
    }
  }

  void mutate(Chromosome c, float rate) {
    for ( int i = 0; i < c.getLength(); i++ ) {
      if ( random(1) < rate ) {
        boolean newVal = c.getGeneAtIndex(i) == true ? false : true;
        c.setGeneAtIndex(i, newVal);
      }
    }
  }
}