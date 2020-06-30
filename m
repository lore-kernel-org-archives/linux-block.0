Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCFCC433DF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 06:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1F320759
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 06:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbgF3G0O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:26:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:55068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgF3G0O (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 02:26:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E1F99AAC3;
        Tue, 30 Jun 2020 06:26:12 +0000 (UTC)
Subject: Re: [PATCH 3/3] blk-mq: centralise related handling into
 blk_mq_get_driver_tag
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20200630022356.2149607-1-ming.lei@redhat.com>
 <20200630022356.2149607-4-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <49f8b5f5-e437-3bb7-ae5d-06f59fea5cfe@suse.de>
Date:   Tue, 30 Jun 2020 08:26:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630022356.2149607-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/20 4:23 AM, Ming Lei wrote:
> Move blk_mq_tag_busy(), .nr_active update and request assignment into
> blk_mq_get_driver_tag(), all are good to do during getting driver tag.
> 
> Meantime blk-flush related code is simplified and flush request needn't
> to update the request table manually any more.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-flush.c  | 13 ++++---------
>   block/blk-mq-tag.h | 12 ------------
>   block/blk-mq.c     | 33 +++++++++++++--------------------
>   block/blk.h        |  5 -----
>   4 files changed, 17 insertions(+), 46 deletions(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 21108a550fbf..3b0c5cfe922a 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -236,12 +236,10 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
>   		error = fq->rq_status;
>   
>   	hctx = flush_rq->mq_hctx;
> -	if (!q->elevator) {
> -		blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
> +	if (!q->elevator)
>   		flush_rq->tag = -1;
> -	} else {
> +	else
>   		flush_rq->internal_tag = -1;
> -	}
>   
>   	running = &fq->flush_queue[fq->flush_running_idx];
>   	BUG_ON(fq->flush_pending_idx == fq->flush_running_idx);
> @@ -315,13 +313,10 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
>   	flush_rq->mq_ctx = first_rq->mq_ctx;
>   	flush_rq->mq_hctx = first_rq->mq_hctx;
>   
> -	if (!q->elevator) {
> -		fq->orig_rq = first_rq;
> +	if (!q->elevator)
>   		flush_rq->tag = first_rq->tag;
> -		blk_mq_tag_set_rq(flush_rq->mq_hctx, first_rq->tag, flush_rq);
> -	} else {
> +	else
>   		flush_rq->internal_tag = first_rq->internal_tag;
> -	}
>   
>   	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
>   	flush_rq->cmd_flags |= (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index 3945c7f5b944..b1acac518c4e 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -101,18 +101,6 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
>   	return atomic_read(&hctx->nr_active) < depth;
>   }
>   
> -/*
> - * This helper should only be used for flush request to share tag
> - * with the request cloned from, and both the two requests can't be
> - * in flight at the same time. The caller has to make sure the tag
> - * can't be freed.
> - */
> -static inline void blk_mq_tag_set_rq(struct blk_mq_hw_ctx *hctx,
> -		unsigned int tag, struct request *rq)
> -{
> -	hctx->tags->rqs[tag] = rq;
> -}
> -
>   static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
>   					  unsigned int tag)
>   {
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index cabeeeb3d56c..44b101757d33 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -277,26 +277,20 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>   {
>   	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
>   	struct request *rq = tags->static_rqs[tag];
> -	req_flags_t rq_flags = 0;
>   
>   	if (data->flags & BLK_MQ_REQ_INTERNAL) {
>   		rq->tag = BLK_MQ_NO_TAG;
>   		rq->internal_tag = tag;
>   	} else {
> -		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
> -			rq_flags = RQF_MQ_INFLIGHT;
> -			atomic_inc(&data->hctx->nr_active);
> -		}
>   		rq->tag = tag;
>   		rq->internal_tag = BLK_MQ_NO_TAG;
> -		data->hctx->tags->rqs[rq->tag] = rq;
>   	}
>   
>   	/* csd/requeue_work/fifo_time is initialized before use */
>   	rq->q = data->q;
>   	rq->mq_ctx = data->ctx;
>   	rq->mq_hctx = data->hctx;
> -	rq->rq_flags = rq_flags;
> +	rq->rq_flags = 0;
>   	rq->cmd_flags = data->cmd_flags;
>   	if (data->flags & BLK_MQ_REQ_PREEMPT)
>   		rq->rq_flags |= RQF_PREEMPT;
> @@ -380,8 +374,6 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
>   retry:
>   	data->ctx = blk_mq_get_ctx(q);
>   	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
> -	if (!(data->flags & BLK_MQ_REQ_INTERNAL))
> -		blk_mq_tag_busy(data->hctx);
>   
>   	/*
>   	 * Waiting allocations only fail because of an inactive hctx.  In that
> @@ -478,8 +470,6 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>   
>   	if (q->elevator)
>   		data.flags |= BLK_MQ_REQ_INTERNAL;
> -	else
> -		blk_mq_tag_busy(data.hctx);
>   
>   	ret = -EWOULDBLOCK;
>   	tag = blk_mq_get_tag(&data);
> @@ -1131,7 +1121,6 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
>   {
>   	struct sbitmap_queue *bt = &rq->mq_hctx->tags->bitmap_tags;
>   	unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
> -	bool shared = blk_mq_tag_busy(rq->mq_hctx);
>   	int tag;
>   
>   	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
> @@ -1146,19 +1135,23 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
>   		return false;
>   
>   	rq->tag = tag + tag_offset;
> -	if (shared) {
> -		rq->rq_flags |= RQF_MQ_INFLIGHT;
> -		atomic_inc(&rq->mq_hctx->nr_active);
> -	}
> -	rq->mq_hctx->tags->rqs[rq->tag] = rq;
>   	return true;
>   }
>   
>   static bool blk_mq_get_driver_tag(struct request *rq)
>   {
> -	if (rq->tag != BLK_MQ_NO_TAG)
> -		return true;
> -	return __blk_mq_get_driver_tag(rq);
> +	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> +	bool shared = blk_mq_tag_busy(rq->mq_hctx);
> +
> +	if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_get_driver_tag(rq))
> +		return false;
> +
> +	if (shared) {
> +		rq->rq_flags |= RQF_MQ_INFLIGHT;
> +		atomic_inc(&hctx->nr_active);
> +	}
> +	hctx->tags->rqs[rq->tag] = rq;
> +	return true;
>   }
>   
>   static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
> diff --git a/block/blk.h b/block/blk.h
> index 3a120a070dac..459790f9783d 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -25,11 +25,6 @@ struct blk_flush_queue {
>   	struct list_head	flush_data_in_flight;
>   	struct request		*flush_rq;
>   
> -	/*
> -	 * flush_rq shares tag with this rq, both can't be active
> -	 * at the same time
> -	 */
> -	struct request		*orig_rq;
>   	struct lock_class_key	key;
>   	spinlock_t		mq_flush_lock;
>   };
> 
Can you give some more explanation why it's safe to move 
blk_mq_tag_busy() into blk_mq_get_driver_tag(), seeing that it was 
called before blk_mq_get_tag() initially?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
