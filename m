Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29E1C433DB
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 03:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B812964DD1
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 03:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhCDDU3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Mar 2021 22:20:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:39948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232174AbhCDDUQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Mar 2021 22:20:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614827970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uwROHri3jAYqZiiPC7ezazGqMAZqkEXzkvDJV6oH7b8=;
        b=QkWLq1VO64r4McPWb5fyZBIZtT1EYMBzCqh4+V324aWNnQeOsa3csYsMqjCBc5YXWsOpad
        MD83xpvQUSiN8IbFEUnRVSoj5dkpTJC0RG2voi8pFkCgpLJouKlPY1fMfd2QrPD8W7exCN
        FddccjD12Dt0jMBskXbVHemt1/ZIT7c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40072ACBF;
        Thu,  4 Mar 2021 03:19:30 +0000 (UTC)
Date:   Thu, 4 Mar 2021 04:19:29 +0100
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org
Subject: Re: [PATCH] swap: fix swapfile read/write offset
Message-ID: <YEBRwbYtxT1HL+qU@technoir>
References: <6f9da9c6-c6c5-08fe-95ea-940954456c40@kernel.dk>
 <YD+vZW2bJsmpCGn5@technoir>
 <910b8b56-e16d-ec91-5e76-c88cac69d89b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <910b8b56-e16d-ec91-5e76-c88cac69d89b@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 03, 2021 at 09:24:13AM -0700, Jens Axboe wrote:
> On 3/3/21 8:46 AM, Anthony Iliopoulos wrote:
> > On Tue, Mar 02, 2021 at 03:36:19PM -0700, Jens Axboe wrote:
> >> We're not factoring in the start of the file for where to write and
> >> read the swapfile, which leads to very unfortunate side effects of
> >> writing where we should not be...
> >>
> >> Fixes: 48d15436fde6 ("mm: remove get_swap_bio")
> > 
> > Presumably the usage of swap_page_sector was already affecting swap on
> > blockdevs that implement rw_page (currently brd, zram, btt, pmem), so it
> > may worth adding:
> > 
> > Fixes: dd6bd0d9c7db ("swap: use bdev_read_page() / bdev_write_page()")
> > Cc: <stable@vger.kernel.org> # v3.16+
> > 
> > for backporting, since it also affects stable.
> 
> yes indeed, in fact that is the source of the original issue (copy/paste
> from that broken path).
> 
> Fix is already upstream, but would be nice if someone would turn it into
> something that could be applied to stable.

Sure, I have the following for v5.10+ and can post this later today to
stable for review along with backports for the rest of the longterm
kernels:

From f0d75f9a18e5184670ea11b87bf513b0225b6826 Mon Sep 17 00:00:00 2001
From: Anthony Iliopoulos <ailiop@suse.com>
Date: Wed, 3 Mar 2021 20:07:05 +0100
Subject: [PATCH] swap: fix swapfile page offset mapping

Fix block device sector offset calculation for swap page io on top of
blockdevs that provide a rw_page operation and do page-sized io directly
(without the block layer).

Currently swap_page_sector() maps a swap page into a blockdev sector by
obtaining the swap page offset (swap map slot), but ignores the swapfile
starting offset into the blockdev.

In setups where swapfiles are sitting on top of a filesystem, this
results into swapping out activity potentially overwriting filesystem
blocks that fall outside the swapfile region.

[This issue only affects swapfiles on filesystems on top of blockdevs
that implement rw_page ops (brd, zram, btt, pmem), and not on top of any
other regular block devices.]

Fixes: dd6bd0d9c7db ("swap: use bdev_read_page() / bdev_write_page()")
Cc: <stable@vger.kernel.org> # v5.10+

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 mm/page_io.c  | 12 ++++--------
 mm/swapfile.c |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 9bca17ecc4df..d2d4d1b3db10 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -37,7 +37,6 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
 
 		bio->bi_iter.bi_sector = map_swap_page(page, &bdev);
 		bio_set_dev(bio, bdev);
-		bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
 		bio->bi_end_io = end_io;
 
 		bio_add_page(bio, page, thp_size(page), 0);
@@ -273,11 +272,6 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 	return ret;
 }
 
-static sector_t swap_page_sector(struct page *page)
-{
-	return (sector_t)__page_file_index(page) << (PAGE_SHIFT - 9);
-}
-
 static inline void count_swpout_vm_event(struct page *page)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -355,7 +349,8 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		return ret;
 	}
 
-	ret = bdev_write_page(sis->bdev, swap_page_sector(page), page, wbc);
+	ret = bdev_write_page(sis->bdev, map_swap_page(page, &sis->bdev),
+			      page, wbc);
 	if (!ret) {
 		count_swpout_vm_event(page);
 		return 0;
@@ -414,7 +409,8 @@ int swap_readpage(struct page *page, bool synchronous)
 	}
 
 	if (sis->flags & SWP_SYNCHRONOUS_IO) {
-		ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
+		ret = bdev_read_page(sis->bdev, map_swap_page(page, &sis->bdev),
+				     page);
 		if (!ret) {
 			if (trylock_page(page)) {
 				swap_slot_free_notify(page);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9fffc5af29d1..47524a4d5e90 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2308,7 +2308,7 @@ sector_t map_swap_page(struct page *page, struct block_device **bdev)
 {
 	swp_entry_t entry;
 	entry.val = page_private(page);
-	return map_swap_entry(entry, bdev);
+	return map_swap_entry(entry, bdev) << (PAGE_SHIFT - 9);
 }
 
 /*
-- 
2.30.1
