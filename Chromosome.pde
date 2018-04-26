class Chromosome {
  boolean[] code;
  float fitness;

  Chromosome(int len) {
    code = new boolean[len];
    fitness = 0.0;
  }

  int getLength() {
    return code.length;
  }

  void setChromosome(Chromosome c) {
    for ( int i = 0; i < code.length; i++ ) {
      code[i] = c.getGeneAtIndex(i);
    }
  }

  boolean getGeneAtIndex(int i) {
    return code[i];
  }

  void setGeneAtIndex(int i, boolean v) {
    code[i] = v;
  }

  void randomize() {
    for ( int i = 0; i < code.length; i++ ) {
      code[i] = int(random(0, 2)) == 1 ? true : false;
    }
  }

  void setFitnessValue(float f) {
    fitness = f;
  }

  float getFitnessValue() {
    return fitness;
  }
}