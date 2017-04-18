Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>, Adam Manzanares
	<adam.manzanares@wdc.com>
Subject: [PATCH 1/5] block: Export blk_init_request_from_bio()
Date: Tue, 18 Apr 2017 16:10:33 -0700
Message-ID: <20170418231037.3968-2-bart.vanassche@sandisk.com>
In-Reply-To: <20170418231037.3968-1-bart.vanassche@sandisk.com>
References: <20170418231037.3968-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Export this function such that it becomes available to block
drivers.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Matias Bjørling <m@bjorling.me>
Cc: Adam Manzanares <adam.manzanares@wdc.com>
---
 block/blk-core.c       | 5 +++--
 block/blk-mq.c         | 2 +-
 block/blk.h            | 1 -
 include/linux/blkdev.h | 1 +
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ab1ecf71cb27..c274aed2ca3f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1633,7 +1633,7 @@ unsigned int blk_plug_queued_count(struct request_queue *q)
 	return ret;
 }
 
-void init_request_from_bio(struct request *req, struct bio *bio)
+void blk_init_request_from_bio(struct request *req, struct bio *bio)
 {
 	if (bio->bi_opf & REQ_RAHEAD)
 		req->cmd_flags |= REQ_FAILFAST_MASK;
@@ -1645,6 +1645,7 @@ void init_request_from_bio(struct request *req, struct bio *bio)
 		req->ioprio = bio_prio(bio);
 	blk_rq_bio_prep(req->q, req, bio);
 }
+EXPORT_SYMBOL(blk_init_request_from_bio);
 
 static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 {
@@ -1735,7 +1736,7 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 	 * We don't worry about that case for efficiency. It won't happen
 	 * often, and the elevators are able to handle it.
 	 */
-	init_request_from_bio(req, bio);
+	blk_init_request_from_bio(req, bio);
 
 	if (test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags))
 		req->cpu = raw_smp_processor_id();
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4d8368f657ac..a3a2e9c40453 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1410,7 +1410,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 
 static void blk_mq_bio_to_request(struct request *rq, struct bio *bio)
 {
-	init_request_from_bio(rq, bio);
+	blk_init_request_from_bio(rq, bio);
 
 	blk_account_io_start(rq, true);
 }
diff --git a/block/blk.h b/block/blk.h
index 07d375183f31..cc8e61cdc229 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -60,7 +60,6 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
 int blk_init_rl(struct request_list *rl, struct request_queue *q,
 		gfp_t gfp_mask);
 void blk_exit_rl(struct request_list *rl);
-void init_request_from_bio(struct request *req, struct bio *bio);
 void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
 			struct bio *bio);
 void blk_queue_bypass_start(struct request_queue *q);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7cadaa0cc0b9..e1ea875ec048 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -924,6 +924,7 @@ extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
 extern blk_qc_t generic_make_request(struct bio *bio);
 extern void blk_rq_init(struct request_queue *q, struct request *rq);
+extern void blk_init_request_from_bio(struct request *req, struct bio *bio);
 extern void blk_put_request(struct request *);
 extern void __blk_put_request(struct request_queue *, struct request *);
 extern struct request *blk_get_request(struct request_queue *, int, gfp_t);
-- 
2.12.2
