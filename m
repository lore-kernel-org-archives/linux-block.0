Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E82A3438A1
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715288; cv=none; b=dqO3dZ+2jAWi00wSwrS7XKeU1uXEk4tv+xenJsvY1hqDPPVRJaeWolrg0Fv6e9IwPCcDfv72nYGVWVLBD3gulmjMOuuV0GaDgxixkoiYbnSXTRBuahhFhQaMMdqPYGZWMST1kS6SWmPPsr6akpndnn9GY3mv/hp7e2bJPDCOxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715288; c=relaxed/simple;
	bh=gcdqKgFiUVttCH+VQ/R3iZ+1mrRhAkssPcHu/KBc9Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vr4omrLt4vd34CAok5UcxhK8x9+/CjThI06kxb5ItyDeFfSKOvBjZ4zBgGNbUe9Xf/sQRoXC1qzb71b+IzJEkuuhOxjl73cpjYIU9nIy0qk2MLPCQKmWeHjwNdR7NJaLru7tfyQsVFUGQo/AswOOlSQUeKAiopiMy7aAxVq7REg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoIgOYrz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoIgOYrz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0DA1F000E9;
	Fri, 14 Aug 2026 13:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715287;
	bh=3CaoJxXdgPkWRfNm6L4FGtXfnM/Po2tkJXFqrpYplBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aoIgOYrzN/pwp8y1O8BSE6pKkBs1AJQRLQZ/YTn7owwwbbx2G8GTK6BoqqJ5HUs/l
	 MdJhZ0yNsKAgUJZrsXVU4bh7ot6au4EbBJaagN9D1KInBOqb8Ksxt4uQrEZ0D55vnd
	 AkkvwPaXptZwRaitzdirouS2D4xrQ3DnnghHeCy0Eawjg3UYjT/kJm/IcW8GYDpSEi
	 +xuHUINJLHA9P3zhV9918J5vAn8nBwXfjcs0IadqDEPVv/FV307HaRte1Jdx8gtzRu
	 gytDgj4cBYtcE/Y4NL24ri9oc73iGOWmvqBMiKKp2xj/tww7MJD5vMhUtma+E9RIgP
	 zxTNrKWMCgg0A==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 07/13] block: drop all zone write plugs on capacity changes
Date: Fri, 14 Aug 2026 22:47:44 +0900
Message-ID: <20260814134750.2100304-8-dlemoal@kernel.org>
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
 block/blk-zoned.c | 74 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 16 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 83737c9a92d8..b153bed9d576 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2222,6 +2222,59 @@ static int disk_revalidate_zone_resources(struct gendisk *disk,
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
+	unsigned int memflags;
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
+	memflags = blk_mq_freeze_queue(disk->queue);
+	disk_for_all_zone_wplugs(disk, disk_drop_zone_wplug, NULL);
+	blk_mq_unfreeze_queue(disk->queue, memflags);
+
+	return ret;
+}
+
 static int blk_revalidate_zone_cond(struct blk_zone *zone, unsigned int idx,
 				    struct blk_revalidate_zone_args *args)
 {
@@ -2411,31 +2464,20 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
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

