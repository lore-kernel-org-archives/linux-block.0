Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C724643C7AF
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445952; cv=none; b=JQIHUQc1bH8PFii44b1q3kAQcomFJz3WZvMbFOSX9VJdu1o9ZYFca/0FoVZbjCqGZxP8Ns5/7SYo3vikqR9CeNNGql8yTtww+/n7iCrKZKjJ6CX3wQJzsxU8mfcEAvikfDYNxtEBNuLEraMLvzdOdkhiMc89UM3vSW7TFUB+xVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445952; c=relaxed/simple;
	bh=sf6hvhn3K6BbLLdW4rNs302SWkOT06gStIhCMlY0yIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGQRpLBjzNZ3sWjJKY6FHEA/Jij+QBkyJQ+UQXv92hSPCtTWaX7ew5ChxDa5q9juCZcP9JV3l3SEBoFVe0qED+ZndbnFp9+l7tAWdAlz56jAv62WTKZPwf8zp83E7x3vdXWAlTsR7Avs5oKsDA4q9ApucS/n4El6CmRLAGWhGyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUG4bw4/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUG4bw4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F961F00A3A;
	Tue, 11 Aug 2026 10:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786445950;
	bh=Yg/e2+rhKB7VP3BsUm6f4Fb9oqjrU7fOyoyvZ6t0lJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MUG4bw4/kbvj6fLrlnEzyCwYSSPTLl3J8yBpaDF8aXSolOdx34x1NfyT23638HBOP
	 foFq7MXpw/OwyJwcQPrR8ICd/Dkb8jLKx7BtxI0WX74L9j4PYaY2sC8jqXByW+l+4B
	 6obZRReMXm2oD7OAyyZEeKCJ+w5DLX6/HnpsFwHJibCPzg5FyPa/x814TKPjynSNcw
	 efln/pqxXR3wrthy6qBFThcVggMNF40JUEaF/Y6PXG4E1jsrdfNvUHhy0SLQvdoLFx
	 d033sdfRp/Kc3rKHSRWNlqtIZjkvFY3KYynKoCEEfLVM9bmcQhLfVeqY7akng7Z0ej
	 n199YK0TB8Vrw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 09/13] block: always treat offline and read-only zones as dead
Date: Tue, 11 Aug 2026 19:58:48 +0900
Message-ID: <20260811105852.1245357-10-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811105852.1245357-1-dlemoal@kernel.org>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
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
---
 block/blk-zoned.c | 110 +++++++++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 51 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index ccbc04d855d3..b43b3745f700 100644
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

