Return-Path: <SRS0=I4RS=DX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C42C433DF
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 15:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2AF8207C4
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 15:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602862410;
	bh=5Remwr+83WDq22OIH+lcGhLd6AiGLJSNCyWhoMRBkio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OgfzH2/kQXkZo18OZpzcacx7BkMhdVL8m1k6/40Gr1FJ3VPHOrO45BpwPG+1B1gwm
	 gIk9q2VkkyhuLkitVVCa4P/4ADDI6rHANRoR1AZC/a2n7w1lkQ2Q66FflspopMlEg9
	 djlmuyjQ5XXJaRPwSkg/2KMuntmJfNlS+CiVB7lI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407585AbgJPPd3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Oct 2020 11:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404507AbgJPPd3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Oct 2020 11:33:29 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EC0C061755;
        Fri, 16 Oct 2020 08:33:29 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x13so1695456pfa.9;
        Fri, 16 Oct 2020 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gABW2KQ5ZiJTeAUlEXgZ7DFl25H1jBQV0yMaSjTf0Ew=;
        b=e7qsBCmrw3wUcu9lLKmG7tEhmzh41fiigyyDOt8192HLNXv+l+v0qaTk/pV0oHJK8E
         SuIrgrxbbk243Wnl3nWuDKUKLiTvq28NmNl+6XITIzV1pRO0218WY2AAcEPXIkW4ylSq
         SCdpTXgr5hWeVDQxZq+0GTMcwQzVfvStZl3cvbredb3FTHv9kLEdtcIqq/T5li/vKjrS
         m4RVtMwlq/Ni/F5sKK7IVdyZpber/0SbDACBa8gzKFIYOgtvIAz+881ZqGeK3oPNh0WS
         D51wHa8vT6oY5jArASJUnuwe6OMJodqU/S4PDkdM7JnadSJsfAJ8vL8p+1z8QFs4Xk76
         8hFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gABW2KQ5ZiJTeAUlEXgZ7DFl25H1jBQV0yMaSjTf0Ew=;
        b=DDv/O7ZOT+NWdzf0eO57HH6M77GV04H80ncGbBDnPnlumroiJGChEaze5iTBuCIk0Q
         TJEfVoydFrw67LxF+nWyd8P8OUxaYkTA7Ian2puz4C41Ibjbz8doaVq1RZDD7PjCyY6n
         iyH/BrKFjIfQV/hntUPYffJBPEiVYqRF41anmeVe31JmS/l4jbhHGYoeeIcNAErLSJ+p
         5T+TIrNGCd9ka0bu/G1TW9uHMrMQWp+IjhjDtAES7y63Su9oV0fmh6HXHWKj/Hcb5Wjv
         0I1m7jiq7gjf0wdkTfSemckhlWKiNcUTzp8kGqd89OxFFEJBnLC1k3JgDjlU2RvGMG/I
         FBCA==
X-Gm-Message-State: AOAM530X+lexC09Wvtwrmp3KpTkziHzBxZvhpzSnYra/CJzNKZ5W5DBg
        dzQNcAN3zv6NCKR69m9aSVE=
X-Google-Smtp-Source: ABdhPJw/7zCuRVADn2EVkiQosa8Zi2DucisTB0ZX9s95yH+EFV89V+qRrXAN6KVFuHbh9hdK50pBaQ==
X-Received: by 2002:a62:7a53:0:b029:152:5482:8935 with SMTP id v80-20020a627a530000b029015254828935mr4338348pfc.31.1602862408483;
        Fri, 16 Oct 2020 08:33:28 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id l14sm3034600pfc.170.2020.10.16.08.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:33:27 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 16 Oct 2020 08:33:24 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Mike Galbraith <umgwanakikbuti@gmail.com>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, bigeasy@linutronix.de,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: swapon/913 is trying to acquire lock at
 zcomp_stream_get+0x5/0x90 [zram] but task is already holding lock at
 zs_map_object+0x7a/0x2e0
Message-ID: <20201016153324.GA1976566@google.com>
References: <CABXGCsOL0pW0Ghh-w5d12P75ve6FS9Rgmzm6DvsYbJY-jMTCdg@mail.gmail.com>
 <20201016124009.GQ2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016124009.GQ2611@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 16, 2020 at 02:40:09PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 16, 2020 at 11:21:47AM +0500, Mikhail Gavrilov wrote:
> > Hi folks,
> > today I joined to testing Kernel 5.10 and see that every boot happens
> > this warning:
> > 
> > [    9.032096] ======================================================
> > [    9.032097] WARNING: possible circular locking dependency detected
> > [    9.032098] 5.10.0-0.rc0.20201014gitb5fc7a89e58b.41.fc34.x86_64 #1 Not tainted
> > [    9.032099] ------------------------------------------------------
> > [    9.032100] swapon/913 is trying to acquire lock:
> > [    9.032101] ffffc984fda4f948 (&zstrm->lock){+.+.}-{2:2}, at: zcomp_stream_get+0x5/0x90 [zram]
> > [    9.032106] but task is already holding lock:
> > [    9.032107] ffff993c54cdceb0 (&zspage->lock){.+.+}-{2:2}, at: zs_map_object+0x7a/0x2e0
> > [    9.032111] which lock already depends on the new lock.
> > [    9.032112] the existing dependency chain (in reverse order) is:
> 
> > [    9.032112] -> #1 (&zspage->lock){.+.+}-{2:2}:
> > [    9.032116]        _raw_read_lock+0x3d/0xa0
> > [    9.032118]        zs_map_object+0x7a/0x2e0
> > [    9.032119]        zram_bvec_rw.constprop.0.isra.0+0x287/0x730 [zram]
> > [    9.032121]        zram_submit_bio+0x189/0x35d [zram]
> > [    9.032123]        submit_bio_noacct+0xff/0x650
> > [    9.032124]        submit_bh_wbc+0x17d/0x1a0
> > [    9.032126]        __block_write_full_page+0x227/0x580
> > [    9.032128]        __writepage+0x1a/0x70
> > [    9.032129]        write_cache_pages+0x21c/0x540
> > [    9.032130]        generic_writepages+0x41/0x60
> > [    9.032131]        do_writepages+0x28/0xb0
> > [    9.032133]        __filemap_fdatawrite_range+0xa7/0xe0
> > [    9.032134]        file_write_and_wait_range+0x67/0xb0
> > [    9.032135]        blkdev_fsync+0x17/0x40
> > [    9.032137]        __x64_sys_fsync+0x34/0x60
> > [    9.032138]        do_syscall_64+0x33/0x40
> > [    9.032140]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [    9.032140]
> >                -> #0 (&zstrm->lock){+.+.}-{2:2}:
> 
> 
> > [    9.032169] 1 lock held by swapon/913:
> > [    9.032170]  #0: ffff993c54cdceb0 (&zspage->lock){.+.+}-{2:2}, at: zs_map_object+0x7a/0x2e0
> 
> > [    9.032176] Call Trace:
> > [    9.032179]  dump_stack+0x8b/0xb0
> > [    9.032181]  check_noncircular+0xd0/0xf0
> > [    9.032183]  __lock_acquire+0x11e3/0x21f0
> > [    9.032185]  lock_acquire+0xc8/0x400
> > [    9.032187]  ? zcomp_stream_get+0x5/0x90 [zram]
> > [    9.032189]  zcomp_stream_get+0x38/0x90 [zram]
> > [    9.032190]  ? zcomp_stream_get+0x5/0x90 [zram]
> > [    9.032192]  zram_bvec_rw.constprop.0.isra.0+0x4c1/0x730 [zram]
> > [    9.032194]  ? __part_start_io_acct+0x4d/0xf0
> > [    9.032196]  zram_rw_page+0xa9/0x130 [zram]
> > [    9.032197]  bdev_read_page+0x71/0xa0
> > [    9.032199]  do_mpage_readpage+0x5a8/0x800
> > [    9.032201]  ? xa_load+0xbf/0x140
> > [    9.032203]  mpage_readahead+0xfb/0x230
> > [    9.032205]  ? bdev_evict_inode+0x1a0/0x1a0
> > [    9.032207]  read_pages+0x60/0x1e0
> > [    9.032208]  page_cache_readahead_unbounded+0x1da/0x270
> > [    9.032211]  generic_file_buffered_read+0x69c/0xe00
> > [    9.032213]  new_sync_read+0x108/0x180
> > [    9.032215]  vfs_read+0x12e/0x1c0
> > [    9.032217]  ksys_read+0x58/0xd0
> > [    9.032218]  do_syscall_64+0x33/0x40
> > [    9.032219]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> 
> Joy... __zram_bvec_write() and __zram_bvec_read() take these locks in
> opposite order.
> 
> Does something like the (_completely_) untested below cure things?


[19f545b6e07f7, zram: Use local lock to protect per-CPU data] introduced
new lock dependency and this patch looks good to me.

Peter, do you mind sending this patch with fix tag to Andrew Morton?

Thanks for your help.

> 
> ---
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 9100ac36670a..c1e2c2e1cde8 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1216,10 +1216,11 @@ static void zram_free_page(struct zram *zram, size_t index)
>  static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
>  				struct bio *bio, bool partial_io)
>  {
> -	int ret;
> +	struct zcomp_strm *zstrm;
>  	unsigned long handle;
>  	unsigned int size;
>  	void *src, *dst;
> +	int ret;
>  
>  	zram_slot_lock(zram, index);
>  	if (zram_test_flag(zram, index, ZRAM_WB)) {
> @@ -1250,6 +1251,9 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
>  
>  	size = zram_get_obj_size(zram, index);
>  
> +	if (size != PAGE_SIZE)
> +		zstrm = zcomp_stream_get(zram->comp);
> +
>  	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
>  	if (size == PAGE_SIZE) {
>  		dst = kmap_atomic(page);
> @@ -1257,8 +1261,6 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
>  		kunmap_atomic(dst);
>  		ret = 0;
>  	} else {
> -		struct zcomp_strm *zstrm = zcomp_stream_get(zram->comp);
> -
>  		dst = kmap_atomic(page);
>  		ret = zcomp_decompress(zstrm, src, size, dst);
>  		kunmap_atomic(dst);
