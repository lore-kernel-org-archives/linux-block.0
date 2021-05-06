Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D363AC433B4
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 07:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DDD4611AD
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 07:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhEFHfb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 03:35:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233434AbhEFHfa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 May 2021 03:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620286472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hYbdphz8e2KBwElpraWrgIPtOFUWWU9FrPT6eAmWO38=;
        b=eQHmd9Ak0xj+wR5IMN5j2kXzK3bnHTCVoh2mWOXtAAsKvVCs+0qad9zwzap44pt7yaSA96
        uXqtTPnGy8OMIJ/8y2v4doTUTJWatA5a4XSN+Jzm+R62R13RFzFDXXnD3RdwDnivn+AFCX
        6cJ0up0LaNS5D0RcZFicpF3F9KTbJ64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-2FVh-nYJOi2Kc0Y19o0n2Q-1; Thu, 06 May 2021 03:34:30 -0400
X-MC-Unique: 2FVh-nYJOi2Kc0Y19o0n2Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF763107ACE4;
        Thu,  6 May 2021 07:34:28 +0000 (UTC)
Received: from T590 (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 037F160C5C;
        Thu,  6 May 2021 07:34:21 +0000 (UTC)
Date:   Thu, 6 May 2021 15:34:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V5 3/4] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
Message-ID: <YJOb+a85Cpb56Mdz@T590>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-4-ming.lei@redhat.com>
 <20210506071256.GD328487@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506071256.GD328487@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 06, 2021 at 08:12:56AM +0100, Christoph Hellwig wrote:
> On Wed, May 05, 2021 at 10:58:54PM +0800, Ming Lei wrote:
> > refcount_inc_not_zero() in bt_tags_iter() still may read one freed
> > request.
> > 
> > Fix the issue by the following approach:
> > 
> > 1) hold a per-tags spinlock when reading ->rqs[tag] and calling
> > refcount_inc_not_zero in bt_tags_iter()
> > 
> > 2) clearing stale request referred via ->rqs[tag] before freeing
> > request pool, the per-tags spinlock is held for clearing stale
> > ->rq[tag]
> > 
> > So after we cleared stale requests, bt_tags_iter() won't observe
> > freed request any more, also the clearing will wait for pending
> > request reference.
> > 
> > The idea of clearing ->rqs[] is borrowed from John Garry's previous
> > patch and one recent David's patch.
> > 
> > Tested-by: John Garry <john.garry@huawei.com>
> > Reviewed-by: David Jeffery <djeffery@redhat.com>
> > Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq-tag.c |  8 +++++++-
> >  block/blk-mq-tag.h |  3 +++
> >  block/blk-mq.c     | 39 ++++++++++++++++++++++++++++++++++-----
> >  3 files changed, 44 insertions(+), 6 deletions(-)
> > 
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index 4a40d409f5dd..8b239dcce85f 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -203,9 +203,14 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
> >  		unsigned int bitnr)
> >  {
> >  	struct request *rq = tags->rqs[bitnr];
> > +	unsigned long flags;
> >  
> > -	if (!rq || !refcount_inc_not_zero(&rq->ref))
> > +	spin_lock_irqsave(&tags->lock, flags);
> > +	if (!rq || !refcount_inc_not_zero(&rq->ref)) {
> > +		spin_unlock_irqrestore(&tags->lock, flags);
> >  		return NULL;
> > +	}
> > +	spin_unlock_irqrestore(&tags->lock, flags);
> >  	return rq;
> >  }
> >  
> > @@ -538,6 +543,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
> >  
> >  	tags->nr_tags = total_tags;
> >  	tags->nr_reserved_tags = reserved_tags;
> > +	spin_lock_init(&tags->lock);
> >  
> >  	if (blk_mq_is_sbitmap_shared(flags))
> >  		return tags;
> > diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> > index 7d3e6b333a4a..f942a601b5ef 100644
> > --- a/block/blk-mq-tag.h
> > +++ b/block/blk-mq-tag.h
> > @@ -20,6 +20,9 @@ struct blk_mq_tags {
> >  	struct request **rqs;
> >  	struct request **static_rqs;
> >  	struct list_head page_list;
> > +
> > +	/* used to clear rqs[] before one request pool is freed */
> > +	spinlock_t lock;
> >  };
> >  
> >  extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index d053e80fa6d7..c1b28e09a27e 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2306,6 +2306,38 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
> >  	return BLK_QC_T_NONE;
> >  }
> >  
> > +static size_t order_to_size(unsigned int order)
> > +{
> > +	return (size_t)PAGE_SIZE << order;
> > +}
> > +
> > +/* called before freeing request pool in @tags */
> > +static void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
> > +		struct blk_mq_tags *tags, unsigned int hctx_idx)
> > +{
> > +	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
> > +	struct page *page;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&drv_tags->lock, flags);
> > +	list_for_each_entry(page, &tags->page_list, lru) {
> > +		unsigned long start = (unsigned long)page_address(page);
> > +		unsigned long end = start + order_to_size(page->private);
> > +		int i;
> > +
> > +		for (i = 0; i < set->queue_depth; i++) {
> > +			struct request *rq = drv_tags->rqs[i];
> > +			unsigned long rq_addr = (unsigned long)rq;
> > +
> > +			if (rq_addr >= start && rq_addr < end) {
> > +				WARN_ON_ONCE(refcount_read(&rq->ref) != 0);
> > +				cmpxchg(&drv_tags->rqs[i], rq, NULL);
> > +			}
> > +		}
> > +	}
> > +	spin_unlock_irqrestore(&drv_tags->lock, flags);
> 
> This looks really strange.  Why do we need the cmpxchg while under
> the lock anyway?  Why iterate the allocated pages and not just clear

Lock is for protecting free vs. iterating.

> the drv_tags valus directly?
> 
> static void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
> 		struct blk_mq_tags *tags, unsigned int hctx_idx)
> {
> 	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
> 	unsigned int i = 0;
> 	unsigned long flags;
> 
> 	spin_lock_irqsave(&drv_tags->lock, flags);
> 	for (i = 0; i < set->queue_depth; i++)
> 		WARN_ON_ONCE(refcount_read(&drv_tags->rqs[i]->ref) != 0);
> 		drv_tags->rqs[i] = NULL;

drv_tags->rqs[] may be assigned from another LUN at the same time, then
the simple clearing will overwrite the active assignment. We just need
to clear mapping iff the stored rq will be freed.


Thanks,
Ming

