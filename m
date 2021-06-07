Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC43C47082
	for <linux-block@archiver.kernel.org>; Mon,  7 Jun 2021 11:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 054046120F
	for <linux-block@archiver.kernel.org>; Mon,  7 Jun 2021 11:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhFGLnT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jun 2021 07:43:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36668 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhFGLnS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Jun 2021 07:43:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 39EA521A93;
        Mon,  7 Jun 2021 11:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623066087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y1p34XXNGh13rgcmV89i0Hv1PANOTcFOPO8k8eP1M4Y=;
        b=SHkREpPwnPLgvg4Hr1PyJ8+pT6ZSTMXxkT2yuB8OK+6Ut/3Gpn56H8lPU2gcIf5t5pFPS/
        3oZ2ayP4XrTlHYgHO0KftMfpb9LaVNCXzQvkZpCB4DkCrBSVyGD5BDc2sNj9o/czg/lzJw
        NGwY0paYWx+leJTIGJbB2ytQhFCGcaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623066087;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y1p34XXNGh13rgcmV89i0Hv1PANOTcFOPO8k8eP1M4Y=;
        b=BNu3OcxPPM6wI9r7VyWpHjeqymUvNelFDLsR21xhARu1mXX/B3RcYq5IEwcspHKuKJKcMQ
        HIhQluYwS94zOQAw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 2E3F3A3B8A;
        Mon,  7 Jun 2021 11:41:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0CE5A1F2CA8; Mon,  7 Jun 2021 13:41:27 +0200 (CEST)
Date:   Mon, 7 Jun 2021 13:41:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH v2] block: Do not pull requests from the scheduler when
 we cannot dispatch them
Message-ID: <20210607114127.GG30275@quack2.suse.cz>
References: <20210603104721.6309-1-jack@suse.cz>
 <42e2e0f1-acf4-a5eb-2c3e-cb20706430a4@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e2e0f1-acf4-a5eb-2c3e-cb20706430a4@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 07-06-21 12:05:52, Hannes Reinecke wrote:
> On 6/3/21 12:47 PM, Jan Kara wrote:
> > Provided the device driver does not implement dispatch budget accounting
> > (which only SCSI does) the loop in __blk_mq_do_dispatch_sched() pulls
> > requests from the IO scheduler as long as it is willing to give out any.
> > That defeats scheduling heuristics inside the scheduler by creating
> > false impression that the device can take more IO when it in fact
> > cannot.
> > 
> > For example with BFQ IO scheduler on top of virtio-blk device setting
> > blkio cgroup weight has barely any impact on observed throughput of
> > async IO because __blk_mq_do_dispatch_sched() always sucks out all the
> > IO queued in BFQ. BFQ first submits IO from higher weight cgroups but
> > when that is all dispatched, it will give out IO of lower weight cgroups
> > as well. And then we have to wait for all this IO to be dispatched to
> > the disk (which means lot of it actually has to complete) before the
> > IO scheduler is queried again for dispatching more requests. This
> > completely destroys any service differentiation.
> > 
> > So grab request tag for a request pulled out of the IO scheduler already
> > in __blk_mq_do_dispatch_sched() and do not pull any more requests if we
> > cannot get it because we are unlikely to be able to dispatch it. That
> > way only single request is going to wait in the dispatch list for some
> > tag to free.
> > 
> > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  block/blk-mq-sched.c | 12 +++++++++++-
> >  block/blk-mq.c       |  2 +-
> >  block/blk-mq.h       |  2 ++
> >  3 files changed, 14 insertions(+), 2 deletions(-)
> > 
> > Jens, can you please merge the patch? Thanks!
> > 
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index 996a4b2f73aa..714e678f516a 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -168,9 +168,19 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> >  		 * in blk_mq_dispatch_rq_list().
> >  		 */
> >  		list_add_tail(&rq->queuelist, &rq_list);
> > +		count++;
> >  		if (rq->mq_hctx != hctx)
> >  			multi_hctxs = true;
> > -	} while (++count < max_dispatch);
> > +
> > +		/*
> > +		 * If we cannot get tag for the request, stop dequeueing
> > +		 * requests from the IO scheduler. We are unlikely to be able
> > +		 * to submit them anyway and it creates false impression for
> > +		 * scheduling heuristics that the device can take more IO.
> > +		 */
> > +		if (!blk_mq_get_driver_tag(rq))
> > +			break;
> > +	} while (count < max_dispatch);
> >  
> >  	if (!count) {
> >  		if (run_queue)
> 
> Doesn't this lead to a double accounting of the allocated tags?
> From what I can see we don't really check if the tag is already
> allocated in blk_mq_get_driver_tag() ...

I think we do check. blk_mq_get_driver_tag() has:

        if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_get_driver_tag(rq))
                return false;

        if ((hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED) &&
                        !(rq->rq_flags & RQF_MQ_INFLIGHT)) {
                rq->rq_flags |= RQF_MQ_INFLIGHT;
                __blk_mq_inc_active_requests(hctx);
        }
        hctx->tags->rqs[rq->tag] = rq;
 
So once we call it, rq->tag will be != BLK_MQ_NO_TAG and RQF_MQ_INFLIGHT
will be set. So neither __blk_mq_get_driver_tag() nor
__blk_mq_inc_active_requests() will get repeated.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
