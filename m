Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A56343D63
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032305; cv=none; b=o7CJifDDwvD03R8DSOSlaFt8nh6wjYwpU/oUg/gDAhnTdsEjQTaVcx74viGZB3329aAdKCV/IXZLSL7rJSKMMauc77UvIpracQx/qjBcKoPF0ZEc2qRcByOawjsdJo0dJ8pSofhiCTVsxJP8qU6DOQJE8isHhQ5LXFFt9SU3BNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032305; c=relaxed/simple;
	bh=022IJSRDJ6u8p3+fu/lkkIjsAEisYVuuz870vVTlxME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQQ16AkZCXdC3/yMpStd0sp1ybf/tSeyFSGtkPGXVLxqOhbgGCfMcwkexsA6ilaYDNa1j+lH+VAJmkiZKNVm8bF0/gUz62wz8LznGogVuEV73bELulAC9gUNi6j0dJX55FQq8D8rqCK411I++ORD8mPRg+R8tMPSLgo7ednB3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOyhrAal; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOyhrAal"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44FE1F000E9;
	Thu,  6 Aug 2026 16:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032304;
	bh=np06tKvMm5uA0XgdfGJcw2VL0YiEYORZ2Quku3b1+u4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dOyhrAalt1DPT/Zfirniq9zsPl7VFMgzyQm61F4S2Uz4RFA0ijoSS9cLDkYETrMfW
	 L2kQUdn61EhJjuErlzACb0ovM7XMYZUZW3M+kR8aL4QtZhfoNfDVW+C07mVGRx703R
	 vBLTjbwIpXdbAO380lralRzf5SfeVnEt5x67OQgiz1wuw17M6vZqUyT7ZFUmLU64fd
	 JY3DXZD5xUjkg4wphR04g/zvUOLDACjWFS0eDSTUbb0Dx2LOyt/udy7wa7ORzGvZ95
	 UuaZDp2+p3sbf7cr+15OcKNztXcMeEYrQwbfQ6teiztqZxa9NHDkXlQaueZWp0t9pZ
	 PGryKdNmx5Tbg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 09/13] block: always treat offline and read-only zones as dead
Date: Fri,  7 Aug 2026 01:04:41 +0900
Message-ID: <20260806160445.848337-10-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806160445.848337-1-dlemoal@kernel.org>
References: <20260806160445.848337-1-dlemoal@kernel.org>
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
---
 block/blk-zoned.c | 113 +++++++++++++++++++++++++---------------------
 1 file changed, 61 insertions(+), 52 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index cb34d0beaf43..0f0ffe832008 100644
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
@@ -967,8 +973,10 @@ static unsigned int disk_zone_wplug_sync_state(struct gendisk *disk,
 		spin_lock_irqsave(&zwplug->lock, flags);
 		if (zwplug->flags & BLK_ZONE_WPLUG_NEED_WP_UPDATE)
 			disk_zone_wplug_set_wp_offset(disk, zwplug, wp_offset);
-		if (disk_zone_cond_is_offline_or_readonly(zone->cond))
+		if (disk_zone_cond_is_offline_or_readonly(zone->cond)) {
 			zwplug->cond = zone->cond;
+			disk_mark_zone_wplug_dead(zwplug);
+		}
 		spin_unlock_irqrestore(&zwplug->lock, flags);
 		disk_put_zone_wplug(zwplug);
 	}
@@ -1521,11 +1529,12 @@ static bool blk_zone_wplug_prepare_bio(struct blk_zone_wplug *zwplug,
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

