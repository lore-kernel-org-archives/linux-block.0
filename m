Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98DBC433ED
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 11:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA16613DE
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 11:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbhEUL2h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 07:28:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:36670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234876AbhEUL22 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 07:28:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64074AAA6;
        Fri, 21 May 2021 11:27:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2D1451F2C73; Fri, 21 May 2021 13:27:04 +0200 (CEST)
Date:   Fri, 21 May 2021 13:27:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Do not pull requests from the scheduler when we
 cannot dispatch them
Message-ID: <20210521112704.GI18952@quack2.suse.cz>
References: <20210520112528.16250-1-jack@suse.cz>
 <YKcM/TWxSAQv7KHg@T590>
 <20210521112016.GH18952@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521112016.GH18952@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 21-05-21 13:20:16, Jan Kara wrote:
> On Fri 21-05-21 09:29:33, Ming Lei wrote:
> > On Thu, May 20, 2021 at 01:25:28PM +0200, Jan Kara wrote:
> > > Provided the device driver does not implement dispatch budget accounting
> > > (which only SCSI does) the loop in __blk_mq_do_dispatch_sched() pulls
> > > requests from the IO scheduler as long as it is willing to give out any.
> > > That defeats scheduling heuristics inside the scheduler by creating
> > > false impression that the device can take more IO when it in fact
> > > cannot.
> > 
> > So hctx->dispatch_busy isn't set as true in this case?
> 
> No. blk_mq_update_dispatch_busy() has:
> 
>         if (hctx->queue->elevator)
>                 return;
> 
> > > For example with BFQ IO scheduler on top of virtio-blk device setting
> > > blkio cgroup weight has barely any impact on observed throughput of
> > > async IO because __blk_mq_do_dispatch_sched() always sucks out all the
> > > IO queued in BFQ. BFQ first submits IO from higher weight cgroups but
> > > when that is all dispatched, it will give out IO of lower weight cgroups
> > > as well. And then we have to wait for all this IO to be dispatched to
> > > the disk (which means lot of it actually has to complete) before the
> > > IO scheduler is queried again for dispatching more requests. This
> > > completely destroys any service differentiation.
> > > 
> > > So grab request tag for a request pulled out of the IO scheduler already
> > > in __blk_mq_do_dispatch_sched() and do not pull any more requests if we
> > > cannot get it because we are unlikely to be able to dispatch it. That
> > > way only single request is going to wait in the dispatch list for some
> > > tag to free.
> > > 
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  block/blk-mq-sched.c | 12 +++++++++++-
> > >  block/blk-mq.c       |  2 +-
> > >  block/blk-mq.h       |  2 ++
> > >  3 files changed, 14 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > index 996a4b2f73aa..714e678f516a 100644
> > > --- a/block/blk-mq-sched.c
> > > +++ b/block/blk-mq-sched.c
> > > @@ -168,9 +168,19 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > >  		 * in blk_mq_dispatch_rq_list().
> > >  		 */
> > >  		list_add_tail(&rq->queuelist, &rq_list);
> > > +		count++;
> > >  		if (rq->mq_hctx != hctx)
> > >  			multi_hctxs = true;
> > > -	} while (++count < max_dispatch);
> > > +
> > > +		/*
> > > +		 * If we cannot get tag for the request, stop dequeueing
> > > +		 * requests from the IO scheduler. We are unlikely to be able
> > > +		 * to submit them anyway and it creates false impression for
> > > +		 * scheduling heuristics that the device can take more IO.
> > > +		 */
> > > +		if (!blk_mq_get_driver_tag(rq))
> > > +			break;
> > 
> > At default BFQ's queue depth is same with virtblk_queue_depth, both are
> > 256, so looks you use non-default setting?
> 
> Ah yes, I forgot to mention that. I actually had nr_requests set to 1024 as
> otherwise all requests get sucked into virtio-blk and no IO scheduling
> happens either.
> 
> > Also in case of running out of driver tag, hctx->dispatch_busy should have
> > been set as true for avoiding batching dequeuing, does the following
> > patch make a difference for you?
> 
> I'll try it with modifying blk_mq_update_dispatch_busy() to be updated when
> elevator is in use...

OK, tried your patch with the modification and it seems to work OK! Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
