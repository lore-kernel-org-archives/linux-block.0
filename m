Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA7BC433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 07:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2ADF60F3A
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 07:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbhIOHdW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 03:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhIOHdW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 03:33:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB15C061574;
        Wed, 15 Sep 2021 00:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EWvc+q9s1X7xJOMLCiV8ECkEXtDe5FQ0U3D7Zlj18qg=; b=enAQlBdJgwtG7Zlgh7SXmTWZKK
        RLlwrNTTyJjUB85LBACpvf45Mj/sTBD0uIn29bFznTlLH1Ld8p5RMKWHfDJo/UkzucWlqOezhmkGi
        gCqU+B3S3YlxZp/K4aREfdwrbmnpSVPIWCebR4evFzRrBnVNAGGHfpoD6wIucs72mduM3z6gFciR9
        FEHmTOlnPzcYGV7Hm/5lQcD3Hx9X3uPbUZoStV3qsjB8T+0BvfJjbhex7pG03J587ZXo5Ki6HCDtB
        2crYeD7XOg9574c5ZuEwjnGh0uqTI2/38JxLjQh7GLD+Abbzaf5N1ex8B2jB+Nku9IIYuuLm04eZg
        rjo7Owmw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQPMX-00FSj6-ML; Wed, 15 Sep 2021 07:30:07 +0000
Date:   Wed, 15 Sep 2021 08:29:45 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: general protection fault in wb_timer_fn
Message-ID: <YUGg6aVAPKoYZ+8V@infradead.org>
References: <CACkBjsZxsm=91sf-ihJgEtx7tmBJr-yTrPbrvg6tP-_J4pGdGw@mail.gmail.com>
 <YUB9Pn4CrqYu7TMC@infradead.org>
 <CACkBjsYwLYLRmX8GpsDpMthagWOjWWrNxqY6ZLNQVr6yx+f5vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACkBjsYwLYLRmX8GpsDpMthagWOjWWrNxqY6ZLNQVr6yx+f5vA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 15, 2021 at 09:49:49AM +0800, Hao Sun wrote:
> console output: https://paste.ubuntu.com/p/5qHqPXWmCQ/
> kernel config: https://paste.ubuntu.com/p/VsVbFh9ZpQ/
> C reproducer: https://paste.ubuntu.com/p/yrYsn4zpcn/
> Syzlang reproducer: https://paste.ubuntu.com/p/bCWyNyHncJ/
> 
> Just tried the C reproducer on the latest Linux kernel (6880fa6c5660
> Linux 5.15-rc1).
> The reproducer still crashed the kernel but with a different backtrace.

Well, that trace looks very much like an issue in the MM truncate code.
Adding the linux-mm list.

> 
> IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): wlan1: link becomes ready
> Bluetooth: hci0: command 0x0409 tx timeout
> ------------[ cut here ]------------
> kernel BUG at fs/buffer.c:1510!
> invalid opcode: 0000 [#1] PREEMPT SMP
> CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.14.0+ #15
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> Workqueue: events delayed_fput
> RIP: 0010:block_invalidatepage+0x27f/0x2a0 -origin/fs/buffer.c:1510
> Code: ff ff e8 b4 07 d7 ff b9 02 00 00 00 be 02 00 00 00 4c 89 ff 48
> c7 c2 40 4e 25 84 e8 2b c2 c4 02 e9 c9 fe ff ff e8 91 07 d7 ff <0f> 0b
> e8 8a 07 d7 ff 0f 0b e8 83 07 d7 ff 48 8d 5d ff e9 57 ff ff
> RSP: 0018:ffffc9000065bb60 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffea0000670000 RCX: 0000000000000000
> RDX: ffff8880097fa240 RSI: ffffffff81608a9f RDI: ffffea0000670000
> RBP: ffffea0000670000 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffc9000065b9f8 R11: 0000000000000003 R12: ffffffff81608820
> R13: ffffc9000065bc68 R14: 0000000000000000 R15: ffffc9000065bbf0
> FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4aef93fb08 CR3: 0000000108cf2000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  do_invalidatepage -origin/mm/truncate.c:157 [inline]
>  truncate_cleanup_page+0x15c/0x280 -origin/mm/truncate.c:176
>  truncate_inode_pages_range+0x169/0xc30 -origin/mm/truncate.c:325
>  kill_bdev.isra.29+0x28/0x30
>  blkdev_flush_mapping+0x4c/0x130 -origin/block/bdev.c:658
>  blkdev_put_whole+0x54/0x60 -origin/block/bdev.c:689
>  blkdev_put+0x6f/0x210 -origin/block/bdev.c:953
>  blkdev_close+0x25/0x30 -origin/block/fops.c:459
>  __fput+0xdf/0x380 -origin/fs/file_table.c:280
>  delayed_fput+0x25/0x40 -origin/fs/file_table.c:308
>  process_one_work+0x359/0x850 -origin/kernel/workqueue.c:2297
>  worker_thread+0x41/0x4d0 -origin/kernel/workqueue.c:2444
>  kthread+0x178/0x1b0 -origin/kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30 -origin/arch/x86/entry/entry_64.S:295
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace 9dbb8f58f2109f10 ]---
> RIP: 0010:block_invalidatepage+0x27f/0x2a0 -origin/fs/buffer.c:1510
> Code: ff ff e8 b4 07 d7 ff b9 02 00 00 00 be 02 00 00 00 4c 89 ff 48
> c7 c2 40 4e 25 84 e8 2b c2 c4 02 e9 c9 fe ff ff e8 91 07 d7 ff <0f> 0b
> e8 8a 07 d7 ff 0f 0b e8 83 07 d7 ff 48 8d 5d ff e9 57 ff ff
> RSP: 0018:ffffc9000065bb60 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffea0000670000 RCX: 0000000000000000
> RDX: ffff8880097fa240 RSI: ffffffff81608a9f RDI: ffffea0000670000
> RBP: ffffea0000670000 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffc9000065b9f8 R11: 0000000000000003 R12: ffffffff81608820
> R13: ffffc9000065bc68 R14: 0000000000000000 R15: ffffc9000065bbf0
> FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff98674f000 CR3: 0000000106b2e000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
---end quoted text---
