Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C52AC5ACAE
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 08:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9C02084F
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 08:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="MUuSvSz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbfILI7h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:59:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34631 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbfILI7h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Sep 2019 04:59:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id c20so14233749eds.1
        for <linux-block@vger.kernel.org>; Thu, 12 Sep 2019 01:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kChvZGbpcJWA2QRofLXP+ULBEdJ049tY540TTie6bnU=;
        b=MUuSvSz0vaefSqMFwvKsboUMqEg4bADf5e7y9F0QRljZuV48QrPRH/+amsn+qt8gQj
         ySKdX8KziJFTgHPw8RzqHgVUGBIXHcmzxzURqOTtCHk2iryUWidN7w3CHs2G+z6a6erh
         VDD2J8FF9MJ5j2r9SaxcREfmD715nJCPyOLvWoOeImu2IqHZ8uXNvzDN8ByrB0aNFGXw
         Bf2oCtYlwWxygeb9egiY6Oft64JQRCCYVKIw2H5P6HMp2AzaANV+0d87RC1xM/B3tYC1
         SlW0zva+rQlXBuQnP7+Y2LxCWrD1fnBojAnw9zH5k6OcXJAS1u4ADzHa3Uwfp2E5Rg6p
         P08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kChvZGbpcJWA2QRofLXP+ULBEdJ049tY540TTie6bnU=;
        b=WgU4oy6VuyR9bxTxAOxpYZHr+ZLa4EJ4wopJ9s+a8LVer/UeeGAT3KsM0HjE8OZ2PG
         LI2tZiEAdptf+sxTDAR4mWd5VLu0JZOf9L5EzmxrOzjyz6B1W9FVbODZ231PtIsFxTQ/
         o8acV+tUSxzZIn0oMbCGgCxMorehvbBSdAUSQKIFL4KH2fwckl0mhd8fvx4bG8jgra/P
         IDqHpuNkcHQt+/EjSk4hj2YuDimC+7oKOTKw3kbLyG5C8e6fJoo4c+S/ss3++1/m25v1
         OaR9CQLi0WORZu+Xv4OgkdBT8VBFaL0J88XntPMnYPmwa7b6fUkTyUWTuLnx3EYOu/aj
         VHJQ==
X-Gm-Message-State: APjAAAUwX40FpCqP8a4SQAhODoRg0Xd+YKEaGMXaB99iVpwG8UFmd0h5
        MtGurpfH045OmMHvMEgwW35c/A==
X-Google-Smtp-Source: APXvYqwGXzlvBlcszQ/4Bfx75CxBv8UH0dQSUoI37IEruQK8pKw++5lGMCF+XJ7r5afipXJWTiYnNg==
X-Received: by 2002:a17:906:6c7:: with SMTP id v7mr20824770ejb.27.1568278774936;
        Thu, 12 Sep 2019 01:59:34 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:a1ab:2925:fa73:b0d7? ([2001:1438:4010:2540:a1ab:2925:fa73:b0d7])
        by smtp.gmail.com with ESMTPSA id mh8sm2751385ejb.74.2019.09.12.01.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 01:59:34 -0700 (PDT)
Subject: Re: [PATCH] block: fix null pointer dereference in
 blk_mq_rq_timed_out()
To:     Yufen Yu <yuyufen@huawei.com>, Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, hch@infradead.org,
        keith.busch@intel.com, tj@kernel.org, zhangxiaoxu5@huawei.com
References: <20190907102450.40291-1-yuyufen@huawei.com>
 <20190912024618.GE2731@ming.t460p>
 <b3d7b459-5f31-d473-2508-20048119c1b2@huawei.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <9a77d54c-78b1-c24d-c8ba-0240c7ae7460@cloud.ionos.com>
Date:   Thu, 12 Sep 2019 10:59:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b3d7b459-5f31-d473-2508-20048119c1b2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 9/12/19 5:29 AM, Yufen Yu wrote:
>
>
> On 2019/9/12 10:46, Ming Lei wrote:
>> On Sat, Sep 07, 2019 at 06:24:50PM +0800, Yufen Yu wrote:
>>> There is a race condition between timeout check and completion for
>>> flush request as follow:
>>>
>>> timeout_work    issue flush      issue flush
>>>                  blk_insert_flush
>>>                                   blk_insert_flush
>>> blk_mq_timeout_work
>>>                  blk_kick_flush
>>>
>>> blk_mq_queue_tag_busy_iter
>>> blk_mq_check_expired(flush_rq)
>>>
>>>                  __blk_mq_end_request
>>>                 flush_end_io
>>>                 blk_kick_flush
>>>                 blk_rq_init(flush_rq)
>>>                 memset(flush_rq, 0)
>> Not see there is memset(flush_rq, 0) in block/blk-flush.c
>
> Call path as follow:
>
> blk_kick_flush
>     blk_rq_init
>         memset(rq, 0, sizeof(*rq));
>
>>> blk_mq_timed_out
>>> BUG_ON flush_rq->q->mq_ops
>> flush_rq->q won't be changed by blk_rq_init(), and either READ or WRITE
>> on variable with machine WORD length are atomic, so how can the BUG_ON()
>> be triggered? Do you have the actual BUG log?
>>
>> Also now it is driver's responsibility for avoiding race between normal
>> completion and timeout.
>
> I have reproduced the bug by adding time delay in timeout handle and 
> memset.
> BUG_ON log as follow:
>
> [  108.825472] BUG: kernel NULL pointer dereference, address: 
> 0000000000000040
> [  108.826091] #PF: supervisor read access in kernel mode
> [  108.826543] #PF: error_code(0x0000) - not-present page
> [  108.827059] PGD 0 P4D 0
> [  108.827313] Oops: 0000 [#1] SMP PTI
> [  108.827657] CPU: 6 PID: 198 Comm: kworker/6:1H Not tainted 
> 5.3.0-rc8+ #431
> [  108.828326] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
> BIOS ?-20180531_142017-buildhw-08.phx2.fedoraproject.org-1.fc28 
> 04/01/2014
> [  108.829503] Workqueue: kblockd blk_mq_timeout_work
> [  108.829913] RIP: 0010:blk_mq_check_expired+0x258/0x330
> [  108.830439] Code: 01 e9 0a ff ff ff 48 83 05 34 45 dd 02 01 4c 39 
> 63 40 0f 84 8a 00 00 00 0d 00 00 20 00 40 0f b6 f5 41 89 44 24 1c 49 
> 8b 04 24 <48> 8b 40 40 48 8b 40 20 48 85 c0 0f 84 90 00 00 00 48 83 05 
> 2f 44
> [  108.832246] RSP: 0018:ffffbf7ac18b7db0 EFLAGS: 00010206
> [  108.832756] RAX: 0000000000000000 RBX: ffffffffb56e0250 RCX: 
> 0000000000000000
> [  108.833444] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
> ffff9ab7fbb96538
> [  108.834149] RBP: 0000000000000000 R08: 000000000000024b R09: 
> 0000000000000030
> [  108.834840] R10: 000000000000004e R11: ffffbf7ac18b7c40 R12: 
> ffff9ab7f756e000
> [  108.835531] R13: ffffbf7ac18b7e70 R14: 0000000000000017 R15: 
> ffff9ab7f6ead0a0
> [  108.836228] FS:  0000000000000000(0000) GS:ffff9ab7fbb80000(0000) 
> knlGS:0000000000000000
> [  108.837026] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  108.837588] CR2: 0000000000000040 CR3: 000000013544c000 CR4: 
> 00000000000006e0
> [  108.838191] Call Trace:
> [  108.838406]  bt_iter+0x74/0x80
> [  108.838665]  blk_mq_queue_tag_busy_iter+0x204/0x450
> [  108.839074]  ? __switch_to_asm+0x34/0x70
> [  108.839405]  ? blk_mq_stop_hw_queue+0x40/0x40
> [  108.839823]  ? blk_mq_stop_hw_queue+0x40/0x40
> [  108.840273]  ? syscall_return_via_sysret+0xf/0x7f
> [  108.840732]  blk_mq_timeout_work+0x74/0x200
> [  108.841151]  process_one_work+0x297/0x680
> [  108.841550]  worker_thread+0x29c/0x6f0
> [  108.841926]  ? rescuer_thread+0x580/0x580
> [  108.842344]  kthread+0x16a/0x1a0
> [  108.842666]  ? kthread_flush_work+0x170/0x170
> [  108.843100]  ret_from_fork+0x35/0x40
> [  108.843455] Modules linked in:
> [  108.843758] CR2: 0000000000000040
> [  108.844090] ---[ end trace e0ac552505fa1b95 ]---
>
> blk_mq_rq_timed_out() attempt to read 'req->q->mq_ops->timeout', but 
> 'q == 0' currently,
> which triggers BUG_ON.

We have a similar calltrace which happened in older kernel (4.4.62), not 
sure if it is the same one.

[32353526.224059] CPU: 16 PID: 0 Comm: swapper/16 Tainted: G           O    4.4.62-1-storage #4.4.62-1.3
[32353526.224343] Hardware name: Supermicro SSG-2028R-ACR24L/X10DRH-iT, BIOS 3.1 06/18/2018
[...]
[32353526.224840] RIP: 0010:[<ffffffff812df5a1>] [<ffffffff812df5a1>] blk_mq_rq_timed_out+0x11/0x70
[32353526.285015]  [<ffffffff812df63d>] blk_mq_check_expired+0x3d/0x60
[32353526.301997]  [<ffffffff812e1f74>] bt_for_each+0xd4/0xe0
[32353526.310730]  [<ffffffff812df600>] ? blk_mq_rq_timed_out+0x70/0x70
[32353526.319579]  [<ffffffff812df600>] ? blk_mq_rq_timed_out+0x70/0x70
[32353526.328329]  [<ffffffff812e2753>] blk_mq_queue_tag_busy_iter+0x43/0xc0
[32353526.336995]  [<ffffffff812de7c0>] ? blk_mq_bio_to_request+0x40/0x40
[32353526.345566]  [<ffffffff812de7f2>] blk_mq_rq_timer+0x32/0xd0
[32353526.354094]  [<ffffffff810b2e45>] call_timer_fn+0x35/0x130
[32353526.362542]  [<ffffffff812de7c0>] ? blk_mq_bio_to_request+0x40/0x40
[32353526.370894]  [<ffffffff810b31b7>] run_timer_softirq+0x157/0x280

Thanks,
Guoqing

