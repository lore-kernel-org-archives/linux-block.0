Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15305C433F5
	for <linux-block@archiver.kernel.org>; Sun, 12 Sep 2021 13:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E39AF60555
	for <linux-block@archiver.kernel.org>; Sun, 12 Sep 2021 13:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhILNE5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Sep 2021 09:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbhILNE4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Sep 2021 09:04:56 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C3DC061574
        for <linux-block@vger.kernel.org>; Sun, 12 Sep 2021 06:03:42 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b10so8490844ioq.9
        for <linux-block@vger.kernel.org>; Sun, 12 Sep 2021 06:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mTko1vIetriD3H79ly0+Z/rb1uLtWwuSBbJWXVu8ryI=;
        b=t27mrpIBaDcq9YCg6MVV5Fju3n+vATJMnGnMNKig2dG+lit+zjUEsBXrIfPK7xT9Go
         TadoKPKhT0cD7QtoLnk3Xa82RtJTSkfNs2NUlV/EZc3BlvW5UtRtrOz6M6jdAgdrQf11
         zRK+tKgYO/Qnkv84ipD6KktlV1ALoY9i+NmAeNpFsbElJ9JebTmqmoPTosH86S6vlJQe
         ybR2kwSLOKLvrRrOUYvXxwHQWsHsh4tqZdJGbpdSDA5cGoNV4hLlJu56ZCy1L5EZzngv
         wOoTuoNYiSI8WaQtX3SLRMfMsEVHRha1j5WPB28N+vHsUhF9vB38/tOImXcO1nprMyfQ
         /+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mTko1vIetriD3H79ly0+Z/rb1uLtWwuSBbJWXVu8ryI=;
        b=RzjiCemrOJEZORGYSFqkFOXLl3coOzHYsCS6fqExRrFzYfPKq3nKSXC1nPgHEnk8js
         RnIWR+U/G+LpnNAN8e/A7iwGs1GtKy6kDSb8Kzi5nQOBZW+Qu5522E1TiP0wJdH6Tuui
         wRp2ylj0mkuiHJm/hhg2+1o0KQszDRvecgOHf+wLs10kYcQImeeLU96tAaR26kqz6fjm
         h5YPeeWCDpzek8V5qemCG2YLyJyugyQfXvfP/jUDUI7KbCUVTy4QcgbnMB82Ip7yQe+L
         UF7awF3tDdZC4O2b5/7qon6tQhIzHDnHh/LXFaZb8xX/dlHBQ7uFjjOQB7Qv4qJKKuqP
         7RlQ==
X-Gm-Message-State: AOAM532t9XA5fSySEH21hT4/2Sy7DMah3HLhcOWKMnOdwbtDIqi6ZlKg
        r8aCePeYwPvg9oLuagY/IuGcVg==
X-Google-Smtp-Source: ABdhPJye7SA/4+I0pssO/BWE+aGHJO3oxBAYcpyb/cyBVr742snIlq4UHMj3opoQ7JB04ZDdbZtX7w==
X-Received: by 2002:a05:6638:1347:: with SMTP id u7mr5481552jad.34.1631451821973;
        Sun, 12 Sep 2021 06:03:41 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b16sm2776209ila.1.2021.09.12.06.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 06:03:41 -0700 (PDT)
Subject: Re: [PATCH] block: Optimize bio_init()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210911214734.4692-1-bvanassche@acm.org>
 <c61afcb0-dcee-8c02-d216-58f263093951@kernel.dk>
 <c810ce05-0893-d8c8-f288-0e018b0a08ca@kernel.dk>
 <fe7f7cc7-2403-7ec6-7c1c-abb6ac6a68fa@kernel.dk>
 <c728eac8-3246-2a6d-84bd-a04fa62fbc04@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <200438e7-1a04-ae88-e79c-a4276b9dbb0f@kernel.dk>
Date:   Sun, 12 Sep 2021 07:03:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c728eac8-3246-2a6d-84bd-a04fa62fbc04@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/11/21 9:19 PM, Bart Van Assche wrote:
> On 9/11/21 15:16, Jens Axboe wrote:
>> Looking at profile:
>>
>>   43.34 │      rep    stos %rax,%es:(%rdi)
>> I do wonder if rep stos is just not very well suited for small regions,
>> either in general or particularly on AMD.
>>
>> What do your profiles look like for before and after?
> 
> Since I do not know which tool was used to obtain the above
> information, I ran perf record -ags sleep 10 while the test
> was running. I could not find bio_init in the output. I think
> that means that that function got inlined. But
> bio_alloc_bioset() showed up in the output. The time spent in
> that function is lower if IOPS are higher.

The above is from perf report, diving into the functions. Yours show up
in bio_alloc_bioset(), and mine in bio_alloc_kiocb() as I'm doing polled
IO.

> The performance numbers in the patch description come from a
> Intel Xeon Gold 6154 CPU. I reran the test today on an old Intel
> Core i7-4790 CPU and obtained the opposite result: higher IOPS
> without this patch than with this patch although the assembler
> code looks to be the same. It seems like how fast "rep stos"
> runs depends on the CPU type?

It does appear so. Which is a bit frustrating...

-- 
Jens Axboe

