Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E4FC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 09:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5127C60E05
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 09:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbhJMJIf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 05:08:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3974 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhJMJIe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 05:08:34 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HTml23zrvz6H6yb;
        Wed, 13 Oct 2021 17:02:38 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 11:06:29 +0200
Received: from [10.47.95.55] (10.47.95.55) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 10:06:28 +0100
Subject: Re: [PATCH 6/9] nvme: add support for batched completion of polled IO
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-7-axboe@kernel.dk>
From:   John Garry <john.garry@huawei.com>
Message-ID: <659e549a-db56-ecae-35a3-2f6203dc3a28@huawei.com>
Date:   Wed, 13 Oct 2021 10:09:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211012181742.672391-7-axboe@kernel.dk>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.55]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/10/2021 19:17, Jens Axboe wrote:
> Signed-off-by: Jens Axboe<axboe@kernel.dk>
> ---
>   drivers/nvme/host/pci.c | 69 +++++++++++++++++++++++++++++++++++++----
>   1 file changed, 63 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 4ad63bb9f415..4713da708cd4 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -959,7 +959,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	return ret;
>   }
>   
> -static void nvme_pci_complete_rq(struct request *req)
> +static void nvme_pci_unmap_rq(struct request *req)
>   {
>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>   	struct nvme_dev *dev = iod->nvmeq->dev;
> @@ -969,9 +969,34 @@ static void nvme_pci_complete_rq(struct request *req)
>   			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
>   	if (blk_rq_nr_phys_segments(req))
>   		nvme_unmap_data(dev, req);
> +}
> +
> +static void nvme_pci_complete_rq(struct request *req)
> +{
> +	nvme_pci_unmap_rq(req);
>   	nvme_complete_rq(req);
>   }
>   
> +static void nvme_pci_complete_batch(struct io_batch *ib)
> +{
> +	struct request *req;
> +
> +	req = ib->req_list;
> +	while (req) {
> +		nvme_pci_unmap_rq(req);

This will do the DMA SG unmap per request. Often this is a performance 
bottle neck when we have an IOMMU enabled in strict mode. So since we 
complete in batches, could we combine all the SGs in the batch to do one 
big DMA unmap SG, and not one-by-one?

Just a thought.

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
> +}

