Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E327A478865
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032303; cv=none; b=qeG77Gqupx2it/pgQ6kR/OTEUGuBuv/T9FmaDVYgVnV9Es0j6HO38GTzj/MxrvzGiED0GdfVPRdrxW9aO+qy/pdF6TqoQofZ8YkXD5p38i5ZOGEb75CxMZCrRLumzX0fhCdYuhQORTynNB+oD324CVlIiaxyVtdBXGaA81LNykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032303; c=relaxed/simple;
	bh=s//su08orCENwksiJxDZTePnuxQ2/DO7BM5wjVKtrUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWpu0NdeIVEEFpQsx56m9D+ZLJvgaXPGxLpGVoi5GUFYKeM1Edd2cLbuXBv0O7V4Zlhf/KbJDUDpo89yslYGslA2/mwKUj1k23tluAp0ztLXqXsths/TPwc8KH53rRX/2s8FyrV2emYvaVFAJktmWd0FQFyAl2S21RRcgR1n+Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBKT1Xag; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBKT1Xag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F8E1F000E9;
	Thu,  6 Aug 2026 16:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032301;
	bh=lZeBvuufVU0f+eo7q7cg37inMiPfeknwC9DeLMO4Odw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eBKT1XagJYvcQqwk/WYblftu5L0yajMDjow2NHIH4Q5HJdo3F6kjaBEL2e/aw9LD/
	 kB3PY8W8+YFg5w/fvWUx8wZzEtN6pBjkiDQs5O2+0Cn6AQXaiSTmCpQcsvaOQX99Of
	 mFgkg5Y4MS6QpofYekDt9Lg+0uuYM6IWPM+9kqas0YHgM7aI374U4egGn+pBslmGXZ
	 60fX/MYUSSeYJ4PS5nFoVv1CiPlafgq9a9zNnLa4xPz2wCNxQMi+D5u9u8R9fEn0KB
	 b81MT0c8zVluNVk3oopUjKyoAq2pN9ma9KL1eh02JyFWS5f981RbylgTjHBNFTfqIZ
	 N+Fov18nxR1SA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 06/13] block: introduce disk_for_all_zone_wplugs()
Date: Fri,  7 Aug 2026 01:04:38 +0900
Message-ID: <20260806160445.848337-7-dlemoal@kernel.org>
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
index c1090155d961..53c43a9413a1 100644
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
@@ -2508,8 +2522,9 @@ EXPORT_SYMBOL_GPL(blk_zone_issue_zeroout);
 
 #ifdef CONFIG_BLK_DEBUG_FS
 static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
-				  struct seq_file *m)
+				  void *data)
 {
+	struct seq_file *m = data;
 	unsigned int zwp_wp_offset, zwp_flags;
 	unsigned int zwp_zone_no, zwp_ref;
 	unsigned int zwp_bio_list_size;
@@ -2534,19 +2549,8 @@ static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
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

