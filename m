Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAA4C77B7F
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 15:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241995AbjELPni (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 11:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241990AbjELPnf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 11:43:35 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C9665A4
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:43:34 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3357ea1681fso2002275ab.1
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683906214; x=1686498214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Ak8ROaJ4rD42fUldM6Zk4zYheQ4QoVvDZ/co/RPjZg=;
        b=CR5XiIDQmuiOZJfSZ1oFi+2Ll3xAyPb/TbLZ7G2IJyg3ekQL+5mQRLMP2PdurWb9qd
         AiX0hPizr3Km8y1QQXIYiiFJ5yvJRKG5JA1Sw0qoFDIgzHzBqRHtEEf/hudp18QCnJ+3
         wYVbTtEwgk0YWZXrbZydovrTTMIAFbN6ENQvrDpFpXKmy+MkFaMSxFCTXsBCJOnaGwUQ
         kAVbEXflKoGkkiEWHedej2r8w3AHZlcUJM5fx39fbowY2UEx5WT0suobxRYb2Shn3SkT
         JtefIRU/fSJBMkJBGQocRNyGCW5NVK1php2QcOLw0O7JPBKo34pLjNT8hhWZ4KAPG39q
         JvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683906214; x=1686498214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ak8ROaJ4rD42fUldM6Zk4zYheQ4QoVvDZ/co/RPjZg=;
        b=cFJvstmiGjismwCEbyUwbS3fkirbjuU8SLlY20WDc0MKe1yDZ2daIU+K1gbxgft/2M
         oWX3sRX6LRmvkemj1TTWpsEFnqcoUWgUOmKy5tYulTN7v4yfFt4uCmhG3OUvQRhF0To6
         8J9uEQFFxYTBYVzwe5wurUngMHqc6bSPOH6xJdkRmDvB4hrXMz/9oMlzAEPWQe3dV6G7
         919WVcFq4sUah89Ne+zEo7UbOk27a8ddXbV9Zc7RwUztfOqEooOZZ8njq+4xEDyKNyv2
         4ikcfGMNwljP8el/HUfQbZN/HeB4FJTMfZ8CLxRWYIhu0Byq2hxYd/cm3viSxwVvRTRj
         PfWA==
X-Gm-Message-State: AC+VfDyNwciScZw13TkZ8/bAWBJdlhscbhL2IKA/nzgtFx7o233RAU5+
        qQtDSvFXuCGe/aBCUAyYWFfsZA==
X-Google-Smtp-Source: ACHHUZ45Zk1y40dmVNxhyrs5M1NuwCfK5jWOJYAGrf/WtIrqchC8nxF28HQ33Vd2IBhCOddGlV9j2A==
X-Received: by 2002:a6b:b4ce:0:b0:76c:6fa4:4df4 with SMTP id d197-20020a6bb4ce000000b0076c6fa44df4mr4478322iof.2.1683906213850;
        Fri, 12 May 2023 08:43:33 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l19-20020a02a893000000b0040fae3b49e5sm4961377jam.124.2023.05.12.08.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 08:43:33 -0700 (PDT)
Message-ID: <ca934bc6-651a-6c96-0598-105cd4a0b500@kernel.dk>
Date:   Fri, 12 May 2023 09:43:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] blk-mq: don't queue passthrough request into scheduler
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
References: <20230512150328.192908-1-ming.lei@redhat.com>
 <70478f95-2852-9bf1-f8f7-630c74641c0f@kernel.dk>
 <ZF5ZB7QWPCF0ZKWN@ovpn-8-16.pek2.redhat.com>
 <b745f17b-088c-a72c-00f2-3c0a13cdead5@kernel.dk>
 <ZF5co5g2XLIw82DK@ovpn-8-16.pek2.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZF5co5g2XLIw82DK@ovpn-8-16.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/23 9:34?AM, Ming Lei wrote:
> On Fri, May 12, 2023 at 09:25:18AM -0600, Jens Axboe wrote:
>> On 5/12/23 9:19?AM, Ming Lei wrote:
>>> On Fri, May 12, 2023 at 09:08:54AM -0600, Jens Axboe wrote:
>>>> On 5/12/23 9:03?AM, Ming Lei wrote:
>>>>> Passthrough(pt) request shouldn't be queued to scheduler, especially some
>>>>> schedulers(such as bfq) supposes that req->bio is always available and
>>>>> blk-cgroup can be retrieved via bio.
>>>>>
>>>>> Sometimes pt request could be part of error handling, so it is better to always
>>>>> queue it into hctx->dispatch directly.
>>>>>
>>>>> Fix this issue by queuing pt request from plug list to hctx->dispatch
>>>>> directly.
>>>>
>>>> Why not just add the check to the BFQ insertion? That would be a lot
>>>> more trivial and would not be poluting the core with this stuff.
>>>
>>> pt request is supposed to be issued to device directly, and we never
>>> queue it to scheduler before 1c2d2fff6dc0 ("block: wire-up support for
>>> passthrough plugging").
>>>
>>> some pt request might be part of error handling, and adding it to
>>> scheduler could cause io hang.
>>
>> I'm not suggesting adding it to the scheduler, just having the bypass
>> "add to dispatch" in a different spot.
> 
> Originally it is added to dispatch in blk_execute_rq_nowait() for each
> request, but now we support plug for pt request, that is why I add the
> bypass in blk_mq_dispatch_plug_list(), and just grab lock for each batch
> given now blk_execute_rq_nowait() is fast path for nvme uring pt io feature.

We really have two types of passthrough - normal kind of IO, and
potential error recovery etc IO. The former can plug just fine, and I
don't think we should treat it differently. Might make more sense to
just bypass plugging for error handling type of IO, or pt that doesn't
transfer any data to avoid having a NULL bio inserted into the
scheduler.

>> Let me take a look at it... Do we have a reproducer for this issue?
> 
> Guang Wu and Yu Kuai should have, and I didn't succeed in reproducing
> it by setting bfq & io.bfq.weight cgroup in my test VM.

I didn't either, but most likely because all the pt testing I did was
mapped IO. So there would be a bio there.

-- 
Jens Axboe

