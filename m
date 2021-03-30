Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5EFC433C1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 03:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A5061929
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 03:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhC3Dye (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Mar 2021 23:54:34 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:41117 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229630AbhC3DyX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 23:54:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UTodFWf_1617076447;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UTodFWf_1617076447)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 30 Mar 2021 11:54:08 +0800
Subject: Re: [PATCH V4 03/12] block: create io poll context for submission and
 poll task
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Hannes Reinecke <hare@suse.de>
References: <20210329152622.173035-1-ming.lei@redhat.com>
 <20210329152622.173035-4-ming.lei@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <75de97c3-c41e-9f5c-e6fe-da6c4711dca2@linux.alibaba.com>
Date:   Tue, 30 Mar 2021 11:54:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210329152622.173035-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/29/21 11:26 PM, Ming Lei wrote:
> Create per-task io poll context for both IO submission and poll task
> if the queue is bio based and supports polling.
> 
> This io polling context includes two queues:
> 
> 1) submission queue(sq) for storing HIPRI bio, written by submission task
>    and read by poll task.
> 2) polling queue(pq) for holding data moved from sq, only used in poll
>    context for running bio polling.
> 
> Following patches will support bio based io polling.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>


> ---
>  block/blk-core.c          | 79 +++++++++++++++++++++++++++++++++------
>  block/blk-ioc.c           |  1 +
>  block/blk-mq.c            | 14 +++++++
>  block/blk.h               | 38 +++++++++++++++++++
>  include/linux/iocontext.h |  2 +
>  5 files changed, 123 insertions(+), 11 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index a31371d55b9d..8a21a8c010a6 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -792,6 +792,61 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>  	return BLK_STS_OK;
>  }
>  
> +static inline struct blk_bio_poll_ctx *blk_get_bio_poll_ctx(void)
> +{
> +	struct io_context *ioc = current->io_context;
> +
> +	return ioc ? ioc->data : NULL;
> +}
> +
> +static inline unsigned int bio_grp_list_size(unsigned int nr_grps)
> +{
> +	return sizeof(struct bio_grp_list) + nr_grps *
> +		sizeof(struct bio_grp_list_data);
> +}
> +
> +static void bio_poll_ctx_init(struct blk_bio_poll_ctx *pc)
> +{
> +	pc->sq = (void *)pc + sizeof(*pc);
> +	pc->sq->max_nr_grps = BLK_BIO_POLL_SQ_SZ;
> +
> +	pc->pq = (void *)pc->sq + bio_grp_list_size(BLK_BIO_POLL_SQ_SZ);
> +	pc->pq->max_nr_grps = BLK_BIO_POLL_PQ_SZ;
> +
> +	spin_lock_init(&pc->sq_lock);
> +	spin_lock_init(&pc->pq_lock);
> +}
> +
> +void bio_poll_ctx_alloc(struct io_context *ioc)
> +{
> +	struct blk_bio_poll_ctx *pc;
> +	unsigned int size = sizeof(*pc) +
> +		bio_grp_list_size(BLK_BIO_POLL_SQ_SZ) +
> +		bio_grp_list_size(BLK_BIO_POLL_PQ_SZ);
> +
> +	pc = kzalloc(GFP_ATOMIC, size);
> +	if (pc) {
> +		bio_poll_ctx_init(pc);
> +		if (cmpxchg(&ioc->data, NULL, (void *)pc))
> +			kfree(pc);
> +	}
> +}
> +
> +static inline bool blk_queue_support_bio_poll(struct request_queue *q)
> +{
> +	return !queue_is_mq(q) && blk_queue_poll(q);
> +}
> +
> +static inline void blk_bio_poll_preprocess(struct request_queue *q,
> +		struct bio *bio)
> +{
> +	if (!(bio->bi_opf & REQ_HIPRI))
> +		return;
> +
> +	if (!blk_queue_poll(q) || (!queue_is_mq(q) && !blk_get_bio_poll_ctx()))
> +		bio->bi_opf &= ~REQ_HIPRI;
> +}
> +
>  static noinline_for_stack bool submit_bio_checks(struct bio *bio)
>  {
>  	struct block_device *bdev = bio->bi_bdev;
> @@ -836,8 +891,19 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
>  		}
>  	}
>  
> -	if (!blk_queue_poll(q))
> -		bio->bi_opf &= ~REQ_HIPRI;
> +	/*
> +	 * Various block parts want %current->io_context, so allocate it up
> +	 * front rather than dealing with lots of pain to allocate it only
> +	 * where needed. This may fail and the block layer knows how to live
> +	 * with it.
> +	 */
> +	if (unlikely(!current->io_context))
> +		create_task_io_context(current, GFP_ATOMIC, q->node);
> +
> +	if (blk_queue_support_bio_poll(q) && (bio->bi_opf & REQ_HIPRI))
> +		blk_create_io_poll_context(q);
> +
> +	blk_bio_poll_preprocess(q, bio);
>  
>  	switch (bio_op(bio)) {
>  	case REQ_OP_DISCARD:
> @@ -876,15 +942,6 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
>  		break;
>  	}
>  
> -	/*
> -	 * Various block parts want %current->io_context, so allocate it up
> -	 * front rather than dealing with lots of pain to allocate it only
> -	 * where needed. This may fail and the block layer knows how to live
> -	 * with it.
> -	 */
> -	if (unlikely(!current->io_context))
> -		create_task_io_context(current, GFP_ATOMIC, q->node);
> -
>  	if (blk_throtl_bio(bio)) {
>  		blkcg_bio_issue_init(bio);
>  		return false;
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index b0cde18c4b8c..5574c398eff6 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -19,6 +19,7 @@ static struct kmem_cache *iocontext_cachep;
>  
>  static inline void free_io_context(struct io_context *ioc)
>  {
> +	kfree(ioc->data);
>  	kmem_cache_free(iocontext_cachep, ioc);
>  }
>  
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 63c81df3b8b5..1ada2c0e76b1 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3852,6 +3852,17 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
>  	return blk_mq_poll_hybrid_sleep(q, rq);
>  }
>  
> +static int blk_bio_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
> +{
> +	/*
> +	 * Create poll queue for storing poll bio and its cookie from
> +	 * submission queue
> +	 */
> +	blk_create_io_poll_context(q);
> +
> +	return 0;
> +}
> +
>  /**
>   * blk_poll - poll for IO completions
>   * @q:  the queue
> @@ -3875,6 +3886,9 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
>  	if (current->plug)
>  		blk_flush_plug_list(current->plug, false);
>  
> +	if (!queue_is_mq(q))
> +		return blk_bio_poll(q, cookie, spin);
> +
>  	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
>  
>  	/*
> diff --git a/block/blk.h b/block/blk.h
> index 3b53e44b967e..35901cee709d 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -357,4 +357,42 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
>  		struct page *page, unsigned int len, unsigned int offset,
>  		unsigned int max_sectors, bool *same_page);
>  
> +/* Grouping bios that share same data into one list */
> +struct bio_grp_list_data {
> +	void *grp_data;
> +
> +	/* all bios in this list share same 'grp_data' */
> +	struct bio_list list;
> +};
> +
> +struct bio_grp_list {
> +	unsigned int max_nr_grps, nr_grps;
> +	struct bio_grp_list_data head[0];
> +};
> +
> +struct blk_bio_poll_ctx {
> +	spinlock_t sq_lock;
> +	struct bio_grp_list *sq;
> +
> +	spinlock_t pq_lock;
> +	struct bio_grp_list *pq;
> +};
> +
> +#define BLK_BIO_POLL_SQ_SZ		16U
> +#define BLK_BIO_POLL_PQ_SZ		(BLK_BIO_POLL_SQ_SZ * 2)
> +
> +void bio_poll_ctx_alloc(struct io_context *ioc);
> +
> +static inline void blk_create_io_poll_context(struct request_queue *q)
> +{
> +	struct io_context *ioc;
> +
> +	if (unlikely(!current->io_context))
> +		create_task_io_context(current, GFP_ATOMIC, q->node);
> +
> +	ioc = current->io_context;
> +	if (unlikely(ioc && !ioc->data))
> +		bio_poll_ctx_alloc(ioc);
> +}
> +
>  #endif /* BLK_INTERNAL_H */
> diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
> index 0a9dc40b7be8..f9a467571356 100644
> --- a/include/linux/iocontext.h
> +++ b/include/linux/iocontext.h
> @@ -110,6 +110,8 @@ struct io_context {
>  	struct io_cq __rcu	*icq_hint;
>  	struct hlist_head	icq_list;
>  
> +	void			*data;
> +
>  	struct work_struct release_work;
>  };
>  
> 

-- 
Thanks,
Jeffle
