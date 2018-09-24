Return-Path: <jack@suse.cz>
Date: Mon, 24 Sep 2018 18:31:14 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	syzbot <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
	syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
Subject: Re: [PATCH v4] block/loop: Serialize ioctl operations.
Message-ID: <20180924163114.GG28775@quack2.suse.cz>
References: <1537009136-4839-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1af79300-cb04-36e3-a650-168a5942161f@i-love.sakura.ne.jp>
 <20180923220300.GA12589@ming.t460p>
 <ba535251-c206-6242-3e6d-a4ed825c8114@i-love.sakura.ne.jp>
 <20180924123108.GD28775@quack2.suse.cz>
 <c51b5ce0-befb-5b7f-1aab-588d0f14d7b8@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c51b5ce0-befb-5b7f-1aab-588d0f14d7b8@i-love.sakura.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Mon 24-09-18 22:05:20, Tetsuo Handa wrote:
> On 2018/09/24 21:31, Jan Kara wrote:
> > On Mon 24-09-18 19:29:10, Tetsuo Handa wrote:
> >> On 2018/09/24 7:03, Ming Lei wrote:
> >>> On Sat, Sep 22, 2018 at 09:39:02PM +0900, Tetsuo Handa wrote:
> >>>> Hello, Ming Lei.
> >>>>
> >>>> I'd like to hear your comment on this patch regarding the ordering of
> >>>> stopping kernel thread.
> >>>>
> >>>>   > In order to enforce this strategy, this patch inversed
> >>>>   > loop_reread_partitions() and loop_unprepare_queue() in loop_clr_fd().
> >>>>   > I don't know whether it breaks something, but I don't have testcases.
> >>>>
> >>>> Until 3.19, kthread_stop(lo->lo_thread) was called before
> >>>> ioctl_by_bdev(bdev, BLKRRPART, 0) is called.
> >>>> During 4.0 to 4.3, the loop module was using "kloopd" workqueue.
> >>>> But since 4.4, loop_reread_partitions(lo, bdev) is called before
> >>>> loop_unprepare_queue(lo) is called. And this patch is trying to change to
> >>>> call loop_unprepare_queue() before loop_reread_partitions() is called.
> >>>> Is there some reason we need to preserve current ordering?
> >>>
> >>> IMO, both the two orders are fine, and what matters is that 'lo->lo_state'
> >>> is updated before loop_reread_partitions(), then any IO from loop_reread_partitions
> >>> will be failed, so it shouldn't be a big deal wrt. the order between
> >>> loop_reread_partitions() and loop_unprepare_queue().
> >>
> >> OK. Thank you. Here is v4 patch (only changelog was updated).
> >> Andrew, can we test this patch in the -mm tree?
> >>
> >> From 2278250ac8c5b912f7eb7af55e36ed40e2f7116b Mon Sep 17 00:00:00 2001
> >> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> Date: Mon, 24 Sep 2018 18:58:37 +0900
> >> Subject: [PATCH v4] block/loop: Serialize ioctl operations.
> >>
> >> syzbot is reporting NULL pointer dereference [1] which is caused by
> >> race condition between ioctl(loop_fd, LOOP_CLR_FD, 0) versus
> >> ioctl(other_loop_fd, LOOP_SET_FD, loop_fd) due to traversing other
> >> loop devices without holding corresponding locks.
> >>
> >> syzbot is also reporting circular locking dependency between bdev->bd_mutex
> >> and lo->lo_ctl_mutex [2] which is caused by calling blkdev_reread_part()
> >> with lock held.
> > 
> > Thanks for looking into the loop crashes Tetsuo. I was looking into the
> > loop code and trying to understand how your patch fixes them but I've
> > failed. Can you please elaborate a bit on how exactly LOOP_CLR_FD and
> > LOOP_SET_FD race to hit NULL pointer dereference? I don't really see the
> > code traversing other loop devices as you mention in your changelog so I'm
> > probably missing something. Thanks.
> > 
> 
> That is explained in a discussion for [1] at
> https://groups.google.com/forum/#!msg/syzkaller-bugs/c8KUcTAzTvA/3o_7g6-tAwAJ
> .  In the current code, the location of dangerous traversal is in
> loop_validate_file().

OK, thanks for explanation! I'll send some comments in reply to your patch.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
