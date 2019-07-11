Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B3EC71142
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 17:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C3A20872
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 17:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H5vJrtPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfGKRyX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:54:23 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53271 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfGKRyX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 13:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562867754; x=1594403754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=NRbtIeIHaFWl344KVqwv8W6TUa6y5dakiIM6yOpWXYE=;
  b=H5vJrtPv+atzVgSfPGDEMcNW7YWlLHHFXcg3VSUMS97DQOWBuk9E0aHs
   LswRrrrBjP6ohLqvsJSGKgmtNlS4zYXDP2f+EH4C9kn29QtLhXz7WP82f
   aqohafIhKFGiGImBDuQr5VWjXhSrR5mQTugozsYDsaFLB1J/OzS+DBHmw
   iAozy2H5T5/QKHOAfm8I49yt3PTf1ZgOX1XUdp9nZzshMAYw95qoIqle0
   SpVWiN5MefNz10f5+AY1SQy/k3n/zjCi7mgtcPmcygPpSooK36DptgMog
   EXcm0NAaESj9o+O7z1aRp2NZ/qg0r5t3iLk2w8CwSaI83XBeyxudxKtBg
   w==;
IronPort-SDR: bpjN/uZ/RnVmGaKY4/rzjlHEYXu26mg7vK3V2TSsDCvMssjR8HXiqX+22C/nuRJR6uxsVZCyg/
 hYLUQdsfWHdS+7xc+wyPVd2cdSiqfEiInDg/ZyKQC22hhGgHqx65doAwEVj+zFQvX3Xvj7oh8J
 GOxLulgUEf7ipf5AQaG13XyjcIOKcEJbwbwjHaOOSWkvG0Tfm/t1bjcCYmOlcJlQgCgyKV5LTo
 +b+Oki4UpI1s+8xDpWu7PSKAbnKFQKipilUoMmiMVkLH4B6/3oQvwQfhMz1R28yADwFDQDMduD
 mOU=
X-IronPort-AV: E=Sophos;i="5.63,479,1557158400"; 
   d="scan'208";a="212743432"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 01:55:54 +0800
IronPort-SDR: PGWectX0mT/CQmJH3hCPM0bsOipks+XsE7ET2H3hdHYt1tXD2a5+mohu4vZu278JUdv+fODgFl
 CfayT57mX2s5ozYZ2oxxJzw5GGSVvlBfmQwktP4BD0E5xWg3JR7F9dCmsMT7m/LoLDaA5SzSaD
 Miv3JkIRfE3E3ZJ3u5Y4BD8d2/UD4dJ0ACpz5IxXoHDFlPJmOigAmGh0GqNPSbiazezUn/1npx
 lMYf54EDMYhVqry5v0mVAJ7uJojpb7t81xzUHLW8vS2/khZDZt0xG9PCJypG5PLOJT5mPl637r
 MqEdItDErDk/R6dj8SUlUOS1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 11 Jul 2019 10:53:06 -0700
IronPort-SDR: B7PdpoNA9DngraQgMWPjgcaOjzhWoiCX33MzhAhUW7pNesGhDblbJ53XYMO/0Qtok6hQ+igkgm
 Gvg7DBjLIFq8ZCLsyU/M56J0kyJ0Dq+f/aAdSbOLto6rELfOSHFtvnufVkMXllb/81ddM4IHDv
 1IxhTrfQ9HNQEP9xFb4rT1eFUCNq4hncdb80n+TV1VYCazQJxOKVPM8vh2p4jzCRC73+PFZnOn
 sQg+87wrO7X6BfyTpAADNir+s5gMCpwTgXfEWC8fSYGjLEkZePDwmZIHb2Bl4nacwKWoTmOxtD
 If8=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jul 2019 10:54:22 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 5/8] null_blk: code cleaup
Date:   Thu, 11 Jul 2019 10:53:25 -0700
Message-Id: <20190711175328.16430-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
References: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In the null_blk for different page and sector calculation we have
simple macros to make the code more redable.

Similar to that this is a purely code cleanup patch where we
introduce two new macros for calculating the page index from given
sector and index (offset) of the sector in the page.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 37 ++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index fca011a05277..d463bde001b6 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -16,6 +16,11 @@
 #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
 #define SECTOR_MASK		(PAGE_SECTORS - 1)
 
+/* Gives page index for which this sector belongs to. */
+#define PAGE_IDX_FROM_SECT(sect)	(sect >> PAGE_SECTORS_SHIFT)
+/* Gives index (offset) of the sector within page. */
+#define SECT_IDX_IN_PAGE(sect)		((sect & SECTOR_MASK) << SECTOR_SHIFT)
+
 #define FREE_BATCH		16
 
 #define TICKS_PER_SEC		50ULL
@@ -708,20 +713,20 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
 	struct radix_tree_root *root;
 
 	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
-	idx = sector >> PAGE_SECTORS_SHIFT;
+	idx = PAGE_IDX_FROM_SECT(sector);
 	sector_bit = (sector & SECTOR_MASK);
 
 	t_page = radix_tree_lookup(root, idx);
-	if (t_page) {
-		__clear_bit(sector_bit, t_page->bitmap);
-
-		if (null_page_empty(t_page)) {
-			ret = radix_tree_delete_item(root, idx, t_page);
-			WARN_ON(ret != t_page);
-			null_free_page(ret);
-			if (is_cache)
-				nullb->dev->curr_cache -= PAGE_SIZE;
-		}
+	if (!t_page)
+		return;
+	__clear_bit(sector_bit, t_page->bitmap);
+
+	if (null_page_empty(t_page)) {
+		ret = radix_tree_delete_item(root, idx, t_page);
+		WARN_ON(ret != t_page);
+		null_free_page(ret);
+		if (is_cache)
+			nullb->dev->curr_cache -= PAGE_SIZE;
 	}
 }
 
@@ -733,11 +738,11 @@ static void null_zero_sector(struct nullb_device *d, sector_t sect,
 	unsigned int offset;
 	void *dest;
 
-	t_page = radix_tree_lookup(root, sect >> PAGE_SECTORS_SHIFT);
+	t_page = radix_tree_lookup(root, PAGE_IDX_FROM_SECT(sect));
 	if (!t_page)
 		return;
 
-	offset = (sect & SECTOR_MASK) << SECTOR_SHIFT;
+	offset = SECT_IDX_IN_PAGE(sect);
 	dest = kmap_atomic(t_page->page);
 	memset(dest + offset, 0, SECTOR_SIZE * nr_sects);
 	kunmap_atomic(dest);
@@ -797,7 +802,7 @@ static struct nullb_page *__null_lookup_page(struct nullb *nullb,
 	struct nullb_page *t_page;
 	struct radix_tree_root *root;
 
-	idx = sector >> PAGE_SECTORS_SHIFT;
+	idx = PAGE_IDX_FROM_SECT(sector);
 	sector_bit = (sector & SECTOR_MASK);
 
 	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
@@ -973,7 +978,7 @@ static int copy_to_nullb(struct nullb *nullb, struct page *source,
 		if (null_cache_active(nullb) && !is_fua)
 			null_make_cache_space(nullb, PAGE_SIZE);
 
-		offset = (sector & SECTOR_MASK) << SECTOR_SHIFT;
+		offset = SECT_IDX_IN_PAGE(sector);
 		t_page = null_insert_page(nullb, sector,
 			!null_cache_active(nullb) || is_fua);
 		if (!t_page)
@@ -1007,7 +1012,7 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
 	while (count < n) {
 		temp = min_t(size_t, nullb->dev->blocksize, n - count);
 
-		offset = (sector & SECTOR_MASK) << SECTOR_SHIFT;
+		offset = SECT_IDX_IN_PAGE(sector);
 		t_page = null_lookup_page(nullb, sector, false,
 			!null_cache_active(nullb));
 
-- 
2.17.0

