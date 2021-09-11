Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D61C433F5
	for <linux-block@archiver.kernel.org>; Sat, 11 Sep 2021 22:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2D760F6C
	for <linux-block@archiver.kernel.org>; Sat, 11 Sep 2021 22:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhIKWRx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Sep 2021 18:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhIKWRw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Sep 2021 18:17:52 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEF7C061574
        for <linux-block@vger.kernel.org>; Sat, 11 Sep 2021 15:16:39 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id v16so1197191ilg.3
        for <linux-block@vger.kernel.org>; Sat, 11 Sep 2021 15:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MEXTb3QcEM/ypIHuqN9qiQ/A1vfplVmsPUaky2RuJB8=;
        b=QIa2p+AHyVHLgiAlBIlCqtOGzsRzkwF9VKv5a8N2ciXr+C63nj1BYSrO6HYsoXeFM/
         q68D+RoXLHnHl+YkHPhgZKso0MjZtnwqaKzqNfY2xqZu6bpu/TUYBqPrJ2dabdP7GhWk
         1iTI3P2ao2ApOn0+rmVTgGBG66RcSSjJg8PjBsK0ys8jEVQgaDWnSG5iLc4NsYbJIqMr
         JlFdgTBB+ks96uuuJ22Kuep9HYMm94lxU+OVJo6EgFAkwneCr5h57CuyQmgteEKxTvm2
         6MZu23nXna6K2NALHHka8P/GgiQxF1m/dXA/L0/QD6Wpo9d+7M10wh8u6dZlfg4O85Zv
         9gQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MEXTb3QcEM/ypIHuqN9qiQ/A1vfplVmsPUaky2RuJB8=;
        b=nH3ImTG8PaWvJJjgG/XvpI9f7yrZ0VbdDPxiGAUmOrjKcXXvNM6Na17cghD3RCIVem
         LmTbbcoue2ATuEDZFyFzyLFCAdzyl+tJ9gJfT265bqETlQ+g43PtZCqQEmnwYDFSUZUK
         UXs37vakWrCm2aAWSurf8Yr9o1UaSoyG9dYanODYS7vPKgcETicgQGXLp5sGM3VEphUE
         Qbk7GqpLJQKNvxiPKIOnbOcMbhTzgPDCeY4Z0xnr6hNQDZrMsdec3D3x2jVUs2OMzexc
         wG7pWmAGTMp17HmMCT5lz3waAawpQDOR89dr1ik1zVM8soD5dVVOvdPdriDpS4WdLDI1
         XasQ==
X-Gm-Message-State: AOAM530EOeisoj5eM6FE+PVUD05D+2H94f6s2Or8q+hJ8Xk48oNbhEhI
        /SAnnZr9EE8x1CdpXgFk+NO/Wg==
X-Google-Smtp-Source: ABdhPJzkt6shVWeRRMNxFW6sKgAUrxVgwITuXUH9drxeKFbqr30RnFjF41y54HBsgcUmrv14I72B6A==
X-Received: by 2002:a92:c5c9:: with SMTP id s9mr2940206ilt.56.1631398599091;
        Sat, 11 Sep 2021 15:16:39 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id t14sm1604731ilu.67.2021.09.11.15.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 15:16:38 -0700 (PDT)
Subject: Re: [PATCH] block: Optimize bio_init()
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210911214734.4692-1-bvanassche@acm.org>
 <c61afcb0-dcee-8c02-d216-58f263093951@kernel.dk>
 <c810ce05-0893-d8c8-f288-0e018b0a08ca@kernel.dk>
Message-ID: <fe7f7cc7-2403-7ec6-7c1c-abb6ac6a68fa@kernel.dk>
Date:   Sat, 11 Sep 2021 16:16:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c810ce05-0893-d8c8-f288-0e018b0a08ca@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/11/21 4:09 PM, Jens Axboe wrote:
> On 9/11/21 4:01 PM, Jens Axboe wrote:
>> On 9/11/21 3:47 PM, Bart Van Assche wrote:
>>> The following test:
>>>
>>> sudo taskset -c 0 t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1 /dev/nullb0
>>>
>>> reports 1366 K IOPS on my test setup without this patch and 1380 K IOPS
>>> with this patch applied. In other words, this patch realizes a 1%
>>> performance improvement. I think this is because this patch makes the
>>> compiler generate better code. See also commit da521626ac62 ("bio:
>>> optimize initialization of a bio").
>>>
>>> The assembler code generated by gcc without this patch is as follows:
>>>
>>>    0x0000000000000000 <+0>:     call   0x5 <bio_init+5>
>>>    0x0000000000000005 <+5>:     xor    %eax,%eax
>>>    0x0000000000000007 <+7>:     xor    %ecx,%ecx
>>>    0x0000000000000009 <+9>:     movl   $0x1,0x1c(%rdi)
>>>    0x0000000000000010 <+16>:    movq   $0x0,(%rdi)
>>>    0x0000000000000017 <+23>:    movq   $0x0,0x8(%rdi)
>>>    0x000000000000001f <+31>:    movq   $0x0,0x10(%rdi)
>>>    0x0000000000000027 <+39>:    mov    %ax,0x18(%rdi)
>>>    0x000000000000002b <+43>:    movb   $0x0,0x1a(%rdi)
>>>    0x000000000000002f <+47>:    movq   $0x0,0x20(%rdi)
>>>    0x0000000000000037 <+55>:    movq   $0x0,0x28(%rdi)
>>>    0x000000000000003f <+63>:    movl   $0x0,0x30(%rdi)
>>>    0x0000000000000046 <+70>:    movq   $0x0,0x38(%rdi)
>>>    0x000000000000004e <+78>:    movq   $0x0,0x40(%rdi)
>>>    0x0000000000000056 <+86>:    movq   $0x0,0x48(%rdi)
>>>    0x000000000000005e <+94>:    movq   $0x0,0x50(%rdi)
>>>    0x0000000000000066 <+102>:   movq   $0x0,0x58(%rdi)
>>>    0x000000000000006e <+110>:   movq   $0x0,0x60(%rdi)
>>>    0x0000000000000076 <+118>:   mov    %cx,0x68(%rdi)
>>>    0x000000000000007a <+122>:   movl   $0x1,0x6c(%rdi)
>>>    0x0000000000000081 <+129>:   mov    %dx,0x6a(%rdi)
>>>    0x0000000000000085 <+133>:   mov    %rsi,0x70(%rdi)
>>>    0x0000000000000089 <+137>:   movq   $0x0,0x78(%rdi)
>>>    0x0000000000000091 <+145>:   ret
>>>
>>> With this patch bio_init() is compiled into the following assembly code:
>>>
>>>    0x0000000000000000 <+0>:     call   0x5 <bio_init+5>
>>>    0x0000000000000005 <+5>:     mov    %rdi,%r8
>>>    0x0000000000000008 <+8>:     mov    $0x10,%ecx
>>>    0x000000000000000d <+13>:    xor    %eax,%eax
>>>    0x000000000000000f <+15>:    rep stos %rax,%es:(%rdi)
>>>    0x0000000000000012 <+18>:    movl   $0x1,0x1c(%r8)
>>>    0x000000000000001a <+26>:    mov    %dx,0x6a(%r8)
>>>    0x000000000000001f <+31>:    movl   $0x1,0x6c(%r8)
>>>    0x0000000000000027 <+39>:    mov    %rsi,0x70(%r8)
>>>    0x000000000000002b <+43>:    ret
>>>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>> ---
>>>  block/bio.c | 45 ++++++++-------------------------------------
>>>  1 file changed, 8 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/block/bio.c b/block/bio.c
>>> index 5df3dd282e40..775cd4274523 100644
>>> --- a/block/bio.c
>>> +++ b/block/bio.c
>>> @@ -244,47 +244,18 @@ static void bio_free(struct bio *bio)
>>>  }
>>>  
>>>  /*
>>> - * Users of this function have their own bio allocation. Subsequently,
>>> - * they must remember to pair any call to bio_init() with bio_uninit()
>>> - * when IO has completed, or when the bio is released.
>>> + * Users of this function must pair any call to bio_init() with a call to
>>> + * bio_uninit() after IO has completed or when the bio is released.
>>>   */
>>>  void bio_init(struct bio *bio, struct bio_vec *table,
>>>  	      unsigned short max_vecs)
>>>  {
>>> -	bio->bi_next = NULL;
>>> -	bio->bi_bdev = NULL;
>>> -	bio->bi_opf = 0;
>>> -	bio->bi_flags = 0;
>>> -	bio->bi_ioprio = 0;
>>> -	bio->bi_write_hint = 0;
>>> -	bio->bi_status = 0;
>>> -	bio->bi_iter.bi_sector = 0;
>>> -	bio->bi_iter.bi_size = 0;
>>> -	bio->bi_iter.bi_idx = 0;
>>> -	bio->bi_iter.bi_bvec_done = 0;
>>> -	bio->bi_end_io = NULL;
>>> -	bio->bi_private = NULL;
>>> -#ifdef CONFIG_BLK_CGROUP
>>> -	bio->bi_blkg = NULL;
>>> -	bio->bi_issue.value = 0;
>>> -#ifdef CONFIG_BLK_CGROUP_IOCOST
>>> -	bio->bi_iocost_cost = 0;
>>> -#endif
>>> -#endif
>>> -#ifdef CONFIG_BLK_INLINE_ENCRYPTION
>>> -	bio->bi_crypt_context = NULL;
>>> -#endif
>>> -#ifdef CONFIG_BLK_DEV_INTEGRITY
>>> -	bio->bi_integrity = NULL;
>>> -#endif
>>> -	bio->bi_vcnt = 0;
>>> -
>>> -	atomic_set(&bio->__bi_remaining, 1);
>>> -	atomic_set(&bio->__bi_cnt, 1);
>>> -
>>> -	bio->bi_max_vecs = max_vecs;
>>> -	bio->bi_io_vec = table;
>>> -	bio->bi_pool = NULL;
>>> +	*bio = (struct bio) {
>>> +		.__bi_remaining	= ATOMIC_INIT(1),
>>> +		.__bi_cnt	= ATOMIC_INIT(1),
>>> +		.bi_max_vecs	= max_vecs,
>>> +		.bi_io_vec	= table,
>>> +	};
>>>  }
>>
>> I'll give this a whirl too, another upside is that it's less prone to
>> errors if struct bio is changed.
> 
> Seems slower for me, by about 1-1.5%, which is consumed by
> bio_alloc_kiocb() which is the only bio_init() caller in my test. Using
> gcc 11.1 here, and my code generation seems to match your case too
> (series of mov vs rep stos with the patch).
> 
> Probably a CPU thing. I'm running on an AMD 3970X for these tests.

Looking at profile:

 43.34 │      rep    stos %rax,%es:(%rdi)                                              
I do wonder if rep stos is just not very well suited for small regions,
either in general or particularly on AMD.

What do your profiles look like for before and after?

-- 
Jens Axboe

