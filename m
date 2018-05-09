Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: osandov@fb.com,
	efault@gmx.de,
	paolo.valente@linaro.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/7] bfq-iosched: remove unused variable
Date: Wed,  9 May 2018 14:49:26 -0600
Message-Id: <1525898967-13425-7-git-send-email-axboe@kernel.dk>
In-Reply-To: <1525898967-13425-1-git-send-email-axboe@kernel.dk>
References: <1525898967-13425-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

bfqd->sb_shift was attempted used as a cache for the sbitmap queue
shift, but we don't need it, as it never changes. Kill it with fire.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bfq-iosched.c | 16 +++++++---------
 block/bfq-iosched.h |  6 ------
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index cba6e82153a2..07b43ea124b0 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5060,26 +5060,24 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
 {
 	unsigned int i, j, min_shallow = UINT_MAX;
 
-	bfqd->sb_shift = bt->sb.shift;
-
 	/*
 	 * In-word depths if no bfq_queue is being weight-raised:
 	 * leaving 25% of tags only for sync reads.
 	 *
 	 * In next formulas, right-shift the value
-	 * (1U<<bfqd->sb_shift), instead of computing directly
-	 * (1U<<(bfqd->sb_shift - something)), to be robust against
-	 * any possible value of bfqd->sb_shift, without having to
+	 * (1U<<bt->sb.shift), instead of computing directly
+	 * (1U<<(bt->sb.shift - something)), to be robust against
+	 * any possible value of bt->sb.shift, without having to
 	 * limit 'something'.
 	 */
 	/* no more than 50% of tags for async I/O */
-	bfqd->word_depths[0][0] = max((1U<<bfqd->sb_shift)>>1, 1U);
+	bfqd->word_depths[0][0] = max((1U << bt->sb.shift) >> 1, 1U);
 	/*
 	 * no more than 75% of tags for sync writes (25% extra tags
 	 * w.r.t. async I/O, to prevent async I/O from starving sync
 	 * writes)
 	 */
-	bfqd->word_depths[0][1] = max(((1U<<bfqd->sb_shift) * 3)>>2, 1U);
+	bfqd->word_depths[0][1] = max(((1U << bt->sb.shift) * 3) >> 2, 1U);
 
 	/*
 	 * In-word depths in case some bfq_queue is being weight-
@@ -5089,9 +5087,9 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
 	 * shortage.
 	 */
 	/* no more than ~18% of tags for async I/O */
-	bfqd->word_depths[1][0] = max(((1U<<bfqd->sb_shift) * 3)>>4, 1U);
+	bfqd->word_depths[1][0] = max(((1U << bt->sb.shift) * 3) >> 4, 1U);
 	/* no more than ~37% of tags for sync writes (~20% extra tags) */
-	bfqd->word_depths[1][1] = max(((1U<<bfqd->sb_shift) * 6)>>4, 1U);
+	bfqd->word_depths[1][1] = max(((1U << bt->sb.shift) * 6) >> 4, 1U);
 
 	for (i = 0; i < 2; i++)
 		for (j = 0; j < 2; j++)
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 8ec7ff92cd6f..faac509cb35e 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -636,12 +636,6 @@ struct bfq_data {
 	struct bfq_queue *bio_bfqq;
 
 	/*
-	 * Cached sbitmap shift, used to compute depth limits in
-	 * bfq_update_depths.
-	 */
-	unsigned int sb_shift;
-
-	/*
 	 * Depth limits used in bfq_limit_depth (see comments on the
 	 * function)
 	 */
-- 
2.7.4
