Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955C8C433F5
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 19:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F29361B3D
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 19:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbhKQTop (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 14:44:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:48388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240565AbhKQTop (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 14:44:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA96761B42;
        Wed, 17 Nov 2021 19:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637178106;
        bh=zY/+GrC0s4U2Uo9qqNFqoXuRe7yQipDGHjq21HPK3mI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SJCukQbz50UdYbATqf7kCBfn2hlQ/qRUDxPyE2JDePqbFQlV84PKUU3I7K9EPdri8
         aP1jO6Z/+BDveuZT1IzcNs02kNCdIc5lj6zM61jPX/GY7uevbeomQ6IJOPNdcHrS3C
         KHoedRaY0zIMShgnXo/z4g/OA48a/bkfzbU6pib7D4BP0ylHBbDSQ27jolrq05g4Wz
         V7T4DFzi6+3+ZKGn7fUJehVf7p/iR7YZWhn52ify5+Us1445mFiNtsYsJrCmme1yOV
         KSYEjTjBt1aY2QLm1knfoL2avLkxArynuvI68rz0TZcfIEXexpJpiz3pxPCNsPBDql
         Cz3+HSY0aV1VA==
Date:   Wed, 17 Nov 2021 11:41:43 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
Message-ID: <20211117194143.GA2988482@dhcp-10-100-145-180.wdc.com>
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117033807.185715-5-axboe@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[adding linux-nvme]

On Tue, Nov 16, 2021 at 08:38:07PM -0700, Jens Axboe wrote:
> This enables the block layer to send us a full plug list of requests
> that need submitting. The block layer guarantees that they all belong
> to the same queue, but we do have to check the hardware queue mapping
> for each request.

So this means that the nvme namespace will always be the same for all
the requests in the list, but the rqlist may contain requests allocated
from different CPUs?
 
> If errors are encountered, leave them in the passed in list. Then the
> block layer will handle them individually.
> 
> This is good for about a 4% improvement in peak performance, taking us
> from 9.6M to 10M IOPS/core.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/nvme/host/pci.c | 67 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d2b654fc3603..2eedd04b1f90 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1004,6 +1004,72 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	return ret;
>  }
>  
> +static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct request **rqlist)
> +{
> +	spin_lock(&nvmeq->sq_lock);
> +	while (!rq_list_empty(*rqlist)) {
> +		struct request *req = rq_list_pop(rqlist);
> +		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +
> +		nvme_copy_cmd(nvmeq, absolute_pointer(&iod->cmd));
> +	}
> +	nvme_write_sq_db(nvmeq, true);
> +	spin_unlock(&nvmeq->sq_lock);
> +}
> +
> +static void nvme_queue_rqs(struct request **rqlist)
> +{
> +	struct request *requeue_list = NULL, *req, *prev = NULL;
> +	struct blk_mq_hw_ctx *hctx;
> +	struct nvme_queue *nvmeq;
> +	struct nvme_ns *ns;
> +
> +restart:
> +	req = rq_list_peek(rqlist);
> +	hctx = req->mq_hctx;
> +	nvmeq = hctx->driver_data;
> +	ns = hctx->queue->queuedata;
> +
> +	/*
> +	 * We should not need to do this, but we're still using this to
> +	 * ensure we can drain requests on a dying queue.
> +	 */
> +	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
> +		return;
> +
> +	rq_list_for_each(rqlist, req) {
> +		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +		blk_status_t ret;
> +
> +		if (unlikely(!nvme_check_ready(&nvmeq->dev->ctrl, req, true)))
> +			goto requeue;
> +
> +		if (req->mq_hctx != hctx) {
> +			/* detach rest of list, and submit */
> +			prev->rq_next = NULL;
> +			nvme_submit_cmds(nvmeq, rqlist);
> +			/* req now start of new list for this hw queue */
> +			*rqlist = req;
> +			goto restart;
> +		}
> +
> +		hctx->tags->rqs[req->tag] = req;

After checking how this is handled previously, it appears this new
.queue_rqs() skips incrementing active requests, and bypasses the
hctx_lock(). Won't that break quiesce?

> +		ret = nvme_prep_rq(nvmeq->dev, ns, req, &iod->cmd);
> +		if (ret == BLK_STS_OK) {
> +			prev = req;
> +			continue;
> +		}
> +requeue:
> +		/* detach 'req' and add to remainder list */
> +		if (prev)
> +			prev->rq_next = req->rq_next;
> +		rq_list_add(&requeue_list, req);
> +	}
> +
> +	nvme_submit_cmds(nvmeq, rqlist);
> +	*rqlist = requeue_list;
> +}
> +
>  static __always_inline void nvme_pci_unmap_rq(struct request *req)
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> @@ -1741,6 +1807,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
>  
>  static const struct blk_mq_ops nvme_mq_ops = {
>  	.queue_rq	= nvme_queue_rq,
> +	.queue_rqs	= nvme_queue_rqs,
>  	.complete	= nvme_pci_complete_rq,
>  	.commit_rqs	= nvme_commit_rqs,
>  	.init_hctx	= nvme_init_hctx,
> -- 
