Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13ABC433F5
	for <linux-block@archiver.kernel.org>; Fri, 27 May 2022 05:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243017AbiE0F6O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 May 2022 01:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbiE0F6L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 May 2022 01:58:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026DE3A18F
        for <linux-block@vger.kernel.org>; Thu, 26 May 2022 22:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kvkxB51uUiZEsmCSNcfGEI81a4XYEz0zdOH+fH5VPQU=; b=r4kiAEAAcMZHplf8pn29rb92hO
        kqO7sOnFdXnPy8NL0Gsibz2358aVGB+8iLBMD2FhleNfMRokZeaHSalFpqTfZV3W2Vl+6qjdiXe49
        LvPqQEEo8sCvAKd/Chlei6sO95ZKCDprVpaYJhOExmB+rBjifmWdRLPyb069Ee4E7OVjMebMEtraK
        d4X5cHNLuN50UTUlck2BQYqlZ8WvcteU515puMX9l3G1plvIMvuRrIC3OfkupZPuGuDpn87o0cpoR
        oOU4VARgkwV1m0Z0Rr+euPun81oDXYQhxaDZYxzQEPldl4oafBeMAIRAefa2Lc/nTcaWrAiUO6gq3
        AeTokPDA==;
Received: from [2001:4bb8:18c:7298:b5ab:7d49:c6be:2011] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuSzA-00GifB-HU; Fri, 27 May 2022 05:58:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block, loop: support partitions without scanning
Date:   Fri, 27 May 2022 07:58:06 +0200
Message-Id: <20220527055806.1972352-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Historically we did distinguish between a flag that surpressed partition
scanning, and a combinations of the minors variable and another flag if
any partitions were supported.  This was generally confusing and doesn't
make much sense, but some corner case uses of the loop driver actually
do want to support manually added partitions on a device that does not
actively scan for partitions.  To make things worsee the loop driver
also wants to dynamically toggle the scanning for partitions on a live
gendisk, which makes the disk->flags updates non-atomic.

Introduce a new GD_SUPPRESS_PART_SCAN bit in disk->state that disables
just scanning for partitions, and toggle that instead of GENHD_FL_NO_PART
in the loop driver.

Fixes: 1ebe2e5f9d68 ("block: remove GENHD_FL_EXT_DEVT")
Reported-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c          | 2 ++
 drivers/block/loop.c   | 8 ++++----
 include/linux/blkdev.h | 1 +
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 36532b9318419..27205ae47d593 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -385,6 +385,8 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
 
 	if (disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN))
 		return -EINVAL;
+	if (test_bit(GD_SUPPRESS_PART_SCAN, &disk->state))
+		return -EINVAL;
 	if (disk->open_partitions)
 		return -EBUSY;
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e2cb51810e89a..5bef97ffbe21e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1102,7 +1102,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 	if (partscan)
-		lo->lo_disk->flags &= ~GENHD_FL_NO_PART;
+		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 
 	loop_global_unlock(lo, is_loop);
 	if (partscan)
@@ -1198,7 +1198,7 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	 */
 	lo->lo_flags = 0;
 	if (!part_shift)
-		lo->lo_disk->flags |= GENHD_FL_NO_PART;
+		set_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 	mutex_lock(&lo->lo_mutex);
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&lo->lo_mutex);
@@ -1308,7 +1308,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 
 	if (!err && (lo->lo_flags & LO_FLAGS_PARTSCAN) &&
 	     !(prev_lo_flags & LO_FLAGS_PARTSCAN)) {
-		lo->lo_disk->flags &= ~GENHD_FL_NO_PART;
+		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 		partscan = true;
 	}
 out_unlock:
@@ -2011,7 +2011,7 @@ static int loop_add(int i)
 	 * userspace tools. Parameters like this in general should be avoided.
 	 */
 	if (!part_shift)
-		disk->flags |= GENHD_FL_NO_PART;
+		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
 	mutex_init(&lo->lo_mutex);
 	lo->lo_number		= i;
 	spin_lock_init(&lo->lo_lock);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1b24c1fb3bb1e..608d577734c29 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -147,6 +147,7 @@ struct gendisk {
 #define GD_DEAD				2
 #define GD_NATIVE_CAPACITY		3
 #define GD_ADDED			4
+#define GD_SUPPRESS_PART_SCAN		5
 
 	struct mutex open_mutex;	/* open/close mutex */
 	unsigned open_partitions;	/* number of open partitions */
-- 
2.30.2

