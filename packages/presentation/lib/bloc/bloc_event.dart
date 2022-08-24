abstract class GuessedEvent {
  const GuessedEvent();
}

class GuessedStartEvent extends GuessedEvent {
  const GuessedStartEvent();
}

class GuessedCheckEvent extends GuessedEvent {
  const GuessedCheckEvent();
}

class GuessedRefreshEvent extends GuessedEvent {
  const GuessedRefreshEvent();
}