Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A08340DB8
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715287; cv=none; b=raNai45ne0ICjrqIXyTIQpYfo4QzPEowl+jMIjCwiGwt6O/G/5JRP5aZbq+b8RQr/hYLMRR7YzJ7s010xDJenyZf+V0CrOrircPQScAhUJPY92sVQ5CFzegfNoRwPclGW4FgvTyLVmw7JlTlb4zv4kziITnJRtJQrHk1OTYlFHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715287; c=relaxed/simple;
	bh=F+obadVbMfQP9YVLyX63lzqqT/UQfqG1wVKou7smUU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEgm6b/92CFQplesL9KqDqtdzdYR7x5j7BmZOVyyrsDDJWwLiS0nAk59XurGlwXUGLyENhZ4v7IRGYrPLHRF+dwFLnCb6TXv0e/UfA+bz5ng+trxb4JJJ589yzUcmNEOJJ4k0rd1mrK4PRfZgGkF/T/hhRIGGbCV5tBoAKrAItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjiNLqXP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjiNLqXP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099EB1F00A3E;
	Fri, 14 Aug 2026 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715286;
	bh=Ve3aG5/QoBdk2IqgI8h0tKOG7aV7G0i74O6hjVMziQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EjiNLqXPatz/MiamFyo5aLmrqraqMYBba5gFli37YLjb3lPX5xqsHZq+EFHodbGvX
	 4G+IchccX9pB60TTyaYr4qKrSsj4oWJupMnK2wHGbnRdypYSrEz8P8h3m0244JDjL2
	 /gV83KVfM8rf3F5B5I3FTXcnATZ9nMmJw6lqUSIzG+KJ1YMAqRH1Uq57IPynijbbvO
	 I0UGytVQXwxa/gSv/JHmMV2k//yPKfusRkLkHoELsZVR9EMNrdcxMC+YrGgA3CRhQs
	 8rXWsFNc62XfG0gc5wjUl2/53B/xOmlkcYAe+MvYqYrYGmf/yawCJtz3OQEbKf8Tll
	 xljXmsrjI+lmA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 06/13] block: introduce disk_for_all_zone_wplugs()
Date: Fri, 14 Aug 2026 22:47:43 +0900
Message-ID: <20260814134750.2100304-7-dlemoal@kernel.org>
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

Introduce the helper function disk_for_all_zone_wplugs() to allow
executing an actor function on all hashed zone write plugs. This helper
is used to simplify the implementation of blk_zone_reset_all_bio_endio()
and queue_zone_wplugs_show().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 68 +++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index e3c28db5690c..83737c9a92d8 100644
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
@@ -2514,8 +2528,9 @@ EXPORT_SYMBOL_GPL(blk_zone_issue_zeroout);
 
 #ifdef CONFIG_BLK_DEBUG_FS
 static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
-				  struct seq_file *m)
+				  void *data)
 {
+	struct seq_file *m = data;
 	unsigned int zwp_wp_offset, zwp_flags;
 	unsigned int zwp_zone_no, zwp_ref;
 	unsigned int zwp_bio_list_size;
@@ -2540,19 +2555,8 @@ static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
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

