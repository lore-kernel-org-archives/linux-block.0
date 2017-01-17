Return-Path: <andrey.v.kuzmin@gmail.com>
MIME-Version: 1.0
In-Reply-To: <499af528-7810-f82d-1f11-cbf8f3a5b21c@grimberg.me>
References: <20170111134312.GH6286@linux-x5ow.site> <cc00cc1f-17d7-105e-ef2c-61791b7cc676@kernel.dk>
 <d60d4499-6ed8-0a69-edbf-db205a6dba6a@kernel.dk> <8b47ca34-d2ff-26dc-721e-2cb1e18f1efc@grimberg.me>
 <499af528-7810-f82d-1f11-cbf8f3a5b21c@grimberg.me>
From: Andrey Kuzmin <andrey.v.kuzmin@gmail.com>
Date: Tue, 17 Jan 2017 19:44:38 +0300
Message-ID: <CANvN+emx1-F3iAY45t1_MQRcijw7sf1jPvjwv0uh8A3GzzQwMg@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, Johannes Thumshirn <jthumshirn@suse.de>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, Keith Busch <keith.busch@intel.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Linux-scsi@vger.kernel.org
Content-Type: multipart/alternative; boundary=94eb2c05cfb2494c5305464d0534
List-ID: <linux-block@vger.kernel.org>

--94eb2c05cfb2494c5305464d0534
Content-Type: text/plain; charset=UTF-8

On Tue, Jan 17, 2017 at 6:38 PM, Sagi Grimberg <sagi@grimberg.me> wrote:

> Hey, so I made some initial analysis of whats going on with
> irq-poll.
>
> First, I sampled how much time it takes before we
> get the interrupt in nvme_irq and the initial visit
> to nvme_irqpoll_handler. I ran a single threaded fio
> with QD=32 of 4K reads. This is two displays of a
> histogram of the latency (ns):
> --
> [1]
> queue = b'nvme0q1'
>      usecs               : count     distribution
>          0 -> 1          : 7310 |****************************************|
>          2 -> 3          : 11       |      |
>          4 -> 7          : 10       |      |
>          8 -> 15         : 20       |      |
>         16 -> 31         : 0        |      |
>         32 -> 63         : 0        |      |
>         64 -> 127        : 1        |      |
>
> [2]
> queue = b'nvme0q1'
>      usecs               : count     distribution
>          0 -> 1          : 7309 |****************************************|
>          2 -> 3          : 14       |      |
>          4 -> 7          : 7        |      |
>          8 -> 15         : 17       |      |
>
> We can see that most of the time our latency is pretty good (<1ns) but with
> huge tail latencies (some 8-15 ns and even one in 32-63 ns).
> **NOTE, in order to reduce the tracing impact on performance I sampled
> for every 100 interrupts.
>
> I also sampled for a multiple threads/queues with QD=32 of 4K reads.
> This is a collection of histograms for 5 queues (5 fio threads):
> queue = b'nvme0q1'
>      usecs               : count     distribution
>          0 -> 1          : 701 |****************************************|
>          2 -> 3          : 177      |**********      |
>          4 -> 7          : 56       |***      |
>          8 -> 15         : 24       |*      |
>         16 -> 31         : 6        |      |
>         32 -> 63         : 1        |      |
>
> queue = b'nvme0q2'
>      usecs               : count     distribution
>          0 -> 1          : 412 |****************************************|
>          2 -> 3          : 52       |*****      |
>          4 -> 7          : 19       |*      |
>          8 -> 15         : 13       |*      |
>         16 -> 31         : 5        |      |
>
> queue = b'nvme0q3'
>      usecs               : count     distribution
>          0 -> 1          : 381 |****************************************|
>          2 -> 3          : 74       |*******      |
>          4 -> 7          : 26       |**      |
>          8 -> 15         : 12       |*      |
>         16 -> 31         : 3        |      |
>         32 -> 63         : 0        |      |
>         64 -> 127        : 0        |      |
>        128 -> 255        : 1        |      |
>
> queue = b'nvme0q4'
>      usecs               : count     distribution
>          0 -> 1          : 386 |****************************************|
>          2 -> 3          : 63       |******      |
>          4 -> 7          : 30       |***      |
>          8 -> 15         : 11       |*      |
>         16 -> 31         : 7        |      |
>         32 -> 63         : 1        |      |
>
> queue = b'nvme0q5'
>      usecs               : count     distribution
>          0 -> 1          : 384 |****************************************|
>          2 -> 3          : 69       |*******      |
>          4 -> 7          : 25       |**      |
>          8 -> 15         : 15       |*      |
>         16 -> 31         : 3        |      |
>
> Overall looks pretty much the same but some more samples with tails...
>
> Next, I sampled how many completions we are able to consume per interrupt.
> Two exaples of histograms of how many completions we take per interrupt.
> --
> queue = b'nvme0q1'
>      completed     : count     distribution
>         0          : 0        |                                        |
>         1          : 11690    |****************************************|
>         2          : 46       |                                        |
>         3          : 1        |                                        |
>
> queue = b'nvme0q1'
>      completed     : count     distribution
>         0          : 0        |                                        |
>         1          : 944      |****************************************|
>         2          : 8        |                                        |
> --
>
> So it looks like we are super not efficient because most of the times we
> catch 1
> completion per interrupt and the whole point is that we need to find more!
> This fio
> is single threaded with QD=32 so I'd expect that we be somewhere in 8-31
> almost all
> the time... I also tried QD=1024, histogram is still the same.
>

It looks like it takes you longer to submit an I/O than to service an
interrupt, so increasing queue depth in the singe-threaded case doesn't
make much difference. You might want to try multiple threads per core with
QD, say, 32 (but beware that Intel limits the aggregate queue depth to 256
and even 128 for some models).

Regards,
Andrey




> **NOTE: Here I also sampled for every 100 interrupts.
>
>
> I'll try to run the counter on the current nvme driver and see what I get.
>
>
>
> I attached the bpf scripts I wrote (nvme-trace-irq, nvme-count-comps)
> with hope that someone is interested enough to try and reproduce these
> numbers on his/hers setup and maybe suggest some other useful tracing
> we can do.
>
> Prerequisites:
> 1. iovisor is needed for python bpf support.
>   $ echo "deb [trusted=yes] https://repo.iovisor.org/apt/xenial
> xenial-nightly main" | sudo tee /etc/apt/sources.list.d/iovisor.list
>   $ sudo apt-get update -y
>   $ sudo apt-get install bcc-tools -y
>   # Nastty hack .. bcc only available in python2 but copliant with
> python3..
>   $ sudo cp -r /usr/lib/python2.7/dist-packages/bcc
> /usr/lib/python3/dist-packages/
>
> 2. Because we don't have the nvme-pci symbols exported, The nvme.h file is
> needed on the
>    test machine (where the bpf code is running). I used nfs mount for the
> linux source (this
>    is why I include from /mnt/linux in the scripts).
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
>

--94eb2c05cfb2494c5305464d0534
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj5PbiBUdWUsIEphbiAxNywgMjAxNyBhdCA2OjM4IFBNLCBTYWdpIEdyaW1iZXJnIDxz
cGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOnNhZ2lAZ3JpbWJlcmcubWUiIHRhcmdl
dD0iX2JsYW5rIj5zYWdpQGdyaW1iZXJnLm1lPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44
ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFl
eCI+SGV5LCBzbyBJIG1hZGUgc29tZSBpbml0aWFsIGFuYWx5c2lzIG9mIHdoYXRzIGdvaW5nIG9u
IHdpdGg8YnI+DQppcnEtcG9sbC48YnI+DQo8YnI+DQpGaXJzdCwgSSBzYW1wbGVkIGhvdyBtdWNo
IHRpbWUgaXQgdGFrZXMgYmVmb3JlIHdlPGJyPg0KZ2V0IHRoZSBpbnRlcnJ1cHQgaW4gbnZtZV9p
cnEgYW5kIHRoZSBpbml0aWFsIHZpc2l0PGJyPg0KdG8gbnZtZV9pcnFwb2xsX2hhbmRsZXIuIEkg
cmFuIGEgc2luZ2xlIHRocmVhZGVkIGZpbzxicj4NCndpdGggUUQ9MzIgb2YgNEsgcmVhZHMuIFRo
aXMgaXMgdHdvIGRpc3BsYXlzIG9mIGE8YnI+DQpoaXN0b2dyYW0gb2YgdGhlIGxhdGVuY3kgKG5z
KTo8YnI+DQotLTxicj4NClsxXTxicj4NCnF1ZXVlID0gYiYjMzk7bnZtZTBxMSYjMzk7PGJyPg0K
wqAgwqAgwqB1c2Vjc8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgOiBjb3VudMKgIMKgIMKgZGlzdHJp
YnV0aW9uPGJyPg0KwqAgwqAgwqAgwqAgwqAwIC0mZ3Q7IDHCoCDCoCDCoCDCoCDCoCA6IDczMTAg
fCoqKioqKioqKioqKioqKioqKioqKioqKioqKioqPHdicj4qKioqKioqKioqKnw8YnI+DQrCoCDC
oCDCoCDCoCDCoDIgLSZndDsgM8KgIMKgIMKgIMKgIMKgIDogMTHCoCDCoCDCoCDCoHzCoCDCoCDC
oCB8PGJyPg0KwqAgwqAgwqAgwqAgwqA0IC0mZ3Q7IDfCoCDCoCDCoCDCoCDCoCA6IDEwwqAgwqAg
wqAgwqB8wqAgwqAgwqAgfDxicj4NCsKgIMKgIMKgIMKgIMKgOCAtJmd0OyAxNcKgIMKgIMKgIMKg
IMKgOiAyMMKgIMKgIMKgIMKgfMKgIMKgIMKgIHw8YnI+DQrCoCDCoCDCoCDCoCAxNiAtJmd0OyAz
McKgIMKgIMKgIMKgIMKgOiAwwqAgwqAgwqAgwqAgfMKgIMKgIMKgIHw8YnI+DQrCoCDCoCDCoCDC
oCAzMiAtJmd0OyA2M8KgIMKgIMKgIMKgIMKgOiAwwqAgwqAgwqAgwqAgfMKgIMKgIMKgIHw8YnI+
DQrCoCDCoCDCoCDCoCA2NCAtJmd0OyAxMjfCoCDCoCDCoCDCoCA6IDHCoCDCoCDCoCDCoCB8wqAg
wqAgwqAgfDxicj4NCjxicj4NClsyXTxicj4NCnF1ZXVlID0gYiYjMzk7bnZtZTBxMSYjMzk7PGJy
Pg0KwqAgwqAgwqB1c2Vjc8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgOiBjb3VudMKgIMKgIMKgZGlz
dHJpYnV0aW9uPGJyPg0KwqAgwqAgwqAgwqAgwqAwIC0mZ3Q7IDHCoCDCoCDCoCDCoCDCoCA6IDcz
MDkgfCoqKioqKioqKioqKioqKioqKioqKioqKioqKioqPHdicj4qKioqKioqKioqKnw8YnI+DQrC
oCDCoCDCoCDCoCDCoDIgLSZndDsgM8KgIMKgIMKgIMKgIMKgIDogMTTCoCDCoCDCoCDCoHzCoCDC
oCDCoCB8PGJyPg0KwqAgwqAgwqAgwqAgwqA0IC0mZ3Q7IDfCoCDCoCDCoCDCoCDCoCA6IDfCoCDC
oCDCoCDCoCB8wqAgwqAgwqAgfDxicj4NCsKgIMKgIMKgIMKgIMKgOCAtJmd0OyAxNcKgIMKgIMKg
IMKgIMKgOiAxN8KgIMKgIMKgIMKgfMKgIMKgIMKgIHw8YnI+DQo8YnI+DQpXZSBjYW4gc2VlIHRo
YXQgbW9zdCBvZiB0aGUgdGltZSBvdXIgbGF0ZW5jeSBpcyBwcmV0dHkgZ29vZCAoJmx0OzFucykg
YnV0IHdpdGg8YnI+DQpodWdlIHRhaWwgbGF0ZW5jaWVzIChzb21lIDgtMTUgbnMgYW5kIGV2ZW4g
b25lIGluIDMyLTYzIG5zKS48YnI+DQoqKk5PVEUsIGluIG9yZGVyIHRvIHJlZHVjZSB0aGUgdHJh
Y2luZyBpbXBhY3Qgb24gcGVyZm9ybWFuY2UgSSBzYW1wbGVkPGJyPg0KZm9yIGV2ZXJ5IDEwMCBp
bnRlcnJ1cHRzLjxicj4NCjxicj4NCkkgYWxzbyBzYW1wbGVkIGZvciBhIG11bHRpcGxlIHRocmVh
ZHMvcXVldWVzIHdpdGggUUQ9MzIgb2YgNEsgcmVhZHMuPGJyPg0KVGhpcyBpcyBhIGNvbGxlY3Rp
b24gb2YgaGlzdG9ncmFtcyBmb3IgNSBxdWV1ZXMgKDUgZmlvIHRocmVhZHMpOjxicj4NCnF1ZXVl
ID0gYiYjMzk7bnZtZTBxMSYjMzk7PGJyPg0KwqAgwqAgwqB1c2Vjc8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgOiBjb3VudMKgIMKgIMKgZGlzdHJpYnV0aW9uPGJyPg0KwqAgwqAgwqAgwqAgwqAwIC0m
Z3Q7IDHCoCDCoCDCoCDCoCDCoCA6IDcwMSB8KioqKioqKioqKioqKioqKioqKioqKioqKioqKio8
d2JyPioqKioqKioqKioqfDxicj4NCsKgIMKgIMKgIMKgIMKgMiAtJmd0OyAzwqAgwqAgwqAgwqAg
wqAgOiAxNzfCoCDCoCDCoCB8KioqKioqKioqKsKgIMKgIMKgIHw8YnI+DQrCoCDCoCDCoCDCoCDC
oDQgLSZndDsgN8KgIMKgIMKgIMKgIMKgIDogNTbCoCDCoCDCoCDCoHwqKirCoCDCoCDCoCB8PGJy
Pg0KwqAgwqAgwqAgwqAgwqA4IC0mZ3Q7IDE1wqAgwqAgwqAgwqAgwqA6IDI0wqAgwqAgwqAgwqB8
KsKgIMKgIMKgIHw8YnI+DQrCoCDCoCDCoCDCoCAxNiAtJmd0OyAzMcKgIMKgIMKgIMKgIMKgOiA2
wqAgwqAgwqAgwqAgfMKgIMKgIMKgIHw8YnI+DQrCoCDCoCDCoCDCoCAzMiAtJmd0OyA2M8KgIMKg
IMKgIMKgIMKgOiAxwqAgwqAgwqAgwqAgfMKgIMKgIMKgIHw8YnI+DQo8YnI+DQpxdWV1ZSA9IGIm
IzM5O252bWUwcTImIzM5Ozxicj4NCsKgIMKgIMKgdXNlY3PCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oDogY291bnTCoCDCoCDCoGRpc3RyaWJ1dGlvbjxicj4NCsKgIMKgIMKgIMKgIMKgMCAtJmd0OyAx
wqAgwqAgwqAgwqAgwqAgOiA0MTIgfCoqKioqKioqKioqKioqKioqKioqKioqKioqKioqPHdicj4q
KioqKioqKioqKnw8YnI+DQrCoCDCoCDCoCDCoCDCoDIgLSZndDsgM8KgIMKgIMKgIMKgIMKgIDog
NTLCoCDCoCDCoCDCoHwqKioqKsKgIMKgIMKgIHw8YnI+DQrCoCDCoCDCoCDCoCDCoDQgLSZndDsg
N8KgIMKgIMKgIMKgIMKgIDogMTnCoCDCoCDCoCDCoHwqwqAgwqAgwqAgfDxicj4NCsKgIMKgIMKg
IMKgIMKgOCAtJmd0OyAxNcKgIMKgIMKgIMKgIMKgOiAxM8KgIMKgIMKgIMKgfCrCoCDCoCDCoCB8
PGJyPg0KwqAgwqAgwqAgwqAgMTYgLSZndDsgMzHCoCDCoCDCoCDCoCDCoDogNcKgIMKgIMKgIMKg
IHzCoCDCoCDCoCB8PGJyPg0KPGJyPg0KcXVldWUgPSBiJiMzOTtudm1lMHEzJiMzOTs8YnI+DQrC
oCDCoCDCoHVzZWNzwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA6IGNvdW50wqAgwqAgwqBkaXN0cmli
dXRpb248YnI+DQrCoCDCoCDCoCDCoCDCoDAgLSZndDsgMcKgIMKgIMKgIMKgIMKgIDogMzgxIHwq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKjx3YnI+KioqKioqKioqKip8PGJyPg0KwqAgwqAg
wqAgwqAgwqAyIC0mZ3Q7IDPCoCDCoCDCoCDCoCDCoCA6IDc0wqAgwqAgwqAgwqB8KioqKioqKsKg
IMKgIMKgIHw8YnI+DQrCoCDCoCDCoCDCoCDCoDQgLSZndDsgN8KgIMKgIMKgIMKgIMKgIDogMjbC
oCDCoCDCoCDCoHwqKsKgIMKgIMKgIHw8YnI+DQrCoCDCoCDCoCDCoCDCoDggLSZndDsgMTXCoCDC
oCDCoCDCoCDCoDogMTLCoCDCoCDCoCDCoHwqwqAgwqAgwqAgfDxicj4NCsKgIMKgIMKgIMKgIDE2
IC0mZ3Q7IDMxwqAgwqAgwqAgwqAgwqA6IDPCoCDCoCDCoCDCoCB8wqAgwqAgwqAgfDxicj4NCsKg
IMKgIMKgIMKgIDMyIC0mZ3Q7IDYzwqAgwqAgwqAgwqAgwqA6IDDCoCDCoCDCoCDCoCB8wqAgwqAg
wqAgfDxicj4NCsKgIMKgIMKgIMKgIDY0IC0mZ3Q7IDEyN8KgIMKgIMKgIMKgIDogMMKgIMKgIMKg
IMKgIHzCoCDCoCDCoCB8PGJyPg0KwqAgwqAgwqAgwqAxMjggLSZndDsgMjU1wqAgwqAgwqAgwqAg
OiAxwqAgwqAgwqAgwqAgfMKgIMKgIMKgIHw8YnI+DQo8YnI+DQpxdWV1ZSA9IGImIzM5O252bWUw
cTQmIzM5Ozxicj4NCsKgIMKgIMKgdXNlY3PCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDogY291bnTC
oCDCoCDCoGRpc3RyaWJ1dGlvbjxicj4NCsKgIMKgIMKgIMKgIMKgMCAtJmd0OyAxwqAgwqAgwqAg
wqAgwqAgOiAzODYgfCoqKioqKioqKioqKioqKioqKioqKioqKioqKioqPHdicj4qKioqKioqKioq
Knw8YnI+DQrCoCDCoCDCoCDCoCDCoDIgLSZndDsgM8KgIMKgIMKgIMKgIMKgIDogNjPCoCDCoCDC
oCDCoHwqKioqKirCoCDCoCDCoCB8PGJyPg0KwqAgwqAgwqAgwqAgwqA0IC0mZ3Q7IDfCoCDCoCDC
oCDCoCDCoCA6IDMwwqAgwqAgwqAgwqB8KioqwqAgwqAgwqAgfDxicj4NCsKgIMKgIMKgIMKgIMKg
OCAtJmd0OyAxNcKgIMKgIMKgIMKgIMKgOiAxMcKgIMKgIMKgIMKgfCrCoCDCoCDCoCB8PGJyPg0K
wqAgwqAgwqAgwqAgMTYgLSZndDsgMzHCoCDCoCDCoCDCoCDCoDogN8KgIMKgIMKgIMKgIHzCoCDC
oCDCoCB8PGJyPg0KwqAgwqAgwqAgwqAgMzIgLSZndDsgNjPCoCDCoCDCoCDCoCDCoDogMcKgIMKg
IMKgIMKgIHzCoCDCoCDCoCB8PGJyPg0KPGJyPg0KcXVldWUgPSBiJiMzOTtudm1lMHE1JiMzOTs8
YnI+DQrCoCDCoCDCoHVzZWNzwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA6IGNvdW50wqAgwqAgwqBk
aXN0cmlidXRpb248YnI+DQrCoCDCoCDCoCDCoCDCoDAgLSZndDsgMcKgIMKgIMKgIMKgIMKgIDog
Mzg0IHwqKioqKioqKioqKioqKioqKioqKioqKioqKioqKjx3YnI+KioqKioqKioqKip8PGJyPg0K
wqAgwqAgwqAgwqAgwqAyIC0mZ3Q7IDPCoCDCoCDCoCDCoCDCoCA6IDY5wqAgwqAgwqAgwqB8Kioq
KioqKsKgIMKgIMKgIHw8YnI+DQrCoCDCoCDCoCDCoCDCoDQgLSZndDsgN8KgIMKgIMKgIMKgIMKg
IDogMjXCoCDCoCDCoCDCoHwqKsKgIMKgIMKgIHw8YnI+DQrCoCDCoCDCoCDCoCDCoDggLSZndDsg
MTXCoCDCoCDCoCDCoCDCoDogMTXCoCDCoCDCoCDCoHwqwqAgwqAgwqAgfDxicj4NCsKgIMKgIMKg
IMKgIDE2IC0mZ3Q7IDMxwqAgwqAgwqAgwqAgwqA6IDPCoCDCoCDCoCDCoCB8wqAgwqAgwqAgfDxi
cj4NCjxicj4NCk92ZXJhbGwgbG9va3MgcHJldHR5IG11Y2ggdGhlIHNhbWUgYnV0IHNvbWUgbW9y
ZSBzYW1wbGVzIHdpdGggdGFpbHMuLi48YnI+DQo8YnI+DQpOZXh0LCBJIHNhbXBsZWQgaG93IG1h
bnkgY29tcGxldGlvbnMgd2UgYXJlIGFibGUgdG8gY29uc3VtZSBwZXIgaW50ZXJydXB0Ljxicj4N
ClR3byBleGFwbGVzIG9mIGhpc3RvZ3JhbXMgb2YgaG93IG1hbnkgY29tcGxldGlvbnMgd2UgdGFr
ZSBwZXIgaW50ZXJydXB0Ljxicj4NCi0tPGJyPg0KcXVldWUgPSBiJiMzOTtudm1lMHExJiMzOTs8
YnI+DQrCoCDCoCDCoGNvbXBsZXRlZMKgIMKgIMKgOiBjb3VudMKgIMKgIMKgZGlzdHJpYnV0aW9u
PGJyPg0KwqAgwqAgwqAgwqAgMMKgIMKgIMKgIMKgIMKgIDogMMKgIMKgIMKgIMKgIHzCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8PGJy
Pg0KwqAgwqAgwqAgwqAgMcKgIMKgIMKgIMKgIMKgIDogMTE2OTDCoCDCoCB8KioqKioqKioqKioq
KioqKioqKioqKioqKioqKio8d2JyPioqKioqKioqKioqfDxicj4NCsKgIMKgIMKgIMKgIDLCoCDC
oCDCoCDCoCDCoCA6IDQ2wqAgwqAgwqAgwqB8wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfDxicj4NCsKgIMKgIMKgIMKgIDPCoCDCoCDC
oCDCoCDCoCA6IDHCoCDCoCDCoCDCoCB8wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfDxicj4NCjxicj4NCnF1ZXVlID0gYiYjMzk7bnZt
ZTBxMSYjMzk7PGJyPg0KwqAgwqAgwqBjb21wbGV0ZWTCoCDCoCDCoDogY291bnTCoCDCoCDCoGRp
c3RyaWJ1dGlvbjxicj4NCsKgIMKgIMKgIMKgIDDCoCDCoCDCoCDCoCDCoCA6IDDCoCDCoCDCoCDC
oCB8wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgfDxicj4NCsKgIMKgIMKgIMKgIDHCoCDCoCDCoCDCoCDCoCA6IDk0NMKgIMKgIMKgIHwq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKjx3YnI+KioqKioqKioqKip8PGJyPg0KwqAgwqAg
wqAgwqAgMsKgIMKgIMKgIMKgIMKgIDogOMKgIMKgIMKgIMKgIHzCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8PGJyPg0KLS08YnI+DQo8
YnI+DQpTbyBpdCBsb29rcyBsaWtlIHdlIGFyZSBzdXBlciBub3QgZWZmaWNpZW50IGJlY2F1c2Ug
bW9zdCBvZiB0aGUgdGltZXMgd2UgY2F0Y2ggMTxicj4NCmNvbXBsZXRpb24gcGVyIGludGVycnVw
dCBhbmQgdGhlIHdob2xlIHBvaW50IGlzIHRoYXQgd2UgbmVlZCB0byBmaW5kIG1vcmUhIFRoaXMg
ZmlvPGJyPg0KaXMgc2luZ2xlIHRocmVhZGVkIHdpdGggUUQ9MzIgc28gSSYjMzk7ZCBleHBlY3Qg
dGhhdCB3ZSBiZSBzb21ld2hlcmUgaW4gOC0zMSBhbG1vc3QgYWxsPGJyPg0KdGhlIHRpbWUuLi4g
SSBhbHNvIHRyaWVkIFFEPTEwMjQsIGhpc3RvZ3JhbSBpcyBzdGlsbCB0aGUgc2FtZS48YnI+PC9i
bG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+SXQgbG9va3MgbGlrZSBpdCB0YWtlcyB5b3Ug
bG9uZ2VyIHRvIHN1Ym1pdCBhbiBJL08gdGhhbiB0byBzZXJ2aWNlIGFuIGludGVycnVwdCwgc28g
aW5jcmVhc2luZyBxdWV1ZSBkZXB0aCBpbiB0aGUgc2luZ2UtdGhyZWFkZWQgY2FzZSBkb2VzbiYj
Mzk7dCBtYWtlIG11Y2ggZGlmZmVyZW5jZS4gWW91IG1pZ2h0IHdhbnQgdG8gdHJ5IG11bHRpcGxl
IHRocmVhZHMgcGVyIGNvcmUgd2l0aCBRRCwgc2F5LCAzMiAoYnV0IGJld2FyZSB0aGF0IEludGVs
IGxpbWl0cyB0aGUgYWdncmVnYXRlIHF1ZXVlIGRlcHRoIHRvIDI1NiBhbmQgZXZlbiAxMjggZm9y
IHNvbWUgbW9kZWxzKS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlJlZ2FyZHMsPGJyPjwvZGl2
PjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfc2lnbmF0dXJlIj5BbmRyZXk8YnI+PC9kaXY+PC9kaXY+
PGRpdj7CoMKgPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNs
YXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXIt
bGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4NCioqTk9U
RTogSGVyZSBJIGFsc28gc2FtcGxlZCBmb3IgZXZlcnkgMTAwIGludGVycnVwdHMuPGJyPg0KPGJy
Pg0KPGJyPg0KSSYjMzk7bGwgdHJ5IHRvIHJ1biB0aGUgY291bnRlciBvbiB0aGUgY3VycmVudCBu
dm1lIGRyaXZlciBhbmQgc2VlIHdoYXQgSSBnZXQuPGJyPg0KPGJyPg0KPGJyPg0KPGJyPg0KSSBh
dHRhY2hlZCB0aGUgYnBmIHNjcmlwdHMgSSB3cm90ZSAobnZtZS10cmFjZS1pcnEsIG52bWUtY291
bnQtY29tcHMpPGJyPg0Kd2l0aCBob3BlIHRoYXQgc29tZW9uZSBpcyBpbnRlcmVzdGVkIGVub3Vn
aCB0byB0cnkgYW5kIHJlcHJvZHVjZSB0aGVzZTxicj4NCm51bWJlcnMgb24gaGlzL2hlcnMgc2V0
dXAgYW5kIG1heWJlIHN1Z2dlc3Qgc29tZSBvdGhlciB1c2VmdWwgdHJhY2luZzxicj4NCndlIGNh
biBkby48YnI+DQo8YnI+DQpQcmVyZXF1aXNpdGVzOjxicj4NCjEuIGlvdmlzb3IgaXMgbmVlZGVk
IGZvciBweXRob24gYnBmIHN1cHBvcnQuPGJyPg0KwqAgJCBlY2hvICZxdW90O2RlYiBbdHJ1c3Rl
ZD15ZXNdIDxhIGhyZWY9Imh0dHBzOi8vcmVwby5pb3Zpc29yLm9yZy9hcHQveGVuaWFsIiByZWw9
Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL3JlcG8uaW92aXNvci5vcmcvYXB0
L3g8d2JyPmVuaWFsPC9hPiB4ZW5pYWwtbmlnaHRseSBtYWluJnF1b3Q7IHwgc3VkbyB0ZWUgL2V0
Yy9hcHQvc291cmNlcy5saXN0LmQvaW92aXNvPHdicj5yLmxpc3Q8YnI+DQrCoCAkIHN1ZG8gYXB0
LWdldCB1cGRhdGUgLXk8YnI+DQrCoCAkIHN1ZG8gYXB0LWdldCBpbnN0YWxsIGJjYy10b29scyAt
eTxicj4NCsKgICMgTmFzdHR5IGhhY2sgLi4gYmNjIG9ubHkgYXZhaWxhYmxlIGluIHB5dGhvbjIg
YnV0IGNvcGxpYW50IHdpdGggcHl0aG9uMy4uPGJyPg0KwqAgJCBzdWRvIGNwIC1yIC91c3IvbGli
L3B5dGhvbjIuNy9kaXN0LXBhY2thZzx3YnI+ZXMvYmNjIC91c3IvbGliL3B5dGhvbjMvZGlzdC1w
YWNrYWdlczx3YnI+Lzxicj4NCjxicj4NCjIuIEJlY2F1c2Ugd2UgZG9uJiMzOTt0IGhhdmUgdGhl
IG52bWUtcGNpIHN5bWJvbHMgZXhwb3J0ZWQsIFRoZSBudm1lLmggZmlsZSBpcyBuZWVkZWQgb24g
dGhlPGJyPg0KwqAgwqB0ZXN0IG1hY2hpbmUgKHdoZXJlIHRoZSBicGYgY29kZSBpcyBydW5uaW5n
KS4gSSB1c2VkIG5mcyBtb3VudCBmb3IgdGhlIGxpbnV4IHNvdXJjZSAodGhpczxicj4NCsKgIMKg
aXMgd2h5IEkgaW5jbHVkZSBmcm9tIC9tbnQvbGludXggaW4gdGhlIHNjcmlwdHMpLjxicj4NCjxi
cj4NCjxicj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188d2JyPl9fX19fX19fX19fX19f
X19fPGJyPg0KTGludXgtbnZtZSBtYWlsaW5nIGxpc3Q8YnI+DQo8YSBocmVmPSJtYWlsdG86TGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnIj5MaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmc8L2E+PGJyPg0KPGEgaHJlZj0iaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udm1lIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy88d2JyPm1haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZTwv
YT48YnI+DQo8YnI+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj48L2Rpdj4NCg==
--94eb2c05cfb2494c5305464d0534--
