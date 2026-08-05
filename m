Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF53D23BD05
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896854; cv=none; b=eVvcw0qNzZ4XWCfDcGdlKqa3QMRe9IS2hhRQRjBgsTo/b6gXyT5CarU7baLvgo1r1Tc7rzt55D9NuKxxrtsrfbG2s3ZLMBKBr6ksMjISnmBAPbvCf6MNP6Ax4qhN2ufvzGkcG9ACIdVc8nbYwo/+KWgLgTX6or2PAJ7J8X2QiSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896854; c=relaxed/simple;
	bh=/4PwvuOo5zl5+XKcEANc/333NMt6CjZZ86t7dFAKtYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxD10cOoOqYmatpz98BELELA7qT4dAWXGisKfCFRd7KMs3yh62n9EcCg+FOMf0sV8VI32eJaQ8opZqmEAk6O9zUUCLJvKlED6OsOyusBZggLnD4CgirI4BpMG6NnZc7REoMjzeRYqe8GqJKnrK2C8C+oNSYPKzXxXrb+0NPCDZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn9Jajte; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn9Jajte"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130881F000E9;
	Wed,  5 Aug 2026 02:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785896853;
	bh=KmN6SkKLf4CDzNZcI+Mv1ntrjcxPWEIPjGDtxOKfesA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qn9Jajte3ckBCX4VlZiZRgfvBR5feyStu9BvinerMWpG522qTowCJJ4n803kgyuBt
	 Ri6AO9JiWYvTcxZpNtc8+3mEpck4yZ0RL+ga4EAkTJI8PekgQXnYYFhkGg8ImQ+fCS
	 vr5YqazcDKuzVXyMr0DVbamxKbEbL/wberW3tPZiilDXHEyjOhPczbcdhy6sp4lviu
	 khmAVAssLf9saXMbd5YsAv0aRsZG85rtKCBC/UpIecPnuwsUQMh4JFvSgm8lByDmJS
	 aVrkKPw1CLLq6WuMnwNKHW7z45Ax4NC2zH02HEF+Jgxq5kPMBiBoQxMQH5azDOyArV
	 OoDqV6npiZFfA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/14] block: refactor disk_revalidate_zone_resources()
Date: Wed,  5 Aug 2026 11:27:07 +0900
Message-ID: <20260805022719.735323-3-dlemoal@kernel.org>
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

The function disk_revalidate_zone_resources() is misnamed as it does not
revalidate anything but rather allocates the revalidation arguments and
then calls disk_alloc_zone_resources() to initialize the disk zone
resources if they are needed and not already allocated.

Make this function less confusing by renaming it
disk_init_revalidate_args() and moving the call to
disk_alloc_zone_resources() into blk_revalidate_disk_zones(). As before,
this function is only called if the zone resources are needed and not yet
allocated.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 69 ++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index fd9d8878c15c..ba51e600ae92 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1854,12 +1854,20 @@ static int disk_zone_wplugs_worker(void *data)
 
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
+	return DIV_ROUND_UP_ULL(get_capacity(disk), lim->chunk_sectors);
+}
+
 /*
  * For the size of a disk zone write plug hash table, use the size of the
  * zone write plug mempool, which is the maximum of the disk open zones and
@@ -1869,13 +1877,21 @@ void disk_init_zone_resources(struct gendisk *disk)
 #define BLK_ZONE_WPLUG_MAX_HASH_BITS		9
 #define BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE	128
 
-static int disk_alloc_zone_resources(struct gendisk *disk,
-				     unsigned int pool_size)
+static int disk_alloc_zone_resources(struct gendisk *disk)
 {
-	unsigned int i;
+	struct queue_limits *lim = &disk->queue->limits;
+	unsigned int nr_zones = disk_get_nr_zones(disk);
+	unsigned int pool_size, i;
 	int ret = -ENOMEM;
 
-	atomic_set(&disk->nr_zone_wplugs, 0);
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
 
@@ -2001,41 +2017,18 @@ struct blk_revalidate_zone_args {
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
@@ -2328,11 +2321,21 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
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

