Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A69C4320E
	for <linux-block@archiver.kernel.org>; Thu,  2 Sep 2021 02:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76804610C8
	for <linux-block@archiver.kernel.org>; Thu,  2 Sep 2021 02:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhIBCJZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Sep 2021 22:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbhIBCJY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Sep 2021 22:09:24 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265BAC061575
        for <linux-block@vger.kernel.org>; Wed,  1 Sep 2021 19:08:27 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id i13so249553ilm.4
        for <linux-block@vger.kernel.org>; Wed, 01 Sep 2021 19:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=67D3KFtL0xMui+A/kjdkz8LXwB5XZmZTGPRjpur3LVU=;
        b=v5OMY5Di8q6dr//elP11vfZ6GmWP3T30zrW2qz0Ty3RMot6IBcspjLvuXv7Z29f5/x
         yioV6XJIBNcgrRcOM435dfNRZCMCv1IWVIZOxhyEC/cxU93sNKrrWgqURkw8npAIfES4
         XfLACt3AyLlTPwiho3QIFQv3mHc63YRf1WOfXlVFNvZvUE56IsCiYa4CmWQKyhGrWisS
         vvuym1emqBJ2DMAgw3tl9tnPgV56F/Oyeg444TkSRcdqKbt6jwxOYEA0Nh/Y/bW2rLtB
         dxB/nAMCOQcBfCgZKlIQkkSKFUhqcT3QSHT/Dlux5puMvilxWk8l2HTsVyZu2qGtpECE
         g/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=67D3KFtL0xMui+A/kjdkz8LXwB5XZmZTGPRjpur3LVU=;
        b=NrUq+X8Il+QVwFjQmYMtUH/ZlLDhSqnasU70pI640W57PIzET/u7QdvYc35KsT5pe1
         2oNttUfwqDl3ly01DELWgvMVhgjPdDWcYJ9cMdDBapWNRxBiUScgWR5sSVPx16VBff73
         yoC7KCDfmKcA8tf8MhWpLPiegWKOIDY2EUFV3XVdNYtAANkeKtIwpkEpu60tmmLep6IK
         AWSDgucFCKUGLJY3hlP9lUCj4WnKDurdyMqvW0R51yhBbAY+xfPcFUj+6Py+EENaCwfA
         KiPVuxS7WESIgwN119S4N8Nh74wUpfcymJifdnNe0YN5oWOp1P/NnWaILvem9rxTJ5WO
         gibA==
X-Gm-Message-State: AOAM531mZ9Izk1zxFCaFhA57jkzXZnZsJG/uJDU1vMsS2ADkbnSylXck
        7mQLl8k5CDZxvY/Lbeueoy4Fx/JSW858GA==
X-Google-Smtp-Source: ABdhPJzlxwEGPqEuZ1RcxXpFVMvzzK/QjhOk0j8PJWD5JGV+Re5I+CRWjcLo8E/44W+kCf7l0COF2w==
X-Received: by 2002:a05:6e02:154a:: with SMTP id j10mr561342ilu.79.1630548505543;
        Wed, 01 Sep 2021 19:08:25 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id k5sm218334iob.45.2021.09.01.19.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 19:08:25 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] virtio-blk: avoid preallocating big SGL for data
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     hch@infradead.org, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, stefanha@redhat.com, israelr@nvidia.com,
        nitzanc@nvidia.com, oren@nvidia.com, linux-block@vger.kernel.org
References: <20210901131434.31158-1-mgurtovoy@nvidia.com>
 <20210901102623-mutt-send-email-mst@kernel.org>
 <89d6dc30-a876-b1b0-4ff4-605415113611@nvidia.com>
 <6a648daf-dd93-0c16-58d6-e4a59334bf0b@kernel.dk>
 <3ee9405e-733f-30f5-aee2-26b74fbc9cfc@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aea59bb1-23c2-fed0-f032-07444d319b00@kernel.dk>
Date:   Wed, 1 Sep 2021 20:08:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3ee9405e-733f-30f5-aee2-26b74fbc9cfc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/1/21 4:25 PM, Max Gurtovoy wrote:
> 
> On 9/1/2021 6:27 PM, Jens Axboe wrote:
>> On 9/1/21 8:58 AM, Max Gurtovoy wrote:
>>> On 9/1/2021 5:50 PM, Michael S. Tsirkin wrote:
>>>> On Wed, Sep 01, 2021 at 04:14:34PM +0300, Max Gurtovoy wrote:
>>>>> No need to pre-allocate a big buffer for the IO SGL anymore. If a device
>>>>> has lots of deep queues, preallocation for the sg list can consume
>>>>> substantial amounts of memory. For HW virtio-blk device, nr_hw_queues
>>>>> can be 64 or 128 and each queue's depth might be 128. This means the
>>>>> resulting preallocation for the data SGLs is big.
>>>>>
>>>>> Switch to runtime allocation for SGL for lists longer than 2 entries.
>>>>> This is the approach used by NVMe drivers so it should be reasonable for
>>>>> virtio block as well. Runtime SGL allocation has always been the case
>>>>> for the legacy I/O path so this is nothing new.
>>>>>
>>>>> The preallocated small SGL depends on SG_CHAIN so if the ARCH doesn't
>>>>> support SG_CHAIN, use only runtime allocation for the SGL.
>>>>>
>>>>> Re-organize the setup of the IO request to fit the new sg chain
>>>>> mechanism.
>>>>>
>>>>> No performance degradation was seen (fio libaio engine with 16 jobs and
>>>>> 128 iodepth):
>>>>>
>>>>> IO size      IOPs Rand Read (before/after)         IOPs Rand Write (before/after)
>>>>> --------     ---------------------------------    ----------------------------------
>>>>> 512B          318K/316K                                    329K/325K
>>>>>
>>>>> 4KB           323K/321K                                    353K/349K
>>>>>
>>>>> 16KB          199K/208K                                    250K/275K
>>>>>
>>>>> 128KB         36K/36.1K                                    39.2K/41.7K
>>>>>
>>>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>>> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
>>>> Could you use something to give confidence intervals maybe?
>>>> As it is it looks like a 1-2% regression for 512B and 4KB.
>>> 1%-2% is not a regression. It's a device/env/test variance.
>>>
>>> This is just one test results. I run it many times and got difference by
>>> +/- 2%-3% in each run for each sides.
>>>
>>> Even if I run same driver without changes I get 2%-3% difference between
>>> runs.
>>>
>>> If you have a perf test suite for virtio-blk it will be great if you can
>>> run it, or maybe Feng Li has.
>> You're adding an allocation to the hot path, and a free to the
>> completion hot path. It's not unreasonable to expect that there could be
>> performance implications associated with that. Which would be
>> particularly evident with 1 segment requests, as the results would seem
>> to indicate as well.
> 
> but for sg_nents <= 2 there is no dynamic allocation also in this patch 
> exactly as we do in nvmf RDMA and FC for example.

My quick read missed that, which is why you're using chaining. Then it
looks very reasonable to me.

>> Probably needs better testing. A profile of a peak run before and after
>> and a diff of the two might also be interesting.
> 
> I'll run ezfio test suite with stronger virtio-blk device that reach > 
> 800KIOPs

That'd be better, and preferably a test with pinning etc so that you can
show more consistent results. Just reading your table does indeed look
like there's a performance degradation, even if you preface it by saying
there is none. It would need better explaining, but preferably better
testing.

>> The common idiom for situations like this is to have an inline part that
>> holds 1-2 segments, and then only punt to alloc if you need more than
>> that. As the number of segments grows, the cost per request matters
>> less.
> 
> isn't this the case here ? or am I missing something ?

it totally is, I was the one missing that.

-- 
Jens Axboe

