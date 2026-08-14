Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A8E1D8E01
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715284; cv=none; b=U1vl2e3OBw7eKYa85ODizfKW10P7cpmJG3/ZSfNom3CqesvBZC51Bqcpr2wAmlPD+sbD13aI9mQ+q0yECI0/bdH3qNaDVmhOeBoRXBplrT8UcLkp6JNYc65D9xm124G+fMXrHOhlQ25s38ZyoyGBQfhwop7dBTKW7oMASz22FVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715284; c=relaxed/simple;
	bh=FpF3IzHJoe+JMy1wvgirXX92e+AZ8FUaMNkj1xTPkg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0zaFo0llDpz7IAhiiRklzZWZUfbOYau9PcyYN6NO35tXGzDIapcV4A33GTPXSjnMANyF9n2Fe6CSmrOlWdbuM5xBVZEG7MZGfd2mY3sn1XQNuF+zHUDIFNCeyiSBkXIhl7weuTtuwJhhPy6rgfvWrOkjKIuFWEZaODaS2UtwMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=go+1+Y+R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="go+1+Y+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431451F00A3A;
	Fri, 14 Aug 2026 13:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715282;
	bh=uoKd7PMTHGl5NcRDa78FDJv9bYrv0b0HymIYVKyYZF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=go+1+Y+RA4EUAr0VGyVc9rt7/l/wUjhzNsTBO2i8xQw3ww2WDHIeKBmCK8SJFTHjw
	 QMzwBL3jayqcLBxh8pZAfwq+w8rDn3VmfGnAQjm4FGFTHYwSl3w9+IuOu2MCP2D7B0
	 qj/bH1FwW9oQRYZp0o5WcGLSOYuX+M22bmG329/iJgCzWO5Qy1PJVc2ZSHUtt3KWBv
	 ctQw9OfV31D+7rDhacJN1ods5deHqzyGmhjGzxj6JYz9JpD3+7tXx0gu8wb5A9XdNO
	 HjB+8XbxFld6AGgKcHZo4D7mG8iTapCSQ6/RzN/E1/enE4brmsVSS5YoRYDRxjZCkK
	 sKbRy7+KxHIog==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 01/13] block: remove disk_free_zone_resources()
Date: Fri, 14 Aug 2026 22:47:38 +0900
Message-ID: <20260814134750.2100304-2-dlemoal@kernel.org>
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

In the rare event when revalidating the zones of a zoned block device
fails, the device capacity will be dropped to 0. In such case, the zoned
block device will either be rescanned and restored or will be dropped
entirely and its gendisk will be destroyed. So calling
disk_free_zone_resources() from blk_revalidate_disk_zones() in case of
an error does not make much sense. We can keep the zone resources in case
the device is rescanned and restored and simply free all resources in
disk_release_zone_resources() when the gendisk is destroyed.

Remove the call to disk_free_zone_resources() from
blk_revalidate_disk_zones() and squash disk_free_zone_resources() inside
disk_release_zone_resources(). With this change, the conditional creation
of the zone write plugs work queue is not necessary anymore as the
workqueue will keep existing together with all other resources until the
disk is released. This simplifies disk_alloc_zone_resources().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

