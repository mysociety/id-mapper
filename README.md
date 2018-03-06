# ID Mapper

A ruby gem to interface with ID Mapping Store

## Environment variables

These variables are needed to use this gem:

- `ID_MAPPING_STORE_BASE_URL` defaults to `http://id-mapping-store.mysociety.org`
- `ID_MAPPING_STORE_API_KEY` as specified in the ID Mapping Store admin

## Schemes

Return all current scheme names:

```ruby
IDMapper.schemes => ['uk-area_id', 'wikidata-district-item']
```

Initialise a scheme object from an existing scheme names:

```ruby
uk = IDMapper.scheme('uk-area_id')
wd = IDMapper.scheme('wikidata-district-item')
```

Schemes have to be created in ID Mapping Store, so you can't do:

```ruby
IDMapper.scheme('new-scheme') # raises InvalidScheme exception
```

## Identifiers

Fetch all identifiers from another scheme:

```ruby
uk['gss:S17000017'].all(wd) => ['Q1529479']
```
Fetch the latest identifier from another scheme:

```ruby
uk['gss:S17000017'].get(wd) => 'Q1529479'
```

But you can't return identifiers from the same scheme:

```ruby
uk['gss:S17000017'].all(uk) => # raises InvalidScheme exception
uk['gss:S17000017'].get(uk) => # raises InvalidScheme exception
```

## Equivalence claims

Create an equivalence claim between `gss:S17000017` and `Q408547`:

```ruby
uk['gss:S14000003'].set(wd['Q408547'])
```

Create an equivalence claim between `gss:S17000017` and `Q408547`, with a
comment:

```ruby
uk['gss:S14000003'].set(wd['Q408547'], comment: 'Foo')
```
