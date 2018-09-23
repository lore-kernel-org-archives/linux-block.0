Return-Path: <ming.lei@redhat.com>
Date: Mon, 24 Sep 2018 06:03:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	syzbot <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
	syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
Subject: Re: [PATCH v3 (resend)] block/loop: Serialize ioctl operations.
Message-ID: <20180923220300.GA12589@ming.t460p>
References: <1537009136-4839-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1af79300-cb04-36e3-a650-168a5942161f@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1af79300-cb04-36e3-a650-168a5942161f@i-love.sakura.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Sat, Sep 22, 2018 at 09:39:02PM +0900, Tetsuo Handa wrote:
> Hello, Ming Lei.
> 
> I'd like to hear your comment on this patch regarding the ordering of
> stopping kernel thread.
> 
>   > In order to enforce this strategy, this patch inversed
>   > loop_reread_partitions() and loop_unprepare_queue() in loop_clr_fd().
>   > I don't know whether it breaks something, but I don't have testcases.
> 
> Until 3.19, kthread_stop(lo->lo_thread) was called before
> ioctl_by_bdev(bdev, BLKRRPART, 0) is called.
> During 4.0 to 4.3, the loop module was using "kloopd" workqueue.
> But since 4.4, loop_reread_partitions(lo, bdev) is called before
> loop_unprepare_queue(lo) is called. And this patch is trying to change to
> call loop_unprepare_queue() before loop_reread_partitions() is called.
> Is there some reason we need to preserve current ordering?

IMO, both the two orders are fine, and what matters is that 'lo->lo_state'
is updated before loop_reread_partitions(), then any IO from loop_reread_partitions
will be failed, so it shouldn't be a big deal wrt. the order between
loop_reread_partitions() and loop_unprepare_queue().

Thanks,
Ming
