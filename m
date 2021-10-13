Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D0CC4332F
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 07:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30AA8610A0
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 07:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238336AbhJMHME (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 03:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238334AbhJMHMA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 03:12:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A77C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 00:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q6v1qYFSzejbOcobGcA8Pm+xEYzFhY58TnbWUsVzHpo=; b=LZ807zr40oKfQ/3XaZ234bbepp
        O7ZlqrbcmChRK8l+c/WFUWdaAbTDMNzbL8QJ1CrClLgftGQygV7FrFmVoqrGDjSwm5/ENkWewnSOu
        cchTuCmSNeyVdIp1C0xLSWDBoO6QzpX77TqYmlcNINZORut5cIS9f7tfKM7K9vk0IdIN3MRhbF+P7
        z91fGeCsqD9BSJxdQYHkh+nanuIVzBgqKOvFQxVNKEknWmYy4L2QOgUpUNPv4hG4tOWlam92zU245
        O4C3AF1nWMRB5MwmMRSlwzKmg6mOnHPDOjtA/Rd0R7qJeGj3EmGdLArurMjhQDcZZ2TjYXxPULjzX
        JiGWAwTw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maYNj-007Czh-9Z; Wed, 13 Oct 2021 07:09:10 +0000
Date:   Wed, 13 Oct 2021 08:08:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 6/9] nvme: add support for batched completion of polled IO
Message-ID: <YWaGB/798mw3kt9O@infradead.org>
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-7-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012181742.672391-7-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 12, 2021 at 12:17:39PM -0600, Jens Axboe wrote:
> Take advantage of struct io_batch, if passed in to the nvme poll handler.
> If it's set, rather than complete each request individually inline, store
> them in the io_batch list. We only do so for requests that will complete
> successfully, anything else will be completed inline as before.
> 
> Add an mq_ops->complete_batch() handler to do the post-processing of
> the io_batch list once polling is complete.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/nvme/host/pci.c | 69 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 63 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 4ad63bb9f415..4713da708cd4 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -959,7 +959,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	return ret;
>  }
>  
> -static void nvme_pci_complete_rq(struct request *req)
> +static void nvme_pci_unmap_rq(struct request *req)
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  	struct nvme_dev *dev = iod->nvmeq->dev;
> @@ -969,9 +969,34 @@ static void nvme_pci_complete_rq(struct request *req)
>  			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
>  	if (blk_rq_nr_phys_segments(req))
>  		nvme_unmap_data(dev, req);
> +}
> +
> +static void nvme_pci_complete_rq(struct request *req)
> +{
> +	nvme_pci_unmap_rq(req);
>  	nvme_complete_rq(req);
>  }
>  
> +static void nvme_pci_complete_batch(struct io_batch *ib)
> +{
> +	struct request *req;
> +
> +	req = ib->req_list;
> +	while (req) {
> +		nvme_pci_unmap_rq(req);
> +		if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
> +			nvme_cleanup_cmd(req);
> +		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +				req_op(req) == REQ_OP_ZONE_APPEND)
> +			req->__sector = nvme_lba_to_sect(req->q->queuedata,
> +					le64_to_cpu(nvme_req(req)->result.u64));
> +		req->status = nvme_error_status(nvme_req(req)->status);
> +		req = req->rq_next;
> +	}
> +
> +	blk_mq_end_request_batch(ib);

I hate all this open coding.  All the common logic needs to be in a
common helper.  Also please add a for_each macro for the request list
iteration.  I already thought about that for the batch allocation in
for-next, but with ever more callers this becomes essential.

> +	if (!nvme_try_complete_req(req, cqe->status, cqe->result)) {
> +		enum nvme_disposition ret;
> +
> +		ret = nvme_decide_disposition(req);
> +		if (unlikely(!ib || req->end_io || ret != COMPLETE)) {
> +			nvme_pci_complete_rq(req);

This actually is the likely case as only polling ever does the batch
completion.  In doubt I'd prefer if we can avoid these likely/unlikely
annotations as much as possible.

> +		} else {
> +			req->rq_next = ib->req_list;
> +			ib->req_list = req;
> +		}

And all this list manipulation should use proper helper.

> +	}

Also - can you look into turning this logic into an inline function with
a callback for the driver?  I think in general gcc will avoid the
indirect call for function pointers passed directly.  That way we can
keep a nice code structure but also avoid the indirections.

Same for nvme_pci_complete_batch.
