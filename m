Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831E22B9B7
	for <linux-block@vger.kernel.org>; Sat, 21 Feb 2026 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771634969; cv=none; b=LwJKhrRN/xw19UmuSSpPCzOCTUoRf6yowU5p/ad0CwmPSt0AzBIx4O9kUrVdUt1X3c3jVbSAFYYBLsQk46KaeDkWn22AB9bzjZbhKPRXPra6Uuu44DfNH5NGkeiH7b4Cu+df6R9KgWhOuubhLyBtlnLH6JBMHZIXFYFL3dWEJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771634969; c=relaxed/simple;
	bh=7ms1a7RpGa1hyxDgPi7zXz9zUYL3Z1CNjtJTRws0Ab4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaHaqWsz/4qPelzEQxEgRKCTQFVlM9lqL8RyTpab5EwkxMRCX4+Yv7debJFklyp2gBWnkRb3fLbaK1JrhbAWeFSHiPZ3+FCsOkesAJWhfpqn0Xn56LBk5t+F6S1jXRiSHdSV3Z0h3haQWEZOE4hfDx7Jmgq523QU4A3loxqUeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TutX/awc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TutX/awc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197DEC116C6;
	Sat, 21 Feb 2026 00:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771634969;
	bh=7ms1a7RpGa1hyxDgPi7zXz9zUYL3Z1CNjtJTRws0Ab4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TutX/awcvLAUth25BwzJ1y5oiwQQ2Pg404J6UUqkUU3kd6Ru7FLO4I3SacI2TmsW8
	 Z+7+lEwqrz5jtBj2nozRqyvinHqMzr7mJ8rfpis8PDYhwZNXH7IxA2LYFidQDrkCZI
	 kH6/Go1rwbh1kXHXegZ5B57cJMIkElIShraXqF+J33TM9oH0vaG6pAheYGJC8iUygy
	 B7suuuyVbDTp/KRr04k3TnuWgSdlqf5rpYidDTpJDO8OUOmhThe8nQqoFezpfRhwd5
	 Fn+/BhsGi41cmmTIiz+WKwsUjZC46tSS/H8vlWkoBuNiwB72KJM2fCiaYLryTTcH56
	 5d/A5bl/ZpEXQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/8] block: fix zone write plug removal
Date: Sat, 21 Feb 2026 09:44:04 +0900
Message-ID: <20260221004411.548482-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260221004411.548482-1-dlemoal@kernel.org>
References: <20260221004411.548482-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7b295187287e ("block: Do not remove zone write plugs still in
use") modified disk_should_remove_zone_wplug() to add a check on the
reference count of a zone write plug to prevent removing zone write
plugs from a disk hash table when the plugs are still being referenced
by BIOs in-flight. However, this check does not take into account that
a BIO completion may happen right after its submission by a zone write
plug BIO work, and before the zone write plug BIO work release the zone
write plug reference count. This situation leads to
disk_should_remove_zone_wplug() returning false. If the BIO that
completes in such manner transitioned the zone to the FULL condition,
the zone write plug for the FULL zone will remain in the disk hash
table.

Solve this by moving the check for removing a zone write plug from its
disk hash table from disk_zone_wplug_unplug_bio() into a new function
disk_check_and_put_zone_wplug() so that we can always check if a zone
write plug should be removed when the plug references are being
released. This new function calls disk_should_remove_zone_wplug() and
disk_remove_zone_wplug() with the zone write plug lock held when the
zone write plug reference count is equal to the minimum value (2)
indicating that only the caller context is referencing the zone write
plug. This is followed with a call to disk_put_zone_wplug() which may
cause the zone write plug to be freed if the plug was removed from the
disk hash table and the plug reference count dropped to 0.

The simpler disk_put_zone_write_plug() function is used whenever we
know that we have multiple references on a zone write plug, that is,
when we know that checking for the zone removal is not necessary.

Of note is that the calls to disk_should_remove_zone_wplug() and
disk_remove_zone_zone_wplug() are maintained in
disk_zone_wplug_set_wp_offset() because this function is called
directly while walking the disk zone write plug hash table without
taking references on zone write plugs when processing zone reset all
operations.

Fixes: 7b295187287e ("block: Do not remove zone write plugs still in use")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 52 +++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 846b8844f04a..9c38497e7258 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -655,6 +655,29 @@ static void disk_remove_zone_wplug(struct gendisk *disk,
 	disk_put_zone_wplug(zwplug);
 }
 
+static inline void disk_check_and_put_zone_wplug(struct blk_zone_wplug *zwplug)
+{
+	lockdep_assert_not_held(&zwplug->lock);
+
+	/*
+	 * Check for the need to remove the zone write plug from the hash list
+	 * when we see that only the caller is referencing the zone write plug.
+	 * Since this is racy without holding the zone write plug lock, this
+	 * check is done again in  disk_should_remove_zone_wplug().
+	 */
+	if (refcount_read(&zwplug->ref) <= 2) {
+		struct gendisk *disk = zwplug->disk;
+		unsigned long flags;
+
+		spin_lock_irqsave(&zwplug->lock, flags);
+		if (disk_should_remove_zone_wplug(disk, zwplug))
+			disk_remove_zone_wplug(disk, zwplug);
+		spin_unlock_irqrestore(&zwplug->lock, flags);
+	}
+
+	disk_put_zone_wplug(zwplug);
+}
+
 static void blk_zone_wplug_bio_work(struct work_struct *work);
 
 /*
@@ -835,7 +858,7 @@ static unsigned int disk_zone_wplug_sync_wp_offset(struct gendisk *disk,
 		if (zwplug->flags & BLK_ZONE_WPLUG_NEED_WP_UPDATE)
 			disk_zone_wplug_set_wp_offset(disk, zwplug, wp_offset);
 		spin_unlock_irqrestore(&zwplug->lock, flags);
-		disk_put_zone_wplug(zwplug);
+		disk_check_and_put_zone_wplug(zwplug);
 	}
 
 	return wp_offset;
@@ -1017,14 +1040,14 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 	spin_lock_irqsave(&zwplug->lock, flags);
 	if (zwplug->flags & BLK_ZONE_WPLUG_NEED_WP_UPDATE) {
 		spin_unlock_irqrestore(&zwplug->lock, flags);
-		disk_put_zone_wplug(zwplug);
+		disk_check_and_put_zone_wplug(zwplug);
 		return blkdev_report_zone_fallback(bdev, sector, zone);
 	}
 	zone->cond = zwplug->cond;
 	zone->wp = sector + zwplug->wp_offset;
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 
-	disk_put_zone_wplug(zwplug);
+	disk_check_and_put_zone_wplug(zwplug);
 
 	return 0;
 }
@@ -1107,7 +1130,7 @@ static void blk_zone_reset_bio_endio(struct bio *bio)
 		spin_lock_irqsave(&zwplug->lock, flags);
 		disk_zone_wplug_set_wp_offset(disk, zwplug, 0);
 		spin_unlock_irqrestore(&zwplug->lock, flags);
-		disk_put_zone_wplug(zwplug);
+		disk_check_and_put_zone_wplug(zwplug);
 	} else {
 		disk_zone_set_cond(disk, sector, BLK_ZONE_COND_EMPTY);
 	}
@@ -1165,7 +1188,7 @@ static void blk_zone_finish_bio_endio(struct bio *bio)
 		disk_zone_wplug_set_wp_offset(disk, zwplug,
 					      bdev_zone_sectors(bdev));
 		spin_unlock_irqrestore(&zwplug->lock, flags);
-		disk_put_zone_wplug(zwplug);
+		disk_check_and_put_zone_wplug(zwplug);
 	} else {
 		disk_zone_set_cond(disk, sector, BLK_ZONE_COND_FULL);
 	}
@@ -1530,7 +1553,7 @@ static void blk_zone_wplug_handle_native_zone_append(struct bio *bio)
 	disk_remove_zone_wplug(disk, zwplug);
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 
-	disk_put_zone_wplug(zwplug);
+	disk_check_and_put_zone_wplug(zwplug);
 }
 
 static bool blk_zone_wplug_handle_zone_mgmt(struct bio *bio)
@@ -1631,13 +1654,6 @@ static void disk_zone_wplug_unplug_bio(struct gendisk *disk,
 
 	zwplug->flags &= ~BLK_ZONE_WPLUG_PLUGGED;
 
-	/*
-	 * If the zone is full (it was fully written or finished, or empty
-	 * (it was reset), remove its zone write plug from the hash table.
-	 */
-	if (disk_should_remove_zone_wplug(disk, zwplug))
-		disk_remove_zone_wplug(disk, zwplug);
-
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 }
 
@@ -1701,7 +1717,7 @@ void blk_zone_write_plug_bio_endio(struct bio *bio)
 		disk_zone_wplug_unplug_bio(disk, zwplug);
 
 	/* Drop the reference we took when entering this function. */
-	disk_put_zone_wplug(zwplug);
+	disk_check_and_put_zone_wplug(zwplug);
 }
 
 void blk_zone_write_plug_finish_request(struct request *req)
@@ -1724,7 +1740,7 @@ void blk_zone_write_plug_finish_request(struct request *req)
 	disk_zone_wplug_unplug_bio(disk, zwplug);
 
 	/* Drop the reference we took when entering this function. */
-	disk_put_zone_wplug(zwplug);
+	disk_check_and_put_zone_wplug(zwplug);
 }
 
 static void blk_zone_wplug_bio_work(struct work_struct *work)
@@ -1777,7 +1793,7 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
 
 put_zwplug:
 	/* Drop the reference we took in disk_zone_wplug_schedule_bio_work(). */
-	disk_put_zone_wplug(zwplug);
+	disk_check_and_put_zone_wplug(zwplug);
 }
 
 void disk_init_zone_resources(struct gendisk *disk)
@@ -1850,7 +1866,7 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
 					     struct blk_zone_wplug, node);
 			refcount_inc(&zwplug->ref);
 			disk_remove_zone_wplug(disk, zwplug);
-			disk_put_zone_wplug(zwplug);
+			disk_check_and_put_zone_wplug(zwplug);
 		}
 	}
 
@@ -2112,7 +2128,7 @@ static int blk_revalidate_seq_zone(struct blk_zone *zone, unsigned int idx,
 	if (!zwplug)
 		return -ENOMEM;
 	spin_unlock_irqrestore(&zwplug->lock, flags);
-	disk_put_zone_wplug(zwplug);
+	disk_check_and_put_zone_wplug(zwplug);
 
 	return 0;
 }
-- 
2.53.0

