Return-Path: <ming.lei@redhat.com>
Date: Thu, 26 Apr 2018 23:57:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] nvme: pci: simplify timeout handling
Message-ID: <20180426155722.GA3597@ming.t460p>
References: <20180426123956.26039-1-ming.lei@redhat.com>
 <20180426123956.26039-2-ming.lei@redhat.com>
 <b8dd2c24-a011-7e66-feca-502b0a6b10c0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b8dd2c24-a011-7e66-feca-502b0a6b10c0@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Hi Jianchao,

On Thu, Apr 26, 2018 at 11:07:56PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> Thanks for your wonderful solution. :)
> 
> On 04/26/2018 08:39 PM, Ming Lei wrote:
> > +/*
> > + * This one is called after queues are quiesced, and no in-fligh timeout
> > + * and nvme interrupt handling.
> > + */
> > +static void nvme_pci_cancel_request(struct request *req, void *data,
> > +		bool reserved)
> > +{
> > +	/* make sure timed-out requests are covered too */
> > +	if (req->rq_flags & RQF_MQ_TIMEOUT_EXPIRED) {
> > +		req->aborted_gstate = 0;
> > +		req->rq_flags &= ~RQF_MQ_TIMEOUT_EXPIRED;
> > +	}
> > +
> > +	nvme_cancel_request(req, data, reserved);
> > +}
> > +
> >  static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
> >  {
> >  	int i;
> > @@ -2223,10 +2316,17 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
> >  	for (i = dev->ctrl.queue_count - 1; i >= 0; i--)
> >  		nvme_suspend_queue(&dev->queues[i]);
> >  
> > +	/*
> > +	 * safe to sync timeout after queues are quiesced, then all
> > +	 * requests(include the time-out ones) will be canceled.
> > +	 */
> > +	nvme_sync_queues(&dev->ctrl);
> > +	blk_sync_queue(dev->ctrl.admin_q);
> > +
> Looks like blk_sync_queue cannot drain all the timeout work.
> 
> blk_sync_queue
>   -> del_timer_sync          
>                           blk_mq_timeout_work
>                             -> mod_timer
>   -> cancel_work_sync
> the timeout work may come back again.
> we may need to force all the in-flight requests to be timed out with blk_abort_request
> 

blk_abort_request() seems over-kill, we could avoid this race simply by
returning EH_NOT_HANDLED if the controller is in-recovery.

> >  	nvme_pci_disable(dev);
> 
> the interrupt will not come, but there maybe running one.
> a synchronize_sched() here ?

We may cover this case by moving nvme_suspend_queue() before
nvme_stop_queues().

Both two are very good catch, thanks!

-- 
Ming
