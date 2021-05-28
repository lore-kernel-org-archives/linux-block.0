Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E367C47089
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 02:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 662D7613BA
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 02:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhE1CG6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 22:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbhE1CG6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 22:06:58 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0817C061574
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 19:05:23 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id m190so1402902pga.2
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 19:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c4P8jUhjzur8Pcu4fuZsY+eakDhXCeaikQHd5qa+IYM=;
        b=MmiSgKCymuvvHV08FHQHs21Pa3fCD44I/unU5da6nTO7JC0zW+OtktFMrZxr+yMifR
         Z7hNInl2U4KKab0Nnlx1DK0/Eb0nDD6jv3XrsjEnEbx5EaRdiqkpR0ND+Y6wRdTNFJ+3
         3ZSRW1eN5PQfiikk6/RslrErDLn4jduCyBACnSI61HyqqdQ3AMSp8iyI/1hYKG/BHl3e
         fmhAcb5jgjIqEiqRFHm8FGQaqntkMiuFjsE/NWxbxtWPJm677B5+7UTkEuUwE/deFaaj
         sfWjMrhrq2UwVDK1VzNIys5viOlIwgz/ZEMqadRC0xMJSleykaEAURiJ8eMirbbUFbjj
         vVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c4P8jUhjzur8Pcu4fuZsY+eakDhXCeaikQHd5qa+IYM=;
        b=KwK9ujfg9aWGTLBz0v68zP6cCP4P1v+CnshIDueFV0i3KbEh8jLIKkOc5fW8sbDBjM
         1vrsucv2JgTXvS4N7soPMv+QM9OOsjmMRues49PlQFSKzGzb/a2JDnmPr+4p+8Eho+8E
         3ay/IUI5s7GK1VxjUXmH8RfLOqePHEi4ZzlsllJ2cqAeYGhvm6UJUL9qeLfVimbuoAnz
         LS/X+R+ohoBmThofzFZA9bLsXqAt6ia0PJtjMbHdE0RnzCgOQbHc9mINZ14EVRkKRIz/
         ZjI3P+0bWibO4MLiTtroE4+iEtpDUVtf9ZPPQmCP+P5sjQ5ym80OMX2of+UuKfkoYnup
         sNbA==
X-Gm-Message-State: AOAM530xCs1fpt4ToRp/e1NnEHuXpESBLc9A3nU5JP2Ie2voOTJAeLKj
        bcuOMasSChY/1iaK8gLqRQU=
X-Google-Smtp-Source: ABdhPJx4jnOsxAgdYEV5t0NK+3uCyc4nrUOWGx3LBSkgyxAAt15rZJoq4l+CmZTZBdcy5IlR4kfADQ==
X-Received: by 2002:a05:6a00:1509:b029:2de:6765:276b with SMTP id q9-20020a056a001509b02902de6765276bmr1423491pfu.67.1622167522966;
        Thu, 27 May 2021 19:05:22 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([2402:5ec0:1fff:ffff:6f68:d793:b2e3:9de6])
        by smtp.gmail.com with ESMTPSA id n30sm2913594pgd.8.2021.05.27.19.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 19:05:22 -0700 (PDT)
Subject: Re: [PATCH 0/9] Improve I/O priority support
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <b58840a8-0122-26cd-e756-92562064075a@gmail.com>
 <ef81558a-cab2-ca2f-dba8-e032ecdb8154@gmail.com>
 <22c245e9-469c-0a0f-ad31-455a33f1e073@acm.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Message-ID: <b3878299-ae9b-d03a-eaa8-b1890afcbfe2@gmail.com>
Date:   Fri, 28 May 2021 10:05:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <22c245e9-469c-0a0f-ad31-455a33f1e073@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/5/28 2:40 AM, Bart Van Assche wrote:
> On 5/27/21 1:05 AM, Wang Jianchao wrote:
>> On 2021/5/27 2:25 PM, Wang Jianchao wrote:
>>> On 2021/5/27 9:01 AM, Bart Van Assche wrote:
>>>> A feature that is missing from the Linux kernel for storage devices that
>>>> support I/O priorities is to set the I/O priority in requests involving page
>>>> cache writeback. Since the identity of the process that triggers page cache
>>>> writeback is not known in the writeback code, the priority set by ioprio_set()
>>>> is ignored. However, an I/O cgroup is associated with writeback requests
>>>> by certain filesystems. Hence this patch series that implements the following
>>>> changes for the mq-deadline scheduler:
>>>
>>> How about implement this feature based on the rq-qos framework ?
>>> Maybe it is better to make mq-deadline a pure io-scheduler.
>>
>> In addition, it is more flexible to combine different io-scheduler and rq-qos policy
>> if we take io priority as a new policy ;)
> 
> Hi Jianchao,
> 
> That's an interesting question. I'm in favor of flexibility. However,
> I'm not sure whether it would be possible to combine an rq-qos policy
> that submits high priority requests first with an I/O scheduler that
> ignores I/O priorities. Since a typical I/O scheduler reorders requests,
> such a combination would lead to requests being submitted in the wrong
> order to storage devices. In other words, when using an I/O scheduler,> proper support for I/O priority in the I/O scheduler is essential. The

Hi Bart,

Does it really matter that issue IO request by the order of io priority ?

Given a device with a 32 depth queue and doesn't support io priority, even if
we issue the request by the order of io priority, will the fw of device handle
them by the same order ? Or in the other word, we always issue 32 io requests
to device one time and then the fw of device decides how to handle them.
The order of dispatching request from queue may only work when the device's
queue is full and we have a deeper queue in io scheduler. And at this moment,
maybe the user needs to check why their application saturates the block device.

As for the qos policy of io priority, it seems similar with wbt in which read,
sync write and background write have different priority. Since we always want
the io with higher priority to be served more by the device, adapting the depth
of queue of different io priority may work ;)

Best regards
Jianchao

> BFQ I/O scheduler is still maturing. The purpose of the Kyber I/O
> scheduler is to control latency by reducing the queue depth without
> differentiating between requests of the same type. The mq-deadline
> scheduler is already being used in combination with storage devices that
> support I/O priorities in their controller. Hence the choice for the
> mq-deadline scheduler.
> 
> Thanks,
> 
> Bart.
> 
