Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9F3371CFF
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 06:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689137; cv=none; b=nX41UHMZ4qGq9Caw1VaF89lxvn7fCGBPse/ivF4upE0FyYxPVtNNU1wnPlxlhFeoaWlJeo4Xi4/N/ToblFSnTy9OFr7bwl+bhwGXZ5UWZonu6RmR8mHtnNvZWIq5EUF6+1NuuOfS3XvEPk+tvHW7qImNz9ZSk5Dr7Zm4pZ8h6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689137; c=relaxed/simple;
	bh=QE/0/buNleJmT+y1KEGXz08vWmURzH0i9KQjIBek8x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrJxiQoX5C/+ax+HTxbjF4jehdszCppQlLuy2A8kCibVhhdc32t/uUpm9yK/e5RD2Og2g2xrI50BaraDI8J4IgJddDqHALu6lr7vFvn6M2Ik1sbGuy1ReDWx470VtWczjFoXk8dss4QEnRG5siz11CYDfibLxnJCMDRQyXT2GKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxSlRtXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxSlRtXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66451F00A3D;
	Fri, 14 Aug 2026 06:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786689135;
	bh=087VlQrVhyik0dLWAyQOED0pwFJ8AKPvkH4Z+LEusaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RxSlRtXYsoGYG2cpOTL0rvAMODAPtYbUnaNI39fxcpilS5QHCd8g3vamnDrG+xkfD
	 u9CP+6P/WvVogFI0BMTINF5P0pPYDPCW7ocaldx1OYEOdyvVB6G9JYzPC5nT8pt5HM
	 AGjIb5QMFmxfrSRAkWxHrEDbm4i/2Eik1w7WHycRfwUwZ8R+vU5x7AEerxob100+wf
	 ZoMHPrUGWE6m2rFWVK9lEAzM/3Fk3nbfzTX50sOHpvaYzoDAPf1+NPC7or2t93MKCs
	 3h/VMtCfQGL414vRFGSx3G70iT0+antGilH4vsPDzJZa8HN9MooHCNk2QFbdJ0d3TK
	 uSDb4JIqa186Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 02/13] block: refactor disk_revalidate_zone_resources()
Date: Fri, 14 Aug 2026 15:31:50 +0900
Message-ID: <20260814063201.1762743-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814063201.1762743-1-dlemoal@kernel.org>
References: <20260814063201.1762743-1-dlemoal@kernel.org>
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

