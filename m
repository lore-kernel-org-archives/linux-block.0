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
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ce5ee556-9552-6ffd-7578-7b3b983c07bf@kernel.dk>
Date: Wed, 9 May 2018 09:18:17 -0600
MIME-Version: 1.0
In-Reply-To: <1525839089.15732.1.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-block@vger.kernel.org>

On 5/8/18 10:11 PM, Mike Galbraith wrote:
> On Tue, 2018-05-08 at 19:09 -0600, Jens Axboe wrote:
>>
>> Alright, I managed to reproduce it. What I think is happening is that
>> BFQ is limiting the inflight case to something less than the wake
>> batch for sbitmap, which can lead to stalls. I don't have time to test
>> this tonight, but perhaps you can give it a go when you are back at it.
>> If not, I'll try tomorrow morning.
>>
>> If this is the issue, I can turn it into a real patch. This is just to
>> confirm that the issue goes away with the below.
> 
> Confirmed.  Impressive high speed bug stomping.

Well, that's good news. Can I get you to try this patch? Needs to be
split, but it'll be good to know if this fixes it too (since it's an
ACTUAL attempt at a fix, not just a masking).


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
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 25c14c58385c..0c53a254671f 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -16,6 +16,32 @@
 #include "blk-mq-tag.h"
 #include "blk-wbt.h"
 
+void blk_mq_sched_limit_depth(struct elevator_queue *e,
+			      struct blk_mq_alloc_data *data, unsigned int op)
+{
+	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
+	struct sbitmap_queue *bt;
+	int ret;
+
+	/*
+	 * Flush requests are special and go directly to the
+	 * dispatch list.
+	 */
+	if (op_is_flush(op) || !e->type->ops.mq.limit_depth)
+		return;
+
+	ret = e->type->ops.mq.limit_depth(op, data);
+	if (!ret)
+		return;
+
+	if (data->flags & BLK_MQ_REQ_RESERVED)
+		bt = &tags->breserved_tags;
+	else
+		bt = &tags->bitmap_tags;
+
+	sbitmap_queue_shallow_depth(bt, ret);
+}
+
 void blk_mq_sched_free_hctx_data(struct request_queue *q,
 				 void (*exit)(struct blk_mq_hw_ctx *))
 {
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 1e9c9018ace1..6abebc1b9ae0 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -5,6 +5,9 @@
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
 
+void blk_mq_sched_limit_depth(struct elevator_queue *e,
+			      struct blk_mq_alloc_data *data, unsigned int op);
+
 void blk_mq_sched_free_hctx_data(struct request_queue *q,
 				 void (*exit)(struct blk_mq_hw_ctx *));
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e9d83594cca..1bb7aa40c192 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -357,13 +357,7 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 
 	if (e) {
 		data->flags |= BLK_MQ_REQ_INTERNAL;
-
-		/*
-		 * Flush requests are special and go directly to the
-		 * dispatch list.
-		 */
-		if (!op_is_flush(op) && e->type->ops.mq.limit_depth)
-			e->type->ops.mq.limit_depth(op, data);
+		blk_mq_sched_limit_depth(e, data, op);
 	}
 
 	tag = blk_mq_get_tag(data);
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
index e6a9c06ec70c..563ae9d75fb8 100644
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
@@ -403,6 +409,15 @@ int __sbitmap_queue_get_shallow(struct sbitmap_queue *sbq,
 }
 EXPORT_SYMBOL_GPL(__sbitmap_queue_get_shallow);
 
+/*
+ * User has limited the shallow depth to 'depth', update batch wake counts
+ */
+void sbitmap_queue_shallow_depth(struct sbitmap_queue *sbq, unsigned int depth)
+{
+	sbitmap_queue_update_batch_wake(sbq, depth);
+}
+EXPORT_SYMBOL_GPL(sbitmap_queue_shallow_depth);
+
 static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 {
 	int i, wake_index;

-- 
Jens Axboe
