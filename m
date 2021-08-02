Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE23EC4338F
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 16:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A6B36100A
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 16:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhHBQRo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:17:44 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:39518 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhHBQRo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 12:17:44 -0400
Received: by mail-pj1-f45.google.com with SMTP id k4-20020a17090a5144b02901731c776526so32413076pjm.4;
        Mon, 02 Aug 2021 09:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nIRjck5Ee5tjZVq3eJ/W83YPGQGA2jpDSG9eUBTAzQE=;
        b=rFeB0Pp04lGMb/EfPxsLcwk5V6aRhRrChqphuUSwTi0jxdbThJ8p5zI54QflM3oCoR
         5FKCwmZak2oHf5Q1KfaHYtt6uP6pLztRvY9K6pbLkCA15jzaKsxH1FyT6D/gnMpNj2/9
         l6CgIwBD001z4evyEDGHmzfEoOIXsy76aimLIXmxGzpR2Jc/5g3qQh39koQFIFnkonL5
         l0qD+xB8sgEsaJFsG3ka/9ROYMdDD1YdJC9vBCkG0S8W5wx3ZPtsXKh5S8dXuGr9a5U5
         b99B+2rdg42IhR8loxZ9rScFeY3mH9EQ/9OikLDNDehGBKv3fKMIe27s3/s2tqY48y+O
         rI9g==
X-Gm-Message-State: AOAM5322bU7Bvui7Y1KKtGNIOQIStIjlJ1ZAq8fmfVY+Z/ApM9HceoEe
        pxHuUZSyDSm9mKdrmIR7wCg=
X-Google-Smtp-Source: ABdhPJxzcFBAvLGl+R1llvOIR/01Uxr2Pd7NaRvpRyDi0bi+N8OiBGilB/U+Yq4rAn5e6BsY+BjGXA==
X-Received: by 2002:a17:90b:2513:: with SMTP id ns19mr11567270pjb.63.1627921053409;
        Mon, 02 Aug 2021 09:17:33 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:bca4:545f:af00:8cbe])
        by smtp.gmail.com with ESMTPSA id k200sm2323866pfd.46.2021.08.02.09.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 09:17:32 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: allow hardware queue to get more tag while
 sharing a tag set
To:     "yukuai (C)" <yukuai3@huawei.com>, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20210712031818.31918-1-yukuai3@huawei.com>
 <ade72519-5e16-1cc5-9a77-cb9ead42035e@acm.org>
 <5ab07cf8-a2a5-a60e-c86a-ab6ea53990bb@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e587c572-bcd7-87c4-5eea-30ccdc7455db@acm.org>
Date:   Mon, 2 Aug 2021 09:17:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5ab07cf8-a2a5-a60e-c86a-ab6ea53990bb@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/2/21 6:34 AM, yukuai (C) wrote:
> I run a test on both null_blk and nvme, results show that there are no
> performance degradation:
> 
> test platform: x86
> test cpu: 2 nodes, total 72
> test scheduler: none
> test device: null_blk / nvme
> 
> test cmd: fio -filename=/dev/xxx -name=test -ioengine=libaio -direct=1
> -numjobs=72 -iodepth=16 -bs=4k -rw=write -offset_increment=1G
> -cpus_allowed=0:71 -cpus_allowed_policy=split -group_reporting
> -runtime=120
> 
> test results: iops
> 1) null_blk before this patch: 280k
> 2) null_blk after this patch: 282k
> 3) nvme before this patch: 378k
> 4) nvme after this patch: 384k

Please use io_uring for performance tests.

The null_blk numbers seem way too low to me. If I run a null_blk 
performance test inside a VM with 6 CPU cores (Xeon W-2135 CPU) I see 
about 6 million IOPS for synchronous I/O and about 4.4 million IOPS when 
using libaio. The options I used and that are not in the above command 
line are: --thread --gtod_reduce=1 --ioscheduler=none.

Thanks,

Bart.
