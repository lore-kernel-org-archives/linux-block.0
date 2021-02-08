Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C653C433E9
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 18:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE9C64E73
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 18:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhBHSnb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Feb 2021 13:43:31 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:41912 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbhBHSnP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Feb 2021 13:43:15 -0500
Received: by mail-wr1-f53.google.com with SMTP id n6so5617281wrv.8
        for <linux-block@vger.kernel.org>; Mon, 08 Feb 2021 10:42:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WZI679MKug/C6d5XEdGiTwN53NorH7qi3N9ZPYlHr9Q=;
        b=i11b/BaoNvnoBE5BFCM0acREKM7QNbBQOdpELX6uycpIEIL/Y6lyqhNu+M7RLHx5Mi
         64vgA28+DDgcU8zCflH06PKaSl8sogYqa5l8zgXyCaUM4aJb5U9BZOaQEwQifLwXuGXH
         Kq72ecyUUJQy4e9n9U2id08+Q7CDvy/2Hvn3kf0ckBOagMOPzVoXPrGYk82KPP7yYbtU
         gVKMS0fjdRVrmNY4yZZS6h/P9PCcaiqhEirFX9R42U3Pm9kv+w531zLDpTr1EOUcNa9P
         nmNSVHxJLKvElnI856Jd8qdCmiILUBNPdWm7S9LZDk19nIvLkB19L8HLUp3OpmVKHgW8
         L+hw==
X-Gm-Message-State: AOAM533oYNLW07Ccwa94Ok0RY61irMPYulPX9n+iq3KO8EOfpOG2455o
        yFQxWyUUDw4Z3lBE9CcxiMI=
X-Google-Smtp-Source: ABdhPJy+0K0PHaSQALy1w2K+Q9cnATgNYdrv/M8TDx0MmmjSUBBYwLLXKRJCI1Y5EdVTRoQ6Z55O0g==
X-Received: by 2002:a05:6000:11c4:: with SMTP id i4mr7053597wrx.272.1612809753620;
        Mon, 08 Feb 2021 10:42:33 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:2121:4cf7:e6f6:2dc5? ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
        by smtp.gmail.com with ESMTPSA id t126sm158426wmf.3.2021.02.08.10.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 10:42:32 -0800 (PST)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block <linux-block@vger.kernel.org>
Cc:     axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        Chaitanya.Kulkarni@wdc.com
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <af1d7e9d-0170-82f6-30e1-01f045d73fc7@grimberg.me>
Message-ID: <6147d452-a12e-c76c-22f1-5d9e7cb6b01d@grimberg.me>
Date:   Mon, 8 Feb 2021 10:42:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <af1d7e9d-0170-82f6-30e1-01f045d73fc7@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> Hi Sagi
>>
>> On 2/8/21 5:46 PM, Sagi Grimberg wrote:
>>>
>>>> Hello
>>>>
>>>> We found this kernel NULL pointer issue with latest 
>>>> linux-block/for-next and it's 100% reproduced, let me know if you 
>>>> need more info/testing, thanks
>>>>
>>>> Kernel repo: 
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>>> Commit: 11f8b6fd0db9 - Merge branch 'for-5.12/io_uring' into for-next
>>>>
>>>> Reproducer: blktests nvme-tcp/012
>>>
>>> Thanks for reporting Ming, I've tried to reproduce this on my VM
>>> but did not succeed. Given that you have it 100% reproducible,
>>> can you try to revert commit:
>>>
>>> 0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter
>>>
>>
>> Revert this commit fixed the issue and I've attached the config. :)
> 
> Good to know,
> 
> I see some differences that I should probably change to hit this:
> -- 
> @@ -254,14 +256,15 @@ CONFIG_PERF_EVENTS=y
>   # end of Kernel Performance Events And Counters
> 
>   CONFIG_VM_EVENT_COUNTERS=y
> +CONFIG_SLUB_DEBUG=y
>   # CONFIG_COMPAT_BRK is not set
> -CONFIG_SLAB=y
> -# CONFIG_SLUB is not set
> -# CONFIG_SLOB is not set
> -CONFIG_SLAB_MERGE_DEFAULT=y
> -# CONFIG_SLAB_FREELIST_RANDOM is not set
> +# CONFIG_SLAB is not set
> +CONFIG_SLUB=y
> +# CONFIG_SLAB_MERGE_DEFAULT is not set
> +CONFIG_SLAB_FREELIST_RANDOM=y
>   # CONFIG_SLAB_FREELIST_HARDENED is not set
> -# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
> +CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
> +CONFIG_SLUB_CPU_PARTIAL=y
>   CONFIG_SYSTEM_DATA_VERIFICATION=y
>   CONFIG_PROFILING=y
>   CONFIG_TRACEPOINTS=y
> @@ -299,7 +302,8 @@ CONFIG_HAVE_INTEL_TXT=y
>   CONFIG_X86_64_SMP=y
>   CONFIG_ARCH_SUPPORTS_UPROBES=y
>   CONFIG_FIX_EARLYCON_MEM=y
> -CONFIG_PGTABLE_LEVELS=4
> +CONFIG_DYNAMIC_PHYSICAL_MASK=y
> +CONFIG_PGTABLE_LEVELS=5
>   CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> -- 
> 
> Probably CONFIG_SLUB and CONFIG_SLUB_DEBUG should be used.

Used your profile and this still does not happen :(
