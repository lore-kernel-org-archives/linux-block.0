Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E26C55ABD
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 20:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 094842224A
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 20:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgKMUe7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 15:34:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42678 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgKMUe7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 15:34:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id x15so7279713pfm.9;
        Fri, 13 Nov 2020 12:34:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fxjgOhyybNYpZSYX+6Oz1HIqCUNxG8ovneGfaNCfF7M=;
        b=m28oKwq7QobdmdxuzWY01aXV6BBzuzqqyh3Zt0Gd51yLBAmz0uG0CGVMehKrGrV1sW
         tJLsmEMRow0lTkTWnR69KbqESdUv8eKoL4JkQWc6R0UhTb44Km4844/faD2xhoRpuT6r
         OiDtaxx98HfIvog9uGT3EQkzJJlJwAn5HfSfu3kZPqiRrGhqFeUF39vBKp/Lj3vaib0l
         BRpV4O6lBG+QCl2FUube2SOfTdeqS3ZCFu3UoFSMb+bgEJ7/Mvja3gKtYNaaz0imcRDM
         D9gZdIE+2Zo3/QwzLb7hjXQKpJM0MvZRUs7jvrIxqadVnZT+Wv9tC2UGofs2O5qh9ajU
         Ngsw==
X-Gm-Message-State: AOAM5330anewUGY8DuSo+P1+PHJLtGoPR9hHWx6cx5CJlcBZgqRFi+oT
        sAvtMSU39+wLD6WZKOTkn5o=
X-Google-Smtp-Source: ABdhPJy42BorG2pmGsmgyPntSK/vRijj7t5aWnUYg3nJvkgQnbWSa/nNQ4gJ0u4rpJEGYtI1RRcikA==
X-Received: by 2002:a62:dd16:0:b029:18a:b228:649 with SMTP id w22-20020a62dd160000b029018ab2280649mr3540822pff.33.1605299698294;
        Fri, 13 Nov 2020 12:34:58 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:be97:ffd:339d:919c? ([2601:647:4802:9070:be97:ffd:339d:919c])
        by smtp.gmail.com with ESMTPSA id t64sm11036186pfd.36.2020.11.13.12.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 12:34:57 -0800 (PST)
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
Date:   Fri, 13 Nov 2020 12:34:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> I haven't taken a close look at the code yet so far, but one quick note
> that patches like this should be against the branches for 5.11. In fact,
> this one doesn't even compile against current -git, as
> blk_mq_bio_list_merge is now called blk_bio_list_merge.

Ugh, I guess that Jaehyun had this patch bottled up and didn't rebase
before submitting.. Sorry about that.

> In any case, I did run this through some quick peak testing as I was
> curious, and I'm seeing about 20% drop in peak IOPS over none running
> this. Perf diff:
> 
>      10.71%     -2.44%  [kernel.vmlinux]  [k] read_tsc
>       2.33%     -1.99%  [kernel.vmlinux]  [k] _raw_spin_lock

You ran this with nvme? or null_blk? I guess neither would benefit
from this because if the underlying device will not benefit from
batching (at least enough for the extra cost of accounting for it) it
will be counter productive to use this scheduler.

> Also:
> 
>> [5] https://github.com/i10-kernel/upstream-linux/blob/master/dss-evaluation.pdf
> 
> Was curious and wanted to look it up, but it doesn't exist.

I think this is the right one:
https://github.com/i10-kernel/upstream-linux/blob/master/i10-evaluation.pdf

We had some back and forth around the naming, hence this was probably
omitted.
