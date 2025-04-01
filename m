Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBEC2F3B
	for <linux-block@vger.kernel.org>; Tue,  1 Apr 2025 07:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743493667; cv=none; b=d0ny9fHbCN1moUw1ghsL+CSTMDcrmH/Oz2aM7ZX/brsF/bIFDRn17PXq8b1dlWBvCixN7H0U3QtFk+boYiB2PjXRmE/l85CuS3Kj8ygTWDhfzLFCDMWCf4lZW9tSYpimlZTaicqFFcX4E0IGrYRxEptrkPfkiJC5EkC8Qstn8Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743493667; c=relaxed/simple;
	bh=KjhNRR9mMoGhC9XVVEq+YwwobekdUMI2ChK5QI1pf6c=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Qh5DGbzb349eX4Azff7YQP/3EsBAcFx12fPNKt0erV9tXNZ/wXMXusO3DfC8DbM3LiZQaQ+2oSYiF4E/jLBWI9PxFOyHn1d4cKh9U2fQIlo/mO/dOueAkLLkM4Ehf+2+EWeeWuiELBTRCm8DpjODlq4/cS7QqA8I96SpxnTl1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
	by 156.147.23.53 with ESMTP; 1 Apr 2025 16:17:41 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.31.96)
	by 156.147.1.121 with ESMTP; 1 Apr 2025 16:17:41 +0900
X-Original-SENDERIP: 10.178.31.96
X-Original-MAILFROM: chanho.min@lge.com
From: Chanho Min <chanho.min@lge.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sven <dm-devel@schwermer.no>,
	Gunho Lee <gunho.lee@lge.com>,
	Chanho Min <chanho.min@lge.com>
Subject: [PATCH] block: restrict blk_lookup_devt non-existent partition return to MD devices
Date: Tue,  1 Apr 2025 16:17:28 +0900
Message-Id: <20250401071728.16030-1-chanho.min@lge.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

We have observed occasional failures in dm-init due to dm-mod.waitfor not
working as expected when partitions are not yet ready. This issue was
raised in a discussion on the mailing list:
https://lore.kernel.org/all/e746b8b5-c04c-4982-b4bc-0fa240742755@schwermer.no/T/
but has remained unresolved since then.

The root cause was identified in blk_lookup_devt(), which returns a dev_t
even for non-existent partitions, a behavior introduced by commit
41b8c853a495 ("block: fix booting from partitioned md array"). This
change was intended to support MD RAID devices, where partitions may not
be available during early boot, allowing the system to proceed and detect
them later.

However, this behavior conflicts with cases like dm-init's waitfor
mechanism, where an accurate dev_t for an existing partition is required.
Returning a dev_t for non-existent partitions should be a special case
(e.g., MD devices), while most scenarios, including Device Mapper, expect
blk_lookup_devt() to reflect the actual partition state.

To address this without major structural changes, this patch restricts the
non-existent partition dev_t return to MD devices. For other devices,
blk_lookup_devt() will only return a dev_t if the partition exists.
With this change, dm-mod.waitfor works correctly, resolving the dm-init failures.

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 block/early-lookup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/early-lookup.c b/block/early-lookup.c
index 3fb57f7d2b127..39a32a0fe7aab 100644
--- a/block/early-lookup.c
+++ b/block/early-lookup.c
@@ -5,6 +5,7 @@
  */
 #include <linux/blkdev.h>
 #include <linux/ctype.h>
+#include <linux/major.h>
 
 struct uuidcmp {
 	const char *uuid;
@@ -133,10 +134,9 @@ static dev_t __init blk_lookup_devt(const char *name, int partno)
 
 		if (strcmp(dev_name(dev), name))
 			continue;
-
-		if (partno < disk->minors) {
+		if (partno < disk->minors && MAJOR(dev->devt) == MD_MAJOR) {
 			/* We need to return the right devno, even
-			 * if the partition doesn't exist yet.
+			 * if the partition doesn't exist yet.(for MD devices)
 			 */
 			devt = MKDEV(MAJOR(dev->devt),
 				     MINOR(dev->devt) + partno);
-- 
2.17.1

