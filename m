Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
To: jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, tj@kernel.org, david@fromorbit.com
Subject: Re: [PATCH] bdi: Fix oops in wb_workfn()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180503162626.27753-1-jack@suse.cz>
	<201805040735.ADG57320.VFOQOJMOLHFStF@I-love.SAKURA.ne.jp>
	<201805192327.JIF05779.OQFJFStOOMLFVH@I-love.SAKURA.ne.jp>
	<20180521093823.kjj5tk7ko244jv4d@quack2.suse.cz>
In-Reply-To: <20180521093823.kjj5tk7ko244jv4d@quack2.suse.cz>
Message-Id: <201805251915.FGH64517.HVFJOOLFFMQStO@I-love.SAKURA.ne.jp>
Date: Fri, 25 May 2018 19:15:32 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Jan Kara wrote:
> > void delayed_work_timer_fn(struct timer_list *t)
> > {
> > 	struct delayed_work *dwork = from_timer(dwork, t, timer);
> > 
> > 	/* should have been called from irqsafe timer with irq already off */
> > 	__queue_work(dwork->cpu, dwork->wq, &dwork->work);
> > }
> > 
> > Then, wb_workfn() is after all scheduled even if we check for
> > WB_registered bit, isn't it?
> 
> It can be queued after WB_registered bit is cleared but it cannot be queued
> after mod_delayed_work(bdi_wq, &wb->dwork, 0) has finished. That function
> deletes the pending timer (the timer cannot be armed again because
> WB_registered is cleared) and queues what should be the last round of
> wb_workfn().

mod_delayed_work() deletes the pending timer but does not wait for already
invoked timer handler to complete because it is using del_timer() rather than
del_timer_sync(). Then, what happens if __queue_work() is almost concurrently
executed from two CPUs, one from mod_delayed_work(bdi_wq, &wb->dwork, 0) from
wb_shutdown() path (which is called without spin_lock_bh(&wb->work_lock)) and
the other from delayed_work_timer_fn() path (which is called without checking
WB_registered bit under spin_lock_bh(&wb->work_lock)) ?

wb_wakeup_delayed() {
  spin_lock_bh(&wb->work_lock);
  if (test_bit(WB_registered, &wb->state)) // succeeds
    queue_delayed_work(bdi_wq, &wb->d_work, timeout) {
      queue_delayed_work_on(WORK_CPU_UNBOUND, bdi_wq, &wb->d_work, timeout) {
         if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&wb->d_work.work))) { // succeeds
           __queue_delayed_work(WORK_CPU_UNBOUND, bdi_wq, &wb->d_work, timeout) {
             add_timer(timer); // schedules for delayed_work_timer_fn()
           }
         }
      }
    }
  spin_unlock_bh(&wb->work_lock);
}

delayed_work_timer_fn() {
  // del_timer() already returns false at this point because this timer
  // is already inside handler. But something took long here enough to
  // wait for __queue_work() from wb_shutdown() path to finish?
  __queue_work(WORK_CPU_UNBOUND, bdi_wq, &wb->d_work.work) {
    insert_work(pwq, work, worklist, work_flags);
  }
}

wb_shutdown() {
  mod_delayed_work(bdi_wq, &wb->dwork, 0) {
    mod_delayed_work_on(WORK_CPU_UNBOUND, bdi_wq, &wb->dwork, 0) {
      ret = try_to_grab_pending(&wb->dwork.work, true, &flags) {
        if (likely(del_timer(&wb->dwork.timer))) // fails because already in delayed_work_timer_fn()
          return 1;
        if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&wb->dwork.work))) // fails because already set by queue_delayed_work()
          return 0;
        // Returns 1 or -ENOENT after doing something?
      }
      if (ret >= 0)
        __queue_delayed_work(WORK_CPU_UNBOUND, bdi_wq, &wb->dwork, 0) {
          __queue_work(WORK_CPU_UNBOUND, bdi_wq, &wb->dwork.work) {
            insert_work(pwq, work, worklist, work_flags);
          }
        }
    }
  }
}
