public class LVService {

  public class Election {
    public Election(String id, String name) {
      this.id = id;
      this.name = name;
    }
    String id { get; set; }
    String name { get; set; }
    String description { get; set; }
    Candidate[] candidates;
  }

  public class Candidate {
    public Candidate(String id, String name) {
      this.id = id;
      this.name = name;
    }
    String id { get; set; }
    String name { get; set; }
    String description { get; set; }
    String iconUrl { get; set; }
  }

  public class Proxy {
    public Proxy(String id, String name) {
      this.id = id;
      this.name = name;
    }
    String id { get; set; }
    String name { get; set; }
    String description { get; set; }
    String iconUrl { get; set; }
  }

  public class Vote {
    public Vote(String id) {
      this.id = id;
    }
    String id { get; set; }
    Candidate candidate { get; set; }
    Proxy proxy { get; set; }
    Decimal weight { get; set; }
  }

  Election convertElection(Election__c el) {
    Election e = new Election(el.Id, el.Name);
    e.description = el.Description__c;
    return e;
  }

  Election convertElection(Election__c el, Candidate__c[] cts) {
    Election e = convertElection(el);
    e.candidates = new Candidate[]{};
    for (Candidate__c c : cts) {
      e.candidates.add(convertCandidate(c));
    }
    return e;
  }

  Candidate convertCandidate(Candidate__c cn) {
    Candidate c = new Candidate(cn.Id, cn.Name);
    c.description = cn.Description__c;
    c.iconUrl = cn.IconUrl__c;
    return c;
  }

  Proxy convertProxy(User px) {
    Proxy p = new Proxy(px.Id, px.Name);
    p.description = px.AboutMe;
    p.iconUrl = px.SmallPhotoUrl;
    return p;
  }

  Vote convertVote(DividedVote__c vt) {
    Vote v = new Vote(vt.Id);
    if (vt.Candidate__r != null) {
      v.candidate = convertCandidate(vt.Candidate__r);
    }
    if (vt.Proxy__r != null) {
      v.proxy = convertProxy(vt.Proxy__r);
    }
    v.weight = vt.Weight__c;
    return v;
  } 

  /**
   *
   */
  private Id uid;

  /**
   *
   */
  public LVService() {
    uid = UserInfo.getUserId();
  }

  public Election[] getElections() {
    Election[] elections = new Election[]{};
    for (Election__c el : [
      SELECT Id, Name
      FROM Election__c
    ]) {
      elections.add(convertElection(el));
    }
    return elections;
  }

  public Election getElection(String electionId) {
    Election__c el = [
      SELECT Id, Name, Description__c 
      FROM Election__c
      LIMIT 1
    ];
    Candidate__c[] cts = [
      SELECT Id, Name, Description__c, IconUrl__c
      FROM Candidate__c
    ];
    return convertElection(el, cts);
  }

  public Vote[] getMyVotes(String electionId) {
    return new Vote[] {};
  }

  public Boolean saveMyVotes(String electionId, Vote[] votes) {
    return true;
  }

  public Proxy[] getProxies() {
    Proxy[] proxies = new Proxy[]{};
    for (User px : [
      SELECT Id, Name, AboutMe, SmallPhotoUrl
      FROM User
      WHERE Profile.Name LIKE 'LotteryVote%'
    ]) {
      proxies.add(convertProxy(px));
    }
    return proxies;
  }
}