Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC654C0420
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857887; cv=none; b=bDakWxseUaktSAYKEerIdJ0YaTyOMScWeNfdgbGPNf894sCgfDdSGiAobFajrjcM7pgoekvOH/vwM+u6KoylQBFPngUV56CglogUTZwDQS/3TFG2xiyTWzq0U94xbxFEjURU2WwhgS7wIsvVYbabH3Kw/qklllkZQLphD/0RwPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857887; c=relaxed/simple;
	bh=lAkFwozJlMRjOe4gpB+yVCM762HwXD20vu1FTjsKFCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhGgJYz2qTVWxnZgSfkL8ybKep+GKau7gVjjjbrYIuRF6/g8tooZC7Srx/udGEAimZU+fKJxV11SfB906acAZlfpw1BDePYsU47J6C5I7wKuobDEuw8PhBsYfZSjUpuQSLZjc/4RGl6PhjdL7H4IVH2KLhhE10sOZk8itBNQQzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1WRtkap; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1WRtkap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4011F00A3E;
	Tue,  8 Sep 2026 08:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857878;
	bh=KbQ2heyBR9wrF4mWqFLvScfAxPfaR9wimddqlD+uXWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m1WRtkapCDfbBHK2E/lF8Ias7PgFscb/6WmpWmkVWG7meeP5OhOZQ2ESp2WuxPuJu
	 74GorNr/EycrI1PHysyXPDoVHCQ0UI+m1niJjbftYDb7c/NCIUIG1q4O5vJzzjpxJH
	 wCV19wtrCCjMlZlLqwQAom8KzGQKzQ0AdFHNNWTSsxsLBWJEw7zjL11+wRg+914uQM
	 r3lYsH4cLyVt+wVF/B1dyDn/oFy1Zh4ZQm9vK2KiGmrRZFq6Gao5ej/4EoXJ7Q6Vcq
	 bKUDcsw18WQ5rse2W2p9Ou12CDjwxgXk1dxB4ivUiQOT4m7C+fjwBohpeQIqcmXsvA
	 c1JlmM2eh6drA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 02/16] block: improve capacity handling during zone revalidation
Date: Tue,  8 Sep 2026 17:57:31 +0900
Message-ID: <20260908085745.1082697-3-dlemoal@kernel.org>
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

While executing blk_revalidate_disk_zones(), a disk capacity is looked at
using get_capacity() several times: on entry to
blk_revalidate_disk_zones(), when allocating zone revalidation arguments
in disk_revalidate_zone_resources(), while validating zones in
blk_revalidate_zone_cb() and one last time at the end of
blk_revalidate_disk_zones() to check that all zones have been inspected.

Since this is all done while passthrough commands can be issued, it is
possible that a capacity change operation (e.g. the removal of a storage
element on a SCSI or SATA disk) is concurrently executed, potentially
resulting in an inconsistent or conflicting revalidation with potentially
out-of-bound accesses to the zone condition array.

Prevent issues by using get_capacity() once on entry to
blk_revalidate_disk_zones(), remembering this capacity as a field of
struct blk_revalidate_zone_args and using that field while revalidating
zones. A final second call to get_capacity() is done at the end of
blk_revalidate_disk_zones() to ensure that the disk capacity has not
changed, thus revalidating the capacity (and number of zones) itself.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c7d8c767bb31..8b3b5c7bfd03 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1993,6 +1993,7 @@ void disk_release_zone_resources(struct gendisk *disk)
 
 struct blk_revalidate_zone_args {
 	struct gendisk	*disk;
+	sector_t	capacity;
 	u8		*zones_cond;
 	unsigned int	nr_zones;
 	unsigned int	nr_conv_zones;
@@ -2010,7 +2011,7 @@ static int disk_revalidate_zone_resources(struct gendisk *disk,
 
 	args->disk = disk;
 	args->nr_zones =
-		DIV_ROUND_UP_ULL(get_capacity(disk), lim->chunk_sectors);
+		DIV_ROUND_UP_ULL(args->capacity, lim->chunk_sectors);
 
 	/* Cached zone conditions: 1 byte per zone */
 	args->zones_cond = kzalloc(args->nr_zones, GFP_NOIO);
@@ -2231,7 +2232,7 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 		return -ENODEV;
 	}
 
-	if (zone->start >= get_capacity(disk) || !zone->len) {
+	if (zone->start >= args->capacity || !zone->len) {
 		pr_warn("%s: Invalid zone start %llu, length %llu\n",
 			disk->disk_name, zone->start, zone->len);
 		return -ENODEV;
@@ -2302,8 +2303,9 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	sector_t zone_sectors = q->limits.chunk_sectors;
-	sector_t capacity = get_capacity(disk);
-	struct blk_revalidate_zone_args args = { };
+	struct blk_revalidate_zone_args args = {
+		.capacity = get_capacity(disk),
+	};
 	struct blk_report_zones_args rep_args = {
 		.cb = blk_revalidate_zone_cb,
 		.data = &args,
@@ -2314,7 +2316,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
 		return -EIO;
 
-	if (!capacity)
+	if (!args.capacity)
 		return -ENODEV;
 
 	/*
@@ -2352,7 +2354,12 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	 * If zones where reported, make sure that the entire disk capacity
 	 * has been checked.
 	 */
-	if (args.sector != capacity) {
+	if (args.capacity != get_capacity(disk)) {
+		pr_warn("%s: Capacity has changed\n", disk->disk_name);
+		ret = -ENODEV;
+		goto free_args;
+	}
+	if (args.sector != args.capacity) {
 		pr_warn("%s: Missing zones from sector %llu\n",
 			disk->disk_name, args.sector);
 		ret = -ENODEV;
-- 
2.55.0

