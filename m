Return-Path: <BATV+add76be85c7e68b62602+4917+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] block: optionally merge discontiguous discard bios into a single request
Date: Wed,  8 Feb 2017 14:46:49 +0100
Message-Id: <20170208134650.5380-4-hch@lst.de>
In-Reply-To: <20170208134650.5380-1-hch@lst.de>
References: <20170208134650.5380-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Add a new merge strategy that merges discard bios into a request until the
maximum number of discard ranges (or the maximum discard size) is reached
from the plug merging code.  I/O scheduler merging is not wired up yet
but might also be useful, although not for fast devices like NVMe which
are the only user for now.

Note that for now we don't support limiting the size of each discard range,
but if needed that can be added later.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c         | 27 +++++++++++++++++++++++++++
 block/blk-merge.c        |  5 ++++-
 block/blk-mq.c           |  3 +++
 block/blk-settings.c     | 20 ++++++++++++++++++++
 block/blk-sysfs.c        | 12 ++++++++++++
 block/blk.h              |  2 ++
 include/linux/blkdev.h   | 26 ++++++++++++++++++++++++++
 include/linux/elevator.h |  1 +
 8 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 75fe534861df..b9e857f4afe8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1485,6 +1485,30 @@ bool bio_attempt_front_merge(struct request_queue *q, struct request *req,
 	return true;
 }
 
+bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
+		struct bio *bio)
+{
+	unsigned short segments = blk_rq_nr_discard_segments(req);
+
+	if (segments >= queue_max_discard_segments(q))
+		goto no_merge;
+	if (blk_rq_sectors(req) + bio_sectors(bio) >
+	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
+		goto no_merge;
+
+	req->biotail->bi_next = bio;
+	req->biotail = bio;
+	req->__data_len += bio->bi_iter.bi_size;
+	req->ioprio = ioprio_best(req->ioprio, bio_prio(bio));
+	req->nr_phys_segments = segments + 1;
+
+	blk_account_io_start(req, false);
+	return true;
+no_merge:
+	req_set_nomerge(q, req);
+	return false;
+}
+
 /**
  * blk_attempt_plug_merge - try to merge with %current's plugged list
  * @q: request_queue new bio is being queued at
@@ -1549,6 +1573,9 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		case ELEVATOR_FRONT_MERGE:
 			merged = bio_attempt_front_merge(q, rq, bio);
 			break;
+		case ELEVATOR_DISCARD_MERGE:
+			merged = bio_attempt_discard_merge(q, rq, bio);
+			break;
 		default:
 			break;
 		}
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 6cbd90ad5f90..2afa262425d1 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -803,7 +803,10 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 
 enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
 {
-	if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
+	if (req_op(rq) == REQ_OP_DISCARD &&
+	    queue_max_discard_segments(rq->q) > 1)
+		return ELEVATOR_DISCARD_MERGE;
+	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
 		return ELEVATOR_BACK_MERGE;
 	else if (blk_rq_pos(rq) - bio_sectors(bio) == bio->bi_iter.bi_sector)
 		return ELEVATOR_FRONT_MERGE;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9294633759d9..89cb2d224488 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -780,6 +780,9 @@ static bool blk_mq_attempt_merge(struct request_queue *q,
 			if (blk_mq_sched_allow_merge(q, rq, bio))
 				merged = bio_attempt_front_merge(q, rq, bio);
 			break;
+		case ELEVATOR_DISCARD_MERGE:
+			merged = bio_attempt_discard_merge(q, rq, bio);
+			break;
 		default:
 			continue;
 		}
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 6eb19bcbf3cb..1e7174ffc9d4 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -88,6 +88,7 @@ EXPORT_SYMBOL_GPL(blk_queue_lld_busy);
 void blk_set_default_limits(struct queue_limits *lim)
 {
 	lim->max_segments = BLK_MAX_SEGMENTS;
+	lim->max_discard_segments = 1;
 	lim->max_integrity_segments = 0;
 	lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
 	lim->virt_boundary_mask = 0;
@@ -128,6 +129,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	/* Inherit limits from component devices */
 	lim->discard_zeroes_data = 1;
 	lim->max_segments = USHRT_MAX;
+	lim->max_discard_segments = 1;
 	lim->max_hw_sectors = UINT_MAX;
 	lim->max_segment_size = UINT_MAX;
 	lim->max_sectors = UINT_MAX;
@@ -337,6 +339,22 @@ void blk_queue_max_segments(struct request_queue *q, unsigned short max_segments
 EXPORT_SYMBOL(blk_queue_max_segments);
 
 /**
+ * blk_queue_max_discard_segments - set max segments for discard requests
+ * @q:  the request queue for the device
+ * @max_segments:  max number of segments
+ *
+ * Description:
+ *    Enables a low level driver to set an upper limit on the number of
+ *    segments in a discard request.
+ **/
+void blk_queue_max_discard_segments(struct request_queue *q,
+		unsigned short max_segments)
+{
+	q->limits.max_discard_segments = max_segments;
+}
+EXPORT_SYMBOL_GPL(blk_queue_max_discard_segments);
+
+/**
  * blk_queue_max_segment_size - set max segment size for blk_rq_map_sg
  * @q:  the request queue for the device
  * @max_size:  max size of segment in bytes
@@ -553,6 +571,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 					    b->virt_boundary_mask);
 
 	t->max_segments = min_not_zero(t->max_segments, b->max_segments);
+	t->max_discard_segments = min_not_zero(t->max_discard_segments,
+					       b->max_discard_segments);
 	t->max_integrity_segments = min_not_zero(t->max_integrity_segments,
 						 b->max_integrity_segments);
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 48032c4759a7..070d81bae1d5 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -121,6 +121,12 @@ static ssize_t queue_max_segments_show(struct request_queue *q, char *page)
 	return queue_var_show(queue_max_segments(q), (page));
 }
 
+static ssize_t queue_max_discard_segments_show(struct request_queue *q,
+		char *page)
+{
+	return queue_var_show(queue_max_discard_segments(q), (page));
+}
+
 static ssize_t queue_max_integrity_segments_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(q->limits.max_integrity_segments, (page));
@@ -545,6 +551,11 @@ static struct queue_sysfs_entry queue_max_segments_entry = {
 	.show = queue_max_segments_show,
 };
 
+static struct queue_sysfs_entry queue_max_discard_segments_entry = {
+	.attr = {.name = "max_discard_segments", .mode = S_IRUGO },
+	.show = queue_max_discard_segments_show,
+};
+
 static struct queue_sysfs_entry queue_max_integrity_segments_entry = {
 	.attr = {.name = "max_integrity_segments", .mode = S_IRUGO },
 	.show = queue_max_integrity_segments_show,
@@ -697,6 +708,7 @@ static struct attribute *default_attrs[] = {
 	&queue_max_hw_sectors_entry.attr,
 	&queue_max_sectors_entry.attr,
 	&queue_max_segments_entry.attr,
+	&queue_max_discard_segments_entry.attr,
 	&queue_max_integrity_segments_entry.attr,
 	&queue_max_segment_size_entry.attr,
 	&queue_iosched_entry.attr,
diff --git a/block/blk.h b/block/blk.h
index ae82f2ac4019..d1ea4bd9b9a3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -100,6 +100,8 @@ bool bio_attempt_front_merge(struct request_queue *q, struct request *req,
 			     struct bio *bio);
 bool bio_attempt_back_merge(struct request_queue *q, struct request *req,
 			    struct bio *bio);
+bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
+		struct bio *bio);
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 			    unsigned int *request_count,
 			    struct request **same_queue_rq);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e0bac14347e6..aecca0e7d9ca 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -331,6 +331,7 @@ struct queue_limits {
 	unsigned short		logical_block_size;
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
+	unsigned short		max_discard_segments;
 
 	unsigned char		misaligned;
 	unsigned char		discard_misaligned;
@@ -1146,6 +1147,8 @@ extern void blk_queue_bounce_limit(struct request_queue *, u64);
 extern void blk_queue_max_hw_sectors(struct request_queue *, unsigned int);
 extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
 extern void blk_queue_max_segments(struct request_queue *, unsigned short);
+extern void blk_queue_max_discard_segments(struct request_queue *,
+		unsigned short);
 extern void blk_queue_max_segment_size(struct request_queue *, unsigned int);
 extern void blk_queue_max_discard_sectors(struct request_queue *q,
 		unsigned int max_discard_sectors);
@@ -1189,6 +1192,15 @@ extern void blk_queue_rq_timeout(struct request_queue *, unsigned int);
 extern void blk_queue_flush_queueable(struct request_queue *q, bool queueable);
 extern void blk_queue_write_cache(struct request_queue *q, bool enabled, bool fua);
 
+/*
+ * Number of physical segments as sent to the device.
+ *
+ * Normally this is the number of discontiguous data segments sent by the
+ * submitter.  But for data-less command like discard we might have no
+ * actual data segments submitted, but the driver might have to add it's
+ * own special payload.  In that case we still return 1 here so that this
+ * special payload will be mapped.
+ */
 static inline unsigned short blk_rq_nr_phys_segments(struct request *rq)
 {
 	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
@@ -1196,6 +1208,15 @@ static inline unsigned short blk_rq_nr_phys_segments(struct request *rq)
 	return rq->nr_phys_segments;
 }
 
+/*
+ * Number of discard segments (or ranges) the driver needs to fill in.
+ * Each discard bio merged into a request is counted as one segment.
+ */
+static inline unsigned short blk_rq_nr_discard_segments(struct request *rq)
+{
+	return max_t(unsigned short, rq->nr_phys_segments, 1);
+}
+
 extern int blk_rq_map_sg(struct request_queue *, struct request *, struct scatterlist *);
 extern void blk_dump_rq_flags(struct request *, char *);
 extern long nr_blockdev_pages(void);
@@ -1384,6 +1405,11 @@ static inline unsigned short queue_max_segments(struct request_queue *q)
 	return q->limits.max_segments;
 }
 
+static inline unsigned short queue_max_discard_segments(struct request_queue *q)
+{
+	return q->limits.max_discard_segments;
+}
+
 static inline unsigned int queue_max_segment_size(struct request_queue *q)
 {
 	return q->limits.max_segment_size;
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index b38b4e651ea6..8265b6330cc2 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -16,6 +16,7 @@ enum elv_merge {
 	ELEVATOR_NO_MERGE	= 0,
 	ELEVATOR_FRONT_MERGE	= 1,
 	ELEVATOR_BACK_MERGE	= 2,
+	ELEVATOR_DISCARD_MERGE	= 3,
 };
 
 typedef enum elv_merge (elevator_merge_fn) (struct request_queue *, struct request **,
-- 
2.11.0
