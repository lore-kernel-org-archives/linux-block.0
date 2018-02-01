Return-Path: <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2 2/2] block: Fix a race between the throttling code and
 request queue initialization
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>,
 stable@vger.kernel.org
References: <20180131235300.12773-1-bart.vanassche@wdc.com>
 <20180131235300.12773-3-bart.vanassche@wdc.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <1ff1b2fa-ffe1-20f4-6be9-919c6a5b8227@linux.alibaba.com>
Date: Thu, 1 Feb 2018 09:53:24 +0800
MIME-Version: 1.0
In-Reply-To: <20180131235300.12773-3-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart,

On 18/2/1 07:53, Bart Van Assche wrote:
> Initialize the request queue lock earlier such that the following
> race can no longer occur:
> 
> blk_init_queue_node                 blkcg_print_blkgs
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
> - For all all block drivers that initialize .queue_lock explicitly,
>   change the blk_alloc_queue() call in the driver into a
>   blk_alloc_queue_node() call and remove the explicit .queue_lock
>   initialization. Additionally, initialize the spin lock that will
>   be used as queue lock earlier if necessary.
> 
I'm afraid the risk may also exist in blk_cleanup_queue, which will
set queue_lock to to the default internal lock.

spin_lock_irq(lock);
if (q->queue_lock != &q->__queue_lock)
	q->queue_lock = &q->__queue_lock;
spin_unlock_irq(lock);

I'm thinking of getting blkg->q->queue_lock to local first, but this
will result in still using driver lock even the queue_lock has already
been set to the default internal lock.

Thanks,
Joseph
