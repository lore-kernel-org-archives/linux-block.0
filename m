Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 9 Jan 2018 07:46:07 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "jbacik@fb.com" <jbacik@fb.com>, "jack@suse.cz" <jack@suse.cz>,
	"clm@fb.com" <clm@fb.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 3/8] blk-mq: replace timeout synchronization with a RCU
 and generation based scheme
Message-ID: <20180109154607.GJ3668920@devbig577.frc2.facebook.com>
References: <20180108191542.379478-1-tj@kernel.org>
 <20180108191542.379478-4-tj@kernel.org>
 <1515445614.2909.18.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515445614.2909.18.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 08, 2018 at 09:06:55PM +0000, Bart Van Assche wrote:
> On Mon, 2018-01-08 at 11:15 -0800, Tejun Heo wrote:
> > +static void blk_mq_rq_update_aborted_gstate(struct request *rq, u64 gstate)
> > +{
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +	u64_stats_update_begin(&rq->aborted_gstate_sync);
> > +	rq->aborted_gstate = gstate;
> > +	u64_stats_update_end(&rq->aborted_gstate_sync);
> > +	local_irq_restore(flags);
> > +}
> 
> Please add a comment that explains the purpose of local_irq_save() and
> local_irq_restore(). Please also explain why you chose to disable interrupts

Will do.

> instead of disabling preemption. I think that disabling preemption should be
> sufficient since this is the only code that updates rq->aborted_gstate and
> since this function is always called from thread context.

blk_mq_complete_request() can read it from the irq context.  If that
happens between update_begin and end, it'll end up looping infinitely.

> > @@ -801,6 +840,12 @@ void blk_mq_rq_timed_out(struct request *req, bool reserved)
> >  		__blk_mq_complete_request(req);
> >  		break;
> >  	case BLK_EH_RESET_TIMER:
> > +		/*
> > +		 * As nothing prevents from completion happening while
> > +		 * ->aborted_gstate is set, this may lead to ignored
> > +		 * completions and further spurious timeouts.
> > +		 */
> > +		blk_mq_rq_update_aborted_gstate(req, 0);
> >  		blk_add_timer(req);
> >  		blk_clear_rq_complete(req);
> >  		break;
> 
> Is the race that the comment refers to addressed by one of the later patches?

No, but it's not a new race.  It has always been there and I suppose
doesn't lead to practical problems - the race window is pretty small
and the effect isn't critical.  I'm just documenting the existing race
condition.  Will note that in the description.

Thanks.

-- 
tejun
