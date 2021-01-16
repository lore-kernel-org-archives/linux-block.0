Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48907C433E6
	for <linux-block@archiver.kernel.org>; Sat, 16 Jan 2021 01:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C95239E4
	for <linux-block@archiver.kernel.org>; Sat, 16 Jan 2021 01:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbhAPBTV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jan 2021 20:19:21 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:39597 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbhAPBTV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jan 2021 20:19:21 -0500
Received: by mail-pg1-f174.google.com with SMTP id 30so7118172pgr.6
        for <linux-block@vger.kernel.org>; Fri, 15 Jan 2021 17:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bk1g4DDQRejcA8N92RC1Q91YUpSSEep8rJPoxm/h/vY=;
        b=tXZWsONjBpWfCfs951IZy1QIhQi9jJ536ArlKotIO2k5g9aeCxAhvNOs7rt6y/VtIO
         gz+KOJyj3GeqpJOThhiYfCQ4Y5rdXEcFPZ1U6ueEAS6tWRC/AIqAyCmh9sMY089KQIgl
         obd0t4MRjfP+mx20AKcbr7t6HCplMyHnxqu3dRP5T0Jbv6H8ndhwjyldoUpjsCWWwEkt
         7oqFptv3Z+A0mAlsB3Zb3naLtQbbuijxOH5lEN2iv3KNJpUiTRsZ9lKD/91+FiVM3+x6
         uwubKyOvmTSI0aUHNBihrRXcPQNW/VtCJBxK5Yt7/w0PVyof5rjfkqbusvOX5FHcuW8F
         SP9Q==
X-Gm-Message-State: AOAM531FC1zKlQVWkbrRnDCuhIYW0+7VVQS594jAxp9tp3VXi4uwB9jy
        xCAjzYptsvVhDO4XeCZj4Erjm64ByHA=
X-Google-Smtp-Source: ABdhPJzMUulJ5IqzhoPjxrSkH/xb78AxnsprNqcD2AC6+RH9EhU5NLjatBndzXTsFhD3j6ONl2sB9A==
X-Received: by 2002:a62:ea17:0:b029:1ad:4788:7815 with SMTP id t23-20020a62ea170000b02901ad47887815mr15523329pfh.1.1610759920292;
        Fri, 15 Jan 2021 17:18:40 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:5e2f:377f:716f:f0b9? ([2601:647:4802:9070:5e2f:377f:716f:f0b9])
        by smtp.gmail.com with ESMTPSA id 22sm9073073pfn.190.2021.01.15.17.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 17:18:39 -0800 (PST)
Subject: Re: [PATCH v2 4/6] nvme-rdma: avoid IO error and repeated request
 completion
To:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de,
        linux-block@vger.kernel.org, axboe@kernel.dk
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-5-lengchao@huawei.com>
 <07e41b4f-914a-11e8-5638-e2d6408feb3f@grimberg.me>
 <7b12be41-0fcd-5a22-0e01-8cd4ac9cde5b@huawei.com>
 <a3404c7d-ccc8-0d55-d4a8-fc15107c90e6@grimberg.me>
 <695b6839-5333-c342-2189-d7aaeba797a7@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4ff22d33-12fa-1f70-3606-54821f314c45@grimberg.me>
Date:   Fri, 15 Jan 2021 17:18:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <695b6839-5333-c342-2189-d7aaeba797a7@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>>> When a request is queued failed, blk_status_t is directly returned
>>>>> to the blk-mq. If blk_status_t is not BLK_STS_RESOURCE,
>>>>> BLK_STS_DEV_RESOURCE, BLK_STS_ZONE_RESOURCE, blk-mq call
>>>>> blk_mq_end_request to complete the request with BLK_STS_IOERR.
>>>>> In two scenarios, the request should be retried and may succeed.
>>>>> First, if work with nvme multipath, the request may be retried
>>>>> successfully in another path, because the error is probably related to
>>>>> the path. Second, if work without multipath software, the request may
>>>>> be retried successfully after error recovery.
>>>>> If the request is complete with BLK_STS_IOERR in 
>>>>> blk_mq_dispatch_rq_list.
>>>>> The state of request may be changed to MQ_RQ_IN_FLIGHT. If free the
>>>>> request asynchronously such as in nvme_submit_user_cmd, in extreme
>>>>> scenario the request will be repeated freed in tear down.
>>>>> If a non-resource error occurs in queue_rq, should directly call
>>>>> nvme_complete_rq to complete request and set the state of request to
>>>>> MQ_RQ_COMPLETE. nvme_complete_rq will decide to retry, fail over or 
>>>>> end
>>>>> the request.
>>>>>
>>>>> Signed-off-by: Chao Leng <lengchao@huawei.com>
>>>>> ---
>>>>>   drivers/nvme/host/rdma.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>>>>> index df9f6f4549f1..4a89bf44ecdc 100644
>>>>> --- a/drivers/nvme/host/rdma.c
>>>>> +++ b/drivers/nvme/host/rdma.c
>>>>> @@ -2093,7 +2093,7 @@ static blk_status_t nvme_rdma_queue_rq(struct 
>>>>> blk_mq_hw_ctx *hctx,
>>>>>   unmap_qe:
>>>>>       ib_dma_unmap_single(dev, req->sqe.dma, sizeof(struct 
>>>>> nvme_command),
>>>>>                   DMA_TO_DEVICE);
>>>>> -    return ret;
>>>>> +    return nvme_try_complete_failed_req(rq, ret);
>>>>
>>>> I don't understand this. There are errors that may not be related to
>>>> anything that is pathing related (sw bug, memory leak, mapping error,
>>>> etc, etc) why should we return this one-shot error?
>>> Although fail over retry is not required, if we return the error to
>>> blk-mq, a low probability crash may happen. because blk-mq do not set
>>> the state of request to MQ_RQ_COMPLETE before complete the request,
>>> the request may be freed asynchronously such as in nvme_submit_user_cmd.
>>> If race with error recovery, request double completion may happens.
>>
>> Then fix that, don't work around it.
> I'm not trying to work around it. The purpose of this is to solve
> the problem of nvme native multipathing at the same time.

Please explain how this is an nvme-multipath issue?

>>
>>>
>>> So we can not return the error to blk-mq if the blk_status_t is not
>>> BLK_STS_RESOURCE, BLK_STS_DEV_RESOURCE, BLK_STS_ZONE_RESOURCE.
>>
>> This is not something we should be handling in nvme. block drivers
>> should be able to fail queue_rq, and this all should live in the
>> block layer.
> Of course, it is also an idea to repair the block drivers directly.
> However, block layer is unaware of nvme native multipathing,

Nor it should be

> will cause the request return error which should be avoided.

Not sure I understand..
requests should failover for path related errors,
what queue_rq errors are expected to be failed over from your
perspective?

> The scenario: use two HBAs for nvme native multipath, and then one HBA
> fault,

What is the specific error the driver sees?

> the blk_status_t of queue_rq is BLK_STS_IOERR, blk-mq will call
> blk_mq_end_request to complete the request which bypass name native
> multipath. We expect the request fail over to normal HBA, but the request
> is directly completed with BLK_STS_IOERR.
> The two scenarios can be fixed by directly completing the request in 
> queue_rq.
Well, certainly this one-shot always return 0 and complete the command
with HOST_PATH error is not a good approach IMO
