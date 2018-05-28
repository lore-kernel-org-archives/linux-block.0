Return-Path: <jack@suse.cz>
Date: Mon, 28 May 2018 15:35:03 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, axboe@kernel.dk, tj@kernel.org,
	david@fromorbit.com, linux-block@vger.kernel.org
Subject: Re: general protection fault in wb_workfn (2)
Message-ID: <20180528133503.awomzj6djozbo5bv@quack2.suse.cz>
References: <000000000000cbd959056d1851ca@google.com>
 <0c7c5dea-7312-8a59-9d1b-5467f69719bf@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0c7c5dea-7312-8a59-9d1b-5467f69719bf@I-love.SAKURA.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Sun 27-05-18 09:47:54, Tetsuo Handa wrote:
> Forwarding http://lkml.kernel.org/r/201805251915.FGH64517.HVFJOOLFFMQStO@I-love.SAKURA.ne.jp .
> 
> Jan Kara wrote:
> > > void delayed_work_timer_fn(struct timer_list *t)
> > > {
> > > 	struct delayed_work *dwork = from_timer(dwork, t, timer);
> > > 
> > > 	/* should have been called from irqsafe timer with irq already off */
> > > 	__queue_work(dwork->cpu, dwork->wq, &dwork->work);
> > > }
> > > 
> > > Then, wb_workfn() is after all scheduled even if we check for
> > > WB_registered bit, isn't it?
> > 
> > It can be queued after WB_registered bit is cleared but it cannot be queued
> > after mod_delayed_work(bdi_wq, &wb->dwork, 0) has finished. That function
> > deletes the pending timer (the timer cannot be armed again because
> > WB_registered is cleared) and queues what should be the last round of
> > wb_workfn().
> 
> mod_delayed_work() deletes the pending timer but does not wait for already
> invoked timer handler to complete because it is using del_timer() rather than
> del_timer_sync(). Then, what happens if __queue_work() is almost concurrently
> executed from two CPUs, one from mod_delayed_work(bdi_wq, &wb->dwork, 0) from
> wb_shutdown() path (which is called without spin_lock_bh(&wb->work_lock)) and
> the other from delayed_work_timer_fn() path (which is called without checking
> WB_registered bit under spin_lock_bh(&wb->work_lock)) ?

In this case, work should still be queued only once. The synchronization in
this case should be provided by the WORK_STRUCT_PENDING_BIT. When a delayed
work is queued by mod_delayed_work(), this bit is set, and gets cleared
only once the work is started on some CPU. But admittedly this code is
rather convoluted so I may be missing something.

Also you should note that flush_delayed_work() which follows
mod_delayed_work() in wb_shutdown() does del_timer_sync() so I don't see
how anything could get past that. In fact mod_delayed_work() is in
wb_shutdown() path to make sure wb_workfn() gets executed at least once
before the bdi_writeback structure gets cleaned up so that all queued items
are finished. We do not rely on it to remove pending timers or queued
wb_workfn() executions.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
