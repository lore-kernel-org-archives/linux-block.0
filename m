Return-Path: <ming.lei@redhat.com>
Date: Fri, 28 Apr 2017 11:48:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/6] blk-mq: Make blk_mq_quiesce_queue() wait for all
 .queue_rq() calls
Message-ID: <20170428034850.GD31518@ming.t460p>
References: <20170427155437.23228-1-bart.vanassche@sandisk.com>
 <20170427155437.23228-2-bart.vanassche@sandisk.com>
 <20170428020038.GA31518@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170428020038.GA31518@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

Hi,

On Fri, Apr 28, 2017 at 10:00:44AM +0800, Ming Lei wrote:
> Hi Bart,
> 
> On Thu, Apr 27, 2017 at 08:54:32AM -0700, Bart Van Assche wrote:
> > blk_mq_quiesce_queue() callers, e.g. elevator_switch_mq(), assume
> > that no .queue_rq() calls occur while switching to another I/O
> 
> I think we should call blk_mq_freeze_queue_wait() instead
> of blk_quiesce_queue() in elevator_switch_mq(), otherwise
> it is easy to cause use-after-free.

Sorry, my fault, blk_mq_freeze_queue_wait() has been done in
blk_mq_freeze_queue() already, so no new IO can enter queue
any more, and all old pending IOs will be fninished when 
blk_mq_freeze_queue() returns.

> 
> > scheduler. This patch fixes the following kernel crash if another
> > I/O scheduler than "none" is the default scheduler:
> > 
> > general protection fault: 0000 [#1] SMP
> > RIP: 0010:__lock_acquire+0xfe/0x1280
> > Call Trace:
> >  lock_acquire+0xd5/0x1c0
> >  _raw_spin_lock+0x2a/0x40
> >  dd_dispatch_request+0x29/0x1e0
> >  blk_mq_sched_dispatch_requests+0x139/0x190
> >  __blk_mq_run_hw_queue+0x12d/0x1c0
> >  blk_mq_run_work_fn+0xd/0x10
> >  process_one_work+0x206/0x6a0
> >  worker_thread+0x49/0x4a0
> >  kthread+0x107/0x140
> >  ret_from_fork+0x2e/0x40

So I am just wondering where the I/O in the above issue is
from? and feels there might be other bug behind the issue. 

Also blk_mq_quiesce_queue() in elevator_switch_mq()
shouldn't be necessary.

Thanks,
Ming
