Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA90C432BE
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 02:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B7360698
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 02:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbhH3Cll (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Aug 2021 22:41:41 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:36485 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbhH3Clk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Aug 2021 22:41:40 -0400
Received: by mail-pg1-f176.google.com with SMTP id t1so12047525pgv.3
        for <linux-block@vger.kernel.org>; Sun, 29 Aug 2021 19:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vfxz0y5IYwRH0Qrh8C66QBRTfDeCHisTr0FRVbKMgUg=;
        b=pq+hobhefYzT7ca57z/jwObkLxVfqMcf2eteW2dEiJtbE1tLutM9YciHyQ70BFv8cP
         fwC4MLQEXcWltwkb5eRaQNuT8h0jXW4RSvjcYk95vPpc5ALN3uksDFCX35MyFj5D59Gz
         2ReHA1JlvAjVsGqdfJzF0mydpaarOK+j15BjV8divN7nrR1YsF23YQKr0P1t2KMFbLaE
         EJ0B3ze8Q87iJj8De9nuVXaA2fo2mZWL4BXLbf6Rh3X80LVYQmE/hY2HlutopeOjIttj
         qU/pEqu/mC/RYiE1DtfX372o9QKUG2lv2weKHeHGY12wFz2GCDfz446yp7cxSLngVHDs
         5kEw==
X-Gm-Message-State: AOAM531jn5SpJpByK4fQwugh2Jtr7OMSS/fMC4Y7RBXek9sMB508y+gU
        dcU3EdHrt8UGSZG6YIepif2kQAadNAI=
X-Google-Smtp-Source: ABdhPJwexVVYROAJYHGBSvoWk2s4xal68oaYtqASYLG5OJrTgwDK0YjFTurCVJc3+I0DKv48inoBuQ==
X-Received: by 2002:a63:f346:: with SMTP id t6mr19482154pgj.345.1630291247719;
        Sun, 29 Aug 2021 19:40:47 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:3a42:154:b70e:7868? ([2601:647:4000:d7:3a42:154:b70e:7868])
        by smtp.gmail.com with UTF8SMTPSA id l22sm5947055pjz.54.2021.08.29.19.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 19:40:46 -0700 (PDT)
Message-ID: <ed6f98b8-232e-808b-83b7-98432b5a2450@acm.org>
Date:   Sun, 29 Aug 2021 19:40:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
Content-Language: en-US
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
 <9953a4f0-841e-9a94-d451-4b8ac889d62c@acm.org>
 <DM6PR04MB7081A6BD32CE97BE4149FFFAE7CA9@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB7081A6BD32CE97BE4149FFFAE7CA9@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/29/21 16:02, Damien Le Moal wrote:
> On 2021/08/27 23:34, Bart Van Assche wrote:
>> On 8/26/21 9:49 PM, Damien Le Moal wrote:
>>> So the mq-deadline priority patch reduces performance by nearly half at high QD.
>>> (*) Note: in all cases using the mq-deadline scheduler, for the first run at
>>> QD=1, I get this splat 100% of the time.
>>>
>>> [   95.173889] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [kworker/0:1H:757]
>>> [   95.292994] CPU: 0 PID: 757 Comm: kworker/0:1H Not tainted 5.14.0-rc7+ #1334
>>> [   95.307504] Workqueue: kblockd blk_mq_run_work_fn
>>> [   95.312243] RIP: 0010:_raw_spin_unlock_irqrestore+0x35/0x40
>>> [   95.415904] Call Trace:
>>> [   95.418373]  try_to_wake_up+0x268/0x7c0
>>> [   95.422238]  blk_update_request+0x25b/0x420
>>> [   95.426452]  blk_mq_end_request+0x1c/0x120
>>> [   95.430576]  null_handle_cmd+0x12d/0x270 [null_blk]
>>> [   95.435485]  blk_mq_dispatch_rq_list+0x13c/0x7f0
>>> [   95.443826]  __blk_mq_do_dispatch_sched+0xb5/0x2f0
>>> [   95.448653]  __blk_mq_sched_dispatch_requests+0xf4/0x140
>>> [   95.453998]  blk_mq_sched_dispatch_requests+0x30/0x60
>>> [   95.459083]  __blk_mq_run_hw_queue+0x49/0x90
>>> [   95.463377]  process_one_work+0x26c/0x570
>>> [   95.467421]  worker_thread+0x55/0x3c0
>>> [   95.475313]  kthread+0x140/0x160
>>> [   95.482774]  ret_from_fork+0x1f/0x30
>>
>> I don't see any function names in the above call stack that refer to the
>> mq-deadline scheduler? Did I perhaps overlook something? Anyway, if you can
>> tell me how to reproduce this (kernel commit + kernel config) I will take a
>> look.
> 
> Indeed, the stack trace does not show any mq-deadline function. But the
> workqueue is stuck on _raw_spin_unlock_irqrestore() in the blk_mq_run_work_fn()
> function. I suspect that the spinlock is dd->lock, so the CPU may be stuck on
> entry to mq-deadline dispatch or finish request methods. Not entirely sure.
> 
> I got this splat with 5.4.0-rc7 (Linus tag patch) with the attached config.

Hi Damien,

Thank you for having shared the kernel configuration used in your test. 
So far I have not yet been able to reproduce the above call trace in a 
VM. Could the above call trace have been triggered by the mpt3sas driver 
instead of the mq-deadline I/O scheduler?

Thanks,

Bart.

