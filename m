Return-Path: <ming.lei@redhat.com>
Date: Fri, 28 Apr 2017 10:00:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/6] blk-mq: Make blk_mq_quiesce_queue() wait for all
 .queue_rq() calls
Message-ID: <20170428020038.GA31518@ming.t460p>
References: <20170427155437.23228-1-bart.vanassche@sandisk.com>
 <20170427155437.23228-2-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170427155437.23228-2-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

Hi Bart,

On Thu, Apr 27, 2017 at 08:54:32AM -0700, Bart Van Assche wrote:
> blk_mq_quiesce_queue() callers, e.g. elevator_switch_mq(), assume
> that no .queue_rq() calls occur while switching to another I/O

I think we should call blk_mq_freeze_queue_wait() instead
of blk_quiesce_queue() in elevator_switch_mq(), otherwise
it is easy to cause use-after-free.

> scheduler. This patch fixes the following kernel crash if another
> I/O scheduler than "none" is the default scheduler:
> 
> general protection fault: 0000 [#1] SMP
> RIP: 0010:__lock_acquire+0xfe/0x1280
> Call Trace:
>  lock_acquire+0xd5/0x1c0
>  _raw_spin_lock+0x2a/0x40
>  dd_dispatch_request+0x29/0x1e0
>  blk_mq_sched_dispatch_requests+0x139/0x190
>  __blk_mq_run_hw_queue+0x12d/0x1c0
>  blk_mq_run_work_fn+0xd/0x10
>  process_one_work+0x206/0x6a0
>  worker_thread+0x49/0x4a0
>  kthread+0x107/0x140
>  ret_from_fork+0x2e/0x40
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: <stable@vger.kernel.org>
> ---
>  block/blk-mq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b75ef2392db7..3b3420f76b5a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1224,8 +1224,9 @@ EXPORT_SYMBOL(blk_mq_queue_stopped);
>  
>  void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
>  {
> -	cancel_work(&hctx->run_work);
> -	cancel_delayed_work(&hctx->delay_work);
> +	cancel_work_sync(&hctx->run_work);
> +	cancel_delayed_work_sync(&hctx->delay_work);

Could you explain it a bit why we need the sync version?

> +	cancel_delayed_work_sync(&hctx->delayed_run_work);

More introduced, more bugs may come, :-)

So I suggest to unity both .run_work and .dealyed_run_work
into one work, just as what Jens did in the following link:

	http://marc.info/?t=149183989800010&r=1&w=2


Thanks,
Ming
