Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8C4C433DB
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 07:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C620B64E9D
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 07:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhBIHWo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 02:22:44 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:42839 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhBIHWk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Feb 2021 02:22:40 -0500
Received: by mail-wr1-f41.google.com with SMTP id r21so4137690wrr.9
        for <linux-block@vger.kernel.org>; Mon, 08 Feb 2021 23:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MxYCw3hPtJF0vZIIkMvuq8Yo/9cZaVPDXKoBV4pVGk0=;
        b=pOhF+fhhQKIkjpra/g/d1MTdf/lEIAT3ovn0vresIRakwsG9RdM89nXX3y1TQC2nI6
         IsWv7aL3v5ovXaFnnmYM4JY4SfFEyDyJ+OPt7i8FeenJH3WBKLOrVwr0+/JnZX5BiE/d
         cpaiTOf8nuoGXoS81eOm3Gq2FlCuSy68YlpAHr2gPhcvq6ntz/emH0enS7m1xYo3XGMo
         bKfsfHzm1AB9DAkYmbSjql9Kaq54+pjpIaFw1XcltG4rbiXKaJcyrYDB1AJnrvixGZVo
         2YEZUdukG+R/M3YVnxq22getijZfH4CsJLAGr4kTGCHogLUcO/MCyIaXIiWhdYUEcgvY
         bbXw==
X-Gm-Message-State: AOAM531ibLZ+I7ZEQ+GkzQMs/T+SiKXxuN5Oa+MzjE+uE1H63PobaSTm
        ZeffUodwVNIVtoCw1JXTnfgcge9b+Dw=
X-Google-Smtp-Source: ABdhPJzAp7FNFhLHypi4B5g/sGKp+khwawWBZL0q9njGM3FcTE936kUXB97BQRkd48eTvs9Kl3NaKg==
X-Received: by 2002:adf:80c3:: with SMTP id 61mr24181761wrl.100.1612855317448;
        Mon, 08 Feb 2021 23:21:57 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:2121:4cf7:e6f6:2dc5? ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
        by smtp.gmail.com with ESMTPSA id t2sm20696338wru.53.2021.02.08.23.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 23:21:56 -0800 (PST)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block <linux-block@vger.kernel.org>, axboe@kernel.dk,
        Rachel Sibley <rasibley@redhat.com>,
        Chaitanya.Kulkarni@wdc.com, CKI Project <cki-project@redhat.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <af1d7e9d-0170-82f6-30e1-01f045d73fc7@grimberg.me>
 <6147d452-a12e-c76c-22f1-5d9e7cb6b01d@grimberg.me>
 <20210209042103.GB63798@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1ea82025-44b8-ac3a-2039-35cb8d36dac2@grimberg.me>
Date:   Mon, 8 Feb 2021 23:21:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210209042103.GB63798@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2/8/21 8:21 PM, Ming Lei wrote:
> On Mon, Feb 08, 2021 at 10:42:28AM -0800, Sagi Grimberg wrote:
>>
>>>> Hi Sagi
>>>>
>>>> On 2/8/21 5:46 PM, Sagi Grimberg wrote:
>>>>>
>>>>>> Hello
>>>>>>
>>>>>> We found this kernel NULL pointer issue with latest
>>>>>> linux-block/for-next and it's 100% reproduced, let me know
>>>>>> if you need more info/testing, thanks
>>>>>>
>>>>>> Kernel repo:
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>>>>> Commit: 11f8b6fd0db9 - Merge branch 'for-5.12/io_uring' into for-next
>>>>>>
>>>>>> Reproducer: blktests nvme-tcp/012
>>>>>
>>>>> Thanks for reporting Ming, I've tried to reproduce this on my VM
>>>>> but did not succeed. Given that you have it 100% reproducible,
>>>>> can you try to revert commit:
>>>>>
>>>>> 0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter
>>>>>
>>>>
>>>> Revert this commit fixed the issue and I've attached the config. :)
>>>
>>> Good to know,
>>>
>>> I see some differences that I should probably change to hit this:
>>> -- 
>>> @@ -254,14 +256,15 @@ CONFIG_PERF_EVENTS=y
>>>    # end of Kernel Performance Events And Counters
>>>
>>>    CONFIG_VM_EVENT_COUNTERS=y
>>> +CONFIG_SLUB_DEBUG=y
>>>    # CONFIG_COMPAT_BRK is not set
>>> -CONFIG_SLAB=y
>>> -# CONFIG_SLUB is not set
>>> -# CONFIG_SLOB is not set
>>> -CONFIG_SLAB_MERGE_DEFAULT=y
>>> -# CONFIG_SLAB_FREELIST_RANDOM is not set
>>> +# CONFIG_SLAB is not set
>>> +CONFIG_SLUB=y
>>> +# CONFIG_SLAB_MERGE_DEFAULT is not set
>>> +CONFIG_SLAB_FREELIST_RANDOM=y
>>>    # CONFIG_SLAB_FREELIST_HARDENED is not set
>>> -# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
>>> +CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
>>> +CONFIG_SLUB_CPU_PARTIAL=y
>>>    CONFIG_SYSTEM_DATA_VERIFICATION=y
>>>    CONFIG_PROFILING=y
>>>    CONFIG_TRACEPOINTS=y
>>> @@ -299,7 +302,8 @@ CONFIG_HAVE_INTEL_TXT=y
>>>    CONFIG_X86_64_SMP=y
>>>    CONFIG_ARCH_SUPPORTS_UPROBES=y
>>>    CONFIG_FIX_EARLYCON_MEM=y
>>> -CONFIG_PGTABLE_LEVELS=4
>>> +CONFIG_DYNAMIC_PHYSICAL_MASK=y
>>> +CONFIG_PGTABLE_LEVELS=5
>>>    CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
>>> -- 
>>>
>>> Probably CONFIG_SLUB and CONFIG_SLUB_DEBUG should be used.
>>
>> Used your profile and this still does not happen :(
> 
> One obvious error is that nr_segments is computed wrong.
> 
> Yi, can you try the following patch?
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 881d28eb15e9..a393d99b74e1 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -239,9 +239,14 @@ static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
>   		offset = 0;
>   	} else {
>   		struct bio *bio = req->curr_bio;
> +		struct bio_vec bv;
> +		struct bvec_iter iter;
> +
> +		nsegs = 0;
> +		bio_for_each_bvec(bv, bio, iter)
> +			nsegs++;
>   
>   		vec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
> -		nsegs = bio_segments(bio);

This was exactly the patch that caused the issue.
