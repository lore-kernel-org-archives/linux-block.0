Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970B8C5B57D
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 02:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7039C21721
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 02:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfGCCp4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:45:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbfGCCp4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jul 2019 22:45:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4C693082E44;
        Wed,  3 Jul 2019 02:45:50 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C376D7E56B;
        Wed,  3 Jul 2019 02:45:28 +0000 (UTC)
Date:   Wed, 3 Jul 2019 10:45:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 1/2] blk-mq: Remove blk_mq_put_ctx()
Message-ID: <20190703024513.GA30102@ming.t460p>
References: <20190701154730.203795-1-bvanassche@acm.org>
 <20190701154730.203795-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701154730.203795-2-bvanassche@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 03 Jul 2019 02:45:56 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 01, 2019 at 08:47:29AM -0700, Bart Van Assche wrote:
> No code that occurs between blk_mq_get_ctx() and blk_mq_put_ctx() depends
> on preemption being disabled for its correctness. Since removing the CPU
> preemption calls does not measurably affect performance, simplify the
> blk-mq code by removing the blk_mq_put_ctx() function and also by not
> disabling preemption in blk_mq_get_ctx().
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq-sched.c  |  5 +----
>  block/blk-mq-tag.c    |  8 --------
>  block/blk-mq.c        | 16 +++-------------
>  block/blk-mq.h        |  7 +------
>  block/kyber-iosched.c |  1 -
>  5 files changed, 5 insertions(+), 32 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 956a7aa9a637..c9d183d6c499 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -330,10 +330,8 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
>  	bool ret = false;
>  	enum hctx_type type;
>  
> -	if (e && e->type->ops.bio_merge) {
> -		blk_mq_put_ctx(ctx);
> +	if (e && e->type->ops.bio_merge)
>  		return e->type->ops.bio_merge(hctx, bio, nr_segs);
> -	}
>  
>  	type = hctx->type;
>  	if ((hctx->flags & BLK_MQ_F_SHOULD_MERGE) &&
> @@ -344,7 +342,6 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
>  		spin_unlock(&ctx->lock);
>  	}
>  
> -	blk_mq_put_ctx(ctx);
>  	return ret;
>  }
>  
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 7513c8eaabee..da19f0bc8876 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -113,7 +113,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>  	struct sbq_wait_state *ws;
>  	DEFINE_SBQ_WAIT(wait);
>  	unsigned int tag_offset;
> -	bool drop_ctx;
>  	int tag;
>  
>  	if (data->flags & BLK_MQ_REQ_RESERVED) {
> @@ -136,7 +135,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>  		return BLK_MQ_TAG_FAIL;
>  
>  	ws = bt_wait_ptr(bt, data->hctx);
> -	drop_ctx = data->ctx == NULL;
>  	do {
>  		struct sbitmap_queue *bt_prev;
>  
> @@ -161,9 +159,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>  		if (tag != -1)
>  			break;
>  
> -		if (data->ctx)
> -			blk_mq_put_ctx(data->ctx);
> -
>  		bt_prev = bt;
>  		io_schedule();
>  
> @@ -189,9 +184,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>  		ws = bt_wait_ptr(bt, data->hctx);
>  	} while (1);
>  
> -	if (drop_ctx && data->ctx)
> -		blk_mq_put_ctx(data->ctx);
> -
>  	sbitmap_finish_wait(bt, ws, &wait);
>  
>  found_tag:
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2f0b14d2ecdc..4d661545ad1d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -359,13 +359,13 @@ static struct request *blk_mq_get_request(struct request_queue *q,
>  	struct elevator_queue *e = q->elevator;
>  	struct request *rq;
>  	unsigned int tag;
> -	bool put_ctx_on_error = false;
> +	bool clear_ctx_on_error = false;
>  
>  	blk_queue_enter_live(q);
>  	data->q = q;
>  	if (likely(!data->ctx)) {
>  		data->ctx = blk_mq_get_ctx(q);
> -		put_ctx_on_error = true;
> +		clear_ctx_on_error = true;
>  	}
>  	if (likely(!data->hctx))
>  		data->hctx = blk_mq_map_queue(q, data->cmd_flags,
> @@ -391,10 +391,8 @@ static struct request *blk_mq_get_request(struct request_queue *q,
>  
>  	tag = blk_mq_get_tag(data);
>  	if (tag == BLK_MQ_TAG_FAIL) {
> -		if (put_ctx_on_error) {
> -			blk_mq_put_ctx(data->ctx);
> +		if (clear_ctx_on_error)
>  			data->ctx = NULL;
> -		}
>  		blk_queue_exit(q);
>  		return NULL;
>  	}
> @@ -431,8 +429,6 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
>  	if (!rq)
>  		return ERR_PTR(-EWOULDBLOCK);
>  
> -	blk_mq_put_ctx(alloc_data.ctx);
> -
>  	rq->__data_len = 0;
>  	rq->__sector = (sector_t) -1;
>  	rq->bio = rq->biotail = NULL;
> @@ -1981,7 +1977,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  
>  	plug = current->plug;
>  	if (unlikely(is_flush_fua)) {
> -		blk_mq_put_ctx(data.ctx);
>  		blk_mq_bio_to_request(rq, bio, nr_segs);
>  
>  		/* bypass scheduler for flush rq */
> @@ -1995,7 +1990,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  		unsigned int request_count = plug->rq_count;
>  		struct request *last = NULL;
>  
> -		blk_mq_put_ctx(data.ctx);
>  		blk_mq_bio_to_request(rq, bio, nr_segs);
>  
>  		if (!request_count)
> @@ -2029,8 +2023,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  		blk_add_rq_to_plug(plug, rq);
>  		trace_block_plug(q);
>  
> -		blk_mq_put_ctx(data.ctx);
> -
>  		if (same_queue_rq) {
>  			data.hctx = same_queue_rq->mq_hctx;
>  			trace_block_unplug(q, 1, true);
> @@ -2039,11 +2031,9 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  		}
>  	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
>  			!data.hctx->dispatch_busy)) {
> -		blk_mq_put_ctx(data.ctx);
>  		blk_mq_bio_to_request(rq, bio, nr_segs);
>  		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
>  	} else {
> -		blk_mq_put_ctx(data.ctx);
>  		blk_mq_bio_to_request(rq, bio, nr_segs);
>  		blk_mq_sched_insert_request(rq, false, true, true);
>  	}
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 633a5a77ee8b..f4bf5161333e 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -151,12 +151,7 @@ static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
>   */
>  static inline struct blk_mq_ctx *blk_mq_get_ctx(struct request_queue *q)
>  {
> -	return __blk_mq_get_ctx(q, get_cpu());
> -}
> -
> -static inline void blk_mq_put_ctx(struct blk_mq_ctx *ctx)
> -{
> -	put_cpu();
> +	return __blk_mq_get_ctx(q, raw_smp_processor_id());
>  }

Then there isn't any difference between __blk_mq_get_ctx() and blk_mq_get_ctx(),
so could you kill __blk_mq_get_ctx()?

Otherwise, looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
