Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260DF2DECA5
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413023; cv=none; b=Jf9i81iHvu+rS7dKpxOsi0656OWiZkcW/waCbWyjNtMeAh4usvzH+NPwWOXY0ipHbTKdx9EGX7s1FnXjqMMBohc3EAMe7avdcV02G2sLpClrTkD45Hkeze6gQbEVwAVCY4PaaZrQ9SoTQ5NvQbw9qJPD8SK1M7mRdHFi00+wjV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413023; c=relaxed/simple;
	bh=/gnMmyEhQmev+J3FaEsXyIciynQVaK4UxC+nSX0+5xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mU8M8ns1Zdkw6llplm1n5sPleq2VggjO+0uxJFKJOLkAGMiNi4bd1aqEK+V8SzT48cbE3eJSbEG2RnnZspYhnGFaPXurk+5HOs7ITwkKqs7OhzqU9ixvZQ2P3WPTg+VLA2odlOaHJGNTH8XDWQiPX+Tp0dv6Wr5KuCbuQG1YT24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv0Seg1+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv0Seg1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB19C116B1;
	Thu,  6 Nov 2025 07:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762413023;
	bh=/gnMmyEhQmev+J3FaEsXyIciynQVaK4UxC+nSX0+5xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jv0Seg1+5Bkrw0pH7kSFSNyYGwjdVXBrehK/zSgGCaC+wMX4Zhj/N6e9Vh4DT/lUp
	 1YWT4qA/+GaOa13Wo/dX8KIlo6H+vi0lTQhGDdesf5HBIdohIVoJrMMTWXZ7KYwGN1
	 TP0l2he/CX7Zqew+izmQzHG0RfcrZxDrtng9UFHhKMfXlUD7/B/qC10s4Xzv8614IE
	 QSQIcYs6LloIqRDiODJ9c7HBLqIsDoY0FtOdsEfj8lPVvdZYs4cdru/qegGfHUv7hy
	 t0vm4oWFQepXD1R/iO9knSxw/PeURkxckxail8yAXJpOruht3Fvc/1kfW9JYDEZap+
	 MWmNJeJyAUjnw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] block: introduce bdev_zone_start()
Date: Thu,  6 Nov 2025 16:06:27 +0900
Message-ID: <20251106070627.96995-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251106070627.96995-1-dlemoal@kernel.org>
References: <20251106070627.96995-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function bdev_zone_start() as a more explicit (and clear)
replacement for ALIGN_DOWN() to get the start sector of a zone
containing a particular sector of a zoned block device.

Use this new helper in blkdev_get_zone_info() and
blkdev_report_zones_cached().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c      | 4 ++--
 include/linux/blkdev.h | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 2f4e45638601..e7e5542c538e 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -945,7 +945,7 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 		return -EINVAL;
 
 	memset(zone, 0, sizeof(*zone));
-	sector = ALIGN_DOWN(sector, zone_sectors);
+	sector = bdev_zone_start(bdev, sector);
 
 	if (!blkdev_has_cached_report_zones(bdev))
 		return blkdev_report_zone_fallback(bdev, sector, zone);
@@ -1063,7 +1063,7 @@ int blkdev_report_zones_cached(struct block_device *bdev, sector_t sector,
 		return blkdev_do_report_zones(bdev, sector, nr_zones, &args);
 	}
 
-	for (sector = ALIGN_DOWN(sector, zone_sectors);
+	for (sector = bdev_zone_start(bdev, sector);
 	     sector < capacity && idx < nr_zones;
 	     sector += zone_sectors, idx++) {
 		ret = blkdev_get_zone_info(bdev, sector, &zone);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6a498aa7f7e7..2fff8a80dbd2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1522,6 +1522,12 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 	return q->limits.chunk_sectors;
 }
 
+static inline sector_t bdev_zone_start(struct block_device *bdev,
+				       sector_t sector)
+{
+	return sector & ~(bdev_zone_sectors(bdev) - 1);
+}
+
 static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
 						   sector_t sector)
 {
-- 
2.51.1

