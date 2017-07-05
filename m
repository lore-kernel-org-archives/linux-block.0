Return-Path: <ming.lei@redhat.com>
Date: Thu, 6 Jul 2017 06:58:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v3 5/8] nvme: kick requeue list when requeueing a request
 instead of when starting the queues
Message-ID: <20170705225838.GD2332@ming.t460p>
References: <1499274037-17438-1-git-send-email-sagi@grimberg.me>
 <1499274037-17438-6-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499274037-17438-6-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 05, 2017 at 08:00:34PM +0300, Sagi Grimberg wrote:
> When we requeue a request, we can always insert the request
> back to the scheduler instead of doing it when restarting
> the queues and kicking the requeue work, so get rid of
> the requeue kick in nvme (core and drivers).
> 
> Also, now there is no need start hw queues in nvme_kill_queues
> We don't stop the hw queues anymore, so no need to
> start them.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/core.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d70df1d0072d..48cafaa6fbc5 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -131,7 +131,7 @@ void nvme_complete_rq(struct request *req)
>  {
>  	if (unlikely(nvme_req(req)->status && nvme_req_needs_retry(req))) {
>  		nvme_req(req)->retries++;
> -		blk_mq_requeue_request(req, !blk_mq_queue_stopped(req->q));
> +		blk_mq_requeue_request(req, true);
>  		return;
>  	}
>  
> @@ -2694,9 +2694,6 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>  	/* Forcibly unquiesce queues to avoid blocking dispatch */
>  	blk_mq_unquiesce_queue(ctrl->admin_q);
>  
> -	/* Forcibly start all queues to avoid having stuck requests */
> -	blk_mq_start_hw_queues(ctrl->admin_q);
> -
>  	list_for_each_entry(ns, &ctrl->namespaces, list) {
>  		/*
>  		 * Revalidating a dead namespace sets capacity to 0. This will
> @@ -2709,16 +2706,6 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>  
>  		/* Forcibly unquiesce queues to avoid blocking dispatch */
>  		blk_mq_unquiesce_queue(ns->queue);
> -
> -		/*
> -		 * Forcibly start all queues to avoid having stuck requests.
> -		 * Note that we must ensure the queues are not stopped
> -		 * when the final removal happens.
> -		 */
> -		blk_mq_start_hw_queues(ns->queue);
> -
> -		/* draining requests in requeue list */
> -		blk_mq_kick_requeue_list(ns->queue);
>  	}
>  	mutex_unlock(&ctrl->namespaces_mutex);
>  }
> @@ -2787,10 +2774,8 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
>  	struct nvme_ns *ns;
>  
>  	mutex_lock(&ctrl->namespaces_mutex);
> -	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +	list_for_each_entry(ns, &ctrl->namespaces, list)
>  		blk_mq_unquiesce_queue(ns->queue);
> -		blk_mq_kick_requeue_list(ns->queue);
> -	}
>  	mutex_unlock(&ctrl->namespaces_mutex);
>  }
>  EXPORT_SYMBOL_GPL(nvme_start_queues);
> -- 
> 2.7.4
> 

Yeah, this is a good cleanup, and be one of my motivation of
the quiesce improvement, and I believe we can do more this kind of
cleanup to remove racy stop/start queue in other drivers.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
