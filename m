Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: osandov@fb.com,
	efault@gmx.de,
	paolo.valente@linaro.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] blk-mq-sched: return shallow depth limit from ->limit_depth
Date: Wed,  9 May 2018 09:36:03 -0600
Message-Id: <1525880164-11943-3-git-send-email-axboe@kernel.dk>
In-Reply-To: <1525880164-11943-1-git-send-email-axboe@kernel.dk>
References: <1525880164-11943-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

If the scheduler changes the shallow depth, then return the new
depth. No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bfq-iosched.c      | 13 ++++++++++---
 block/kyber-iosched.c    | 14 ++++++++++----
 include/linux/elevator.h |  2 +-
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ebc264c87a09..b0dbfd297d20 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -533,19 +533,20 @@ static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
  * Limit depths of async I/O and sync writes so as to counter both
  * problems.
  */
-static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
+static int bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
 {
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct bfq_data *bfqd = data->q->elevator->elevator_data;
 	struct sbitmap_queue *bt;
+	int old_depth;
 
 	if (op_is_sync(op) && !op_is_write(op))
-		return;
+		return 0;
 
 	if (data->flags & BLK_MQ_REQ_RESERVED) {
 		if (unlikely(!tags->nr_reserved_tags)) {
 			WARN_ON_ONCE(1);
-			return;
+			return 0;
 		}
 		bt = &tags->breserved_tags;
 	} else
@@ -554,12 +555,18 @@ static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
 	if (unlikely(bfqd->sb_shift != bt->sb.shift))
 		bfq_update_depths(bfqd, bt);
 
+	old_depth = data->shallow_depth;
 	data->shallow_depth =
 		bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
 
 	bfq_log(bfqd, "[%s] wr_busy %d sync %d depth %u",
 			__func__, bfqd->wr_busy_queues, op_is_sync(op),
 			data->shallow_depth);
+
+	if (old_depth != data->shallow_depth)
+		return data->shallow_depth;
+
+	return 0;
 }
 
 static struct bfq_queue *
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 564967fafe5f..d2622386c115 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -433,17 +433,23 @@ static void rq_clear_domain_token(struct kyber_queue_data *kqd,
 	}
 }
 
-static void kyber_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
+static int kyber_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
 {
+	struct kyber_queue_data *kqd = data->q->elevator->elevator_data;
+
+	if (op_is_sync(op))
+		return 0;
+
 	/*
 	 * We use the scheduler tags as per-hardware queue queueing tokens.
 	 * Async requests can be limited at this stage.
 	 */
-	if (!op_is_sync(op)) {
-		struct kyber_queue_data *kqd = data->q->elevator->elevator_data;
-
+	if (data->shallow_depth != kqd->async_depth) {
 		data->shallow_depth = kqd->async_depth;
+		return data->shallow_depth;
 	}
+
+	return 0;
 }
 
 static void kyber_prepare_request(struct request *rq, struct bio *bio)
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 6d9e230dffd2..b2712f4ca9f1 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -105,7 +105,7 @@ struct elevator_mq_ops {
 	int (*request_merge)(struct request_queue *q, struct request **, struct bio *);
 	void (*request_merged)(struct request_queue *, struct request *, enum elv_merge);
 	void (*requests_merged)(struct request_queue *, struct request *, struct request *);
-	void (*limit_depth)(unsigned int, struct blk_mq_alloc_data *);
+	int (*limit_depth)(unsigned int, struct blk_mq_alloc_data *);
 	void (*prepare_request)(struct request *, struct bio *bio);
 	void (*finish_request)(struct request *);
 	void (*insert_requests)(struct blk_mq_hw_ctx *, struct list_head *, bool);
-- 
2.7.4
