Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH v3] block/loop: Serialize ioctl operations.
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot
 <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
        syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
References: <1527297408-4428-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <ce5ce21a-5865-36c5-a110-eed11f785ab2@I-love.SAKURA.ne.jp>
Date: Mon, 4 Jun 2018 20:19:02 +0900
MIME-Version: 1.0
In-Reply-To: <1527297408-4428-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

This problem was already ignored for 8 months. Unless we boost priority,
this problem will be ignored for years. Jens, can we test this patch?

On 2018/05/26 10:16, Tetsuo Handa wrote:
> syzbot is reporting NULL pointer dereference [1] which is caused by
> race condition between ioctl(loop_fd, LOOP_CLR_FD, 0) versus
> ioctl(other_loop_fd, LOOP_SET_FD, loop_fd) due to traversing other
> loop devices without holding corresponding locks.
> 
> syzbot is also reporting circular locking dependency between bdev->bd_mutex
> and lo->lo_ctl_mutex [2] which is caused by calling blkdev_reread_part()
> with lock held.
> 
> Since ioctl() request on loop devices is not frequent operation, we don't
> need fine grained locking. Let's use global lock and simplify the locking
> order.
> 
> Strategy is that the global lock is held upon entry of ioctl() request,
> and release it before either starting operations which might deadlock or
> leaving ioctl() request. After the global lock is released, current thread
> no longer uses "struct loop_device" memory because it might be modified
> by next ioctl() request which was waiting for current ioctl() request.
> 
> In order to enforce this strategy, this patch inversed
> loop_reread_partitions() and loop_unprepare_queue() in loop_clr_fd().
> I don't know whether it breaks something, but I don't have testcases.
> 
> Since this patch serializes using global lock, race bugs should no longer
> exist. Thus, it will be easy to test whether this patch broke something.
> 
> [1] https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3
> [2] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
> Reported-by: syzbot <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/block/loop.c | 231 ++++++++++++++++++++++++++++-----------------------
>  drivers/block/loop.h |   1 -
>  2 files changed, 128 insertions(+), 104 deletions(-)
