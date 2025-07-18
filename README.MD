# Bidding System

![Ruby Version](https://img.shields.io/badge/Ruby-3.0%2B-red)
![RSpec](https://img.shields.io/badge/RSpec-Tested-brightgreen)

A sequential auction system where agents compete by matching or exceeding bids in turn-based rounds.

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Rspec](Rspec)

## Features

- 🎯 Turn-based bidding with multiple agents
- ⚖️ Automatic withdrawal for non-matching bids
- 🔄 Multi-round bidding support
- 🧪 100% RSpec test coverage
- 📊 Detailed bid history tracking

## Installation

1. Ensure Ruby 3.0+ is installed
2. Install dependencies:
```bash
gem install bundler
bundle install
```

## RSpec

### Installation
```bash
gem install rspec
```

### Spec

```bash
bundle exec rspec
```


## Assumptions Made

Agents are autonomous: Each agent independently decides its bid increase per round using get_bid_increase.

Bidding ends when:

Only one agent remains active or

All active agents have placed the same bid (i.e., no more competition).

Agents become inactive if:

Their bid falls behind the current highest bid in a round.

They raise an exception when asked to bid (e.g., ErrorAgent).

Maximum number of rounds is 1000 to prevent infinite loops. This value is configurable via MAX_ROUNDS.

get_bid_increase always returns a numeric value (Integer/Float) unless it raises an exception.

An agent can raise an error, and this should not break the system — instead, the agent is marked inactive.

FixedBidAgent continues to return the same value each time.

IncrementalBidAgent has a finite list of bid values. Once exhausted, it raises an exception.

Specs are designed to test:

Happy path (normal bidding flow)

Error conditions (bad agent behavior)

Edge conditions (max round exceeded, tie cases, all inactive)

For the "max rounds exceeded" test, agents must be defined in a way that keeps them bidding without converging, otherwise the termination condition would end the loop naturally before the cap.

