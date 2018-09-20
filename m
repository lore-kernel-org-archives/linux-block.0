Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1537456990.204730.5.camel@acm.org>
Subject: Re: [PATCH v9 7/8] block: Make blk_get_request() block for non-PM
 requests while suspended
From: Bart Van Assche <bvanassche@acm.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Christoph
 Hellwig <hch@lst.de>, Jianchao Wang <jianchao.w.wang@oracle.com>, Hannes
 Reinecke <hare@suse.com>,  Johannes Thumshirn <jthumshirn@suse.de>, Alan
 Stern <stern@rowland.harvard.edu>
Date: Thu, 20 Sep 2018 08:23:10 -0700
In-Reply-To: <20180920034851.GD27645@ming.t460p>
References: <20180919224530.222469-1-bvanassche@acm.org>
	 <20180919224530.222469-8-bvanassche@acm.org>
	 <20180920034851.GD27645@ming.t460p>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-09-20 at 11:48 +-0800, Ming Lei wrote:
+AD4 On Wed, Sep 19, 2018 at 03:45:29PM -0700, Bart Van Assche wrote:
+AD4 +AD4 +-	ret +AD0 -EBUSY+ADs
+AD4 +AD4 +-	if (blk+AF8-requests+AF8-in+AF8-flight(q) +AD0APQ 0) +AHs
+AD4 +AD4 +-		blk+AF8-freeze+AF8-queue+AF8-start(q)+ADs
+AD4 +AD4 +-		/+ACo
+AD4 +AD4 +-		 +ACo Freezing a queue starts a transition of the
+AD4 +AD4 queue
+AD4 +AD4 +-		 +ACo usage counter to atomic mode. Wait until atomic
+AD4 +AD4 +-		 +ACo mode has been reached. This involves calling
+AD4 +AD4 +-		 +ACo call+AF8-rcu(). That call guarantees that later
+AD4 +AD4 +-		 +ACo blk+AF8-queue+AF8-enter() calls see the pm-only state.
+AD4 +AD4 See
+AD4 +AD4 +-		 +ACo also http://lwn.net/Articles/573497/.
+AD4 +AD4 +-		 +ACo-/
+AD4 +AD4 +-		percpu+AF8-ref+AF8-switch+AF8-to+AF8-atomic+AF8-sync(+ACY-q-
+AD4 +AD4 +AD4-q+AF8-usage+AF8-counter)+ADs
+AD4 +AD4 +-		if (percpu+AF8-ref+AF8-is+AF8-zero(+ACY-q-+AD4-q+AF8-usage+AF8-counter))
+AD4 +AD4 +-			ret +AD0 0+ADs
+AD4 +AD4 +-		blk+AF8-mq+AF8-unfreeze+AF8-queue(q)+ADs
+AD4 
+AD4 Tejun doesn't agree on this kind of usage yet, so the ref has to be
+AD4 dropped before calling blk+AF8-mq+AF8-unfreeze+AF8-queue().

I read all Tejuns' recent e-mails but I have not found any e-mail from
Tejun in which he wrote that he disagrees with the above pattern.

+AD4 Also, this way still can't address the race in the following link:
+AD4 
+AD4 https://marc.info/?l+AD0-linux-block+ACY-m+AD0-153732992701093+ACY-w+AD0-2

I think that the following patch is sufficient to fix that race:

diff --git a/block/blk-core.c b/block/blk-core.c
index ae092ca121d5..16dd3a989753 100644
--- a/block/blk-core.c
+-+-+- b/block/blk-core.c
+AEAAQA -942,8 +-942,6 +AEAAQA int blk+AF8-queue+AF8-enter(struct request+AF8-queue +ACo-q,
blk+AF8-mq+AF8-req+AF8-flags+AF8-t flags)
 		if (success)
 			return 0+ADs
 
-		blk+AF8-pm+AF8-request+AF8-resume(q)+ADs
-
 		if (flags +ACY BLK+AF8-MQ+AF8-REQ+AF8-NOWAIT)
 			return -EBUSY+ADs
 
+AEAAQA -958,7 +-956,8 +AEAAQA int blk+AF8-queue+AF8-enter(struct request+AF8-queue +ACo-q,
blk+AF8-mq+AF8-req+AF8-flags+AF8-t flags)
 
 		wait+AF8-event(q-+AD4-mq+AF8-freeze+AF8-wq,
 			   (atomic+AF8-read(+ACY-q-+AD4-mq+AF8-freeze+AF8-depth) +AD0APQ 0 +ACYAJg
-			    (pm +AHwAfA +ACE-blk+AF8-queue+AF8-pm+AF8-only(q))) +AHwAfA
+-			    (pm +AHwAfA (blk+AF8-pm+AF8-request+AF8-resume(q),
+-				    +ACE-blk+AF8-queue+AF8-pm+AF8-only(q)))) +AHwAfA
 			   blk+AF8-queue+AF8-dying(q))+ADs
 		if (blk+AF8-queue+AF8-dying(q))
 			return -ENODEV+ADs

Bart.
