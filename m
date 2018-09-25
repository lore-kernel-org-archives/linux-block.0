Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1537888485.11137.1.camel@acm.org>
Subject: Re: [PATCH] blk-mq: Allow blocking queue tag iter callbacks
From: Bart Van Assche <bvanassche@acm.org>
To: Keith Busch <keith.busch@intel.com>, "jianchao.wang"
	 <jianchao.w.wang@oracle.com>
Cc: Linux Block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Date: Tue, 25 Sep 2018 08:14:45 -0700
In-Reply-To: <20180925143916.GB11657@localhost.localdomain>
References: <20180924210919.9995-1-keith.busch@intel.com>
	 <45fc0cf9-92b2-2380-d11b-428613a470c2@oracle.com>
	 <fc9d3a15-b136-478c-c35f-74a9a3479fb7@acm.org>
	 <4de9e32b-18a0-bc37-1454-def9486fe3e0@oracle.com>
	 <20180925143916.GB11657@localhost.localdomain>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-09-25 at 08:39 -0600, Keith Busch wrote:
+AD4 On Tue, Sep 25, 2018 at 10:39:46AM +-0800, jianchao.wang wrote:
+AD4 +AD4 But the issue is the left part of blk+AF8-mq+AF8-timeout+AF8-work is moved out of protection of q refcount.
+AD4 
+AD4 I'm not sure what you mean by +ACI-left part+ACI. The only part that isn't
+AD4 outside the reference with this patch is the part Bart pointed out.
+AD4 
+AD4 This looks like it may be fixed by either moving the refcount back up a
+AD4 level to all the callers of blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter, or add
+AD4 cancel+AF8-work+AF8-sync(+ACY-q-+AD4-timeout+AF8-work) to +AF8AXw-blk+AF8-mq+AF8-update+AF8-nr+AF8-hw+AF8-queues after
+AD4 the freeze.

Hi Keith,

How about applying the following (untested) patch on top of your patch?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 019f9b169887..099e203b5213 100644
--- a/block/blk-mq.c
+-+-+- b/block/blk-mq.c
+AEAAQA -851,6 +-851,9 +AEAAQA static void blk+AF8-mq+AF8-timeout+AF8-work(struct work+AF8-struct +ACo-work)
 	if (+ACE-blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter(q, blk+AF8-mq+AF8-check+AF8-expired, +ACY-next))
 		return+ADs
 
+-	if (+ACE-percpu+AF8-ref+AF8-tryget(+ACY-q-+AD4-q+AF8-usage+AF8-counter))
+-		return+ADs
+-
 	if (next +ACEAPQ 0) +AHs
 		mod+AF8-timer(+ACY-q-+AD4-timeout, next)+ADs
 	+AH0 else +AHs
+AEAAQA -866,6 +-869,7 +AEAAQA static void blk+AF8-mq+AF8-timeout+AF8-work(struct work+AF8-struct +ACo-work)
 				blk+AF8-mq+AF8-tag+AF8-idle(hctx)+ADs
 		+AH0
 	+AH0
+-	blk+AF8-queue+AF8-exit(q)+ADs
 +AH0

Thanks,

Bart.
