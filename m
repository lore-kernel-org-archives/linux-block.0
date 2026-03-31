Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EEC3B52EE
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955591; cv=none; b=JgvKNm7kmn7IA4o9YzDwZmGnLfAiFXTOdZn5AVgnt2VOtOkzxcSx52Y4ezPDeaja52NrG/RZywTC6oojRjzVXK2J0BJfWhvC0wqogyGQCmCSmuQF/OYDvVVXis7ViJ5uhyPMoKsC+FXzLRS5Oz/Ou1RXIn2jQSJRPCUd/Ulo1lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955591; c=relaxed/simple;
	bh=rjIaNuNO1AJtED+G4F9LAS5MfAAcge7rOSFjLmkXFZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=byvdtqaCrnqG638l91/J8MRm/rvbiVvbAO4WUC+0EcEKBlKcLgLYW4KcSPTPf5lmLBEM1VkUoYBkkCD2Uo1UDaQiP8feiJ7cv2qdGEvtgoO/YV+GNM3se02nsz2a3TPrrNzN4ugmaIgEDJFv2ZTOoi4b/tRUi6pUk31IdF35wYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vYR0VFEm; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vYR0VFEm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774955586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MKEEzO6l0+D+mGX7YfKKWb6NrwZQIYwtHK8fKRjb5k8=;
	b=vYR0VFEml7VUDcoNyeVLFWTHPlMMbgq7wprjvN/zVjrco4bd+d3cdilVWR54IBlhoXVkDD
	gGt0E4E0bXHZWQib2796eJet1cKHKmaFhFNqkBZsfJTAZ74XwqY4omrcaqei85VgdNr8aJ
	dnVurT5w2RmgDm7VKKk6S3RG/Q6dN+w=
From: Jackie Liu <liu.yun@linux.dev>
To: dlemoal@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH v3] block: fix zones_cond memory leak on zone revalidation error paths
Date: Tue, 31 Mar 2026 19:12:16 +0800
Message-ID: <20260331111216.24242-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jackie Liu <liuyun01@kylinos.cn>

When blk_revalidate_disk_zones() fails after disk_revalidate_zone_resources()
has allocated args.zones_cond, the memory is leaked because no error path
frees it.

Fixes: 6e945ffb6555 ("block: use zone condition to determine conventional zones")
Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/blk-zoned.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 9d1dd6ccfad7..42b9a10138c3 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1910,6 +1910,7 @@ static int disk_revalidate_zone_resources(struct gendisk *disk,
 {
 	struct queue_limits *lim = &disk->queue->limits;
 	unsigned int pool_size;
+	int ret = 0;
 
 	args->disk = disk;
 	args->nr_zones =
@@ -1932,10 +1933,13 @@ static int disk_revalidate_zone_resources(struct gendisk *disk,
 		pool_size =
 			min(BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE, args->nr_zones);
 
-	if (!disk->zone_wplugs_hash)
-		return disk_alloc_zone_resources(disk, pool_size);
+	if (!disk->zone_wplugs_hash) {
+		ret = disk_alloc_zone_resources(disk, pool_size);
+		if (ret)
+			kfree(args->zones_cond);
+	}
 
-	return 0;
+	return ret;
 }
 
 /*
@@ -1967,6 +1971,7 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	disk->zone_capacity = args->zone_capacity;
 	disk->last_zone_capacity = args->last_zone_capacity;
 	disk_set_zones_cond_array(disk, args->zones_cond);
+	args->zones_cond = NULL;
 
 	/*
 	 * Some devices can advertise zone resource limits that are larger than
@@ -2249,21 +2254,30 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	}
 	memalloc_noio_restore(noio_flag);
 
+	if (ret <= 0)
+		goto free_resources;
+
 	/*
 	 * If zones where reported, make sure that the entire disk capacity
 	 * has been checked.
 	 */
-	if (ret > 0 && args.sector != capacity) {
+	if (args.sector != capacity) {
 		pr_warn("%s: Missing zones from sector %llu\n",
 			disk->disk_name, args.sector);
 		ret = -ENODEV;
+		goto free_resources;
 	}
 
-	if (ret > 0)
-		return disk_update_zone_resources(disk, &args);
+	ret = disk_update_zone_resources(disk, &args);
+	if (ret)
+		goto free_resources;
+
+	return 0;
 
+free_resources:
 	pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
 
+	kfree(args.zones_cond);
 	memflags = blk_mq_freeze_queue(q);
 	disk_free_zone_resources(disk);
 	blk_mq_unfreeze_queue(q, memflags);
-- 
2.51.1

