Return-Path: <vgoyal@redhat.com>
Date: Tue, 13 Sep 2016 09:46:46 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Hou Tao <houtao1@huawei.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] blk-throttle: fix infinite throttling caused by
 non-cascading timer wheel
Message-ID: <20160913134646.GA19320@redhat.com>
References: <1473662730-184701-1-git-send-email-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473662730-184701-1-git-send-email-houtao1@huawei.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 12, 2016 at 02:45:30PM +0800, Hou Tao wrote:
> Due to commit 500462a9de65 ("timers: Switch to a non-cascading wheel"),
> the slack of timer increases when the timeout increases:
> 
>  So for HZ=250 we end up with the following granularity levels:
>   Level Offset   Granularity                  Range
>       0      0          4 ms                 0 ms -        252 ms
>       1     64         32 ms               256 ms -       2044 ms (256ms - ~2s)
>       2    128        256 ms              2048 ms -      16380 ms (~2s   - ~16s)
> 
> When the slack is bigger than throtl_slice (100ms), there will be
> a problem: throtl_slice_used() will always return true, a new slice
> will always be genereated, and the bio will be throttled forever.
> 
> The following is a example:
> 
>  echo 253:0 512 > /sys/fs/cgroup/blkio/blkio.throttle.read_bps_device
>  fio --readonly --direct=1 --filename=/dev/vda --size=4K --rate=4K \
> 		 --rw=read --ioengine=libaio --iodepth=16 --name 1
> 
>  the slack of 8s-timer is about 302ms.
> 
>  throtl / [R] bio. bdisp=0 sz=4096 bps=512 iodisp=0 iops=4294967295 queued=0/0
>  throtl schedule timer. delay=8000 jiffies=4295784850
>  throtl / dispatch nr_queued=1 read=1 write=0, bdisp=0/0, iodisp=0/0
>  throtl / [R] new slice start=4295793152 end=4295793252 jiffies=4295793152
>  throtl / [R] extend slice start=4295793152 end=4295801200 jiffies=4295793152
>  throtl schedule timer. delay=8000 jiffies=4295793152
>  throtl / dispatch nr_queued=1 read=1 write=0, bdisp=0/0, iodisp=0/0
>  throtl / [R] new slice start=4295801344 end=4295801444 jiffies=4295801344
>  throtl / [R] extend slice start=4295801344 end=4295809400 jiffies=4295801344
>  throtl schedule timer. delay=8000 jiffies=4295801344
> 
> Fix it by checking the delayed dispatch in tg_may_dispatch():
> 1. If there is any dispatched bio, the time slice must have been used,
>    so it's OK to renew the time slice.
> 2. If there is no queued bio, the time slice must have been expired,
>    so it's Ok to renew the time slice.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  block/blk-throttle.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index f1aba26..91f8140 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -591,13 +591,20 @@ static inline void throtl_extend_slice(struct throtl_grp *tg, bool rw,
>  		   tg->slice_end[rw], jiffies);
>  }
>  
> +static bool throtl_is_delayed_disp(struct throtl_grp *tg, bool rw)
> +{
> +	return (time_after(jiffies, tg->slice_end[rw]) &&
> +			!tg->bytes_disp[rw] && !tg->io_disp[rw] &&
> +			tg->service_queue.nr_queued[rw]) ? true : false;
> +}

Hi Hou Tao,

[ CC Tejun and Thomas ]

Thanks for the patch. I can reproduce it. I am wondering that why are you
doing so many checks. Can't we just check if throttle group is empty or
not. If it is empty and slice has expired, then start a new slice. If
throttle group is not empty, then we know slice has to be an active slice
and should be extended (despite the fact that it might have expired
because timer function got called later than we expected it to be).

Can you please try following patch. It seems to resolve the issue for me.

Vivek


Subject: blk-throttle: Extend slice if throttle group is not empty

Right now, if slice is expired, we start a new slice. If a bio is
queued, we keep on extending slice by throtle_slice interval (100ms).

This worked well as long as pending timer function got executed with-in
few milli seconds of scheduled time. But looks like with recent changes
in timer subsystem, slack can be much longer depending on the expiry time
of the scheduled timer.

commit 500462a9de65 ("timers: Switch to a non-cascading wheel")

This means, by the time timer function gets executed, it is possible the
delay from scheduled time is more than 100ms. That means current code
will conclude that existing slice has expired and a new one needs to
be started. New slice will be 100ms by default and that will not be
sufficient to meet rate requirement of group given the bio size and
bio will not be dispatched and we will start a new timer function to
wait. And when that timer expires, same process will repeat and we
will wait again and this can easily be an infinite loop.

Solve this issue by starting a new slice only if throttle gropup is
empty. If it is not empty, that means there should be an active slice
going on. Ideally it should not be expired but given the slack, it is
possible that it has expired.

Reported-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 block/blk-throttle.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: rhvgoyal-linux/block/blk-throttle.c
===================================================================
--- rhvgoyal-linux.orig/block/blk-throttle.c	2016-09-13 08:55:33.616200176 -0400
+++ rhvgoyal-linux/block/blk-throttle.c	2016-09-13 09:17:10.664200176 -0400
@@ -780,9 +780,11 @@ static bool tg_may_dispatch(struct throt
 	/*
 	 * If previous slice expired, start a new one otherwise renew/extend
 	 * existing slice to make sure it is at least throtl_slice interval
-	 * long since now.
+	 * long since now. New slice is started only for empty throttle group.
+	 * If there is queued bio, that means there should be an active
+	 * slice and it should be extended instead.
 	 */
-	if (throtl_slice_used(tg, rw))
+	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
 		throtl_start_new_slice(tg, rw);
 	else {
 		if (time_before(tg->slice_end[rw], jiffies + throtl_slice))
