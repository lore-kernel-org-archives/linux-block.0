Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A87C433E6
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 17:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D8164EC4
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 17:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhBIRPQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbhBIRPI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Feb 2021 12:15:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A4CC061756
        for <linux-block@vger.kernel.org>; Tue,  9 Feb 2021 09:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jvggammSvObo4RoSuyeZ2Zo9ElC7zgmHWypynsiC2QE=; b=COwEEgjwD0Y9KZMkKHwzMrEpRO
        6t/TvPfp1sgUlkaEUsVD7k3dNWKZiGxqFLHKWT9NvAFmqyDi/yP5r14JWZo/OV5909xUL8AfVd1tV
        Fz69D6fl5Y08WD2b0GzltNSiUJREUSvUFejASpzijYDmIouo8Y2+sh02+0qk2xG7ZzGzDi8sw7YZv
        OvJ+3osL6jcD6ZTBFC5ZKgrD0dQJ9O9pfDdr1pocJqU496c9ThZi+pDJdu6uV/5NM2/lO+W/lc720
        5agYoZxT8qiOnqfMnjelVYj2OZ1uxMWg/d5h1RCH7pEyeoS8c1Er2SWhmMWvOMcYuaZ00cpfjiN1e
        PiIub22w==;
Received: from [2001:4bb8:184:7d04:8942:6d04:f432:bc43] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l9Waj-007jC2-UC; Tue, 09 Feb 2021 17:14:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: [PATCH] mm: simplify swapdev_block
Date:   Tue,  9 Feb 2021 18:14:19 +0100
Message-Id: <20210209171419.4003839-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210209171419.4003839-1-hch@lst.de>
References: <20210209171419.4003839-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Open code the parts of map_swap_entry that was actually used by
swapdev_block, and remove the now unused map_swap_entry function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/swapfile.c | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 351999a84e6e4e..21a98cb8d646e3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1790,9 +1790,6 @@ int free_swap_and_cache(swp_entry_t entry)
 }
 
 #ifdef CONFIG_HIBERNATION
-
-static sector_t map_swap_entry(swp_entry_t, struct block_device**);
-
 /*
  * Find the swap type that corresponds to given device (if any).
  *
@@ -1852,12 +1849,13 @@ int find_first_swap(dev_t *device)
  */
 sector_t swapdev_block(int type, pgoff_t offset)
 {
-	struct block_device *bdev;
 	struct swap_info_struct *si = swap_type_to_swap_info(type);
+	struct swap_extent *se;
 
 	if (!si || !(si->flags & SWP_WRITEOK))
 		return 0;
-	return map_swap_entry(swp_entry(type, offset), &bdev);
+	se = offset_to_swap_extent(si, offset);
+	return se->start_block + (offset - se->start_page);
 }
 
 /*
@@ -2283,28 +2281,6 @@ static void drain_mmlist(void)
 	spin_unlock(&mmlist_lock);
 }
 
-#ifdef CONFIG_HIBERNATION
-/*
- * Use this swapdev's extent info to locate the (PAGE_SIZE) block which
- * corresponds to page offset for the specified swap entry.
- * Note that the type of this function is sector_t, but it returns page offset
- * into the bdev, not sector offset.
- */
-static sector_t map_swap_entry(swp_entry_t entry, struct block_device **bdev)
-{
-	struct swap_info_struct *sis;
-	struct swap_extent *se;
-	pgoff_t offset;
-
-	sis = swp_swap_info(entry);
-	*bdev = sis->bdev;
-
-	offset = swp_offset(entry);
-	se = offset_to_swap_extent(sis, offset);
-	return se->start_block + (offset - se->start_page);
-}
-#endif
-
 /*
  * Free all of a swapdev's extent information
  */
-- 
2.29.2

