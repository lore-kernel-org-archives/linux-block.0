Return-Path: <msnitzer@redhat.com>
Date: Thu, 9 Nov 2017 16:22:17 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 4/7] nvme: implement multipath access to nvme subsystems
Message-ID: <20171109212217.GA16454@redhat.com>
References: <20171109174450.17142-1-hch@lst.de>
 <20171109174450.17142-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171109174450.17142-5-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 09 2017 at 12:44pm -0500,
Christoph Hellwig <hch@lst.de> wrote:

> This patch adds native multipath support to the nvme driver.  For each
> namespace we create only single block device node, which can be used
> to access that namespace through any of the controllers that refer to it.
> The gendisk for each controllers path to the name space still exists
> inside the kernel, but is hidden from userspace.  The character device
> nodes are still available on a per-controller basis.  A new link from
> the sysfs directory for the subsystem allows to find all controllers
> for a given subsystem.
> 
> Currently we will always send I/O to the first available path, this will
> be changed once the NVMe Asynchronous Namespace Access (ANA) TP is
> ratified and implemented, at which point we will look at the ANA state
> for each namespace.  Another possibility that was prototyped is to
> use the path that is closes to the submitting NUMA code, which will be
> mostly interesting for PCI, but might also be useful for RDMA or FC
> transports in the future.  There is not plan to implement round robin
> or I/O service time path selectors, as those are not scalable with
> the performance rates provided by NVMe.
> 
> The multipath device will go away once all paths to it disappear,
> any delay to keep it alive needs to be implemented at the controller
> level.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Your 0th header speaks to the NVMe multipath IO path leveraging NVMe's
lack of partial completion but I think it'd be useful to have this
header (that actually gets committed) speak to it.

> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> new file mode 100644
> index 000000000000..062754ebebfd
> --- /dev/null
> +++ b/drivers/nvme/host/multipath.c
...
> +void nvme_failover_req(struct request *req)
> +{
> +	struct nvme_ns *ns = req->q->queuedata;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ns->head->requeue_lock, flags);
> +	blk_steal_bios(&ns->head->requeue_list, req);
> +	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> +	blk_mq_end_request(req, 0);
> +
> +	nvme_reset_ctrl(ns->ctrl);
> +	kblockd_schedule_work(&ns->head->requeue_work);
> +}

Also, the block core patch to introduce blk_steal_bios() already went in
but should there be a QUEUE_FLAG that gets set by drivers like NVMe that
don't support partial completion?

This would make it easier for other future drivers to know whether they
can use a more optimized IO path.

Mike
