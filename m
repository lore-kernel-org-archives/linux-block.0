Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A13ED10A
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946893; cv=none; b=frsxBGrENFaKjDFiV4cSywbWnHkfxIwk8xN07TdEHInYqWldMU8g5IPj7PkFctt1p9Cn/LcFmOooTXah8W69WU4naCJ2cOA13ebhf89qxnAq1GRVZr9r0zz3QG6f+43cP4wdVg/g3LBdgsle4s7HOUjet9I/foHBh2pVGnkVuW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946893; c=relaxed/simple;
	bh=PlTKqJERiEcVY4uLb6ivjnfwiQSCNaWeG2bAkWrcsK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Axp4ffKW1dejmwzeWsUYrfxVqyhfx9X9c3YOXFG5HgQJioffx0gqIp1iijo0Y32BY+dTkLb7lU7okGkPFxA7RCnay27sw+iNmgV8MZC46gSsQFEiJ45U7EKTwd/6mMW7dsfeJJ1F3Miwyi8lN7yN4HKn+yrMvIsxRhJzU5k+BA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZCyoFkrn; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZCyoFkrn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774946890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EYh6qhvMGHaMb53xZ+1xXdMieG0+56GtOQVsAZ2f87g=;
	b=ZCyoFkrnvQtdfFbLqHvwk7svaBwYvKg9kpXozoqEkHOZr9hjwpwtzQPeITABLDdvoFJJuE
	7Wc2D3G546B+w839ndOf9AJTLFEAan8aRqPJf+pHpu0P5jrhm/r8IHfYMNosVzwBKvNZ6N
	YuGzhj/0dbxFUlsh1BTLvCuSBCT7BWM=
From: Jackie Liu <liu.yun@linux.dev>
To: dlemoal@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: fix zones_cond memory leak in blk_revalidate_disk_zones()
Date: Tue, 31 Mar 2026 16:47:31 +0800
Message-ID: <20260331084731.45283-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jackie Liu <liuyun01@kylinos.cn>

Fix memory leaks of args.zones_cond allocated in
disk_revalidate_zone_resources() on multiple error paths:

1) When disk_revalidate_zone_resources() itself fails (e.g.
   disk_alloc_zone_resources() returns an error), blk_revalidate_disk_zones()
   returns directly without freeing args.zones_cond.

2) When report_zones() fails or the capacity check fails,
   disk_free_zone_resources() only frees the old disk->zones_cond, not
   the newly allocated args.zones_cond.

3) When the nr_conv_zones validation fails in disk_update_zone_resources(),
   the code jumps to unfreeze before disk_set_zones_cond_array() transfers
   ownership of args->zones_cond to disk->zones_cond.

Fix cases 1 and 2 by adding a free_zones_cond label at the end of
blk_revalidate_disk_zones() to centralize the cleanup. Fix case 3 by
moving disk_set_zones_cond_array() before the nr_conv_zones check in
disk_update_zone_resources() so that ownership is transferred early and
disk_free_zone_resources() at the unfreeze label properly frees it.

Fixes: 6e945ffb6555 ("block: use zone condition to determine conventional zones")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/blk-zoned.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 9d1dd6ccfad7..2ea790e4f320 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1956,6 +1956,8 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	memflags = blk_mq_freeze_queue(q);
 
 	disk->nr_zones = args->nr_zones;
+	disk_set_zones_cond_array(disk, args->zones_cond);
+
 	if (args->nr_conv_zones >= disk->nr_zones) {
 		queue_limits_cancel_update(q);
 		pr_warn("%s: Invalid number of conventional zones %u / %u\n",
@@ -1966,7 +1968,6 @@ static int disk_update_zone_resources(struct gendisk *disk,
 
 	disk->zone_capacity = args->zone_capacity;
 	disk->last_zone_capacity = args->last_zone_capacity;
-	disk_set_zones_cond_array(disk, args->zones_cond);
 
 	/*
 	 * Some devices can advertise zone resource limits that are larger than
@@ -2239,7 +2240,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	ret = disk_revalidate_zone_resources(disk, &args);
 	if (ret) {
 		memalloc_noio_restore(noio_flag);
-		return ret;
+		goto free_zones_cond;
 	}
 
 	ret = disk->fops->report_zones(disk, 0, UINT_MAX, &rep_args);
@@ -2268,6 +2269,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	disk_free_zone_resources(disk);
 	blk_mq_unfreeze_queue(q, memflags);
 
+free_zones_cond:
+	kfree(args.zones_cond);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
-- 
2.51.1

