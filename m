Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054BDC433E0
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 02:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D129E61A18
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 02:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbhCYCwV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 22:52:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233097AbhCYCwP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 22:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616640734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PulifEm4i60Din01GnFvZDAAqxMie1o4qsJggnPOa34=;
        b=bZsbhHHByisrYZZ3cJgjD13e5k2t91S6DxvZE4pOssgFjHW0+vh/NiZUhdipA0LOLrOjFy
        Omq5bjvQ6NmQGtTlcuRRD1wIA7P0e2RhiKDgMmi/58iahbfhIIccedHexLj7A51a43rdWi
        5NZml5eiKP5P7rSrgPGkwVZRCBbA6/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-Lj71Qq65PM2wCeXd_akqAg-1; Wed, 24 Mar 2021 22:52:12 -0400
X-MC-Unique: Lj71Qq65PM2wCeXd_akqAg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53F8B8189C6;
        Thu, 25 Mar 2021 02:52:11 +0000 (UTC)
Received: from T590 (ovpn-12-137.pek2.redhat.com [10.72.12.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E80E63BA7;
        Thu, 25 Mar 2021 02:51:57 +0000 (UTC)
Date:   Thu, 25 Mar 2021 10:51:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: Re: [PATCH V3 04/13] block: create io poll context for submission
 and poll task
Message-ID: <YFv6yvj/mGytuFhC@T590>
References: <20210324121927.362525-1-ming.lei@redhat.com>
 <20210324121927.362525-5-ming.lei@redhat.com>
 <0bc4e13a-53ba-5f29-5a6d-5cda1aea098a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bc4e13a-53ba-5f29-5a6d-5cda1aea098a@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 25, 2021 at 10:34:02AM +0800, JeffleXu wrote:
> 
> 
> On 3/24/21 8:19 PM, Ming Lei wrote:
> > Create per-task io poll context for both IO submission and poll task
> > if the queue is bio based and supports polling.
> > 
> > This io polling context includes two queues:
> > 
> > 1) submission queue(sq) for storing HIPRI bio, written by submission task
> >    and read by poll task.
> > 2) polling queue(pq) for holding data moved from sq, only used in poll
> >    context for running bio polling.
> > 
> > Following patches will support bio based io polling.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-core.c          | 71 ++++++++++++++++++++++++++++++++-------
> >  block/blk-ioc.c           |  1 +
> >  block/blk-mq.c            | 14 ++++++++
> >  block/blk.h               | 45 +++++++++++++++++++++++++
> >  include/linux/iocontext.h |  2 ++
> >  5 files changed, 121 insertions(+), 12 deletions(-)
> > 
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index d58f8a0c80de..4671bbf31fd3 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -792,16 +792,59 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
> >  	return BLK_STS_OK;
> >  }
> >  
> > -static inline void blk_create_io_context(struct request_queue *q)
> > +static inline struct blk_bio_poll_ctx *blk_get_bio_poll_ctx(void)
> >  {
> > -	/*
> > -	 * Various block parts want %current->io_context, so allocate it up
> > -	 * front rather than dealing with lots of pain to allocate it only
> > -	 * where needed. This may fail and the block layer knows how to live
> > -	 * with it.
> > -	 */
> > -	if (unlikely(!current->io_context))
> > -		create_task_io_context(current, GFP_ATOMIC, q->node);
> > +	struct io_context *ioc = current->io_context;
> > +
> > +	return ioc ? ioc->data : NULL;
> > +}
> > +
> > +static inline unsigned int bio_grp_list_size(unsigned int nr_grps)
> > +{
> > +	return sizeof(struct bio_grp_list) + nr_grps *
> > +		sizeof(struct bio_grp_list_data);
> > +}
> > +
> > +static void bio_poll_ctx_init(struct blk_bio_poll_ctx *pc)
> > +{
> > +	pc->sq = (void *)pc + sizeof(*pc);
> > +	pc->sq->max_nr_grps = BLK_BIO_POLL_SQ_SZ;
> > +
> > +	pc->pq = (void *)pc->sq + bio_grp_list_size(BLK_BIO_POLL_SQ_SZ);
> > +	pc->pq->max_nr_grps = BLK_BIO_POLL_PQ_SZ;
> > +
> > +	spin_lock_init(&pc->sq_lock);
> > +	spin_lock_init(&pc->pq_lock);
> > +}
> > +
> > +void bio_poll_ctx_alloc(struct io_context *ioc)
> > +{
> > +	struct blk_bio_poll_ctx *pc;
> > +	unsigned int size = sizeof(*pc) +
> > +		bio_grp_list_size(BLK_BIO_POLL_SQ_SZ) +
> > +		bio_grp_list_size(BLK_BIO_POLL_PQ_SZ);
> > +
> > +	pc = kzalloc(GFP_ATOMIC, size);
> > +	if (pc) {
> > +		bio_poll_ctx_init(pc);
> > +		if (cmpxchg(&ioc->data, NULL, (void *)pc))
> > +			kfree(pc);
> > +	}
> 
> Why don't put these in blk-ioc.c?

It is for implementing bio polling, not necessary for moving it to
blk-ioc.c.

> 
> 
> > +}
> > +
> > +static inline bool blk_queue_support_bio_poll(struct request_queue *q)
> > +{
> > +	return !queue_is_mq(q) && blk_queue_poll(q);
> > +}
> > +
> > +static inline void blk_bio_poll_preprocess(struct request_queue *q,
> > +		struct bio *bio)
> > +{
> > +	if (!(bio->bi_opf & REQ_HIPRI))
> > +		return;
> > +
> > +	if (!blk_queue_poll(q) || (!queue_is_mq(q) && !blk_get_bio_poll_ctx()))
> > +		bio->bi_opf &= ~REQ_HIPRI;
> >  }
> >  
> >  static noinline_for_stack bool submit_bio_checks(struct bio *bio)
> > @@ -848,10 +891,14 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
> >  		}
> >  	}
> >  
> > -	blk_create_io_context(q);
> > +	/*
> > +	 * Create per-task io poll ctx if bio polling supported and HIPRI
> > +	 * set.
> > +	 */
> > +	blk_create_io_context(q, blk_queue_support_bio_poll(q) &&
> > +			(bio->bi_opf & REQ_HIPRI));
> >  
> > -	if (!blk_queue_poll(q))
> > -		bio->bi_opf &= ~REQ_HIPRI;
> > +	blk_bio_poll_preprocess(q, bio);
> >  
> >  	switch (bio_op(bio)) {
> >  	case REQ_OP_DISCARD:
> > diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> > index b0cde18c4b8c..5574c398eff6 100644
> > --- a/block/blk-ioc.c
> > +++ b/block/blk-ioc.c
> > @@ -19,6 +19,7 @@ static struct kmem_cache *iocontext_cachep;
> >  
> >  static inline void free_io_context(struct io_context *ioc)
> >  {
> > +	kfree(ioc->data);
> >  	kmem_cache_free(iocontext_cachep, ioc);
> >  }
> >  
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 63c81df3b8b5..c832faa52ca0 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -3852,6 +3852,17 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
> >  	return blk_mq_poll_hybrid_sleep(q, rq);
> >  }
> >  
> > +static int blk_bio_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
> > +{
> > +	/*
> > +	 * Create poll queue for storing poll bio and its cookie from
> > +	 * submission queue
> > +	 */
> > +	blk_create_io_context(q, true);
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * blk_poll - poll for IO completions
> >   * @q:  the queue
> > @@ -3875,6 +3886,9 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
> >  	if (current->plug)
> >  		blk_flush_plug_list(current->plug, false);
> >  
> > +	if (!queue_is_mq(q))
> > +		return blk_bio_poll(q, cookie, spin);
> > +
> >  	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
> >  
> >  	/*
> > diff --git a/block/blk.h b/block/blk.h
> > index 3b53e44b967e..424949f2226d 100644
> > --- a/block/blk.h
> > +++ b/block/blk.h
> > @@ -357,4 +357,49 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
> >  		struct page *page, unsigned int len, unsigned int offset,
> >  		unsigned int max_sectors, bool *same_page);
> >  
> > +/* Grouping bios that share same data into one list */
> > +struct bio_grp_list_data {
> > +	void *grp_data;
> > +
> > +	/* all bios in this list share same 'grp_data' */
> > +	struct bio_list list;
> > +};
> > +
> > +struct bio_grp_list {
> > +	unsigned int max_nr_grps, nr_grps;
> > +	struct bio_grp_list_data head[0];
> > +};
> > +
> > +struct blk_bio_poll_ctx {
> > +	spinlock_t sq_lock;
> > +	struct bio_grp_list *sq;
> > +
> > +	spinlock_t pq_lock;
> > +	struct bio_grp_list *pq;
> > +};
> > +
> > +#define BLK_BIO_POLL_SQ_SZ		16U
> > +#define BLK_BIO_POLL_PQ_SZ		(BLK_BIO_POLL_SQ_SZ * 2)
> 
> And these in iocontext.h?

All are internal definition for bio polling, not necessary to put
it into one public header.


Thanks, 
Ming

