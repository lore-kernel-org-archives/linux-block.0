Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8A0C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 12:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE91218AD
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 12:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfAXMZv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 07:25:51 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33609 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfAXMZv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 07:25:51 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so5084170ljd.0
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 04:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfRw7CcQWSfCYZBU6tYtz4qy+/tOMnN70eTfMoxMaQc=;
        b=mimVfILlv5i+FHxeZ8Rl8YeczVMr3Bphs+ca7ZiuSYlL6wcQ/g0Z5oa6klr6tCc0dX
         oj/Ig9NNDl3TGZbWDRtIGKy4sNP9g8UQ3qQHcIFSHAS43dsq6aDH3v3rr9CrRRfFA5kA
         HdPRkp7yz/BV88tnp4hhMmSFzqFgGThYiHAs8jqddY8lbj6Q97sE4MtpeWf6L3nrFGds
         9PsAPUHedXsrTWiIPBNAvw7gKO8ypgAVissZG2OjKaby6xMwNZJiog4AiFN+RtebKDe0
         aNWPsBnNU8+URpYVulrahADP2n9rLAJ9FcnhgafEgozMQtPkZEVzgt8M8GmE5jKUEwNY
         eixQ==
X-Gm-Message-State: AJcUukcO7vPLTdhl4/OAwAJLUuQqKcA4s6R9Jl2OCSkjAKRbuWa5PGtT
        QTLf5K1vjB2fvIrm2oscjZxwoQumPPSA7XFZgOI2TQ==
X-Google-Smtp-Source: ALg8bN7BTGKS02LBLHaG+OcgvzbtxL3nOi3exsjsDEGzW7mNyjTECxOa4sgIoGE/Ze6Utnm9kEPGCncRxEfoNhqfelE=
X-Received: by 2002:a2e:5418:: with SMTP id i24-v6mr5384502ljb.51.1548332749234;
 Thu, 24 Jan 2019 04:25:49 -0800 (PST)
MIME-Version: 1.0
References: <20190124121315.6737-1-zhangxiaoxu5@huawei.com> <CAMeeMh_qaLMzLUEPWFvycUqcdtRxsgKnr98Y7C6gsnVt2QWP-Q@mail.gmail.com>
In-Reply-To: <CAMeeMh_qaLMzLUEPWFvycUqcdtRxsgKnr98Y7C6gsnVt2QWP-Q@mail.gmail.com>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Thu, 24 Jan 2019 13:25:38 +0100
Message-ID: <CAMeeMh_iy4_s6neKDvBfiAfH3AdLi07PJgzaCpvXdgGQsQPZog@mail.gmail.com>
Subject: Re: [PATCH] block: Fix a WRITE SAME BUG_ON
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, dm-devel@redhat.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Resending as plain text, apologies.

On Thu, Jan 24, 2019 at 1:23 PM John Dorminy <jdorminy@redhat.com> wrote:
>
> Adding dm-devel since it involves LVM.
>
> On Thu, Jan 24, 2019 at 1:14 PM Zhang Xiaoxu <zhangxiaoxu5@huawei.com> wrote:
>>
>> If the lvm is stacked by different logical_block_size disks,
>> when WRITE SAME on it, will bug_on:
>>
>> kernel BUG at drivers/scsi/sd.c:968!
>> invalid opcode: 0000 [#1] SMP PTI
>> CPU: 11 PID: 525 Comm: kworker/11:1H Tainted: G           O      5.0.0-rc3+ #2
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-2.fc27 04/01/2014
>> Workqueue: kblockd blk_mq_run_work_fn
>> RIP: 0010:sd_init_command+0x7aa/0xdb0
>> Code: 30 75 00 00 c7 85 44 01 00 00 18 00 00 00 0f 85 fa 04 00 00 48 83 c4 40 48
>>       89 df 5b 5d 41 5c 41 5d 41 5e 41 5f e9 b6 ca fe ff <0f> 0b 41 bc 09
>> RSP: 0018:ffffb55f80ddbca0 EFLAGS: 00010206
>> RAX: 0000000000001000 RBX: ffff9ed23fb927a0 RCX: 000000000000f000
>> RDX: ffff9ed23f0a8400 RSI: ffff9ed27bc79800 RDI: 0000000000000000
>> RBP: ffff9ed23fb92680 R08: ffff9ed27c8c0000 R09: ffff9ed23fb927d8
>> R10: 0000000000000000 R11: fefefefefefefeff R12: ffff9ed27bc79800
>> R13: ffff9ed2787a0000 R14: ffff9ed27bdf3400 R15: ffff9ed23fb927a0
>> FS:  0000000000000000(0000) GS:ffff9ed27c8c0000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f6b14cf9341 CR3: 0000000069058000 CR4: 00000000000006e0
>> Call Trace:
>>  ? vp_notify+0x12/0x20
>>  scsi_queue_rq+0x525/0xa30
>>  blk_mq_dispatch_rq_list+0x8d/0x580
>>  ? syscall_return_via_sysret+0x10/0x7f
>>  ? elv_rb_del+0x1f/0x30
>>  ? deadline_remove_request+0x55/0xc0
>>  blk_mq_do_dispatch_sched+0x76/0x110
>>  blk_mq_sched_dispatch_requests+0xf9/0x170
>>  __blk_mq_run_hw_queue+0x51/0xd0
>>  process_one_work+0x195/0x380
>>  worker_thread+0x30/0x390
>>  ? process_one_work+0x380/0x380
>>  kthread+0x113/0x130
>>  ? kthread_park+0x90/0x90
>>  ret_from_fork+0x35/0x40
>> Modules linked in: alloc(O+)
>> ---[ end trace dc92ddeb2e6d1fe5 ]---
>>
>> The logical_block_size of the LVM is the max value of the sub disks,
>> it maybe different with one of the sub disk. when WRITE SAME on the
>> disk, it will BUG_ON when setup WRITE SAME cmd.
>>
>> Close WRITE_SAME feature on the LVM if it was stacked by different
>> logical_block_size disk.
>>
>> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
>> ---
>>  block/blk-settings.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index 3e7038e475ee..e1695155ad61 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -537,6 +537,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>>                 }
>>         }
>>
>> +       /* If the logical block size is different, forbid write same */
>> +       if (t->logical_block_size != b->logical_block_size)
>> +               t->max_write_same_sectors = 0;
>> +
>>         t->logical_block_size = max(t->logical_block_size,
>>                                     b->logical_block_size);
>>
>> --
>> 2.14.4
>>
