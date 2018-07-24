Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-mq: Avoid that a request queue stalls when restarting
 a shared hctx
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jack Wang <jack.wang.usish@gmail.com>, stable@vger.kernel.org
References: <20180723155038.22062-1-bart.vanassche@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <914fb260-5529-4e1b-8c38-7355cc298c3a@oracle.com>
Date: Tue, 24 Jul 2018 16:10:52 +0800
MIME-Version: 1.0
In-Reply-To: <20180723155038.22062-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 07/23/2018 11:50 PM, Bart Van Assche wrote:
> The patch below fixes queue stalling when shared hctx marked for restart
> (BLK_MQ_S_SCHED_RESTART bit) but q->shared_hctx_restart stays zero.  The
> root cause is that hctxs are shared between queues, but 'shared_hctx_restart'

The blk_mq_hw_ctx structure is also per request_queue
Please refer to blk_mq_init_allocated_queue -> blk_mq_realloc_hw_ctxs

> belongs to the particular queue, which in fact may not need to be restarted,
> thus we return from blk_mq_sched_restart() and leave shared hctx of another
> queue never restarted.
> 
> The fix is to make shared_hctx_restart counter belong not to the queue, but
> to tags, thereby counter will reflect real number of shared hctx needed to
> be restarted.
> 
> During tests 1 hctx (set->nr_hw_queues) was used and all stalled requests
> were noticed in dd->fifo_list of mq-deadline scheduler.
> 
> Seeming possible sequence of events:
> 
> 1. Request A of queue A is inserted into dd->fifo_list of the scheduler.
> 
> 2. Request B of queue A bypasses scheduler and goes directly to
>    hctx->dispatch.
> 
> 3. Request C of queue B is inserted.
> 
> 4. blk_mq_sched_dispatch_requests() is invoked, since hctx->dispatch is not
>    empty (request B is in the list) hctx is only marked for for next restart
>    and request A is left in a list (see comment "So it's best to leave them
>    there for as long as we can. Mark the hw queue as needing a restart in
>    that case." in blk-mq-sched.c)
> 
> 5. Eventually request B is completed/freed and blk_mq_sched_restart() is
>    called, but by chance hctx from queue B is chosen for restart and request C
>    gets a chance to be dispatched.

Request C is just inserted into queue B. If there is no mark restart there,
it will not be chosen.
blk_mq_sched_restart_hctx

	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
		return false;

If blk_mq_sched_restart choose queue B, one of its hctx must have SCHED_RESTART flag,
and q->shared_hctx_restart must not be zero.

> 
> 6. Eventually request C is completed/freed and blk_mq_sched_restart() is
>    called, but shared_hctx_restart for queue B is zero and we return without
>    attempt to restart hctx from queue A, thus request A is stuck forever.
> 
> But stalling queue is not the only one problem with blk_mq_sched_restart().
> My tests show that those loops thru all queues and hctxs can be very costly,
> even with shared_hctx_restart counter, which aims to fix performance issue.

Currently, SCHED_RESTART is always set when there is reqs on hctx->dispatch list in
blk_mq_sched_dispatch_requests. And no driver tag case is the main reason for hctx->dispatch
is not empty when there is io scheduler.
Therefore, most of time, blk_mq_sched_restart will be invoked further for no driver tag case.

For non-share-tag case, it will wakeup the hctx.
But for shared-tag case, it is unnecessary, because the sbitmap_queue wakeup hook will work
and hctx_may_queue will avoid starvation of other ones.

Therefore, the costly loop through the queues and hctxs is unnecessary most of time. 

Thanks
Jianchao
