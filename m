Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2666B36A033;
	Wed, 15 Jul 2026 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784144399; cv=none; b=t6IXQU3APLRz7NZAEh87KiU2Hcjgj2luWImaM0/skOc1/Skfs6KLvp2gFbpDOg3ri1/sz5xBTDHIx8Q5H5WsFdhNykm22ifwhRJvvfqPuVPa+kSKw2h+//R4FT35XOXwdy4/QV7nzVRymKKiAv6v2ukBvayNouo7LcddvP/F+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784144399; c=relaxed/simple;
	bh=bQvxuIC7f71Wke5vQUt2qtJpSa5sPAWw77uMJuFBdxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nEGs4D0D2Y5yzg2YPVwpDULqnqhIZqBRAawxTwTS0orBgnyFwwr+/p4evVrQOZbLoh53wnQiR/aFCbHds9aAd1IaT4y1Oz7mbuYU8MXNMO48pirfsnza35Lir+yfVH7Xlg1j6g6mOo4SI0dOC2kKzu/smgt8FBIivdf7CdFKVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXElbKL2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXElbKL2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 630D6C2BCB7;
	Wed, 15 Jul 2026 19:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784144398;
	bh=bQvxuIC7f71Wke5vQUt2qtJpSa5sPAWw77uMJuFBdxs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=VXElbKL2/7jzmZM81akBjJ+5oZoVPHSNy2YYrmu2/hP7j4yOm3+gAlMwXbNjKGXXS
	 FGtQbauk7E1CbNbB9hwY+kWkEqwo54ni9k7ndlhdOm5NSy4lUg2m0O6KmCLIgOUwLJ
	 Kh58kEixx33k9nihlAKDMgImdJozM3TBYEDJan/RCub7HU501S/T7Aio4kK35nemen
	 0D/jMkXsbgYWPatcxM2uMWCgMQnteC5ZdDbsb5pKcfvWMoeZ9xK4T4o7SUUno+ub4g
	 PGYi0T2OpHFjBmbyHzpFldxPxG8R4og0+yXHxSDxNn6PvFxHDvUh9OVJFyRLrKWZrn
	 TgEVDRrx6VGSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5A7C4450F;
	Wed, 15 Jul 2026 19:39:58 +0000 (UTC)
From: Daan De Meyer via B4 Relay <devnull+daan.amutable.com@kernel.org>
Date: Wed, 15 Jul 2026 21:39:57 +0200
Subject: [PATCH] loop: remove manually added partitions on detach
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-loop-partition-cleanup-v1-1-b9f59910cd1e@amutable.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSw7CMAwFr1J5jaW0Kv1wFdSFEwwNKmlkpwip6
 t1JYDlP82YHZfGscKl2EH579WvIUJ8qcDOFB6O/ZYbGNJ3p6zPaFpd1jRhJkk/ZRrcwhS2iGdt
 +MM5042Ah/6Pw3X9+7ev0Z93sk10qwWJYUkYrFNxcphdpYoHj+AKW5WvWlgAAAA==
X-Change-ID: 20260715-b4-loop-partition-cleanup-094780c0698b
To: Jens Axboe <axboe@kernel.dk>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <oliver.sang@intel.com>, 
 Daan De Meyer <daan@amutable.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784144397; l=3576;
 i=daan@amutable.com; s=20260712; h=from:subject:message-id;
 bh=fPPZWG7NW2GU2Hqco/N/7L2VKe873LLf2vvD1GDAenU=;
 b=22HVTNT37nM6PwWYG6lZ2ORtb4FLk5KkfK15gwheSmG8xZJ5VW/9p98XNlXMHYtT1vtHArG4H
 ZsmQlUIZmXPAp2O5GQQBJTPXyQdDf+DScPjisxMrLA4/aZOFi8GPDmw
X-Developer-Key: i=daan@amutable.com; a=ed25519;
 pk=I1l+WwrtmzRgofA5SQ1wTuJi18fjh91w+f5uRkFeZEA=
X-Endpoint-Received: by B4 Relay for daan@amutable.com/20260712 with
 auth_id=868
X-Original-From: Daan De Meyer <daan@amutable.com>
Reply-To: daan@amutable.com

From: Daan De Meyer <daan@amutable.com>

Commit 267ec4d7223a ("loop: fix partition scan race between udev and
loop_reread_partitions()") stopped disk_force_media_change() from
setting GD_NEED_PART_SCAN because loop devices with LO_FLAGS_PARTSCAN
rescan partitions explicitly. However, partitions can also be added
manually with BLKPG while LO_FLAGS_PARTSCAN is clear.

When such a loop device is detached, __loop_clr_fd() skips
bdev_disk_changed(). Without GD_NEED_PART_SCAN, reopening the unbound
device no longer performs the previous lazy cleanup, leaving dead
partition devices behind. A subsequent LOOP_CONFIGURE can then fail its
partition scan with -EBUSY, as seen in blktests loop/009 after loop/008.

Call bdev_disk_changed() unconditionally during __loop_clr_fd(). The
disk capacity is already zero and the release path holds open_mutex, so
this drops all partitions without rescanning the detached backing file.

The new blktests loop/013 case covers this sequence by adding a partition
with BLKPG without LO_FLAGS_PARTSCAN, detaching the loop device, and
checking that the partition is gone when the device is reopened.

Fixes: 267ec4d7223a ("loop: fix partition scan race between udev and loop_reread_partitions()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202607150754.b660f5b9-lkp@intel.com
Signed-off-by: Daan De Meyer <daan@amutable.com>
---
 drivers/block/loop.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 310de0463beb..1faecef33009 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1113,6 +1113,7 @@ static void __loop_clr_fd(struct loop_device *lo)
 	struct queue_limits lim;
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
+	int err;
 
 	spin_lock_irq(&lo->lo_lock);
 	filp = lo->lo_backing_file;
@@ -1146,26 +1147,21 @@ static void __loop_clr_fd(struct loop_device *lo)
 
 	disk_force_media_change(lo->lo_disk);
 
-	if (lo->lo_flags & LO_FLAGS_PARTSCAN) {
-		int err;
-
-		/*
-		 * open_mutex has been held already in release path, so don't
-		 * acquire it if this function is called in such case.
-		 *
-		 * If the reread partition isn't from release path, lo_refcnt
-		 * must be at least one and it can only become zero when the
-		 * current holder is released.
-		 */
-		err = bdev_disk_changed(lo->lo_disk, false);
-		if (err)
-			pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
-				__func__, lo->lo_number, err);
-		/* Device is gone, no point in returning error */
-	}
+	/*
+	 * Remove all partitions, including partitions added manually with
+	 * BLKPG, which may exist even if LO_FLAGS_PARTSCAN is not set.
+	 *
+	 * open_mutex has been held already in release path, so don't acquire
+	 * it here.
+	 */
+	err = bdev_disk_changed(lo->lo_disk, false);
+	if (err)
+		pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
+			__func__, lo->lo_number, err);
+	/* Device is gone, no point in returning error */
 
 	/*
-	 * lo->lo_state is set to Lo_unbound here after above partscan has
+	 * lo->lo_state is set to Lo_unbound here after removing partitions has
 	 * finished. There cannot be anybody else entering __loop_clr_fd() as
 	 * Lo_rundown state protects us from all the other places trying to
 	 * change the 'lo' device.

---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260715-b4-loop-partition-cleanup-094780c0698b

Best regards,
--  
Daan De Meyer <daan@amutable.com>


