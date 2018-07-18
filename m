Return-Path: <prvs=730b8c8b8=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [RFC PATCH] blk-mq: move timeout handling from queue to tagset
Date: Wed, 18 Jul 2018 17:18:45 +0000
Message-ID: <11f7a7aff754b9bb0e4243ac4502319f376378c3.camel@wdc.com>
References: <20180718170018.31395-1-keith.busch@intel.com>
In-Reply-To: <20180718170018.31395-1-keith.busch@intel.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-07-18 at 11:00 -0600, Keith Busch wrote:
+AD4-  void blk+AF8-sync+AF8-queue(struct request+AF8-queue +ACo-q)
+AD4-  +AHs-
+AD4- -	del+AF8-timer+AF8-sync(+ACY-q-+AD4-timeout)+ADs-
+AD4- -	cancel+AF8-work+AF8-sync(+ACY-q-+AD4-timeout+AF8-work)+ADs-
+AD4- -
+AD4-  	if (q-+AD4-mq+AF8-ops) +AHs-
+AD4-  		struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx+ADs-
+AD4-  		int i+ADs-
+AD4- +AEAAQA- -415,6 +-412,8 +AEAAQA- void blk+AF8-sync+AF8-queue(struct r=
equest+AF8-queue +ACo-q)
+AD4-  		queue+AF8-for+AF8-each+AF8-hw+AF8-ctx(q, hctx, i)
+AD4-  			cancel+AF8-delayed+AF8-work+AF8-sync(+ACY-hctx-+AD4-run+AF8-work)=
+ADs-
+AD4-  	+AH0- else +AHs-
+AD4- +-		del+AF8-timer+AF8-sync(+ACY-q-+AD4-timeout)+ADs-
+AD4- +-		cancel+AF8-work+AF8-sync(+ACY-q-+AD4-timeout+AF8-work)+ADs-
+AD4-  		cancel+AF8-delayed+AF8-work+AF8-sync(+ACY-q-+AD4-delay+AF8-work)+A=
Ds-
+AD4-  	+AH0-
+AD4-  +AH0-

What is the impact of this change on the md driver, which is the only drive=
r
that calls blk+AF8-sync+AF8-queue() directly? What will happen if timeout p=
rocessing
happens concurrently with or after blk+AF8-sync+AF8-queue() has returned?

+AD4-  static void blk+AF8-mq+AF8-timeout+AF8-work(struct work+AF8-struct +=
ACo-work)
+AD4-  +AHs-
+AD4- -	struct request+AF8-queue +ACo-q +AD0-
+AD4- -		container+AF8-of(work, struct request+AF8-queue, timeout+AF8-work)=
+ADs-
+AD4- +-	struct blk+AF8-mq+AF8-tag+AF8-set +ACo-set +AD0-
+AD4- +-		container+AF8-of(work, struct blk+AF8-mq+AF8-tag+AF8-set, timeout=
+AF8-work)+ADs-
+AD4- +-	struct request+AF8-queue +ACo-q+ADs-
+AD4-  	unsigned long next +AD0- 0+ADs-
+AD4-  	struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx+ADs-
+AD4-  	int i+ADs-
+AD4- =20
+AD4- -	/+ACo- A deadlock might occur if a request is stuck requiring a
+AD4- -	 +ACo- timeout at the same time a queue freeze is waiting
+AD4- -	 +ACo- completion, since the timeout code would not be able to
+AD4- -	 +ACo- acquire the queue reference here.
+AD4- -	 +ACo-
+AD4- -	 +ACo- That's why we don't use blk+AF8-queue+AF8-enter here+ADs- in=
stead, we use
+AD4- -	 +ACo- percpu+AF8-ref+AF8-tryget directly, because we need to be ab=
le to
+AD4- -	 +ACo- obtain a reference even in the short window between the queu=
e
+AD4- -	 +ACo- starting to freeze, by dropping the first reference in
+AD4- -	 +ACo- blk+AF8-freeze+AF8-queue+AF8-start, and the moment the last =
request is
+AD4- -	 +ACo- consumed, marked by the instant q+AF8-usage+AF8-counter reac=
hes
+AD4- -	 +ACo- zero.
+AD4- -	 +ACo-/
+AD4- -	if (+ACE-percpu+AF8-ref+AF8-tryget(+ACY-q-+AD4-q+AF8-usage+AF8-coun=
ter))
+AD4- -		return+ADs-
+AD4- -
+AD4- -	blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter(q, blk+AF8-mq+AF8-ch=
eck+AF8-expired, +ACY-next)+ADs-
+AD4- +-	blk+AF8-mq+AF8-tagset+AF8-busy+AF8-iter(set, blk+AF8-mq+AF8-check+=
AF8-expired, +ACY-next)+ADs-
+AD4- =20
+AD4-  	if (next +ACEAPQ- 0) +AHs-
+AD4- -		mod+AF8-timer(+ACY-q-+AD4-timeout, next)+ADs-
+AD4- -	+AH0- else +AHs-
+AD4- +-		mod+AF8-timer(+ACY-set-+AD4-timer, next)+ADs-
+AD4- +-		return+ADs-
+AD4- +-	+AH0-
+AD4- +-
+AD4- +-	list+AF8-for+AF8-each+AF8-entry(q, +ACY-set-+AD4-tag+AF8-list, tag=
+AF8-set+AF8-list) +AHs-
+AD4-  		/+ACo-
+AD4-  		 +ACo- Request timeouts are handled as a forward rolling timer. If
+AD4-  		 +ACo- we end up here it means that no requests are pending and
+AD4- +AEAAQA- -881,7 +-868,6 +AEAAQA- static void blk+AF8-mq+AF8-timeout+A=
F8-work(struct work+AF8-struct +ACo-work)
+AD4-  				blk+AF8-mq+AF8-tag+AF8-idle(hctx)+ADs-
+AD4-  		+AH0-
+AD4-  	+AH0-
+AD4- -	blk+AF8-queue+AF8-exit(q)+ADs-
+AD4-  +AH0-

What prevents that a request queue is removed from set-+AD4-tag+AF8-list wh=
ile the above
loop examines tag+AF8-list? Can blk+AF8-cleanup+AF8-queue() queue be called=
 from the context
of another thread while this loop is examining hardware queues?
=20
+AD4- +-	timer+AF8-setup(+ACY-set-+AD4-timer, blk+AF8-mq+AF8-timed+AF8-out+=
AF8-timer, 0)+ADs-
+AD4- +-	INIT+AF8-WORK(+ACY-set-+AD4-timeout+AF8-work, blk+AF8-mq+AF8-timeo=
ut+AF8-work)+ADs-
+AD4- +AFs- ... +AF0-
+AD4- --- a/include/linux/blk-mq.h
+AD4- +-+-+- b/include/linux/blk-mq.h
+AD4- +AEAAQA- -86,6 +-86,8 +AEAAQA- struct blk+AF8-mq+AF8-tag+AF8-set +AHs=
-
+AD4- =20
+AD4-  	struct blk+AF8-mq+AF8-tags	+ACoAKg-tags+ADs-
+AD4- =20
+AD4- +-	struct timer+AF8-list	timer+ADs-
+AD4- +-	struct work+AF8-struct	timeout+AF8-work+ADs-

Can the timer and timeout+AF8-work data structures be replaced by a single
delayed+AF8-work instance?

Thanks,

Bart.
