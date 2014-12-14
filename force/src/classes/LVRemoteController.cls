public class LVRemoteController {

  static LVService service = new LVService();

  /**
   *
   */
  @RemoteAction
  public static LVService.Election[] getElections() {
    return service.getElections();
  }

  /**
   *
   */
  @RemoteAction
  public static LVService.Election getElection(String electionId) {
    return service.getElection(electionId);
  }

  /**
   *
   */
  @RemoteAction
  public static LVService.Vote[] getMyVotes(String electionId) {
    return service.getMyVotes(electionId);
  }

  /**
   *
   */
  @RemoteAction
  public static Boolean saveMyVotes(String electionId, LVService.Vote[] votes) {
    return service.saveMyVotes(electionId, votes);
  }

}