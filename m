Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D658C433DB
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 05:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D9764F4E
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 05:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBDF5S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 00:57:18 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3418 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhBDF5S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 00:57:18 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DWSSh5Fk7z5Ngf;
        Thu,  4 Feb 2021 13:55:16 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 4 Feb 2021 13:56:35 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Thu, 4 Feb
 2021 13:56:35 +0800
Subject: Re: [PATCH v5 0/3] avoid double request completion and IO error
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
        <axboe@fb.com>, <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>
References: <20210201034940.18891-1-lengchao@huawei.com>
 <20210203161455.GB4116@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <7d39e0a4-3765-85b8-aab5-b0ded93f8bec@huawei.com>
Date:   Thu, 4 Feb 2021 13:56:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210203161455.GB4116@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme716-chm.china.huawei.com (10.1.199.112) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This looks good to me.
Thank you very much.

On 2021/2/4 0:14, Christoph Hellwig wrote:
> So I think this is conceptually fine, but I still find the API a little
> arcane.  What do you think about the following incremental patch?
> If that looks good and tests good for you I can apply the series with
> the modifications:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0befaad788a094..02579f4f776c7d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -355,6 +355,21 @@ void nvme_complete_rq(struct request *req)
>   }
>   EXPORT_SYMBOL_GPL(nvme_complete_rq);
>   
> +/*
> + * Called to unwind from ->queue_rq on a failed command submission so that the
> + * multipathing code gets called to potentially failover to another path.
> + * The caller needs to unwind all transport specific resource allocations and
> + * must return propagate the return value.
> + */
> +blk_status_t nvme_host_path_error(struct request *req)
> +{
> +	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
> +	blk_mq_set_request_complete(req);
> +	nvme_complete_rq(req);
> +	return BLK_STS_OK;
> +}
> +EXPORT_SYMBOL_GPL(nvme_host_path_error);
> +
>   bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>   {
>   	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index cedf9b31898673..5dfd806fc2d28c 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -552,11 +552,7 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
>   	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
>   	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
>   		return BLK_STS_RESOURCE;
> -
> -	nvme_req(rq)->status = NVME_SC_HOST_PATH_ERROR;
> -	blk_mq_set_request_complete(rq);
> -	nvme_complete_rq(rq);
> -	return BLK_STS_OK;
> +	return nvme_host_path_error(rq);
>   }
>   EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a72f0718109100..5819f038104149 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -575,6 +575,7 @@ static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
>   }
>   
>   void nvme_complete_rq(struct request *req);
> +blk_status_t nvme_host_path_error(struct request *req);
>   bool nvme_cancel_request(struct request *req, void *data, bool reserved);
>   void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
>   void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 6993efb27b39f0..f51af5e4970a2b 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2091,16 +2091,6 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
>   			req->mr ? &req->reg_wr.wr : NULL);
>   	if (unlikely(err)) {
> -		if (err == -EIO) {
> -			/*
> -			 * Fail the reqest so upper layer can failover I/O
> -			 * if another path is available
> -			 */
> -			req->status = NVME_SC_HOST_PATH_ERROR;
> -			blk_mq_set_request_complete(rq);
> -			nvme_rdma_complete_rq(rq);
> -			return BLK_STS_OK;
> -		}
>   		goto err_unmap;
>   	}
>   
> @@ -2109,7 +2099,9 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>   err_unmap:
>   	nvme_rdma_unmap_data(queue, rq);
>   err:
> -	if (err == -ENOMEM || err == -EAGAIN)
> +	if (err == -EIO)
> +		ret = nvme_host_path_error(rq);
> +	else if (err == -ENOMEM || err == -EAGAIN)
>   		ret = BLK_STS_RESOURCE;
>   	else
>   		ret = BLK_STS_IOERR;
> .
> 
