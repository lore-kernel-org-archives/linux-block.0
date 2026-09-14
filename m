Received: from mta0.migadu.com (out-57.mta0.migadu.com [91.218.175.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2642B4078E0
	for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392228; cv=none; b=YNuljTuJndbRKNjm7/8jlaT5E1J/RDWtKUYQA62AHE8o4Hrc4ns6mJuqfbiE4qrYWlr16rNhqJul+7wBqrnL3KbaS8TasFXR0uKUkgB2eC++bf4AXzTR+n4u5PzEGe6c7+Rgssy7/1DtkzgCKfokv+SGuWS4ofMoQMkbNV+kvuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392228; c=relaxed/simple;
	bh=mmk3NSBVpvHBilBnb7N7/oEvq2Mu+ygzuiPAsh0GBE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ksrNo4sCo3t3q3v3TCVbklieYW03fLWgOyutcvUL0AdTJQ+VoqGa0qXzxwS/xAv2DlyRhH4XjfFuveXWJcxc5ptVZE2MiMAdzZHSKwJbWAg/K/kkTtHQvJDBp3vRrsp14jMSQu2+MGIJdXWO+/ZFwEfXGT2acsCThqUIu0Lw9kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oP8pX3AK; arc=none smtp.client-ip=91.218.175.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oP8pX3AK"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mmk3NSBVpvHBilBnb7N7/oEvq2Mu+ygzuiPAsh0GBE4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789392223; v=1; x=1789997023;
 b=oP8pX3AKqKM/+C0kxBFwBLBebf96oSDdz++rJRiJIah/18u2ckM3xd+rbWh5p6LmJVm0Z24H
 Ac8mV0PFp80Q6JxLqujNg2qONEED+NlVub1Msl4/HpYh4HKhQCv/aEOQB5DCtuNdhPIwg5u6J3W
 R4+nN+zVycZD7LJl87dwIWR0=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 53561ba5b39da3dd;
	Mon, 14 Sep 2026 13:23:43 +0000
X-Mizu-Trace-ID: 53561ba5b39da3dd
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: axboe@kernel.dk,
	hch@lst.de
Cc: mkp@kernel.org,
	linux-block@vger.kernel.org,
	John Garry <john.garry@linux.dev>
Subject: [PATCH] block: cap atomic write size by PI buffer size constraints take #2
Date: Mon, 14 Sep 2026 14:23:23 +0100
Message-ID: <20260914132323.208321-1-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1418b5633ca9 ("block: cap atomic write size by PI buffer size
constraints") attempted to fix atomic writes limits according to integrity
limits. However, it just reduced the atomic_write_max_sectors. The other
atomic write limits - unit min and unit max - are not derived directly
from this value.

Update blk_atomic_writes_update_limits() to properly set the atomic write
limits according to integrity limits.

Signed-off-by: John Garry <john.garry@linux.dev>

diff --git a/block/blk-settings.c b/block/blk-settings.c
index e469baa1f08b..1f5ee2453269 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -206,12 +206,6 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
 	lim->max_sectors = min(lim->max_sectors,
 		max_integrity_io_size(lim) >> SECTOR_SHIFT);
 
-	if (lim->features & BLK_FEAT_ATOMIC_WRITES) {
-		lim->atomic_write_max_sectors =
-			min(lim->atomic_write_max_sectors,
-				max_integrity_io_size(lim) >> SECTOR_SHIFT);
-	}
-
 	return 0;
 }
 
@@ -236,14 +230,20 @@ static unsigned int blk_queue_max_guaranteed_bio(struct queue_limits *lim)
 
 static void blk_atomic_writes_update_limits(struct queue_limits *lim)
 {
+	unsigned int integrity_max = lim->integrity.metadata_size ?
+					max_integrity_io_size(lim) : 0;
 	unsigned int unit_limit = min(lim->max_hw_sectors << SECTOR_SHIFT,
 					blk_queue_max_guaranteed_bio(lim));
 
+	unit_limit = min_not_zero(unit_limit, integrity_max);
 	unit_limit = rounddown_pow_of_two(unit_limit);
 
 	lim->atomic_write_max_sectors =
 		min(lim->atomic_write_hw_max >> SECTOR_SHIFT,
 			lim->max_hw_sectors);
+	lim->atomic_write_max_sectors =
+		min_not_zero(lim->atomic_write_max_sectors,
+				integrity_max >> SECTOR_SHIFT);
 	lim->atomic_write_unit_min =
 		min(lim->atomic_write_hw_unit_min, unit_limit);
 	lim->atomic_write_unit_max =
@@ -511,11 +511,13 @@ int blk_validate_limits(struct queue_limits *lim)
 	if (!(lim->features & BLK_FEAT_WRITE_CACHE))
 		lim->features &= ~BLK_FEAT_FUA;
 
-	blk_validate_atomic_write_limits(lim);
-
 	err = blk_validate_integrity_limits(lim);
 	if (err)
 		return err;
+
+	/* atomics limits depend on integrity limits */
+	blk_validate_atomic_write_limits(lim);
+
 	return blk_validate_zoned_limits(lim);
 }
 EXPORT_SYMBOL_GPL(blk_validate_limits);
-- 
2.43.0

