Return-Path: <SRS0=I4RS=DX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D339C433E7
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 12:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08AC21582
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 12:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gRPKVnBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405301AbgJPMkR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Oct 2020 08:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405285AbgJPMkR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Oct 2020 08:40:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77A3C061755;
        Fri, 16 Oct 2020 05:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+u/Kv1xSjoMnO9CYHCfN7Kq1Qqj40T49cs4QSd27bZE=; b=gRPKVnBY7CynOMnL3MRYuL+qsq
        IqNrC0MNy8KgLGWmrSxcFeZaqqvptlqu89+VI6AoRWhJZWMo2Zb9CpBUlPj8/lyOHaw3KIBBPiOue
        RmchvQNGzLds81RhRS7w4GjDr5GiTqHmZEfaxVtHmxSuzL4SeYqGvBQagUVbUStR2/HDHPsZTc3HV
        VQOLSs7AhsL95UH+UcHTCrHMjJGZKQ45c/cM7Y/zlAoKGzxOjwtH97TKcBGnnZqI/q8MHpVxmtZpM
        3yQoD0Z7XjZGkmgEOkitfnwv3YBEjHZi0SUEUQemv3GOaBTVvds5giW7zmN47DoOdR+fK/2shJpdJ
        cCmzQeKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTP1m-0000Hn-Je; Fri, 16 Oct 2020 12:40:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D372B300DB4;
        Fri, 16 Oct 2020 14:40:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA7B9213CCBE0; Fri, 16 Oct 2020 14:40:09 +0200 (CEST)
Date:   Fri, 16 Oct 2020 14:40:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Mike Galbraith <umgwanakikbuti@gmail.com>, minchan@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        bigeasy@linutronix.de
Subject: Re: swapon/913 is trying to acquire lock at
 zcomp_stream_get+0x5/0x90 [zram] but task is already holding lock at
 zs_map_object+0x7a/0x2e0
Message-ID: <20201016124009.GQ2611@hirez.programming.kicks-ass.net>
References: <CABXGCsOL0pW0Ghh-w5d12P75ve6FS9Rgmzm6DvsYbJY-jMTCdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsOL0pW0Ghh-w5d12P75ve6FS9Rgmzm6DvsYbJY-jMTCdg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 16, 2020 at 11:21:47AM +0500, Mikhail Gavrilov wrote:
> Hi folks,
> today I joined to testing Kernel 5.10 and see that every boot happens
> this warning:
> 
> [    9.032096] ======================================================
> [    9.032097] WARNING: possible circular locking dependency detected
> [    9.032098] 5.10.0-0.rc0.20201014gitb5fc7a89e58b.41.fc34.x86_64 #1 Not tainted
> [    9.032099] ------------------------------------------------------
> [    9.032100] swapon/913 is trying to acquire lock:
> [    9.032101] ffffc984fda4f948 (&zstrm->lock){+.+.}-{2:2}, at: zcomp_stream_get+0x5/0x90 [zram]
> [    9.032106] but task is already holding lock:
> [    9.032107] ffff993c54cdceb0 (&zspage->lock){.+.+}-{2:2}, at: zs_map_object+0x7a/0x2e0
> [    9.032111] which lock already depends on the new lock.
> [    9.032112] the existing dependency chain (in reverse order) is:

> [    9.032112] -> #1 (&zspage->lock){.+.+}-{2:2}:
> [    9.032116]        _raw_read_lock+0x3d/0xa0
> [    9.032118]        zs_map_object+0x7a/0x2e0
> [    9.032119]        zram_bvec_rw.constprop.0.isra.0+0x287/0x730 [zram]
> [    9.032121]        zram_submit_bio+0x189/0x35d [zram]
> [    9.032123]        submit_bio_noacct+0xff/0x650
> [    9.032124]        submit_bh_wbc+0x17d/0x1a0
> [    9.032126]        __block_write_full_page+0x227/0x580
> [    9.032128]        __writepage+0x1a/0x70
> [    9.032129]        write_cache_pages+0x21c/0x540
> [    9.032130]        generic_writepages+0x41/0x60
> [    9.032131]        do_writepages+0x28/0xb0
> [    9.032133]        __filemap_fdatawrite_range+0xa7/0xe0
> [    9.032134]        file_write_and_wait_range+0x67/0xb0
> [    9.032135]        blkdev_fsync+0x17/0x40
> [    9.032137]        __x64_sys_fsync+0x34/0x60
> [    9.032138]        do_syscall_64+0x33/0x40
> [    9.032140]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [    9.032140]
>                -> #0 (&zstrm->lock){+.+.}-{2:2}:


> [    9.032169] 1 lock held by swapon/913:
> [    9.032170]  #0: ffff993c54cdceb0 (&zspage->lock){.+.+}-{2:2}, at: zs_map_object+0x7a/0x2e0

> [    9.032176] Call Trace:
> [    9.032179]  dump_stack+0x8b/0xb0
> [    9.032181]  check_noncircular+0xd0/0xf0
> [    9.032183]  __lock_acquire+0x11e3/0x21f0
> [    9.032185]  lock_acquire+0xc8/0x400
> [    9.032187]  ? zcomp_stream_get+0x5/0x90 [zram]
> [    9.032189]  zcomp_stream_get+0x38/0x90 [zram]
> [    9.032190]  ? zcomp_stream_get+0x5/0x90 [zram]
> [    9.032192]  zram_bvec_rw.constprop.0.isra.0+0x4c1/0x730 [zram]
> [    9.032194]  ? __part_start_io_acct+0x4d/0xf0
> [    9.032196]  zram_rw_page+0xa9/0x130 [zram]
> [    9.032197]  bdev_read_page+0x71/0xa0
> [    9.032199]  do_mpage_readpage+0x5a8/0x800
> [    9.032201]  ? xa_load+0xbf/0x140
> [    9.032203]  mpage_readahead+0xfb/0x230
> [    9.032205]  ? bdev_evict_inode+0x1a0/0x1a0
> [    9.032207]  read_pages+0x60/0x1e0
> [    9.032208]  page_cache_readahead_unbounded+0x1da/0x270
> [    9.032211]  generic_file_buffered_read+0x69c/0xe00
> [    9.032213]  new_sync_read+0x108/0x180
> [    9.032215]  vfs_read+0x12e/0x1c0
> [    9.032217]  ksys_read+0x58/0xd0
> [    9.032218]  do_syscall_64+0x33/0x40
> [    9.032219]  entry_SYSCALL_64_after_hwframe+0x44/0xa9


Joy... __zram_bvec_write() and __zram_bvec_read() take these locks in
opposite order.

Does something like the (_completely_) untested below cure things?

---

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9100ac36670a..c1e2c2e1cde8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1216,10 +1216,11 @@ static void zram_free_page(struct zram *zram, size_t index)
 static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 				struct bio *bio, bool partial_io)
 {
-	int ret;
+	struct zcomp_strm *zstrm;
 	unsigned long handle;
 	unsigned int size;
 	void *src, *dst;
+	int ret;
 
 	zram_slot_lock(zram, index);
 	if (zram_test_flag(zram, index, ZRAM_WB)) {
@@ -1250,6 +1251,9 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 
 	size = zram_get_obj_size(zram, index);
 
+	if (size != PAGE_SIZE)
+		zstrm = zcomp_stream_get(zram->comp);
+
 	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
 	if (size == PAGE_SIZE) {
 		dst = kmap_atomic(page);
@@ -1257,8 +1261,6 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 		kunmap_atomic(dst);
 		ret = 0;
 	} else {
-		struct zcomp_strm *zstrm = zcomp_stream_get(zram->comp);
-
 		dst = kmap_atomic(page);
 		ret = zcomp_decompress(zstrm, src, size, dst);
 		kunmap_atomic(dst);
