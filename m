Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BD9C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0846135F
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJTO5x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhJTO5v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 10:57:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BADC06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:55:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y12so29722171eda.4
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VMCeHOth2mWWFST0Y0OfvOcPXmGcXlyEY5wI23Uvyhg=;
        b=pWnu9DfgcxDHZyU/Woy2+wLrx1Vr4pxlhrvHAk0hrh0tNyRQy6aXT0HnbAMtf2Gnxn
         7JyfYhrecqKlx3WgIM6Ci6zJdg0CdYj/qDvgcWEJyT4/VM/w6TW6B7aV1y1V3GluZGo7
         8PT+68HlgmzCfhzwj6H+WGSEqIl8x/MRApVnbAeIOtYQcHVZ0FpR/7pP0ij2VaPRzZpd
         oZ8Gr+JeI51bU6Cu75jxD6yNjbvCmhuuc2pJzRKSG9UB6Z1tWJYM1iHC+QDnJT5trnDc
         GDeikmuq5NDoQzFU3gpBblBPCa29f5eXn2UU6XboJP0W9DMqNw5xILwnJ0CzKVEFckTc
         0XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VMCeHOth2mWWFST0Y0OfvOcPXmGcXlyEY5wI23Uvyhg=;
        b=aopznDsnVHVtQfr5lbkDP0OTN8fzZMEQq1dTyDXnbcXUra6HWTcJgJqQfaUNrL1o0N
         In1Rb+gxnLRFSGFBioI6ISv7mPHrD+Q4lBh8Um3VI53NEq70UaM9+DtS5N/+ymost5jk
         zEpwQPMHqZiSwDL5fM7Pa7wXT79EDH6uYw3OV1ge14g3qAWLb658wAjHWkdKvSwu/NKG
         49LNSsDyqd59bbI3267dacdwa6tDHhgi1BHBeNnMAvCiGKlXScGDO/WaSq/5UH1U3O0R
         Zw0ChHz4PEfuzy+XjnkoaGVgwXEgJJsu/0fiKo4VCnD3RT5w0PpoyyvyWqCU1o36vhpf
         3hlQ==
X-Gm-Message-State: AOAM533AfUCulbFPI5vbqIoNXFZ23NZh7eG41D5eaxi7KG3NLob11jnN
        xy4iIYoAHQZznSk6Gf2RPThQlf3a79A=
X-Google-Smtp-Source: ABdhPJxtEfWT+lomeholz5mFEdB0GF1g/Q2KE7O3r3GU3jISeghh9rEUfXuPA7uEUui+n3Qm+/Lq+g==
X-Received: by 2002:a50:c31a:: with SMTP id a26mr520561edb.193.1634741680834;
        Wed, 20 Oct 2021 07:54:40 -0700 (PDT)
Received: from [192.168.43.77] (82-132-229-137.dab.02.net. [82.132.229.137])
        by smtp.gmail.com with ESMTPSA id h18sm1171925ejt.29.2021.10.20.07.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 07:54:40 -0700 (PDT)
Message-ID: <e5ec65a0-abfd-8eac-59aa-b715d890126c@gmail.com>
Date:   Wed, 20 Oct 2021 15:54:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 00/16] block optimisation round
Content-Language: en-US
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
References: <cover.1634676157.git.asml.silence@gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/21 22:24, Pavel Begunkov wrote:
> Jens tried out a similar series with some not yet sent additions:
> 8.2-8.3 MIOPS -> ~9 MIOPS, or 8-10%.
> 
> 12/16 is bulky, but it nicely drives the numbers. Moreover, with
> it we can rid of some not used anymore optimisations in
> __blkdev_direct_IO() because it awlays serve multiple bios.
> E.g. no need in conditional referencing with DIO_MULTI_BIO,
> and _probably_ can be converted to chained bio.
Some numbers, using nullblk is not perfect, but empirically
from numbers Jens posts his Optane setup usually gives somewhat
relatable results in terms of % difference. (probably, divide
the difference in percents by 2 for the worst case).

modprobe null_blk no_sched=1 irqmode=1 completion_nsec=0 submit_queues=16 poll_queues=32
echo 0 > /sys/block/nullb0/queue/iostats
echo 2 > /sys/block/nullb0/queue/nomerges
nice -n -20 taskset -c 0 ./io_uring -d32 -s32 -c32 -p1 -B1 -F1 -b512 /dev/nullb0
# polled=1, fixedbufs=1, register_files=1, buffered=0 QD=32, sq_ring=32, cq_ring=64

# baseline (for-5.16/block)

IOPS=4304768, IOS/call=32/32, inflight=32 (32)
IOPS=4289824, IOS/call=32/32, inflight=32 (32)
IOPS=4227808, IOS/call=32/32, inflight=32 (32)
IOPS=4187008, IOS/call=32/32, inflight=32 (32)
IOPS=4196992, IOS/call=32/32, inflight=32 (32)
IOPS=4208384, IOS/call=32/32, inflight=32 (32)
IOPS=4233888, IOS/call=32/32, inflight=32 (32)
IOPS=4266432, IOS/call=32/32, inflight=32 (32)
IOPS=4232352, IOS/call=32/32, inflight=32 (32)

# + patch 14/16 (skip advance)

IOPS=4367424, IOS/call=32/32, inflight=0 (16)
IOPS=4401088, IOS/call=32/32, inflight=32 (32)
IOPS=4400544, IOS/call=32/32, inflight=0 (29)
IOPS=4400768, IOS/call=32/32, inflight=32 (32)
IOPS=4409568, IOS/call=32/32, inflight=32 (32)
IOPS=4373888, IOS/call=32/32, inflight=32 (32)
IOPS=4392544, IOS/call=32/32, inflight=32 (32)
IOPS=4368192, IOS/call=32/32, inflight=32 (32)
IOPS=4362976, IOS/call=32/32, inflight=32 (32)

Comparing profiling. Before:
+    1.75%  io_uring  [kernel.vmlinux]  [k] bio_iov_iter_get_pages
+    0.90%  io_uring  [kernel.vmlinux]  [k] iov_iter_advance

After:
+    0.91%  io_uring  [kernel.vmlinux]  [k] bio_iov_iter_get_pages_hint
[no iov_iter_advance]

# + patches 15,16 (switch optimisation)

IOPS=4485984, IOS/call=32/32, inflight=32 (32)
IOPS=4500384, IOS/call=32/32, inflight=32 (32)
IOPS=4524512, IOS/call=32/32, inflight=32 (32)
IOPS=4507424, IOS/call=32/32, inflight=32 (32)
IOPS=4497216, IOS/call=32/32, inflight=32 (32)
IOPS=4496832, IOS/call=32/32, inflight=32 (32)
IOPS=4505632, IOS/call=32/32, inflight=32 (32)
IOPS=4476224, IOS/call=32/32, inflight=32 (32)
IOPS=4478592, IOS/call=32/32, inflight=32 (32)
IOPS=4480128, IOS/call=32/32, inflight=32 (32)
IOPS=4468640, IOS/call=32/32, inflight=32 (32)

Before:
+    1.92%  io_uring  [kernel.vmlinux]  [k] submit_bio_checks
+    5.56%  io_uring  [kernel.vmlinux]  [k] blk_mq_submit_bio
After:
+    1.66%  io_uring  [kernel.vmlinux]  [k] submit_bio_checks
+    5.49%  io_uring  [kernel.vmlinux]  [k] blk_mq_submit_bio

0.3% difference from perf, ~2% from absolute numbers, which is
most probably just a coincidence. But 0.3% looks realistic.


-- 
Pavel Begunkov
