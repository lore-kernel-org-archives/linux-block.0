Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B501F3A5E90
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 03:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788147701; cv=none; b=Gp9BnnkncbpnZTH786OpYu0zJB1CCGp0/QOsGAzs8SLRG2QLTsP6OJ/wQhQH6T7rRQ5zw9RWC3NHlCPKKeFdws9OtE925Z642a3i+bbmur0FcDqRNaw8MIBxyZ2pc8/pUykl0Wyz0wQVhpX/Dgli+YfpiPR2dUJeQQlTaAn9aNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788147701; c=relaxed/simple;
	bh=QE/0/buNleJmT+y1KEGXz08vWmURzH0i9KQjIBek8x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIMy7yld9Oc2eE+sbSDwPCsN43TuZUGYqC5l2k9M15olu66j/xgHo2+xA5M6stjPTAQJFU2ChMhLKXMehrpBDp13n7qpN1/5Qm6ZpMP8tBT9YLAKsUlJEW2VZPOUxOpZZPTKM+MsiIdK0kxbMITZZLU8HmdHzRCBeqOM3oDxM4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ef5oZxgq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef5oZxgq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A16C1F00A3E;
	Mon, 31 Aug 2026 03:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788147683;
	bh=087VlQrVhyik0dLWAyQOED0pwFJ8AKPvkH4Z+LEusaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ef5oZxgqMuzWAFr19+J439NtmE7DltJaf4bj6Yg7HPPEWn5tRDXgRP8LsRZ1ELbDL
	 kglDOf8sY4hFjCOW0JviuifoOBvvgHra8yP5fo6yHfVW1T3eq2xwYeTgoiluUsi5Ek
	 7Esz9pad3LRObrDmsQwkFMLJqasfnkyrgvpV+JF3l/yc0VzANkvGRVcqcFhQzPv1r5
	 SiNOeEp1wX+1VFj7qBMMpC5fObQKyQmyTiEIQ2U7kcsaDn3rT9QAeQSvtmlwSPfq17
	 mYvEXJRIMHvOSTlgHk8wyPaNVss/B1bGOQZ8DZVVGsSWmm9R521UCEfbHyuvEQfmQA
	 NIZl4Hi7Zdyvg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 02/12] block: refactor disk_revalidate_zone_resources()
Date: Mon, 31 Aug 2026 12:40:59 +0900
Message-ID: <20260831034109.744039-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831034109.744039-1-dlemoal@kernel.org>
References: <20260831034109.744039-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function disk_revalidate_zone_resources() is misnamed as it does not
revalidate anything but rather allocates the revalidation arguments and
then calls disk_alloc_zone_resources() to initialize the disk zone
resources if they are needed and not already allocated.

Make this function less confusing by renaming it
disk_init_revalidate_args() and moving the call to
disk_alloc_zone_resources() into blk_revalidate_disk_zones(). As before,
this function is only called if the zone resources are needed and not yet
allocated. The initialization of the atomic nr_zone_wplugs is also moved
to the function disk_init_zone_resources() so that this is done once and
not on all revalidation.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c | 75 ++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index b47e32bf4602..0c298fefecf8 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1854,12 +1854,23 @@ static int disk_zone_wplugs_worker(void *data)
 
 void disk_init_zone_resources(struct gendisk *disk)
 {
+	atomic_set(&disk->nr_zone_wplugs, 0);
 	spin_lock_init(&disk->zone_wplugs_hash_lock);
 	spin_lock_init(&disk->zone_wplugs_list_lock);
 	INIT_LIST_HEAD(&disk->zone_wplugs_list);
 	init_completion(&disk->zone_wplugs_worker_bio_done);
 }
 
+static unsigned int disk_get_nr_zones(struct gendisk *disk)
+{
+	struct queue_limits *lim = &disk->queue->limits;
+
+	if (!lim->chunk_sectors)
+		return 0;
+
+	return DIV_ROUND_UP_ULL(get_capacity(disk), lim->chunk_sectors);
+}
+
 /*
  * For the size of a disk zone write plug hash table, use the size of the
  * zone write plug mempool, which is the maximum of the disk open zones and
@@ -1869,13 +1880,24 @@ void disk_init_zone_resources(struct gendisk *disk)
 #define BLK_ZONE_WPLUG_MAX_HASH_BITS		9
 #define BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE	128
 
-static int disk_alloc_zone_resources(struct gendisk *disk,
-				     unsigned int pool_size)
+static int disk_alloc_zone_resources(struct gendisk *disk)
 {
-	unsigned int i;
+	struct queue_limits *lim = &disk->queue->limits;
+	unsigned int nr_zones, pool_size, i;
 	int ret = -ENOMEM;
 
-	atomic_set(&disk->nr_zone_wplugs, 0);
+	nr_zones = disk_get_nr_zones(disk);
+	if (!nr_zones)
+		return -ENODEV;
+
+	/*
+	 * If the device has no limit on the maximum number of open and active
+	 * zones, use BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE.
+	 */
+	pool_size = max(lim->max_open_zones, lim->max_active_zones);
+	if (!pool_size)
+		pool_size = min(BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE, nr_zones);
+
 	disk->zone_wplugs_hash_bits =
 		min(ilog2(pool_size) + 1, BLK_ZONE_WPLUG_MAX_HASH_BITS);
 
@@ -2001,41 +2023,18 @@ struct blk_revalidate_zone_args {
 	sector_t	sector;
 };
 
-static int disk_revalidate_zone_resources(struct gendisk *disk,
+static int disk_init_revalidate_args(struct gendisk *disk,
 				struct blk_revalidate_zone_args *args)
 {
-	struct queue_limits *lim = &disk->queue->limits;
-	unsigned int pool_size;
-	int ret = 0;
-
 	args->disk = disk;
-	args->nr_zones =
-		DIV_ROUND_UP_ULL(get_capacity(disk), lim->chunk_sectors);
+	args->nr_zones = disk_get_nr_zones(disk);
 
 	/* Cached zone conditions: 1 byte per zone */
 	args->zones_cond = kzalloc(args->nr_zones, GFP_NOIO);
 	if (!args->zones_cond)
 		return -ENOMEM;
 
-	if (!disk_need_zone_resources(disk))
-		return 0;
-
-	/*
-	 * If the device has no limit on the maximum number of open and active
-	 * zones, use BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE.
-	 */
-	pool_size = max(lim->max_open_zones, lim->max_active_zones);
-	if (!pool_size)
-		pool_size =
-			min(BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE, args->nr_zones);
-
-	if (!disk->zone_wplugs_hash) {
-		ret = disk_alloc_zone_resources(disk, pool_size);
-		if (ret)
-			kfree(args->zones_cond);
-	}
-
-	return ret;
+	return 0;
 }
 
 /*
@@ -2328,11 +2327,21 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	}
 
 	/*
-	 * Ensure that all memory allocations in this context are done as if
-	 * GFP_NOIO was specified.
+	 * Allocate zone resources if they are needed and we have not done
+	 * so yet, and initialize the revalidation arguments passed to report
+	 * zones. Ensure that all memory allocations in this context are done as
+	 * if GFP_NOIO was specified.
 	 */
 	noio_flag = memalloc_noio_save();
-	ret = disk_revalidate_zone_resources(disk, &args);
+	if (disk_need_zone_resources(disk) && !disk->zone_wplugs_hash) {
+		ret = disk_alloc_zone_resources(disk);
+		if (ret) {
+			memalloc_noio_restore(noio_flag);
+			return ret;
+		}
+	}
+
+	ret = disk_init_revalidate_args(disk, &args);
 	if (ret) {
 		memalloc_noio_restore(noio_flag);
 		return ret;
-- 
2.55.0

