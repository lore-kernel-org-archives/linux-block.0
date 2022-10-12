Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108CAC4332F
	for <linux-block@archiver.kernel.org>; Wed, 12 Oct 2022 11:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJLLNa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Oct 2022 07:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiJLLNM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Oct 2022 07:13:12 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC4DC1DAE
        for <linux-block@vger.kernel.org>; Wed, 12 Oct 2022 04:13:10 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id w18so25731438wro.7
        for <linux-block@vger.kernel.org>; Wed, 12 Oct 2022 04:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYwAFeqLYBKSSkklslUc0pZkYbBAAiL2WVEM/FMS73I=;
        b=f7T6NkZyvoJX29ZKAjzf/d1vbwNzYGiIMN7BvwaSCitReNALkF66CvD7V1WH7G+f5P
         q1I8wS+y7SYKRQhCiFRqruRvmH3rroOLnyiMeCqbqAnGoracCYzZSn8/LEVG0setiUvH
         GJ1Wd1Wvt/nfFA0WToCCqy6GuyNtlPC+KXn+D39j0fsCUJKY4pgXo03xoLzvepfjM3CA
         0W3JioCu+QnzzLCQeA/30/AZBgyldEOKmgVP3hED30hZeaT6LHYezJR5svA1EdkLff3Y
         yflhNKhcMaVV0lcb80OBZwo06lD5f4N8pWCwozgCthPHW437zWZahGRJAOx0GKJrdYGY
         6gdg==
X-Gm-Message-State: ACrzQf2lJojtzuwGxQrC8yL/dCw7mP1AWsJ1851nojfbHFgD/35CImBJ
        8KFVqc/FuqiB9ds/zjo4isI=
X-Google-Smtp-Source: AMsMyM6gYolkmlmkcNvJqQug5jnk8hs+QgSR5b9WwZPW3HSqCwyqP+BcFHysKcfqRfn9jnG6mHi0UA==
X-Received: by 2002:a05:6000:1244:b0:22e:4d39:a0e3 with SMTP id j4-20020a056000124400b0022e4d39a0e3mr17093808wrx.509.1665573189292;
        Wed, 12 Oct 2022 04:13:09 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b003c6b874a0dfsm1877110wms.14.2022.10.12.04.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 04:13:08 -0700 (PDT)
Message-ID: <a44292df-ce46-828a-91a6-aa7377aa23f7@grimberg.me>
Date:   Wed, 12 Oct 2022 14:13:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/3] improve nvme quiesce time for large amount of
 namespaces
Content-Language: en-US
To:     Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@kernel.dk
References: <20220729073948.32696-1-lengchao@huawei.com>
 <20220729142605.GA395@lst.de>
 <1b3d753a-6ff5-bdf1-8c91-4b4760ea1736@huawei.com>
 <fc7a303f-0921-f784-a559-f03511f2e4be@grimberg.me>
 <20220802133815.GA380@lst.de>
 <537c24ba-e984-811e-9e51-ecbc2af9895d@huawei.com>
 <5fc61f6c-3d3e-ce0e-a090-aa5bcdb7721c@grimberg.me>
 <f9fce880-4714-3cdb-dfd1-f1d77d033d7a@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f9fce880-4714-3cdb-dfd1-f1d77d033d7a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 10/12/22 11:43, Chao Leng wrote:
> Add Ming Lei.
> 
> On 2022/10/12 14:37, Sagi Grimberg wrote:
>>
>>>> On Sun, Jul 31, 2022 at 01:23:36PM +0300, Sagi Grimberg wrote:
>>>>> But maybe we can avoid that, and because we allocate
>>>>> the connect_q ourselves, and fully know that it should
>>>>> not be apart of the tagset quiesce, perhaps we can introduce
>>>>> a new interface like:
>>>>> -- 
>>>>> static inline int nvme_ctrl_init_connect_q(struct nvme_ctrl *ctrl)
>>>>> {
>>>>>     ctrl->connect_q = blk_mq_init_queue_self_quiesce(ctrl->tagset);
>>>>>     if (IS_ERR(ctrl->connect_q))
>>>>>         return PTR_ERR(ctrl->connect_q);
>>>>>     return 0;
>>>>> }
>>>>> -- 
>>>>>
>>>>> And then blk_mq_quiesce_tagset can simply look into a per 
>>>>> request-queue
>>>>> self_quiesce flag and skip as needed.
>>>>
>>>> I'd just make that a queue flag set after allocation to keep the
>>>> interface simple, but otherwise this seems like the right thing
>>>> to do.
>>> Now the code used NVME_NS_STOPPED to avoid unpaired stop/start.
>>> If we use blk_mq_quiesce_tagset, It will cause the above mechanism to 
>>> fail.
>>> I review the code, only pci can not ensure secure stop/start pairing.
>>> So there is a choice, We only use blk_mq_quiesce_tagset on fabrics, 
>>> not PCI.
>>> Do you think that's acceptable?
>>> If that's acceptable, I will try to send a patch set.
>>
>> I don't think that this is acceptable. But I don't understand how
>> NVME_NS_STOPPED would change anything in the behavior of tagset-wide
>> quiesce?
> If use blk_mq_quiesce_tagset, it will quiesce all queues of all ns,
> but can not set NVME_NS_STOPPED of all ns. The mechanism of NVME_NS_STOPPED
> will be invalidated.
> NVMe-pci has very complicated quiesce/unquiesce use pattern, 
> quiesce/unquiesce
> may be called unpaired.
> It will cause some backward. There may be some bugs in this scenario:
> A thread: quiesce the queue
> B thread: quiesce the queue
> A thread end, and does not unquiesce the queue.
> B thread: unquiesce the queue, and do something which need the queue 
> must be unquiesed.
> 
> Of course, I don't think it is a good choice to guarantee paired access 
> through NVME_NS_STOPPED,
> there exist unexpected unquiesce and start queue too early.
> But now that the code has done so, the backward should be unacceptable.
> such as this scenario:
> A thread: quiesce the queue
> B thread: want to quiesce the queue but do nothing because 
> NVME_NS_STOPPED is already set.
> A thread: unquiesce the queue
> Now the queue is unquiesced too early for B thread.
> B thread: do something which need the queue must be quiesced.
> 
> Introduce NVME_NS_STOPPED link:
> https://lore.kernel.org/all/20211014081710.1871747-5-ming.lei@redhat.com/

I think we can just change a ns flag to a controller flag ala:
NVME_CTRL_STOPPED, and then do:

void nvme_stop_queues(struct nvme_ctrl *ctrl)
{
	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ns->flags))
		blk_mq_quiesce_tagset(ctrl->tagset);
}
EXPORT_SYMBOL_GPL(nvme_stop_queues);

void nvme_start_queues(struct nvme_ctrl *ctrl)
{
	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ns->flags))
		blk_mq_unquiesce_tagset(ctrl->tagset);
}
EXPORT_SYMBOL_GPL(nvme_start_queues);

Won't that achieve the same result?
