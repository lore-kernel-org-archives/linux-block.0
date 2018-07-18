Return-Path: <ming.lei@redhat.com>
Date: Thu, 19 Jul 2018 06:45:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
	"hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 2/3] block, scsi: Rework runtime power management
Message-ID: <20180718224545.GA15589@ming.t460p>
References: <20180717234940.11231-1-bart.vanassche@wdc.com>
 <20180717234940.11231-3-bart.vanassche@wdc.com>
 <CACVXFVPP6bY9YijDSyQg9OOR4ge9LyR+naWNDeLGOS=WFL_7CA@mail.gmail.com>
 <60ce50f281bf41483b53246d509697f6d95360f8.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <60ce50f281bf41483b53246d509697f6d95360f8.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 18, 2018 at 03:45:15PM +0000, Bart Van Assche wrote:
> On Wed, 2018-07-18 at 20:16 +0800, Ming Lei wrote:
> > On Wed, Jul 18, 2018 at 7:49 AM, Bart Van Assche <bart.vanassche@wdc.com> wrote:
> > > @@ -3801,8 +3778,11 @@ int blk_pre_runtime_suspend(struct request_queue *q)
> > >         if (!q->dev)
> > >                 return ret;
> > > 
> > > +       blk_set_preempt_only(q);
> > > +       blk_freeze_queue_start(q);
> > > +
> > >         spin_lock_irq(q->queue_lock);
> > > -       if (q->nr_pending) {
> > > +       if (!percpu_ref_is_zero(&q->q_usage_counter)) {
> > 
> > This way can't work reliably because the percpu ref isn't in atomic mode
> > yet after blk_freeze_queue_start() returns, then percpu_ref_is_zero() won't
> > see accurate value of the counter, finally the device may be put down before
> > in-flight requests are completed by hardware.
> 
> Hello Ming,
> 
> The blk_freeze_queue_start() implementation is as follows:
> 
> void blk_freeze_queue_start(struct request_queue *q)
> {
> 	int freeze_depth;
> 
> 	freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
> 	if (freeze_depth == 1) {
> 		percpu_ref_kill(&q->q_usage_counter);
> 		if (q->mq_ops)
> 			blk_mq_run_hw_queues(q, false);
> 	}
> }
> 
> From the documentation header in include/linux/percpu-refcount.h above
> percpu_ref_kill():
> 
>  * Switches @ref into atomic mode before gathering up the percpu counters
>  * and dropping the initial ref.

IMO, the comment isn't accurate enough. Yes, the counter becomes atomic
mode after percpu_ref_kill() returns, but the counter can't be retrieved
accurately before the rcu confirmation is done.

One extra get is done in __percpu_ref_switch_to_atomic(), and the put pair
is run in percpu_ref_call_confirm_rcu(), which is scheduled via call_rcu_sched().

So once blk_freeze_queue_start() returns, percpu_ref_is_zero() won't
return true only until the rcu confirmation is done. That means this
approach may not put device down.

Thanks,
Ming
