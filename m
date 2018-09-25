Return-Path: <jack@suse.cz>
Date: Tue, 25 Sep 2018 10:06:22 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	syzbot <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
	syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
Subject: Re: [PATCH v4] block/loop: Serialize ioctl operations.
Message-ID: <20180925080622.GA6567@quack2.suse.cz>
References: <1537009136-4839-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1af79300-cb04-36e3-a650-168a5942161f@i-love.sakura.ne.jp>
 <20180923220300.GA12589@ming.t460p>
 <ba535251-c206-6242-3e6d-a4ed825c8114@i-love.sakura.ne.jp>
 <20180924184734.GH28775@quack2.suse.cz>
 <70de0609-c9f5-1747-93dc-fc4d693f1c27@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <70de0609-c9f5-1747-93dc-fc4d693f1c27@i-love.sakura.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Tue 25-09-18 06:06:56, Tetsuo Handa wrote:
> On 2018/09/25 3:47, Jan Kara wrote:
> >> +/*
> >> + * unlock_loop - Unlock loop_mutex as needed.
> >> + *
> >> + * Explicitly call this function before calling fput() or blkdev_reread_part()
> >> + * in order to avoid circular lock dependency. After this function is called,
> >> + * current thread is no longer allowed to access "struct loop_device" memory,
> >> + * for another thread would access that memory as soon as loop_mutex is held.
> >> + */
> >> +static void unlock_loop(void)
> >> +{
> >> +	if (loop_mutex_owner == current) {
> > 
> > Urgh, why this check? Conditional locking / unlocking is evil so it has to
> > have *very* good reasons and there is not any explanation here. So far I
> > don't see a reason why this is needed at all.
> 
> Yeah, this is why Jens hates this patch. But any alternative?

So can you explain why this conditional locking is really necessary?

> >> @@ -630,7 +669,12 @@ static void loop_reread_partitions(struct loop_device *lo,
> >> +	unlock_loop();
> > 
> > Unlocking in loop_reread_partitions() makes the locking rules ugly. And
> > unnecessarily AFAICT. Can't we just use lo_refcnt to protect us against
> > loop_clr_fd() and freeing of 'lo' structure itself?
> 
> Really? I think that just elevating lo->lo_refcnt will cause another lockdep
> warning because __blkdev_reread_part() requires bdev->bd_mutex being held.
> Don't we need to drop the lock in order to solve original lockdep warning at [2] ?

Yes, you have to drop the lo_ctl_mutex before calling
loop_reread_partitions(). But AFAICS all places calling loop_reread_part()
are called from ioctl where we are sure the device is open and thus
lo_refcnt is > 0. So in these places calling loop_reread_partitions()
without lo_ctl_mutex should be fine. The only exception is lo_clr_fd() that
can get called from __lo_release() - and I think we can protect that case
against LOOP_CTL_REMOVE (it cannot really race with anything else) by
keeping lo_state at Lo_rundown until after loop_reread_partitions() has
finished.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
