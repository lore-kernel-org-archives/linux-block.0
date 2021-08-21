Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D301DC4338F
	for <linux-block@archiver.kernel.org>; Sat, 21 Aug 2021 07:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39C660E93
	for <linux-block@archiver.kernel.org>; Sat, 21 Aug 2021 07:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhHUHs5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Aug 2021 03:48:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232195AbhHUHsz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Aug 2021 03:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629532096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EeUhPgKQkrozlr2RNO/SOJCvPJI+D/541J+Hmw4ZTKo=;
        b=BKbznkA4Q+bD25A0YmT6gfek1A84am5I5Qy72AhMAjZmoGiPwiToAtAFg1or/yer1si6xh
        ZR6BrLkF2J+t5AaPdlPnt55EPb6iAEmaR+5RWjZHgqxS0GyOxM0nVXvlJ9QVUH/VVnYrQi
        yIENYzJGH+8A8muWp8R+EffzVmNALZY=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-9K2aRQlDPkyA-OlDR1V1jw-1; Sat, 21 Aug 2021 03:48:14 -0400
X-MC-Unique: 9K2aRQlDPkyA-OlDR1V1jw-1
Received: by mail-yb1-f199.google.com with SMTP id f64-20020a2538430000b0290593bfc4b046so11835714yba.9
        for <linux-block@vger.kernel.org>; Sat, 21 Aug 2021 00:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EeUhPgKQkrozlr2RNO/SOJCvPJI+D/541J+Hmw4ZTKo=;
        b=C6fw30AYsVSuguF0ay6JzfqZ46/JOv3a0GSce3kh58A2L/hQqeHAiIFRdEP47IoTe5
         vGGNNaW5RwD0TVm3ftAqaBNDxWXM/VkgY2ZV7M4th/FDTFClvPFvglH2LxJo0docc/Cc
         9lhMeDYhi+oHbDOnaStJBsqtEX350ck46iav1eMbmCXUwasi33flZl525MjDC+3Ky9Cq
         42YwOGX5TPKpgijIdV/4UHb2npTn/DZG5d0vgFmAlsFL19bUvxCL97+a9WhdgvvUANON
         HFjWFf0jyIW1JKNqFa2tvlDIUg4dNgMuozWZD+HjfSJ9qxdcvsxm5oOmsSXQArKxBf1L
         yuDQ==
X-Gm-Message-State: AOAM530PHyAn8Na0a4Yo/4BjLbOZbBoYtiJ6KLuM27dCBUaGss9tX01c
        lGrzLS2osqMTU8xtSfxo/YHFRGVMKjr4KdFZLU91HAz3kA6n3/E1v0GMC3clUnZuE2wwPE9cnLa
        7x8gITLzgIf/08QGEqZQGb/wSRkGsbvHorty5n3E=
X-Received: by 2002:a25:4d1:: with SMTP id 200mr30174279ybe.438.1629532093731;
        Sat, 21 Aug 2021 00:48:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZL9VYzLa3LEyke2XETabdxfctprYRnfeyeOp3C9z7iD0cxFH83opbKW2LgQqh8cUJtLGWzK6RLyRMN6Tk2zQ=
X-Received: by 2002:a25:4d1:: with SMTP id 200mr30174264ybe.438.1629532093498;
 Sat, 21 Aug 2021 00:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000072e53a05c983ab22@google.com> <20210816091041.3313-1-hdanton@sina.com>
 <20210816093336.GA3950@lst.de> <yt9dim01iz69.fsf@linux.ibm.com>
 <20210819090510.GA12194@lst.de> <yt9dr1eph96a.fsf@linux.ibm.com> <20210819135308.GB3395@lst.de>
In-Reply-To: <20210819135308.GB3395@lst.de>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sat, 21 Aug 2021 15:48:01 +0800
Message-ID: <CAHj4cs-S7sTEMZ=zSreW5_PgQQVxvf-4netHy-paPR2kfY=-hQ@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in wb_timer_fn
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+aa0801b6b32dca9dda82@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 19, 2021 at 9:53 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Aug 19, 2021 at 03:10:37PM +0200, Sven Schnelle wrote:
> > Christoph Hellwig <hch@lst.de> writes:
> >
> > > On Thu, Aug 19, 2021 at 11:03:42AM +0200, Sven Schnelle wrote:
> > >> I'm seeing a similar crash in our CI:
> > >
> > > This series:
> > >
> > > https://lore.kernel.org/linux-block/20210816131910.615153-1-hch@lst.de/T/#t
> > >
> > > should fi it.  Can you give it a spin?
> >
> > I tested it without your patchset and it crashed around every second
> > try. With that patchset, i wasn't able to reproduce it.
>
> Can you send a Tested-by: for the last patch which should fix this?
>
Hi Christoph

I also met similar issue with blktests, I tried to apply the patchset
but with no luck to apply them, any suggestions to fix it.

[ 2464.154898] run blktests nvme/012 at 2021-08-20 21:20:29
[ 2464.192252] loop0: detected capacity change from 0 to 2097152
[ 2464.309275] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 2464.396464] nvmet: creating controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:a43453b4c0df4cb7bd2303f547ca0f22.
[ 2464.410162] nvme nvme0: creating 128 I/O queues.
[ 2464.425839] nvme nvme0: new ctrl: "blktests-subsystem-1"
[ 2465.483434] XFS (nvme0n1): Mounting V5 Filesystem
[ 2465.493142] XFS (nvme0n1): Ending clean mount
[ 2465.498278] xfs filesystem being mounted at /mnt/blktests supports
timestamps until 2038 (0x7fffffff)
[ 2488.544383] XFS (nvme0n1): Unmounting Filesystem
[ 2488.559652] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[ 2488.625086] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000308
[ 2488.633871] Mem abort info:
[ 2488.636655]   ESR = 0x96000004
[ 2488.639698]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 2488.645000]   SET = 0, FnV = 0
[ 2488.648044]   EA = 0, S1PTW = 0
[ 2488.651173]   FSC = 0x04: level 0 translation fault
[ 2488.656039] Data abort info:
[ 2488.658908]   ISV = 0, ISS = 0x00000004
[ 2488.662732]   CM = 0, WnR = 0
[ 2488.665689] user pgtable: 4k pages, 48-bit VAs, pgdp=00000008fd3a0000
[ 2488.672119] [0000000000000308] pgd=0000000000000000, p4d=0000000000000000
[ 2488.678903] Internal error: Oops: 96000004 [#1] SMP
[ 2488.683770] Modules linked in: nvme_loop nvme_fabrics nvmet
nvme_core loop dm_log_writes dm_flakey rfkill mlx5_ib ib_uverbs
ib_core sunrpc coresight_etm4x i2c_smbus coresight_tpiu
coresight_replicator coresight_tmc joydev mlx5_core mlxfw psample tls
acpi_ipmi ipmi_ssif ipmi_devintf ipmi_msghandler coresight_funnel
coresight thunderx2_pmu vfat fat fuse zram ip_tables xfs crct10dif_ce
ast ghash_ce i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm gpio_xlp
i2c_xlp9xx uas usb_storage aes_neon_bs [last unloaded: nvme_core]
[ 2488.735491] CPU: 41 PID: 0 Comm: swapper/41 Not tainted 5.14.0-rc5 #1
[ 2488.751647] pstate: 20400009 (nzCv daif +PAN -UAO -TCO BTYPE=--)
[ 2488.757641] pc : latency_exceeded+0x30/0x304
[ 2488.761905] lr : wb_timer_fn+0x48/0x1fc
[ 2488.765730] sp : ffff800012b83d00
[ 2488.769031] x29: ffff800012b83d00 x28: ffff800011dc7000 x27: ffff800012b83e80
[ 2488.776156] x26: ffff800011886000 x25: 00000000000000e0 x24: 0000000000000028
[ 2488.783280] x23: ffffffffffffffff x22: ffff0008097ac900 x21: ffff0008097ade80
[ 2488.790404] x20: 0000000000000000 x19: ffff00080adfb300 x18: 0000000000000000
[ 2488.797528] x17: ffff800f4ac9a000 x16: ffff800012b84000 x15: 0000000000004000
[ 2488.804652] x14: 0000000000000000 x13: 0000000000000038 x12: 0000000000000040
[ 2488.811776] x11: 0000000000036e09 x10: ffff0008097ade80 x9 : ffff80001073074c
[ 2488.818901] x8 : fffffbffec7ec0b0 x7 : 000000000000003f x6 : 0000000000000000
[ 2488.826024] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[ 2488.833148] x2 : 0000000000000000 x1 : ffff0008097ade80 x0 : 0000000000000000
[ 2488.840273] Call trace:
[ 2488.842707]  latency_exceeded+0x30/0x304
[ 2488.846618]  wb_timer_fn+0x48/0x1fc
[ 2488.850095]  blk_stat_timer_fn+0x170/0x190
[ 2488.854183]  call_timer_fn+0x3c/0x17c
[ 2488.857835]  __run_timers.part.0+0x290/0x330
[ 2488.862092]  run_timer_softirq+0x48/0x80
[ 2488.866002]  __do_softirq+0x128/0x380
[ 2488.869653]  __irq_exit_rcu+0x154/0x160
[ 2488.873482]  irq_exit+0x1c/0x30
[ 2488.876612]  handle_domain_irq+0x70/0x9c
[ 2488.880525]  gic_handle_irq+0x58/0xd8
[ 2488.884174]  call_on_irq_stack+0x2c/0x38
[ 2488.888086]  do_interrupt_handler+0x5c/0x70
[ 2488.892257]  el1_interrupt+0x30/0x50
[ 2488.895824]  el1h_64_irq_handler+0x18/0x24
[ 2488.899908]  el1h_64_irq+0x7c/0x80
[ 2488.903297]  arch_cpu_idle+0x18/0x2c
[ 2488.906861]  default_idle_call+0x4c/0x160
[ 2488.910860]  cpuidle_idle_call+0x14c/0x1a0
[ 2488.914947]  do_idle+0xbc/0x110
[ 2488.918077]  cpu_startup_entry+0x30/0x8c
[ 2488.921988]  secondary_start_kernel+0xec/0x110
[ 2488.926422]  __secondary_switched+0x94/0x98
[ 2488.930596] Code: aa0103f5 f9403000 f9401674 f9404800 (f9418400)
[ 2488.936789] ---[ end trace 8d092c5fdd268b3c ]---
[ 2488.941394] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[ 2488.948283] SMP: stopping secondary CPUs
[ 2488.952240] Kernel Offset: disabled
[ 2488.955715] CPU features: 0x00600051,a3200840
[ 2488.960059] Memory Limit: none
[ 2488.963125] ---[ end Kernel panic - not syncing: Oops: Fatal
exception in interrupt ]---

-- 
Best Regards,
  Yi Zhang

