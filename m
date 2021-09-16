Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C9DC433F5
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 10:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC88761212
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 10:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbhIPKst (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Sep 2021 06:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbhIPKsq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 06:48:46 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1B7C061574;
        Thu, 16 Sep 2021 03:47:26 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t1so5773832pgv.3;
        Thu, 16 Sep 2021 03:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YC9YYN4ZYlzqQeEAIPt4H6+3LrIiiG00V4GERK24HN8=;
        b=EXudBpudxdjE2aRI1Aiz+vZvRKpCpeCEp7mAvEdE+a9nJ5s4hejAldxo0AvmlYrVrL
         bWZh+7Vn1ryy7YuqPv7bfYzQYRscx3I2mzW3RAPBJ/F9e7opXp6yrDhYZem3uPkGgiqE
         ZNhPWq9LH4CbwjmEyksT3ICgyKguDwPmBa4CV81rCCt0iR4faKx/j6vweZSLhTLx52iu
         5o3chcJEbSDCkgCTJ3Qk5SX9wYOTeff/f1xY52LmL5flaCr25npik3BJR7cVbsvtg2B7
         wqRJDwFLEzJIrKSisAyexacHygqxeTmQyksZYh/K3pTMQB+xXTiC390BQ1RqUp34Ertk
         JxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YC9YYN4ZYlzqQeEAIPt4H6+3LrIiiG00V4GERK24HN8=;
        b=A0KzebCrbHpd1Kfu5iBAoZee7viE+c5gXMwGfiQ3jZ/43VElXGJ2BypEiyyqQo9JZn
         vxmknb96XzbYraX2g7/GXkAAU6vgTj5oUjZ0FGZG8hytrQA2l9lPz45EFc1rBdvTpoBm
         XGbrRX5CpAAYqiTR0AWJI0kJRpTWdIgWTCIjLewn/0r9iY4eUWlcomOu8b3Tjs75tAls
         N2k4PPnuA61et5LCezJpWC1JkRzRokUwMyBL5vCR417eDVahr2K59sPyz/GobMluQ7Gf
         Jc5z8GTWvdcGSmSdygk1OYL68MXtVdojlS/ZmzjsqERhM9ysyOyVKHtsNgc5zrdxfEOG
         j9Jw==
X-Gm-Message-State: AOAM532YXVeZzmpZ9HSbdKsAH9E8MHElYis9CrXKkN5BxrWI+vOtKEx8
        Ae01z8kgXRy2+fbvc1Pnq3mfylmTpFs3Ly58dg==
X-Google-Smtp-Source: ABdhPJyHwe9xgXRDr79PSt5a5uvpmT/aJwcMoLHSh6v+RpXkiC3rLZpIxDnkYPofhFDxm5SVul9nIo40weH6WKtq/vA=
X-Received: by 2002:a65:6389:: with SMTP id h9mr4382216pgv.83.1631789245670;
 Thu, 16 Sep 2021 03:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsZxsm=91sf-ihJgEtx7tmBJr-yTrPbrvg6tP-_J4pGdGw@mail.gmail.com>
 <YUB9Pn4CrqYu7TMC@infradead.org> <CACkBjsYwLYLRmX8GpsDpMthagWOjWWrNxqY6ZLNQVr6yx+f5vA@mail.gmail.com>
 <YUGg6aVAPKoYZ+8V@infradead.org> <CAHbLzkp7hyNa58ghiPy2MQCLLG-oXp=_syP8vvFkWK1SviJuPw@mail.gmail.com>
In-Reply-To: <CAHbLzkp7hyNa58ghiPy2MQCLLG-oXp=_syP8vvFkWK1SviJuPw@mail.gmail.com>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Thu, 16 Sep 2021 18:47:13 +0800
Message-ID: <CACkBjsZnemb=zGa83yhTj9v091kp6CZ_D39fGCn-uRTjteNw6A@mail.gmail.com>
Subject: Re: general protection fault in wb_timer_fn
To:     Yang Shi <shy828301@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> The BUG is triggered if it tries to invalidate across pages. But it
> hardcoded PAGE_SIZE. The offset passed in by truncate_cleanup_page()
> is 0, but the length might be > PAGE_SIZE if it is a compound page. It
> might be caused by READ_ONLY_THP_FOR_FS.
>
> Could you please try the below debug patch to dump page details? I saw
> your kernel config has DEBUG_VM enabled.
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index ab7573d72dd7..ed7256112c2b 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1507,7 +1507,8 @@ void block_invalidatepage(struct page *page,
> unsigned int offset,
>         /*
>          * Check for overflow
>          */
> -       BUG_ON(stop > PAGE_SIZE || stop < length);
> +       VM_BUG_ON_PAGE((stop > PAGE_SIZE), page);
> +       VM_BUG_ON_PAGE((stop < length), page);
>
>         head = page_buffers(page);
>         bh = head;
>

Just patched it.
The following log was printed after executing the C reproducer.

IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): wlan1: link becomes ready
Bluetooth: hci0: command 0x0409 tx timeout
Bluetooth: hci0: command 0x041b tx timeout
Bluetooth: hci0: command 0x040f tx timeout
Bluetooth: hci0: command 0x0419 tx timeout
page:ffffea00009c0000 refcount:514 mapcount:0 mapping:ffff8881060db7b0
index:0x0 pfn:0x27000
head:ffffea00009c0000 order:9 compound_mapcount:0 compound_pincount:0
memcg:ffff8880118bc000
aops:def_blk_aops ino:fa00000
flags: 0xfff00000012037(locked|referenced|uptodate|lru|active|private|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000012037 ffffea00009491c8 ffff888010c7d030 ffff8881060db7b0
raw: 0000000000000000 ffff888025d10658 00000202ffffffff ffff8880118bc000
page dumped because: VM_BUG_ON_PAGE((stop > ((1UL) << 12)))
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask
0x13c24ca(GFP_TRANSHUGE|__GFP_THISNODE), pid 35, ts 579054356699,
free_ts 543915753195
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook mm/page_alloc.c:2418 [inline]
 prep_new_page+0x1a5/0x240 mm/page_alloc.c:2424
 get_page_from_freelist+0x1f10/0x3b70 mm/page_alloc.c:4153
 __alloc_pages+0x306/0x6e0 mm/page_alloc.c:5375
 __alloc_pages_node include/linux/gfp.h:570 [inline]
 khugepaged_alloc_page+0xa0/0x170 mm/khugepaged.c:881
 collapse_file+0x20a/0x45f0 mm/khugepaged.c:1655
 khugepaged_scan_file mm/khugepaged.c:2051 [inline]
 khugepaged_scan_mm_slot mm/khugepaged.c:2146 [inline]
 khugepaged_do_scan mm/khugepaged.c:2230 [inline]
 khugepaged+0x2e65/0x5c50 mm/khugepaged.c:2275
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x412/0x900 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3315 [inline]
 free_unref_page+0x19/0x580 mm/page_alloc.c:3394
 release_pages+0x87f/0x2920 mm/swap.c:926
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu+0x8d/0x610 mm/mmu_gather.c:249
 tlb_finish_mmu+0x93/0x3c0 mm/mmu_gather.c:340
 unmap_region+0x27f/0x350 mm/mmap.c:2653
 __do_munmap+0xabc/0x11e0 mm/mmap.c:2884
 do_munmap mm/mmap.c:2895 [inline]
 munmap_vma_range mm/mmap.c:603 [inline]
 mmap_region+0x2c4/0x1340 mm/mmap.c:1742
 do_mmap+0x7f5/0xe60 mm/mmap.c:1575
 vm_mmap_pgoff+0x1b7/0x290 mm/util.c:519
 ksys_mmap_pgoff+0x49f/0x620 mm/mmap.c:1624
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
------------[ cut here ]------------
kernel BUG at fs/buffer.c:1511!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 2954 Comm: kworker/1:2 Not tainted 5.15.0-rc1+ #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: events delayed_fput
RIP: 0010:block_invalidatepage+0x599/0x680 fs/buffer.c:1511
Code: 0f 0b e8 9a 6b 9c ff 31 f6 4c 89 e7 e8 10 d7 bf ff e9 df fe ff
ff e8 86 6b 9c ff 48 c7 c6 00 4e 9a 89 4c 89 e7 e8 c7 16 d0 ff <0f> 0b
e8 70 6b 9c ff 48 c7 c6 60 4e 9a 89 4c 89 e7 e8 b1 16 d0 ff
RSP: 0018:ffffc9000e9078b8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888100bd9c80
RDX: 0000000000000000 RSI: ffff888100bd9c80 RDI: 0000000000000002
RBP: 0000000000000000 R08: ffffffff81d9e369 R09: 000000000000ffff
R10: 0000000000000003 R11: ffffed1026b83f53 R12: ffffea00009c0000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000200000
FS:  0000000000000000(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffde41e8960 CR3: 0000000019cef000 CR4: 0000000000350ee0
Call Trace:
 do_invalidatepage mm/truncate.c:157 [inline]
 truncate_cleanup_page+0x3e4/0x620 mm/truncate.c:176
 truncate_inode_pages_range+0x26c/0x1910 mm/truncate.c:325
 kill_bdev.isra.0+0x5f/0x80 block/bdev.c:77
 blkdev_flush_mapping+0xdf/0x2e0 block/bdev.c:658
 blkdev_put_whole+0xe8/0x110 block/bdev.c:689
 blkdev_put+0x23c/0x6f0 block/bdev.c:953
 blkdev_close+0x8d/0xb0 block/fops.c:459
 __fput+0x288/0x9f0 fs/file_table.c:280
 delayed_fput+0x56/0x70 fs/file_table.c:308
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2297
 worker_thread+0x90/0xed0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 77cfca54575c5255 ]---
RIP: 0010:block_invalidatepage+0x599/0x680 fs/buffer.c:1511
Code: 0f 0b e8 9a 6b 9c ff 31 f6 4c 89 e7 e8 10 d7 bf ff e9 df fe ff
ff e8 86 6b 9c ff 48 c7 c6 00 4e 9a 89 4c 89 e7 e8 c7 16 d0 ff <0f> 0b
e8 70 6b 9c ff 48 c7 c6 60 4e 9a 89 4c 89 e7 e8 b1 16 d0 ff
RSP: 0018:ffffc9000e9078b8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888100bd9c80
RDX: 0000000000000000 RSI: ffff888100bd9c80 RDI: 0000000000000002
RBP: 0000000000000000 R08: ffffffff81d9e369 R09: 000000000000ffff
R10: 0000000000000003 R11: ffffed1026b83f53 R12: ffffea00009c0000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000200000
FS:  0000000000000000(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f78dffb7ef8 CR3: 000000001f2ef000 CR4: 0000000000350ee0


> If my speculation is correct, I think the below patch should be able
> to fix this issue.
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index ab7573d72dd7..18428cee59af 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1507,7 +1507,7 @@ void block_invalidatepage(struct page *page,
> unsigned int offset,
>         /*
>          * Check for overflow
>          */
> -       BUG_ON(stop > PAGE_SIZE || stop < length);
> +       BUG_ON(stop > thp_size(page) || stop < length);
>
>         head = page_buffers(page);
>         bh = head;
>

Yes, the C reproducer can not crash the kernel anymore after patching
the above code.
