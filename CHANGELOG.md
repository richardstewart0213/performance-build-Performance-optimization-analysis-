# Change log

## master (unreleased)

## 1.4.1 (2019-07-29)

### Bug fixes

* [#67](https://github.com/rubocop-hq/rubocop-performance/issues/67): Fix an error for `Performance/RedundantMerge` when `MaxKeyValuePairs` option is set to `null`. ([@koic][])
* [#73](https://github.com/rubocop-hq/rubocop-performance/pull/73): Fix a false negative for `Performance/RegexpMatch` when `MatchData` is not detected in `if` branch of guard condition. ([@koic][])

## 1.4.0 (2019-06-20)

### Bug fixes

* [#54](https://github.com/rubocop-hq/rubocop-performance/issues/54): Fix `Performance/FixedSize` to accept const assign with some operation. ([@tejasbubane][])
* [#61](https://github.com/rubocop-hq/rubocop-performance/pull/61): Fix a false negative for `Performance/RegexpMatch` when using RuboCop 0.71 or higher. ([@koic][])

## 1.3.0 (2019-05-13)

### Bug fixes

* [#48](https://github.com/rubocop-hq/rubocop-performance/issues/48): Reduce `Performance/RegexpMatch` false positive by only flagging `match` used with Regexp/String/Symbol literals. ([@dduugg][])

### Changes

* [#52](https://github.com/rubocop-hq/rubocop-performance/issues/52): Drop support for Ruby 2.2. ([@bquorning][])

## 1.2.0 (2019-05-04)

### Bug fixes

* [#47](https://github.com/rubocop-hq/rubocop-performance/pull/47): Fix a false negative for `Performance/RegexpMatch` when using RuboCop 0.68 or higher. ([@koic][])

## 1.1.0 (2019-04-08)

### Changes

* [#39](https://github.com/rubocop-hq/rubocop-performance/pull/39): Remove `Performance/LstripRstrip` cop. ([@koic][])
* [#39](https://github.com/rubocop-hq/rubocop-performance/pull/39): Remove `Performance/RedundantSortBy`, `Performance/UnneededSort` and `Performance/Sample` cops. ([@koic][])

## 1.0.0 (2019-03-14)

### New features

* Extract performance cops from rubocop-hq/rubocop repository. ([@composerinteralia][], [@koic][])

[@composerinteralia]: https://github.com/composerinteralia
[@koic]: https://github.com/koic
[@bquorning]: https://github.com/bquorning
[@dduugg]: https://github.com/dduugg
[@tejasbubane]: https://github.com/tejasbubane
