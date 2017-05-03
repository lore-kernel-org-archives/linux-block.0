Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36762 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbdECRAG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 13:00:06 -0400
Received: by mail-pf0-f176.google.com with SMTP id q66so15415641pfi.3
        for <linux-block@vger.kernel.org>; Wed, 03 May 2017 10:00:06 -0700 (PDT)
Date: Wed, 3 May 2017 10:00:04 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 3/4] blk-mq: use hw tag for scheduling if hw tag space is
 big enough
Message-ID: <20170503170004.GA10971@vader>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <20170428151539.25514-4-ming.lei@redhat.com>
 <20170503162936.GB10343@vader>
 <20170503165529.GC9706@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170503165529.GC9706@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, May 04, 2017 at 12:55:30AM +0800, Ming Lei wrote:
> On Wed, May 03, 2017 at 09:29:36AM -0700, Omar Sandoval wrote:
> > On Fri, Apr 28, 2017 at 11:15:38PM +0800, Ming Lei wrote:
> > > When tag space of one device is big enough, we use hw tag
> > > directly for I/O scheduling.
> > > 
> > > Now the decision is made if hw queue depth is not less than
> > > q->nr_requests and the tag set isn't shared.
> > > 
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  block/blk-mq-sched.c |  8 ++++++++
> > >  block/blk-mq-sched.h | 15 +++++++++++++++
> > >  block/blk-mq.c       | 18 +++++++++++++++++-
> > >  3 files changed, 40 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > index 45a675f07b8b..4681e27c127e 100644
> > > --- a/block/blk-mq-sched.c
> > > +++ b/block/blk-mq-sched.c
> > > @@ -507,6 +507,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
> > >  	struct elevator_queue *eq;
> > >  	unsigned int i;
> > >  	int ret;
> > > +	bool auto_hw_tag;
> > >  
> > >  	if (!e) {
> > >  		q->elevator = NULL;
> > > @@ -519,7 +520,14 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
> > >  	 */
> > >  	q->nr_requests = 2 * BLKDEV_MAX_RQ;
> > >  
> > > +	auto_hw_tag = blk_mq_sched_may_use_hw_tag(q);
> > > +
> > >  	queue_for_each_hw_ctx(q, hctx, i) {
> > > +		if (auto_hw_tag)
> > > +			hctx->flags |= BLK_MQ_F_SCHED_USE_HW_TAG;
> > > +		else
> > > +			hctx->flags &= ~BLK_MQ_F_SCHED_USE_HW_TAG;
> > > +
> > >  		ret = blk_mq_sched_alloc_tags(q, hctx, i);
> > >  		if (ret)
> > >  			goto err;
> > 
> > I think you should also clear the BLK_MQ_F_SCHED_USE_HW_TAG flag in
> > blk_mq_exit_sched()?
> 
> Looks not necessary since the flag is always evaluated in
> blk_mq_init_sched().

What if we're setting the scheduler to "none"? Then blk_mq_init_sched()
will go in here:

if (!e) {
	q->elevator = NULL;
	return 0;
}
