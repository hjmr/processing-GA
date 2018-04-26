class ProblemTSP implements Problem {

  int bitsPerCity;
  ArrayList cities;

  int cityIdxListLen;
  int[] cityIdxList;

  protected float R = 10.0;

  ProblemTSP(int n) {
    float offset = 3 * R;
    cities = new ArrayList();
    for ( int i = 0; i < n; i++ ) {
      cities.add(new PVector(random(offset, width-offset), random(offset, height-offset)));
    }
    bitsPerCity = int(log(cities.size()) / log(2)) + 1;
    cityIdxList = new int[cities.size()];
    initCityIdxList();
  }

  int getChromosomeLength() {
    return bitsPerCity * cities.size();
  }

  float evaluate(Chromosome c) {
    initCityIdxList();

    float d = 0.0;
    int start = getCityIndex(c, 0);
    int prev = start;
    for ( int i = 1; i < cities.size(); i++ ) {
      int curr = getCityIndex(c, i);
      d += getDistance(prev, curr);
      prev = curr;
    }
    d += getDistance(prev, start);
    return 1.0 / d;
  }

  void initCityIdxList() {
    cityIdxListLen = cities.size();
    for ( int i = 0; i < cities.size(); i++ ) {
      cityIdxList[i] = i;
    }
  }

  int getCityIndex(Chromosome c, int n) {
    int idx = 0;
    int p = n * bitsPerCity;
    for ( int i = 0; i < bitsPerCity; i++ ) {
      idx = idx * 2 + ((c.getGeneAtIndex(p + i) == true) ? 1 : 0);
    }
    idx = idx % cityIdxListLen;
    int city = cityIdxList[idx];
    cityIdxList[idx] = cityIdxList[cityIdxListLen - 1];
    cityIdxListLen--;
    return city;
  }

  float getDistance(int cityFrom, int cityTo) {
    PVector prevPos = (PVector)cities.get(cityFrom);
    PVector currPos = (PVector)cities.get(cityTo  );
    return prevPos.dist(currPos);
  }

  void draw(Chromosome c) {
    initCityIdxList();

    PVector start = (PVector)cities.get(getCityIndex(c, 0));
    PVector from = start;
    for ( int i = 1; i < cities.size(); i++ ) {
      int n = getCityIndex(c, i);
      PVector to = (PVector)cities.get(n);

      noFill();
      stroke(64);
      line(from.x, from.y, to.x, to.y);
      from = to;
    }
    line(from.x, from.y, start.x, start.y);

    for ( int i = 0; i < cities.size(); i++ ) {
      PVector pos = (PVector)cities.get(i);
      noFill();
      stroke(255);
      ellipse(pos.x, pos.y, R * 2, R * 2);
      if ( i == 0 ) {
        ellipse(pos.x, pos.y, R * 2.5, R * 2.5);
      }
      fill(255);
      text("[" + i + "]", pos.x + R * 1.3, pos.y + R * 1.3);
    }
  }
}