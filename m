Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF4F49EC64
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857899; cv=none; b=HkEjqF2WOq8VFHha06mr+pQ26GcY9QIpwx1XCVmP6ovemke1TTkyRio2OTOWoyCc+1BwbMy7H+nZOd9vrpoiznmDUxGsI1Omu7x9gbh2EtlP9o9qwfQPwEKua6GK9XiR/YJnLR0emamvPxM1OcB275XHRpcEX7joEP6ygNG8iJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857899; c=relaxed/simple;
	bh=Co9sNXpkziujoGb76LxmLk1tvDfMAVy/1UZ0r+l3vmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVzISD9g5DOBYBadUNrsDVzrW8aIEl8hvstcQlBejRSu2v18lFIRYmjT1fTujaEf/Vh7TAXuZYbnmuWsG+GApHj+97dzeTz58+KBMbiu7faATJmZx0t6ojP7j0gojDt3sZPa7GLTMlQfDP0u2sDmyu5tl48tZi31TYhc6ngq+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLJFe7Uk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLJFe7Uk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34661F00ADB;
	Tue,  8 Sep 2026 08:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857882;
	bh=j9ERgf80KMzQ58bR98bYhbf7uzuzqt/vs9U7KpXPAdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RLJFe7UkrK1CRyxJ3QhuYlebdS2BMndfvenGkv+MsqgWvqeKWGeJmNgVm9MZ5Hu1I
	 EXFEo6qa8RQ+AwShYtl5QqpfW8Lr3DlGm48O2uUpMt7WJ/zSss1OR4qbGkTDICNd2w
	 lDtDpNlqMz8nSy/ylv8BDmQWDl2+xnFit8UH3ixnnqLCn8UZ1BdOT2XnOzotGi9uFx
	 N9dUYMAeqaUUeIfYAg9B316+EZfYqHKgsjGcCt1Lk9f6FNmCy/G3iWRsAdvYE2L7Am
	 GOK9VvYgDBNxaaKhRc1s9cQU+PSjge0T/sJ4/ljgQAe868NDKESeRa9NBQoqasv9JM
	 CninAHirAEBVg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 07/16] block: improve blkdev_get_zone_info()
Date: Tue,  8 Sep 2026 17:57:36 +0900
Message-ID: <20260908085745.1082697-8-dlemoal@kernel.org>
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

Add a zone state array bound check to ensure that like
disk_zone_get_state(), we never attempt to access the zone state array
beyond its size.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 14c88d11f243..93d862d44e7c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1025,6 +1025,7 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 {
 	struct gendisk *disk = bdev->bd_disk;
 	sector_t zone_sectors = bdev_zone_sectors(bdev);
+	unsigned int zno = disk_zone_no(disk, sector);
 	struct blk_zone_wplug *zwplug;
 	unsigned long flags;
 	u8 *zones_state, zs;
@@ -1032,23 +1033,23 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 	if (!bdev_is_zoned(bdev))
 		return -EOPNOTSUPP;
 
-	if (sector >= get_capacity(disk))
+	if (sector >= get_capacity(disk) || zno >= disk->nr_zones)
 		return -EINVAL;
 
 	memset(zone, 0, sizeof(*zone));
 	sector = bdev_zone_start(bdev, sector);
 
 	if (!blkdev_has_cached_report_zones(bdev))
-		return blkdev_report_zone_fallback(bdev, sector, zone);
+		goto fallback;
 
 	rcu_read_lock();
 	zones_state = rcu_dereference(disk->zones_state);
 	if (!disk->zone_wplugs_hash || !zones_state) {
 		rcu_read_unlock();
-		return blkdev_report_zone_fallback(bdev, sector, zone);
+		goto fallback;
 	}
 
-	zs = zones_state[disk_zone_no(disk, sector)];
+	zs = zones_state[zno];
 	zone->cond = blk_zstate_to_zone_cond(zs);
 	if (blk_zstate_is_conv(zs))
 		zone->type = BLK_ZONE_TYPE_CONVENTIONAL;
@@ -1113,6 +1114,9 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 	disk_put_zone_wplug(zwplug);
 
 	return 0;
+
+fallback:
+	return blkdev_report_zone_fallback(bdev, sector, zone);
 }
 EXPORT_SYMBOL_GPL(blkdev_get_zone_info);
 
-- 
2.55.0

