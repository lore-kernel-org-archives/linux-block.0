Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [WIP PATCHSET 2/4] Move thinktime from bic to bfqq
Date: Tue,  7 Feb 2017 18:24:44 +0100
Message-Id: <20170207172446.4528-3-paolo.valente@linaro.org>
In-Reply-To: <20170207172446.4528-1-paolo.valente@linaro.org>
References: <20170207172446.4528-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Prep change to make it possible to protect this field with a
scheduler lock.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-mq-iosched.c | 28 ++++++++++++++--------------
 block/bfq-mq.h         | 30 ++++++++++++++++--------------
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/block/bfq-mq-iosched.c b/block/bfq-mq-iosched.c
index 0a7da4e..7e3f429 100644
--- a/block/bfq-mq-iosched.c
+++ b/block/bfq-mq-iosched.c
@@ -670,6 +670,7 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 	else
 		bfq_clear_bfqq_IO_bound(bfqq);
 
+	bfqq->ttime = bic->saved_ttime;
 	bfqq->wr_coeff = bic->saved_wr_coeff;
 	bfqq->wr_start_at_switch_to_srt = bic->saved_wr_start_at_switch_to_srt;
 	BUG_ON(time_is_after_jiffies(bfqq->wr_start_at_switch_to_srt));
@@ -1247,7 +1248,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 		 * details on the usage of the next variable.
 		 */
 		arrived_in_time =  ktime_get_ns() <=
-			RQ_BIC(rq)->ttime.last_end_request +
+			bfqq->ttime.last_end_request +
 			bfqd->bfq_slice_idle * 3;
 
 	bfq_log_bfqq(bfqd, bfqq,
@@ -2003,6 +2004,7 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 	if (!bic)
 		return;
 
+	bic->saved_ttime = bfqq->ttime;
 	bic->saved_idle_window = bfq_bfqq_idle_window(bfqq);
 	bic->saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
 	bic->saved_in_large_burst = bfq_bfqq_in_large_burst(bfqq);
@@ -3870,11 +3872,6 @@ static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	bfq_put_queue(bfqq);
 }
 
-static void bfq_init_icq(struct io_cq *icq)
-{
-	icq_to_bic(icq)->ttime.last_end_request = ktime_get_ns() - (1ULL<<32);
-}
-
 static void bfq_exit_icq(struct io_cq *icq)
 {
 	struct bfq_io_cq *bic = icq_to_bic(icq);
@@ -4000,6 +3997,9 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_mark_bfqq_just_created(bfqq);
 	} else
 		bfq_clear_bfqq_sync(bfqq);
+
+	bfqq->ttime.last_end_request = ktime_get_ns() - (1ULL<<32);
+
 	bfq_mark_bfqq_IO_bound(bfqq);
 
 	/* Tentative initial value to trade off between thr and lat */
@@ -4107,14 +4107,14 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 }
 
 static void bfq_update_io_thinktime(struct bfq_data *bfqd,
-				    struct bfq_io_cq *bic)
+				    struct bfq_queue *bfqq)
 {
-	struct bfq_ttime *ttime = &bic->ttime;
-	u64 elapsed = ktime_get_ns() - bic->ttime.last_end_request;
+	struct bfq_ttime *ttime = &bfqq->ttime;
+	u64 elapsed = ktime_get_ns() - bfqq->ttime.last_end_request;
 
 	elapsed = min_t(u64, elapsed, 2 * bfqd->bfq_slice_idle);
 
-	ttime->ttime_samples = (7*bic->ttime.ttime_samples + 256) / 8;
+	ttime->ttime_samples = (7*bfqq->ttime.ttime_samples + 256) / 8;
 	ttime->ttime_total = div_u64(7*ttime->ttime_total + 256*elapsed,  8);
 	ttime->ttime_mean = div64_ul(ttime->ttime_total + 128,
 				     ttime->ttime_samples);
@@ -4157,8 +4157,8 @@ static void bfq_update_idle_window(struct bfq_data *bfqd,
 		(bfqd->hw_tag && BFQQ_SEEKY(bfqq) &&
 			bfqq->wr_coeff == 1))
 		enable_idle = 0;
-	else if (bfq_sample_valid(bic->ttime.ttime_samples)) {
-		if (bic->ttime.ttime_mean > bfqd->bfq_slice_idle &&
+	else if (bfq_sample_valid(bfqq->ttime.ttime_samples)) {
+		if (bfqq->ttime.ttime_mean > bfqd->bfq_slice_idle &&
 			bfqq->wr_coeff == 1)
 			enable_idle = 0;
 		else
@@ -4185,7 +4185,7 @@ static void bfq_rq_enqueued(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	if (rq->cmd_flags & REQ_META)
 		bfqq->meta_pending++;
 
-	bfq_update_io_thinktime(bfqd, bic);
+	bfq_update_io_thinktime(bfqd, bfqq);
 	bfq_update_io_seektime(bfqd, bfqq, rq);
 	if (bfqq->entity.service > bfq_max_budget(bfqd) / 8 ||
 	    !BFQQ_SEEKY(bfqq))
@@ -4354,7 +4354,7 @@ static void bfq_completed_request(struct request_queue *q, struct request *rq)
 
 	now_ns = ktime_get_ns();
 
-	RQ_BIC(rq)->ttime.last_end_request = now_ns;
+	bfqq->ttime.last_end_request = now_ns;
 
 	/*
 	 * Using us instead of ns, to get a reasonable precision in
diff --git a/block/bfq-mq.h b/block/bfq-mq.h
index f28feb6..c6acee2 100644
--- a/block/bfq-mq.h
+++ b/block/bfq-mq.h
@@ -199,6 +199,18 @@ struct bfq_entity {
 struct bfq_group;
 
 /**
+ * struct bfq_ttime - per process thinktime stats.
+ */
+struct bfq_ttime {
+	u64 last_end_request; /* completion time of last request */
+
+	u64 ttime_total; /* total process thinktime */
+	unsigned long ttime_samples; /* number of thinktime samples */
+	u64 ttime_mean; /* average process thinktime */
+
+};
+
+/**
  * struct bfq_queue - leaf schedulable entity.
  *
  * A bfq_queue is a leaf request queue; it can be associated with an
@@ -259,6 +271,9 @@ struct bfq_queue {
 	/* node for active/idle bfqq list inside parent bfqd */
 	struct list_head bfqq_list;
 
+	/* associated @bfq_ttime struct */
+	struct bfq_ttime ttime;
+
 	/* bit vector: a 1 for each seeky requests in history */
 	u32 seek_history;
 
@@ -322,18 +337,6 @@ struct bfq_queue {
 };
 
 /**
- * struct bfq_ttime - per process thinktime stats.
- */
-struct bfq_ttime {
-	u64 last_end_request; /* completion time of last request */
-
-	u64 ttime_total; /* total process thinktime */
-	unsigned long ttime_samples; /* number of thinktime samples */
-	u64 ttime_mean; /* average process thinktime */
-
-};
-
-/**
  * struct bfq_io_cq - per (request_queue, io_context) structure.
  */
 struct bfq_io_cq {
@@ -341,8 +344,6 @@ struct bfq_io_cq {
 	struct io_cq icq; /* must be the first member */
 	/* array of two process queues, the sync and the async */
 	struct bfq_queue *bfqq[2];
-	/* associated @bfq_ttime struct */
-	struct bfq_ttime ttime;
 	/* per (request_queue, blkcg) ioprio */
 	int ioprio;
 #ifdef BFQ_GROUP_IOSCHED_ENABLED
@@ -379,6 +380,7 @@ struct bfq_io_cq {
 	unsigned long saved_last_wr_start_finish;
 	unsigned long saved_wr_start_at_switch_to_srt;
 	unsigned int saved_wr_cur_max_time;
+	struct bfq_ttime saved_ttime;
 };
 
 enum bfq_device_speed {
-- 
2.10.0
