Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0801C43460
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 14:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF7FE6115C
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 14:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbhDZO6S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhDZO6P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 10:58:15 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14834C06175F
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 07:57:33 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e186so3233031iof.7
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 07:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+yd2tx9BCCf4xJLHc9OiI/eDFt5m0JTWVGxUCZolvrw=;
        b=2HsIu7cpcisWskDPCz1niUfCrbIV0yAHc5tmdZS/e1f/EMJOWvNzqGnZdIiXuD84Kg
         9dJaGxDmjYKwmWr0CmxlFa7GvlSyWCTgbJObTr81zckzaUhAQuQ1gakaRU2WmFBi5pAu
         C1mdzvUGp8MdlROJlOeGfQrlirIksyxo71NlzNKW9SKj/jW72jG0EKMA/VTzA6qzsKb+
         LfeiyiJR7bBEfuLttt4BeLKwaaEq0lP6V9wdmYTLey/s1gWVhMBDbitQcELfllf17jZQ
         mdJLCOvxPi/ow7//U9w1+U7c728K8oSvZbOCU25dtNbZL8YB01wwzer7pbJ9qUqQBVYw
         NhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+yd2tx9BCCf4xJLHc9OiI/eDFt5m0JTWVGxUCZolvrw=;
        b=ei3wfHWHGOOaBsKW5vqVYWZI1LrYLsfAySqfkVrxVr48O59XxiKdMaR79RcVVRu7cU
         GF464mnm0i9f6ZTLVYtcD2uOZKSC0EQA1/4P9EdiRwXRCHD6qzkyu8bxf9dDZymV3qEV
         S12fNguKeUVoiRNiTsoIXDvhTK56GxYX6HdW6euzJ6x5wFNpOOOJcScCmhHBoQKpGMqS
         d09F72J2yd/zo7LlV7xNJqNR4P8F25h5GExzkIyY+M58mEUYfm8quzhor8O+53IB7v9L
         mecKv2p+ruvKOpHxQFCgeCQSU5t+NkpA/YswYd1VquaL1+ARcD24BQfVvJVKaCMU9TBZ
         JfbA==
X-Gm-Message-State: AOAM533/eC69BUUS2SnUvO3ZBswcOR2lq8vUfCpPmm5ZpcNlBfhx6Lm3
        CTwbA4Sw0BZcejxOFKXe1GbnqA==
X-Google-Smtp-Source: ABdhPJwtGMtPoVs1B11K5X6uVtKBj+YRGFpJg6HoDvgF9dkSbV8E+DF9QKm2IzXOcFpgUQM5vHj6PQ==
X-Received: by 2002:a02:ce9a:: with SMTP id y26mr16884376jaq.16.1619449052374;
        Mon, 26 Apr 2021 07:57:32 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s6sm7590013iob.45.2021.04.26.07.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 07:57:32 -0700 (PDT)
Subject: Re: switch block layer polling to a bio based model
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210426134821.2191160-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2d229167-f56d-583b-569c-166c97ce2e71@kernel.dk>
Date:   Mon, 26 Apr 2021 08:57:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210426134821.2191160-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/26/21 7:48 AM, Christoph Hellwig wrote:
> Hi all,
> 
> This series clean up the block polling code a bit and changes the interface
> to poll for a specific bio instead of a request_queue and cookie pair.
> 
> Polling for the bio itself leads to a few advantages:
> 
>   - the cookie construction can made entirely private in blk-mq.c
>   - the caller does not need to remember the request_queue and cookie
>     separately and thus sidesteps their lifetime issues
>   - keeping the device and the cookie inside the bio allows to trivially
>     support polling BIOs remapping by stacking drivers
>   - a lot of code to propagate the cookie back up the submission path can
>     removed entirely
> 
> The one major caveat is that this requires RCU freeing polled BIOs to make
> sure the bio that contains the polling information is still alive when
> io_uring tries to poll it through the iocb. For synchronous polling all the
> callers have a bio reference anyway, so this is not an issue.

Was curious about this separately, so ran a quick test on it. Running polled
IO on a fast device, performance drops about 10% with this applied. Outside
of that, we have ksoftirqd using 5-7% of CPU continually, just doing frees:

+   45.33%  ksoftirqd/0  [kernel.vmlinux]  [k] __slab_free
+   15.91%  ksoftirqd/0  [kernel.vmlinux]  [k] kmem_cache_free
+   12.66%  ksoftirqd/0  [kernel.vmlinux]  [k] rcu_cblist_dequeue
+    8.39%  ksoftirqd/0  [kernel.vmlinux]  [k] rcu_core
+    4.75%  ksoftirqd/0  [kernel.vmlinux]  [k] free_one_page
+    3.27%  ksoftirqd/0  [kernel.vmlinux]  [k] bio_free_rcu
+    1.98%  ksoftirqd/0  [kernel.vmlinux]  [k] mempool_free_slab

This all means that we go from 2.97M IOPS to 2.70M IOPS in that
particular test (QD=128, async polled).

I was separately curious about this as I have a (as of yet unposted)
patchset that recycles bio allocations, as we spend quite a bit of time
doing that for high rate polled IO. It's good for taking the above 2.97M
IOPS to 3.2-3.3M IOPS, and it'd obviously be a bit more problematic with
required RCU freeing of bio's. Even without the alloc cache, using RCU
will ruin any potential cache locality on back-to-back bio free + bio
alloc.

-- 
Jens Axboe

