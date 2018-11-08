Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 1/2] blk-mq-tag: change busy_iter_fn to return whether to continue or not
Date: Thu,  8 Nov 2018 08:42:15 -0700
Message-Id: <20181108154216.23853-2-axboe@kernel.dk>
In-Reply-To: <20181108154216.23853-1-axboe@kernel.dk>
References: <20181108154216.23853-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

We have this functionality in sbitmap, but we don't export it in
blk-mq for users of the tags busy iteration. This can be useful
for stopping the iteration, if the caller doesn't need to find
more requests.

Cc: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-debugfs.c |  4 +++-
 block/blk-mq-tag.c     |  4 ++--
 block/blk-mq.c         | 16 +++++++++++-----
 include/linux/blk-mq.h |  4 ++--
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index cde19be36135..4f61632af6f4 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -424,13 +424,15 @@ struct show_busy_params {
  * Note: the state of a request may change while this function is in progress,
  * e.g. due to a concurrent blk_mq_finish_request() call.
  */
-static void hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
+static bool hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
 {
 	const struct show_busy_params *params = data;
 
 	if (rq->mq_hctx == params->hctx)
 		__blk_mq_debugfs_rq_show(params->m,
 					 list_entry_rq(&rq->queuelist));
+
+	return true;
 }
 
 static int hctx_busy_show(void *data, struct seq_file *m)
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index fb836d818b80..097e9a67d5f5 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -236,7 +236,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	 * test and set the bit before assigning ->rqs[].
 	 */
 	if (rq && rq->q == hctx->queue)
-		iter_data->fn(hctx, rq, iter_data->data, reserved);
+		return iter_data->fn(hctx, rq, iter_data->data, reserved);
 	return true;
 }
 
@@ -289,7 +289,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	 */
 	rq = tags->rqs[bitnr];
 	if (rq && blk_mq_request_started(rq))
-		iter_data->fn(rq, iter_data->data, reserved);
+		return iter_data->fn(rq, iter_data->data, reserved);
 
 	return true;
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 45c92b8d4795..4a622c832b31 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -94,7 +94,7 @@ struct mq_inflight {
 	unsigned int *inflight;
 };
 
-static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
+static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 				  struct request *rq, void *priv,
 				  bool reserved)
 {
@@ -109,6 +109,8 @@ static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 		mi->inflight[0]++;
 	if (mi->part->partno)
 		mi->inflight[1]++;
+
+	return true;
 }
 
 void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
@@ -120,7 +122,7 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
 }
 
-static void blk_mq_check_inflight_rw(struct blk_mq_hw_ctx *hctx,
+static bool blk_mq_check_inflight_rw(struct blk_mq_hw_ctx *hctx,
 				     struct request *rq, void *priv,
 				     bool reserved)
 {
@@ -128,6 +130,8 @@ static void blk_mq_check_inflight_rw(struct blk_mq_hw_ctx *hctx,
 
 	if (rq->part == mi->part)
 		mi->inflight[rq_data_dir(rq)]++;
+
+	return true;
 }
 
 void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
@@ -821,7 +825,7 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
 	return false;
 }
 
-static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
+static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
 {
 	unsigned long *next = priv;
@@ -831,7 +835,7 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	 * so we're not unnecessarilly synchronizing across CPUs.
 	 */
 	if (!blk_mq_req_expired(rq, next))
-		return;
+		return true;
 
 	/*
 	 * We have reason to believe the request may be expired. Take a
@@ -843,7 +847,7 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	 * timeout handler to posting a natural completion.
 	 */
 	if (!refcount_inc_not_zero(&rq->ref))
-		return;
+		return true;
 
 	/*
 	 * The request is now locked and cannot be reallocated underneath the
@@ -855,6 +859,8 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 		blk_mq_rq_timed_out(rq, reserved);
 	if (refcount_dec_and_test(&rq->ref))
 		__blk_mq_free_request(rq);
+
+	return true;
 }
 
 static void blk_mq_timeout_work(struct work_struct *work)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 9f5e93f40857..ff497dfcbbf9 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -129,9 +129,9 @@ typedef int (init_request_fn)(struct blk_mq_tag_set *set, struct request *,
 typedef void (exit_request_fn)(struct blk_mq_tag_set *set, struct request *,
 		unsigned int);
 
-typedef void (busy_iter_fn)(struct blk_mq_hw_ctx *, struct request *, void *,
+typedef bool (busy_iter_fn)(struct blk_mq_hw_ctx *, struct request *, void *,
 		bool);
-typedef void (busy_tag_iter_fn)(struct request *, void *, bool);
+typedef bool (busy_tag_iter_fn)(struct request *, void *, bool);
 typedef int (poll_fn)(struct blk_mq_hw_ctx *, unsigned int);
 typedef int (map_queues_fn)(struct blk_mq_tag_set *set);
 typedef bool (busy_fn)(struct request_queue *);
-- 
2.17.1
