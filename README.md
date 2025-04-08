# Add. Pay. See Progress — Debtor Keeps It Simple.

For those who have achieved some level of financial control and can pay for their stuff without a credit card,
You'll need to pay back yourself. This project holds 3 main functions to help you control it:
- `add`: Increase the debt.
- `pay`: Pay part or total of the debt.
- `see`: Check your current debt.

## Usage
1. `see`
```bash
cabal run debtor see
There is your debt: R$7870.00
```
2. `pay`
```bash
cabal run debtor pay
Amount:
1000
Good job you have paid a part!
Updated debt: R$6870.00
```
3. `add`
```bash
cabal run debtor add
Amount:
3000
Updated debt: R$9870.00
```
