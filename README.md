A server app built using [Shelf](https://pub.dev/packages/shelf),
configured to enable running with [Docker](https://www.docker.com/).
# Running the sample

## Running with the Dart SDK

You can run the example with the [Dart SDK](https://dart.dev/get-dart)
like this:

```
$ dart run bin/server.dart
Server listening on port 8080
```
## Running with Docker

If you have [Docker Desktop](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

```
$ docker build . -t myserver
$ docker run -it -p 8080:8080 myserver
Server listening on port 8080
```

And then from a second terminal:
```
$ curl http://0.0.0.0:8080
```

You should see the logging printed in the first terminal:
```
2021-05-06T15:47:04.620417  0:00:00.000158 GET     [200] /
```
# Requests Overview

This sample code handles following requests:
### GET
  - `/expenses` - this request will fetch all the available expenses in the list.
  - `/expense/<id>` -this request will fetch `Expense` according to `id` that was parsed

### POST
  - `/add-expense` - this request will add new `Expense` to the list, with JSON body that was attached.

### DELETE 
  - `/delete-expense/<id>` - this request will delete `Expense` according to `id` that was parsed.

### PUT
  - `/update-expense` - this request will update and replace the `Expense` with same `id`.

