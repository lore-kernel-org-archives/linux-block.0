Return-Path: <BATV+add76be85c7e68b62602+4917+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] block: enumify ELEVATOR_*_MERGE
Date: Wed,  8 Feb 2017 14:13:41 +0100
Message-Id: <20170208131343.4003-3-hch@lst.de>
In-Reply-To: <20170208131343.4003-1-hch@lst.de>
References: <20170208131343.4003-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Switch these constants to an enum, and make let the compiler ensure that
all callers of blk_try_merge and elv_merge handle all potential values.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c         | 76 +++++++++++++++++++++++++-----------------------
 block/blk-merge.c        |  2 +-
 block/blk-mq-sched.c     | 35 +++++++++++-----------
 block/blk-mq.c           | 32 +++++++++-----------
 block/blk.h              |  2 +-
 block/cfq-iosched.c      |  4 +--
 block/deadline-iosched.c | 12 +++-----
 block/elevator.c         | 10 ++++---
 block/mq-deadline.c      |  2 +-
 include/linux/elevator.h | 28 ++++++++++--------
 10 files changed, 102 insertions(+), 101 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d161d4ab7052..75fe534861df 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1513,12 +1513,11 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 {
 	struct blk_plug *plug;
 	struct request *rq;
-	bool ret = false;
 	struct list_head *plug_list;
 
 	plug = current->plug;
 	if (!plug)
-		goto out;
+		return false;
 	*request_count = 0;
 
 	if (q->mq_ops)
@@ -1527,7 +1526,7 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		plug_list = &plug->list;
 
 	list_for_each_entry_reverse(rq, plug_list, queuelist) {
-		int el_ret;
+		bool merged = false;
 
 		if (rq->q == q) {
 			(*request_count)++;
@@ -1543,19 +1542,22 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		if (rq->q != q || !blk_rq_merge_ok(rq, bio))
 			continue;
 
-		el_ret = blk_try_merge(rq, bio);
-		if (el_ret == ELEVATOR_BACK_MERGE) {
-			ret = bio_attempt_back_merge(q, rq, bio);
-			if (ret)
-				break;
-		} else if (el_ret == ELEVATOR_FRONT_MERGE) {
-			ret = bio_attempt_front_merge(q, rq, bio);
-			if (ret)
-				break;
+		switch (blk_try_merge(rq, bio)) {
+		case ELEVATOR_BACK_MERGE:
+			merged = bio_attempt_back_merge(q, rq, bio);
+			break;
+		case ELEVATOR_FRONT_MERGE:
+			merged = bio_attempt_front_merge(q, rq, bio);
+			break;
+		default:
+			break;
 		}
+
+		if (merged)
+			return true;
 	}
-out:
-	return ret;
+
+	return false;
 }
 
 unsigned int blk_plug_queued_count(struct request_queue *q)
@@ -1597,7 +1599,7 @@ void init_request_from_bio(struct request *req, struct bio *bio)
 static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 {
 	struct blk_plug *plug;
-	int el_ret, where = ELEVATOR_INSERT_SORT;
+	int where = ELEVATOR_INSERT_SORT;
 	struct request *req, *free;
 	unsigned int request_count = 0;
 	unsigned int wb_acct;
@@ -1635,27 +1637,29 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 
 	spin_lock_irq(q->queue_lock);
 
-	el_ret = elv_merge(q, &req, bio);
-	if (el_ret == ELEVATOR_BACK_MERGE) {
-		if (bio_attempt_back_merge(q, req, bio)) {
-			elv_bio_merged(q, req, bio);
-			free = attempt_back_merge(q, req);
-			if (!free)
-				elv_merged_request(q, req, el_ret);
-			else
-				__blk_put_request(q, free);
-			goto out_unlock;
-		}
-	} else if (el_ret == ELEVATOR_FRONT_MERGE) {
-		if (bio_attempt_front_merge(q, req, bio)) {
-			elv_bio_merged(q, req, bio);
-			free = attempt_front_merge(q, req);
-			if (!free)
-				elv_merged_request(q, req, el_ret);
-			else
-				__blk_put_request(q, free);
-			goto out_unlock;
-		}
+	switch (elv_merge(q, &req, bio)) {
+	case ELEVATOR_BACK_MERGE:
+		if (!bio_attempt_back_merge(q, req, bio))
+			break;
+		elv_bio_merged(q, req, bio);
+		free = attempt_back_merge(q, req);
+		if (free)
+			__blk_put_request(q, free);
+		else
+			elv_merged_request(q, req, ELEVATOR_BACK_MERGE);
+		goto out_unlock;
+	case ELEVATOR_FRONT_MERGE:
+		if (!bio_attempt_front_merge(q, req, bio))
+			break;
+		elv_bio_merged(q, req, bio);
+		free = attempt_front_merge(q, req);
+		if (free)
+			__blk_put_request(q, free);
+		else
+			elv_merged_request(q, req, ELEVATOR_FRONT_MERGE);
+		goto out_unlock;
+	default:
+		break;
 	}
 
 get_rq:
diff --git a/block/blk-merge.c b/block/blk-merge.c
index c956d9e7aafd..6cbd90ad5f90 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -801,7 +801,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	return true;
 }
 
-int blk_try_merge(struct request *rq, struct bio *bio)
+enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
 {
 	if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
 		return ELEVATOR_BACK_MERGE;
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ee455e7cf9d8..72d0d8361175 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -238,30 +238,29 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 			    struct request **merged_request)
 {
 	struct request *rq;
-	int ret;
 
-	ret = elv_merge(q, &rq, bio);
-	if (ret == ELEVATOR_BACK_MERGE) {
+	switch (elv_merge(q, &rq, bio)) {
+	case ELEVATOR_BACK_MERGE:
 		if (!blk_mq_sched_allow_merge(q, rq, bio))
 			return false;
-		if (bio_attempt_back_merge(q, rq, bio)) {
-			*merged_request = attempt_back_merge(q, rq);
-			if (!*merged_request)
-				elv_merged_request(q, rq, ret);
-			return true;
-		}
-	} else if (ret == ELEVATOR_FRONT_MERGE) {
+		if (!bio_attempt_back_merge(q, rq, bio))
+			return false;
+		*merged_request = attempt_back_merge(q, rq);
+		if (!*merged_request)
+			elv_merged_request(q, rq, ELEVATOR_BACK_MERGE);
+		return true;
+	case ELEVATOR_FRONT_MERGE:
 		if (!blk_mq_sched_allow_merge(q, rq, bio))
 			return false;
-		if (bio_attempt_front_merge(q, rq, bio)) {
-			*merged_request = attempt_front_merge(q, rq);
-			if (!*merged_request)
-				elv_merged_request(q, rq, ret);
-			return true;
-		}
+		if (!bio_attempt_front_merge(q, rq, bio))
+			return false;
+		*merged_request = attempt_front_merge(q, rq);
+		if (!*merged_request)
+			elv_merged_request(q, rq, ELEVATOR_FRONT_MERGE);
+		return true;
+	default:
+		return false;
 	}
-
-	return false;
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_merge);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index be183e6115a1..9294633759d9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -763,7 +763,7 @@ static bool blk_mq_attempt_merge(struct request_queue *q,
 	int checked = 8;
 
 	list_for_each_entry_reverse(rq, &ctx->rq_list, queuelist) {
-		int el_ret;
+		bool merged = false;
 
 		if (!checked--)
 			break;
@@ -771,26 +771,22 @@ static bool blk_mq_attempt_merge(struct request_queue *q,
 		if (!blk_rq_merge_ok(rq, bio))
 			continue;
 
-		el_ret = blk_try_merge(rq, bio);
-		if (el_ret == ELEVATOR_NO_MERGE)
-			continue;
-
-		if (!blk_mq_sched_allow_merge(q, rq, bio))
+		switch (blk_try_merge(rq, bio)) {
+		case ELEVATOR_BACK_MERGE:
+			if (blk_mq_sched_allow_merge(q, rq, bio))
+				merged = bio_attempt_back_merge(q, rq, bio);
 			break;
-
-		if (el_ret == ELEVATOR_BACK_MERGE) {
-			if (bio_attempt_back_merge(q, rq, bio)) {
-				ctx->rq_merged++;
-				return true;
-			}
-			break;
-		} else if (el_ret == ELEVATOR_FRONT_MERGE) {
-			if (bio_attempt_front_merge(q, rq, bio)) {
-				ctx->rq_merged++;
-				return true;
-			}
+		case ELEVATOR_FRONT_MERGE:
+			if (blk_mq_sched_allow_merge(q, rq, bio))
+				merged = bio_attempt_front_merge(q, rq, bio);
 			break;
+		default:
+			continue;
 		}
+
+		if (merged)
+			ctx->rq_merged++;
+		return merged;
 	}
 
 	return false;
diff --git a/block/blk.h b/block/blk.h
index 3e08703902a9..ae82f2ac4019 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -215,7 +215,7 @@ int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 void blk_recalc_rq_segments(struct request *rq);
 void blk_rq_set_mixed_merge(struct request *rq);
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio);
-int blk_try_merge(struct request *rq, struct bio *bio);
+enum elv_merge blk_try_merge(struct request *rq, struct bio *bio);
 
 void blk_queue_congestion_threshold(struct request_queue *q);
 
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index f0f29ee731e1..921262770636 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -2528,7 +2528,7 @@ static void cfq_remove_request(struct request *rq)
 	}
 }
 
-static int cfq_merge(struct request_queue *q, struct request **req,
+static enum elv_merge cfq_merge(struct request_queue *q, struct request **req,
 		     struct bio *bio)
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
@@ -2544,7 +2544,7 @@ static int cfq_merge(struct request_queue *q, struct request **req,
 }
 
 static void cfq_merged_request(struct request_queue *q, struct request *req,
-			       int type)
+			       enum elv_merge type)
 {
 	if (type == ELEVATOR_FRONT_MERGE) {
 		struct cfq_queue *cfqq = RQ_CFQQ(req);
diff --git a/block/deadline-iosched.c b/block/deadline-iosched.c
index 05fc0ea25a98..c68f6bbc0dcd 100644
--- a/block/deadline-iosched.c
+++ b/block/deadline-iosched.c
@@ -120,12 +120,11 @@ static void deadline_remove_request(struct request_queue *q, struct request *rq)
 	deadline_del_rq_rb(dd, rq);
 }
 
-static int
+static enum elv_merge
 deadline_merge(struct request_queue *q, struct request **req, struct bio *bio)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
 	struct request *__rq;
-	int ret;
 
 	/*
 	 * check for front merge
@@ -138,20 +137,17 @@ deadline_merge(struct request_queue *q, struct request **req, struct bio *bio)
 			BUG_ON(sector != blk_rq_pos(__rq));
 
 			if (elv_bio_merge_ok(__rq, bio)) {
-				ret = ELEVATOR_FRONT_MERGE;
-				goto out;
+				*req = __rq;
+				return ELEVATOR_FRONT_MERGE;
 			}
 		}
 	}
 
 	return ELEVATOR_NO_MERGE;
-out:
-	*req = __rq;
-	return ret;
 }
 
 static void deadline_merged_request(struct request_queue *q,
-				    struct request *req, int type)
+				    struct request *req, enum elv_merge type)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
 
diff --git a/block/elevator.c b/block/elevator.c
index 7e4f5880dd64..27ff1ed5a6fa 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -427,11 +427,11 @@ void elv_dispatch_add_tail(struct request_queue *q, struct request *rq)
 }
 EXPORT_SYMBOL(elv_dispatch_add_tail);
 
-int elv_merge(struct request_queue *q, struct request **req, struct bio *bio)
+enum elv_merge elv_merge(struct request_queue *q, struct request **req,
+		struct bio *bio)
 {
 	struct elevator_queue *e = q->elevator;
 	struct request *__rq;
-	int ret;
 
 	/*
 	 * Levels of merges:
@@ -446,7 +446,8 @@ int elv_merge(struct request_queue *q, struct request **req, struct bio *bio)
 	 * First try one-hit cache.
 	 */
 	if (q->last_merge && elv_bio_merge_ok(q->last_merge, bio)) {
-		ret = blk_try_merge(q->last_merge, bio);
+		enum elv_merge ret = blk_try_merge(q->last_merge, bio);
+
 		if (ret != ELEVATOR_NO_MERGE) {
 			*req = q->last_merge;
 			return ret;
@@ -514,7 +515,8 @@ bool elv_attempt_insert_merge(struct request_queue *q, struct request *rq)
 	return ret;
 }
 
-void elv_merged_request(struct request_queue *q, struct request *rq, int type)
+void elv_merged_request(struct request_queue *q, struct request *rq,
+		enum elv_merge type)
 {
 	struct elevator_queue *e = q->elevator;
 
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index d68d9c273a66..236121633ca0 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -121,7 +121,7 @@ static void deadline_remove_request(struct request_queue *q, struct request *rq)
 }
 
 static void dd_request_merged(struct request_queue *q, struct request *req,
-			      int type)
+			      enum elv_merge type)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
 
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index b5825c4f06f7..b38b4e651ea6 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -9,12 +9,21 @@
 struct io_cq;
 struct elevator_type;
 
-typedef int (elevator_merge_fn) (struct request_queue *, struct request **,
+/*
+ * Return values from elevator merger
+ */
+enum elv_merge {
+	ELEVATOR_NO_MERGE	= 0,
+	ELEVATOR_FRONT_MERGE	= 1,
+	ELEVATOR_BACK_MERGE	= 2,
+};
+
+typedef enum elv_merge (elevator_merge_fn) (struct request_queue *, struct request **,
 				 struct bio *);
 
 typedef void (elevator_merge_req_fn) (struct request_queue *, struct request *, struct request *);
 
-typedef void (elevator_merged_fn) (struct request_queue *, struct request *, int);
+typedef void (elevator_merged_fn) (struct request_queue *, struct request *, enum elv_merge);
 
 typedef int (elevator_allow_bio_merge_fn) (struct request_queue *,
 					   struct request *, struct bio *);
@@ -87,7 +96,7 @@ struct elevator_mq_ops {
 	bool (*allow_merge)(struct request_queue *, struct request *, struct bio *);
 	bool (*bio_merge)(struct blk_mq_hw_ctx *, struct bio *);
 	int (*request_merge)(struct request_queue *q, struct request **, struct bio *);
-	void (*request_merged)(struct request_queue *, struct request *, int);
+	void (*request_merged)(struct request_queue *, struct request *, enum elv_merge);
 	void (*requests_merged)(struct request_queue *, struct request *, struct request *);
 	struct request *(*get_request)(struct request_queue *, unsigned int, struct blk_mq_alloc_data *);
 	void (*put_request)(struct request *);
@@ -166,10 +175,12 @@ extern void elv_dispatch_sort(struct request_queue *, struct request *);
 extern void elv_dispatch_add_tail(struct request_queue *, struct request *);
 extern void elv_add_request(struct request_queue *, struct request *, int);
 extern void __elv_add_request(struct request_queue *, struct request *, int);
-extern int elv_merge(struct request_queue *, struct request **, struct bio *);
+extern enum elv_merge elv_merge(struct request_queue *, struct request **,
+		struct bio *);
 extern void elv_merge_requests(struct request_queue *, struct request *,
 			       struct request *);
-extern void elv_merged_request(struct request_queue *, struct request *, int);
+extern void elv_merged_request(struct request_queue *, struct request *,
+		enum elv_merge);
 extern void elv_bio_merged(struct request_queue *q, struct request *,
 				struct bio *);
 extern bool elv_attempt_insert_merge(struct request_queue *, struct request *);
@@ -219,13 +230,6 @@ extern void elv_rb_del(struct rb_root *, struct request *);
 extern struct request *elv_rb_find(struct rb_root *, sector_t);
 
 /*
- * Return values from elevator merger
- */
-#define ELEVATOR_NO_MERGE	0
-#define ELEVATOR_FRONT_MERGE	1
-#define ELEVATOR_BACK_MERGE	2
-
-/*
  * Insertion selection
  */
 #define ELEVATOR_INSERT_FRONT	1
-- 
2.11.0
