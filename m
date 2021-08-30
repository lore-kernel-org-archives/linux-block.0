Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF80C432BE
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 17:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2939A60F5E
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 17:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhH3RPK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:15:10 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:35794 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbhH3RPJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 13:15:09 -0400
Received: by mail-pj1-f42.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so14370807pjb.0
        for <linux-block@vger.kernel.org>; Mon, 30 Aug 2021 10:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LeymGq0eS5YY4/eb8inHYlPUaQZllBGJ3evRgyoEDws=;
        b=h/kUDx4TakG6T41LKreirgWK9DKLCF8pA6D1gOkmGPLJztNEjvUMTwpz/5cOucsMF6
         Fc2svlCYme7EHhTUn9SdxOvOIpwTjb9GF/GP+lig7NqIz6WHCNPZ/4+2KczI2I1Nb7Zh
         NT6Ax2/ryaZSgmxR32X5kmmQeFRvysc0cP3cHEpFo3XWCtZ2j3WH8jjMbeJeHYNQWyQv
         Kfcu7AfTGcOHgpEFw7nAzNhF+rMzIdz4PdFuOnLDPgH/TLOcLCU6OTW12dUAXg6zE7wL
         Ars+mnHo/gUKy3J89t6OBrowjHbcnbm8c21jCMvn+SIr36DOpB3Pk+R+J2rqXfSiA8cL
         lxPQ==
X-Gm-Message-State: AOAM530dzJX7wPjtFKAaHp6yGrKLEcygCkEFhmQ6KA6Hz4pPtg0/tDAy
        EddV8olNNmgNkcDoKBNxNR91T9wu1H8=
X-Google-Smtp-Source: ABdhPJxt3drTUwwz45SxXX/HJhfQdSIwDMJ6RZmCWnuxGNvZeSBUo5hJz2aT2grCV2oEafxmJHmaSw==
X-Received: by 2002:a17:90a:43c2:: with SMTP id r60mr141840pjg.52.1630343654737;
        Mon, 30 Aug 2021 10:14:14 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:86a7:224:3596:de63])
        by smtp.gmail.com with ESMTPSA id d15sm17606541pgj.84.2021.08.30.10.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 10:14:13 -0700 (PDT)
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
 <9953a4f0-841e-9a94-d451-4b8ac889d62c@acm.org>
 <DM6PR04MB7081A6BD32CE97BE4149FFFAE7CA9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <ed6f98b8-232e-808b-83b7-98432b5a2450@acm.org>
 <DM6PR04MB70817A17F89A5654A46F3729E7CB9@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <cb651839-bc72-5b85-c531-af28b84dcbaf@acm.org>
Date:   Mon, 30 Aug 2021 10:14:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB70817A17F89A5654A46F3729E7CB9@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/29/21 8:07 PM, Damien Le Moal wrote:
> On 2021/08/30 11:40, Bart Van Assche wrote:
>> On 8/29/21 16:02, Damien Le Moal wrote:
>>> On 2021/08/27 23:34, Bart Van Assche wrote:
>>>> On 8/26/21 9:49 PM, Damien Le Moal wrote:
>>>>> So the mq-deadline priority patch reduces performance by nearly half at high QD.
>>>>> (*) Note: in all cases using the mq-deadline scheduler, for the first run at
>>>>> QD=1, I get this splat 100% of the time.
>>>>>
>>>>> [   95.173889] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [kworker/0:1H:757]
>>>>> [   95.292994] CPU: 0 PID: 757 Comm: kworker/0:1H Not tainted 5.14.0-rc7+ #1334
>>>>> [   95.307504] Workqueue: kblockd blk_mq_run_work_fn
>>>>> [   95.312243] RIP: 0010:_raw_spin_unlock_irqrestore+0x35/0x40
>>>>> [   95.415904] Call Trace:
>>>>> [   95.418373]  try_to_wake_up+0x268/0x7c0
>>>>> [   95.422238]  blk_update_request+0x25b/0x420
>>>>> [   95.426452]  blk_mq_end_request+0x1c/0x120
>>>>> [   95.430576]  null_handle_cmd+0x12d/0x270 [null_blk]
>>>>> [   95.435485]  blk_mq_dispatch_rq_list+0x13c/0x7f0
>>>>> [   95.443826]  __blk_mq_do_dispatch_sched+0xb5/0x2f0
>>>>> [   95.448653]  __blk_mq_sched_dispatch_requests+0xf4/0x140
>>>>> [   95.453998]  blk_mq_sched_dispatch_requests+0x30/0x60
>>>>> [   95.459083]  __blk_mq_run_hw_queue+0x49/0x90
>>>>> [   95.463377]  process_one_work+0x26c/0x570
>>>>> [   95.467421]  worker_thread+0x55/0x3c0
>>>>> [   95.475313]  kthread+0x140/0x160
>>>>> [   95.482774]  ret_from_fork+0x1f/0x30
>>>>
>>>> I don't see any function names in the above call stack that refer to the
>>>> mq-deadline scheduler? Did I perhaps overlook something? Anyway, if you can
>>>> tell me how to reproduce this (kernel commit + kernel config) I will take a
>>>> look.
>>>
>>> Indeed, the stack trace does not show any mq-deadline function. But the
>>> workqueue is stuck on _raw_spin_unlock_irqrestore() in the blk_mq_run_work_fn()
>>> function. I suspect that the spinlock is dd->lock, so the CPU may be stuck on
>>> entry to mq-deadline dispatch or finish request methods. Not entirely sure.
>>>
>>> I got this splat with 5.4.0-rc7 (Linus tag patch) with the attached config.
>>
>> Hi Damien,
>>
>> Thank you for having shared the kernel configuration used in your test.
>> So far I have not yet been able to reproduce the above call trace in a
>> VM. Could the above call trace have been triggered by the mpt3sas driver
>> instead of the mq-deadline I/O scheduler?
> 
> The above was triggered using nullblk with the test script you sent. I was not
> using drives on the HBA or AHCI when it happens. And I can reproduce this 100%
> of the time by running your script with QD=1.

Hi Damien,

I rebuilt kernel v5.14-rc7 (tag v5.14-rc7) after having run git clean -f -d -x
and reran my nullb iops test with the mq-deadline scheduler. No kernel complaints
appeared in the kernel log. Next I enabled lockdep (CONFIG_PROVE_LOCKING=y) and
reran the nullb iops test with mq-deadline as scheduler. Again zero complaints
appeared in the kernel log. Next I ran a subset of the blktests test
(./check -q block). All tests passed and no complaints appeared in the kernel log.

Please help with root-causing this issue by rerunning the test on your setup after
having enabled lockdep.

Thanks,

Bart.
