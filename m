Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C205C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB3B61183
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhJTGSn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 02:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJTGSn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 02:18:43 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756D9C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 23:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LtTm0t1GqMOfM3hJjN1fnNIEHLtCmCms34Sb7OxloWs=; b=xh3908WLfieShSKcQQ4JVX6sIC
        F4NTWoXldKcm9wAj7+WgTiN8ynoDj250WwHK6VFJauZQ5Mw6UfdlWqpceBb2ZlYBeKvcy8DYzOZpe
        4l/fyXdkdpFLW5U+CdXNBZdrCLG/FqmD8oAr7HY3JE3FwZIlU4Ti1jEg6NxVPaujY4K7MPfuZowqF
        53O1oUnWCyMI5/CV4mjczdRjAbzRIN6B56SovyM7ENVRKpCLxILjc/hE2O+FtXVCeyklwEXGsjy6O
        H/CVeZpXWTPxUWlpQwx3VDAjhcEn3PkNcGg6NdbMLHlbbTGobla2QiiypNBd8QApWCGEus86zo+LO
        ei1/Hyuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md4tp-003Sxi-59; Wed, 20 Oct 2021 06:16:29 +0000
Date:   Tue, 19 Oct 2021 23:16:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 06/16] block: clean up blk_mq_submit_bio() merging
Message-ID: <YW+0Pf9jBG5JtjQY@infradead.org>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <4772d0d2111972ed5db4bc667e68e7416f809b57.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4772d0d2111972ed5db4bc667e68e7416f809b57.1634676157.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 10:24:15PM +0100, Pavel Begunkov wrote:
> Combine blk_mq_sched_bio_merge() and blk_attempt_plug_merge() under a
> common if, so we don't check it twice. Also honor bio_mergeable() for
> blk_mq_sched_bio_merge().
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  block/blk-mq-sched.c |  2 +-
>  block/blk-mq-sched.h | 12 +-----------
>  block/blk-mq.c       | 13 +++++++------
>  3 files changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index e85b7556b096..5b259fdea794 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -361,7 +361,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  	}
>  }
>  
> -bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
> +bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
>  		unsigned int nr_segs)
>  {
>  	struct elevator_queue *e = q->elevator;
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index 98836106b25f..25d1034952b6 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -12,7 +12,7 @@ void blk_mq_sched_assign_ioc(struct request *rq);
>  
>  bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
>  		unsigned int nr_segs, struct request **merged_request);
> -bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
> +bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
>  		unsigned int nr_segs);
>  bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
>  				   struct list_head *free);
> @@ -42,16 +42,6 @@ static inline bool bio_mergeable(struct bio *bio)
>  	return !(bio->bi_opf & REQ_NOMERGE_FLAGS);
>  }
>  
> -static inline bool
> -blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
> -		unsigned int nr_segs)
> -{
> -	if (blk_queue_nomerges(q) || !bio_mergeable(bio))
> -		return false;
> -
> -	return __blk_mq_sched_bio_merge(q, bio, nr_segs);
> -}
> -
>  static inline bool
>  blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
>  			 struct bio *bio)
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index bab1fccda6ca..218bfaa98591 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2482,12 +2482,13 @@ void blk_mq_submit_bio(struct bio *bio)
>  	if (!bio_integrity_prep(bio))
>  		goto queue_exit;
>  
> -	if (!is_flush_fua && !blk_queue_nomerges(q) &&
> -	    blk_attempt_plug_merge(q, bio, nr_segs, &same_queue_rq))
> -		goto queue_exit;
> -
> -	if (blk_mq_sched_bio_merge(q, bio, nr_segs))
> -		goto queue_exit;
> +	if (!blk_queue_nomerges(q) && bio_mergeable(bio)) {

bio_mergeable just checks REQ_NOMERGE_FLAGS, which includes
REQ_PREFLUSH and REQ_FUA...

> +		if (!is_flush_fua &&

... so this is not needed.
