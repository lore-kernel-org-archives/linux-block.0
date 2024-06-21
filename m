Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9944412BF25
	for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 03:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718939709; cv=none; b=T6K2om152w5A5dMa6/RuUcawRw5GALM/vbm/SDTGkOnXWY/wn8r+OdxR6NCMxSHIUOvohdqkjLmiWt562xoZKLkgiB+glw8wyeq5VevixSz5WUQ+ph947smJsijk4lSWCwtyaX8gB0cmNg5+VfzjQlh7l48DkrTcYLPZPXqGuh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718939709; c=relaxed/simple;
	bh=QINgyjZ7UZVheyZ1tdvxh92Kxr1t65kNwRGhecM5Kfg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzCz+oCZ3EaBEBUonNLXNC+FUdkfrq8XFv54MTCRML9xZH2MNcAfcXS1cnMlWhz4z0Q2LJq4z1tNF1eW8AtmXnHNntdunv08GkuhGcPQoaWnX9OJxL0Va1FPILtbB9K65AoNUlUgtf6WhBCQdw/J9Tn/urbr63Xw7KFhkt7ItVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb7Tt69V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb7Tt69V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA5FC4AF0A;
	Fri, 21 Jun 2024 03:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718939709;
	bh=QINgyjZ7UZVheyZ1tdvxh92Kxr1t65kNwRGhecM5Kfg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Fb7Tt69V/BTil6F/++xTRz4Nqggvg1rf+5suIigo5kVmubV3ikr2awOme0NahxGZp
	 9IRFtild1kWZah7X9yq9OnC1zkU0FLp/wm6Fk/ZYlC4cok93P4O1U8cO+OWXhzmKZw
	 TpCDnB3gVsWciCyKjjcPTwO5GKC5Yr7IZWpzSwH5x44k6bHyTtGiZrHGuoF+A3+mX3
	 kA9VBdHXcgQlcVrJ8nzlT/UrRui82KOwk60Ynj2cXfU50xUna0gjV77l8udDBxm72T
	 Z6+T3lTOmokN2801CiY6W0sHZlmcJt27Ab74d6QlEuE7k8eqRppJe7M3AvhuIV4/yh
	 2wn9fGCyrkaIg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: Cleanup block device zone helpers
Date: Fri, 21 Jun 2024 12:15:06 +0900
Message-ID: <20240621031506.759397-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621031506.759397-1-dlemoal@kernel.org>
References: <20240621031506.759397-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to conditionally define on CONFIG_BLK_DEV_ZONED the
inline helper functions bdev_nr_zones(), bdev_max_open_zones(),
bdev_max_active_zones() and disk_zone_no() as these function will return
the correct valu in all cases (zoned device or not, including when
CONFIG_BLK_DEV_ZONED is not set). Furthermore, disk_nr_zones()
definition can be simplified as disk->nr_zones is always 0 for regular
block devices.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 include/linux/blkdev.h | 44 ++++++++++++------------------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1078a7d51295..e89003360c17 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -673,11 +673,21 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
 }
 
 #ifdef CONFIG_BLK_DEV_ZONED
-
 static inline unsigned int disk_nr_zones(struct gendisk *disk)
 {
-	return blk_queue_is_zoned(disk->queue) ? disk->nr_zones : 0;
+	return disk->nr_zones;
+}
+bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs);
+#else /* CONFIG_BLK_DEV_ZONED */
+static inline unsigned int disk_nr_zones(struct gendisk *disk)
+{
+	return 0;
+}
+static inline bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
+{
+	return false;
 }
+#endif /* CONFIG_BLK_DEV_ZONED */
 
 static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 {
@@ -701,36 +711,6 @@ static inline unsigned int bdev_max_active_zones(struct block_device *bdev)
 	return bdev->bd_disk->queue->limits.max_active_zones;
 }
 
-bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs);
-#else /* CONFIG_BLK_DEV_ZONED */
-static inline unsigned int bdev_nr_zones(struct block_device *bdev)
-{
-	return 0;
-}
-
-static inline unsigned int disk_nr_zones(struct gendisk *disk)
-{
-	return 0;
-}
-static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
-{
-	return 0;
-}
-static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
-{
-	return 0;
-}
-
-static inline unsigned int bdev_max_active_zones(struct block_device *bdev)
-{
-	return 0;
-}
-static inline bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
-{
-	return false;
-}
-#endif /* CONFIG_BLK_DEV_ZONED */
-
 static inline unsigned int blk_queue_depth(struct request_queue *q)
 {
 	if (q->queue_depth)
-- 
2.45.2

