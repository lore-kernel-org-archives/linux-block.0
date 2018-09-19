Return-Path: <ming.lei@redhat.com>
Date: Wed, 19 Sep 2018 12:05:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v8 6/8] block: Schedule runtime resume earlier
Message-ID: <20180919040514.GE20560@ming.t460p>
References: <20180918205903.15516-1-bvanassche@acm.org>
 <20180918205903.15516-7-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180918205903.15516-7-bvanassche@acm.org>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 18, 2018 at 01:59:01PM -0700, Bart Van Assche wrote:
> Instead of scheduling runtime resume of a request queue after a
> request has been queued, schedule asynchronous resume during request
> allocation. The new pm_request_resume() calls occur after
> blk_queue_enter() has increased the q_usage_counter request queue
> member. This change is needed for a later patch that will make request
> allocation block while the queue status is not RPM_ACTIVE.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> ---
>  block/blk-core.c | 2 ++
>  block/elevator.c | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fd91e9bf2893..18b874d5c9c9 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -942,6 +942,8 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
>  		if (success)
>  			return 0;
>  
> +		blk_pm_request_resume(q);


Looks this patch may introduce the following race between queue freeze and
runtime suspend:

--------------------------------------------------------------------------
CPU0				CPU1						CPU2
--------------------------------------------------------------------------

blk_freeze_queue()

					blk_mq_alloc_request()
						blk_queue_enter()
							blk_pm_request_resume()
							wait_event()

												blk_pre_runtime_suspend()
													->blk_set_pm_only
												...
												blk_post_runtime_suspend()

...
blk_mq_unfreeze_queue()
--------------------------------------------------------------------------
- CPU0: queue is frozen

- CPU1: one new request comes, and see queue is frozen, but queue isn't
runtime-suspended yet, then blk_pm_request_resume() does nothing. So this
allocation is blocked in wait_event().

- CPU2: runtime suspend comes, and queue becomes runtime-suspended now

- CPU0: queue is unfreeze, but the new request allocation in CPU1 may never
be done because the queue is runtime suspended, and wait_event() won't return.
And the expected result is that the queue becomes active and the allocation on
CPU1 is done immediately.

Thanks,
Ming
