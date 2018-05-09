Return-Path: <jack@suse.cz>
Date: Wed, 9 May 2018 11:47:19 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, axboe@kernel.dk, tj@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH] bdi: Fix oops in wb_workfn()
Message-ID: <20180509094719.sjlw5y4f3cp3tkj7@quack2.suse.cz>
References: <20180503162626.27753-1-jack@suse.cz>
 <201805040735.ADG57320.VFOQOJMOLHFStF@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201805040735.ADG57320.VFOQOJMOLHFStF@I-love.SAKURA.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Fri 04-05-18 07:35:34, Tetsuo Handa wrote:
> Jan Kara wrote:
> > Make wb_workfn() use wakeup_wb() for requeueing the work which takes all
> > the necessary precautions against racing with bdi unregistration.
> 
> Yes, this patch will solve NULL pointer dereference bug. But is it OK to
> leave list_empty(&wb->work_list) == false situation? Who takes over the
> role of making list_empty(&wb->work_list) == true?

That's a good question. The reason is the last running instance of
wb_workfn() cannot leave with the work_list non-empty. Once WB_registered
is cleared we cannot add new entries to work_list. Then we'll queue and
flush last wb_workfn() to clean up the list. The problem with NULL ptr
deref has been triggered not by this last running wb_workfn() but by one
running independently in parallel to wb_shutdown(). So something like:

CPU0			CPU1			CPU2
wb_workfn()
  do {
    ...
  } while (!list_empty(&wb->work_list));
			wb_queue_work()
			  if (test_bit(WB_registered, &wb->state)) {
			    list_add_tail(&work->list, &wb->work_list);
			    mod_delayed_work(bdi_wq, &wb->dwork, 0);
			  }
						wb_shutdown()
						  if (!test_and_clear_bit(WB_registered, &wb->state)) {
						  ...
						  mod_delayed_work(bdi_wq, &wb->dwork, 0);
						  flush_delayed_work(&wb->dwork);
  if (!list_empty(&wb->work_list))
    mod_delayed_work(bdi_wq, &wb->dwork, 0); -> queues buggy work

> Just a confirmation, for Fabiano Rosas is facing a problem that "write call
> hangs in kernel space after virtio hot-remove" and is thinking that we might
> need to go the opposite direction
> ( http://lkml.kernel.org/r/f0787b79-1e50-5f55-a400-44f715451777@linux.ibm.com ).

Yes, I'm aware of that report and I think it should be solved
differently than what Fabiano suggests.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
