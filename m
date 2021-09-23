Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47482C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 17:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E1B56109E
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 17:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241698AbhIWR5F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241751AbhIWR5F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 13:57:05 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6874C061574
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 10:55:33 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id m11so9190622ioo.6
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 10:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bACruWd/c6X0qkahV771F28YQbqAMXsLOtuoi95gpTg=;
        b=ZGzcNIIy1ThkOCxGBEffVMJMiZsyiIM4XSw/kz/jl089tXMo5cKKrX3fNk6DLtYhrl
         KBeESh8d4HxOcYl/LSNfnXu07otlIXyQVvmKzRTHxIWFM6DKpcmVnRKTVAJThmwRfqo1
         ydps0UULGf7M1P0uNoyN98aJU0YsKRT0vIa4WExQCljUs3aDpKfEk6/mBwnkycF3i5oq
         7jH7LzQlBrWkjUeO8V0DlZ4u+0bmZK0VSGj9lAzortD5E6USE+sfgng/Hru0lI4fG2t2
         j3k9uM+Vkwn3vXJn+YkoSHAff5UMDGn6++zkS0U3NUoeSAh6C4FGKweh5y7EHKZAaL4R
         ni3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bACruWd/c6X0qkahV771F28YQbqAMXsLOtuoi95gpTg=;
        b=u7MlIQ1Uo5FhHZLVZdfPgtOexlzsttTVsC2vNbysqGU1pfvq04Y5B5+9UA7Cb1TAPa
         qRNwugdEafdRSuUHtNGwigFKIZfSPTXxozebBw6z1UeVXw0V9E5SDgAowqV5iUdc0YXo
         5azZD4wGfUTblBBiftZkER6XNn0t0+vyEEAX6qFg/RNg4Be1MfYXnYkZo5fjT96uFp8l
         K/g/zGDOLIQoPIqmjH467UuivahumYMSfo3XbxHuSmriDrYEPqk0qKaBmeoTVwjQylni
         ZCntFaGxbxEpBZK/YBgmB2WgOcUJwcZ06V2TmAgJ7HyVsynGWMpQnT5UBlG7g+VkLt8m
         5J/A==
X-Gm-Message-State: AOAM532xGXaw/VCls/wpSPtMnDTT4LTGjrsUHOu+ynXUACaB2XUig3Vi
        hCKRI5K8auFnM6Kn/Kw3Gw+4ug==
X-Google-Smtp-Source: ABdhPJx/x1C6dO/+KrN+fZ18A5Umo7KOdkmf4Utq3pmcWU0O0935R85fm/i7HcWYayy1IFEf9HWwSg==
X-Received: by 2002:a02:ac96:: with SMTP id x22mr5269079jan.18.1632419732943;
        Thu, 23 Sep 2021 10:55:32 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i14sm2664436iog.47.2021.09.23.10.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 10:55:32 -0700 (PDT)
Subject: Re: [PATCH] null_blk: Fix a NULL pointer dereference
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20210922175055.568763-1-bvanassche@acm.org>
 <d8c3e376-145e-f29a-3cf2-210fae4c8884@kernel.dk>
 <fdf80121-35aa-0295-8614-54247fd12686@acm.org>
 <ae742deb-df52-9c65-8cb1-3f66dc0bde53@acm.org>
 <4c26ddaf-1b25-7a53-6e6b-09b59ada1a99@kernel.dk>
 <941cc786-fea9-4f35-dc19-8b84461285e9@acm.org>
 <86906e1f-83dd-503f-1369-158966a2ac20@kernel.dk>
 <83d45e6b-6bd5-8e59-d0bf-6d86b18a81f4@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fc3299cf-1603-fcd9-6287-1424586cb479@kernel.dk>
Date:   Thu, 23 Sep 2021 11:55:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <83d45e6b-6bd5-8e59-d0bf-6d86b18a81f4@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/23/21 11:51 AM, Bart Van Assche wrote:
> On 9/23/21 9:39 AM, Jens Axboe wrote:
>> On 9/23/21 10:22 AM, Bart Van Assche wrote:
>>> On 9/23/21 9:04 AM, Jens Axboe wrote:
>>>> What options are you loading null_blk with?
>>>
>>> The issues I reported are the result of running test blk/010 from the
>>> blktests suite. That test loads the null_blk kernel module twice:
>>>
>>> _init_null_blk queue_mode=2 submit_queues=16 nr_devices=32
>>> [ ... ]
>>> _exit_null_blk
>>> _init_null_blk queue_mode=2 submit_queues=16 nr_devices=32 shared_tags=1
>>> [ ... ]
>>> _exit_null_blk
>>>
>>> Please let me know if you need more information.
>>
>> Tried both that and running block/010, didn't trigger anything for me.
>> Odd...
> 
> Hi Jens,
> 
> I took another look at the kernel logs from yesterday of the VM that I use
> for testing. In that kernel log I found the following:
> * Without any changes on top of the for-next branch of
>    git://git.kernel.dk/linux-block (commit 4129031563d0 ("Merge branch
>    'for-5.16/io_uring' into for-next"), test block/010 triggers the oops
>    reported at the start of this email thread.
> * With the patch at the start of this email thread applied, the first test
>    that triggers a kernel oops is block/020 (blk_mq_free_rqs+0x1f4).
> 
> This morning I rebuilt the block for-next kernel with and without my
> null_blk patch applied. I was able to reproduce what I observed yesterday.
> Test block/020 passes with if commit 5f7acddf706c ("null_blk: poll queue
> support") is reverted. This is why I wrote that my patch does not seem to
> be sufficient to fix commit 5f7acddf706c.

Ah ok, so it's block/020, not block/010 for the later one. I'll take a
look.

-- 
Jens Axboe

