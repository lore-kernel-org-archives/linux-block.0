Return-Path: <jiangqi903@gmail.com>
Return-Path: <jiangqi903@gmail.com>
Subject: Re: [PATCH v4 6/6] block: Fix a race between request queue removal
 and the block cgroup controller
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Jan Kara <jack@suse.com>,
 "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
References: <20180223010808.25765-1-bart.vanassche@wdc.com>
 <20180223010808.25765-7-bart.vanassche@wdc.com>
From: Joseph Qi <jiangqi903@gmail.com>
Message-ID: <4fb04428-7de9-3454-3002-83a2c805083e@gmail.com>
Date: Fri, 23 Feb 2018 17:54:42 +0800
MIME-Version: 1.0
In-Reply-To: <20180223010808.25765-7-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 18/2/23 09:08, Bart Van Assche wrote:
> Avoid that the following race can occur:
> 
> blk_cleanup_queue()               blkcg_print_blkgs()
>   spin_lock_irq(lock) (1)           spin_lock_irq(blkg->q->queue_lock) (2,5)
>     q->queue_lock = &q->__queue_lock (3)
>   spin_unlock_irq(lock) (4)
>                                     spin_unlock_irq(blkg->q->queue_lock) (6)
> 
> (1) take driver lock;
> (2) busy loop for driver lock;
> (3) override driver lock with internal lock;
> (4) unlock driver lock;
> (5) can take driver lock now;
> (6) but unlock internal lock.
> 
> This change is safe because only the SCSI core and the NVME core keep
> a reference on a request queue after having called blk_cleanup_queue().
> Neither driver accesses any of the removed data structures between its
> blk_cleanup_queue() and blk_put_queue() calls.
> 
> Reported-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Jan Kara <jack@suse.com>

Looks good.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
