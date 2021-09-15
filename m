Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0BBC433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 19:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7A861056
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 19:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhIOTn7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 15:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhIOTn7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 15:43:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E27C061574;
        Wed, 15 Sep 2021 12:42:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v22so3523105edd.11;
        Wed, 15 Sep 2021 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uw13fa7UPrscT+hp1Xeoi9cyf+BNE2EOet5zGwMHioI=;
        b=pAZ4I+JbBGP0q8CR3B0DJFJYk9OKkqPtDYgaWjDuZqUFo9PosGyMUA9DUqeFAS4U7t
         vXeKj/QVIH2YbcALd0dmVRZUMXOUTctX5xM7JfyeH018FbYpYgbqAsr6YKYbofTe2eas
         qnUkMHr52lARw6SXMF5VQbT8LGTpvZ1FxJtqxpIPUwk/oiVdBkBvGGfpQ5MkS+Ijo0eR
         kf6fhNOSAzvvKh8z9fJcKGPBJQOnYAEbWi1PQg5OU/wxh9BaRsmnLX+N7I/bw+KAmMYH
         mZwzMazJ+/z+7L7yl6qo04XqsoIXW993qqPfKdQGIZRFTtwT2RHJAacr8xOQHDRmiez6
         1mXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uw13fa7UPrscT+hp1Xeoi9cyf+BNE2EOet5zGwMHioI=;
        b=LBf7dRe0SS3xNBQkqikFLNA/m8mmED+mpVUvwlS76BzhTy9Gz/7bXu19yuGdyNuGKP
         pRnRlZ7vUrpsGfXoL9mwsyc8cu42BoAXCSW9AYHKdMH0v+wRwhxfxBKe43uPoRwdrpUU
         HbVQn75KwNcdkTMlXd3yDqfiwkDUrD6rVsOBT8npQV8B6fYE8nCijkkol118xJAPIA8n
         BslK7DmwVIwLlZaOFYfz9rz+J76I2vOmcb1V1bDjYT/PIX1K5DHSOzikxCOFMK7RTZR6
         aDKYO8JioHIXIVBlmxBfPhzb0v3TU3AYdeqhtnfc3sownulwBzQEOqAKOGVLYwOI47CP
         G4gg==
X-Gm-Message-State: AOAM531hcTig9UnAmot+ANBK9Zry54o5WtUbpICNU/RbeKVayKY9xrsX
        hy8Ko9d0+5kWST+i6Vh86N8qdW0v4dts0a/Xa6A=
X-Google-Smtp-Source: ABdhPJxa05SSTZEJszHSAxzMlgCguILIh6H6Tn47tnK76rBCqWwl//b8i1Bddai/L40Va4CpERC/3VkqEYrwBPupY3o=
X-Received: by 2002:aa7:c80d:: with SMTP id a13mr1817821edt.71.1631734958661;
 Wed, 15 Sep 2021 12:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsZxsm=91sf-ihJgEtx7tmBJr-yTrPbrvg6tP-_J4pGdGw@mail.gmail.com>
 <YUB9Pn4CrqYu7TMC@infradead.org> <CACkBjsYwLYLRmX8GpsDpMthagWOjWWrNxqY6ZLNQVr6yx+f5vA@mail.gmail.com>
 <YUGg6aVAPKoYZ+8V@infradead.org>
In-Reply-To: <YUGg6aVAPKoYZ+8V@infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Sep 2021 12:42:26 -0700
Message-ID: <CAHbLzkp7hyNa58ghiPy2MQCLLG-oXp=_syP8vvFkWK1SviJuPw@mail.gmail.com>
Subject: Re: general protection fault in wb_timer_fn
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Hao Sun <sunhao.th@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 15, 2021 at 12:34 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Sep 15, 2021 at 09:49:49AM +0800, Hao Sun wrote:
> > console output: https://paste.ubuntu.com/p/5qHqPXWmCQ/
> > kernel config: https://paste.ubuntu.com/p/VsVbFh9ZpQ/
> > C reproducer: https://paste.ubuntu.com/p/yrYsn4zpcn/
> > Syzlang reproducer: https://paste.ubuntu.com/p/bCWyNyHncJ/
> >
> > Just tried the C reproducer on the latest Linux kernel (6880fa6c5660
> > Linux 5.15-rc1).
> > The reproducer still crashed the kernel but with a different backtrace.
>
> Well, that trace looks very much like an issue in the MM truncate code.
> Adding the linux-mm list.

The BUG is triggered if it tries to invalidate across pages. But it
hardcoded PAGE_SIZE. The offset passed in by truncate_cleanup_page()
is 0, but the length might be > PAGE_SIZE if it is a compound page. It
might be caused by READ_ONLY_THP_FOR_FS.

Could you please try the below debug patch to dump page details? I saw
your kernel config has DEBUG_VM enabled.

diff --git a/fs/buffer.c b/fs/buffer.c
index ab7573d72dd7..ed7256112c2b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1507,7 +1507,8 @@ void block_invalidatepage(struct page *page,
unsigned int offset,
        /*
         * Check for overflow
         */
-       BUG_ON(stop > PAGE_SIZE || stop < length);
+       VM_BUG_ON_PAGE((stop > PAGE_SIZE), page);
+       VM_BUG_ON_PAGE((stop < length), page);

        head = page_buffers(page);
        bh = head;

If my speculation is correct, I think the below patch should be able
to fix this issue.

diff --git a/fs/buffer.c b/fs/buffer.c
index ab7573d72dd7..18428cee59af 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1507,7 +1507,7 @@ void block_invalidatepage(struct page *page,
unsigned int offset,
        /*
         * Check for overflow
         */
-       BUG_ON(stop > PAGE_SIZE || stop < length);
+       BUG_ON(stop > thp_size(page) || stop < length);

        head = page_buffers(page);
        bh = head;

>
> >
> > IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> > IPv6: ADDRCONF(NETDEV_CHANGE): wlan1: link becomes ready
> > Bluetooth: hci0: command 0x0409 tx timeout
> > ------------[ cut here ]------------
> > kernel BUG at fs/buffer.c:1510!
> > invalid opcode: 0000 [#1] PREEMPT SMP
> > CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.14.0+ #15
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > Workqueue: events delayed_fput
> > RIP: 0010:block_invalidatepage+0x27f/0x2a0 -origin/fs/buffer.c:1510
> > Code: ff ff e8 b4 07 d7 ff b9 02 00 00 00 be 02 00 00 00 4c 89 ff 48
> > c7 c2 40 4e 25 84 e8 2b c2 c4 02 e9 c9 fe ff ff e8 91 07 d7 ff <0f> 0b
> > e8 8a 07 d7 ff 0f 0b e8 83 07 d7 ff 48 8d 5d ff e9 57 ff ff
> > RSP: 0018:ffffc9000065bb60 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: ffffea0000670000 RCX: 0000000000000000
> > RDX: ffff8880097fa240 RSI: ffffffff81608a9f RDI: ffffea0000670000
> > RBP: ffffea0000670000 R08: 0000000000000001 R09: 0000000000000000
> > R10: ffffc9000065b9f8 R11: 0000000000000003 R12: ffffffff81608820
> > R13: ffffc9000065bc68 R14: 0000000000000000 R15: ffffc9000065bbf0
> > FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f4aef93fb08 CR3: 0000000108cf2000 CR4: 0000000000750ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > PKRU: 55555554
> > Call Trace:
> >  do_invalidatepage -origin/mm/truncate.c:157 [inline]
> >  truncate_cleanup_page+0x15c/0x280 -origin/mm/truncate.c:176
> >  truncate_inode_pages_range+0x169/0xc30 -origin/mm/truncate.c:325
> >  kill_bdev.isra.29+0x28/0x30
> >  blkdev_flush_mapping+0x4c/0x130 -origin/block/bdev.c:658
> >  blkdev_put_whole+0x54/0x60 -origin/block/bdev.c:689
> >  blkdev_put+0x6f/0x210 -origin/block/bdev.c:953
> >  blkdev_close+0x25/0x30 -origin/block/fops.c:459
> >  __fput+0xdf/0x380 -origin/fs/file_table.c:280
> >  delayed_fput+0x25/0x40 -origin/fs/file_table.c:308
> >  process_one_work+0x359/0x850 -origin/kernel/workqueue.c:2297
> >  worker_thread+0x41/0x4d0 -origin/kernel/workqueue.c:2444
> >  kthread+0x178/0x1b0 -origin/kernel/kthread.c:319
> >  ret_from_fork+0x1f/0x30 -origin/arch/x86/entry/entry_64.S:295
> > Modules linked in:
> > Dumping ftrace buffer:
> >    (ftrace buffer empty)
> > ---[ end trace 9dbb8f58f2109f10 ]---
> > RIP: 0010:block_invalidatepage+0x27f/0x2a0 -origin/fs/buffer.c:1510
> > Code: ff ff e8 b4 07 d7 ff b9 02 00 00 00 be 02 00 00 00 4c 89 ff 48
> > c7 c2 40 4e 25 84 e8 2b c2 c4 02 e9 c9 fe ff ff e8 91 07 d7 ff <0f> 0b
> > e8 8a 07 d7 ff 0f 0b e8 83 07 d7 ff 48 8d 5d ff e9 57 ff ff
> > RSP: 0018:ffffc9000065bb60 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: ffffea0000670000 RCX: 0000000000000000
> > RDX: ffff8880097fa240 RSI: ffffffff81608a9f RDI: ffffea0000670000
> > RBP: ffffea0000670000 R08: 0000000000000001 R09: 0000000000000000
> > R10: ffffc9000065b9f8 R11: 0000000000000003 R12: ffffffff81608820
> > R13: ffffc9000065bc68 R14: 0000000000000000 R15: ffffc9000065bbf0
> > FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007ff98674f000 CR3: 0000000106b2e000 CR4: 0000000000750ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > PKRU: 55555554
> ---end quoted text---
