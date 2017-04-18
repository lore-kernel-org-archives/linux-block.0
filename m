Return-Path: <jack@suse.cz>
Date: Tue, 18 Apr 2017 14:25:17 +0200
From: Jan Kara <jack@suse.cz>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "jack@suse.cz" <jack@suse.cz>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Make writeback throttling defaults consistent for
 SQ devices
Message-ID: <20170418122517.GA16327@quack2.suse.cz>
References: <20170412082337.10256-1-jack@suse.cz>
 <1492184571.2644.1.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1492184571.2644.1.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

Hello Bart,

On Fri 14-04-17 15:42:53, Bart Van Assche wrote:
> On Wed, 2017-04-12 at 10:23 +0200, Jan Kara wrote:
> > +#ifndef CONFIG_BLK_WBT_MQ
> > +	if (q->mq_ops)
> > +		return;
> > +#endif
> > +#ifndef CONFIG_BLK_WBT_SQ
> > +	if (q->request_fn)
> > +		return;
> > +#endif
> > +
> > +	/*
> > +	 * If this fails, we don't get throttling
> > +	 */
> > +	wbt_init(q);
> 
> How about using positive logic to enable WBT, e.g. as follows? Wouldn't
> that make the code easier to read?
> 
> 	if ((IS_ENABLED(CONFIG_BLK_WBT_MQ) &&�q->mq_ops) ||
> 	    (IS_ENABLED(CONFIG_BLK_WBT_SQ) && q->request_fn))
> 		wbt_init(q);

Yes, it is more readable. I was just copying the function around so I
didn't change it from the original but I guess I could add this cleanup to
make things more readable.

> > +static void deadline_registered_queue(struct request_queue *q)
> > +{
> > +	wbt_enable_default(q);
> > +}
> > +
> >  /*
> >   * sysfs parts below
> >   */
> > @@ -445,6 +451,7 @@ static struct elevator_type iosched_deadline = {
> >  		.elevator_latter_req_fn =	elv_rb_latter_request,
> >  		.elevator_init_fn =		deadline_init_queue,
> >  		.elevator_exit_fn =		deadline_exit_queue,
> > +		.elevator_registered_fn =	deadline_registered_queue,
> >  	},
> >  
> >  	.elevator_attrs = deadline_attrs,
> > [ ... ]
> > @@ -91,6 +92,11 @@ static void noop_exit_queue(struct elevator_queue *e)
> >  	kfree(nd);
> >  }
> >  
> > +static void noop_registered_queue(struct request_queue *q)
> > +{
> > +	wbt_enable_default(q);
> > +}
> > +
> >  static struct elevator_type elevator_noop = {
> >  	.ops.sq = {
> >  		.elevator_merge_req_fn		= noop_merged_requests,
> > @@ -100,6 +106,7 @@ static struct elevator_type elevator_noop = {
> >  		.elevator_latter_req_fn		= noop_latter_request,
> >  		.elevator_init_fn		= noop_init_queue,
> >  		.elevator_exit_fn		= noop_exit_queue,
> > +		.elevator_registered_fn		= noop_registered_queue,
> >  	},
> >  	.elevator_name = "noop",
> >  	.elevator_owner = THIS_MODULE,
> 
> This approach is not suited for blk-mq because with blk-mq "none" means no
> scheduler and hence no struct elevator_type. Please consider not to add any
> elevator_registered_fn() callbacks to noop and deadline but instead to call
> wbt_enable_default() from elv_unregister_queue().

So I was not much concerned about how to make blk-mq enable the writeback
throttling as you cannot switch between legacy and blk-mq path dynamically
and thus writeback throttling cannot get disabled. And for legacy path
using elevator_registered_fn is a natural choice.

I agree that using elv_unregister_queue() to enable writeback throttling
would work as well and may be easier to reuse if we ever want to make
similar auto-disabling work e.g. with BFQ. So unless someone objects I can
redo my patch that way.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
