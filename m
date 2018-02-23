Return-Path: <jiangqi903@gmail.com>
Return-Path: <jiangqi903@gmail.com>
Subject: Re: [PATCH v4 5/6] block: Fix a race between the cgroup code and
 request queue initialization
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>
References: <20180223010808.25765-1-bart.vanassche@wdc.com>
 <20180223010808.25765-6-bart.vanassche@wdc.com>
From: Joseph Qi <jiangqi903@gmail.com>
Message-ID: <33eefa94-b0fc-9ac4-6b16-39c3ad8fc293@gmail.com>
Date: Fri, 23 Feb 2018 17:52:23 +0800
MIME-Version: 1.0
In-Reply-To: <20180223010808.25765-6-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 18/2/23 09:08, Bart Van Assche wrote:
> Initialize the request queue lock earlier such that the following
> race can no longer occur:
> 
> blk_init_queue_node()             blkcg_print_blkgs()
>   blk_alloc_queue_node (1)
>     q->queue_lock = &q->__queue_lock (2)
>     blkcg_init_queue(q) (3)
>                                     spin_lock_irq(blkg->q->queue_lock) (4)
>   q->queue_lock = lock (5)
>                                     spin_unlock_irq(blkg->q->queue_lock) (6)
> 
> (1) allocate an uninitialized queue;
> (2) initialize queue_lock to its default internal lock;
> (3) initialize blkcg part of request queue, which will create blkg and
>     then insert it to blkg_list;
> (4) traverse blkg_list and find the created blkg, and then take its
>     queue lock, here it is the default *internal lock*;
> (5) *race window*, now queue_lock is overridden with *driver specified
>     lock*;
> (6) now unlock *driver specified lock*, not the locked *internal lock*,
>     unlock balance breaks.
> 
> The changes in this patch are as follows:
> - Move the .queue_lock initialization from blk_init_queue_node() into
>   blk_alloc_queue_node().
> - Only override the .queue_lock pointer for legacy queues because it
>   is not useful for blk-mq queues to override this pointer.
> - For all all block drivers that initialize .queue_lock explicitly,
>   change the blk_alloc_queue() call in the driver into a
>   blk_alloc_queue_node() call and remove the explicit .queue_lock
>   initialization. Additionally, initialize the spin lock that will
>   be used as queue lock earlier if necessary.
> 
> Reported-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kees Cook <keescook@chromium.org>

Looks good.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
