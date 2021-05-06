Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DA4C433B4
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 07:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15DD61168
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 07:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhEFHOg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 03:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhEFHOf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 03:14:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F34C061574
        for <linux-block@vger.kernel.org>; Thu,  6 May 2021 00:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3WpNmxQwm8YEJtgI4+wy/RzcondEnH2K1zl9C0ABFDA=; b=T6FXzjVdZObA9hxThE83HEt2Ho
        tk/ufK1e+pVsrvJM38z5SVC1XdFE1neMKp6tvDOOb2P42GIBey49dHcJZwz51kjl+fjGH55Jb9IHe
        xjhI/3rIOtnCy8yiR7maNsuVk/4Aygc0lHPWrMLqvPCftrW2MdWGqGlTDoSWy+SCI0D0Ad6jNuZj0
        LV2X37ehACXbz823jtOdZEI95dh+2Fns9R9Y96aH47Wkvztfx3ybc1sFUL764jE91F2Fu1001PMFj
        5MOi2+jQhx5oCmHwX2OdfTqJnMPcLKWTVH23XxiN3abfLG6j0kK6bfoO7tG0hZiXk84Lyy60gIqI5
        R7jB20uA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leYBs-001Pek-1L; Thu, 06 May 2021 07:12:58 +0000
Date:   Thu, 6 May 2021 08:12:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V5 3/4] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
Message-ID: <20210506071256.GD328487@infradead.org>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505145855.174127-4-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 05, 2021 at 10:58:54PM +0800, Ming Lei wrote:
> refcount_inc_not_zero() in bt_tags_iter() still may read one freed
> request.
> 
> Fix the issue by the following approach:
> 
> 1) hold a per-tags spinlock when reading ->rqs[tag] and calling
> refcount_inc_not_zero in bt_tags_iter()
> 
> 2) clearing stale request referred via ->rqs[tag] before freeing
> request pool, the per-tags spinlock is held for clearing stale
> ->rq[tag]
> 
> So after we cleared stale requests, bt_tags_iter() won't observe
> freed request any more, also the clearing will wait for pending
> request reference.
> 
> The idea of clearing ->rqs[] is borrowed from John Garry's previous
> patch and one recent David's patch.
> 
> Tested-by: John Garry <john.garry@huawei.com>
> Reviewed-by: David Jeffery <djeffery@redhat.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-tag.c |  8 +++++++-
>  block/blk-mq-tag.h |  3 +++
>  block/blk-mq.c     | 39 ++++++++++++++++++++++++++++++++++-----
>  3 files changed, 44 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 4a40d409f5dd..8b239dcce85f 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -203,9 +203,14 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
>  		unsigned int bitnr)
>  {
>  	struct request *rq = tags->rqs[bitnr];
> +	unsigned long flags;
>  
> -	if (!rq || !refcount_inc_not_zero(&rq->ref))
> +	spin_lock_irqsave(&tags->lock, flags);
> +	if (!rq || !refcount_inc_not_zero(&rq->ref)) {
> +		spin_unlock_irqrestore(&tags->lock, flags);
>  		return NULL;
> +	}
> +	spin_unlock_irqrestore(&tags->lock, flags);
>  	return rq;
>  }
>  
> @@ -538,6 +543,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
>  
>  	tags->nr_tags = total_tags;
>  	tags->nr_reserved_tags = reserved_tags;
> +	spin_lock_init(&tags->lock);
>  
>  	if (blk_mq_is_sbitmap_shared(flags))
>  		return tags;
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index 7d3e6b333a4a..f942a601b5ef 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -20,6 +20,9 @@ struct blk_mq_tags {
>  	struct request **rqs;
>  	struct request **static_rqs;
>  	struct list_head page_list;
> +
> +	/* used to clear rqs[] before one request pool is freed */
> +	spinlock_t lock;
>  };
>  
>  extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d053e80fa6d7..c1b28e09a27e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2306,6 +2306,38 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>  	return BLK_QC_T_NONE;
>  }
>  
> +static size_t order_to_size(unsigned int order)
> +{
> +	return (size_t)PAGE_SIZE << order;
> +}
> +
> +/* called before freeing request pool in @tags */
> +static void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
> +		struct blk_mq_tags *tags, unsigned int hctx_idx)
> +{
> +	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
> +	struct page *page;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&drv_tags->lock, flags);
> +	list_for_each_entry(page, &tags->page_list, lru) {
> +		unsigned long start = (unsigned long)page_address(page);
> +		unsigned long end = start + order_to_size(page->private);
> +		int i;
> +
> +		for (i = 0; i < set->queue_depth; i++) {
> +			struct request *rq = drv_tags->rqs[i];
> +			unsigned long rq_addr = (unsigned long)rq;
> +
> +			if (rq_addr >= start && rq_addr < end) {
> +				WARN_ON_ONCE(refcount_read(&rq->ref) != 0);
> +				cmpxchg(&drv_tags->rqs[i], rq, NULL);
> +			}
> +		}
> +	}
> +	spin_unlock_irqrestore(&drv_tags->lock, flags);

This looks really strange.  Why do we need the cmpxchg while under
the lock anyway?  Why iterate the allocated pages and not just clear
the drv_tags valus directly?

static void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
		struct blk_mq_tags *tags, unsigned int hctx_idx)
{
	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
	unsigned int i = 0;
	unsigned long flags;

	spin_lock_irqsave(&drv_tags->lock, flags);
	for (i = 0; i < set->queue_depth; i++)
		WARN_ON_ONCE(refcount_read(&drv_tags->rqs[i]->ref) != 0);
		drv_tags->rqs[i] = NULL;
	}
	spin_unlock_irqrestore(&drv_tags->lock, flags);
}
