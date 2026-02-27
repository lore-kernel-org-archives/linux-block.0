Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CB026F2AD
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 01:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157310; cv=none; b=TGWW/bkZGK3EHufOp/z/rOT3rB0GJeC53GmFQv/lP6yfPyU3TC/s1QwvVMXqrTntbTw0YquCNAUMjP2hIJ9lmuxGfYjVQMIKIuv2zhZ8vi+egZruQm4+R18qWdPjmCwPJq09CguJmQsNzVh/utCI/eDbUYywFk5N/qXra8tAmdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157310; c=relaxed/simple;
	bh=As2ibBLl5r+2aKTaTEMRVnYM3vHgUNPIooXxj66F9/8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvoXAcCUf/Vnd8fUw77W/0rY10QjVZLsDx9MbwW1ptlWVdElpD2vHQnNp+wohCWylhP+pqgATqTNGCdMf1wK14t0Y51L+8gijA8Jb8In0LDCdPh/qZpDkSyOzkqDip34RKs7cG4wHR5Q34Bx2z4dVK1RakVJjtWIXC0t24sEifU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpdmsPLH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpdmsPLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FF8C19425;
	Fri, 27 Feb 2026 01:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772157310;
	bh=As2ibBLl5r+2aKTaTEMRVnYM3vHgUNPIooXxj66F9/8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UpdmsPLHiC89XD0TemzOF9HXAkIXVhASoDybdRGUUgAbG7XqKIQlzztfbgPlvMw0s
	 SJ9irdafGOQcZiUt1feZ9vmUTLGnQr25jdKmdtnOzC7I8JRmR6Z38XXCjPfp0PAhtt
	 CM0vcOkrLb0few3ik7c2ydugH4CEGS3meLcjlCOVK0hg4+CZIQBThkoW65D+Fj/zGJ
	 Z5j70Uj50lm7u8ZkkgfA9Mpbim9ECvaqGLiO+SkgreLOt88YozLxbOQKJhV7Vwr9vK
	 kiWBUBvHLzoC81vB16hXlCrUIZBW1PosO1Cub0rsxOvQqd865PELJl19T+98/aVCWl
	 jSLd9CUf7BUDw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v3 4/8] block: remove disk_zone_is_full()
Date: Fri, 27 Feb 2026 10:49:47 +0900
Message-ID: <20260227014951.2327711-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227014951.2327711-1-dlemoal@kernel.org>
References: <20260227014951.2327711-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper function disk_zone_is_full() is only used in
disk_zone_wplug_is_full(). So remove it and open code it directly in
this single caller.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 185651a0d617..26c2aa79faf6 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -492,18 +492,12 @@ static bool disk_zone_is_last(struct gendisk *disk, struct blk_zone *zone)
 	return zone->start + zone->len >= get_capacity(disk);
 }
 
-static bool disk_zone_is_full(struct gendisk *disk,
-			      unsigned int zno, unsigned int offset_in_zone)
-{
-	if (zno < disk->nr_zones - 1)
-		return offset_in_zone >= disk->zone_capacity;
-	return offset_in_zone >= disk->last_zone_capacity;
-}
-
 static bool disk_zone_wplug_is_full(struct gendisk *disk,
 				    struct blk_zone_wplug *zwplug)
 {
-	return disk_zone_is_full(disk, zwplug->zone_no, zwplug->wp_offset);
+	if (zwplug->zone_no < disk->nr_zones - 1)
+		return zwplug->wp_offset >= disk->zone_capacity;
+	return zwplug->wp_offset >= disk->last_zone_capacity;
 }
 
 static bool disk_insert_zone_wplug(struct gendisk *disk,
-- 
2.53.0

