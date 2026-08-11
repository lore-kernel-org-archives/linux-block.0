Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5482943C7DB
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445950; cv=none; b=Nmv5ma1jFX6C2ScdgQSkxKVywqwqtgAOGBFVAkSszO83G4+fUBdor0DRxqtzs+AfM5v7jIbhtSdM+CrydtSaSPLHdMbfRHTRvRHGUhk3EFS92LdaLQw64vqPJ47BDKaUcNSLsKyfWkQ4S+3DxLB7ob3/bd/6g1TTDO6YtstMvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445950; c=relaxed/simple;
	bh=QS2Ruri8/tDUHkVFvy2noKrpsGBkw61IWxmY0mt9iS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VF0Ac+SzrBij/gBVhI1oshIy7FpNYOnLVYjrpPYXBNX+zw1z1mqwJFSDQpd1rAFiq2N40PoP+elHTrPu4rozS88PfQGE4jygEv5ufmvxExTAOZ2XtBGkFz9JIFGnrRSxRBnsmCV1Ef9yAPHTr1UY7iqykGM4YSYuB66wsHJ4uDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyqOP1Sx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyqOP1Sx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C382F1F00A3E;
	Tue, 11 Aug 2026 10:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786445949;
	bh=nXibAWMeNpYZJglRKPgV9FQKjp+ogDybO5XudRWvpeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GyqOP1Sxnlw+SjhNERVH+Mp60/s45SWY1NtJNIBjEpd5N+tPYJRvIkoBUZ61PQE2p
	 Q7gU1ExpZXnteRXpBTE2B+084hTj7QfbCu2wpt3nqoaowKbHecpaUVfZw+N47BIzeP
	 k2S+puJPzckzHRdgJuip6B9wm/s2UrO1NYr7UKxsapC9SqiuR6QKXceRYlfFdic51w
	 IV0TK68xr/UhKtRuXMJje/Nn4PQwugNGvmNYxXQGvR4ZKoiwRbWjb/3mvBFuuFJHoK
	 TVkO7fkptBQ7b7kzHc3QWLUewXSN46RSXQPTYHHTNK16otL5FTzFF9sinEzznYRfEB
	 4Rrtlt6PJ65FA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 07/13] block: drop all zone write plugs on capacity changes
Date: Tue, 11 Aug 2026 19:58:46 +0900
Message-ID: <20260811105852.1245357-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811105852.1245357-1-dlemoal@kernel.org>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
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
---
 block/blk-zoned.c | 81 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 63 insertions(+), 18 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 925f9bfcbd6b..5b84fde63ef3 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1971,6 +1971,9 @@ static unsigned int disk_get_nr_zones(struct gendisk *disk)
 {
 	struct queue_limits *lim = &disk->queue->limits;
 
+	if (!lim->chunk_sectors)
+		return 0;
+
 	return DIV_ROUND_UP_ULL(get_capacity(disk), lim->chunk_sectors);
 }
 
@@ -1986,10 +1989,13 @@ static unsigned int disk_get_nr_zones(struct gendisk *disk)
 static int disk_alloc_zone_resources(struct gendisk *disk)
 {
 	struct queue_limits *lim = &disk->queue->limits;
-	unsigned int nr_zones = disk_get_nr_zones(disk);
-	unsigned int pool_size, i;
+	unsigned int nr_zones, pool_size, i;
 	int ret = -ENOMEM;
 
+	nr_zones = disk_get_nr_zones(disk);
+	if (!nr_zones)
+		return -ENODEV;
+
 	/*
 	 * If the device has no limit on the maximum number of open and active
 	 * zones, use BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE.
@@ -2216,6 +2222,56 @@ static int disk_revalidate_zone_resources(struct gendisk *disk,
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
+static int disk_revalidate_capacity(struct gendisk *disk)
+{
+	struct queue_limits *lim = &disk->queue->limits;
+	sector_t zone_sectors = lim->chunk_sectors;
+	unsigned int nr_zones = disk_get_nr_zones(disk);
+	int ret = -ENODEV;
+
+	if (!get_capacity(disk) || !nr_zones)
+		goto drop_all_zwplugs;
+
+	/*
+	 * Checks that the device driver indicated a valid zone size and that
+	 * the max zone append limit is set.
+	 */
+	if (!zone_sectors || !is_power_of_2(zone_sectors)) {
+		pr_warn("%s: Invalid non power of two zone size (%llu)\n",
+			disk->disk_name, zone_sectors);
+		goto drop_all_zwplugs;
+	}
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
@@ -2405,31 +2461,20 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
  */
 int blk_revalidate_disk_zones(struct gendisk *disk)
 {
-	struct request_queue *q = disk->queue;
-	sector_t zone_sectors = q->limits.chunk_sectors;
 	struct blk_revalidate_zone_args args = { };
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
 
-	if (!get_capacity(disk))
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
+	ret = disk_revalidate_capacity(disk);
+	if (ret)
+		return ret;
 
 	/*
 	 * Allocate zone resources if they are needed and we have not done
-- 
2.55.0

