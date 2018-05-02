Return-Path: <ming.lei@redhat.com>
Date: Wed, 2 May 2018 12:54:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 5/5] nvme: pci: simplify timeout handling
Message-ID: <20180502045423.GE22363@ming.t460p>
References: <20180429154152.16656-1-ming.lei@redhat.com>
 <20180429154152.16656-6-ming.lei@redhat.com>
 <655b9d93-b4fc-b78b-1ea1-1c34d5c0535e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <655b9d93-b4fc-b78b-1ea1-1c34d5c0535e@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 02, 2018 at 10:23:20AM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 04/29/2018 11:41 PM, Ming Lei wrote:
> > +
> >  static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> >  {
> >  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> > @@ -1197,8 +1297,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> >  	 */
> >  	if (nvme_should_reset(dev, csts)) {
> >  		nvme_warn_reset(dev, csts);
> > -		nvme_dev_disable(dev, false);
> > -		nvme_reset_ctrl(&dev->ctrl);
> > +		nvme_eh_schedule(dev);
> >  		return BLK_EH_HANDLED;
> >  	}
> >  
> > @@ -1224,8 +1323,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> >  		dev_warn(dev->ctrl.device,
> >  			 "I/O %d QID %d timeout, disable controller\n",
> >  			 req->tag, nvmeq->qid);
> > -		nvme_dev_disable(dev, false);
> >  		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> > +		nvme_eh_schedule(dev);
> >  		return BLK_EH_HANDLED;
> >  	default:
> >  		break;
> > @@ -1240,14 +1339,12 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> >  		dev_warn(dev->ctrl.device,
> >  			 "I/O %d QID %d timeout, reset controller\n",
> >  			 req->tag, nvmeq->qid);
> > -		nvme_dev_disable(dev, false);
> > -		nvme_reset_ctrl(&dev->ctrl);
> > -
> >  		/*
> >  		 * Mark the request as handled, since the inline shutdown
> >  		 * forces all outstanding requests to complete.
> >  		 */
> >  		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> > +		nvme_eh_schedule(dev);
> >  		return BLK_EH_HANDLED;
> >  	}
> >  
> > @@ -2246,8 +2343,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
> >  	if (pci_is_enabled(pdev)) {
> >  		u32 csts = readl(dev->bar + NVME_REG_CSTS);
> >  
> > -		if (dev->ctrl.state == NVME_CTRL_LIVE ||
> > -		    dev->ctrl.state == NVME_CTRL_RESETTING) {
> > +		if (shutdown && (dev->ctrl.state == NVME_CTRL_LIVE ||
> > +		    dev->ctrl.state == NVME_CTRL_RESETTING)) {
> >  			nvme_start_freeze(&dev->ctrl);
> >  			frozen = true;
> >  		}
> > @@ -2281,11 +2378,23 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
> >  	for (i = dev->ctrl.queue_count - 1; i >= 0; i--)
> >  		nvme_suspend_queue(&dev->queues[i]);
> >  
> > +	/* safe to sync timeout after queues are quiesced */
> > +	nvme_quiesce_timeout(&dev->ctrl);
> > +	blk_quiesce_timeout(dev->ctrl.admin_q);
> > +
> >  	nvme_pci_disable(dev);
> >  
> > +	/*
> > +	 * Both timeout and interrupt handler have been drained, and all
> > +	 * in-flight requests will be canceled now.
> > +	 */
> >  	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
> >  	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
> 
> 
> We need to return BLK_EH_RESET_TIMER in nvme_timeout then:
> 1. defer the completion. we can't unmap the io request before close the controller totally, so not BLK_EH_HANDLED.
> 2. nvme_cancel_request could complete it. blk_mq_complete_request is invoked by nvme_cancel_request, so not BLK_EH_NOT_HANDLED.

We don't need to change return value of .timeout() any more after
calling nvme_quiesce_timeout():

Thanks the single EH kthread, once nvme_quiesce_timeout() returns, all
timed-out requests have been handled already. Some of them may be completed,
and others may be handled as RESET_TIMER, but none of them are handled as
NOT_HANDLED because nvme_timeout() won't return that value.

So the following blk_mq_tagset_busy_iter(nvme_cancel_request) can handle
all in-flight requests because timeout is drained and quiesced.

Thanks,
Ming
