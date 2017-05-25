Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, "Omar
 Sandoval" <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 19/19] block: Make request operation type argument declarations consistent
Date: Thu, 25 May 2017 11:43:27 -0700
Message-ID: <20170525184327.23570-20-bart.vanassche@sandisk.com>
In-Reply-To: <20170525184327.23570-1-bart.vanassche@sandisk.com>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Instead of declaring the second argument of blk_*_get_request()
as int and passing it to functions that expect an unsigned int,
declare that second argument as unsigned int. Also because of
consistency, rename that second argument from 'rw' into 'op'.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c       | 13 +++++++------
 block/blk-mq.c         | 10 +++++-----
 include/linux/blk-mq.h |  6 +++---
 include/linux/blkdev.h |  3 ++-
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 82e0dbfc593b..02952e85c580 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1326,8 +1326,8 @@ static struct request *get_request(struct request_queue *q, unsigned int op,
 	goto retry;
 }
 
-static struct request *blk_old_get_request(struct request_queue *q, int rw,
-		gfp_t gfp_mask)
+static struct request *blk_old_get_request(struct request_queue *q,
+					   unsigned int op, gfp_t gfp_mask)
 {
 	struct request *rq;
 
@@ -1337,7 +1337,7 @@ static struct request *blk_old_get_request(struct request_queue *q, int rw,
 	create_io_context(gfp_mask, q->node);
 
 	spin_lock_irq(q->queue_lock);
-	rq = get_request(q, rw, NULL, gfp_mask);
+	rq = get_request(q, op, NULL, gfp_mask);
 	if (IS_ERR(rq)) {
 		spin_unlock_irq(q->queue_lock);
 		return rq;
@@ -1350,14 +1350,15 @@ static struct request *blk_old_get_request(struct request_queue *q, int rw,
 	return rq;
 }
 
-struct request *blk_get_request(struct request_queue *q, int rw, gfp_t gfp_mask)
+struct request *blk_get_request(struct request_queue *q, unsigned int op,
+				gfp_t gfp_mask)
 {
 	if (q->mq_ops)
-		return blk_mq_alloc_request(q, rw,
+		return blk_mq_alloc_request(q, op,
 			(gfp_mask & __GFP_DIRECT_RECLAIM) ?
 				0 : BLK_MQ_REQ_NOWAIT);
 	else
-		return blk_old_get_request(q, rw, gfp_mask);
+		return blk_old_get_request(q, op, gfp_mask);
 }
 EXPORT_SYMBOL(blk_get_request);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b1b2c7b4344..aa2e9eb643a9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -281,7 +281,7 @@ struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
 }
 EXPORT_SYMBOL_GPL(__blk_mq_alloc_request);
 
-struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
+struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 		unsigned int flags)
 {
 	struct blk_mq_alloc_data alloc_data = { .flags = flags };
@@ -292,7 +292,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 	if (ret)
 		return ERR_PTR(ret);
 
-	rq = blk_mq_sched_get_request(q, NULL, rw, &alloc_data);
+	rq = blk_mq_sched_get_request(q, NULL, op, &alloc_data);
 
 	blk_mq_put_ctx(alloc_data.ctx);
 	blk_queue_exit(q);
@@ -307,8 +307,8 @@ struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 }
 EXPORT_SYMBOL(blk_mq_alloc_request);
 
-struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
-		unsigned int flags, unsigned int hctx_idx)
+struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
+		unsigned int op, unsigned int flags, unsigned int hctx_idx)
 {
 	struct blk_mq_alloc_data alloc_data = { .flags = flags };
 	struct request *rq;
@@ -343,7 +343,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
 	cpu = cpumask_first(alloc_data.hctx->cpumask);
 	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
 
-	rq = blk_mq_sched_get_request(q, NULL, rw, &alloc_data);
+	rq = blk_mq_sched_get_request(q, NULL, op, &alloc_data);
 
 	blk_queue_exit(q);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index c589b81be491..da892b9fd4d7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -205,10 +205,10 @@ enum {
 	BLK_MQ_REQ_INTERNAL	= (1 << 2), /* allocate internal/sched tag */
 };
 
-struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
+struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 		unsigned int flags);
-struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int op,
-		unsigned int flags, unsigned int hctx_idx);
+struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
+		unsigned int op, unsigned int flags, unsigned int hctx_idx);
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag);
 
 enum {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 293067a2726e..85230b5259da 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -942,7 +942,8 @@ extern void blk_rq_init(struct request_queue *q, struct request *rq);
 extern void blk_init_request_from_bio(struct request *req, struct bio *bio);
 extern void blk_put_request(struct request *);
 extern void __blk_put_request(struct request_queue *, struct request *);
-extern struct request *blk_get_request(struct request_queue *, int, gfp_t);
+extern struct request *blk_get_request(struct request_queue *, unsigned int op,
+				       gfp_t gfp_mask);
 extern void blk_requeue_request(struct request_queue *, struct request *);
 extern int blk_lld_busy(struct request_queue *q);
 extern int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
-- 
2.12.2
