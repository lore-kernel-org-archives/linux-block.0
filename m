Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAE7C433DB
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 21:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D53523117
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 21:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbhANV0P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jan 2021 16:26:15 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:43422 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbhANV0N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jan 2021 16:26:13 -0500
Received: by mail-oi1-f177.google.com with SMTP id q25so7429868oij.10
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 13:25:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wQfZzkSVTsHcN34H+4B7fx0/39tNd164MXiCBd1US7M=;
        b=euCu+w+5C/WuSEFkHcpGGXmMACn1iBBM9AE+H+iCNOvZ3OsQxGk1tldMNX3BepnepC
         ILzQ83bqdHMoOMSc7e7av721rlvTeyMVX/YmoBTmnmQm+YXZNlEH2Ux99TyyMFCxJyA3
         9xhIft6loWshoSmsgV8mx9C0lTSq+VqqEoneJtt1yk+nJDZxdcBPMQbBvjOFE5kFMHod
         7lAJvZrWkHmyN2QLc0ihMnkS5BYYy0LJkv8BFltwRFzpWUgObLVZs9ZzYOOzXblfaEVv
         in4lfBsaXGkmMirvD3kbfUufTiEcmBPxthEl2p6sTFg8PZiadkypZsjOC2PXHbr8d84M
         qwsg==
X-Gm-Message-State: AOAM5333f3Vv8ngESanvMLkWuHeDyiSrbpwYehfxXaL0bv2NE98OxZ7z
        zQD2jiXsD90HhBdATnHgP70=
X-Google-Smtp-Source: ABdhPJwfhRlKIsA2gWEuDrLjv5IY1+pOKcBqWFqjbkr57zkpptbpG7tMV2DQjnpqXXu+G7rt9Yovhg==
X-Received: by 2002:a54:479a:: with SMTP id o26mr3783510oic.48.1610659531914;
        Thu, 14 Jan 2021 13:25:31 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:9240:50d6:cd00:1b14? ([2600:1700:65a0:78e0:9240:50d6:cd00:1b14])
        by smtp.gmail.com with ESMTPSA id s66sm1330357ooa.37.2021.01.14.13.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 13:25:31 -0800 (PST)
Subject: Re: [PATCH v2 4/6] nvme-rdma: avoid IO error and repeated request
 completion
To:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de,
        linux-block@vger.kernel.org, axboe@kernel.dk
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-5-lengchao@huawei.com>
 <07e41b4f-914a-11e8-5638-e2d6408feb3f@grimberg.me>
 <7b12be41-0fcd-5a22-0e01-8cd4ac9cde5b@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a3404c7d-ccc8-0d55-d4a8-fc15107c90e6@grimberg.me>
Date:   Thu, 14 Jan 2021 13:25:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7b12be41-0fcd-5a22-0e01-8cd4ac9cde5b@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> When a request is queued failed, blk_status_t is directly returned
>>> to the blk-mq. If blk_status_t is not BLK_STS_RESOURCE,
>>> BLK_STS_DEV_RESOURCE, BLK_STS_ZONE_RESOURCE, blk-mq call
>>> blk_mq_end_request to complete the request with BLK_STS_IOERR.
>>> In two scenarios, the request should be retried and may succeed.
>>> First, if work with nvme multipath, the request may be retried
>>> successfully in another path, because the error is probably related to
>>> the path. Second, if work without multipath software, the request may
>>> be retried successfully after error recovery.
>>> If the request is complete with BLK_STS_IOERR in 
>>> blk_mq_dispatch_rq_list.
>>> The state of request may be changed to MQ_RQ_IN_FLIGHT. If free the
>>> request asynchronously such as in nvme_submit_user_cmd, in extreme
>>> scenario the request will be repeated freed in tear down.
>>> If a non-resource error occurs in queue_rq, should directly call
>>> nvme_complete_rq to complete request and set the state of request to
>>> MQ_RQ_COMPLETE. nvme_complete_rq will decide to retry, fail over or end
>>> the request.
>>>
>>> Signed-off-by: Chao Leng <lengchao@huawei.com>
>>> ---
>>>   drivers/nvme/host/rdma.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>>> index df9f6f4549f1..4a89bf44ecdc 100644
>>> --- a/drivers/nvme/host/rdma.c
>>> +++ b/drivers/nvme/host/rdma.c
>>> @@ -2093,7 +2093,7 @@ static blk_status_t nvme_rdma_queue_rq(struct 
>>> blk_mq_hw_ctx *hctx,
>>>   unmap_qe:
>>>       ib_dma_unmap_single(dev, req->sqe.dma, sizeof(struct 
>>> nvme_command),
>>>                   DMA_TO_DEVICE);
>>> -    return ret;
>>> +    return nvme_try_complete_failed_req(rq, ret);
>>
>> I don't understand this. There are errors that may not be related to
>> anything that is pathing related (sw bug, memory leak, mapping error,
>> etc, etc) why should we return this one-shot error?
> Although fail over retry is not required, if we return the error to
> blk-mq, a low probability crash may happen. because blk-mq do not set
> the state of request to MQ_RQ_COMPLETE before complete the request,
> the request may be freed asynchronously such as in nvme_submit_user_cmd.
> If race with error recovery, request double completion may happens.

Then fix that, don't work around it.

> 
> So we can not return the error to blk-mq if the blk_status_t is not
> BLK_STS_RESOURCE, BLK_STS_DEV_RESOURCE, BLK_STS_ZONE_RESOURCE.

This is not something we should be handling in nvme. block drivers
should be able to fail queue_rq, and this all should live in the
block layer.
