Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D8CC2BA19
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 08:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F92D2084D
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 08:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZP071dS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgDWIrS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Apr 2020 04:47:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52822 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725854AbgDWIrS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Apr 2020 04:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587631637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pVuO+YQBkH+YujX9oi6gdsgqNVvyRsL0TVIJuHpDbWQ=;
        b=iZP071dSDCQk408vMMvEMIn109yDoC/SSSpey4Bx+QYl4wx0nph+du9Qax6RWv9bNOYBre
        XEFaW7128Y2UrLaNbFkqRdFK51llSUcD2lNmWVb1an3YZni6WYt3mXkl/67REIdDiT50eH
        YDUZUUgHYqKb+rkjdbD0Cfmuyx51vWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-7oI1550DNXyr_vJkXqpWew-1; Thu, 23 Apr 2020 04:47:13 -0400
X-MC-Unique: 7oI1550DNXyr_vJkXqpWew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0937A2E42;
        Thu, 23 Apr 2020 08:47:11 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B18A45D9E2;
        Thu, 23 Apr 2020 08:47:03 +0000 (UTC)
Date:   Thu, 23 Apr 2020 16:46:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V7 7/9] blk-mq: re-submit IO in case that hctx is inactive
Message-ID: <20200423084659.GA345742@T590>
References: <20200418030925.31996-1-ming.lei@redhat.com>
 <20200418030925.31996-8-ming.lei@redhat.com>
 <20200423075011.GH10951@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423075011.GH10951@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 23, 2020 at 09:50:11AM +0200, Christoph Hellwig wrote:
> > +static void blk_mq_resubmit_passthrough_io(struct request *rq)
> > +{
> > +	struct request *nrq;
> > +	unsigned int flags = 0, cmd_flags = 0;
> > +	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> > +	struct blk_mq_tags *tags = rq->q->elevator ? hctx->sched_tags :
> > +		hctx->tags;
> > +	bool reserved = blk_mq_tag_is_reserved(tags, rq->internal_tag);
> > +
> > +	if (rq->rq_flags & RQF_PREEMPT)
> > +		flags |= BLK_MQ_REQ_PREEMPT;
> > +	if (reserved)
> > +		flags |= BLK_MQ_REQ_RESERVED;
> > +
> > +	/* avoid allocation failure & IO merge */
> > +	cmd_flags = (rq->cmd_flags & ~REQ_NOWAIT) | REQ_NOMERGE;
> > +
> > +	nrq = blk_get_request(rq->q, cmd_flags, flags);
> > +	if (!nrq)
> > +		return;
> > +
> > +	nrq->__sector = blk_rq_pos(rq);
> > +	nrq->__data_len = blk_rq_bytes(rq);
> > +	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD) {
> > +		nrq->rq_flags |= RQF_SPECIAL_PAYLOAD;
> > +		nrq->special_vec = rq->special_vec;
> > +	}
> > +#if defined(CONFIG_BLK_DEV_INTEGRITY)
> > +	nrq->nr_integrity_segments = rq->nr_integrity_segments;
> > +#endif
> > +	nrq->nr_phys_segments = rq->nr_phys_segments;
> > +	nrq->ioprio = rq->ioprio;
> > +	nrq->extra_len = rq->extra_len;
> > +	nrq->rq_disk = rq->rq_disk;
> > +	nrq->part = rq->part;
> > +	nrq->write_hint = rq->write_hint;
> > +	nrq->timeout = rq->timeout;
> 
> This should share code with blk_rq_prep_clone() using a helper.
> Note that blk_rq_prep_clone seems to miss things like the
> write_hint and timeout, which we should fix as well.

Looks requests in both cases are inserted directly, so it is reasonable
to share similar clone helper.

Will do that in next version.

> 
> > +static void blk_mq_resubmit_fs_io(struct request *rq)
> > +{
> > +	struct bio_list list;
> > +	struct bio *bio;
> > +
> > +	bio_list_init(&list);
> > +	blk_steal_bios(&list, rq);
> > +
> > +	while (true) {
> > +		bio = bio_list_pop(&list);
> > +		if (!bio)
> > +			break;
> > +
> > +		generic_make_request(bio);
> > +	}
> 
> This could be simplified to:
> 
> 	while ((bio = bio_list_pop(&list)))
> 		generic_make_request(bio);
> 
> but then again the generic_make_request seems weird.  Do we need
> actually need any of the checks in generic_make_request?  Shouldn't
> we call into blk_mq_make_request directly?

Good catch, I think we should call into blk_mq_make_request() directly
for avoiding double check in generic_make_request.

> 
> Then again I wonder why the passthrough case doesn't work for
> FS requests?

Good question, just not think of this way cause re-submitting
passthrough request is done a bit late. I believe we can do
this way, which is very similar with dm-rq's usage.

> 
> >  static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
> >  {
> > @@ -2394,14 +2482,38 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
> >  	}
> >  	spin_unlock(&ctx->lock);
> >  
> > +	if (!test_bit(BLK_MQ_S_INACTIVE, &hctx->state)) {
> > +		if (!list_empty(&tmp)) {
> > +			spin_lock(&hctx->lock);
> > +			list_splice_tail_init(&tmp, &hctx->dispatch);
> > +			spin_unlock(&hctx->lock);
> > +			blk_mq_run_hw_queue(hctx, true);
> > +		}
> > +	} else {
> 
> What about an early return or two here to save a level of indentation
> later?
> 
> 	if (!test_bit(BLK_MQ_S_INACTIVE, &hctx->state)) {
> 		if (list_empty(&tmp))
> 			return 0;
> 
> 		spin_lock(&hctx->lock);
> 		list_splice_tail_init(&tmp, &hctx->dispatch);
> 		spin_unlock(&hctx->lock);
> 		blk_mq_run_hw_queue(hctx, true);
> 		return 0;
> 	}

OK.


Thanks,
Ming

