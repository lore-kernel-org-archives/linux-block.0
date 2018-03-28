Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: only run mapped hw queues in
 blk_mq_run_hw_queues()
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Stefan Haberland <sth@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Christoph Hellwig <hch@lst.de>
References: <20180328012035.17565-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ab28ea2a-9061-a4bb-723f-7db46d9a61c2@kernel.dk>
Date: Tue, 27 Mar 2018 21:22:20 -0600
MIME-Version: 1.0
In-Reply-To: <20180328012035.17565-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/27/18 7:20 PM, Ming Lei wrote:
> From commit 20e4d813931961fe ("blk-mq: simplify queue mapping & schedule
> with each possisble CPU") on, it should be easier to see unmapped hctx
> in some CPU topo, such as, hctx may not be mapped to any CPU.
> 
> This patch avoids the warning in __blk_mq_delay_run_hw_queue() by
> checking if the hctx is mapped in blk_mq_run_hw_queues().
> 
> blk_mq_run_hw_queues() is often run in SCSI or some driver's completion
> path, so this warning has to be addressed.

I don't like this very much. You're catching just one particular case,
and if the hw queue has pending IO (for instance), then it's just wrong.

How about something like the below? Totally untested...

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 16e83e6df404..4c04ac124e5d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1307,6 +1307,14 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	int srcu_idx;
 
 	/*
+	 * Warn if the queue isn't mapped AND we have pending IO. Not being
+	 * mapped isn't necessarily a huge issue, if we don't have pending IO.
+	 */
+	if (!blk_mq_hw_queue_mapped(hctx) &&
+	    !WARN_ON_ONCE(blk_mq_hctx_has_pending(hctx)))
+		return;
+
+	/*
 	 * We should be running this queue from one of the CPUs that
 	 * are mapped to it.
 	 *

-- 
Jens Axboe
