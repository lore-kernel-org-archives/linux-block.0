Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63D2C6369E
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F5A2224D
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgKMU6N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 15:58:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44342 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgKMU6N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 15:58:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id y7so8617004pfq.11;
        Fri, 13 Nov 2020 12:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eqiW5WCeO56holm7RXoi3eQgmDv2WVSj1ocHaA+r/9M=;
        b=SD0NIz4vD6djBocDFHuL9faqso6+ZL+OWbv6vafsErXswxuleWC2KWuNDKMWtgJelq
         wqmMjYhAdp/UsZB8V8ParcVhH3u/jU1tipksoZ+lcV9YwOXu9A7IpVuU8BkpfRDkgkuL
         xaaN/fbRFx0WO9Bdoxx0xvNoGhTb/uBUvRMJFEkwaoNx73yqfiKrbaSuZ+6iDsHIvhS9
         8sY0i+ZlDsw6OfH3eWagT3F/t7oID5D/PtWJIRe5Xw8QiOf3Jtj84GMal5PVxR/aSrWF
         AyhGQOZCekU5E1JkHGtL6vg4a4AQTeWUW7ocW0u85ZsmSKA2ua/hGMtyvUhOlBVd25xm
         ikyA==
X-Gm-Message-State: AOAM5313KifQhjHGaY1yWoqRMfkfZz1p7pwYHmyIrjoA6Q8xT0/RIDjZ
        crDdDv+T/v8cVNIj7wdkB1vVTFqJk+U=
X-Google-Smtp-Source: ABdhPJwn08QDfPoq2VTpcaBPIWAw389P+6FOdpXkdFrwjnNGlFh6XICRT0Yz5zZUNeeVgaqEo7SODw==
X-Received: by 2002:a62:7bcc:0:b029:18b:5859:d5e1 with SMTP id w195-20020a627bcc0000b029018b5859d5e1mr3398498pfc.40.1605301092806;
        Fri, 13 Nov 2020 12:58:12 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:be97:ffd:339d:919c? ([2601:647:4802:9070:be97:ffd:339d:919c])
        by smtp.gmail.com with ESMTPSA id r127sm10585552pfc.159.2020.11.13.12.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 12:58:12 -0800 (PST)
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To:     Ming Lei <ming.lei@redhat.com>, Rachit Agarwal <rach4x0r@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Qizhe Cai <qc228@cornell.edu>,
        Rachit Agarwal <ragarwal@cornell.edu>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org,
        Midhul Vuppalapati <mvv25@cornell.edu>,
        Jaehyun Hwang <jaehyun.hwang@cornell.edu>,
        Rachit Agarwal <ragarwal@cs.cornell.edu>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@lightbitslabs.com>,
        Christoph Hellwig <hch@lst.de>
References: <20201112140752.1554-1-rach4x0r@gmail.com>
 <20201113145912.GA1074955@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <44d5bcb0-689e-50c8-fa8e-a7d2b569f75c@grimberg.me>
Date:   Fri, 13 Nov 2020 12:58:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113145912.GA1074955@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> blk-mq actually has built-in batching(or sort of) mechanism, which is enabled
> if the hw queue is busy(hctx->dispatch_busy is > 0). We use EWMA to compute
> hctx->dispatch_busy, and it is adaptive, even though the implementation is quite
> coarse. But there should be much space to improve, IMO.

You are correct, however nvme-tcp should be getting to dispatch_busy > 0
IIUC.

> It is reported that this way improves SQ high-end SCSI SSD very much[1],
> and MMC performance gets improved too[2].
> 
> [1] https://lore.kernel.org/linux-block/3cc3e03901dc1a63ef32e036182521af@mail.gmail.com/
> [2] https://lore.kernel.org/linux-block/CADBw62o9eTQDJ9RvNgEqSpXmg6Xcq=2TxH0Hfxhp29uF2W=TXA@mail.gmail.com/

Yes, the guys paid attention to the MMC related improvements that you
made.

>> The i10 I/O scheduler builds upon recent work on [6]. We have tested the i10 I/O
>> scheduler with nvme-tcp optimizaitons [2,3] and batching dispatch [4], varying number
>> of cores, varying read/write ratios, and varying request sizes, and with NVMe SSD and
>> RAM block device. For NVMe SSDs, the i10 I/O scheduler achieves ~60% improvements in
>> terms of IOPS per core over "noop" I/O scheduler. These results are available at [5],
>> and many additional results are presented in [6].
> 
> In case of none scheduler, basically nvme driver won't provide any queue busy
> feedback, so the built-in batching dispatch doesn't work simply.

Exactly.

> kyber scheduler uses io latency feedback to throttle and build io batch,
> can you compare i10 with kyber on nvme/nvme-tcp?

I assume it should be simple to get, I'll let Rachit/Jaehyun comment.

>> While other schedulers may also batch I/O (e.g., mq-deadline), the optimization target
>> in the i10 I/O scheduler is throughput maximization. Hence there is no latency target
>> nor a need for a global tracking context, so a new scheduler is needed rather than
>> to build this functionality to an existing scheduler.
>>
>> We currently use fixed default values as batching thresholds (e.g., 16 for #requests,
>> 64KB for #bytes, and 50us for timeout). These default values are based on sensitivity
>> tests in [6]. For our future work, we plan to support adaptive batching according to
> 
> Frankly speaking, hardcode 16 #rquests or 64KB may not work everywhere,
> and product environment could be much complicated than your sensitivity
> tests. If possible, please start with adaptive batching.

That was my feedback as well for sure. But given that this is a
scheduler one would opt-in to anyway, that won't be a must-have
initially. I'm not sure if the guys made progress with this yet, I'll
let them comment.
