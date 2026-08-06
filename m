Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCC0343D63
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032299; cv=none; b=PDv8Zb8b9bUiO/MHEzHdOv7WyElkMcdNTE5SmruAdrvM7LlQi7/U0LljkkEPSb0ZPIcnMS9zgoKJMDZGHGXWS5z9NcLcolTzNnzuWhH7d6aUEHx3kR2WUn1XROO0wlkDgqnb08MGqUK2bVd8jrexe5r3gS7n3plFJyyi5Zb3wpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032299; c=relaxed/simple;
	bh=GcltVTmo/2f4dC9ma1YkiCn4dO2eP13iSp9l6aA/oq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzCxKRoajhCITAQx5r+nNEJVu6YxpFrM89roXrQ7jMZR+xSxApzLh6eK3M8i6fsOOTOiC7EYvTEqev1BoPrkv5Ge1qiBfWgaNiWfwI+RN1LjSNuB8ykdXEIiF7CtBsuhQxKWejVuW7Y3hFtUb393aBFtlzYnsUO4qtIO0sM9AC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9Yp3xR5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9Yp3xR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAFC1F00A3A;
	Thu,  6 Aug 2026 16:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032298;
	bh=IuZSAqMUUItmMSGpU+e1DKPGj7tldYUGBcXomQmSQDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D9Yp3xR57GUYrHaEHSp8c9I++kz7p7c2vk7VJrXYwRrrmf5fdmbIQKem9ViedZdkY
	 tnLpcfzy1hLeCS0xIlHD4Khf7hjXkW4+fCEPM4FQxy460dDZ5SNmGjaS6X3GptRJic
	 VR9vh1tEc9z39iXYvsOFiDJHyGbeINxi5LAfICDQjsWUnZ9+Mvizwm+gNgYkZCEIzA
	 9u/4KeCZsH3fJbya1jPFF3TizHZV2GetOPREGm5ND9MeqfrDtFzmdsIT2yPui7lNJ1
	 /3VWiGQ2spm+ZKtvqbY8Ln0Btmab4XVlBdyNvx/bwpiwrKIncOwNhDX4Mjz4kmH+1F
	 kMZO3jNvyOc5w==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 01/13] block: remove disk_free_zone_resources()
Date: Fri,  7 Aug 2026 01:04:33 +0900
Message-ID: <20260806160445.848337-2-dlemoal@kernel.org>
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

In the rare event when revalidating the zones of a zoned block device
fails, the device capacity will be dropped to 0. In such case, the zoned
block device will either be rescanned and restored or dropped entirely and
its gendisk destroyed. So calling disk_free_zone_resources() from
blk_revalidate_disk_zones() in case of error does not make much sense. We
can keep the zone resources in case the device is rescanned and restored
or simply free all resources in disk_release_zone_resources() when the
gendick is destroyed.

Remove the call to disk_free_zone_resources() from
blk_revalidate_disk_zones() and squash disk_free_zone_resources() inside
disk_release_zone_resources(). With this change, the conditional creation
of the zone write plugs work queue is not necessary anymore as the
workqueue will keep existing together with all other resources until the
disk is released. This simplifies disk_alloc_zone_resources().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-zoned.c | 56 +++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 36 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index a5afb842bf35..b47e32bf4602 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1893,21 +1893,6 @@ static int disk_alloc_zone_resources(struct gendisk *disk,
 	if (!disk->zone_wplugs_pool)
 		goto free_hash;
 
-	/*
-	 * We may already have a zone write plug workqueue as this function may
-	 * be called after disk_free_zone_resources(), which does not destroy
-	 * the workqueue (the zone write plugs workqueue is destroyed at
-	 * disk_release() time).
-	 */
-	if (!disk->zone_wplugs_wq) {
-		disk->zone_wplugs_wq =
-			alloc_workqueue("%s_zwplugs",
-					WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU,
-					pool_size, disk->disk_name);
-		if (!disk->zone_wplugs_wq)
-			goto destroy_pool;
-	}
-
 	disk->zone_wplugs_worker =
 		kthread_create(disk_zone_wplugs_worker, disk,
 			       "%s_zwplugs_worker", disk->disk_name);
@@ -1918,8 +1903,18 @@ static int disk_alloc_zone_resources(struct gendisk *disk,
 	}
 	wake_up_process(disk->zone_wplugs_worker);
 
+	disk->zone_wplugs_wq =
+		alloc_workqueue("%s_zwplugs",
+				WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU,
+				pool_size, disk->disk_name);
+	if (!disk->zone_wplugs_wq)
+		goto stop_worker;
+
 	return 0;
 
+stop_worker:
+	kthread_stop(disk->zone_wplugs_worker);
+	disk->zone_wplugs_worker = NULL;
 destroy_pool:
 	mempool_destroy(disk->zone_wplugs_pool);
 	disk->zone_wplugs_pool = NULL;
@@ -1975,7 +1970,7 @@ static void disk_set_zones_cond_array(struct gendisk *disk, u8 *zones_cond)
 	kfree_rcu_mightsleep(zones_cond);
 }
 
-static void disk_free_zone_resources(struct gendisk *disk)
+void disk_release_zone_resources(struct gendisk *disk)
 {
 	if (disk->zone_wplugs_worker) {
 		kthread_stop(disk->zone_wplugs_worker);
@@ -1983,8 +1978,10 @@ static void disk_free_zone_resources(struct gendisk *disk)
 	}
 	WARN_ON_ONCE(!list_empty(&disk->zone_wplugs_list));
 
-	if (disk->zone_wplugs_wq)
-		drain_workqueue(disk->zone_wplugs_wq);
+	if (disk->zone_wplugs_wq) {
+		destroy_workqueue(disk->zone_wplugs_wq);
+		disk->zone_wplugs_wq = NULL;
+	}
 
 	disk_destroy_zone_wplugs_hash_table(disk);
 
@@ -1994,16 +1991,6 @@ static void disk_free_zone_resources(struct gendisk *disk)
 	disk->nr_zones = 0;
 }
 
-void disk_release_zone_resources(struct gendisk *disk)
-{
-	if (disk->zone_wplugs_wq) {
-		destroy_workqueue(disk->zone_wplugs_wq);
-		disk->zone_wplugs_wq = NULL;
-	}
-
-	disk_free_zone_resources(disk);
-}
-
 struct blk_revalidate_zone_args {
 	struct gendisk	*disk;
 	u8		*zones_cond;
@@ -2317,11 +2304,11 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	sector_t zone_sectors = q->limits.chunk_sectors;
 	sector_t capacity = get_capacity(disk);
 	struct blk_revalidate_zone_args args = { };
-	unsigned int memflags, noio_flag;
 	struct blk_report_zones_args rep_args = {
 		.cb = blk_revalidate_zone_cb,
 		.data = &args,
 	};
+	unsigned int noio_flag;
 	int ret = -ENOMEM;
 
 	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
@@ -2359,7 +2346,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	memalloc_noio_restore(noio_flag);
 
 	if (ret <= 0)
-		goto free_resources;
+		goto free_args;
 
 	/*
 	 * If zones where reported, make sure that the entire disk capacity
@@ -2369,22 +2356,19 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		pr_warn("%s: Missing zones from sector %llu\n",
 			disk->disk_name, args.sector);
 		ret = -ENODEV;
-		goto free_resources;
+		goto free_args;
 	}
 
 	ret = disk_update_zone_resources(disk, &args);
 	if (ret)
-		goto free_resources;
+		goto free_args;
 
 	return 0;
 
-free_resources:
+free_args:
 	pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
 
 	kfree(args.zones_cond);
-	memflags = blk_mq_freeze_queue(q);
-	disk_free_zone_resources(disk);
-	blk_mq_unfreeze_queue(q, memflags);
 
 	return ret;
 }
-- 
2.55.0

