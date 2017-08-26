Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751925AbdHZIr7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Aug 2017 04:47:59 -0400
Date: Sat, 26 Aug 2017 16:47:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 03/20] blk-mq: introduce blk_mq_dispatch_rq_from_ctx()
Message-ID: <20170826084737.GB28380@ming.t460p>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-4-ming.lei@redhat.com>
 <1503427542.2508.10.camel@wdc.com>
 <20170824045226.GC12966@ming.t460p>
 <1503697267.2680.36.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503697267.2680.36.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Aug 25, 2017 at 09:41:08PM +0000, Bart Van Assche wrote:
> On Thu, 2017-08-24 at 12:52 +0800, Ming Lei wrote:
> > On Tue, Aug 22, 2017 at 06:45:46PM +0000, Bart Van Assche wrote:
> > > On Sat, 2017-08-05 at 14:56 +0800, Ming Lei wrote:
> > > > More importantly, for some SCSI devices, driver
> > > > tags are host wide, and the number is quite big,
> > > > but each lun has very limited queue depth.
> > > 
> > > This may be the case but is not always the case. Another important use-case
> > > is one LUN per host and where the queue depth per LUN is identical to the
> > > number of host tags.
> > 
> > This patchset won't hurt this case because the BUSY info is returned
> > from driver.  In this case, BLK_STS_RESOURCE should seldom be returned
> > from .queue_rq generally.
> > 
> > Also one important fact is that once q->queue_depth is set, that
> > means there is per-request_queue limit on pending I/Os, and the
> > single LUN is just the special case which is covered by this whole
> > patchset. We don't need to pay special attention in this special case
> > at all.
> 
> The purpose of my comment was not to ask for further clarification but to
> report that the description of this patch is not correct.

OK, will change the commit log in V3.

> 
> > > 
> > > > +struct request *blk_mq_dispatch_rq_from_ctx(struct blk_mq_hw_ctx *hctx,
> > > > +					    struct blk_mq_ctx *start)
> > > > +{
> > > > +	unsigned off = start ? start->index_hw : 0;
> > > 
> > > Please consider to rename this function into blk_mq_dispatch_rq_from_next_ctx()
> > > and to start from start->index_hw + 1 instead of start->index_hw. I think that
> > > will not only result in simpler but also in faster code.
> > 
> > I believe this helper with blk_mq_next_ctx(hctx, rq->mq_ctx) together
> > will be much simpler and easier to implement, and code can be much
> > readable too.
> > 
> > blk_mq_dispatch_rq_from_next_ctx() is ugly and mixing two things
> > together.
> 
> Sorry but I disagree with both of the above statements.

I will post out V3, please comment it on that patch about this issue,
especially total round robin is added.

-- 
Ming
