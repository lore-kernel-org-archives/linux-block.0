Return-Path: <SRS0=xZ4d=QC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B20C282C7
	for <linux-block@archiver.kernel.org>; Sat, 26 Jan 2019 11:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C333218A6
	for <linux-block@archiver.kernel.org>; Sat, 26 Jan 2019 11:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfAZLSN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Jan 2019 06:18:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42958 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAZLSN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Jan 2019 06:18:13 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so10466272lja.9
        for <linux-block@vger.kernel.org>; Sat, 26 Jan 2019 03:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBf8mCljPcuuQJqeZgCSw+mqZ3t1Yc27xPSCyO+nKRQ=;
        b=qpK9vMtM1ojnqbH2ODq+dBBOODTVMucixyupyao6rpHcVsU2spFTJbNMq3QCFCQZ33
         K2oTGFJasmR6fUzDezGI9DBNnAe9PKGMqjpeAeY5lF79JMo7La+4i8A0OOxf8Mgpb2kz
         rBMQAQooiBb2UTN+DtZ6giz3+evPyE54fuHnEVoEopHHJSweuDXbvkAYjAB0/k6PwW9D
         iohgFdZ4oE+wNDcIgLSvhQNV2yLawLAFzl8eslfYFFCk0XkV0QnlilxSIArrC1vR2ep4
         zlx9hjhj0PSZYHoX61vNasDHPqAbp7PJXTm15xrWxZvRzuvsU3oYj1M5vJmDQgXFzMNk
         fS/Q==
X-Gm-Message-State: AHQUAuaN4Go+rtl5lSbYGu3b4cp17cjZpa6A4j2HgGqrAV5zmCnKii9T
        WVcSitcNZNW9flTRvRKbOVlED1GudepT5zkcfCzBQQ==
X-Google-Smtp-Source: ALg8bN4P9elZGeBmPmCX7m3ismpbyZFRqXfjHeRxgiHmCOfYJ7WODF8KzPhPetTdLxdgXEgK/JGvhsbrVigTaWnsPnQ=
X-Received: by 2002:a2e:9e95:: with SMTP id f21-v6mr3316918ljk.128.1548501489911;
 Sat, 26 Jan 2019 03:18:09 -0800 (PST)
MIME-Version: 1.0
References: <20190125021107.4595-1-zhangxiaoxu5@huawei.com>
In-Reply-To: <20190125021107.4595-1-zhangxiaoxu5@huawei.com>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Sat, 26 Jan 2019 12:17:57 +0100
Message-ID: <CAMeeMh_=UVGwo-=9WtBXRmiHTXnLAswqis97bM-aiuwnzPU0QQ@mail.gmail.com>
Subject: Re: [dm-devel] [v2] block: Fix a WRITE SAME BUG_ON
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi. I have read a bit of DM code and spent an hour reviewing this... I
didn't get to the point of knowing what the right fix for the problem
is, and I may have a wrong understanding, but I have two thoughts
about the patch:

I don't think this is the right solution for two reasons:

In the first place, if it's an LVM-only issue, we should fix it only
for device-mapper devices. If this is the right way to fix it,
possibly the way to do that would be to change DM calls to
blk_queue_max_write_same_sectors() to only set the max sectors to more
than 0 if and only if the logical block sizes match.

In the second place, I don't think this is the problem. The line of
code that's calling BUG_ON is, I think,
BUG_ON(bio_offset(bio) || bio_iovec(bio).bv_len != sdp->sector_size);

This is because write_same bios are supposed to have a single sector
of data at the beginning of a page in their bio_iovec(bio) [I think,
based on a commit message I've read] -- in other words, bio_iovec(bio)
is supposed to say something like { .page = something, .offset = 0,
.len = 1 native sector }. But clearly, since the BUG_ON is being
called, one of these is not true. Have you added a log statement right
before the BUG_ON() to print out bio_offset(bio) and
bio_iovec(bio).bv_len to see which value defies expectations?

I would be happy to help you trace through this or attempt to
reproduce it myself -- what stack of devices can you reproduce this
on? Is this a dm-linear device on top of a disk? Does it have a
filesystem on top, and if so, what filesystem?

Thank you!

John Dorminy


On Fri, Jan 25, 2019 at 9:53 AM Zhang Xiaoxu <zhangxiaoxu5@huawei.com> wrote:
>
> If the lvm is stacked by different logical_block_size disks,
> when WRITE SAME on it, will bug_on:
>
> kernel BUG at drivers/scsi/sd.c:968!
> invalid opcode: 0000 [#1] SMP PTI
> CPU: 11 PID: 525 Comm: kworker/11:1H Tainted: G           O      5.0.0-rc3+ #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-2.fc27 04/01/2014
> Workqueue: kblockd blk_mq_run_work_fn
> RIP: 0010:sd_init_command+0x7aa/0xdb0
> Code: 30 75 00 00 c7 85 44 01 00 00 18 00 00 00 0f 85 fa 04 00 00 48 83 c4 40 48
>       89 df 5b 5d 41 5c 41 5d 41 5e 41 5f e9 b6 ca fe ff <0f> 0b 41 bc 09
> RSP: 0018:ffffb55f80ddbca0 EFLAGS: 00010206
> RAX: 0000000000001000 RBX: ffff9ed23fb927a0 RCX: 000000000000f000
> RDX: ffff9ed23f0a8400 RSI: ffff9ed27bc79800 RDI: 0000000000000000
> RBP: ffff9ed23fb92680 R08: ffff9ed27c8c0000 R09: ffff9ed23fb927d8
> R10: 0000000000000000 R11: fefefefefefefeff R12: ffff9ed27bc79800
> R13: ffff9ed2787a0000 R14: ffff9ed27bdf3400 R15: ffff9ed23fb927a0
> FS:  0000000000000000(0000) GS:ffff9ed27c8c0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6b14cf9341 CR3: 0000000069058000 CR4: 00000000000006e0
> Call Trace:
>  ? vp_notify+0x12/0x20
>  scsi_queue_rq+0x525/0xa30
>  blk_mq_dispatch_rq_list+0x8d/0x580
>  ? syscall_return_via_sysret+0x10/0x7f
>  ? elv_rb_del+0x1f/0x30
>  ? deadline_remove_request+0x55/0xc0
>  blk_mq_do_dispatch_sched+0x76/0x110
>  blk_mq_sched_dispatch_requests+0xf9/0x170
>  __blk_mq_run_hw_queue+0x51/0xd0
>  process_one_work+0x195/0x380
>  worker_thread+0x30/0x390
>  ? process_one_work+0x380/0x380
>  kthread+0x113/0x130
>  ? kthread_park+0x90/0x90
>  ret_from_fork+0x35/0x40
> Modules linked in: alloc(O+)
> ---[ end trace dc92ddeb2e6d1fe5 ]---
>
> The logical_block_size of the LVM is the max value of the sub disks,
> it maybe different with one of the sub disk. when WRITE SAME on the
> disk, it will BUG_ON when setup WRITE SAME cmd.
>
> Close WRITE_SAME feature on the LVM if it was stacked by different
> logical_block_size disk.
>
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> ---
>  block/blk-settings.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 3e7038e475ee..e4664280edb4 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -497,8 +497,6 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>         t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
>         t->max_hw_sectors = min_not_zero(t->max_hw_sectors, b->max_hw_sectors);
>         t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
> -       t->max_write_same_sectors = min(t->max_write_same_sectors,
> -                                       b->max_write_same_sectors);
>         t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
>                                         b->max_write_zeroes_sectors);
>         t->bounce_pfn = min_not_zero(t->bounce_pfn, b->bounce_pfn);
> @@ -537,6 +535,14 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>                 }
>         }
>
> +       /* If the logical block size is different, forbid write same */
> +       if (t->logical_block_size != b->logical_block_size &&
> +           t->max_write_same_sectors != UINT_MAX)
> +               t->max_write_same_sectors = 0;
> +       else
> +               t->max_write_same_sectors = min(t->max_write_same_sectors,
> +                                               b->max_write_same_sectors);
> +
>         t->logical_block_size = max(t->logical_block_size,
>                                     b->logical_block_size);
>
> --
> 2.14.4
>
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel
