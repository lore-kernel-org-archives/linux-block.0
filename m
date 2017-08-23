Return-Path: <SRS0=1zCZ=7Z=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	Kernel-team@fb.com,
	Shaohua Li <shli@fb.com>
Subject: [PATCH 2/2] block/loop: allow request merge for directio mode
Date: Wed, 23 Aug 2017 16:49:24 -0700
Message-Id: <2fbfb61a927561c3c251fff8f6e75d7544df9eed.1503531709.git.shli@fb.com>
In-Reply-To: <cover.1503531709.git.shli@fb.com>
References: <cover.1503531709.git.shli@fb.com>
In-Reply-To: <cover.1503531709.git.shli@fb.com>
References: <cover.1503531709.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

Currently loop disables merge. While it makes sense for buffer IO mode,
directio mode can benefit from request merge. Without merge, loop could
send small size IO to underlayer disk and harm performance.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/block/loop.c | 43 +++++++++++++++++++++++++++++++++++--------
 drivers/block/loop.h |  1 +
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 428da07..1bfa3ff 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -213,10 +213,13 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 	 */
 	blk_mq_freeze_queue(lo->lo_queue);
 	lo->use_dio = use_dio;
-	if (use_dio)
+	if (use_dio) {
+		queue_flag_clear_unlocked(QUEUE_FLAG_NOMERGES, lo->lo_queue);
 		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
-	else
+	} else {
+		queue_flag_set_unlocked(QUEUE_FLAG_NOMERGES, lo->lo_queue);
 		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
+	}
 	blk_mq_unfreeze_queue(lo->lo_queue);
 }
 
@@ -464,6 +467,8 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
 {
 	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
 
+	kfree(cmd->bvec);
+	cmd->bvec = NULL;
 	cmd->ret = ret;
 	blk_mq_complete_request(cmd->rq);
 }
@@ -473,22 +478,44 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 {
 	struct iov_iter iter;
 	struct bio_vec *bvec;
-	struct bio *bio = cmd->rq->bio;
+	struct request *rq = cmd->rq;
+	struct bio *bio = rq->bio;
 	struct file *file = lo->lo_backing_file;
+	unsigned int offset;
+	int segments = 0;
 	int ret;
 
-	/* nomerge for loop request queue */
-	WARN_ON(cmd->rq->bio != cmd->rq->biotail);
+	if (rq->bio != rq->biotail) {
+		struct req_iterator iter;
+		struct bio_vec tmp;
+
+		__rq_for_each_bio(bio, rq)
+			segments += bio_segments(bio);
+		bvec = kmalloc(sizeof(struct bio_vec) * segments, GFP_KERNEL);
+		if (!bvec)
+			return -EIO;
+		cmd->bvec = bvec;
+
+		rq_for_each_segment(tmp, rq, iter) {
+			*bvec = tmp;
+			bvec++;
+		}
+		bvec = cmd->bvec;
+		offset = 0;
+	} else {
+		offset = bio->bi_iter.bi_bvec_done;
+		bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
+		segments = bio_segments(bio);
+	}
 
-	bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
 	iov_iter_bvec(&iter, ITER_BVEC | rw, bvec,
-		      bio_segments(bio), blk_rq_bytes(cmd->rq));
+		      segments, blk_rq_bytes(rq));
 	/*
 	 * This bio may be started from the middle of the 'bvec'
 	 * because of bio splitting, so offset from the bvec must
 	 * be passed to iov iterator
 	 */
-	iter.iov_offset = bio->bi_iter.bi_bvec_done;
+	iter.iov_offset = offset;
 
 	cmd->iocb.ki_pos = pos;
 	cmd->iocb.ki_filp = file;
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index fecd3f9..bc9cf91 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -72,6 +72,7 @@ struct loop_cmd {
 	bool use_aio;           /* use AIO interface to handle I/O */
 	long ret;
 	struct kiocb iocb;
+	struct bio_vec *bvec;
 };
 
 /* Support for loadable transfer modules */
-- 
2.9.5
