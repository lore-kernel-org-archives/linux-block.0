Return-Path: <keith.busch@linux.intel.com>
Date: Wed, 18 Jul 2018 11:45:34 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [RFC PATCH] blk-mq: move timeout handling from queue to tagset
Message-ID: <20180718174534.GC30873@localhost.localdomain>
References: <20180718170018.31395-1-keith.busch@intel.com>
 <11f7a7aff754b9bb0e4243ac4502319f376378c3.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11f7a7aff754b9bb0e4243ac4502319f376378c3.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 18, 2018 at 05:18:45PM +0000, Bart Van Assche wrote:
> On Wed, 2018-07-18 at 11:00 -0600, Keith Busch wrote:
> > -	cancel_work_sync(&q->timeout_work);
> > -
> >  	if (q->mq_ops) {
> >  		struct blk_mq_hw_ctx *hctx;
> >  		int i;
> > @@ -415,6 +412,8 @@ void blk_sync_queue(struct request_queue *q)
> >  		queue_for_each_hw_ctx(q, hctx, i)
> >  			cancel_delayed_work_sync(&hctx->run_work);
> >  	} else {
> > +		del_timer_sync(&q->timeout);
> > +		cancel_work_sync(&q->timeout_work);
> >  		cancel_delayed_work_sync(&q->delay_work);
> >  	}
> >  }
> 
> What is the impact of this change on the md driver, which is the only driver
> that calls blk_sync_queue() directly? What will happen if timeout processing
> happens concurrently with or after blk_sync_queue() has returned?

That's a make_request_fn stacking driver, right? There should be
no impact in that case, since the change above affects only mq.

I'm actually a little puzzled why md calls blk_sync_queue. Are the
queue timers ever used for bio-based drivers?
 
> > +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> >  		/*
> >  		 * Request timeouts are handled as a forward rolling timer. If
> >  		 * we end up here it means that no requests are pending and
> > @@ -881,7 +868,6 @@ static void blk_mq_timeout_work(struct work_struct *work)
> >  				blk_mq_tag_idle(hctx);
> >  		}
> >  	}
> > -	blk_queue_exit(q);
> >  }
> 
> What prevents that a request queue is removed from set->tag_list while the above
> loop examines tag_list? Can blk_cleanup_queue() queue be called from the context
> of another thread while this loop is examining hardware queues?

Good point. I missed that this needs to hold the tag_list_lock.
  
> > +	timer_setup(&set->timer, blk_mq_timed_out_timer, 0);
> > +	INIT_WORK(&set->timeout_work, blk_mq_timeout_work);
> > [ ... ]
> > --- a/include/linux/blk-mq.h
> > +++ b/include/linux/blk-mq.h
> > @@ -86,6 +86,8 @@ struct blk_mq_tag_set {
> >  
> >  	struct blk_mq_tags	**tags;
> >  
> > +	struct timer_list	timer;
> > +	struct work_struct	timeout_work;
> 
> Can the timer and timeout_work data structures be replaced by a single
> delayed_work instance?

I think so. I wanted to keep blk_add_timer relatively unchanged for this
proposal, so I followed the existing pattern with the timer kicking the
work. I don't see why that extra indirection is necessary, so I think
it's a great idea. Unless anyone knows a reason not to, we can collapse
this into a single delayed work for both mq and legacy as a prep patch
before this one.

Thanks for the feedback!
