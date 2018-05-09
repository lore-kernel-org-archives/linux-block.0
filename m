Return-Path: <axboe@kernel.dk>
Subject: Re: bug in tag handling in blk-mq?
To: Mike Galbraith <efault@gmx.de>, Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block
 <linux-block@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Oleksandr Natalenko <oleksandr@natalenko.name>
References: <999DF2B3-4EE8-4BDF-89C5-EB0C2D8BF69E@linaro.org>
 <7760d23b-7a4c-a645-1c7a-da7569bb44dc@kernel.dk>
 <84145CD7-B917-4B32-8A5C-310C1910DB71@linaro.org>
 <1525755090.24338.1.camel@gmx.de> <1525768632.5208.4.camel@gmx.de>
 <ffd0c030-43f8-0dbe-42b3-03bb9c410bea@kernel.dk>
 <1525797766.5204.2.camel@gmx.de>
 <3692ce7d-a767-72e6-65ae-6178b6c2e7d8@kernel.dk>
 <f04636df-3f97-6c16-f37b-d407e062b9e5@kernel.dk>
 <57952405-bdeb-f4e4-1aef-a7c0a8a68674@kernel.dk>
 <1525839089.15732.1.camel@gmx.de>
 <ce5ee556-9552-6ffd-7578-7b3b983c07bf@kernel.dk>
 <1525885030.15732.6.camel@gmx.de>
 <1e51eb57-6d9b-a53c-9cd6-2adfc86b21b5@kernel.dk>
 <1525890708.11382.1.camel@gmx.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2b65d736-aef8-5da1-96ad-c86a931d59eb@kernel.dk>
Date: Wed, 9 May 2018 13:50:48 -0600
MIME-Version: 1.0
In-Reply-To: <1525890708.11382.1.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-block@vger.kernel.org>

On 5/9/18 12:31 PM, Mike Galbraith wrote:
> On Wed, 2018-05-09 at 11:01 -0600, Jens Axboe wrote:
>> On 5/9/18 10:57 AM, Mike Galbraith wrote:
>>
>>>>> Confirmed.  Impressive high speed bug stomping.
>>>>
>>>> Well, that's good news. Can I get you to try this patch?
>>>
>>> Sure thing.  The original hang (minus provocation patch) being
>>> annoyingly non-deterministic, this will (hopefully) take a while.
>>
>> You can verify with the provocation patch as well first, if you wish.
> 
> Done, box still seems fine.

Omar had some (valid) complaints, can you try this one as well? You
can also find it as a series here:

http://git.kernel.dk/cgit/linux-block/log/?h=bfq-cleanups

I'll repost the series shortly, need to check if it actually builds and
boots.

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ebc264c87a09..cba6e82153a2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -487,46 +487,6 @@ static struct request *bfq_choose_req(struct bfq_data *bfqd,
 }
 
 /*
- * See the comments on bfq_limit_depth for the purpose of
- * the depths set in the function.
- */
-static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
-{
-	bfqd->sb_shift = bt->sb.shift;
-
-	/*
-	 * In-word depths if no bfq_queue is being weight-raised:
-	 * leaving 25% of tags only for sync reads.
-	 *
-	 * In next formulas, right-shift the value
-	 * (1U<<bfqd->sb_shift), instead of computing directly
-	 * (1U<<(bfqd->sb_shift - something)), to be robust against
-	 * any possible value of bfqd->sb_shift, without having to
-	 * limit 'something'.
-	 */
-	/* no more than 50% of tags for async I/O */
-	bfqd->word_depths[0][0] = max((1U<<bfqd->sb_shift)>>1, 1U);
-	/*
-	 * no more than 75% of tags for sync writes (25% extra tags
-	 * w.r.t. async I/O, to prevent async I/O from starving sync
-	 * writes)
-	 */
-	bfqd->word_depths[0][1] = max(((1U<<bfqd->sb_shift) * 3)>>2, 1U);
-
-	/*
-	 * In-word depths in case some bfq_queue is being weight-
-	 * raised: leaving ~63% of tags for sync reads. This is the
-	 * highest percentage for which, in our tests, application
-	 * start-up times didn't suffer from any regression due to tag
-	 * shortage.
-	 */
-	/* no more than ~18% of tags for async I/O */
-	bfqd->word_depths[1][0] = max(((1U<<bfqd->sb_shift) * 3)>>4, 1U);
-	/* no more than ~37% of tags for sync writes (~20% extra tags) */
-	bfqd->word_depths[1][1] = max(((1U<<bfqd->sb_shift) * 6)>>4, 1U);
-}
-
-/*
  * Async I/O can easily starve sync I/O (both sync reads and sync
  * writes), by consuming all tags. Similarly, storms of sync writes,
  * such as those that sync(2) may trigger, can starve sync reads.
@@ -535,25 +495,11 @@ static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
  */
 static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
 {
-	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct bfq_data *bfqd = data->q->elevator->elevator_data;
-	struct sbitmap_queue *bt;
 
 	if (op_is_sync(op) && !op_is_write(op))
 		return;
 
-	if (data->flags & BLK_MQ_REQ_RESERVED) {
-		if (unlikely(!tags->nr_reserved_tags)) {
-			WARN_ON_ONCE(1);
-			return;
-		}
-		bt = &tags->breserved_tags;
-	} else
-		bt = &tags->bitmap_tags;
-
-	if (unlikely(bfqd->sb_shift != bt->sb.shift))
-		bfq_update_depths(bfqd, bt);
-
 	data->shallow_depth =
 		bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
 
@@ -5105,6 +5051,66 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
 	__bfq_put_async_bfqq(bfqd, &bfqg->async_idle_bfqq);
 }
 
+/*
+ * See the comments on bfq_limit_depth for the purpose of
+ * the depths set in the function. Return minimum shallow depth we'll use.
+ */
+static unsigned int bfq_update_depths(struct bfq_data *bfqd,
+				      struct sbitmap_queue *bt)
+{
+	unsigned int i, j, min_shallow = UINT_MAX;
+
+	bfqd->sb_shift = bt->sb.shift;
+
+	/*
+	 * In-word depths if no bfq_queue is being weight-raised:
+	 * leaving 25% of tags only for sync reads.
+	 *
+	 * In next formulas, right-shift the value
+	 * (1U<<bfqd->sb_shift), instead of computing directly
+	 * (1U<<(bfqd->sb_shift - something)), to be robust against
+	 * any possible value of bfqd->sb_shift, without having to
+	 * limit 'something'.
+	 */
+	/* no more than 50% of tags for async I/O */
+	bfqd->word_depths[0][0] = max((1U<<bfqd->sb_shift)>>1, 1U);
+	/*
+	 * no more than 75% of tags for sync writes (25% extra tags
+	 * w.r.t. async I/O, to prevent async I/O from starving sync
+	 * writes)
+	 */
+	bfqd->word_depths[0][1] = max(((1U<<bfqd->sb_shift) * 3)>>2, 1U);
+
+	/*
+	 * In-word depths in case some bfq_queue is being weight-
+	 * raised: leaving ~63% of tags for sync reads. This is the
+	 * highest percentage for which, in our tests, application
+	 * start-up times didn't suffer from any regression due to tag
+	 * shortage.
+	 */
+	/* no more than ~18% of tags for async I/O */
+	bfqd->word_depths[1][0] = max(((1U<<bfqd->sb_shift) * 3)>>4, 1U);
+	/* no more than ~37% of tags for sync writes (~20% extra tags) */
+	bfqd->word_depths[1][1] = max(((1U<<bfqd->sb_shift) * 6)>>4, 1U);
+
+	for (i = 0; i < 2; i++)
+		for (j = 0; j < 2; j++)
+			min_shallow = min(min_shallow, bfqd->word_depths[i][j]);
+
+	return min_shallow;
+}
+
+static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
+{
+	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
+	struct blk_mq_tags *tags = hctx->sched_tags;
+	unsigned int min_shallow;
+
+	min_shallow = bfq_update_depths(bfqd, &tags->bitmap_tags);
+	sbitmap_queue_shallow_depth(&tags->bitmap_tags, min_shallow);
+	return 0;
+}
+
 static void bfq_exit_queue(struct elevator_queue *e)
 {
 	struct bfq_data *bfqd = e->elevator_data;
@@ -5526,6 +5532,7 @@ static struct elevator_type iosched_bfq_mq = {
 		.requests_merged	= bfq_requests_merged,
 		.request_merged		= bfq_request_merged,
 		.has_work		= bfq_has_work,
+		.init_hctx		= bfq_init_hctx,
 		.init_sched		= bfq_init_queue,
 		.exit_sched		= bfq_exit_queue,
 	},
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e9d83594cca..64630caaf27e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -360,9 +360,11 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 
 		/*
 		 * Flush requests are special and go directly to the
-		 * dispatch list.
+		 * dispatch list. Don't include reserved tags in the
+		 * limiting, as it isn't useful.
 		 */
-		if (!op_is_flush(op) && e->type->ops.mq.limit_depth)
+		if (!op_is_flush(op) && e->type->ops.mq.limit_depth &&
+		    !(data->flags & BLK_MQ_REQ_RESERVED))
 			e->type->ops.mq.limit_depth(op, data);
 	}
 
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 841585f6e5f2..99059789f45f 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -164,6 +164,17 @@ static inline void sbitmap_free(struct sbitmap *sb)
 void sbitmap_resize(struct sbitmap *sb, unsigned int depth);
 
 /**
+ * sbitmap_queue_shallow_depth() - Inform sbitmap about shallow depth changes
+ * @sbq: Bitmap queue in question
+ * @depth: Shallow depth limit
+ *
+ * Due to how sbitmap does batched wakes, if a user of sbitmap updates the
+ * shallow depth, then we might need to update our batched wake counts.
+ *
+ */
+void sbitmap_queue_shallow_depth(struct sbitmap_queue *sbq, unsigned int depth);
+
+/**
  * sbitmap_get() - Try to allocate a free bit from a &struct sbitmap.
  * @sb: Bitmap to allocate from.
  * @alloc_hint: Hint for where to start searching for a free bit.
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index e6a9c06ec70c..a4fb48e4c26b 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -327,7 +327,8 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_init_node);
 
-void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth)
+static void sbitmap_queue_update_batch_wake(struct sbitmap_queue *sbq,
+					    unsigned int depth)
 {
 	unsigned int wake_batch = sbq_calc_wake_batch(depth);
 	int i;
@@ -342,6 +343,11 @@ void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth)
 		for (i = 0; i < SBQ_WAIT_QUEUES; i++)
 			atomic_set(&sbq->ws[i].wait_cnt, 1);
 	}
+}
+
+void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth)
+{
+	sbitmap_queue_update_batch_wake(sbq, depth);
 	sbitmap_resize(&sbq->sb, depth);
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_resize);
@@ -403,6 +409,17 @@ int __sbitmap_queue_get_shallow(struct sbitmap_queue *sbq,
 }
 EXPORT_SYMBOL_GPL(__sbitmap_queue_get_shallow);
 
+/*
+ * User has limited the shallow depth to 'depth', update batch wake counts
+ * if depth is smaller than the sbitmap_queue depth
+ */
+void sbitmap_queue_shallow_depth(struct sbitmap_queue *sbq, unsigned int depth)
+{
+	if (depth < sbq->sb.depth)
+		sbitmap_queue_update_batch_wake(sbq, depth);
+}
+EXPORT_SYMBOL_GPL(sbitmap_queue_shallow_depth);
+
 static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 {
 	int i, wake_index;

-- 
Jens Axboe
