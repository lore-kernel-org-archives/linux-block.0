Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133A3C47096
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 10:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2C7E610A8
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 10:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFCKrE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 06:47:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44308 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhFCKrE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 06:47:04 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F0A5C1FD46;
        Thu,  3 Jun 2021 10:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622717118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V1PvJPcFYd4AMPpcn2hMppcINIA5RXLlrqpuPiW5fUA=;
        b=kJgkmjisf/+ArhZeVYMQA+I/13IMTNkHonM9ELyqyj6eBRSwFfbY42ptF4hmG9RWv1AAjj
        xBVuZrcFmB9yH4OW7fy1LUkyRGqiXZzZ2LdR5oE3GxN/fyLDkipDEazxU0DdJcvOkyv1Z0
        U3O//Mz/eCVuJYh4l6LcGHoKdKcvONI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622717118;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V1PvJPcFYd4AMPpcn2hMppcINIA5RXLlrqpuPiW5fUA=;
        b=3Z7Yu+2Lm8Hcf5d0EP7hrc84TlSqwI7AGCq9oNUlRHhAVp9QQJng6CjUZFDlXjKB/hpTP1
        WUEcW57Yo/cGJdDA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id E3DEFA3B85;
        Thu,  3 Jun 2021 10:45:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C6A991F2C98; Thu,  3 Jun 2021 12:45:18 +0200 (CEST)
Date:   Thu, 3 Jun 2021 12:45:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Do not pull requests from the scheduler when we
 cannot dispatch them
Message-ID: <20210603104518.GJ23647@quack2.suse.cz>
References: <20210520112528.16250-1-jack@suse.cz>
 <YLdOoFBz3k+ipxkC@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLdOoFBz3k+ipxkC@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 02-06-21 17:25:52, Ming Lei wrote:
> On Thu, May 20, 2021 at 01:25:28PM +0200, Jan Kara wrote:
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
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  block/blk-mq-sched.c | 12 +++++++++++-
> >  block/blk-mq.c       |  2 +-
> >  block/blk-mq.h       |  2 ++
> >  3 files changed, 14 insertions(+), 2 deletions(-)
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
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index c86c01bfecdb..bc2cf80d2c3b 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1100,7 +1100,7 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
> >  	return true;
> >  }
> >  
> > -static bool blk_mq_get_driver_tag(struct request *rq)
> > +bool blk_mq_get_driver_tag(struct request *rq)
> >  {
> >  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> >  
> > diff --git a/block/blk-mq.h b/block/blk-mq.h
> > index 9ce64bc4a6c8..81a775171be7 100644
> > --- a/block/blk-mq.h
> > +++ b/block/blk-mq.h
> > @@ -259,6 +259,8 @@ static inline void blk_mq_put_driver_tag(struct request *rq)
> >  	__blk_mq_put_driver_tag(rq->mq_hctx, rq);
> >  }
> >  
> > +bool blk_mq_get_driver_tag(struct request *rq);
> > +
> >  static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
> >  {
> >  	int cpu;
> 
> Thinking of further, looks this patch is fine, and it is safe to use driver tag
> allocation result to decide if more requests need to be dequeued since run queue
> always be followed when breaking from the loop. Also I can observe that
> io.bfq.weight is improved on virtio-blk, so
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

OK, thanks for your review!

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
