Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, Jens Axboe <axboe@fb.com>, Omar
 Sandoval <osandov@fb.com>
Subject: [PATCH 08/19] block: Introduce request_queue.initialize_rq_fn()
Date: Thu, 25 May 2017 11:43:16 -0700
Message-ID: <20170525184327.23570-9-bart.vanassche@sandisk.com>
In-Reply-To: <20170525184327.23570-1-bart.vanassche@sandisk.com>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Several block drivers need to initialize the driver-private data
after having called blk_get_request() and before .prep_rq_fn() is
called, e.g. when submitting a REQ_OP_SCSI_* request. Avoid that
that initialization code has to be repeated after every
blk_get_request() call by adding a new callback function to struct
request_queue.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org
---
 block/blk-core.c       | 3 +++
 block/blk-mq.c         | 3 +++
 include/linux/blkdev.h | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9416f6f495d4..fa453ed95973 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -126,6 +126,9 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->start_time = jiffies;
 	set_start_time_ns(rq);
 	rq->part = NULL;
+
+	if (q->initialize_rq_fn)
+		q->initialize_rq_fn(rq);
 }
 EXPORT_SYMBOL(blk_rq_init);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9ae1d9ccf4df..a1620b36b95c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -241,6 +241,9 @@ void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
 	rq->end_io_data = NULL;
 	rq->next_rq = NULL;
 
+	if (q->initialize_rq_fn)
+		q->initialize_rq_fn(rq);
+
 	ctx->rq_dispatched[op_is_sync(op)]++;
 }
 EXPORT_SYMBOL_GPL(blk_mq_rq_ctx_init);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 94fd2600584d..8a223a0c95d5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -410,8 +410,12 @@ struct request_queue {
 	rq_timed_out_fn		*rq_timed_out_fn;
 	dma_drain_needed_fn	*dma_drain_needed;
 	lld_busy_fn		*lld_busy_fn;
+	/* Called just after a request is allocated */
 	init_rq_fn		*init_rq_fn;
+	/* Called just before a request is freed */
 	exit_rq_fn		*exit_rq_fn;
+	/* Called from inside blk_get_request() */
+	void (*initialize_rq_fn)(struct request *rq);
 
 	const struct blk_mq_ops	*mq_ops;
 
-- 
2.12.2
