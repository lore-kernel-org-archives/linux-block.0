Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V2 5/5] nvme: pci: simplify timeout handling
To: Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20180429154152.16656-1-ming.lei@redhat.com>
 <20180429154152.16656-6-ming.lei@redhat.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <655b9d93-b4fc-b78b-1ea1-1c34d5c0535e@oracle.com>
Date: Wed, 2 May 2018 10:23:20 +0800
MIME-Version: 1.0
In-Reply-To: <20180429154152.16656-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

On 04/29/2018 11:41 PM, Ming Lei wrote:
> +
>  static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> @@ -1197,8 +1297,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  	 */
>  	if (nvme_should_reset(dev, csts)) {
>  		nvme_warn_reset(dev, csts);
> -		nvme_dev_disable(dev, false);
> -		nvme_reset_ctrl(&dev->ctrl);
> +		nvme_eh_schedule(dev);
>  		return BLK_EH_HANDLED;
>  	}
>  
> @@ -1224,8 +1323,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  		dev_warn(dev->ctrl.device,
>  			 "I/O %d QID %d timeout, disable controller\n",
>  			 req->tag, nvmeq->qid);
> -		nvme_dev_disable(dev, false);
>  		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> +		nvme_eh_schedule(dev);
>  		return BLK_EH_HANDLED;
>  	default:
>  		break;
> @@ -1240,14 +1339,12 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  		dev_warn(dev->ctrl.device,
>  			 "I/O %d QID %d timeout, reset controller\n",
>  			 req->tag, nvmeq->qid);
> -		nvme_dev_disable(dev, false);
> -		nvme_reset_ctrl(&dev->ctrl);
> -
>  		/*
>  		 * Mark the request as handled, since the inline shutdown
>  		 * forces all outstanding requests to complete.
>  		 */
>  		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> +		nvme_eh_schedule(dev);
>  		return BLK_EH_HANDLED;
>  	}
>  
> @@ -2246,8 +2343,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  	if (pci_is_enabled(pdev)) {
>  		u32 csts = readl(dev->bar + NVME_REG_CSTS);
>  
> -		if (dev->ctrl.state == NVME_CTRL_LIVE ||
> -		    dev->ctrl.state == NVME_CTRL_RESETTING) {
> +		if (shutdown && (dev->ctrl.state == NVME_CTRL_LIVE ||
> +		    dev->ctrl.state == NVME_CTRL_RESETTING)) {
>  			nvme_start_freeze(&dev->ctrl);
>  			frozen = true;
>  		}
> @@ -2281,11 +2378,23 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  	for (i = dev->ctrl.queue_count - 1; i >= 0; i--)
>  		nvme_suspend_queue(&dev->queues[i]);
>  
> +	/* safe to sync timeout after queues are quiesced */
> +	nvme_quiesce_timeout(&dev->ctrl);
> +	blk_quiesce_timeout(dev->ctrl.admin_q);
> +
>  	nvme_pci_disable(dev);
>  
> +	/*
> +	 * Both timeout and interrupt handler have been drained, and all
> +	 * in-flight requests will be canceled now.
> +	 */
>  	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
>  	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);


We need to return BLK_EH_RESET_TIMER in nvme_timeout then:
1. defer the completion. we can't unmap the io request before close the controller totally, so not BLK_EH_HANDLED.
2. nvme_cancel_request could complete it. blk_mq_complete_request is invoked by nvme_cancel_request, so not BLK_EH_NOT_HANDLED.

Thanks
Jianchao
