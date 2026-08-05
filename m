Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D153C13EC
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896859; cv=none; b=qULa5BsX2dik+U7yPStDrFZROAgIKFXNZYLG1qxVQQHb8ZZzPAid7+/QphXchrm4V9SLyg0mvEidOxdHAlrGfcDyQ6dHr7tRneu/EDxtofQqwE0xaZA9IwQmh4TRtLQkTbC5bhTc3LIlbItzsIBeSQ2txKH7RU9/85wKl0PKgAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896859; c=relaxed/simple;
	bh=tbd9DedBSyX/mbPK2+ikuBdjmEjU66WLEDWTJ56SrZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQ5rYvd+TddkqAY6tTTUDtEmMP7wdwexmxZIRWk5eIBIHkhkvQLk+Zc24y759C3ASkEy1Q853Bl+v1FxoE2jspuyO4mok0LaUxBc0K27gLwCPvP09qaUIJmSHrebua/JkJVQdprdGzlE7tknHRWLSi5f5XkeplIh1zbSS25lQRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOncY9AO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOncY9AO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A7F1F000E9;
	Wed,  5 Aug 2026 02:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785896858;
	bh=1pmDZEEnnOf//M9P4xdeH3WCv5HjXdUWiBjVMgKQtng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hOncY9AONjVtCcXTGBjiWLl9+x0Ku7+vmXC8IgSxiqjXe1ab2cQ169DZovI/uhYdN
	 H6tQZBe0MiJ7ty78JUyueJuhQbxR0E1iiwq7d+8HPmRJFWdNGWThbANBUN35Cjjv8Q
	 H2WnirIyPh6p83hV9EOBiLMLG9n/mtCLIHrOVVDqR+J9cFcncraq56qH7HjRBEvdd4
	 p6T/EVzm5BmMfZr2L/JT81Gn4/5oXhRLMqjOmyo28cVg/LUh2kdQwvVHP7M6PRjUmG
	 o9L3KENlQ6lfNN6AR7CLMkRC2u4U7dDBY5VpwokFAme5JFWm2qUgV2yCEbL1w+9B0p
	 kLYXgzd22v1wg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 07/14] block: drop all zone write plugs on capacity changes
Date: Wed,  5 Aug 2026 11:27:12 +0900
Message-ID: <20260805022719.735323-8-dlemoal@kernel.org>
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
---
 block/blk-zoned.c | 71 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 16 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 3bca7b0437d5..f065febbae97 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2216,6 +2216,56 @@ static int disk_revalidate_zone_resources(struct gendisk *disk,
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
+	if (!get_capacity(disk))
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
@@ -2405,31 +2455,20 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
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

