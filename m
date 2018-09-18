Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v7 5/6] block: Make blk_get_request() block for non-PM
 requests while suspended
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>
References: <20180917201525.26570-1-bvanassche@acm.org>
 <20180917201525.26570-6-bvanassche@acm.org>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <be1de777-357c-ef19-1de0-7b352b3cee96@oracle.com>
Date: Tue, 18 Sep 2018 10:39:10 +0800
MIME-Version: 1.0
In-Reply-To: <20180917201525.26570-6-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 09/18/2018 04:15 AM, Bart Van Assche wrote:
> Instead of allowing requests that are not power management requests
> to enter the queue in runtime suspended status (RPM_SUSPENDED), make
> the blk_get_request() caller block. This change fixes a starvation
> issue: it is now guaranteed that power management requests will be
> executed no matter how many blk_get_request() callers are waiting.
> Instead of maintaining the q->nr_pending counter, rely on
> q->q_usage_counter. 

Looks like we still depend on this nr_pending for blk-legacy.

Call pm_runtime_mark_last_busy() every time a
> request finishes instead of only if the queue depth drops to zero.
...
>  		/*
> diff --git a/block/blk-pm.c b/block/blk-pm.c
> index 9b636960d285..5f21bedcb307 100644
> --- a/block/blk-pm.c
> +++ b/block/blk-pm.c
> @@ -1,8 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <linux/blk-mq.h>
>  #include <linux/blk-pm.h>
>  #include <linux/blkdev.h>
>  #include <linux/pm_runtime.h>
> +#include "blk-mq.h"
> +#include "blk-mq-tag.h"
>  
>  /**
>   * blk_pm_runtime_init - Block layer runtime PM initialization routine
> @@ -40,6 +43,36 @@ void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
>  }
>  EXPORT_SYMBOL(blk_pm_runtime_init);
>  
> +struct in_flight_data {
> +	struct request_queue	*q;
> +	int			in_flight;
> +};
> +
> +static void blk_count_in_flight(struct blk_mq_hw_ctx *hctx, struct request *rq,
> +				void *priv, bool reserved)
> +{
> +	struct in_flight_data *in_flight = priv;
> +
> +	if (rq->q == in_flight->q)
> +		in_flight->in_flight++;
> +}
> +
> +/*
> + * Count the number of requests that are in flight for request queue @q. Use
> + * @q->nr_pending for legacy queues. Iterate over the tag set for blk-mq
> + * queues.  Use blk_mq_queue_tag_busy_iter() instead of
> + * blk_mq_tagset_busy_iter() because the latter only considers requests that
> + * have already been started.
> + */
> +static int blk_requests_in_flight(struct request_queue *q)
> +{
> +	struct in_flight_data in_flight = { .q = q };
> +
> +	if (q->mq_ops)
> +		blk_mq_queue_tag_busy_iter(q, blk_count_in_flight, &in_flight);
> +	return q->nr_pending + in_flight.in_flight;
> +}

blk_mq_queue_tag_busy_iter only accounts the driver tags. This will only work w/o io scheduler

> +
>  /**
>   * blk_pre_runtime_suspend - Pre runtime suspend check
>   * @q: the queue of the device
> @@ -68,14 +101,38 @@ int blk_pre_runtime_suspend(struct request_queue *q)
>  	if (!q->dev)
>  		return ret;
>  
> +	WARN_ON_ONCE(q->rpm_status != RPM_ACTIVE);
> +
> +	blk_set_pm_only(q);
> +	/*
> +	 * This function only gets called if the most recent
> +	 * pm_request_resume() call occurred at least autosuspend_delay_ms
           ^^^^^^^^^^^^^^^^^^^
pm_runtime_mark_last_busy ?

> +	 * ago. Since blk_queue_enter() is called by the request allocation
> +	 * code before pm_request_resume(), if no requests have a tag assigned
> +	 * it is safe to suspend the device.
> +	 */
> +	ret = -EBUSY;
> +	if (blk_requests_in_flight(q) == 0) {
> +		/*
> +		 * Call synchronize_rcu() such that later blk_queue_enter()
> +		 * calls see the pm-only state. See also
> +		 * https://urldefense.proofpoint.com/v2/url?u=http-3A__lwn.net_Articles_573497_&d=DwIDAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=o3yai95U5Ge5APoSiMJX64Z8wlI7gf3x0mFnfHpuA4E&s=VPnOWAeo4J4VB944La0uBcynCgVHE-qp52b_9pV8NH4&e=.
> +		 */
> +		synchronize_rcu();
> +		if (blk_requests_in_flight(q) == 0)

Seems not safe here.

For blk-mq path:
Someone may have escaped from the preempt checking, missed the blk_pm_request_resume there,
entered into generic_make_request, but have not allocated request and occupied any tag.

There could be a similar scenario for blk-legacy path, the q->nr_pending is increased when
request is queued.

So I guess the q_usage_counter checking is still needed here.
  
> +			ret = 0;
> +	}
> +
>  	spin_lock_irq(q->queue_lock);
> -	if (q->nr_pending) {
> -		ret = -EBUSY;
> +	if (ret < 0)
>  		pm_runtime_mark_last_busy(q->dev);
> -	} else {
> +	else
>  		q->rpm_status = RPM_SUSPENDING;
> -	}
>  	spin_unlock_irq(q->queue_lock);
> +
> +	if (ret)
> +		blk_clear_pm_only(q);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(blk_pre_runtime_suspend);
> @@ -106,6 +163,9 @@ void blk_post_runtime_suspend(struct request_queue *q, int err)
>  		pm_runtime_mark_last_busy(q->dev);
>  	}
>  	spin_unlock_irq(q->queue_lock);
> +
> +	if (err)
> +		blk_clear_pm_only(q);
>  }
>  EXPORT_SYMBOL(blk_post_runtime_suspend);
>  
> @@ -153,13 +213,15 @@ void blk_post_runtime_resume(struct request_queue *q, int err)
>  	spin_lock_irq(q->queue_lock);
>  	if (!err) {
>  		q->rpm_status = RPM_ACTIVE;
> -		__blk_run_queue(q);
>  		pm_runtime_mark_last_busy(q->dev);
>  		pm_request_autosuspend(q->dev);
>  	} else {
>  		q->rpm_status = RPM_SUSPENDED;
>  	}
>  	spin_unlock_irq(q->queue_lock);
> +
> +	if (!err)
> +		blk_clear_pm_only(q);
>  }
>  EXPORT_SYMBOL(blk_post_runtime_resume);
>  
> 
