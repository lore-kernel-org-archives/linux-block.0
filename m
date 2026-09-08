Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572493ACA41
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857908; cv=none; b=rRuk1navb+AAYaWHe39TzWwJhJn34DfyCIY4+cwJSIiBCjnpg8Or2SfiaB9gxNnbidU7hDrM9jkkGGenSKE0/ZcpUs3e1EJim7QWfAO6cm0Bol9zXE3gV5oJw9kaKL4hJumt23o5FfAYfAOKRHNIk/jQUUS4cf9zQW+DreOGpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857908; c=relaxed/simple;
	bh=POfaIFVqK7n+5XDATlaYWLWKBBBfcBwF58lx9yPdQkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXOVtbEl0K2s7D6ytqmK8aU/IlMcXDmUw5ewt1Q1uvhj5V3cYIkV5xwJZl1HDSRX7X1sCwjyx8/sxxpcL9+ZEoqzHd9QYuKiIXWLd58Ji+y4MBa2STLDAYFjNhLkqIvNA9VJuur/1Z3ogaMubOEF7nAboMMcPp4taIhkEREoqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnVqgn3Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnVqgn3Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5EE1F01558;
	Tue,  8 Sep 2026 08:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857886;
	bh=g7d39S8sNKN/WhxoQ61hVxsxfxXvNk9ODI7gUHVjtbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QnVqgn3Zx7e8OO/6FWk15Wn3bA4b8jBpejjImusVrwfa8JqRkKJF3l92ivVAsZFMK
	 l2hOc7WKWdzD40YukeDfDW9znJ13bZOVU8Tqu6DbjIDR72rdu3XrJxmta9Xaqyjy9K
	 xdkCShe6o+a795MTSdwf9cXNgmMntoXY10zdVaRtUSEkBJiUrUEPqGTCgLjgf9Ed0A
	 OgvS3biPWfhxWfssdvRFp5paKZkBPHm5BA2YBb04b6m7C60eap1OV1Sn/QmY/1qb3Z
	 td8FtWwtRgQqYYOyEuaRu60N8FCNBbdDlGkSKcQBir8Jtzi4Yk/URR/neFp3eAIQwG
	 lPCnQeXVKm+Ug==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 13/16] block: always treat offline and read-only zones as dead
Date: Tue,  8 Sep 2026 17:57:42 +0900
Message-ID: <20260908085745.1082697-14-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908085745.1082697-1-dlemoal@kernel.org>
References: <20260908085745.1082697-1-dlemoal@kernel.org>
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c | 110 +++++++++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 51 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index ac94ab32564b..ecaeacf3b287 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -743,6 +743,53 @@ static inline void disk_put_zone_wplug(struct blk_zone_wplug *zwplug)
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
@@ -760,6 +807,12 @@ static void disk_mark_zone_wplug_dead(struct blk_zone_wplug *zwplug)
 
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
 
@@ -843,53 +896,6 @@ static struct blk_zone_wplug *disk_get_or_alloc_zone_wplug(struct gendisk *disk,
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
@@ -968,6 +974,7 @@ static unsigned int disk_zone_wplug_sync_state(struct gendisk *disk,
 			zwplug->flags &= ~BLK_ZONE_WPLUG_NEED_WP_UPDATE;
 			zwplug->cond = zone->cond;
 			zwplug->wp_offset = UINT_MAX;
+			disk_mark_zone_wplug_dead(zwplug);
 		}
 		if (zwplug->flags & BLK_ZONE_WPLUG_NEED_WP_UPDATE)
 			disk_zone_wplug_set_wp_offset(disk, zwplug, wp_offset);
@@ -1527,11 +1534,12 @@ static bool blk_zone_wplug_prepare_bio(struct blk_zone_wplug *zwplug,
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

