Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:38148 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeBTNVm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Feb 2018 08:21:42 -0500
Date: Tue, 20 Feb 2018 14:21:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, linux-block@vger.kernel.org, axboe@fb.com,
        linux-nvme@lists.infradead.org, joshi.k@samsung.com
Subject: Re: [PATCH] blk: optimization for classic polling
Message-ID: <20180220132137.GG25314@hirez.programming.kicks-ass.net>
References: <CGME20180208143655epcas1p444bf34705526b7839a5a135f82761aad@epcas1p4.samsung.com>
 <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, May 30, 2083 at 09:51:06AM +0530, Nitesh Shetty wrote:
> This removes the dependency on interrupts to wake up task. Set task
> state as TASK_RUNNING, if need_resched() returns true,
> while polling for IO completion.
> Earlier, polling task used to sleep, relying on interrupt to wake it up.
> This made some IO take very long when interrupt-coalescing is enabled in
> NVMe.

This is a horrible Changelog.. it does not in fact explain why the patch
works or is correct.

Also, set_current_state(TASK_RUNNING) is dodgy (similarly in
__blk_mq_poll), why do you need that memory barrier?


> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  fs/block_dev.c | 16 ++++++++++++----
>  fs/direct-io.c |  8 ++++++--
>  fs/iomap.c     | 10 +++++++---
>  3 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 4a181fc..a87d8b7 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -236,9 +236,13 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>  		set_current_state(TASK_UNINTERRUPTIBLE);
>  		if (!READ_ONCE(bio.bi_private))
>  			break;
> -		if (!(iocb->ki_flags & IOCB_HIPRI) ||
> -		    !blk_poll(bdev_get_queue(bdev), qc))
> +		if (!(iocb->ki_flags & IOCB_HIPRI))
>  			io_schedule();
> +		else if (!blk_poll(bdev_get_queue(bdev), qc)) {
> +			if (need_resched())
> +				set_current_state(TASK_RUNNING);
> +			io_schedule();
> +		}
>  	}
>  	__set_current_state(TASK_RUNNING);
>  
