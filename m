Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAB33C1405
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 02:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896858; cv=none; b=Vs+O9ErCSH16ezVTmOAOCDDaOAvpGDjok2pSMPNcPGShsTVFOLjz8900RVK9uBljuyAv3Cd4CjQFUbtmXQn2hbqoZZ2XjelNr3ITE3HDKlIltqK9JRVhPXx5K4Au6xrWqk9dsyLVQanWAnglYpbQCYXk/Ar1zFFLEovn9A/enBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896858; c=relaxed/simple;
	bh=pG4wT2XXfkLbHg9fEdc1mrTSx9CMGtXbQS7AOdrxkm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LupLP/Cy8QZ7+4jvVKnLXX3dlV4sQbD5v5Lo5xhTGPgK8gmJb+Ufqv3ZfGuxhlPHWry4WD8ytK8lvkb+bzIkEnk1qAyjwkGIny353yt7nZxNHOjbzHHS4mEsho0N5juY2Xv0HpU87D4OnB4Yj2/hipijG/JIHk0jQRwqLvAcyvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkUtnc4x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkUtnc4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F831F00A3A;
	Wed,  5 Aug 2026 02:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785896857;
	bh=sNMDFSO1LtUw9AC+jdoLItDlwlJ4U09MruI4OUouUZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CkUtnc4xDxl8vuGu2lz4fZexMKJRAr8LsCuo8ulIHFE72G11usFT4we8fh3YFuMtN
	 KEVRrQVm1GiceIp+tacxl5jRs4fhSpczE0lPZH36slC8jxEui4luAU9vh5DDeDOeOG
	 KXjYn1gh4sh2ZH2ZXIkTW+3CGh/17pN7OOVoXOa8INXxfXw8dKj2ycYszUO1RndpOI
	 OYEjL8qVskIiS9aoSifEtECaeqNR1A0uhzcQqRSBfGRkd0G+K4VdgwHo8RF/BaESFd
	 D1e61P0niY0Sd4/We8kh6dhEVT2i48yZz/sCxtJmBGMJ7zyA69lT1Xa9A6vunZ4nxH
	 SyaxwmYUhXXWQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 06/14] block: introduce disk_for_all_zone_wplugs()
Date: Wed,  5 Aug 2026 11:27:11 +0900
Message-ID: <20260805022719.735323-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805022719.735323-1-dlemoal@kernel.org>
References: <20260805022719.735323-1-dlemoal@kernel.org>
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
---
 block/blk-zoned.c | 68 +++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 60adc9a4c853..3bca7b0437d5 100644
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

