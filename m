Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: kyber: make kyber more friendly with merging
From: Jens Axboe <axboe@kernel.dk>
To: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
 Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1527000509-2619-1-git-send-email-jianchao.w.wang@oracle.com>
 <163c5760-cf0e-faea-ee4e-ac5d688310fe@applied-asynchrony.com>
 <00e5dfd4-d3a2-b008-3d8b-390a788f61c9@kernel.dk>
Message-ID: <7c93b85f-6a02-bdcf-5e92-a9533500df20@kernel.dk>
Date: Tue, 22 May 2018 11:46:11 -0600
MIME-Version: 1.0
In-Reply-To: <00e5dfd4-d3a2-b008-3d8b-390a788f61c9@kernel.dk>
Content-Type: multipart/mixed;
 boundary="------------A1D17A7671C3FD0CF70B0070"
List-ID: <linux-block@vger.kernel.org>

This is a multi-part message in MIME format.
--------------A1D17A7671C3FD0CF70B0070
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 5/22/18 10:20 AM, Jens Axboe wrote:
> On 5/22/18 10:17 AM, Holger Hoffstätte wrote:
>> On 05/22/18 16:48, Jianchao Wang wrote:
>>> Currently, kyber is very unfriendly with merging. kyber depends
>>> on ctx rq_list to do merging, however, most of time, it will not
>>> leave any requests in ctx rq_list. This is because even if tokens
>>> of one domain is used up, kyber will try to dispatch requests
>>> from other domain and flush the rq_list there.
>>>
>>> To improve this, we setup kyber_ctx_queue (kcq) which is similar
>>> with ctx, but it has rq_lists for different domain and build same
>>> mapping between kcq and khd as the ctx & hctx. Then we could merge,
>>> insert and dispatch for different domains separately. If one domain
>>> token is used up, the requests could be left in the rq_list of
>>> that domain and maybe merged with following io.
>>>
>>> Following is my test result on machine with 8 cores and NVMe card
>>> INTEL SSDPEKKR128G7
>>>
>>> fio size=256m ioengine=libaio iodepth=64 direct=1 numjobs=8
>>> seq/random
>>> +------+---------------------------------------------------------------+
>>> |patch?| bw(MB/s) |   iops    | slat(usec) |    clat(usec)   |  merge  |
>>> +----------------------------------------------------------------------+
>>> | w/o  |  606/612 | 151k/153k |  6.89/7.03 | 3349.21/3305.40 |   0/0   |
>>> +----------------------------------------------------------------------+
>>> | w/   | 1083/616 | 277k/154k |  4.93/6.95 | 1830.62/3279.95 | 223k/3k |
>>> +----------------------------------------------------------------------+
>>> When set numjobs to 16, the bw and iops could reach 1662MB/s and 425k
>>> on my platform.
>>>
>>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>>
>> <snip>
>>
>> This looks great but prevents kyber from being built as module,
>> which is AFAIK supposed to work (and works now):
>>
>> ..
>>   CC [M]  block/kyber-iosched.o
>>   Building modules, stage 2.
>>   MODPOST 313 modules
>> ERROR: "bio_attempt_back_merge" [block/kyber-iosched.ko] undefined!
>> ERROR: "bio_attempt_front_merge" [block/kyber-iosched.ko] undefined!
>> ERROR: "bio_attempt_discard_merge" [block/kyber-iosched.ko] undefined!
>> ERROR: "blk_try_merge" [block/kyber-iosched.ko] undefined!
>> ERROR: "blk_rq_merge_ok" [block/kyber-iosched.ko] undefined!
>> ..
>>
>> It does build fine when compiled in, obviously. :)
> 
> It's basically duplicating the contents of blk_attempt_plug_merge().
> I would suggest abstracting out the list loop and merge check
> into a helper, that could then both be called from kyber and the
> plug merge function.

See attached, prep patch and yours rebased on top of it.

-- 
Jens Axboe


--------------A1D17A7671C3FD0CF70B0070
Content-Type: text/x-patch;
 name="0002-block-kyber-make-kyber-more-friendly-with-merging.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-block-kyber-make-kyber-more-friendly-with-merging.patch"

>From edb57af07cf619f27a3fee85705870875f853f58 Mon Sep 17 00:00:00 2001
From: Jianchao Wang <jianchao.w.wang@oracle.com>
Date: Tue, 22 May 2018 11:45:01 -0600
Subject: [PATCH 2/2] block: kyber: make kyber more friendly with merging

Currently, kyber is very unfriendly with merging. kyber depends
on ctx rq_list to do merging, however, most of time, it will not
leave any requests in ctx rq_list. This is because even if tokens
of one domain is used up, kyber will try to dispatch requests
from other domain and flush the rq_list there.

To improve this, we setup kyber_ctx_queue (kcq) which is similar
with ctx, but it has rq_lists for different domain and build same
mapping between kcq and khd as the ctx & hctx. Then we could merge,
insert and dispatch for different domains separately. If one domain
token is used up, the requests could be left in the rq_list of
that domain and maybe merged with following io.

Following is my test result on machine with 8 cores and NVMe card
INTEL SSDPEKKR128G7

fio size=256m ioengine=libaio iodepth=64 direct=1 numjobs=8
seq/random
+------+---------------------------------------------------------------+
|patch?| bw(MB/s) |   iops    | slat(usec) |    clat(usec)   |  merge  |
+----------------------------------------------------------------------+
| w/o  |  606/612 | 151k/153k |  6.89/7.03 | 3349.21/3305.40 |   0/0   |
+----------------------------------------------------------------------+
| w/   | 1083/616 | 277k/154k |  4.93/6.95 | 1830.62/3279.95 | 223k/3k |
+----------------------------------------------------------------------+
When set numjobs to 16, the bw and iops could reach 1662MB/s and 425k
on my platform.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/kyber-iosched.c | 212 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 184 insertions(+), 28 deletions(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 5b33dc394cc7..f28147be729b 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -72,6 +72,15 @@ static const unsigned int kyber_batch_size[] = {
 	[KYBER_OTHER] = 8,
 };
 
+struct kyber_ctx_queue {
+	/*
+	 * Copied from blk_mq_ctx->index_hw
+	 */
+	unsigned int index;
+	spinlock_t lock;
+	struct list_head rq_list[KYBER_NUM_DOMAINS];
+} ____cacheline_aligned_in_smp;
+
 struct kyber_queue_data {
 	struct request_queue *q;
 
@@ -84,6 +93,7 @@ struct kyber_queue_data {
 	 */
 	struct sbitmap_queue domain_tokens[KYBER_NUM_DOMAINS];
 
+	struct kyber_ctx_queue *ctx_queue;
 	/*
 	 * Async request percentage, converted to per-word depth for
 	 * sbitmap_get_shallow().
@@ -99,6 +109,8 @@ struct kyber_hctx_data {
 	struct list_head rqs[KYBER_NUM_DOMAINS];
 	unsigned int cur_domain;
 	unsigned int batching;
+	struct kyber_ctx_queue **kcqs;
+	struct sbitmap kcq_map[KYBER_NUM_DOMAINS];
 	wait_queue_entry_t domain_wait[KYBER_NUM_DOMAINS];
 	struct sbq_wait_state *domain_ws[KYBER_NUM_DOMAINS];
 	atomic_t wait_index[KYBER_NUM_DOMAINS];
@@ -284,6 +296,19 @@ static unsigned int kyber_sched_tags_shift(struct kyber_queue_data *kqd)
 	return kqd->q->queue_hw_ctx[0]->sched_tags->bitmap_tags.sb.shift;
 }
 
+static void kyber_ctx_queue_init(struct kyber_queue_data *kqd)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < nr_cpu_ids; i++) {
+		struct kyber_ctx_queue *kcq = &kqd->ctx_queue[i];
+
+		spin_lock_init(&kcq->lock);
+		for (j = 0; j < KYBER_NUM_DOMAINS; j++)
+			INIT_LIST_HEAD(&kcq->rq_list[j]);
+	}
+}
+
 static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
 {
 	struct kyber_queue_data *kqd;
@@ -302,6 +327,13 @@ static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
 	if (!kqd->cb)
 		goto err_kqd;
 
+	kqd->ctx_queue = kmalloc_array_node(nr_cpu_ids,
+			sizeof(struct kyber_ctx_queue), GFP_KERNEL, -1);
+	if (!kqd->ctx_queue)
+		goto err_cb;
+
+	kyber_ctx_queue_init(kqd);
+
 	/*
 	 * The maximum number of tokens for any scheduling domain is at least
 	 * the queue depth of a single hardware queue. If the hardware doesn't
@@ -318,7 +350,7 @@ static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
 		if (ret) {
 			while (--i >= 0)
 				sbitmap_queue_free(&kqd->domain_tokens[i]);
-			goto err_cb;
+			goto err_kcq;
 		}
 		sbitmap_queue_resize(&kqd->domain_tokens[i], kyber_depth[i]);
 	}
@@ -331,6 +363,8 @@ static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
 
 	return kqd;
 
+err_kcq:
+	kfree(kqd->ctx_queue);
 err_cb:
 	blk_stat_free_callback(kqd->cb);
 err_kqd:
@@ -372,6 +406,7 @@ static void kyber_exit_sched(struct elevator_queue *e)
 
 	for (i = 0; i < KYBER_NUM_DOMAINS; i++)
 		sbitmap_queue_free(&kqd->domain_tokens[i]);
+	kfree(kqd->ctx_queue);
 	blk_stat_free_callback(kqd->cb);
 	kfree(kqd);
 }
@@ -381,11 +416,31 @@ static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
 	struct kyber_hctx_data *khd;
 	int i;
+	int sd;
 
 	khd = kmalloc_node(sizeof(*khd), GFP_KERNEL, hctx->numa_node);
 	if (!khd)
 		return -ENOMEM;
 
+	khd->kcqs = kmalloc_array_node(nr_cpu_ids, sizeof(void *),
+					GFP_KERNEL, hctx->numa_node);
+	if (!khd->kcqs)
+		goto err_khd;
+
+	sd = 0;
+	for (i = 0; i < KYBER_NUM_DOMAINS; i++) {
+		if (sbitmap_init_node(&khd->kcq_map[i], hctx->nr_ctx,
+				ilog2(8), GFP_KERNEL, hctx->numa_node))
+			goto err_kcq_map;
+		sd++;
+	}
+	/*
+	 * clone the mapping between hctx and ctx to khd and kcq
+	 */
+	for (i = 0; i < hctx->nr_ctx; i++) {
+		khd->kcqs[i] = &kqd->ctx_queue[hctx->ctxs[i]->cpu];
+		khd->kcqs[i]->index = i;
+	}
 	spin_lock_init(&khd->lock);
 
 	for (i = 0; i < KYBER_NUM_DOMAINS; i++) {
@@ -405,10 +460,24 @@ static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 					kqd->async_depth);
 
 	return 0;
+
+err_kcq_map:
+	for (i = 0; i < sd; i++)
+		sbitmap_free(&khd->kcq_map[i]);
+	kfree(khd->kcqs);
+err_khd:
+	kfree(khd);
+	return -ENOMEM;
 }
 
 static void kyber_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 {
+	struct kyber_hctx_data *khd = hctx->sched_data;
+	int i;
+
+	for (i = 0; i < KYBER_NUM_DOMAINS; i++)
+		sbitmap_free(&khd->kcq_map[i]);
+	kfree(khd->kcqs);
 	kfree(hctx->sched_data);
 }
 
@@ -449,11 +518,68 @@ static void kyber_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
 	}
 }
 
+static int bio_sched_domain(const struct bio *bio)
+{
+	unsigned int op = bio->bi_opf;
+
+	if ((op & REQ_OP_MASK) == REQ_OP_READ)
+		return KYBER_READ;
+	else if ((op & REQ_OP_MASK) == REQ_OP_WRITE && op_is_sync(op))
+		return KYBER_SYNC_WRITE;
+	else
+		return KYBER_OTHER;
+}
+
+/*
+ * Do limited merge trying here. Align with blk_mq_attempt_merge, reverse
+ * checking corresponding domain queue for 8 reqs.
+ */
+static bool kyber_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio)
+{
+	struct kyber_hctx_data *khd = hctx->sched_data;
+	struct blk_mq_ctx *ctx = blk_mq_get_ctx(hctx->queue);
+	struct kyber_ctx_queue *kcq = khd->kcqs[ctx->index_hw];
+	struct list_head *rq_list = &kcq->rq_list[bio_sched_domain(bio)];
+	bool merged;
+
+	spin_lock(&kcq->lock);
+	merged = blk_mq_bio_list_merge(hctx->queue, rq_list, bio);
+	spin_unlock(&kcq->lock);
+
+	blk_mq_put_ctx(ctx);
+
+	return merged;
+}
+
 static void kyber_prepare_request(struct request *rq, struct bio *bio)
 {
 	rq_set_domain_token(rq, -1);
 }
 
+static void kyber_insert_requests(struct blk_mq_hw_ctx *hctx,
+		struct list_head *rq_list, bool at_head)
+{
+	struct kyber_hctx_data *khd = hctx->sched_data;
+	struct kyber_ctx_queue *kcq;
+	struct request *rq, *next;
+	struct list_head *head;
+	unsigned int sched_domain;
+
+	list_for_each_entry_safe(rq, next, rq_list, queuelist) {
+		sched_domain = rq_sched_domain(rq);
+		kcq = khd->kcqs[rq->mq_ctx->index_hw];
+		head = &kcq->rq_list[sched_domain];
+		spin_lock(&kcq->lock);
+		if (at_head)
+			list_move(&rq->queuelist, head);
+		else
+			list_move_tail(&rq->queuelist, head);
+		sbitmap_set_bit(&khd->kcq_map[sched_domain], kcq->index);
+		blk_mq_sched_request_inserted(rq);
+		spin_unlock(&kcq->lock);
+	}
+}
+
 static void kyber_finish_request(struct request *rq)
 {
 	struct kyber_queue_data *kqd = rq->q->elevator->elevator_data;
@@ -498,19 +624,36 @@ static void kyber_completed_request(struct request *rq)
 		blk_stat_activate_msecs(kqd->cb, 10);
 }
 
-static void kyber_flush_busy_ctxs(struct kyber_hctx_data *khd,
-				  struct blk_mq_hw_ctx *hctx)
+struct flush_kcq_data {
+	struct kyber_hctx_data *khd;
+	unsigned int sched_domain;
+	struct list_head *list;
+};
+
+static bool flush_busy_kcq(struct sbitmap *sb, unsigned int bitnr, void *data)
 {
-	LIST_HEAD(rq_list);
-	struct request *rq, *next;
+	struct flush_kcq_data *flush_data = data;
+	struct kyber_ctx_queue *kcq = flush_data->khd->kcqs[bitnr];
 
-	blk_mq_flush_busy_ctxs(hctx, &rq_list);
-	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
-		unsigned int sched_domain;
+	spin_lock(&kcq->lock);
+	list_splice_tail_init(&kcq->rq_list[flush_data->sched_domain],
+			flush_data->list);
+	sbitmap_clear_bit(sb, bitnr);
+	spin_unlock(&kcq->lock);
 
-		sched_domain = rq_sched_domain(rq);
-		list_move_tail(&rq->queuelist, &khd->rqs[sched_domain]);
-	}
+	return true;
+}
+
+static void kyber_flush_busy_kcqs(struct kyber_hctx_data *khd,
+		unsigned int sched_domain, struct list_head *list)
+{
+	struct flush_kcq_data data = {
+		.khd = khd,
+		.sched_domain = sched_domain,
+		.list = list,
+	};
+
+	sbitmap_for_each_set(&khd->kcq_map[sched_domain], flush_busy_kcq, &data);
 }
 
 static int kyber_domain_wake(wait_queue_entry_t *wait, unsigned mode, int flags,
@@ -573,26 +716,19 @@ static int kyber_get_domain_token(struct kyber_queue_data *kqd,
 static struct request *
 kyber_dispatch_cur_domain(struct kyber_queue_data *kqd,
 			  struct kyber_hctx_data *khd,
-			  struct blk_mq_hw_ctx *hctx,
-			  bool *flushed)
+			  struct blk_mq_hw_ctx *hctx)
 {
 	struct list_head *rqs;
 	struct request *rq;
 	int nr;
 
 	rqs = &khd->rqs[khd->cur_domain];
-	rq = list_first_entry_or_null(rqs, struct request, queuelist);
 
 	/*
-	 * If there wasn't already a pending request and we haven't flushed the
-	 * software queues yet, flush the software queues and check again.
+	 * If we do have cur_domain rqs on khd or kcq list, then try to require
+	 * the token
 	 */
-	if (!rq && !*flushed) {
-		kyber_flush_busy_ctxs(khd, hctx);
-		*flushed = true;
-		rq = list_first_entry_or_null(rqs, struct request, queuelist);
-	}
-
+	rq = list_first_entry_or_null(rqs, struct request, queuelist);
 	if (rq) {
 		nr = kyber_get_domain_token(kqd, khd, hctx);
 		if (nr >= 0) {
@@ -601,8 +737,25 @@ kyber_dispatch_cur_domain(struct kyber_queue_data *kqd,
 			list_del_init(&rq->queuelist);
 			return rq;
 		}
+	} else if (sbitmap_any_bit_set(&khd->kcq_map[khd->cur_domain])) {
+		nr = kyber_get_domain_token(kqd, khd, hctx);
+		if (nr >= 0) {
+			kyber_flush_busy_kcqs(khd, khd->cur_domain, rqs);
+			rq = list_first_entry_or_null(rqs, struct request, queuelist);
+			/*
+			 * khd->lock and kcq->lock will ensure that, if kcq_map[cur_domain]
+			 * is set, we must be able to get requests from the kcq
+			 */
+			khd->batching++;
+			rq_set_domain_token(rq, nr);
+			list_del_init(&rq->queuelist);
+			return rq;
+		}
+		/*
+		 * if not get domain token, the rqs could be left on kcqs to merged
+		 * with following ios.
+		 */
 	}
-
 	/* There were either no pending requests or no tokens. */
 	return NULL;
 }
@@ -611,7 +764,6 @@ static struct request *kyber_dispatch_request(struct blk_mq_hw_ctx *hctx)
 {
 	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
 	struct kyber_hctx_data *khd = hctx->sched_data;
-	bool flushed = false;
 	struct request *rq;
 	int i;
 
@@ -622,7 +774,7 @@ static struct request *kyber_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	 * from the batch.
 	 */
 	if (khd->batching < kyber_batch_size[khd->cur_domain]) {
-		rq = kyber_dispatch_cur_domain(kqd, khd, hctx, &flushed);
+		rq = kyber_dispatch_cur_domain(kqd, khd, hctx);
 		if (rq)
 			goto out;
 	}
@@ -643,7 +795,7 @@ static struct request *kyber_dispatch_request(struct blk_mq_hw_ctx *hctx)
 		else
 			khd->cur_domain++;
 
-		rq = kyber_dispatch_cur_domain(kqd, khd, hctx, &flushed);
+		rq = kyber_dispatch_cur_domain(kqd, khd, hctx);
 		if (rq)
 			goto out;
 	}
@@ -660,10 +812,12 @@ static bool kyber_has_work(struct blk_mq_hw_ctx *hctx)
 	int i;
 
 	for (i = 0; i < KYBER_NUM_DOMAINS; i++) {
-		if (!list_empty_careful(&khd->rqs[i]))
+		if (!list_empty_careful(&khd->rqs[i]) ||
+				sbitmap_any_bit_set(&khd->kcq_map[i]))
 			return true;
 	}
-	return sbitmap_any_bit_set(&hctx->ctx_map);
+
+	return false;
 }
 
 #define KYBER_LAT_SHOW_STORE(op)					\
@@ -834,7 +988,9 @@ static struct elevator_type kyber_sched = {
 		.init_hctx = kyber_init_hctx,
 		.exit_hctx = kyber_exit_hctx,
 		.limit_depth = kyber_limit_depth,
+		.bio_merge = kyber_bio_merge,
 		.prepare_request = kyber_prepare_request,
+		.insert_requests = kyber_insert_requests,
 		.finish_request = kyber_finish_request,
 		.requeue_request = kyber_finish_request,
 		.completed_request = kyber_completed_request,
-- 
2.7.4


--------------A1D17A7671C3FD0CF70B0070
Content-Type: text/x-patch;
 name="0001-blk-mq-abstract-out-blk-mq-sched-rq-list-iteration-b.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-blk-mq-abstract-out-blk-mq-sched-rq-list-iteration-b.pa";
 filename*1="tch"

>From 82d8018412c12407fbfb134c7be5410ba5a76084 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 22 May 2018 11:41:46 -0600
Subject: [PATCH 1/2] blk-mq: abstract out blk-mq-sched rq list iteration bio
 merge helper

No functional changes in this patch, just a prep patch for utilizing
this in an IO scheduler.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-sched.c   | 34 ++++++++++++++++++++++++----------
 include/linux/blk-mq.h |  3 ++-
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 25c14c58385c..b0f2c2a40a0c 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -268,19 +268,16 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_merge);
 
 /*
- * Reverse check our software queue for entries that we could potentially
- * merge with. Currently includes a hand-wavy stop count of 8, to not spend
- * too much time checking for merges.
+ * Iterate list of requests and see if we can merge this bio with any
+ * of them.
  */
-static bool blk_mq_attempt_merge(struct request_queue *q,
-				 struct blk_mq_ctx *ctx, struct bio *bio)
+bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
+			   struct bio *bio)
 {
 	struct request *rq;
 	int checked = 8;
 
-	lockdep_assert_held(&ctx->lock);
-
-	list_for_each_entry_reverse(rq, &ctx->rq_list, queuelist) {
+	list_for_each_entry_reverse(rq, list, queuelist) {
 		bool merged = false;
 
 		if (!checked--)
@@ -305,13 +302,30 @@ static bool blk_mq_attempt_merge(struct request_queue *q,
 			continue;
 		}
 
-		if (merged)
-			ctx->rq_merged++;
 		return merged;
 	}
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(blk_mq_bio_list_merge);
+
+/*
+ * Reverse check our software queue for entries that we could potentially
+ * merge with. Currently includes a hand-wavy stop count of 8, to not spend
+ * too much time checking for merges.
+ */
+static bool blk_mq_attempt_merge(struct request_queue *q,
+				 struct blk_mq_ctx *ctx, struct bio *bio)
+{
+	lockdep_assert_held(&ctx->lock);
+
+	if (blk_mq_bio_list_merge(q, &ctx->rq_list, bio)) {
+		ctx->rq_merged++;
+		return true;
+	}
+
+	return false;
+}
 
 bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ebc34a5686dc..fb355173f3c7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -259,7 +259,8 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 void blk_mq_complete_request(struct request *rq);
-
+bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
+			   struct bio *bio);
 bool blk_mq_queue_stopped(struct request_queue *q);
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
 void blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx);
-- 
2.7.4


--------------A1D17A7671C3FD0CF70B0070--
