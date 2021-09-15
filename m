Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C86BC433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 01:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471C960FBF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 01:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhIOBvU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 21:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhIOBvT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 21:51:19 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D49C061574;
        Tue, 14 Sep 2021 18:50:01 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so3728911pjc.3;
        Tue, 14 Sep 2021 18:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0duRHFk7lUou2HJyFdnkXq9ZDnwKgf88dnSVoAia5cQ=;
        b=h7UHB1c5RiPAVdvLzyUqEyzHQyKvNQ8N5SIJYqo8r/ACiw+E0hVTpqhGzAifmalWUH
         mGcXC/E1F4nl3+i1fxYQuQRRjaVQAfekF6Dcz4SyqObNP2kGPWQGRwjqCGmgPcC/CtzW
         2RnGQ/Eem38Lp7Su/EcsHBqbpOQNcksg8yvMl4Q3lLWYLL2vLBheHJW2ykMmmzF5LW11
         xlcfoO/aA7Q5Xyk4D+NNatR0OPUmifDBnheBXW9ZjIG8NIGNJsTxrguBXahZvWedo1wZ
         gAnfKUn4uowFGhqkGreo9awcClDN0ZQOY53MoZPt+oqss9jQ5W7Aldk68w0OnAEVMlYX
         W/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0duRHFk7lUou2HJyFdnkXq9ZDnwKgf88dnSVoAia5cQ=;
        b=4LYuvSE9e4sNwD7rHSks+zzXkMx3gLQRa20sMbaBE4ilp0r+FxtkeMoprzK3XOi8Me
         6rzrPICNxebacDTh3qjVElHM32qJJYk8XesszWTPVuTGO0UqMC1MWKiHPNQsfp853NiY
         O66ulKmoF0zHtfN1xAJ+rp10k6D78f2iYIgc3VW9TSD4a8OK1Z4oi6nsO0zYTbPpf4Fu
         FN33SEXX9oFFdKu4ps1plYMHtPjBl4yoDSitP1K2JMFL5lkK/a/Z1oB7/3nexSOeKsLw
         9jql2PsQ4fS/bCX+LVS8i8kPfkBjIwJYqNFAidWj941dkaFRoRWt0UUCBcgdGTqH6Ef8
         3D1Q==
X-Gm-Message-State: AOAM533WSBlJ+budvLo6D2tMDjflXih2wmhZXy5BhzKMex9PnzTL3bj9
        tZnFKxj8SbwWu72fqmC8C0l2zu8GcsnLFYXJKA==
X-Google-Smtp-Source: ABdhPJwHC881s34EBZiNHIy8DrEYTyS/wk6mQKFICqKI08cP0+R7xMXJTyjuayfwp1a2sBcGlimf7YifmRYOdmcJpSc=
X-Received: by 2002:a17:90b:124c:: with SMTP id gx12mr5566671pjb.106.1631670600973;
 Tue, 14 Sep 2021 18:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsZxsm=91sf-ihJgEtx7tmBJr-yTrPbrvg6tP-_J4pGdGw@mail.gmail.com>
 <YUB9Pn4CrqYu7TMC@infradead.org>
In-Reply-To: <YUB9Pn4CrqYu7TMC@infradead.org>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 15 Sep 2021 09:49:49 +0800
Message-ID: <CACkBjsYwLYLRmX8GpsDpMthagWOjWWrNxqY6ZLNQVr6yx+f5vA@mail.gmail.com>
Subject: Re: general protection fault in wb_timer_fn
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2021=E5=B9=B49=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:46=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Sep 13, 2021 at 10:00:27AM +0800, Hao Sun wrote:
> > Hello,
> >
> > When using Healer to fuzz the latest Linux kernel, the following crash
> > was triggered.
> >
> > HEAD commit:  4b93c544e90e-thunderbolt: test: split up test cases
> > git tree: upstream
> > console output:
> > https://drive.google.com/file/d/1naN-5p-rFgKpHrshO_kQr5f_KlhvFGGU/view?=
usp=3Dsharing
> > kernel config: https://drive.google.com/file/d/1c0u2EeRDhRO-ZCxr9MP2VvA=
tJd6kfg-p/view?usp=3Dsharing
> > C reproducer: https://drive.google.com/file/d/19EDhssGw_V1oO2vWOPrgQqve=
0TdFSgvh/view?usp=3Dsharing
> > Syzlang reproducer:
> > https://drive.google.com/file/d/13EGCCoaMe9oitrQCfy44BkGVLbKKFP6X/view?=
usp=3Dsharing
>
> All these google drive links just lead me to badly localized error
> messages.  Can you upload these to a less broken hosting platform?

console output: https://paste.ubuntu.com/p/5qHqPXWmCQ/
kernel config: https://paste.ubuntu.com/p/VsVbFh9ZpQ/
C reproducer: https://paste.ubuntu.com/p/yrYsn4zpcn/
Syzlang reproducer: https://paste.ubuntu.com/p/bCWyNyHncJ/

Just tried the C reproducer on the latest Linux kernel (6880fa6c5660
Linux 5.15-rc1).
The reproducer still crashed the kernel but with a different backtrace.

IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): wlan1: link becomes ready
Bluetooth: hci0: command 0x0409 tx timeout
------------[ cut here ]------------
kernel BUG at fs/buffer.c:1510!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.14.0+ #15
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events delayed_fput
RIP: 0010:block_invalidatepage+0x27f/0x2a0 -origin/fs/buffer.c:1510
Code: ff ff e8 b4 07 d7 ff b9 02 00 00 00 be 02 00 00 00 4c 89 ff 48
c7 c2 40 4e 25 84 e8 2b c2 c4 02 e9 c9 fe ff ff e8 91 07 d7 ff <0f> 0b
e8 8a 07 d7 ff 0f 0b e8 83 07 d7 ff 48 8d 5d ff e9 57 ff ff
RSP: 0018:ffffc9000065bb60 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea0000670000 RCX: 0000000000000000
RDX: ffff8880097fa240 RSI: ffffffff81608a9f RDI: ffffea0000670000
RBP: ffffea0000670000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc9000065b9f8 R11: 0000000000000003 R12: ffffffff81608820
R13: ffffc9000065bc68 R14: 0000000000000000 R15: ffffc9000065bbf0
FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4aef93fb08 CR3: 0000000108cf2000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 do_invalidatepage -origin/mm/truncate.c:157 [inline]
 truncate_cleanup_page+0x15c/0x280 -origin/mm/truncate.c:176
 truncate_inode_pages_range+0x169/0xc30 -origin/mm/truncate.c:325
 kill_bdev.isra.29+0x28/0x30
 blkdev_flush_mapping+0x4c/0x130 -origin/block/bdev.c:658
 blkdev_put_whole+0x54/0x60 -origin/block/bdev.c:689
 blkdev_put+0x6f/0x210 -origin/block/bdev.c:953
 blkdev_close+0x25/0x30 -origin/block/fops.c:459
 __fput+0xdf/0x380 -origin/fs/file_table.c:280
 delayed_fput+0x25/0x40 -origin/fs/file_table.c:308
 process_one_work+0x359/0x850 -origin/kernel/workqueue.c:2297
 worker_thread+0x41/0x4d0 -origin/kernel/workqueue.c:2444
 kthread+0x178/0x1b0 -origin/kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 -origin/arch/x86/entry/entry_64.S:295
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 9dbb8f58f2109f10 ]---
RIP: 0010:block_invalidatepage+0x27f/0x2a0 -origin/fs/buffer.c:1510
Code: ff ff e8 b4 07 d7 ff b9 02 00 00 00 be 02 00 00 00 4c 89 ff 48
c7 c2 40 4e 25 84 e8 2b c2 c4 02 e9 c9 fe ff ff e8 91 07 d7 ff <0f> 0b
e8 8a 07 d7 ff 0f 0b e8 83 07 d7 ff 48 8d 5d ff e9 57 ff ff
RSP: 0018:ffffc9000065bb60 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea0000670000 RCX: 0000000000000000
RDX: ffff8880097fa240 RSI: ffffffff81608a9f RDI: ffffea0000670000
RBP: ffffea0000670000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc9000065b9f8 R11: 0000000000000003 R12: ffffffff81608820
R13: ffffc9000065bc68 R14: 0000000000000000 R15: ffffc9000065bbf0
FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff98674f000 CR3: 0000000106b2e000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
