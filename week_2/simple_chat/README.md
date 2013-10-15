# SimpleChat

A very simple socket-based chat application built in Ruby.

## Design

The program design loosely follows a [publish/subscribe pattern](http://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern) whereby one or more **clients** establish a connection to a central **server**. Upon establishing a connection, clients can send messages to the server, which are then broadcast to any and all connected clients listening on the same channel.

Something like what is illustrated in this beautiful diagram:

![server-client diagram](http://f.cl.ly/items/3o3O3b2y311t2z3Q0C0F/jw-1019-jxta1.gif)

Got it? Good.

## Usage

Two binary files are provided: one to run the chat server, and one to run a client session.

### Server

To run the server, execute `bin/server` from the app's root directory.

```bash
$ bin/server

Simple Chat server is running.
Listening for connections on HOSTNAME:PORT...
```

It also accepts options to specify the **hostname** and **port**.

```bash
$ bin/server -h my_computer.local -p 7777

Simple Chat server is running.
Listening for connections on my_computer.local:7777...
```

### Client

To start a client session, execute `bin/client` from the app's root directory.

```bash
$ bin/client

Welcome! There are N people online.
```

In addition to specifying the hostname and port to connect to, you can also provide the client with a **name**, which will be used to identify the client.

```bash
$ bin/client -n my name -h my_computer.local -p 7777

Welcome! There are N people online.
```

Thus, when another client connects to the same server, messages are prefixed with the sender's name.