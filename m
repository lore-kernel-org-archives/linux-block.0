Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Fix a race between the throttling code and request
 queue initialization
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>,
 stable@vger.kernel.org
References: <20180131191300.25664-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d7acd8ee-7256-0a84-1d81-38b15534d138@kernel.dk>
Date: Wed, 31 Jan 2018 12:22:41 -0700
MIME-Version: 1.0
In-Reply-To: <20180131191300.25664-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/31/18 12:13 PM, Bart Van Assche wrote:
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
> - Rename blk_alloc_queue_node() into blk_alloc_queue_node2() and add
>   a new queue lock argument.
> - Introduce a wrapper function with the same name and behavior as the
>   old blk_alloc_queue_node() function.

Let's please not do any of that, that's a horrible name to export. It's
not like we have hundreds of callers of blk_alloc_queue_node(), just
change them to pass in a NULL if they use the queue embedded lock.


-- 
Jens Axboe
