Return-Path: <guanjunxiong@huawei.com>
Subject: Re: [PATCH 10/10] nvme: implement multipath access to nvme subsystems
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Keith Busch <keith.busch@intel.com>, <linux-block@vger.kernel.org>,
        "Sagi
 Grimberg" <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        niuhaoxin
	<niuhaoxin@huawei.com>,
        "Shenhong (C)" <shenhong09@huawei.com>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-11-hch@lst.de>
From: Guan Junxiong <guanjunxiong@huawei.com>
Message-ID: <e751810f-bb91-f764-dd51-ce2faaf209f0@huawei.com>
Date: Tue, 29 Aug 2017 18:22:50 +0800
MIME-Version: 1.0
In-Reply-To: <20170823175815.3646-11-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>



On 2017/8/24 1:58, Christoph Hellwig wrote:
> -static inline bool nvme_req_needs_retry(struct request *req)
> +static bool nvme_failover_rq(struct request *req)
>  {
> -	if (blk_noretry_request(req))
> +	struct nvme_ns *ns = req->q->queuedata;
> +	unsigned long flags;
> +
> +	/*
> +	 * Only fail over commands that came in through the the multipath
> +	 * aware submissions path.  Note that ns->head might not be set up
> +	 * for commands used during controller initialization, but those
> +	 * must never set REQ_FAILFAST_TRANSPORT.
> +	 */
> +	if (!(req->cmd_flags & REQ_FAILFAST_TRANSPORT))
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
>  		return false;
> +	}
> +
> +	/* Anything else could be a path failure, so should be retried */
> +	spin_lock_irqsave(&ns->head->requeue_lock, flags);
> +	blk_steal_bios(&ns->head->requeue_list, req);
> +	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> +
> +	nvme_reset_ctrl(ns->ctrl);
> +	kblockd_schedule_work(&ns->head->requeue_work);
> +	return true;
> +}
> +
> +static inline bool nvme_req_needs_retry(struct request *req)
> +{
>  	if (nvme_req(req)->status & NVME_SC_DNR)
>  		return false;
>  	if (jiffies - req->start_time >= req->timeout)
>  		return false;
>  	if (nvme_req(req)->retries >= nvme_max_retries)
>  		return false;
> +	if (nvme_failover_rq(req))
> +		return false;
> +	if (blk_noretry_request(req))
> +		return false;
>  	return true;
>  }

Does this introduce conflicts with current DM-Multipath used for NVMe/NVMeF
when path IO error occurs?  Such IO will be retried not only on the nvme-mpath
internal path, but also on the dm-mpath path.

In general, I wonder whether nvme-mpath can co-exist with DM-multipath
in a well-defined fashion.
