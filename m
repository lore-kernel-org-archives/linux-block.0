Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81092EA754
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715292; cv=none; b=ub+9tduMD4FlLgKMj0YWPyajjtkl50MGLn0pCXAKnxo0xJv3zYeOPGWrgK8CvtpSIoGToIJjj9wFPWZRpCvAtvvBrMfPSn0AXLz+vAdxhiU6r8vvDRHZdIP659j+cO5JnAgftvOaBh98g4gigbSdVn4pob0wi9K7YtOAViO3g2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715292; c=relaxed/simple;
	bh=V4I9kvom9ZBC9X2k7Najp7efjbSIlMHQ4aM2MFFllBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5SWkmKrcYLvCj/rC3Fm8KzTtPsIuQ7h4zyQlrcnu1Hy8VbaoLDZErfJ/dr1hzDMKbCkVfNVoUWFOMQBMCQ5Wo04lkmcPyjZYY1rj1DBDd3d2GeeV/v8d1BcPes0943YDnk6z2STj3rn9iMp344p/HfhuHim2cnleuEcqJevx38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F62ywIgt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F62ywIgt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463641F00A3D;
	Fri, 14 Aug 2026 13:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715288;
	bh=WRrgIMCOs/EWgJF+gfF2O345YDyJdax0sJ8XOLwmwvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F62ywIgtSLhdE5tRkzTo7fOmbZZuG6TkMTFz8kHXHxq0fNqhMte7ZC8TMw9J2h5BE
	 1OQkAng8WMz1q/IXBaa+8/j2rZEDgYHBujp5zi22dBML1AvUl/DgWFg39f5nfWgsvs
	 tMAFd+ZVzVC52HPY74rGkfCefm75f/3moEdqgom/c1kNFc38brM31lrKf22lMTHfjz
	 xjM1vsPxp/MT4rmWJZwZ9ZF/apL+1Ggh7BQzbeavxVZ7UULyOsO8VbSP7/0tVEOijm
	 XKGAqNPe/A1FnE/tFaIh6jWX+eyJ5UHykh9pgy5VOmGcAODm1roSpp21IIxp5QtZuY
	 t1sLwdDpiqvzA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 09/13] block: always treat offline and read-only zones as dead
Date: Fri, 14 Aug 2026 22:47:46 +0900
Message-ID: <20260814134750.2100304-10-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814134750.2100304-1-dlemoal@kernel.org>
References: <20260814134750.2100304-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since any write BIO targeting an offline or a read-only zone will fail,
there is no point in keeping zone write plugs for these zones.
So for any offline or read-only zone, the zone write plug should always
be treated as dead.

Do this by modifying disk_check_zone_wplug_dead() to always mark read-only
and offline zones as dead to force a removal of the zone write plug from
the disk hash table on BIO submission. blk_zone_wplug_prepare_bio() is
also modified to have the same checks to immediately fail a write BIO
targeting a read-only or offline zone. With these two changes, any newly
issued or unplugged write BIO targeting a read-only or offline zone is
immediately failed.

Finally, disk_zone_wplug_sync_state() is modified to add a call to
disk_mark_zone_wplug_dead() for the zone write plug of any read-only or
offline zone found during zone revalidation or a report zones.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 110 +++++++++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 51 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 28fcf37dba0b..b88860cf5864 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -744,6 +744,53 @@ static inline void disk_put_zone_wplug(struct blk_zone_wplug *zwplug)
 		disk_free_zone_wplug(zwplug);
 }
 
+static inline void blk_zone_wplug_bio_io_error(struct blk_zone_wplug *zwplug,
+					       struct bio *bio)
+{
+	struct request_queue *q = zwplug->disk->queue;
+
+	bio_clear_flag(bio, BIO_ZONE_WRITE_PLUGGING);
+	bio_io_error(bio);
+	disk_put_zone_wplug(zwplug);
+	/* Drop the reference taken by disk_zone_wplug_add_bio(). */
+	blk_queue_exit(q);
+}
+
+/*
+ * Abort (fail) all plugged BIOs of a zone write plug.
+ */
+static void disk_zone_wplug_abort(struct blk_zone_wplug *zwplug)
+{
+	struct gendisk *disk = zwplug->disk;
+	struct bio *bio;
+
+	lockdep_assert_held(&zwplug->lock);
+
+	if (bio_list_empty(&zwplug->bio_list))
+		return;
+
+	pr_warn_ratelimited("%s: zone %u: Aborting plugged BIOs\n",
+			    zwplug->disk->disk_name, zwplug->zone_no);
+	while ((bio = bio_list_pop(&zwplug->bio_list)))
+		blk_zone_wplug_bio_io_error(zwplug, bio);
+
+	zwplug->flags &= ~BLK_ZONE_WPLUG_PLUGGED;
+
+	/*
+	 * If we are using the per disk zone write plugs worker thread, remove
+	 * the zone write plug from the work list and drop the reference we
+	 * took when the zone write plug was added to that list.
+	 */
+	if (blk_queue_zoned_qd1_writes(disk->queue)) {
+		spin_lock(&disk->zone_wplugs_list_lock);
+		if (!list_empty(&zwplug->entry)) {
+			list_del_init(&zwplug->entry);
+			disk_put_zone_wplug(zwplug);
+		}
+		spin_unlock(&disk->zone_wplugs_list_lock);
+	}
+}
+
 /*
  * Flag the zone write plug as dead and drop the initial reference we got when
  * the zone write plug was added to the hash table. The zone write plug will be
@@ -761,6 +808,12 @@ static void disk_mark_zone_wplug_dead(struct blk_zone_wplug *zwplug)
 
 static inline bool disk_check_zone_wplug_dead(struct blk_zone_wplug *zwplug)
 {
+	if (disk_zone_wplug_is_offline_or_readonly(zwplug)) {
+		disk_zone_wplug_abort(zwplug);
+		disk_mark_zone_wplug_dead(zwplug);
+		return true;
+	}
+
 	if (!(zwplug->flags & BLK_ZONE_WPLUG_DEAD))
 		return false;
 
@@ -844,53 +897,6 @@ static struct blk_zone_wplug *disk_get_or_alloc_zone_wplug(struct gendisk *disk,
 	return zwplug;
 }
 
-static inline void blk_zone_wplug_bio_io_error(struct blk_zone_wplug *zwplug,
-					       struct bio *bio)
-{
-	struct request_queue *q = zwplug->disk->queue;
-
-	bio_clear_flag(bio, BIO_ZONE_WRITE_PLUGGING);
-	bio_io_error(bio);
-	disk_put_zone_wplug(zwplug);
-	/* Drop the reference taken by disk_zone_wplug_add_bio(). */
-	blk_queue_exit(q);
-}
-
-/*
- * Abort (fail) all plugged BIOs of a zone write plug.
- */
-static void disk_zone_wplug_abort(struct blk_zone_wplug *zwplug)
-{
-	struct gendisk *disk = zwplug->disk;
-	struct bio *bio;
-
-	lockdep_assert_held(&zwplug->lock);
-
-	if (bio_list_empty(&zwplug->bio_list))
-		return;
-
-	pr_warn_ratelimited("%s: zone %u: Aborting plugged BIOs\n",
-			    zwplug->disk->disk_name, zwplug->zone_no);
-	while ((bio = bio_list_pop(&zwplug->bio_list)))
-		blk_zone_wplug_bio_io_error(zwplug, bio);
-
-	zwplug->flags &= ~BLK_ZONE_WPLUG_PLUGGED;
-
-	/*
-	 * If we are using the per disk zone write plugs worker thread, remove
-	 * the zone write plug from the work list and drop the reference we
-	 * took when the zone write plug was added to that list.
-	 */
-	if (blk_queue_zoned_qd1_writes(disk->queue)) {
-		spin_lock(&disk->zone_wplugs_list_lock);
-		if (!list_empty(&zwplug->entry)) {
-			list_del_init(&zwplug->entry);
-			disk_put_zone_wplug(zwplug);
-		}
-		spin_unlock(&disk->zone_wplugs_list_lock);
-	}
-}
-
 /*
  * Update a zone write plug condition based on the write pointer offset.
  */
@@ -969,6 +975,7 @@ static unsigned int disk_zone_wplug_sync_state(struct gendisk *disk,
 			zwplug->flags &= ~BLK_ZONE_WPLUG_NEED_WP_UPDATE;
 			zwplug->cond = zone->cond;
 			zwplug->wp_offset = UINT_MAX;
+			disk_mark_zone_wplug_dead(zwplug);
 		}
 		if (zwplug->flags & BLK_ZONE_WPLUG_NEED_WP_UPDATE)
 			disk_zone_wplug_set_wp_offset(disk, zwplug, wp_offset);
@@ -1524,11 +1531,12 @@ static bool blk_zone_wplug_prepare_bio(struct blk_zone_wplug *zwplug,
 		return false;
 
 	/*
-	 * Check that the user is not attempting to write to a full zone.
-	 * We know such BIO will fail, and that would potentially overflow our
-	 * write pointer offset beyond the end of the zone.
+	 * Check that the user is not attempting to write to a full, read-only
+	 * or offline zone. We know such BIOs will fail, so there is no point
+	 * in issuing them.
 	 */
-	if (disk_zone_wplug_is_full(disk, zwplug))
+	if (disk_zone_wplug_is_full(disk, zwplug) ||
+	    disk_zone_wplug_is_offline_or_readonly(zwplug))
 		return false;
 
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-- 
2.55.0

