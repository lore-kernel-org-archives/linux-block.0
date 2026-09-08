Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE4349EC7B
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857899; cv=none; b=sO7KWrHYDt+xsLXlAH5sBoKpivgdo5uOEQn5uX888Aij4aTCps48Le7fNZf/Y9XZ909dzRQJzm6h3H/B5khj7ElT9/G2EQyFyB18J8RTA2XXZpKtOtZ7+s56M1Kg/+XL7As6e3sIiwiXFZ/XI7rfmp0HSrzyWYCpWPPR0MXUYcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857899; c=relaxed/simple;
	bh=5wrB5Iel+OPUnIDJfN+aeVbQOekClcyr5UcmOcGMatw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McuvnDFVk/rVKA+PnpcnfyLY7jxyz9CK2Lfk6q5uS2ye/npgJylRuoBi5r1MBx7fn+aMPYcGwbktKgJlhM//exQTs94ERXLFYD+Odfh+HeP4WgS8lDxdIUQ3svk1sofpJYn2vhZZLM8iEN/z1044DvxvQEVHlJSK0ULT2XJFNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDXYLNS/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDXYLNS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77F51F00A3F;
	Tue,  8 Sep 2026 08:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857879;
	bh=HB1MmEyF4JJMrYeenhlBZKnl5ptYgQlPEUoJHyUPbCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aDXYLNS/aZBhn+YyeZKa2YRo3raRjZX9fVXDgRZUWEQs+o//vGOMcI2pPHYoodM5q
	 b65gULKW0SW3jFphNpXm7hPugxgKHgUuJScwQWSALDxj1n8NjbZ5i5PMMyeC488Aus
	 pAHNAgNlHIbzzpmY46+t6Ee375om+NwoDl7U6kregG5oGEMswDlYlsv3buc1w2wKlZ
	 qmQKRACef39gmraIdy5k88o4i/DeSxM7rUrvWz3oJJb2OBlk6DNoshQhxjuEXwRyNC
	 /KFygqgGbzJprG3tSGjO1SOT2dTh2bK0LjAxt10few2f6VgLDQfEy4B9e+mFowp2q9
	 41eHkCPH/P7tg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 03/16] block: refactor disk_revalidate_zone_resources()
Date: Tue,  8 Sep 2026 17:57:32 +0900
Message-ID: <20260908085745.1082697-4-dlemoal@kernel.org>
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
 block/blk-zoned.c | 77 ++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 8b3b5c7bfd03..993ddaf7acf1 100644
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
 
+static unsigned int disk_get_nr_zones(struct gendisk *disk, sector_t capacity)
+{
+	struct queue_limits *lim = &disk->queue->limits;
+
+	if (!capacity || !lim->chunk_sectors)
+		return 0;
+
+	return DIV_ROUND_UP_ULL(capacity, lim->chunk_sectors);
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
+static int disk_alloc_zone_resources(struct gendisk *disk, sector_t capacity)
 {
-	unsigned int i;
+	struct queue_limits *lim = &disk->queue->limits;
+	unsigned int nr_zones, pool_size, i;
 	int ret = -ENOMEM;
 
-	atomic_set(&disk->nr_zone_wplugs, 0);
+	nr_zones = disk_get_nr_zones(disk, capacity);
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
 
@@ -2002,41 +2024,18 @@ struct blk_revalidate_zone_args {
 	sector_t	sector;
 };
 
-static int disk_revalidate_zone_resources(struct gendisk *disk,
-				struct blk_revalidate_zone_args *args)
+static int disk_init_revalidate_args(struct gendisk *disk,
+				     struct blk_revalidate_zone_args *args)
 {
-	struct queue_limits *lim = &disk->queue->limits;
-	unsigned int pool_size;
-	int ret = 0;
-
 	args->disk = disk;
-	args->nr_zones =
-		DIV_ROUND_UP_ULL(args->capacity, lim->chunk_sectors);
+	args->nr_zones = disk_get_nr_zones(disk, args->capacity);
 
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
@@ -2330,11 +2329,21 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
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
+		ret = disk_alloc_zone_resources(disk, args.capacity);
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

