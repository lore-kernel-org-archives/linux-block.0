Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD06C433DB
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 00:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 737DC23343
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 00:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbhANAbw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 19:31:52 -0500
Received: from mail-ej1-f54.google.com ([209.85.218.54]:43873 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbhANAab (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 19:30:31 -0500
Received: by mail-ej1-f54.google.com with SMTP id jx16so5684891ejb.10
        for <linux-block@vger.kernel.org>; Wed, 13 Jan 2021 16:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QKyQAKUG74ERfhNn7PLJoK1vBWNcwgfr7UQBcd/3CAY=;
        b=Q/r0t4H1IK8DQNUomfrBNz/ugEos85j6h7g9eOUDsQ00b2wM/RkzkG7D8Gu3Hjxm+i
         rgOlbtc+0Uvs+8vjpi+CC9aPn8adtM7ciCtLIZzHtr+eptIMN9QYNkAGzm3V1Na+1PFX
         m7eampgzN9eT8EvMcEGJByT9beuNj7ZZLa1g0qPr9CkZZ16yfre4JMXWNLDSoZtSYWQ4
         974GDRNsfkSm1yEy0+z9C40/QsZetDmxLhmqe4svN3fI2a2/Aowj4AkPbeIHwMXE2rjG
         QeF4he3raui+9VWDR5sOsiuur4nyzB4lRNHxfpIEyLeTd62VoTHMxSyuvuKF/2ddaeQZ
         nOxQ==
X-Gm-Message-State: AOAM531k7WSubVFFrDx9MqlsqOAJ75Y3G8YIQ4SOM97EkIvgiyGt3/gJ
        oTVRt8sXkRXkmr5QthDMr3Lg9O2Sg1w=
X-Google-Smtp-Source: ABdhPJzxrhFpOBtsKJZ4rbU+zKE/yi0qjhtXrcnLSfbOSfEjClVRzjHS0tCL8T5ekeYRPwJlH1HWlQ==
X-Received: by 2002:a5d:5146:: with SMTP id u6mr5053555wrt.46.1610583590598;
        Wed, 13 Jan 2021 16:19:50 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988? ([2601:647:4802:9070:e70c:620a:4d8a:b988])
        by smtp.gmail.com with ESMTPSA id s3sm4848530wmc.44.2021.01.13.16.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 16:19:50 -0800 (PST)
Subject: Re: [PATCH v2 4/6] nvme-rdma: avoid IO error and repeated request
 completion
To:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de,
        linux-block@vger.kernel.org, axboe@kernel.dk
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-5-lengchao@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <07e41b4f-914a-11e8-5638-e2d6408feb3f@grimberg.me>
Date:   Wed, 13 Jan 2021 16:19:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210107033149.15701-5-lengchao@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> When a request is queued failed, blk_status_t is directly returned
> to the blk-mq. If blk_status_t is not BLK_STS_RESOURCE,
> BLK_STS_DEV_RESOURCE, BLK_STS_ZONE_RESOURCE, blk-mq call
> blk_mq_end_request to complete the request with BLK_STS_IOERR.
> In two scenarios, the request should be retried and may succeed.
> First, if work with nvme multipath, the request may be retried
> successfully in another path, because the error is probably related to
> the path. Second, if work without multipath software, the request may
> be retried successfully after error recovery.
> If the request is complete with BLK_STS_IOERR in blk_mq_dispatch_rq_list.
> The state of request may be changed to MQ_RQ_IN_FLIGHT. If free the
> request asynchronously such as in nvme_submit_user_cmd, in extreme
> scenario the request will be repeated freed in tear down.
> If a non-resource error occurs in queue_rq, should directly call
> nvme_complete_rq to complete request and set the state of request to
> MQ_RQ_COMPLETE. nvme_complete_rq will decide to retry, fail over or end
> the request.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>   drivers/nvme/host/rdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index df9f6f4549f1..4a89bf44ecdc 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2093,7 +2093,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>   unmap_qe:
>   	ib_dma_unmap_single(dev, req->sqe.dma, sizeof(struct nvme_command),
>   			    DMA_TO_DEVICE);
> -	return ret;
> +	return nvme_try_complete_failed_req(rq, ret);

I don't understand this. There are errors that may not be related to
anything that is pathing related (sw bug, memory leak, mapping error,
etc, etc) why should we return this one-shot error?
