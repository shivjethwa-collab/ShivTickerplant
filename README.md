# ShivTickerplant

A custom KDB+/q tickerplant that I built in my free time. It has a feedhandler which generates fake trade data and sends it to the tickerplant.

## Structure

The project is made up of four q processes:

- `fh.q` - Generates fake trade data and sends it to the tickerplant.
- `tp.q` - Receives the data, writes it to the tickerplant log and sends it to subscribers.
- `rdb.q` - Subscribes to the tickerplant and stores the current day's trades in memory.
- `hdb.q` - Loads the historical database.

The data flows from the feedhandler to the tickerplant and then to the RDB. The RDB can then save the data to the HDB.

## Ports

The tickerplant runs on port 5010.

The RDB runs on port 5011.

The HDB runs on port 5012.

## Trades table

The project currently uses a `trades` table with the following columns:

- `time` - Trade timestamp
- `sym` - Symbol of the instrument
- `price` - Trade price
- `size` - Size of the trade
- `side` - Buy or sell

## How the data is generated

The feedhandler generates random trade data for TSLA, MSFT and AAPL.

For each update it generates a timestamp, symbol, price, size and side. The data is then sent to the tickerplant every 5 seconds.

The tickerplant logs the updates and sends them to any processes that are subscribed to the `trades` table.

## How to run

Clone the repository and open four separate q sessions.

Start the HDB first:

`q hdb.q`

Then start the tickerplant:

`q tp.q`

Then start the RDB:

`q rdb.q`

Finally start the feedhandler:

`q fh.q`

Once all four processes are running, the feedhandler will start generating trade data and sending it to the tickerplant.

The tickerplant will then send the data to the RDB, where it is stored in the in-memory `trades` table.

At the end of the day the data can be saved to the HDB.