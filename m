Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1537393175.186311.3.camel@acm.org>
Subject: Re: [PATCH v8 6/8] block: Schedule runtime resume earlier
From: Bart Van Assche <bvanassche@acm.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Christoph
 Hellwig <hch@lst.de>, Jianchao Wang <jianchao.w.wang@oracle.com>, Hannes
 Reinecke <hare@suse.com>,  Johannes Thumshirn <jthumshirn@suse.de>, Alan
 Stern <stern@rowland.harvard.edu>
Date: Wed, 19 Sep 2018 14:39:35 -0700
In-Reply-To: <20180919040514.GE20560@ming.t460p>
References: <20180918205903.15516-1-bvanassche@acm.org>
	 <20180918205903.15516-7-bvanassche@acm.org>
	 <20180919040514.GE20560@ming.t460p>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-09-19 at 12:05 +-0800, Ming Lei wrote:
+AD4 Looks this patch may introduce the following race between queue
+AD4 freeze and
+AD4 runtime suspend:
+AD4 
+AD4 -------------------------------------------------------------------
+AD4 -------
+AD4 CPU0				CPU1				
+AD4 		CPU2
+AD4 -------------------------------------------------------------------
+AD4 -------
+AD4 
+AD4 blk+AF8-freeze+AF8-queue()
+AD4 
+AD4 					blk+AF8-mq+AF8-alloc+AF8-request()
+AD4 						blk+AF8-queue+AF8-enter()
+AD4 							blk+AF8-pm+AF8-request+AF8
+AD4 resume()
+AD4 							wait+AF8-event()
+AD4 
+AD4 									
+AD4 			blk+AF8-pre+AF8-runtime+AF8-suspend()
+AD4 									
+AD4 				-+AD4-blk+AF8-set+AF8-pm+AF8-only
+AD4 									
+AD4 			...
+AD4 									
+AD4 			blk+AF8-post+AF8-runtime+AF8-suspend()
+AD4 
+AD4 ...
+AD4 blk+AF8-mq+AF8-unfreeze+AF8-queue()
+AD4 -------------------------------------------------------------------
+AD4 -------
+AD4 - CPU0: queue is frozen
+AD4 
+AD4 - CPU1: one new request comes, and see queue is frozen, but queue
+AD4 isn't
+AD4 runtime-suspended yet, then blk+AF8-pm+AF8-request+AF8-resume() does nothing. So
+AD4 this
+AD4 allocation is blocked in wait+AF8-event().
+AD4 
+AD4 - CPU2: runtime suspend comes, and queue becomes runtime-suspended
+AD4 now
+AD4 
+AD4 - CPU0: queue is unfreeze, but the new request allocation in CPU1 may
+AD4 never
+AD4 be done because the queue is runtime suspended, and wait+AF8-event()
+AD4 won't return.
+AD4 And the expected result is that the queue becomes active and the
+AD4 allocation on
+AD4 CPU1 is done immediately.

Hello Ming,

Just like for the scenario Jianchao reported, I will address this by
only allowing the suspend to proceed if q+AF8-usage+AF8-counter +AD0APQ 0.

Bart.
