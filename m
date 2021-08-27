Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A8BC432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 14:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1717D61029
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 14:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhH0OfS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 10:35:18 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:33769 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbhH0OfR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 10:35:17 -0400
Received: by mail-pf1-f172.google.com with SMTP id u6so5224108pfi.0
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 07:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fjba557/L3aah7XiOo6MlikroRUn3vpgMQK4+OF2nAo=;
        b=cavONqJVm+b4IagIkodHcCUBywwX8Ay9zv9G5S5gPxDjP3X5RMLpYu5V60rGO0pA0b
         i2HXdYuuJzG/Q+9GRp9fipFjuZmAIKsoDQgqZ/loEWNAGq3scyP3HKSZ1DZGJikDTurd
         Y2sAzvu36SsR3z6LFyEbkJHWoxQsYLBcmkp7jnoik5rGZxzFUnKM0IUHTwrrtEB5C0fJ
         9kUCj4OD0Gy6+JFa6gMaD3y5MEdZrKgfjUwPYuvVXraDJT7QgBKW1t4Q8A2S/CyAcSQy
         etqp8si2YrKdEVhE4yn/S2aolKfCipfwk+bX6mvhosfgCXk621KiqyCRBPZwdhPNsBWR
         /r7w==
X-Gm-Message-State: AOAM531COqng6l83M6z2A7mhUquq6uaMC3iL1hItw37iz4R1AyMpDgFO
        3AbdsK3v1q1qdgTQ2trEUrce+eTPVBA=
X-Google-Smtp-Source: ABdhPJyHmJqDMY45escum7YCugL7bbpdQiZe6c6AmuQWXZ8VAuVafcurN532ooNIaKgelqHflbQ34g==
X-Received: by 2002:a63:d814:: with SMTP id b20mr8208852pgh.268.1630074867792;
        Fri, 27 Aug 2021 07:34:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:7c18:2fe1:2126:c371? ([2601:647:4000:d7:7c18:2fe1:2126:c371])
        by smtp.gmail.com with ESMTPSA id b3sm6734185pfi.179.2021.08.27.07.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 07:34:26 -0700 (PDT)
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>
References: <20210826144039.2143-1-thunder.leizhen@huawei.com>
 <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
 <537620de-646d-e78e-ccb8-4105bac398b3@kernel.dk>
 <82612be1-d61e-1ad5-8fb5-d592a5bc4789@kernel.dk>
 <59c19a63-f321-94e8-cb31-87e88bd4e3d5@acm.org>
 <0ef7865d-a9ce-c5d9-ff7f-c0ef58de3d21@kernel.dk>
 <2332cba0-efe6-3b35-0587-ee6355a3567d@acm.org>
 <dd1f2b01-abe5-4e6f-14cf-c3bef90eb6f9@kernel.dk>
 <fdd60ef5-285c-964b-818a-6e0ee0481751@acm.org>
 <6ad27546-d61f-a98a-1633-9a4808a829ba@kernel.dk>
 <CH2PR04MB7078A227EF9087A45CF4535EE7C89@CH2PR04MB7078.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9953a4f0-841e-9a94-d451-4b8ac889d62c@acm.org>
Date:   Fri, 27 Aug 2021 07:34:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CH2PR04MB7078A227EF9087A45CF4535EE7C89@CH2PR04MB7078.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/26/21 9:49 PM, Damien Le Moal wrote:
> So the mq-deadline priority patch reduces performance by nearly half at high QD.
> With the modified patch, we are back to better numbers, but still a significant
> 20% drop at high QD.

Hi Damien,

An implementation of I/O priority for the deadline scheduler that reduces the
IOPS drop to 1% on my test setup is available here:
https://github.com/bvanassche/linux/tree/block-for-next

> (*) Note: in all cases using the mq-deadline scheduler, for the first run at
> QD=1, I get this splat 100% of the time.
> 
> [   95.173889] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [kworker/0:1H:757]
> [   95.292994] CPU: 0 PID: 757 Comm: kworker/0:1H Not tainted 5.14.0-rc7+ #1334
> [   95.307504] Workqueue: kblockd blk_mq_run_work_fn
> [   95.312243] RIP: 0010:_raw_spin_unlock_irqrestore+0x35/0x40
> [   95.415904] Call Trace:
> [   95.418373]  try_to_wake_up+0x268/0x7c0
> [   95.422238]  blk_update_request+0x25b/0x420
> [   95.426452]  blk_mq_end_request+0x1c/0x120
> [   95.430576]  null_handle_cmd+0x12d/0x270 [null_blk]
> [   95.435485]  blk_mq_dispatch_rq_list+0x13c/0x7f0
> [   95.443826]  __blk_mq_do_dispatch_sched+0xb5/0x2f0
> [   95.448653]  __blk_mq_sched_dispatch_requests+0xf4/0x140
> [   95.453998]  blk_mq_sched_dispatch_requests+0x30/0x60
> [   95.459083]  __blk_mq_run_hw_queue+0x49/0x90
> [   95.463377]  process_one_work+0x26c/0x570
> [   95.467421]  worker_thread+0x55/0x3c0
> [   95.475313]  kthread+0x140/0x160
> [   95.482774]  ret_from_fork+0x1f/0x30

I don't see any function names in the above call stack that refer to the
mq-deadline scheduler? Did I perhaps overlook something? Anyway, if you can
tell me how to reproduce this (kernel commit + kernel config) I will take a
look.

Thanks,

Bart.
