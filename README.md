# Backend Programming Task

## Tools used

1. **ARGV** - Ruby standard library ARGV is used for parsing CLI arguments.
2. **net/http** - Ruby standard library 'net/http' is used to make HTTP request.
3. **test/unit** - Ruby standard library 'test/unit' is used to write Unit test cases.

## Input methods

1. `ruby card.rb set` - Returns a list of **Cards** grouped by **`set`**.
2. `ruby card.rb rarity` - Returns a list of **Cards** grouped by **`set`** and within each **`set`** grouped by **`rarity`**.
3. `ruby card.rb colors [KTK] [red,blue]` - Returns a list of cards from the **Khans of Tarkir (KTK)** set that ONLY have the colours `red` **AND** `blue`. The parameters are optional, `KTK` and `red,blue` are taken as default params.

### Initial analysis

The given `magicthegathering` API endpoint takes a `GET` request with optional Query parameters and returns an Array of Hashes with various Key parameters.

### Technical choices

1. Since we are restricted from adding any Query Parameters for filtering and grouping, we receive whole response and apply logic to replicate the requirement.

2. Ignored usage of the MTG SDK as per the conditions and used `net/http` for performing HTTP requests.

3. Since we are performing all the logics client side, single HTTP request will be made per lifetime. So, the rate limits are covered.
