Return-Path: <ming.lei@redhat.com>
Date: Fri, 21 Sep 2018 08:54:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v9 7/8] block: Make blk_get_request() block for non-PM
 requests while suspended
Message-ID: <20180921005445.GA2904@ming.t460p>
References: <20180919224530.222469-1-bvanassche@acm.org>
 <20180919224530.222469-8-bvanassche@acm.org>
 <20180920034851.GD27645@ming.t460p>
 <1537456990.204730.5.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1537456990.204730.5.camel@acm.org>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 20, 2018 at 08:23:10AM -0700, Bart Van Assche wrote:
> On Thu, 2018-09-20 at 11:48 +0800, Ming Lei wrote:
> > On Wed, Sep 19, 2018 at 03:45:29PM -0700, Bart Van Assche wrote:
> > > +	ret = -EBUSY;
> > > +	if (blk_requests_in_flight(q) == 0) {
> > > +		blk_freeze_queue_start(q);
> > > +		/*
> > > +		 * Freezing a queue starts a transition of the
> > > queue
> > > +		 * usage counter to atomic mode. Wait until atomic
> > > +		 * mode has been reached. This involves calling
> > > +		 * call_rcu(). That call guarantees that later
> > > +		 * blk_queue_enter() calls see the pm-only state.
> > > See
> > > +		 * also http://lwn.net/Articles/573497/.
> > > +		 */
> > > +		percpu_ref_switch_to_atomic_sync(&q-
> > > >q_usage_counter);
> > > +		if (percpu_ref_is_zero(&q->q_usage_counter))
> > > +			ret = 0;
> > > +		blk_mq_unfreeze_queue(q);
> > 
> > Tejun doesn't agree on this kind of usage yet, so the ref has to be
> > dropped before calling blk_mq_unfreeze_queue().
> 
> I read all Tejuns' recent e-mails but I have not found any e-mail from
> Tejun in which he wrote that he disagrees with the above pattern.

Up to now, blk_mq_unfreeze_queue() should only be called when
percpu_ref_is_zero(&q->q_usage_counter) is true.

I am trying to relax this limit in the following patch, but Tejun
objects this approach.

https://marc.info/?l=linux-block&m=153726600813090&w=2

BTW, the race with .release() may be left to user to handle by removing
grabbing the ref of atomic part in this patch, and it won't be a issue
for blk-mq.

> 
> > Also, this way still can't address the race in the following link:
> > 
> > https://marc.info/?l=linux-block&m=153732992701093&w=2
> 
> I think that the following patch is sufficient to fix that race:
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ae092ca121d5..16dd3a989753 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -942,8 +942,6 @@ int blk_queue_enter(struct request_queue *q,
> blk_mq_req_flags_t flags)
>  		if (success)
>  			return 0;
>  
> -		blk_pm_request_resume(q);
> -
>  		if (flags & BLK_MQ_REQ_NOWAIT)
>  			return -EBUSY;
>  
> @@ -958,7 +956,8 @@ int blk_queue_enter(struct request_queue *q,
> blk_mq_req_flags_t flags)
>  
>  		wait_event(q->mq_freeze_wq,
>  			   (atomic_read(&q->mq_freeze_depth) == 0 &&
> -			    (pm || !blk_queue_pm_only(q))) ||
> +			    (pm || (blk_pm_request_resume(q),
> +				    !blk_queue_pm_only(q)))) ||
>  			   blk_queue_dying(q));
>  		if (blk_queue_dying(q))
>  			return -ENODEV;

This fix looks clever.


Thanks,
Ming
