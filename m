Return-Path: <BATV+e774f35f755d74bf45df+5174+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 07/17] block: add a poll_fn callback to struct request_queue
Date: Mon, 23 Oct 2017 16:51:16 +0200
Message-Id: <20171023145126.2471-8-hch@lst.de>
In-Reply-To: <20171023145126.2471-1-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

That we we can also poll non blk-mq queues.  Mostly needed for
the NVMe multipath code, but could also be useful elsewhere.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c             | 11 +++++++++++
 block/blk-mq.c               | 14 +++++---------
 drivers/nvme/target/io-cmd.c |  2 +-
 fs/block_dev.c               |  4 ++--
 fs/direct-io.c               |  2 +-
 fs/iomap.c                   |  2 +-
 include/linux/blkdev.h       |  4 +++-
 mm/page_io.c                 |  2 +-
 8 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index e804529e65a5..8e7e12e5ffa2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2319,6 +2319,17 @@ blk_qc_t submit_bio(struct bio *bio)
 }
 EXPORT_SYMBOL(submit_bio);
 
+bool blk_poll(struct request_queue *q, blk_qc_t cookie)
+{
+	if (!q->poll_fn || !blk_qc_t_valid(cookie))
+		return false;
+
+	if (current->plug)
+		blk_flush_plug_list(current->plug, false);
+	return q->poll_fn(q, cookie);
+}
+EXPORT_SYMBOL_GPL(blk_poll);
+
 /**
  * blk_cloned_rq_check_limits - Helper function to check a cloned request
  *                              for new the queue limits
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7f01d69879d6..10c99cf6fd71 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -37,6 +37,7 @@
 #include "blk-wbt.h"
 #include "blk-mq-sched.h"
 
+static bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie);
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
 
@@ -2401,6 +2402,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	spin_lock_init(&q->requeue_lock);
 
 	blk_queue_make_request(q, blk_mq_make_request);
+	if (q->mq_ops->poll)
+		q->poll_fn = blk_mq_poll;
 
 	/*
 	 * Do this after blk_queue_make_request() overrides it...
@@ -2860,20 +2863,14 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 	return false;
 }
 
-bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
+static bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
 {
 	struct blk_mq_hw_ctx *hctx;
-	struct blk_plug *plug;
 	struct request *rq;
 
-	if (!q->mq_ops || !q->mq_ops->poll || !blk_qc_t_valid(cookie) ||
-	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return false;
 
-	plug = current->plug;
-	if (plug)
-		blk_flush_plug_list(plug, false);
-
 	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
 	if (!blk_qc_t_is_internal(cookie))
 		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
@@ -2891,7 +2888,6 @@ bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
 
 	return __blk_mq_poll(hctx, rq);
 }
-EXPORT_SYMBOL_GPL(blk_mq_poll);
 
 static int __init blk_mq_init(void)
 {
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 0d4c23dc4532..db632818777d 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -94,7 +94,7 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 
 	cookie = submit_bio(bio);
 
-	blk_mq_poll(bdev_get_queue(req->ns->bdev), cookie);
+	blk_poll(bdev_get_queue(req->ns->bdev), cookie);
 }
 
 static void nvmet_execute_flush(struct nvmet_req *req)
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 93d088ffc05c..49a55246ba50 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -249,7 +249,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		if (!READ_ONCE(bio.bi_private))
 			break;
 		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_mq_poll(bdev_get_queue(bdev), qc))
+		    !blk_poll(bdev_get_queue(bdev), qc))
 			io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -414,7 +414,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 			break;
 
 		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_mq_poll(bdev_get_queue(bdev), qc))
+		    !blk_poll(bdev_get_queue(bdev), qc))
 			io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 62cf812ed0e5..d2bc339cb1e9 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -486,7 +486,7 @@ static struct bio *dio_await_one(struct dio *dio)
 		dio->waiter = current;
 		spin_unlock_irqrestore(&dio->bio_lock, flags);
 		if (!(dio->iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_mq_poll(dio->bio_disk->queue, dio->bio_cookie))
+		    !blk_poll(dio->bio_disk->queue, dio->bio_cookie))
 			io_schedule();
 		/* wake up sets us TASK_RUNNING */
 		spin_lock_irqsave(&dio->bio_lock, flags);
diff --git a/fs/iomap.c b/fs/iomap.c
index 8194d30bdca0..4241bac905b1 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1049,7 +1049,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 
 			if (!(iocb->ki_flags & IOCB_HIPRI) ||
 			    !dio->submit.last_queue ||
-			    !blk_mq_poll(dio->submit.last_queue,
+			    !blk_poll(dio->submit.last_queue,
 					 dio->submit.cookie))
 				io_schedule();
 		}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 45c63764a14e..a18ea9b9b8f7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -266,6 +266,7 @@ struct blk_queue_ctx;
 
 typedef void (request_fn_proc) (struct request_queue *q);
 typedef blk_qc_t (make_request_fn) (struct request_queue *q, struct bio *bio);
+typedef bool (poll_q_fn) (struct request_queue *q, blk_qc_t);
 typedef int (prep_rq_fn) (struct request_queue *, struct request *);
 typedef void (unprep_rq_fn) (struct request_queue *, struct request *);
 
@@ -408,6 +409,7 @@ struct request_queue {
 
 	request_fn_proc		*request_fn;
 	make_request_fn		*make_request_fn;
+	poll_q_fn		*poll_fn;
 	prep_rq_fn		*prep_rq_fn;
 	unprep_rq_fn		*unprep_rq_fn;
 	softirq_done_fn		*softirq_done_fn;
@@ -991,7 +993,7 @@ extern void blk_execute_rq_nowait(struct request_queue *, struct gendisk *,
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
 
-bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie);
+bool blk_poll(struct request_queue *q, blk_qc_t cookie);
 
 static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 {
diff --git a/mm/page_io.c b/mm/page_io.c
index 21502d341a67..ff04de630c46 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -407,7 +407,7 @@ int swap_readpage(struct page *page, bool do_poll)
 		if (!READ_ONCE(bio->bi_private))
 			break;
 
-		if (!blk_mq_poll(disk->queue, qc))
+		if (!blk_poll(disk->queue, qc))
 			break;
 	}
 	__set_current_state(TASK_RUNNING);
-- 
2.14.2
