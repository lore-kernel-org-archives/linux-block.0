Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751503AbeECQFR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 May 2018 12:05:17 -0400
Message-ID: <0e80a398d8384741f8151212c63cbdff42c9cad1.camel@kernel.org>
Subject: Re: write call hangs in kernel space after virtio hot-remove
From: Jeff Layton <jlayton@kernel.org>
To: Jan Kara <jack@suse.cz>, Fabiano Rosas <farosas@linux.ibm.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tj@kernel.org, Matthew Wilcox <willy@infradead.org>
Date: Thu, 03 May 2018 12:05:14 -0400
In-Reply-To: <20180503144255.gortapk4rfqib3kj@quack2.suse.cz>
References: <f0787b79-1e50-5f55-a400-44f715451777@linux.ibm.com>
         <20180503144255.gortapk4rfqib3kj@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2018-05-03 at 16:42 +0200, Jan Kara wrote:
> On Wed 25-04-18 17:07:48, Fabiano Rosas wrote:
> > I'm looking into an issue where removing a virtio disk via sysfs while another
> > process is issuing write() calls results in the writing task going into a
> > livelock:
> > 
> > 
> > root@guest # cat test.sh
> > #!/bin/bash
> > 
> > dd if=/dev/zero of=/dev/vda bs=1M count=10000 &
> > sleep 1
> > echo 1 > /sys/bus/pci/devices/0000:00:04.0/remove
> > 
> > root@guest # ls /dev/vd*
> > /dev/vda
> > 
> > root@guest # grep Dirty /proc/meminfo
> > Dirty:                 0 kB
> > 
> > root@guest # sh test.sh
> > 
> > root@guest # ps aux | grep "[d]d if"
> > root      1699 38.6  0.0 111424  1216 hvc0     D+   10:48   0:01 dd if=/dev/zero of=/dev/vda bs=1M count=10000
> > 
> > root@guest # ls /dev/vd*
> > ls: cannot access /dev/vd*: No such file or directory
> > 
> > root@guest # cat /proc/1699/stack
> > [<0>] 0xc0000000ffe28218
> > [<0>] __switch_to+0x31c/0x480
> > [<0>] balance_dirty_pages+0x990/0xb90
> > [<0>] balance_dirty_pages_ratelimited+0x50c/0x6c0
> > [<0>] generic_perform_write+0x1b0/0x260
> > [<0>] __generic_file_write_iter+0x200/0x240
> > [<0>] blkdev_write_iter+0xa4/0x150
> > [<0>] __vfs_write+0x14c/0x240
> > [<0>] vfs_write+0xd0/0x240
> > [<0>] ksys_write+0x6c/0x110
> > [<0>] system_call+0x58/0x6c
> > 
> > root@guest # grep Dirty /proc/meminfo
> > Dirty:           1506816 kB
> > 
> > ---
> > 
> > I have done some tracing and I believe this is caused by the clearing of
> > 'WB_registered' in 'wb_shutdown':
> > 
> > <snip>
> > sh-1697  [000] ....  3994.541664: sysfs_remove_link <-del_gendisk
> > sh-1697  [000] ....  3994.541671: wb_shutdown <-bdi_unregister
> > <snip>
> > 
> > Later, when 'balance_dirty_pages' tries to start writeback, it doesn't happen
> > because 'WB_registered' is not set:
> > 
> > fs/fs-writeback.c
> > 
> > static void wb_wakeup(struct bdi_writeback *wb)
> > {
> >         spin_lock_bh(&wb->work_lock);
> >         if (test_bit(WB_registered, &wb->state))
> >                 mod_delayed_work(bdi_wq, &wb->dwork, 0);
> >         spin_unlock_bh(&wb->work_lock);
> > }
> > 
> > So we get stuck in a loop in 'balance_dirty_pages':
> > 
> > root@guest # cat /sys/kernel/debug/tracing/set_ftrace_filter
> > balance_dirty_pages_ratelimited
> > balance_dirty_pages
> > wb_wakeup
> > wb_workfn
> > io_schedule_timeout
> > 
> > <snip>
> > dd-1699  [000] .... 11192.535946: wb_wakeup <-balance_dirty_pages
> > dd-1699  [000] .... 11192.535950: io_schedule_timeout <-balance_dirty_pages
> > dd-1699  [000] .... 11192.745968: wb_wakeup <-balance_dirty_pages
> > dd-1699  [000] .... 11192.745972: io_schedule_timeout <-balance_dirty_pages
> > <snip>
> > 
> > 
> > The test on 'WB_registered' before starting the writeback task is introduced
> > by: "5acda9 bdi: avoid oops on device removal".
> > 
> > I have made a *naive* attempt at fixing it by allowing writeback to happen even
> > without 'WB_registered':
> > 
> > 
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index d4d04fe..050b067 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -982,7 +982,7 @@ void wb_start_background_writeback(struct bdi_writeback *wb)
> >  	 * writeback as soon as there is no other work to do.
> >  	 */
> >  	trace_writeback_wake_background(wb);
> > -	wb_wakeup(wb);
> > +	mod_delayed_work(bdi_wq, &wb->dwork, 0);
> >  }
> >  
> >  /*
> > @@ -1933,7 +1933,7 @@ void wb_workfn(struct work_struct *work)
> >  						struct bdi_writeback, dwork);
> >  	long pages_written;
> >  
> > -	set_worker_desc("flush-%s", dev_name(wb->bdi->dev));
> > +	set_worker_desc("flush-%s", wb->bdi->dev ? dev_name(wb->bdi->dev) : "?" );
> >  	current->flags |= PF_SWAPWRITE;
> >  
> >  	if (likely(!current_is_workqueue_rescuer() ||
> > --
> > 
> > 
> > The effect of that is that the 'dd' process now finishes successfully and we
> > get "Buffer I/O error"s for the dirty pages that remain. I believe this to be
> > in conformance with existing interfaces since dd does not issue any fsync()
> > calls.
> > 
> > 
> > Does my analysis make any sense and would something along these lines be
> > acceptable as a solution?
> 
> Thanks for the debugging of the problem. I agree with your analysis however
> I don't like your fix. The issue is that when bdi is unregistered we don't
> really expect any writeback to happen after that moment. This is what
> prevents various use-after-free issues and I'd like that to stay the way it
> is.
> 
> What I think we should do is that we'll prevent dirtying of new pages when
> we know the underlying device is gone. Because that will fix your problem
> and also make sure user sees the IO errors directly instead of just in the
> kernel log. The question is how to make this happen in the least painful
> way. I think we could intercept writes in grab_cache_page_write_begin()
> (which however requires that function to return a proper error code and not
> just NULL / non-NULL). And we should also intercept write faults to not
> allow page dirtying via mmap - probably somewhere in do_shared_fault() and
> do_wp_page(). I've added Jeff to CC since he's dealing with IO error
> handling a lot these days. Jeff, what do you think?
> 
> 								Honza

(cc'ing Willy too since he's given this more thought than me)

For the record, I've mostly been looking at error _reporting_. Handling
errors at this level is not something I've really considered in great
detail as of yet.

Still, I think the basic idea sounds reasonable. Not allowing pages to
be dirtied when we can't clean them seems like a reasonable thing to
do.

The big question is how we'll report this to userland:

Would your approach have it return an error on write() and such? What
sort of error if so? ENODEV? Would we have to SIGBUS when someone tries
to dirty the page through mmap?
--
Jeff Layton <jlayton@kernel.org>
