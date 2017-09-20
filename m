Return-Path: <ming.lei@redhat.com>
Date: Wed, 20 Sep 2017 20:20:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Laurence Oberman <loberman@redhat.com>,
	Paolo Valente <paolo.valente@linaro.org>,
	Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH V4 05/14] blk-mq-sched: improve dispatching from sw queue
Message-ID: <20170920122057.GA27867@ming.t460p>
References: <20170902151729.6162-1-ming.lei@redhat.com>
 <20170902151729.6162-6-ming.lei@redhat.com>
 <937c6abf-8438-5e04-76a6-8485eb8be141@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <937c6abf-8438-5e04-76a6-8485eb8be141@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 19, 2017 at 02:37:50PM -0600, Jens Axboe wrote:
> On 09/02/2017 09:17 AM, Ming Lei wrote:
> > @@ -142,18 +178,31 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> >  	if (!list_empty(&rq_list)) {
> >  		blk_mq_sched_mark_restart_hctx(hctx);
> >  		do_sched_dispatch = blk_mq_dispatch_rq_list(q, &rq_list);
> > -	} else if (!has_sched_dispatch) {
> > +	} else if (!has_sched_dispatch && !q->queue_depth) {
> > +		/*
> > +		 * If there is no per-request_queue depth, we
> > +		 * flush all requests in this hw queue, otherwise
> > +		 * pick up request one by one from sw queue for
> > +		 * avoiding to mess up I/O merge when dispatch
> > +		 * is busy, which can be triggered easily by
> > +		 * per-request_queue queue depth
> > +		 */
> >  		blk_mq_flush_busy_ctxs(hctx, &rq_list);
> >  		blk_mq_dispatch_rq_list(q, &rq_list);
> >  	}
> 
> I don't like this part at all. It's a heuristic, and on top of that,
> it's a heuristic based on a weak assumption that if q->queue_depth == 0,
> then we never run into BUSY constraints. I think that would be stronger
> if it was based on "is this using shared tags", but even that is not
> great at all. It's perfectly possible to have a shared tags setup and
> never run into resource constraints. The opposite condition is also true
> - you can run without shared tags, and yet hit resource constraints
> constantly. Hence this is NOT a good test for deciding whether to flush
> everything at once or not. In short, I think a much better test case
> would be "has this device ever returned BLK_STS_RESOURCE. As it so
> happens, that's easy enough to keep track of and base this test on.

Hi Jens,

The attached patch follows your suggestion, and uses EWMA to
compute the average length of hctx->dispatch, then only flush
all requests from ctxs if the average length is zero, what do
you think about this approach? Or other suggestions?


diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 7a27f262c96a..c420c775b9c0 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -232,6 +232,14 @@ static int hctx_flags_show(void *data, struct seq_file *m)
 	return 0;
 }
 
+static int hctx_dispatch_len_show(void *data, struct seq_file *m)
+{
+	struct blk_mq_hw_ctx *hctx = data;
+
+	seq_printf(m, "%u\n", hctx->dispatch_len);
+	return 0;
+}
+
 #define REQ_OP_NAME(name) [REQ_OP_##name] = #name
 static const char *const op_name[] = {
 	REQ_OP_NAME(READ),
@@ -763,6 +771,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"state", 0400, hctx_state_show},
 	{"flags", 0400, hctx_flags_show},
 	{"dispatch", 0400, .seq_ops = &hctx_dispatch_seq_ops},
+	{"dispatch_length", 0400, hctx_dispatch_len_show},
 	{"busy", 0400, hctx_busy_show},
 	{"ctx_map", 0400, hctx_ctx_map_show},
 	{"tags", 0400, hctx_tags_show},
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index a5712dd67783..91a6eeaadaf1 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -102,7 +102,7 @@ static void blk_mq_do_dispatch_sched(struct request_queue *q,
 		if (!rq)
 			break;
 		list_add(&rq->queuelist, &rq_list);
-	} while (blk_mq_dispatch_rq_list(q, &rq_list));
+	} while (blk_mq_dispatch_rq_list(q, &rq_list, 1));
 }
 
 static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
@@ -134,19 +134,51 @@ static void blk_mq_do_dispatch_ctx(struct request_queue *q,
 		/* round robin for fair dispatch */
 		ctx = blk_mq_next_ctx(hctx, rq->mq_ctx);
 
-		dispatched = blk_mq_dispatch_rq_list(q, &rq_list);
+		dispatched = blk_mq_dispatch_rq_list(q, &rq_list, 1);
 	} while (dispatched);
 
 	if (!dispatched)
 		WRITE_ONCE(hctx->dispatch_from, ctx);
 }
 
+/* borrowed from bcache */
+void ewma_add(unsigned *ewma, unsigned val, unsigned weight)
+{
+	unsigned  result = READ_ONCE(*ewma);
+
+	if (val == 1) {
+		result += 1;
+	} else {
+		result *= weight - 1;
+		result += val;
+		result /= weight;
+	}
+	WRITE_ONCE(*ewma, result);
+}
+
+/*
+ * We use EWMA to compute the average length of dispatch list.
+ * It is totally lockless, but we can survive that since it
+ * is just a hint.
+ *
+ * We only flush requests from all ctxs if the average length
+ * of dispatch list is zero, otherwise the hw queue can be
+ * thought as busy and we dequeue request from ctxs one by
+ * one
+ */
+static void blk_mq_update_dispatch_length(struct blk_mq_hw_ctx *hctx,
+					  unsigned cnt)
+{
+	ewma_add(&hctx->dispatch_len, cnt, 8);
+}
+
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
 	const bool has_sched_dispatch = e && e->type->ops.mq.dispatch_request;
 	LIST_HEAD(rq_list);
+	unsigned rq_cnt = 0;
 
 	/* RCU or SRCU read lock is needed before checking quiesced flag */
 	if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
@@ -162,9 +194,14 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 		spin_lock(&hctx->lock);
 		if (!list_empty(&hctx->dispatch))
 			list_splice_init(&hctx->dispatch, &rq_list);
+		rq_cnt = hctx->cnt;
+		hctx->cnt = 0;
 		spin_unlock(&hctx->lock);
 	}
 
+	if (!has_sched_dispatch)
+		blk_mq_update_dispatch_length(hctx, rq_cnt);
+
 	/*
 	 * Only ask the scheduler for requests, if we didn't have residual
 	 * requests from the dispatch list. This is to avoid the case where
@@ -176,7 +213,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	 */
 	if (!list_empty(&rq_list)) {
 		blk_mq_sched_mark_restart_hctx(hctx);
-		blk_mq_dispatch_rq_list(q, &rq_list);
+		blk_mq_dispatch_rq_list(q, &rq_list, rq_cnt);
 
 		/*
 		 * We may clear DISPATCH_BUSY just after it
@@ -204,16 +241,16 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 
 	if (!has_sched_dispatch) {
 		/*
-		 * If there is no per-request_queue depth, we
+		 * If dispatch doesn't run out of resource, we
 		 * flush all requests in this hw queue, otherwise
 		 * pick up request one by one from sw queue for
 		 * avoiding to mess up I/O merge when dispatch
 		 * run out of resource, which can be triggered
 		 * easily by per-request_queue queue depth
 		 */
-		if (!q->queue_depth) {
-			blk_mq_flush_busy_ctxs(hctx, &rq_list);
-			blk_mq_dispatch_rq_list(q, &rq_list);
+		if (!hctx->dispatch_len) {
+			rq_cnt = blk_mq_flush_busy_ctxs(hctx, &rq_list);
+			blk_mq_dispatch_rq_list(q, &rq_list, rq_cnt);
 		} else {
 			blk_mq_do_dispatch_ctx(q, hctx);
 		}
@@ -346,6 +383,7 @@ static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
 	 * the dispatch list.
 	 */
 	spin_lock(&hctx->lock);
+	hctx->cnt++;
 	list_add(&rq->queuelist, &hctx->dispatch);
 	set_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state);
 	spin_unlock(&hctx->lock);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1bb45e995da3..b2db5d6d568e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -850,6 +850,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
 struct flush_busy_ctx_data {
 	struct blk_mq_hw_ctx *hctx;
 	struct list_head *list;
+	unsigned cnt;
 };
 
 static bool flush_busy_ctx(struct sbitmap *sb, unsigned int bitnr, void *data)
@@ -857,11 +858,16 @@ static bool flush_busy_ctx(struct sbitmap *sb, unsigned int bitnr, void *data)
 	struct flush_busy_ctx_data *flush_data = data;
 	struct blk_mq_hw_ctx *hctx = flush_data->hctx;
 	struct blk_mq_ctx *ctx = hctx->ctxs[bitnr];
+	unsigned cnt = 0;
 
 	sbitmap_clear_bit(sb, bitnr);
 	spin_lock(&ctx->lock);
 	list_splice_tail_init(&ctx->rq_list, flush_data->list);
+	cnt = ctx->cnt;
+	ctx->cnt = 0;;
 	spin_unlock(&ctx->lock);
+	flush_data->cnt += cnt;
+
 	return true;
 }
 
@@ -869,14 +875,17 @@ static bool flush_busy_ctx(struct sbitmap *sb, unsigned int bitnr, void *data)
  * Process software queues that have been marked busy, splicing them
  * to the for-dispatch
  */
-void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list)
+unsigned blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 {
 	struct flush_busy_ctx_data data = {
 		.hctx = hctx,
 		.list = list,
+		.cnt  = 0,
 	};
 
 	sbitmap_for_each_set(&hctx->ctx_map, flush_busy_ctx, &data);
+
+	return data.cnt;
 }
 EXPORT_SYMBOL_GPL(blk_mq_flush_busy_ctxs);
 
@@ -897,6 +906,7 @@ static bool dispatch_rq_from_ctx(struct sbitmap *sb, unsigned int bitnr, void *d
 		list_del_init(&dispatch_data->rq->queuelist);
 		if (list_empty(&ctx->rq_list))
 			sbitmap_clear_bit(sb, bitnr);
+		ctx->cnt--;
 	}
 	spin_unlock(&ctx->lock);
 
@@ -1052,7 +1062,9 @@ static bool blk_mq_dispatch_wait_add(struct blk_mq_hw_ctx *hctx)
 	return true;
 }
 
-bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
+/* @cnt represents the number of requests in @list */
+bool blk_mq_dispatch_rq_list(struct request_queue *q,
+			     struct list_head *list, unsigned cnt)
 {
 	struct blk_mq_hw_ctx *hctx;
 	struct request *rq;
@@ -1139,6 +1151,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
 		blk_mq_put_driver_tag(rq);
 
 		spin_lock(&hctx->lock);
+		hctx->cnt += cnt - queued - errors;
 		list_splice_init(list, &hctx->dispatch);
 		/*
 		 * DISPATCH_BUSY won't be cleared until all requests
@@ -1431,6 +1444,7 @@ static inline void __blk_mq_insert_req_list(struct blk_mq_hw_ctx *hctx,
 		list_add(&rq->queuelist, &ctx->rq_list);
 	else
 		list_add_tail(&rq->queuelist, &ctx->rq_list);
+	ctx->cnt++;
 }
 
 void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
@@ -1454,6 +1468,7 @@ void blk_mq_request_bypass_insert(struct request *rq)
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(rq->q, ctx->cpu);
 
 	spin_lock(&hctx->lock);
+	hctx->cnt++;
 	list_add_tail(&rq->queuelist, &hctx->dispatch);
 	set_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state);
 	spin_unlock(&hctx->lock);
@@ -1941,6 +1956,7 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	if (!list_empty(&ctx->rq_list)) {
 		list_splice_init(&ctx->rq_list, &tmp);
 		blk_mq_hctx_clear_pending(hctx, ctx);
+		ctx->cnt = 0;
 	}
 	spin_unlock(&ctx->lock);
 
@@ -1950,6 +1966,7 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	spin_lock(&hctx->lock);
 	list_splice_tail_init(&tmp, &hctx->dispatch);
 	set_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state);
+	hctx->cnt++;
 	spin_unlock(&hctx->lock);
 
 	blk_mq_run_hw_queue(hctx, true);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 231cfb0d973b..0da5a81cc41f 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -9,6 +9,7 @@ struct blk_mq_ctx {
 	struct {
 		spinlock_t		lock;
 		struct list_head	rq_list;
+		unsigned		cnt;
 	}  ____cacheline_aligned_in_smp;
 
 	unsigned int		cpu;
@@ -30,8 +31,9 @@ void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_free_queue(struct request_queue *q);
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
-bool blk_mq_dispatch_rq_list(struct request_queue *, struct list_head *);
-void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
+bool blk_mq_dispatch_rq_list(struct request_queue *, struct list_head *,
+			     unsigned);
+unsigned blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
 bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx);
 bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 				bool wait);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 13f6c25fa461..778dbdd596f3 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -11,6 +11,7 @@ struct blk_flush_queue;
 struct blk_mq_hw_ctx {
 	struct {
 		spinlock_t		lock;
+		unsigned		cnt;
 		struct list_head	dispatch;
 		unsigned long		state;		/* BLK_MQ_S_* flags */
 	} ____cacheline_aligned_in_smp;
@@ -31,6 +32,7 @@ struct blk_mq_hw_ctx {
 	struct sbitmap		ctx_map;
 
 	struct blk_mq_ctx	*dispatch_from;
+	unsigned		dispatch_len;
 
 	struct blk_mq_ctx	**ctxs;
 	unsigned int		nr_ctx;


Thanks,
Ming
