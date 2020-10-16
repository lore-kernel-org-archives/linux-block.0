Return-Path: <SRS0=I4RS=DX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4863EC433DF
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 06:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0F82080A
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 06:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRTYjG2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391475AbgJPGWB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Oct 2020 02:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391459AbgJPGWA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Oct 2020 02:22:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895EDC061755;
        Thu, 15 Oct 2020 23:22:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e18so1332160wrw.9;
        Thu, 15 Oct 2020 23:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=cY0yFgdnuLv7PriE3PiwgfGn5jgGpQByMetgMzjDRCw=;
        b=PRTYjG2cgr16sSp8Rimrd+wKfByfFU+9keg+/uIumjlTfV7+seYmo9j6r+zyiWKS+t
         A4SfQuq74OWsq7/D6yRc5V1xy6V+yJMQTopjOGN6SnkgcD5Fo4hQT9E6yqcK9MnW64Gq
         afmmsGjwWsjiY59odC6BzENP1aNLxdRwsnlhvviWl2KtiBLSRSCNldhDGZWuZMdr0t0m
         HhhhLahXX27U2Y1NH5ZORAuCso3CElem8pDk5CplLEssQR+NhFsc+86zuMhKZdGAIiry
         +oBXwiqEdJ3uGlVVBXVHCM2e59cKhVGaVX+I7x29KVn2F6zNEzNrHo64hzCWr4IAtw6a
         EhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cY0yFgdnuLv7PriE3PiwgfGn5jgGpQByMetgMzjDRCw=;
        b=K05hf4/JPWVeOhvma/GwQLhtipzTV1rHWxIZmljaTfGpPjwhWPm2vtbnxcbAaUe6ww
         KJazT4cXfBWybjFCK2Nf+ktJMwkEdEpnBATmGY2AAG3uUaSCMsxnZQl16zAxYu7mivdO
         6cJ/vyCoTLMROI494cGhX6vNE4F3sHT4qHBg03kZWFICmt6H4M0unpOwBdC5JHJ+ecQs
         7PI4EFwufi7l2a/9G08U7yvt8oJO52o4dAiDoGaIwfrrdjO6t/EeFmUNxznaGk8r3y/e
         rKTrL6uHoP6HS0sQwShpuXAjBLRtiVUlCEC8N9biLJT7II0PZAvjFOWvypyHGZXmg25J
         DrKQ==
X-Gm-Message-State: AOAM531IDXySauGRTrTq1jdAjw8KTSoDO3R5lejMjX1Kw9DSb5Z3V60/
        t8qSIhBgYCx6GSS2ViAisvsNoH3FJSBXBgvDXfmqFgWg6T9g+c4p
X-Google-Smtp-Source: ABdhPJwHa3wUtPI2ejpXyceSDmxJGEeEyqsLlPeDduW/sivgpUDhYDJ1gTt3JAgoF5dCoHp7NlaDPf4TtVA3sdAbYrA=
X-Received: by 2002:adf:e741:: with SMTP id c1mr2115658wrn.16.1602829318464;
 Thu, 15 Oct 2020 23:21:58 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 16 Oct 2020 11:21:47 +0500
Message-ID: <CABXGCsOL0pW0Ghh-w5d12P75ve6FS9Rgmzm6DvsYbJY-jMTCdg@mail.gmail.com>
Subject: swapon/913 is trying to acquire lock at zcomp_stream_get+0x5/0x90
 [zram] but task is already holding lock at zs_map_object+0x7a/0x2e0
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi folks,
today I joined to testing Kernel 5.10 and see that every boot happens
this warning:

[    9.032096] ======================================================
[    9.032097] WARNING: possible circular locking dependency detected
[    9.032098] 5.10.0-0.rc0.20201014gitb5fc7a89e58b.41.fc34.x86_64 #1
Not tainted
[    9.032099] ------------------------------------------------------
[    9.032100] swapon/913 is trying to acquire lock:
[    9.032101] ffffc984fda4f948 (&zstrm->lock){+.+.}-{2:2}, at:
zcomp_stream_get+0x5/0x90 [zram]
[    9.032106]
               but task is already holding lock:
[    9.032107] ffff993c54cdceb0 (&zspage->lock){.+.+}-{2:2}, at:
zs_map_object+0x7a/0x2e0
[    9.032111]
               which lock already depends on the new lock.

[    9.032112]
               the existing dependency chain (in reverse order) is:
[    9.032112]
               -> #1 (&zspage->lock){.+.+}-{2:2}:
[    9.032116]        _raw_read_lock+0x3d/0xa0
[    9.032118]        zs_map_object+0x7a/0x2e0
[    9.032119]        zram_bvec_rw.constprop.0.isra.0+0x287/0x730 [zram]
[    9.032121]        zram_submit_bio+0x189/0x35d [zram]
[    9.032123]        submit_bio_noacct+0xff/0x650
[    9.032124]        submit_bh_wbc+0x17d/0x1a0
[    9.032126]        __block_write_full_page+0x227/0x580
[    9.032128]        __writepage+0x1a/0x70
[    9.032129]        write_cache_pages+0x21c/0x540
[    9.032130]        generic_writepages+0x41/0x60
[    9.032131]        do_writepages+0x28/0xb0
[    9.032133]        __filemap_fdatawrite_range+0xa7/0xe0
[    9.032134]        file_write_and_wait_range+0x67/0xb0
[    9.032135]        blkdev_fsync+0x17/0x40
[    9.032137]        __x64_sys_fsync+0x34/0x60
[    9.032138]        do_syscall_64+0x33/0x40
[    9.032140]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    9.032140]
               -> #0 (&zstrm->lock){+.+.}-{2:2}:
[    9.032144]        __lock_acquire+0x11e3/0x21f0
[    9.032145]        lock_acquire+0xc8/0x400
[    9.032146]        zcomp_stream_get+0x38/0x90 [zram]
[    9.032148]        zram_bvec_rw.constprop.0.isra.0+0x4c1/0x730 [zram]
[    9.032149]        zram_rw_page+0xa9/0x130 [zram]
[    9.032150]        bdev_read_page+0x71/0xa0
[    9.032151]        do_mpage_readpage+0x5a8/0x800
[    9.032152]        mpage_readahead+0xfb/0x230
[    9.032153]        read_pages+0x60/0x1e0
[    9.032154]        page_cache_readahead_unbounded+0x1da/0x270
[    9.032155]        generic_file_buffered_read+0x69c/0xe00
[    9.032156]        new_sync_read+0x108/0x180
[    9.032157]        vfs_read+0x12e/0x1c0
[    9.032158]        ksys_read+0x58/0xd0
[    9.032159]        do_syscall_64+0x33/0x40
[    9.032160]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    9.032161]
               other info that might help us debug this:

[    9.032162]  Possible unsafe locking scenario:

[    9.032162]        CPU0                    CPU1
[    9.032163]        ----                    ----
[    9.032163]   lock(&zspage->lock);
[    9.032165]                                lock(&zstrm->lock);
[    9.032166]                                lock(&zspage->lock);
[    9.032167]   lock(&zstrm->lock);
[    9.032168]
                *** DEADLOCK ***

[    9.032169] 1 lock held by swapon/913:
[    9.032170]  #0: ffff993c54cdceb0 (&zspage->lock){.+.+}-{2:2}, at:
zs_map_object+0x7a/0x2e0
[    9.032172]
               stack backtrace:
[    9.032174] CPU: 14 PID: 913 Comm: swapon Not tainted
5.10.0-0.rc0.20201014gitb5fc7a89e58b.41.fc34.x86_64 #1
[    9.032175] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 2606 08/13/2020
[    9.032176] Call Trace:
[    9.032179]  dump_stack+0x8b/0xb0
[    9.032181]  check_noncircular+0xd0/0xf0
[    9.032183]  __lock_acquire+0x11e3/0x21f0
[    9.032185]  lock_acquire+0xc8/0x400
[    9.032187]  ? zcomp_stream_get+0x5/0x90 [zram]
[    9.032189]  zcomp_stream_get+0x38/0x90 [zram]
[    9.032190]  ? zcomp_stream_get+0x5/0x90 [zram]
[    9.032192]  zram_bvec_rw.constprop.0.isra.0+0x4c1/0x730 [zram]
[    9.032194]  ? __part_start_io_acct+0x4d/0xf0
[    9.032196]  zram_rw_page+0xa9/0x130 [zram]
[    9.032197]  bdev_read_page+0x71/0xa0
[    9.032199]  do_mpage_readpage+0x5a8/0x800
[    9.032201]  ? xa_load+0xbf/0x140
[    9.032203]  mpage_readahead+0xfb/0x230
[    9.032205]  ? bdev_evict_inode+0x1a0/0x1a0
[    9.032207]  read_pages+0x60/0x1e0
[    9.032208]  page_cache_readahead_unbounded+0x1da/0x270
[    9.032211]  generic_file_buffered_read+0x69c/0xe00
[    9.032213]  new_sync_read+0x108/0x180
[    9.032215]  vfs_read+0x12e/0x1c0
[    9.032217]  ksys_read+0x58/0xd0
[    9.032218]  do_syscall_64+0x33/0x40
[    9.032219]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    9.032221] RIP: 0033:0x7ff6fcb8e432
[    9.032222] Code: c0 e9 b2 fe ff ff 50 48 8d 3d e2 39 0a 00 e8 a5
f0 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75
10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89
54 24
[    9.032223] RSP: 002b:00007ffff64ee858 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[    9.032225] RAX: ffffffffffffffda RBX: 00007ffff64eea10 RCX: 00007ff6fcb8e432
[    9.032226] RDX: 0000000000010000 RSI: 000055a78c4990c0 RDI: 0000000000000003
[    9.032227] RBP: 0000000000000003 R08: 000055a78c4990c0 R09: 00007ff6fcc60a60
[    9.032228] R10: 0000000000000430 R11: 0000000000000246 R12: 00007ffff64eeaf0
[    9.032228] R13: 000055a78c4990c0 R14: 0000000000000000 R15: 00007ffff64eeaf0

reproductivity 100% reliable on my system

$ /usr/src/kernels/`uname -r`/scripts/faddr2line
/lib/debug/lib/modules/`uname
-r`/kernel/drivers/block/zram/zram.ko.debug zcomp_stream_get+0x5
zcomp_stream_get+0x5/0x10:
zcomp_stream_get at
/usr/src/debug/kernel-20201014gitb5fc7a89e58b/linux-5.10.0-0.rc0.20201014gitb5fc7a89e58b.41.fc34.x86_64/drivers/block/zram/zcomp.c:111

$ git blame -L 106,116 drivers/block/zram/zcomp.c
Blaming lines:   4% (11/232), done.
56b4e8cb85827 (Sergey Senozhatsky 2014-04-07 15:38:22 -0700 106)
 sz += scnprintf(buf + sz, PAGE_SIZE - sz, "\n");
e46b8a030d76d (Sergey Senozhatsky 2014-04-07 15:38:17 -0700 107)
 return sz;
e46b8a030d76d (Sergey Senozhatsky 2014-04-07 15:38:17 -0700 108) }
e46b8a030d76d (Sergey Senozhatsky 2014-04-07 15:38:17 -0700 109)
2aea8493d326b (Sergey Senozhatsky 2016-07-26 15:22:42 -0700 110)
struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
e7e1ef439d18f (Sergey Senozhatsky 2014-04-07 15:38:11 -0700 111) {
19f545b6e07f7 (Mike Galbraith     2020-05-27 22:11:19 +0200 112)
 local_lock(&comp->stream->lock);
19f545b6e07f7 (Mike Galbraith     2020-05-27 22:11:19 +0200 113)
 return this_cpu_ptr(comp->stream);
e7e1ef439d18f (Sergey Senozhatsky 2014-04-07 15:38:11 -0700 114) }
e7e1ef439d18f (Sergey Senozhatsky 2014-04-07 15:38:11 -0700 115)
2aea8493d326b (Sergey Senozhatsky 2016-07-26 15:22:42 -0700 116) void
zcomp_stream_put(struct zcomp *comp)


$ /usr/src/kernels/`uname -r`/scripts/faddr2line
/lib/debug/lib/modules/`uname -r`/vmlinux zs_map_object+0x7a
zs_map_object+0x7a/0x2e0:
get_zspage_mapping at mm/zsmalloc.c:518
(inlined by) zs_map_object at mm/zsmalloc.c:1325


$ git blame -L 1320,1330 mm/zsmalloc.c
Blaming lines:   0% (11/2594), done.
3783689a1aa82 (Minchan Kim      2016-07-26 15:23:23 -0700 1320)
 zspage = get_zspage(page);
48b4800a1c6af (Minchan Kim      2016-07-26 15:23:31 -0700 1321)
48b4800a1c6af (Minchan Kim      2016-07-26 15:23:31 -0700 1322)
 /* migration cannot move any subpage in this zspage */
48b4800a1c6af (Minchan Kim      2016-07-26 15:23:31 -0700 1323)
 migrate_read_lock(zspage);
48b4800a1c6af (Minchan Kim      2016-07-26 15:23:31 -0700 1324)
3783689a1aa82 (Minchan Kim      2016-07-26 15:23:23 -0700 1325)
 get_zspage_mapping(zspage, &class_idx, &fg);
66cdef663cd7a (Ganesh Mahendran 2014-12-18 16:17:40 -0800 1326)
 class = pool->size_class[class_idx];
bfd093f5e7f09 (Minchan Kim      2016-07-26 15:23:28 -0700 1327)
 off = (class->size * obj_idx) & ~PAGE_MASK;
df8b5bb998f10 (Ganesh Mahendran 2014-12-12 16:57:07 -0800 1328)
66cdef663cd7a (Ganesh Mahendran 2014-12-18 16:17:40 -0800 1329)
 area = &get_cpu_var(zs_map_area);
66cdef663cd7a (Ganesh Mahendran 2014-12-18 16:17:40 -0800 1330)
 area->vm_mm = mm;


The last changes were made by Mike and acked by Peter. That is why I
invited you here, can you clarify the situation.

--
Best Regards,
Mike Gavrilov.
