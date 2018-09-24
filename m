Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1537818667.195115.22.camel@gmail.com>
Subject: Re: Regression caused by f5bbbbe4d635
From: Bart Van Assche <bart.vanassche@gmail.com>
To: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>
Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>,
	"linux-block@vger.kernel.org"
	 <linux-block@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>
Date: Mon, 24 Sep 2018 12:51:07 -0700
In-Reply-To: <20180924191348.GB9223@localhost.localdomain>
References: <bae37c56-3f12-448d-cdb5-6ed2c2d069a4@kernel.dk>
	 <20180924191348.GB9223@localhost.localdomain>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-09-24 at 13:13 -0600, Keith Busch wrote:
+AD4 diff --git a/block/blk-mq.c b/block/blk-mq.c
+AD4 index 85a1c1a59c72..28d128450621 100644
+AD4 --- a/block/blk-mq.c
+AD4 +-+-+- b/block/blk-mq.c
+AD4 +AEAAQA -848,22 +-848,6 +AEAAQA static void blk+AF8-mq+AF8-timeout+AF8-work(struct work+AF8-struct +ACo-work)
+AD4 	struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx+ADs
+AD4 	int i+ADs
+AD4  
+AD4 -	/+ACo A deadlock might occur if a request is stuck requiring a
+AD4 -	 +ACo timeout at the same time a queue freeze is waiting
+AD4 -	 +ACo completion, since the timeout code would not be able to
+AD4 -	 +ACo acquire the queue reference here.
+AD4 -	 +ACo
+AD4 -	 +ACo That's why we don't use blk+AF8-queue+AF8-enter here+ADs instead, we use
+AD4 -	 +ACo percpu+AF8-ref+AF8-tryget directly, because we need to be able to
+AD4 -	 +ACo obtain a reference even in the short window between the queue
+AD4 -	 +ACo starting to freeze, by dropping the first reference in
+AD4 -	 +ACo blk+AF8-freeze+AF8-queue+AF8-start, and the moment the last request is
+AD4 -	 +ACo consumed, marked by the instant q+AF8-usage+AF8-counter reaches
+AD4 -	 +ACo zero.
+AD4 -	 +ACo-/
+AD4 -	if (+ACE-percpu+AF8-ref+AF8-tryget(+ACY-q-+AD4-q+AF8-usage+AF8-counter))
+AD4 -		return+ADs
+AD4 -
+AD4 	blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter(q, blk+AF8-mq+AF8-check+AF8-expired, +ACY-next)+ADs
+AD4  
+AD4 	if (next +ACEAPQ 0) +AHs
+AD4 +AEAAQA -881,7 +-865,6 +AEAAQA static void blk+AF8-mq+AF8-timeout+AF8-work(struct work+AF8-struct +ACo-work)
+AD4 				blk+AF8-mq+AF8-tag+AF8-idle(hctx)+ADs
+AD4 		+AH0
+AD4 	+AH0
+AD4 -	blk+AF8-queue+AF8-exit(q)+ADs
+AD4  +AH0

Hi Keith,

The above introduces a behavior change: if the percpu+AF8-ref+AF8-tryget() call inside
blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter() fails then blk+AF8-mq+AF8-timeout+AF8-work() will now call
blk+AF8-mq+AF8-tag+AF8-idle(). I think that's wrong if the percpu+AF8-ref+AF8-tryget() call fails
due to the queue having been frozen. Please make blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter()
return a bool that indicates whether or not it has iterated over the request
queue.

Thanks,

Bart.
