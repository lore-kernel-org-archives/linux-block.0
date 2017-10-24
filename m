Return-Path: <hare@suse.de>
Subject: Re: [PATCH 16/17] nvme: implement multipath access to nvme subsystems
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-17-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <104278cd-0383-71e0-45c2-750108723b8b@suse.de>
Date: Tue, 24 Oct 2017 09:43:11 +0200
MIME-Version: 1.0
In-Reply-To: <20171023145126.2471-17-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/23/2017 04:51 PM, Christoph Hellwig wrote:
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
> ---
>  drivers/nvme/host/core.c | 398 ++++++++++++++++++++++++++++++++++++++++-------
>  drivers/nvme/host/nvme.h |  15 +-
>  drivers/nvme/host/pci.c  |   2 +
>  3 files changed, 355 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1db26729bd89..22c06cd3bef0 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -102,6 +102,20 @@ static int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
>  	return ret;
>  }
>  
> +static void nvme_failover_req(struct request *req)
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
> +
>  static blk_status_t nvme_error_status(struct request *req)
>  {
>  	switch (nvme_req(req)->status & 0x7ff) {
> @@ -129,6 +143,53 @@ static blk_status_t nvme_error_status(struct request *req)
>  	}
>  }
>  
> +static bool nvme_req_needs_failover(struct request *req)
> +{
> +	if (!(req->cmd_flags & REQ_NVME_MPATH))
> +		return false;
> +
> +	switch (nvme_req(req)->status & 0x7ff) {
> +	/*
> +	 * Generic command status:
> +	 */
> +	case NVME_SC_INVALID_OPCODE:
> +	case NVME_SC_INVALID_FIELD:
> +	case NVME_SC_INVALID_NS:
> +	case NVME_SC_LBA_RANGE:
> +	case NVME_SC_CAP_EXCEEDED:
> +	case NVME_SC_RESERVATION_CONFLICT:
> +		return false;
> +
> +	/*
> +	 * I/O command set specific error.  Unfortunately these values are
> +	 * reused for fabrics commands, but those should never get here.
> +	 */
> +	case NVME_SC_BAD_ATTRIBUTES:
> +	case NVME_SC_INVALID_PI:
> +	case NVME_SC_READ_ONLY:
> +	case NVME_SC_ONCS_NOT_SUPPORTED:
> +		WARN_ON_ONCE(nvme_req(req)->cmd->common.opcode ==
> +			nvme_fabrics_command);
> +		return false;
> +
> +	/*
> +	 * Media and Data Integrity Errors:
> +	 */
> +	case NVME_SC_WRITE_FAULT:
> +	case NVME_SC_READ_ERROR:
> +	case NVME_SC_GUARD_CHECK:
> +	case NVME_SC_APPTAG_CHECK:
> +	case NVME_SC_REFTAG_CHECK:
> +	case NVME_SC_COMPARE_FAILED:
> +	case NVME_SC_ACCESS_DENIED:
> +	case NVME_SC_UNWRITTEN_BLOCK:
> +		return false;
> +	}
> +
> +	/* Everything else could be a path failure, so should be retried */
> +	return true;
> +}
> +
>  static inline bool nvme_req_needs_retry(struct request *req)
>  {
>  	if (blk_noretry_request(req))
> @@ -143,6 +204,11 @@ static inline bool nvme_req_needs_retry(struct request *req)
>  void nvme_complete_rq(struct request *req)
>  {
>  	if (unlikely(nvme_req(req)->status && nvme_req_needs_retry(req))) {
> +		if (nvme_req_needs_failover(req)) {
> +			nvme_failover_req(req);
> +			return;
> +		}
> +
>  		nvme_req(req)->retries++;
>  		blk_mq_requeue_request(req, true);
>  		return;
Sure this works? nvme_req_needs_retry() checks blk_noretry_request():

static inline bool nvme_req_needs_retry(struct request *req)
{
	if (blk_noretry_request(req))
		return false;

which has:
#define blk_noretry_request(rq) \
	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
			     REQ_FAILFAST_DRIVER))

The original idea here was to _set_ these bits on multipath path devices
so that they won't attempt any retry, but rather forward the I/O error
to the multipath device itself for failover.
So if these bits are set (as they should be for multipathed devices)
we'll never attempt any failover...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
