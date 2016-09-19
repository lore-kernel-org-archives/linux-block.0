Return-Path: <vgoyal@redhat.com>
Date: Mon, 19 Sep 2016 17:06:45 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH] blk-throttle: fix infinite throttling caused by
 non-cascading timer wheel
Message-ID: <20160919210645.GE12537@redhat.com>
References: <1473662730-184701-1-git-send-email-houtao1@huawei.com>
 <20160913134646.GA19320@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160913134646.GA19320@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 13, 2016 at 09:46:46AM -0400, Vivek Goyal wrote:
> 
> Hi Hou Tao,
> 
> [ CC Tejun and Thomas ]
> 
> Thanks for the patch. I can reproduce it. I am wondering that why are you
> doing so many checks. Can't we just check if throttle group is empty or
> not. If it is empty and slice has expired, then start a new slice. If
> throttle group is not empty, then we know slice has to be an active slice
> and should be extended (despite the fact that it might have expired
> because timer function got called later than we expected it to be).
> 
> Can you please try following patch. It seems to resolve the issue for me.
> 
> Vivek

Hi Jens,

Can you please pick this patch. It seems to fix the reported issued.
Please let me know if you prefer a separate posting.

Vivek

> 
> 
> Subject: blk-throttle: Extend slice if throttle group is not empty
> 
> Right now, if slice is expired, we start a new slice. If a bio is
> queued, we keep on extending slice by throtle_slice interval (100ms).
> 
> This worked well as long as pending timer function got executed with-in
> few milli seconds of scheduled time. But looks like with recent changes
> in timer subsystem, slack can be much longer depending on the expiry time
> of the scheduled timer.
> 
> commit 500462a9de65 ("timers: Switch to a non-cascading wheel")
> 
> This means, by the time timer function gets executed, it is possible the
> delay from scheduled time is more than 100ms. That means current code
> will conclude that existing slice has expired and a new one needs to
> be started. New slice will be 100ms by default and that will not be
> sufficient to meet rate requirement of group given the bio size and
> bio will not be dispatched and we will start a new timer function to
> wait. And when that timer expires, same process will repeat and we
> will wait again and this can easily be an infinite loop.
> 
> Solve this issue by starting a new slice only if throttle gropup is
> empty. If it is not empty, that means there should be an active slice
> going on. Ideally it should not be expired but given the slack, it is
> possible that it has expired.
> 
> Reported-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  block/blk-throttle.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Index: rhvgoyal-linux/block/blk-throttle.c
> ===================================================================
> --- rhvgoyal-linux.orig/block/blk-throttle.c	2016-09-13 08:55:33.616200176 -0400
> +++ rhvgoyal-linux/block/blk-throttle.c	2016-09-13 09:17:10.664200176 -0400
> @@ -780,9 +780,11 @@ static bool tg_may_dispatch(struct throt
>  	/*
>  	 * If previous slice expired, start a new one otherwise renew/extend
>  	 * existing slice to make sure it is at least throtl_slice interval
> -	 * long since now.
> +	 * long since now. New slice is started only for empty throttle group.
> +	 * If there is queued bio, that means there should be an active
> +	 * slice and it should be extended instead.
>  	 */
> -	if (throtl_slice_used(tg, rw))
> +	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
>  		throtl_start_new_slice(tg, rw);
>  	else {
>  		if (time_before(tg->slice_end[rw], jiffies + throtl_slice))
