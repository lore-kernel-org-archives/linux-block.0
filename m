Return-Path: <keith.busch@linux.intel.com>
Date: Sat, 28 Apr 2018 07:35:14 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] nvme: pci: simplify timeout handling
Message-ID: <20180428133514.GB5938@localhost.localdomain>
References: <20180426123956.26039-1-ming.lei@redhat.com>
 <20180426123956.26039-2-ming.lei@redhat.com>
 <20180427175157.GB5073@localhost.localdomain>
 <20180428035015.GB5657@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180428035015.GB5657@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Sat, Apr 28, 2018 at 11:50:17AM +0800, Ming Lei wrote:
> > I understand how the problems are happening a bit better now. It used
> > to be that blk-mq would lock an expired command one at a time, so when
> > we had a batch of IO timeouts, the driver was able to complete all of
> > them inside a single IO timeout handler.
> > 
> > That's not the case anymore, so the driver is called for every IO
> > timeout even though if it reaped all the commands at once.
> 
> Actually there isn't the case before, even for legacy path, one .timeout()
> handles one request only.

That's not quite what I was talking about.

Before, only the command that was about to be sent to the driver's
.timeout() was marked completed. The driver could (and did) compete
other timed out commands in a single .timeout(), and the tag would
clear, so we could hanlde all timeouts in a single .timeout().

Now, blk-mq marks all timed out commands as aborted prior to calling
the driver's .timeout(). If the driver completes any of those commands,
the tag does not clear, so the driver's .timeout() just gets to be called
again for commands it already reaped.



> > IMO, the block layer should allow the driver to complete all timed out
> > IOs at once rather than go through ->timeout() for each of them and
> > without knowing about the request state details. Much of the problems
> > would go away in that case.
> 
> That need to change every driver, looks not easy to do, also not sure
> if other drivers need this way.
> 
> > 
> > But I think much of this can be fixed by just syncing the queues in the
> > probe work, and may be a more reasonable bug-fix for 4.17 rather than
> > rewrite the entire timeout handler. What do you think of this patch? It's
> > an update of one I posted a few months ago, but uses Jianchao's safe
> > namespace list locking.
> > 
> > ---
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index a3771c5729f5..198b4469c3e2 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3562,12 +3562,25 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
> >  	struct nvme_ns *ns;
> >  
> >  	down_read(&ctrl->namespaces_rwsem);
> > -	list_for_each_entry(ns, &ctrl->namespaces, list)
> > +	list_for_each_entry(ns, &ctrl->namespaces, list) {
> >  		blk_mq_unquiesce_queue(ns->queue);
> > +		blk_mq_kick_requeue_list(ns->queue);
> > +	}
> >  	up_read(&ctrl->namespaces_rwsem);
> >  }
> >  EXPORT_SYMBOL_GPL(nvme_start_queues);
> >  
> > +void nvme_sync_queues(struct nvme_ctrl *ctrl)
> > +{
> > +	struct nvme_ns *ns;
> > +
> > +	down_read(&ctrl->namespaces_rwsem);
> > +	list_for_each_entry(ns, &ctrl->namespaces, list)
> > +		blk_sync_queue(ns->queue);
> > +	up_read(&ctrl->namespaces_rwsem);
> > +}
> > +EXPORT_SYMBOL_GPL(nvme_sync_queues);
> > +
> >  int nvme_reinit_tagset(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set)
> >  {
> >  	if (!ctrl->ops->reinit_request)
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index 7ded7a51c430..e62273198725 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -402,6 +402,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
> >  void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
> >  		union nvme_result *res);
> >  
> > +void nvme_sync_queues(struct nvme_ctrl *ctrl);
> >  void nvme_stop_queues(struct nvme_ctrl *ctrl);
> >  void nvme_start_queues(struct nvme_ctrl *ctrl);
> >  void nvme_kill_queues(struct nvme_ctrl *ctrl);
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index fbc71fac6f1e..a2f3ad105620 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2303,6 +2303,7 @@ static void nvme_reset_work(struct work_struct *work)
> >  	 */
> >  	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
> >  		nvme_dev_disable(dev, false);
> > +	nvme_sync_queues(&dev->ctrl);
> 
> This sync may be raced with one timed-out request, which may be handled
> as BLK_EH_HANDLED or BLK_EH_RESET_TIMER, so the above sync queues can't
> work reliably. 
> 
> There are more issues except for the above one if disabling controller
> and resetting it are run in different context:
> 
> 1) inside resetting, nvme_dev_disable() may be called, but this way
> may cause double completion on the previous timed-out request.
> 
> 2) the timed-out request can't be covered by nvme_dev_disable(), and
> this way is too tricky and easy to cause trouble.
> 
> IMO, it is much easier to avoid the above issues by handling controller
> recover in one single thread. I will address all your comments and post
> V3 for review.
> 
> 
> Thanks,
> Ming
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
