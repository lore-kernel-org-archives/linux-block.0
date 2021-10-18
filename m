Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100F5C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 10:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A4B60F9E
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 10:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhJRKUm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 06:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhJRKUm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 06:20:42 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B71C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 03:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jbhwA6EBPlH81OqXHFgdzJUyxZT53zx8oI1DYE27aFc=; b=DPX5eNPu4k4ADNwaWAEPV6azy8
        9JxFbp2OwVW7RY3bb5dFJXCVyYV38zcfQh2+/8Pvru5fNYEMJe9xNF/+WpLbs6BztiiQd0iksvUJN
        vloaAge3Q8PG5fNEJyZKY5/eDPbTannTTCLjjQ4umfRDl4Uii1T1+lGsNp5y53KlZbyvwC+0c1B9F
        tIsy3wFk+WymixswRqY5Ar5WBtVFcUVMOSChx5np5VbnWxpHuT6wKYtDbbm9KRc+lNfO1JLshZRlk
        viPFOU0N1Bzpwd1pu8gU9eMfseu3uRmNWofCVetzA8QJd2iWYyHkxe20ItkSkvXC5EMlp99RdiwTh
        Gv8UkT5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcPix-00Exq6-80; Mon, 18 Oct 2021 10:18:31 +0000
Date:   Mon, 18 Oct 2021 03:18:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 3/6] block: add support for blk_mq_end_request_batch()
Message-ID: <YW1J92MfyiNZ/wuI@infradead.org>
References: <20211017020623.77815-1-axboe@kernel.dk>
 <20211017020623.77815-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017020623.77815-4-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 16, 2021 at 08:06:20PM -0600, Jens Axboe wrote:
> Instead of calling blk_mq_end_request() on a single request, add a helper
> that takes the new struct io_comp_batch and completes any request stored
> in there.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq-tag.c     |  6 ++++
>  block/blk-mq-tag.h     |  1 +
>  block/blk-mq.c         | 81 ++++++++++++++++++++++++++++++++----------
>  include/linux/blk-mq.h | 29 +++++++++++++++
>  4 files changed, 98 insertions(+), 19 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index c43b97201161..b94c3e8ef392 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -207,6 +207,12 @@ void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
>  	}
>  }
>  
> +void blk_mq_put_tags(struct blk_mq_tags *tags, int *tag_array, int nr_tags)
> +{
> +	sbitmap_queue_clear_batch(&tags->bitmap_tags, tags->nr_reserved_tags,
> +					tag_array, nr_tags);
> +}
> +
>  struct bt_iter_data {
>  	struct blk_mq_hw_ctx *hctx;
>  	busy_iter_fn *fn;
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index e617c7220626..df787b5a23bd 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -19,6 +19,7 @@ unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
>  			      unsigned int *offset);
>  extern void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
>  			   unsigned int tag);
> +void blk_mq_put_tags(struct blk_mq_tags *tags, int *tag_array, int nr_tags);
>  extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>  					struct blk_mq_tags **tags,
>  					unsigned int depth, bool can_grow);
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8eb80e70e8ea..58dc0c0c24ac 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -292,15 +292,6 @@ void blk_mq_wake_waiters(struct request_queue *q)
>  			blk_mq_tag_wakeup_all(hctx->tags, true);
>  }
>  
> -/*
> - * Only need start/end time stamping if we have iostat or
> - * blk stats enabled, or using an IO scheduler.
> - */
> -static inline bool blk_mq_need_time_stamp(struct request *rq)
> -{
> -	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_ELV));
> -}
> -
>  static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  		unsigned int tag, u64 alloc_time_ns)
>  {
> @@ -754,19 +745,21 @@ bool blk_update_request(struct request *req, blk_status_t error,
>  }
>  EXPORT_SYMBOL_GPL(blk_update_request);
>  
> -inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
> +static inline void __blk_mq_end_request_acct(struct request *rq, u64 now)
>  {
> -	if (blk_mq_need_time_stamp(rq)) {
> -		u64 now = ktime_get_ns();
> +	if (rq->rq_flags & RQF_STATS) {
> +		blk_mq_poll_stats_start(rq->q);
> +		blk_stat_add(rq, now);
> +	}
>  
> +	blk_mq_sched_completed_request(rq, now);
> +	blk_account_io_done(rq, now);
> +}
>  
> -		blk_mq_sched_completed_request(rq, now);
> -		blk_account_io_done(rq, now);
> -	}
> +inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
> +{
> +	if (blk_mq_need_time_stamp(rq))
> +		__blk_mq_end_request_acct(rq, ktime_get_ns());
>  
>  	if (rq->end_io) {
>  		rq_qos_done(rq->q, rq);
> @@ -785,6 +778,56 @@ void blk_mq_end_request(struct request *rq, blk_status_t error)
>  }
>  EXPORT_SYMBOL(blk_mq_end_request);
>  
> +#define TAG_COMP_BATCH		32
> +
> +static inline void blk_mq_flush_tag_batch(struct blk_mq_hw_ctx *hctx,
> +					  int *tag_array, int nr_tags)
> +{
> +	struct request_queue *q = hctx->queue;
> +
> +	blk_mq_put_tags(hctx->tags, tag_array, nr_tags);
> +	percpu_ref_put_many(&q->q_usage_counter, nr_tags);
> +}
> +
> +void blk_mq_end_request_batch(struct io_comp_batch *iob)
> +{
> +	int tags[TAG_COMP_BATCH], nr_tags = 0;
> +	struct blk_mq_hw_ctx *last_hctx = NULL;
> +	struct request *rq;
> +	u64 now = 0;
> +
> +	if (iob->need_ts)
> +		now = ktime_get_ns();
> +
> +	while ((rq = rq_list_pop(&iob->req_list)) != NULL) {
> +		prefetch(rq->bio);
> +		prefetch(rq->rq_next);
> +
> +		blk_update_request(rq, BLK_STS_OK, blk_rq_bytes(rq));
> +		__blk_mq_end_request_acct(rq, now);

If iob->need_ts is not set we don't need to call
__blk_mq_end_request_acct, do we?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
