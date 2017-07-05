Return-Path: <ming.lei@redhat.com>
Date: Thu, 6 Jul 2017 06:49:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v3 2/8] nvme-fc: quiesce/unquiesce admin_q instead of
 start/stop its hw queues
Message-ID: <20170705224937.GB2332@ming.t460p>
References: <1499274037-17438-1-git-send-email-sagi@grimberg.me>
 <1499274037-17438-3-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499274037-17438-3-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 05, 2017 at 08:00:31PM +0300, Sagi Grimberg wrote:
> unlike blk_mq_stop_hw_queues and blk_mq_start_stopped_hw_queues
> quiescing/unquiescing respects the submission path rcu grace.
> 
> Also, make sure to unquiesce before cleanup the admin queue.
> 
> Reviewed-By: James Smart <james.smart@broadcom.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/fc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 50cc3b2b0e11..8d55e7827932 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1703,6 +1703,7 @@ nvme_fc_ctrl_free(struct kref *ref)
>  	list_del(&ctrl->ctrl_list);
>  	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
>  
> +	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>  	blk_cleanup_queue(ctrl->ctrl.admin_q);
>  	blk_mq_free_tag_set(&ctrl->admin_tag_set);
>  
> @@ -2321,7 +2322,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>  		goto out_delete_hw_queue;
>  
>  	if (ctrl->ctrl.state != NVME_CTRL_NEW)
> -		blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
> +		blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>  
>  	ret = nvmf_connect_admin_queue(&ctrl->ctrl);
>  	if (ret)
> @@ -2475,7 +2476,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
>  	 * use blk_mq_tagset_busy_itr() and the transport routine to
>  	 * terminate the exchanges.
>  	 */
> -	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
> +	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
>  	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>  				nvme_fc_terminate_exchange, &ctrl->ctrl);
>  
> -- 
> 2.7.4
> 

Maybe it is a little better to the blk_mq_unquiesce_queue() before
blk_cleanup_queue() after blk_mq_tagset_busy_iter() in
nvme_fc_delete_association(). But it shouldn't be a big deal.

So looks fine,

	Reviewed-by: Ming Lei <ming.lei@redhat.com>


-- 
Ming
