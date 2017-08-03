Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: brking@linux.vnet.ibm.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] blk-mq: provide internal in-flight variant
Date: Thu,  3 Aug 2017 14:01:55 -0600
Message-Id: <1501790516-6924-4-git-send-email-axboe@kernel.dk>
In-Reply-To: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
References: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

We don't have to inc/dec some counter, since we can just
iterate the tags. That makes inc/dec a noop, but means we
have to iterate busy tags to get an in-flight count.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c        | 24 ++++++++++++++++++++++++
 block/blk-mq.h        |  2 ++
 block/genhd.c         | 29 +++++++++++++++++++++++++++++
 include/linux/genhd.h | 25 +++----------------------
 4 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 05dfa3f270ae..37035891e120 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -86,6 +86,30 @@ static void blk_mq_hctx_clear_pending(struct blk_mq_hw_ctx *hctx,
 	sbitmap_clear_bit(&hctx->ctx_map, ctx->index_hw);
 }
 
+struct mq_inflight {
+	struct hd_struct *part;
+	unsigned int inflight;
+};
+
+static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
+				  struct request *rq, void *priv,
+				  bool reserved)
+{
+	struct mq_inflight *mi = priv;
+
+	if (rq->part == mi->part)
+		mi->inflight++;
+}
+
+unsigned int blk_mq_in_flight(struct request_queue *q,
+			       struct hd_struct *part)
+{
+	struct mq_inflight mi = { .part = part, .inflight = 0 };
+
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
+	return mi.inflight;
+}
+
 void blk_freeze_queue_start(struct request_queue *q)
 {
 	int freeze_depth;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 1a06fdf9fd4d..cade1a512a01 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -138,4 +138,6 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 	return hctx->nr_ctx && hctx->tags;
 }
 
+unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part);
+
 #endif
diff --git a/block/genhd.c b/block/genhd.c
index f735af67a0c9..ad5dc567d57f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -45,6 +45,35 @@ static void disk_add_events(struct gendisk *disk);
 static void disk_del_events(struct gendisk *disk);
 static void disk_release_events(struct gendisk *disk);
 
+void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
+{
+	if (q->mq_ops)
+		return;
+
+	atomic_inc(&part->in_flight[rw]);
+	if (part->partno)
+		atomic_inc(&part_to_disk(part)->part0.in_flight[rw]);
+}
+
+void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
+{
+	if (q->mq_ops)
+		return;
+
+	atomic_dec(&part->in_flight[rw]);
+	if (part->partno)
+		atomic_dec(&part_to_disk(part)->part0.in_flight[rw]);
+}
+
+int part_in_flight(struct request_queue *q, struct hd_struct *part)
+{
+	if (q->mq_ops)
+		return blk_mq_in_flight(q, part);
+
+	return atomic_read(&part->in_flight[0]) +
+			atomic_read(&part->in_flight[1]);
+}
+
 /**
  * disk_get_part - get partition
  * @disk: disk to look partition from
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 7f7427e00f9c..f2c5096b3a7e 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -362,28 +362,9 @@ static inline void free_part_stats(struct hd_struct *part)
 #define part_stat_sub(cpu, gendiskp, field, subnd)			\
 	part_stat_add(cpu, gendiskp, field, -subnd)
 
-static inline void part_inc_in_flight(struct request_queue *q,
-				      struct hd_struct *part, int rw)
-{
-	atomic_inc(&part->in_flight[rw]);
-	if (part->partno)
-		atomic_inc(&part_to_disk(part)->part0.in_flight[rw]);
-}
-
-static inline void part_dec_in_flight(struct request_queue *q,
-				      struct hd_struct *part, int rw)
-{
-	atomic_dec(&part->in_flight[rw]);
-	if (part->partno)
-		atomic_dec(&part_to_disk(part)->part0.in_flight[rw]);
-}
-
-static inline int part_in_flight(struct request_queue *q,
-				 struct hd_struct *part)
-{
-	return atomic_read(&part->in_flight[0]) +
-			atomic_read(&part->in_flight[1]);
-}
+int part_in_flight(struct request_queue *q, struct hd_struct *part);
+void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw);
+void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw);
 
 static inline struct partition_meta_info *alloc_part_info(struct gendisk *disk)
 {
-- 
2.7.4
