Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: only run mapped hw queues in
 blk_mq_run_hw_queues()
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Stefan Haberland <sth@linux.vnet.ibm.com>, Christoph Hellwig <hch@lst.de>
References: <20180328012035.17565-1-ming.lei@redhat.com>
 <ab28ea2a-9061-a4bb-723f-7db46d9a61c2@kernel.dk>
 <ebd41c63-5b64-23a7-1914-4abdedf3c9b2@de.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4c774763-3c47-f930-a44e-5fcc5ae5afa0@kernel.dk>
Date: Wed, 28 Mar 2018 08:38:59 -0600
MIME-Version: 1.0
In-Reply-To: <ebd41c63-5b64-23a7-1914-4abdedf3c9b2@de.ibm.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/28/18 1:45 AM, Christian Borntraeger wrote:
> FWIW, this patch does not fix the issue for me:

Looks like I didn't do the delayed path. How about the below?


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 16e83e6df404..fd663ae1094c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1302,10 +1302,23 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	return (queued + errors) != 0;
 }
 
+static bool blk_mq_bail_unmapped(struct blk_mq_hw_ctx *hctx)
+{
+	/*
+	 * Warn if the queue isn't mapped AND we have pending IO. Not being
+	 * mapped isn't necessarily a huge issue, if we don't have pending IO.
+	 */
+	return !blk_mq_hw_queue_mapped(hctx) &&
+		!WARN_ON_ONCE(blk_mq_hctx_has_pending(hctx));
+}
+
 static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 {
 	int srcu_idx;
 
+	if (blk_mq_bail_unmapped(hctx))
+		return;
+
 	/*
 	 * We should be running this queue from one of the CPUs that
 	 * are mapped to it.
@@ -1399,9 +1412,8 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 					unsigned long msecs)
 {
-	if (WARN_ON_ONCE(!blk_mq_hw_queue_mapped(hctx)))
+	if (blk_mq_bail_unmapped(hctx))
 		return;
-
 	if (unlikely(blk_mq_hctx_stopped(hctx)))
 		return;
 

-- 
Jens Axboe
