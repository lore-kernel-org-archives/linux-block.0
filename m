Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: osandov@fb.com,
	efault@gmx.de,
	paolo.valente@linaro.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/7] bfq-iosched: update shallow depth to smallest one used
Date: Wed,  9 May 2018 14:49:25 -0600
Message-Id: <1525898967-13425-6-git-send-email-axboe@kernel.dk>
In-Reply-To: <1525898967-13425-1-git-send-email-axboe@kernel.dk>
References: <1525898967-13425-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

If our shallow depth is smaller than the wake batching of sbitmap,
we can introduce hangs. Ensure that sbitmap knows how low we'll go.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bfq-iosched.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b7722668e295..cba6e82153a2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5053,10 +5053,13 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
 
 /*
  * See the comments on bfq_limit_depth for the purpose of
- * the depths set in the function.
+ * the depths set in the function. Return minimum shallow depth we'll use.
  */
-static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
+static unsigned int bfq_update_depths(struct bfq_data *bfqd,
+				      struct sbitmap_queue *bt)
 {
+	unsigned int i, j, min_shallow = UINT_MAX;
+
 	bfqd->sb_shift = bt->sb.shift;
 
 	/*
@@ -5089,14 +5092,22 @@ static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
 	bfqd->word_depths[1][0] = max(((1U<<bfqd->sb_shift) * 3)>>4, 1U);
 	/* no more than ~37% of tags for sync writes (~20% extra tags) */
 	bfqd->word_depths[1][1] = max(((1U<<bfqd->sb_shift) * 6)>>4, 1U);
+
+	for (i = 0; i < 2; i++)
+		for (j = 0; j < 2; j++)
+			min_shallow = min(min_shallow, bfqd->word_depths[i][j]);
+
+	return min_shallow;
 }
 
 static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
 {
 	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
 	struct blk_mq_tags *tags = hctx->sched_tags;
+	unsigned int min_shallow;
 
-	bfq_update_depths(bfqd, &tags->bitmap_tags);
+	min_shallow = bfq_update_depths(bfqd, &tags->bitmap_tags);
+	sbitmap_queue_shallow_depth(&tags->bitmap_tags, min_shallow);
 	return 0;
 }
 
-- 
2.7.4
