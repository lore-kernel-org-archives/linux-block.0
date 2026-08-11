Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907D73F8EA1
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445949; cv=none; b=DPQZn5VEBCiZkGtN/6mit4V1Rw1U1O8gxdjp4nr3EyWeEKWxTrxM0vp0imrpvLfIxExlfIEBC4afsbH2fUYjCp8dElD3jvR5MMIeWlHqBd2FlTp/x+v6SbbBWFV3FubUXsdRvU72l4xacgMhG6rz1iAAPt8fq0wtaOW5obdS3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445949; c=relaxed/simple;
	bh=AxYrXCWJTgtQ83CVxQDNRvl7ypjDfPJoJGphhcvI2No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t450hwph2d+Np2+c9TvOJr5LXQIUBAPDtANZsh9mYkx0F2P/KJ7vaEwggSlWk5ki3YqOH96v6BcsJeWn4r38sGBLyr+EdGmPU+KPtrL0hMvDGQi5MhyTJhzuRrdt/Q1/JuLW6sEdTytKu9GO8KY548/vN20ytVfAzE+qL/77wP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpT1IqF5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpT1IqF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAE71F000E9;
	Tue, 11 Aug 2026 10:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786445948;
	bh=vLTa1fSqnQnCw7CDUu2BuFpfmuDEo1OTILWjK276S5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OpT1IqF5lIF7MVXAth/d1fktCwJz0foIVhf4MXJeGFZCtdzQU/VLXsTuDHVtL1Qio
	 Nx3mV0MXw2yhfPAoHqO5CcGoYkzMqwRXzucpIomjK1gBaEQ4LOn+TPPYCbIytQqdK+
	 FIntEG6BjZyz/aMeX1NMfXHKaUvk1a0tGzj/4vxtn7V6c7vhdYSaWCTVyGrCWKzMrp
	 KyAXXrjQFyIXsXL/+MiE6qS5/COa+84NVCMlWpJ/btdkG0gqPYwzUYVDBoGLIsmqF4
	 0Zt97JsbOzrHI9VhmJzThJgSllHwgL71tLUJb7tJHPQ70qRd27yACEjPbm73BPlxbn
	 K20ULMYnh5cpg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 06/13] block: introduce disk_for_all_zone_wplugs()
Date: Tue, 11 Aug 2026 19:58:45 +0900
Message-ID: <20260811105852.1245357-7-dlemoal@kernel.org>
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

Introduce the helper function disk_for_all_zone_wplugs() to allow
executing an actor function on all hashed zone write plugs. This helper
is used to simplify the implementation of blk_zone_reset_all_bio_endio()
and queue_zone_wplugs_show().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 68 +++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 557ca986bccf..925f9bfcbd6b 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -662,6 +662,26 @@ static inline struct blk_zone_wplug *disk_get_zone_wplug(struct gendisk *disk,
 	return disk_get_hashed_zone_wplug(disk, sector);
 }
 
+static void disk_for_all_zone_wplugs(struct gendisk *disk,
+				     void (*actor)(struct blk_zone_wplug *,
+						   void *),
+				     void *data)
+{
+	struct blk_zone_wplug *zwplug;
+	unsigned int i;
+
+	if (!disk->zone_wplugs_hash)
+		return;
+
+	rcu_read_lock();
+	for (i = 0; i < disk_zone_wplugs_hash_size(disk); i++) {
+		hlist_for_each_entry_rcu(zwplug, &disk->zone_wplugs_hash[i],
+					 node)
+			actor(zwplug, data);
+	}
+	rcu_read_unlock();
+}
+
 static void disk_free_zone_wplug_rcu(struct rcu_head *rcu_head)
 {
 	struct blk_zone_wplug *zwplug =
@@ -1200,32 +1220,26 @@ static void blk_zone_reset_bio_endio(struct bio *bio)
 	}
 }
 
+static void disk_zone_wplug_reset_wp(struct blk_zone_wplug *zwplug, void *data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&zwplug->lock, flags);
+	disk_zone_wplug_set_wp_offset(zwplug->disk, zwplug, 0);
+	spin_unlock_irqrestore(&zwplug->lock, flags);
+}
+
 static void blk_zone_reset_all_bio_endio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
-	sector_t capacity = get_capacity(disk);
-	struct blk_zone_wplug *zwplug;
-	unsigned long flags;
 	sector_t sector;
-	unsigned int i;
 
-	if (atomic_read(&disk->nr_zone_wplugs)) {
-		/* Update the condition of all zone write plugs. */
-		rcu_read_lock();
-		for (i = 0; i < disk_zone_wplugs_hash_size(disk); i++) {
-			hlist_for_each_entry_rcu(zwplug,
-						 &disk->zone_wplugs_hash[i],
-						 node) {
-				spin_lock_irqsave(&zwplug->lock, flags);
-				disk_zone_wplug_set_wp_offset(disk, zwplug, 0);
-				spin_unlock_irqrestore(&zwplug->lock, flags);
-			}
-		}
-		rcu_read_unlock();
-	}
+	/* Update the condition of all zone write plugs. */
+	if (atomic_read(&disk->nr_zone_wplugs))
+		disk_for_all_zone_wplugs(disk, disk_zone_wplug_reset_wp, NULL);
 
 	/* Update the cached zone conditions. */
-	for (sector = 0; sector < capacity;
+	for (sector = 0; sector < get_capacity(disk);
 	     sector += bdev_zone_sectors(bio->bi_bdev))
 		disk_zone_set_cond(disk, sector, BLK_ZONE_COND_EMPTY);
 	clear_bit(GD_ZONE_APPEND_USED, &disk->state);
@@ -2509,8 +2523,9 @@ EXPORT_SYMBOL_GPL(blk_zone_issue_zeroout);
 
 #ifdef CONFIG_BLK_DEBUG_FS
 static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
-				  struct seq_file *m)
+				  void *data)
 {
+	struct seq_file *m = data;
 	unsigned int zwp_wp_offset, zwp_flags;
 	unsigned int zwp_zone_no, zwp_ref;
 	unsigned int zwp_bio_list_size;
@@ -2535,19 +2550,8 @@ static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
 int queue_zone_wplugs_show(void *data, struct seq_file *m)
 {
 	struct request_queue *q = data;
-	struct gendisk *disk = q->disk;
-	struct blk_zone_wplug *zwplug;
-	unsigned int i;
-
-	if (!disk->zone_wplugs_hash)
-		return 0;
 
-	rcu_read_lock();
-	for (i = 0; i < disk_zone_wplugs_hash_size(disk); i++)
-		hlist_for_each_entry_rcu(zwplug, &disk->zone_wplugs_hash[i],
-					 node)
-			queue_zone_wplug_show(zwplug, m);
-	rcu_read_unlock();
+	disk_for_all_zone_wplugs(q->disk, queue_zone_wplug_show, m);
 
 	return 0;
 }
-- 
2.55.0

