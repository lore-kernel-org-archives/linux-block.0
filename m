Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B844CB8D0
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857900; cv=none; b=FydWu0ilXw5JJT7dDdcyy8sOXjrvcu5XUjctJV6OV/ZnS0kTb8gMMEx2nG4PLs30KS1iq5d6wQmhWTBjtO4x6VejPazogzogCXTEIRctYbV0PA2bfJwgilYiLhntO7+jAxMDI4S65pDn6aA+8cll2Ugr8o10rwEO0XTrJr/c7Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857900; c=relaxed/simple;
	bh=l2GaeuyHtnYaB5TOwfC+nHjWN43ffCrXGBBmGY0APUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/knVxfuHp0J9VKRrsNHOBmlH1tuYQFwKtlOB7iypTvRw5O5Ks+22EME6aqRjJlEeSeQQWI/vfC/RnHQDfo/3yKu1DkZKG01R7CNkLlNoiEoBD2WYypUXfr0KqqQvuoeih4oC8hyMaCjIrl+3a8UzBs2OwEXrAOnygMk20ZGmW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQOwwnDi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQOwwnDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33351F0155D;
	Tue,  8 Sep 2026 08:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857884;
	bh=7JBWQXMJ2Qr65Dt/9tocWZf3X5rjpJRooTQHkzslkuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lQOwwnDir/dE/n2opiHMiOnD02JJVOTa515FKzW2ji7XgbyLRHvZ5/mS2o65ouRXy
	 KBGY7RSGwzghGNZtEFX/XFlfSMRaO8HGywRygXQCHKfdKSVCFzUf14oDx4eW2/ZwDE
	 E+1fMrxC8yF8DYMtE0BLMl7EsrPJQ0dFKF4PxLjgjOkESxEdoXgQ9CDe7NdEl70IpR
	 nntuXL4GGrdZQdYMf5SPjtXqaJdC6bU7uhjVm63cO5aBw+5R5jsbJrkEoXsLy11t+w
	 nQAJSgJM5QbYKDFF2evjtwBOx4rjp4yYlBUgXYxFmZ3W4nbqJ3VJjbHHdPVyZbVBPi
	 SyuQmWVtQQZZw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 10/16] block: drop all zone write plugs on capacity changes
Date: Tue,  8 Sep 2026 17:57:39 +0900
Message-ID: <20260908085745.1082697-11-dlemoal@kernel.org>
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

If during revalidation, we detect a capacity change for a zoned block
device, e.g. due to a storage element removal on an HDD, we can assume
that the device was reformatted, which implies that all sequential zones
are empty. For such case, we can remove and free all zone write plugs in
the gendisk hash table by marking them as dead, thus avoiding also to
leave zone write plugs for zones that are beyond the new device capacity
in the disk hash table.

Introduce the function disk_revalidate_capacity() to do this and call this
new function at the beginning of blk_revalidate_disk_zones(), so that the
zone revalidation process can re-create, if needed, any zone write plug
for sequential zones that are not empty.

The checks on the capacity and zone size that were in
blk_revalidate_disk_zones() are moved to disk_revalidate_capacity() and
if true, also trigger dropping all zone write plugs.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 77 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 20 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 676620ed93de..e7f20b5262c7 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2246,6 +2246,56 @@ static int disk_revalidate_zone_resources(struct gendisk *disk,
 	return ret;
 }
 
+static void disk_drop_zone_wplug(struct blk_zone_wplug *zwplug, void *data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&zwplug->lock, flags);
+	disk_zone_wplug_abort(zwplug);
+	disk_mark_zone_wplug_dead(zwplug);
+	spin_unlock_irqrestore(&zwplug->lock, flags);
+}
+
+static int disk_revalidate_capacity(struct gendisk *disk,
+				    struct blk_revalidate_zone_args *args)
+{
+	struct queue_limits *lim = &disk->queue->limits;
+	sector_t zone_sectors = lim->chunk_sectors;
+	unsigned int nr_zones;
+	int ret = -ENODEV;
+
+	/* Checks that the device driver indicated a valid zone size. */
+	if (!zone_sectors || !is_power_of_2(zone_sectors)) {
+		pr_warn("%s: Invalid non power of two zone size (%llu)\n",
+			disk->disk_name, zone_sectors);
+		goto drop_all_zwplugs;
+	}
+
+	args->capacity = get_capacity(disk);
+	nr_zones = disk_get_nr_zones(disk, args->capacity);
+	if (!args->capacity || !nr_zones)
+		goto drop_all_zwplugs;
+
+	/*
+	 * Check if the capacity has changed. If it did, assume that the device
+	 * was reformatted and that all sequential zones are now empty. So drop
+	 * all zone write plug.
+	 */
+	if (disk->nr_zones && disk->nr_zones != nr_zones) {
+		pr_warn("%s: Number of zones changed (%u -> %u)\n",
+			disk->disk_name, disk->nr_zones, nr_zones);
+		ret = 0;
+		goto drop_all_zwplugs;
+	}
+
+	return 0;
+
+drop_all_zwplugs:
+	disk_for_all_zone_wplugs(disk, disk_drop_zone_wplug, NULL);
+
+	return ret;
+}
+
 static int blk_revalidate_zone_cond(struct blk_zone *zone, unsigned int idx,
 				    struct blk_revalidate_zone_args *args)
 {
@@ -2435,40 +2485,27 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
  */
 int blk_revalidate_disk_zones(struct gendisk *disk)
 {
-	struct request_queue *q = disk->queue;
-	sector_t zone_sectors = q->limits.chunk_sectors;
-	struct blk_revalidate_zone_args args = {
-		.capacity = get_capacity(disk),
-	};
+	struct blk_revalidate_zone_args args = { };
 	struct blk_report_zones_args rep_args = {
 		.cb = blk_revalidate_zone_cb,
 		.data = &args,
 	};
 	unsigned int noio_flag;
-	int ret = -ENOMEM;
+	int ret;
 
-	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
+	if (WARN_ON_ONCE(!blk_queue_is_zoned(disk->queue)))
 		return -EIO;
 
-	if (!args.capacity)
-		return -ENODEV;
-
-	/*
-	 * Checks that the device driver indicated a valid zone size and that
-	 * the max zone append limit is set.
-	 */
-	if (!zone_sectors || !is_power_of_2(zone_sectors)) {
-		pr_warn("%s: Invalid non power of two zone size (%llu)\n",
-			disk->disk_name, zone_sectors);
-		return -ENODEV;
-	}
-
 	/*
 	 * Serialize calls to this function so that we can safely look at and
 	 * eventually change the disk zone information.
 	 */
 	mutex_lock(&disk->zone_revalidate_mutex);
 
+	ret = disk_revalidate_capacity(disk, &args);
+	if (ret)
+		goto unlock;
+
 	/*
 	 * Allocate zone resources if they are needed and we have not done
 	 * so yet, and initialize the revalidation arguments passed to report
-- 
2.55.0

