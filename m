Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBAAC4742C
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 21:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E92892224F
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 21:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgKMVcC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgKMVbv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 16:31:51 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561FDC061A4E;
        Fri, 13 Nov 2020 13:23:54 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id a18so8709544pfl.3;
        Fri, 13 Nov 2020 13:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zDMkxDEKUwigLJNHN3ydwhNR21emZ0w4/kWJ79+z1uM=;
        b=MsockhpYr1gBMiX/VNZ75vH9tTBzfewcY4HvAxaVNk4CsAgONCq03F0hm9hsTRbByp
         6oVj4owU5MYMGTYi9ztLgqXHUJ+sk7cnGwURcTJAwek446tRfrp9iwsoJ/haaifZ68Ij
         5VjbRXTaxJs75mqDfWHNtU+M0hqD0XPGO48xqZxbEu9il1dSEHQfATHfzJb3h1CCi4ks
         Mf4YURPBLLnz/Xo67fsoXDqiLfVh5DVnCLwtEbInug3UgcFN6zIMLGpuvaB6U4N4hro7
         HU5cqMZJnGEwDsUYzWMmZM+PkSpfg15+NG6nQ07KBxapX+wi2Xc2eNlRmQ+mDMyaEsNH
         oZ5Q==
X-Gm-Message-State: AOAM531gGXFBym4uS0pRDhDvTxi7qn4bQE62sAO3kJc4Hak4kA6++R+b
        xG1Sid8vfxkKoTZ4vhe6s+M=
X-Google-Smtp-Source: ABdhPJwuXR2Fvvsb1vzusQKpDgFzaJ8sjH07TtQxH9xHaExt8QMes7iZteziR5hWvSS164xJrGHlNg==
X-Received: by 2002:a05:6a00:225c:b029:18b:d208:a366 with SMTP id i28-20020a056a00225cb029018bd208a366mr3668921pfu.5.1605302633812;
        Fri, 13 Nov 2020 13:23:53 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:be97:ffd:339d:919c? ([2601:647:4802:9070:be97:ffd:339d:919c])
        by smtp.gmail.com with ESMTPSA id e17sm10613872pfm.155.2020.11.13.13.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 13:23:53 -0800 (PST)
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To:     Jens Axboe <axboe@kernel.dk>, Rachit Agarwal <rach4x0r@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jaehyun Hwang <jaehyun.hwang@cornell.edu>,
        Qizhe Cai <qc228@cornell.edu>,
        Midhul Vuppalapati <mvv25@cornell.edu>,
        Rachit Agarwal <ragarwal@cs.cornell.edu>,
        Sagi Grimberg <sagi@lightbitslabs.com>,
        Rachit Agarwal <ragarwal@cornell.edu>
References: <20201112140752.1554-1-rach4x0r@gmail.com>
 <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
 <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
 <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <10993ce4-7048-a369-ea44-adf445acfca7@grimberg.me>
Date:   Fri, 13 Nov 2020 13:23:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> I haven't taken a close look at the code yet so far, but one quick note
>>> that patches like this should be against the branches for 5.11. In fact,
>>> this one doesn't even compile against current -git, as
>>> blk_mq_bio_list_merge is now called blk_bio_list_merge.
>>
>> Ugh, I guess that Jaehyun had this patch bottled up and didn't rebase
>> before submitting.. Sorry about that.
>>
>>> In any case, I did run this through some quick peak testing as I was
>>> curious, and I'm seeing about 20% drop in peak IOPS over none running
>>> this. Perf diff:
>>>
>>>       10.71%     -2.44%  [kernel.vmlinux]  [k] read_tsc
>>>        2.33%     -1.99%  [kernel.vmlinux]  [k] _raw_spin_lock
>>
>> You ran this with nvme? or null_blk? I guess neither would benefit
>> from this because if the underlying device will not benefit from
>> batching (at least enough for the extra cost of accounting for it) it
>> will be counter productive to use this scheduler.
> 
> This is nvme, actual device. The initial posting could be a bit more
> explicit on the use case, it says:
> 
> "For NVMe SSDs, the i10 I/O scheduler achieves ~60% improvements in
> terms of IOPS per core over "noop" I/O scheduler."
> 
> which made me very skeptical, as it sounds like it's raw device claims.

You are absolutely right, that needs to be fixed.

> Does beg the question of why this is a new scheduler then. It's pretty
> basic stuff, something that could trivially just be added a side effect
> of the core (and in fact we have much of it already). Doesn't really seem
> to warrant a new scheduler at all. There isn't really much in there.

Not saying it absolutely warrants a new one, and it could I guess sit in
the core, but this attempts to optimize for a specific metric while
trading-off others, which is exactly what I/O schedulers are for,
optimizing for a specific metric.

Not sure we want to build something biases towards throughput on the
expense of latency into the block core. And, as mentioned this is not
well suited to all device types...

But if you think this has a better home, I'm assuming that the guys
will be open to that.

>>> Was curious and wanted to look it up, but it doesn't exist.
>>
>> I think this is the right one:
>> https://github.com/i10-kernel/upstream-linux/blob/master/i10-evaluation.pdf
>>
>> We had some back and forth around the naming, hence this was probably
>> omitted.
> 
> That works, my local results were a bit worse than listed in there though.
> And what does this mean:
> 
> "We note that Linux I/O scheduler introduces an additional kernel worker
> thread at the I/O dispatching stage"
> 
> It most certainly does not for the common/hot case.

Yes I agree, didn't see the local results. Probably some
misunderstanding or a typo, I'll let them reply on this.
