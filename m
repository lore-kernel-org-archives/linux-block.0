Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Tue, 22 May 2018 13:02:14 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: kyber: make kyber more friendly with merging
Message-ID: <20180522200214.GF9536@vader>
References: <1527000509-2619-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1527000509-2619-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 10:48:29PM +0800, Jianchao Wang wrote:
> Currently, kyber is very unfriendly with merging. kyber depends
> on ctx rq_list to do merging, however, most of time, it will not
> leave any requests in ctx rq_list. This is because even if tokens
> of one domain is used up, kyber will try to dispatch requests
> from other domain and flush the rq_list there.

That's a great catch, I totally missed this.

This approach does end up duplicating a lot of code with the blk-mq core
even after Jens' change, so I'm curious if you tried other approaches.
One idea I had is to try the bio merge against the kqd->rqs lists. Since
that's per-queue, the locking overhead might be too high. Alternatively,
you could keep the software queues as-is but add our own version of
flush_busy_ctxs() that only removes requests of the domain that we want.
If one domain gets backed up, that might get messy with long iterations,
though.

Regarding this approach, a couple of comments below.

> To improve this, we setup kyber_ctx_queue (kcq) which is similar
> with ctx, but it has rq_lists for different domain and build same
> mapping between kcq and khd as the ctx & hctx. Then we could merge,
> insert and dispatch for different domains separately. If one domain
> token is used up, the requests could be left in the rq_list of
> that domain and maybe merged with following io.
> 
> Following is my test result on machine with 8 cores and NVMe card
> INTEL SSDPEKKR128G7
> 
> fio size=256m ioengine=libaio iodepth=64 direct=1 numjobs=8
> seq/random
> +------+---------------------------------------------------------------+
> |patch?| bw(MB/s) |   iops    | slat(usec) |    clat(usec)   |  merge  |
> +----------------------------------------------------------------------+
> | w/o  |  606/612 | 151k/153k |  6.89/7.03 | 3349.21/3305.40 |   0/0   |
> +----------------------------------------------------------------------+
> | w/   | 1083/616 | 277k/154k |  4.93/6.95 | 1830.62/3279.95 | 223k/3k |
> +----------------------------------------------------------------------+
> When set numjobs to 16, the bw and iops could reach 1662MB/s and 425k
> on my platform.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/kyber-iosched.c | 240 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 212 insertions(+), 28 deletions(-)
> 
> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
> index 0d6d25e3..04da05b 100644
> --- a/block/kyber-iosched.c
> +++ b/block/kyber-iosched.c
> @@ -72,6 +72,15 @@ static const unsigned int kyber_batch_size[] = {
>  	[KYBER_OTHER] = 8,
>  };
>  
> +struct kyber_ctx_queue {
> +	/*
> +	 * Copied from blk_mq_ctx->index_hw
> +	 */
> +	unsigned int index;
> +	spinlock_t lock;
> +	struct list_head rq_list[KYBER_NUM_DOMAINS];
> +} ____cacheline_aligned_in_smp;
> +
>  struct kyber_queue_data {
>  	struct request_queue *q;
>  
> @@ -84,6 +93,7 @@ struct kyber_queue_data {
>  	 */
>  	struct sbitmap_queue domain_tokens[KYBER_NUM_DOMAINS];
>  
> +	struct kyber_ctx_queue *ctx_queue;
>  	/*
>  	 * Async request percentage, converted to per-word depth for
>  	 * sbitmap_get_shallow().
> @@ -99,6 +109,8 @@ struct kyber_hctx_data {
>  	struct list_head rqs[KYBER_NUM_DOMAINS];
>  	unsigned int cur_domain;
>  	unsigned int batching;
> +	struct kyber_ctx_queue **kcqs;
> +	struct sbitmap kcq_map[KYBER_NUM_DOMAINS];
>  	wait_queue_entry_t domain_wait[KYBER_NUM_DOMAINS];
>  	struct sbq_wait_state *domain_ws[KYBER_NUM_DOMAINS];
>  	atomic_t wait_index[KYBER_NUM_DOMAINS];
> @@ -284,6 +296,19 @@ static unsigned int kyber_sched_tags_shift(struct kyber_queue_data *kqd)
>  	return kqd->q->queue_hw_ctx[0]->sched_tags->bitmap_tags.sb.shift;
>  }
>  
> +static void kyber_ctx_queue_init(struct kyber_queue_data *kqd)
> +{
> +	unsigned int i, j;
> +
> +	for (i = 0; i < nr_cpu_ids; i++) {
> +		struct kyber_ctx_queue *kcq = &kqd->ctx_queue[i];
> +
> +		spin_lock_init(&kcq->lock);
> +		for (j = 0; j < KYBER_NUM_DOMAINS; j++)
> +			INIT_LIST_HEAD(&kcq->rq_list[j]);
> +	}
> +}
> +
>  static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
>  {
>  	struct kyber_queue_data *kqd;
> @@ -302,6 +327,13 @@ static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
>  	if (!kqd->cb)
>  		goto err_kqd;
>  
> +	kqd->ctx_queue = kmalloc_array_node(nr_cpu_ids,
> +			sizeof(struct kyber_ctx_queue), GFP_KERNEL, -1);

The whitespace here and in several other places is weird, please run
this through checkpatch.

> +	if (!kqd->ctx_queue)
> +		goto err_cb;
> +
> +	kyber_ctx_queue_init(kqd);
> +
>  	/*
>  	 * The maximum number of tokens for any scheduling domain is at least
>  	 * the queue depth of a single hardware queue. If the hardware doesn't
> @@ -318,7 +350,7 @@ static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
>  		if (ret) {
>  			while (--i >= 0)
>  				sbitmap_queue_free(&kqd->domain_tokens[i]);
> -			goto err_cb;
> +			goto err_kcq;
>  		}
>  		sbitmap_queue_resize(&kqd->domain_tokens[i], kyber_depth[i]);
>  	}
> @@ -331,6 +363,8 @@ static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
>  
>  	return kqd;
>  
> +err_kcq:
> +	kfree(kqd->ctx_queue);
>  err_cb:
>  	blk_stat_free_callback(kqd->cb);
>  err_kqd:
> @@ -372,6 +406,7 @@ static void kyber_exit_sched(struct elevator_queue *e)
>  
>  	for (i = 0; i < KYBER_NUM_DOMAINS; i++)
>  		sbitmap_queue_free(&kqd->domain_tokens[i]);
> +	kfree(kqd->ctx_queue);
>  	blk_stat_free_callback(kqd->cb);
>  	kfree(kqd);
>  }
> @@ -379,12 +414,33 @@ static void kyber_exit_sched(struct elevator_queue *e)
>  static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
>  {
>  	struct kyber_hctx_data *khd;
> +	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
>  	int i;
> +	int sd;
>  
>  	khd = kmalloc_node(sizeof(*khd), GFP_KERNEL, hctx->numa_node);
>  	if (!khd)
>  		return -ENOMEM;
>  
> +	khd->kcqs = kmalloc_array_node(nr_cpu_ids, sizeof(void *),
> +					GFP_KERNEL, hctx->numa_node);
> +	if (!khd->kcqs)
> +		goto err_khd;

Why the double indirection of a percpu allocation per hardware queue
here? With, say, 56 cpus and that many hardware queues, that's 3136
pointers, which seems like overkill. Can't you just use the percpu array
in the kqd directly, or make it per-hardware queue instead?

> +	sd = 0;
> +	for (i = 0; i < KYBER_NUM_DOMAINS; i++) {
> +		if (sbitmap_init_node(&khd->kcq_map[i], hctx->nr_ctx,
> +				ilog2(8), GFP_KERNEL, hctx->numa_node))
> +			goto err_kcq_map;
> +		sd++;
> +	}
> +	/*
> +	 * clone the mapping between hctx and ctx to khd and kcq
> +	 */
> +	for (i = 0; i < hctx->nr_ctx; i++) {
> +		khd->kcqs[i] = &kqd->ctx_queue[hctx->ctxs[i]->cpu];
> +		khd->kcqs[i]->index = i;
> +	}
>  	spin_lock_init(&khd->lock);
>  
>  	for (i = 0; i < KYBER_NUM_DOMAINS; i++) {
> @@ -402,10 +458,24 @@ static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
>  	hctx->sched_data = khd;
>  
>  	return 0;
> +
> +err_kcq_map:
> +	for (i = 0; i < sd; i++)
> +		sbitmap_free(&khd->kcq_map[i]);
> +	kfree(khd->kcqs);
> +err_khd:
> +	kfree(khd);
> +	return -ENOMEM;
>  }
>  
>  static void kyber_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
>  {
> +	struct kyber_hctx_data *khd = hctx->sched_data;
> +	int i;
> +
> +	for (i = 0; i < KYBER_NUM_DOMAINS; i++)
> +		sbitmap_free(&khd->kcq_map[i]);
> +	kfree(khd->kcqs);
>  	kfree(hctx->sched_data);
>  }
>  
> @@ -446,11 +516,95 @@ static void kyber_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
>  	}
>  }
>  
> +static int bio_sched_domain(const struct bio *bio)
> +{
> +	unsigned int op = bio->bi_opf;
> +
> +	if ((op & REQ_OP_MASK) == REQ_OP_READ)
> +		return KYBER_READ;
> +	else if ((op & REQ_OP_MASK) == REQ_OP_WRITE && op_is_sync(op))
> +		return KYBER_SYNC_WRITE;
> +	else
> +		return KYBER_OTHER;
> +}

Please add a common helper for rq_sched_domain() and bio_sched_domain()
instead of duplicating the logic.

> +/*
> + * Do limited merge trying here. Align with blk_mq_attempt_merge, reverse
> + * checking corresponding domain queue for 8 reqs.
> + */
> +static bool kyber_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio)
> +{
> +	struct request_queue *q = hctx->queue;
> +	struct kyber_hctx_data *khd = hctx->sched_data;
> +	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
> +	struct kyber_ctx_queue *kcq = khd->kcqs[ctx->index_hw];
> +	struct list_head *rq_list = &kcq->rq_list[bio_sched_domain(bio)];
> +	struct request *rq;
> +	int checked = 8;
> +	bool merged = false;
> +
> +	spin_lock(&kcq->lock);
> +	list_for_each_entry_reverse(rq, rq_list, queuelist) {
> +
> +		if (!checked--)
> +			break;
> +
> +		if (!blk_rq_merge_ok(rq, bio))
> +			continue;
> +
> +		switch (blk_try_merge(rq, bio)) {
> +		case ELEVATOR_BACK_MERGE:
> +			if (blk_mq_sched_allow_merge(q, rq, bio))
> +				merged = bio_attempt_back_merge(q, rq, bio);
> +			break;
> +		case ELEVATOR_FRONT_MERGE:
> +			if (blk_mq_sched_allow_merge(q, rq, bio))
> +				merged = bio_attempt_front_merge(q, rq, bio);
> +			break;
> +		case ELEVATOR_DISCARD_MERGE:
> +			merged = bio_attempt_discard_merge(q, rq, bio);
> +			break;
> +		default:
> +			continue;
> +		}
> +		if (merged)
> +			break;
> +	}
> +	spin_unlock(&kcq->lock);
> +	blk_mq_put_ctx(ctx);
> +
> +	return merged;
> +}
> +
>  static void kyber_prepare_request(struct request *rq, struct bio *bio)
>  {
>  	rq_set_domain_token(rq, -1);
>  }
>  
> +static void kyber_insert_requests(struct blk_mq_hw_ctx *hctx,
> +		struct list_head *rq_list, bool at_head)
> +{
> +	struct kyber_hctx_data *khd = hctx->sched_data;
> +	struct kyber_ctx_queue *kcq;
> +	struct request *rq, *next;
> +	struct list_head *head;
> +	unsigned int sched_domain;
> +
> +	list_for_each_entry_safe(rq, next, rq_list, queuelist) {
> +		sched_domain = rq_sched_domain(rq);
> +		kcq = khd->kcqs[rq->mq_ctx->index_hw];
> +		head = &kcq->rq_list[sched_domain];
> +		spin_lock(&kcq->lock);
> +		if (at_head)
> +			list_move(&rq->queuelist, head);
> +		else
> +			list_move_tail(&rq->queuelist, head);
> +		sbitmap_set_bit(&khd->kcq_map[sched_domain], kcq->index);
> +		blk_mq_sched_request_inserted(rq);
> +		spin_unlock(&kcq->lock);
> +	}
> +}
> +
>  static void kyber_finish_request(struct request *rq)
>  {
>  	struct kyber_queue_data *kqd = rq->q->elevator->elevator_data;
> @@ -495,19 +649,36 @@ static void kyber_completed_request(struct request *rq)
>  		blk_stat_activate_msecs(kqd->cb, 10);
>  }
>  
> -static void kyber_flush_busy_ctxs(struct kyber_hctx_data *khd,
> -				  struct blk_mq_hw_ctx *hctx)
> +struct flush_kcq_data {
> +	struct kyber_hctx_data *khd;
> +	unsigned int sched_domain;
> +	struct list_head *list;
> +};
> +
> +static bool flush_busy_kcq(struct sbitmap *sb, unsigned int bitnr, void *data)
>  {
> -	LIST_HEAD(rq_list);
> -	struct request *rq, *next;
> +	struct flush_kcq_data *flush_data = data;
> +	struct kyber_ctx_queue *kcq = flush_data->khd->kcqs[bitnr];
>  
> -	blk_mq_flush_busy_ctxs(hctx, &rq_list);
> -	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
> -		unsigned int sched_domain;
> +	spin_lock(&kcq->lock);
> +	list_splice_tail_init(&kcq->rq_list[flush_data->sched_domain],
> +			flush_data->list);
> +	sbitmap_clear_bit(sb, bitnr);
> +	spin_unlock(&kcq->lock);
>  
> -		sched_domain = rq_sched_domain(rq);
> -		list_move_tail(&rq->queuelist, &khd->rqs[sched_domain]);
> -	}
> +	return true;
> +}
> +
> +static void kyber_flush_busy_kcqs(struct kyber_hctx_data *khd,
> +		unsigned int sched_domain, struct list_head *list)
> +{
> +	struct flush_kcq_data data = {
> +		.khd = khd,
> +		.sched_domain = sched_domain,
> +		.list = list,
> +	};
> +
> +	sbitmap_for_each_set(&khd->kcq_map[sched_domain], flush_busy_kcq, &data);
>  }
>  
>  static int kyber_domain_wake(wait_queue_entry_t *wait, unsigned mode, int flags,
> @@ -570,26 +741,19 @@ static int kyber_get_domain_token(struct kyber_queue_data *kqd,
>  static struct request *
>  kyber_dispatch_cur_domain(struct kyber_queue_data *kqd,
>  			  struct kyber_hctx_data *khd,
> -			  struct blk_mq_hw_ctx *hctx,
> -			  bool *flushed)
> +			  struct blk_mq_hw_ctx *hctx)
>  {
>  	struct list_head *rqs;
>  	struct request *rq;
>  	int nr;
>  
>  	rqs = &khd->rqs[khd->cur_domain];
> -	rq = list_first_entry_or_null(rqs, struct request, queuelist);
>  
>  	/*
> -	 * If there wasn't already a pending request and we haven't flushed the
> -	 * software queues yet, flush the software queues and check again.
> +	 * If we do have cur_domain rqs on khd or kcq list, then try to require
> +	 * the token
>  	 */
> -	if (!rq && !*flushed) {
> -		kyber_flush_busy_ctxs(khd, hctx);
> -		*flushed = true;
> -		rq = list_first_entry_or_null(rqs, struct request, queuelist);
> -	}
> -
> +	rq = list_first_entry_or_null(rqs, struct request, queuelist);
>  	if (rq) {
>  		nr = kyber_get_domain_token(kqd, khd, hctx);
>  		if (nr >= 0) {
> @@ -598,8 +762,25 @@ kyber_dispatch_cur_domain(struct kyber_queue_data *kqd,
>  			list_del_init(&rq->queuelist);
>  			return rq;
>  		}
> +	} else if (sbitmap_any_bit_set(&khd->kcq_map[khd->cur_domain])) {
> +		nr = kyber_get_domain_token(kqd, khd, hctx);
> +		if (nr >= 0) {
> +			kyber_flush_busy_kcqs(khd, khd->cur_domain, rqs);
> +			rq = list_first_entry_or_null(rqs, struct request, queuelist);
> +			/*
> +			 * khd->lock and kcq->lock will ensure that, if kcq_map[cur_domain]
> +			 * is set, we must be able to get requests from the kcq
> +			 */
> +			khd->batching++;
> +			rq_set_domain_token(rq, nr);
> +			list_del_init(&rq->queuelist);
> +			return rq;
> +		}
> +		/*
> +		 * if not get domain token, the rqs could be left on kcqs to merged
> +		 * with following ios.
> +		 */
>  	}
> -
>  	/* There were either no pending requests or no tokens. */
>  	return NULL;
>  }
> @@ -608,7 +789,6 @@ static struct request *kyber_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
>  	struct kyber_hctx_data *khd = hctx->sched_data;
> -	bool flushed = false;
>  	struct request *rq;
>  	int i;
>  
> @@ -619,7 +799,7 @@ static struct request *kyber_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  	 * from the batch.
>  	 */
>  	if (khd->batching < kyber_batch_size[khd->cur_domain]) {
> -		rq = kyber_dispatch_cur_domain(kqd, khd, hctx, &flushed);
> +		rq = kyber_dispatch_cur_domain(kqd, khd, hctx);
>  		if (rq)
>  			goto out;
>  	}
> @@ -640,7 +820,7 @@ static struct request *kyber_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  		else
>  			khd->cur_domain++;
>  
> -		rq = kyber_dispatch_cur_domain(kqd, khd, hctx, &flushed);
> +		rq = kyber_dispatch_cur_domain(kqd, khd, hctx);
>  		if (rq)
>  			goto out;
>  	}
> @@ -657,10 +837,12 @@ static bool kyber_has_work(struct blk_mq_hw_ctx *hctx)
>  	int i;
>  
>  	for (i = 0; i < KYBER_NUM_DOMAINS; i++) {
> -		if (!list_empty_careful(&khd->rqs[i]))
> +		if (!list_empty_careful(&khd->rqs[i]) ||
> +				sbitmap_any_bit_set(&khd->kcq_map[i]))

More weird whitespace.

>  			return true;
>  	}
> -	return sbitmap_any_bit_set(&hctx->ctx_map);
> +
> +	return false;
>  }
>  
>  #define KYBER_LAT_SHOW_STORE(op)					\
> @@ -831,7 +1013,9 @@ static struct elevator_type kyber_sched = {
>  		.init_hctx = kyber_init_hctx,
>  		.exit_hctx = kyber_exit_hctx,
>  		.limit_depth = kyber_limit_depth,
> +		.bio_merge = kyber_bio_merge,
>  		.prepare_request = kyber_prepare_request,
> +		.insert_requests = kyber_insert_requests,
>  		.finish_request = kyber_finish_request,
>  		.requeue_request = kyber_finish_request,
>  		.completed_request = kyber_completed_request,
> -- 
> 2.7.4
> 
