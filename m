Return-Path: <jack@suse.cz>
Date: Mon, 21 May 2018 11:38:23 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: jack@suse.cz, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, tj@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH] bdi: Fix oops in wb_workfn()
Message-ID: <20180521093823.kjj5tk7ko244jv4d@quack2.suse.cz>
References: <20180503162626.27753-1-jack@suse.cz>
 <201805040735.ADG57320.VFOQOJMOLHFStF@I-love.SAKURA.ne.jp>
 <201805192327.JIF05779.OQFJFStOOMLFVH@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201805192327.JIF05779.OQFJFStOOMLFVH@I-love.SAKURA.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Sat 19-05-18 23:27:09, Tetsuo Handa wrote:
> Tetsuo Handa wrote:
> > Jan Kara wrote:
> > > Make wb_workfn() use wakeup_wb() for requeueing the work which takes all
> > > the necessary precautions against racing with bdi unregistration.
> > 
> > Yes, this patch will solve NULL pointer dereference bug. But is it OK to leave
> > list_empty(&wb->work_list) == false situation? Who takes over the role of making
> > list_empty(&wb->work_list) == true?
> 
> syzbot is again reporting the same NULL pointer dereference.
> 
>   general protection fault in wb_workfn (2)
>   https://syzkaller.appspot.com/bug?id=e0818ccb7e46190b3f1038b0c794299208ed4206

Gaah... So we are still missing something.

> Didn't we overlook something obvious in commit b8b784958eccbf8f ("bdi:
> Fix oops in wb_workfn()") ?
> 
> At first, I thought that that commit will solve NULL pointer dereference bug.
> But what does
> 
>  	if (!list_empty(&wb->work_list))
> -		mod_delayed_work(bdi_wq, &wb->dwork, 0);
> +		wb_wakeup(wb);
>  	else if (wb_has_dirty_io(wb) && dirty_writeback_interval)
>  		wb_wakeup_delayed(wb);
> 
> mean?
> 
> static void wb_wakeup(struct bdi_writeback *wb)
> {
> 	spin_lock_bh(&wb->work_lock);
> 	if (test_bit(WB_registered, &wb->state))
> 		mod_delayed_work(bdi_wq, &wb->dwork, 0);
> 	spin_unlock_bh(&wb->work_lock);
> }
> 
> It means nothing but "we don't call mod_delayed_work() if WB_registered
> bit was already cleared".

Exactly.

> But if WB_registered bit is not yet cleared when we hit
> wb_wakeup_delayed() path?
> 
> void wb_wakeup_delayed(struct bdi_writeback *wb)
> {
> 	unsigned long timeout;
> 
> 	timeout = msecs_to_jiffies(dirty_writeback_interval * 10);
> 	spin_lock_bh(&wb->work_lock);
> 	if (test_bit(WB_registered, &wb->state))
> 		queue_delayed_work(bdi_wq, &wb->dwork, timeout);
> 	spin_unlock_bh(&wb->work_lock);
> }
> 
> add_timer() is called because (presumably) timeout > 0. And after that
> timeout expires, __queue_work() is called even if WB_registered bit is
> already cleared before that timeout expires, isn't it?

Yes.

> void delayed_work_timer_fn(struct timer_list *t)
> {
> 	struct delayed_work *dwork = from_timer(dwork, t, timer);
> 
> 	/* should have been called from irqsafe timer with irq already off */
> 	__queue_work(dwork->cpu, dwork->wq, &dwork->work);
> }
> 
> Then, wb_workfn() is after all scheduled even if we check for
> WB_registered bit, isn't it?

It can be queued after WB_registered bit is cleared but it cannot be queued
after mod_delayed_work(bdi_wq, &wb->dwork, 0) has finished. That function
deletes the pending timer (the timer cannot be armed again because
WB_registered is cleared) and queues what should be the last round of
wb_workfn().

> Then, don't we need to check that
> 
> 	mod_delayed_work(bdi_wq, &wb->dwork, 0);
> 	flush_delayed_work(&wb->dwork);
> 
> is really waiting for completion? At least, shouldn't we try below debug
> output (not only for debugging this report but also generally desirable)?
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 7441bd9..ccec8cd 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -376,8 +376,10 @@ static void wb_shutdown(struct bdi_writeback *wb)
>  	 * tells wb_workfn() that @wb is dying and its work_list needs to
>  	 * be drained no matter what.
>  	 */
> -	mod_delayed_work(bdi_wq, &wb->dwork, 0);
> -	flush_delayed_work(&wb->dwork);
> +	if (!mod_delayed_work(bdi_wq, &wb->dwork, 0))
> +		printk(KERN_WARNING "wb_shutdown: mod_delayed_work() failed\n");

false return from mod_delayed_work() just means that there was no timer
armed. That is a valid situation if there are no dirty data.

> +	if (!flush_delayed_work(&wb->dwork))
> +		printk(KERN_WARNING "wb_shutdown: flush_delayed_work() failed\n");

And this is valid as well (although unlikely) if the work managed to
complete on another CPU before flush_delayed_work() was called.

So I don't think your warnings will help us much. But yes, we need to debug
this somehow. For now I have no idea what could be still going wrong.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
