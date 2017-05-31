Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, "Omar
 Sandoval" <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 11/12] blk-mq: Warn when attempting to run a hardware queue that is not mapped
Date: Wed, 31 May 2017 15:52:45 -0700
Message-ID: <20170531225246.26261-12-bart.vanassche@sandisk.com>
In-Reply-To: <20170531225246.26261-1-bart.vanassche@sandisk.com>
References: <20170531225246.26261-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

A queue must be frozen while the mapped state of a hardware queue
is changed. Additionally, any change of the mapped state is
followed by a call to blk_mq_map_swqueue() (see also
blk_mq_init_allocated_queue() and blk_mq_update_nr_hw_queues()).
Since blk_mq_map_swqueue() does not map any unmapped hardware
queue onto any software queue, no attempt will be made to run
an unmapped hardware queue. Hence issue a warning upon attempts
to run an unmapped hardware queue.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b56cb3d9060f..12a627743842 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1091,8 +1091,9 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 					unsigned long msecs)
 {
-	if (unlikely(blk_mq_hctx_stopped(hctx) ||
-		     !blk_mq_hw_queue_mapped(hctx)))
+	WARN_ON_ONCE(!blk_mq_hw_queue_mapped(hctx));
+
+	if (unlikely(blk_mq_hctx_stopped(hctx)))
 		return;
 
 	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
@@ -1252,7 +1253,7 @@ static void blk_mq_run_work_fn(struct work_struct *work)
 
 void blk_mq_delay_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
 {
-	if (unlikely(!blk_mq_hw_queue_mapped(hctx)))
+	if (WARN_ON_ONCE(!blk_mq_hw_queue_mapped(hctx)))
 		return;
 
 	/*
-- 
2.12.2
