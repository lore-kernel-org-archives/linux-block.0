Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA003C4338F
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 06:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F12C60F44
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 06:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbhG0GeT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 02:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhG0GeS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 02:34:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82120C061757
        for <linux-block@vger.kernel.org>; Mon, 26 Jul 2021 23:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HB7rNV45IS9PO1uEkgO0reCsc2KGPQDSQYd5O6nEhuM=; b=Z+ZXmvSzAWaiAOl0x6sf6njw0s
        XmR7mACAZzCgspFdtzg6qNUZChKiw3M2ct423pzsSRrDaBcGS94GUo/FtIa5TXQiwGOMUevNr0MNe
        Q3Kj+ONTICF/y8QBNhJobzk2AFUHNXa8TKv8BM0n4j1SW/M4djYFemI+OzedhnfMCwOvt/+vL3QlY
        YpxlmdntcMrm62yHJhKa0w0Pw9AH+SANRuEpm1/OrZuIzUfzXaP+WuBvPnpOmlxhc+G9C4SZmF07z
        6oCKuwi4Y1qahLn2AV/OmCQwk0O/wNSC7hXeaf9IDbJeITKPveP/KwFmI/7NfJWVGF2TZE93QHl32
        /qTOYtgw==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8Gdn-00EkdE-3O; Tue, 27 Jul 2021 06:32:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 6/6] block: remove disk_name()
Date:   Tue, 27 Jul 2021 08:25:18 +0200
Message-Id: <20210727062518.122108-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727062518.122108-1-hch@lst.de>
References: <20210727062518.122108-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the disk_name function now that all users are gone.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h   |  1 -
 block/genhd.c | 17 +++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 4b885c0f6708..56f33fbcde59 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -344,7 +344,6 @@ static inline void blk_queue_clear_zone_settings(struct request_queue *q) {}
 
 int blk_alloc_ext_minor(void);
 void blk_free_ext_minor(unsigned int minor);
-char *disk_name(struct gendisk *hd, int partno, char *buf);
 #define ADDPART_FLAG_NONE	0
 #define ADDPART_FLAG_RAID	1
 #define ADDPART_FLAG_WHOLEDISK	2
diff --git a/block/genhd.c b/block/genhd.c
index ffdbdefdea7b..966e32fecfa4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -78,11 +78,17 @@ bool set_capacity_and_notify(struct gendisk *disk, sector_t size)
 EXPORT_SYMBOL_GPL(set_capacity_and_notify);
 
 /*
- * Format the device name of the indicated disk into the supplied buffer and
- * return a pointer to that same buffer for convenience.
+ * Format the device name of the indicated block device into the supplied buffer
+ * and return a pointer to that same buffer for convenience.
+ *
+ * Note: do not use this in new code, use the %pg specifier to sprintf and
+ * printk insted.
  */
-char *disk_name(struct gendisk *hd, int partno, char *buf)
+const char *bdevname(struct block_device *bdev, char *buf)
 {
+	struct gendisk *hd = bdev->bd_disk;
+	int partno = bdev->bd_partno;
+
 	if (!partno)
 		snprintf(buf, BDEVNAME_SIZE, "%s", hd->disk_name);
 	else if (isdigit(hd->disk_name[strlen(hd->disk_name)-1]))
@@ -92,11 +98,6 @@ char *disk_name(struct gendisk *hd, int partno, char *buf)
 
 	return buf;
 }
-
-const char *bdevname(struct block_device *bdev, char *buf)
-{
-	return disk_name(bdev->bd_disk, bdev->bd_partno, buf);
-}
 EXPORT_SYMBOL(bdevname);
 
 static void part_stat_read_all(struct block_device *part,
-- 
2.30.2

