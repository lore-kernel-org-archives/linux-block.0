Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 29 May 2018 06:46:14 -0700
From: Tejun Heo <tj@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, jack@suse.cz,
	viro@zeniv.linux.org.uk, axboe@kernel.dk, david@fromorbit.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
Message-ID: <20180529134614.GF1351649@devbig577.frc2.facebook.com>
References: <000000000000cbd959056d1851ca@google.com>
 <0c7c5dea-7312-8a59-9d1b-5467f69719bf@I-love.SAKURA.ne.jp>
 <314ae2e0-c873-04ce-9cd5-fe2acadaee26@I-love.SAKURA.ne.jp>
 <20180527023602.GE1351649@devbig577.frc2.facebook.com>
 <201805271343.JCF65186.HOMQSOtFFVJOFL@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201805271343.JCF65186.HOMQSOtFFVJOFL@I-love.SAKURA.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Sun, May 27, 2018 at 01:43:45PM +0900, Tetsuo Handa wrote:
> Tejun Heo wrote:
> > On Sun, May 27, 2018 at 11:21:25AM +0900, Tetsuo Handa wrote:
> > > syzbot is still hitting NULL pointer dereference at wb_workfn() [1].
> > > This might be because we overlooked that delayed_work_timer_fn() does not
> > > check WB_registered before calling __queue_work() while mod_delayed_work()
> > > does not wait for already started delayed_work_timer_fn() because it uses
> > > del_timer() rather than del_timer_sync().
> > 
> > It shouldn't be that as dwork timer is an irq safe timer.  Even if
> > that's the case, the right thing to do would be fixing workqueue
> > rather than reaching into workqueue internals from backing-dev code.
> > 
> 
> Do you think that there is possibility that __queue_work() is almost concurrently
> executed from two CPUs, one from mod_delayed_work(bdi_wq, &wb->dwork, 0) from
> wb_shutdown() path (which is called without spin_lock_bh(&wb->work_lock)) and
> the other from delayed_work_timer_fn() path (which is called without checking
> WB_registered bit under spin_lock_bh(&wb->work_lock)) ?

__queue_work() is gated by WORK_STRUCT_PENDING_BIT, so I don't see how
multiple instances would execute concurrently for the same work item.

Thanks.

-- 
tejun
