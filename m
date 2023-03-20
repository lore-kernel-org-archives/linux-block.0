Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7769EC7618A
	for <linux-block@archiver.kernel.org>; Mon, 20 Mar 2023 12:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjCTM4e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 08:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjCTM4I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 08:56:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5301F19134
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 05:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Xu1vqkF7PJnxvNy4qNA4zeyF3kBupZqS+7CPYkh1TlY=; b=Y5FcN+mOG6xPDck4HL8+8qau7e
        vxP+haw4hYanOLvdvCDIt+JzbErFmGXArZLuPL3/By9B1QXDCpX0ze0SmzOu6W1ky1eR6cdQI6MBO
        2sYBZrptcr70hwMH+f8/iMI2qdiuvWq43xIN9gjV7U+aLD1U7yoY9ATiH+GroylldfZdfGx2GWNDp
        h7BdyWgvSPdiQukDwAWUDI8t+I56Q/+XcyJBRwK/Si6sXSn8mVlV8q1H/4Q18EulgaeQKQlQExFns
        FhBVS4aK+8FSuDAOQbC902T2DJ+hg7+TBw5ktsg91rMGpHNd6X0xj1tt5SJAuisAG1DfsZPUVwQmH
        8ENTBgbA==;
Received: from [2001:4bb8:182:9278:b90a:2d0d:2b78:1b32] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1peF23-0091Dy-1L;
        Mon, 20 Mar 2023 12:54:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     hi@alyssa.is, linux-block@vger.kernel.org
Subject: [PATCH] loop: LOOP_CONFIGURE: send uevents for partitions
Date:   Mon, 20 Mar 2023 13:54:30 +0100
Message-Id: <20230320125430.55367-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Alyssa Ross <hi@alyssa.is>

LOOP_CONFIGURE is, as far as I understand it, supposed to be a way to
combine LOOP_SET_FD and LOOP_SET_STATUS64 into a single syscall.  When
using LOOP_SET_FD+LOOP_SET_STATUS64, a single uevent would be sent for
each partition found on the loop device after the second ioctl(), but
when using LOOP_CONFIGURE, no such uevent was being sent.

In the old setup, uevents are disabled for LOOP_SET_FD, but not for
LOOP_SET_STATUS64.  This makes sense, as it prevents uevents being
sent for a partially configured device during LOOP_SET_FD - they're
only sent at the end of LOOP_SET_STATUS64.  But for LOOP_CONFIGURE,
uevents were disabled for the entire operation, so that final
notification was never issued.  To fix this, reduce the critical
section to exclude the loop_reread_partitions() call, which causes
the uevents to be issued, to after uevents are re-enabled, matching
the behaviour of the LOOP_SET_FD+LOOP_SET_STATUS64 combination.

I noticed this because Busybox's losetup program recently changed from
using LOOP_SET_FD+LOOP_SET_STATUS64 to LOOP_CONFIGURE, and this broke
my setup, for which I want a notification from the kernel any time a
new partition becomes available.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
[hch: reduced the critical section]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Fixes: 3448914e8cc5 ("loop: Add LOOP_CONFIGURE ioctl")
---
 drivers/block/loop.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 839373451c2b7d..9d61c027185141 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1010,9 +1010,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
 
-	/* suppress uevents while reconfiguring the device */
-	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
-
 	/*
 	 * If we don't hold exclusive handle for the device, upgrade to it
 	 * here to avoid changing device under exclusive owner.
@@ -1067,6 +1064,9 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		}
 	}
 
+	/* suppress uevents while reconfiguring the device */
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
+
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
 	set_disk_ro(lo->lo_disk, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
@@ -1109,17 +1109,17 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	if (partscan)
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 
+	/* enable and uncork uevent now that we are done */
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
+
 	loop_global_unlock(lo, is_loop);
 	if (partscan)
 		loop_reread_partitions(lo);
+
 	if (!(mode & FMODE_EXCL))
 		bd_abort_claiming(bdev, loop_configure);
 
-	error = 0;
-done:
-	/* enable and uncork uevent now that we are done */
-	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
-	return error;
+	return 0;
 
 out_unlock:
 	loop_global_unlock(lo, is_loop);
@@ -1130,7 +1130,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	fput(file);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
-	goto done;
+	return error;
 }
 
 static void __loop_clr_fd(struct loop_device *lo, bool release)
-- 
2.39.2

