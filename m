Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700C2C6FD1B
	for <linux-block@archiver.kernel.org>; Mon,  6 Mar 2023 12:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjCFMBs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Mar 2023 07:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCFMBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Mar 2023 07:01:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA14B29425
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 04:01:40 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 595071FE6A;
        Mon,  6 Mar 2023 12:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678104099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwWSptgMMFl2hfXaCi3D0muPPjyDoJ1hqU3sgJ2+gbU=;
        b=ka2vINzbCY05g/ovFgiErOugKL5/doF7R8M/rWAE4CBVJkDuDJiIKe1RRW5hllmyMYoaPx
        /gJQ9BLZgFirrnZ3Qa9qHwa7dIiYdWLZ+R7Vq+dYywOf64BNoZlRIKn4ggJVfe2j9VtubM
        TjVzR+1dgwkYv3uFzNwfk6I5v9Y2Ing=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678104099;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwWSptgMMFl2hfXaCi3D0muPPjyDoJ1hqU3sgJ2+gbU=;
        b=znncyqKHFiz607kZw1kho/6kxcNoYrO2gCs+tWehfkMkJ4kXhbcxL0tzjWr8d2TXH/QCiY
        XoBd9rrO3qKEwhBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 485782C146;
        Mon,  6 Mar 2023 12:01:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 3E21D51BE38B; Mon,  6 Mar 2023 13:01:39 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/5] brd: abstract page_size conventions
Date:   Mon,  6 Mar 2023 13:01:24 +0100
Message-Id: <20230306120127.21375-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230306120127.21375-1-hare@suse.de>
References: <20230306120127.21375-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for changing the block sizes abstract away references
to PAGE_SIZE and friends.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/brd.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 7efc276c4963..fc41ea641dfb 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -55,6 +55,7 @@ static struct folio *brd_lookup_folio(struct brd_device *brd, sector_t sector)
 {
 	pgoff_t idx;
 	struct folio *folio;
+	unsigned int rd_sector_shift = PAGE_SHIFT - SECTOR_SHIFT;
 
 	/*
 	 * The folio lifetime is protected by the fact that we have opened the
@@ -68,7 +69,7 @@ static struct folio *brd_lookup_folio(struct brd_device *brd, sector_t sector)
 	 * here, only deletes).
 	 */
 	rcu_read_lock();
-	idx = sector >> PAGE_SECTORS_SHIFT; /* sector to folio index */
+	idx = sector >> rd_sector_shift; /* sector to folio index */
 	folio = radix_tree_lookup(&brd->brd_folios, idx);
 	rcu_read_unlock();
 
@@ -84,13 +85,15 @@ static int brd_insert_folio(struct brd_device *brd, sector_t sector, gfp_t gfp)
 {
 	pgoff_t idx;
 	struct folio *folio;
+	unsigned int rd_sector_shift = PAGE_SHIFT - SECTOR_SHIFT;
+	unsigned int rd_sector_order = get_order(PAGE_SIZE);
 	int ret = 0;
 
 	folio = brd_lookup_folio(brd, sector);
 	if (folio)
 		return 0;
 
-	folio = folio_alloc(gfp | __GFP_ZERO, 0);
+	folio = folio_alloc(gfp | __GFP_ZERO, rd_sector_order);
 	if (!folio)
 		return -ENOMEM;
 
@@ -100,7 +103,7 @@ static int brd_insert_folio(struct brd_device *brd, sector_t sector, gfp_t gfp)
 	}
 
 	spin_lock(&brd->brd_lock);
-	idx = sector >> PAGE_SECTORS_SHIFT;
+	idx = sector >> rd_sector_shift;
 	folio->index = idx;
 	if (radix_tree_insert(&brd->brd_folios, idx, folio)) {
 		folio_put(folio);
@@ -167,11 +170,14 @@ static void brd_free_folios(struct brd_device *brd)
 static int copy_to_brd_setup(struct brd_device *brd, sector_t sector, size_t n,
 			     gfp_t gfp)
 {
-	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
+	unsigned int rd_sectors_shift = PAGE_SHIFT - SECTOR_SHIFT;
+	unsigned int rd_sectors = 1 << rd_sectors_shift;
+	unsigned int rd_sector_size = PAGE_SIZE;
+	unsigned int offset = (sector & (rd_sectors - 1)) << SECTOR_SHIFT;
 	size_t copy;
 	int ret;
 
-	copy = min_t(size_t, n, PAGE_SIZE - offset);
+	copy = min_t(size_t, n, rd_sector_size - offset);
 	ret = brd_insert_folio(brd, sector, gfp);
 	if (ret)
 		return ret;
@@ -190,10 +196,13 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 {
 	struct folio *folio;
 	void *dst;
-	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
+	unsigned int rd_sectors_shift = PAGE_SHIFT - SECTOR_SHIFT;
+	unsigned int rd_sectors = 1 << rd_sectors_shift;
+	unsigned int rd_sector_size = PAGE_SIZE;
+	unsigned int offset = (sector & (rd_sectors - 1)) << SECTOR_SHIFT;
 	size_t copy;
 
-	copy = min_t(size_t, n, PAGE_SIZE - offset);
+	copy = min_t(size_t, n, rd_sector_size - offset);
 	folio = brd_lookup_folio(brd, sector);
 	BUG_ON(!folio);
 
@@ -222,10 +231,13 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 {
 	struct folio *folio;
 	void *src;
-	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
+	unsigned int rd_sectors_shift = PAGE_SHIFT - SECTOR_SHIFT;
+	unsigned int rd_sectors = 1 << rd_sectors_shift;
+	unsigned int rd_sector_size = PAGE_SIZE;
+	unsigned int offset = (sector & (rd_sectors - 1)) << SECTOR_SHIFT;
 	size_t copy;
 
-	copy = min_t(size_t, n, PAGE_SIZE - offset);
+	copy = min_t(size_t, n, rd_sector_size - offset);
 	folio = brd_lookup_folio(brd, sector);
 	if (folio) {
 		src = kmap_local_folio(folio, offset);
-- 
2.35.3

