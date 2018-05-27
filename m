Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: general protection fault in wb_workfn (2)
To: syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, jack@suse.cz
References: <000000000000cbd959056d1851ca@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, tj@kernel.org,
        david@fromorbit.com, linux-block@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <0c7c5dea-7312-8a59-9d1b-5467f69719bf@I-love.SAKURA.ne.jp>
Date: Sun, 27 May 2018 09:47:54 +0900
MIME-Version: 1.0
In-Reply-To: <000000000000cbd959056d1851ca@google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Forwarding http://lkml.kernel.org/r/201805251915.FGH64517.HVFJOOLFFMQStO@I-love.SAKURA.ne.jp .

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
