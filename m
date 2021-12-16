Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0B4C433F5
	for <linux-block@archiver.kernel.org>; Thu, 16 Dec 2021 15:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbhLPPla (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Dec 2021 10:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238592AbhLPPl3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Dec 2021 10:41:29 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5DAC06173E
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 07:41:29 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id y16so35725068ioc.8
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 07:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MP+T3S95w7/Wr3GB0++QH4Oo4hV/4bl0WcXKRoTLGQ0=;
        b=evOjiqfRtE8boAoAd9ey6rKsowHC91NdzVLe8IIOQ4b1W0oxAcbWN3qES/e+bG37eA
         /7MKrSEsOKK4Al6LohurfbKIb9PibRrx8erXp7J2zuW7REqCqup9f/AHDovHpy/Pj/JH
         QfxEefXcv/c+EZ/kJZjaUVq4BuMIta3R+f90Xq0/rAgAFsV87UTxjDdJJ+bU/exZbtVB
         NC9JKYMftiJoN4nqAYENi14C+DXAU3Gfq+1MSH5B9RL8DKDtKdcUQX5ZtZBvXJdYCNtv
         F3GdDGq7kPcv575Net9cOdZBH1FU5RhLteC33ibOwpzaH/ASwr+OhcoTiOrkW7Q9ltm7
         uLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MP+T3S95w7/Wr3GB0++QH4Oo4hV/4bl0WcXKRoTLGQ0=;
        b=iiJQMA3tHeBD3NtSwHWa+5iPC/OKdy4YlsatiDu99yYq1H3hj+Ao9p/MTm3V2wL1D3
         1px4jHzZchGjzswxkg0qIp92eno3QtV912hlZrVwpCdoGro+Evqu3iY7Cu5YeoNrKoaq
         NdjtztEekFWTFmMLB7OhF/mQCpsGGuUnnSg8PK82fW8NnUajTdhTwQ0qgtNeap2tz57G
         0DDOJu5RoN/k5gMkiJqcPmzS9t6MtCYy28RUTrEwqNdywStBb6nQXHBunoXFp88RT9Xn
         9VadXIZFmmWY/IpAz9z6krH9oLOJVbXnkzXly2cESs4PxXKse50W3oEmarmRVcWv4Vqm
         1yZQ==
X-Gm-Message-State: AOAM532TI5nm5WzGJ8CX1BWbhAUlw/ODf6BaT/1hYaDBhVAUZTFWpZfu
        Dt4Ej3UMZl70Z5n3YKD4VwXpifCAk/aoqA==
X-Google-Smtp-Source: ABdhPJzdm4qSTLH4VkMPxlI2m6ERABTsKKJ4m7mPGBKBPzteAcbMkw4q+kYTqt0WuqpL8lTMFOmCCQ==
X-Received: by 2002:a05:6638:24c3:: with SMTP id y3mr9504683jat.305.1639669288784;
        Thu, 16 Dec 2021 07:41:28 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z17sm2788790ior.22.2021.12.16.07.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 07:41:28 -0800 (PST)
Subject: Re: [PATCH 3/3] block: enable bio allocation cache for IRQ driven IO
To:     Christoph Hellwig <hch@infradead.org>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org
References: <20211215163009.15269-1-axboe@kernel.dk>
 <20211215163009.15269-4-axboe@kernel.dk> <YbtOIA7eI0nyh8rb@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <25bd6311-0360-a88e-001c-29c309c8e658@kernel.dk>
Date:   Thu, 16 Dec 2021 08:41:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YbtOIA7eI0nyh8rb@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/16/21 7:33 AM, Christoph Hellwig wrote:
> On Wed, Dec 15, 2021 at 09:30:09AM -0700, Jens Axboe wrote:
>> We currently cannot use the bio recycling allocation cache for IRQ driven
>> IO, as the cache isn't IRQ safe (by design).
>>
>> Add a way for the completion side to pass back a bio that needs freeing,
>> so we can do it from the io_uring side. io_uring completions always
>> run in task context.
>>
>> This is good for about a 13% improvement in IRQ driven IO, taking us from
>> around 6.3M/core to 7.1M/core IOPS.
> 
> The numbers looks great, but I really hate how it ties the caller into
> using a bio.  I'll have to think hard about a better structure.

Yeah it's definitely not the prettiest, but I haven't been able to come
up with a better approach so far. I don't think the bio association is
the worst, can't imagine we'd want to tie it to something else. I might
be wrong...

Ideally we'd flip the completion model upside down here, instead of
having ->bi_end_io() call ->ki_complete.

> Just curious:  are the numbers with retpolines or without?  Do you care
> about the cost of indirect calls with retpolines for these benchmarks?

No mitigations enabled for these tests, so no retpoline. I definitely do
care about indirect call performance. The peak testing so far has been
mostly focused on best case - various features disabled that are common
but costly, and no mitigations enabled. Mostly because it's necessary to
break down the issues one-by-one, and the intent has always been to move
towards making common options less expensive too. Most of the patches
cover both bases, but there are also cases where we want to fix just
items that are costly when features/mitigations are enabled.


-- 
Jens Axboe

