Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD4FC433DB
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 09:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9F5239D1
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 09:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbhAUI74 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 03:59:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:39960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbhAUI7h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 03:59:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE63CAD0B;
        Thu, 21 Jan 2021 08:58:40 +0000 (UTC)
Subject: Re: [PATCH v3 3/5] nvme-fabrics: avoid double request completion for
 nvmf_fail_nonready_command
To:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
        axboe@fb.com, kbusch@kernel.org, hch@lst.de
References: <20210121070330.19701-1-lengchao@huawei.com>
 <20210121070330.19701-4-lengchao@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <fda1fdb8-8a9d-2e95-4d08-8d8ee1df450d@suse.de>
Date:   Thu, 21 Jan 2021 09:58:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210121070330.19701-4-lengchao@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/21/21 8:03 AM, Chao Leng wrote:
> When reconnect, the request may be completed with NVME_SC_HOST_PATH_ERROR
> in nvmf_fail_nonready_command. The state of request will be changed to
> MQ_RQ_IN_FLIGHT before call nvme_complete_rq. If free the request
> asynchronously such as in nvme_submit_user_cmd, in extreme scenario
> the request may be completed again in tear down process.
> nvmf_fail_nonready_command do not need calling blk_mq_start_request
> before complete the request. nvmf_fail_nonready_command should set
> the state of request to MQ_RQ_COMPLETE before complete the request.
> 

So what you are saying is that there is a race condition between
blk_mq_start_request()
and
nvme_complete_request()

> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>   drivers/nvme/host/fabrics.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 72ac00173500..874e4320e214 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -553,9 +553,7 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
>   	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
>   		return BLK_STS_RESOURCE;
>   
> -	nvme_req(rq)->status = NVME_SC_HOST_PATH_ERROR;
> -	blk_mq_start_request(rq);
> -	nvme_complete_rq(rq);
> +	nvme_complete_failed_req(rq);
>   	return BLK_STS_OK;
>   }
>   EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
> I'd rather have 'nvme_complete_failed_req()' accept the status as 
argument, like

nvme_complete_failed_request(rq, NVME_SC_HOST_PATH_ERROR)

that way it's obvious what is happening, and the status isn't hidden in 
the function.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
