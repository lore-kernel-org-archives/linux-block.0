Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0470626B2D2
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 00:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772152968; cv=none; b=cAqJmBFrHZ36kMgCr5mKBMLaMMNrsmla48diU/cswbuiRYIO+/B1T5jC1tWfnWWqmDtkC3p4CcMTjiq3QB2U5ViADZldoPM1xEDRRqIw/fZk4LDc9Ksln97xk7RAnpqNeNFgGUSDT0KSkClX8mmz6aCYxIebOOVav7si4PEDYHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772152968; c=relaxed/simple;
	bh=TYinvOyAjh2H/NtbHNGruW0zLxwpOsVD1XVfAyL342U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B7rMfTXC4gOC93OvBPqAWUHIjTXSgVHgNys+1kLjEKs3oXYZ41wmUJ9uKsbGXYyjWdz8WmKcUDMQ+3OKywmzdjjQTnd4akeSAdXYBpiYGy5SjIbBSml1lLBq8ZY2Ans6yFA3KjHiEkdgFSiVJNW9fpH0UOfAyBLLCJV6jPkeN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lrglvvj0; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lrglvvj0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772152954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W+Z2Aj6ubZCwuXCsOc2jL2mHBymXCjgJw1vuy+9Bbvc=;
	b=Lrglvvj043xQtPxm+LXcX3mNpvIx1/xNB11tPybv2hd9/ztqLWoxu3qtnmeOEve0PJJU3n
	R6l/dbaZ6rXgi4giSoxBO86tL02lmIcbpPfWveNRTvlGtYN8IIhJQcwYmkX0vNMXvGR+2O
	MJtndsWXYUA3MHM6x/Jrrru/0Xl0L38=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jens Axboe <axboe@kernel.dk>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Kees Cook <kees@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: Use sysfs_emit in sysfs show functions
Date: Fri, 27 Feb 2026 01:42:25 +0100
Message-ID: <20260227004227.798808-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace sprintf() with sysfs_emit() in sysfs show functions.
sysfs_emit() is preferred for formatting sysfs output because it
provides safer bounds checking.  No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 block/partitions/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 079057ab535a..7148d5bc37d9 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -8,6 +8,7 @@
 #include <linux/major.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/sysfs.h>
 #include <linux/ctype.h>
 #include <linux/vmalloc.h>
 #include <linux/raid/detect.h>
@@ -177,31 +178,31 @@ static struct parsed_partitions *check_partition(struct gendisk *hd)
 static ssize_t part_partition_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", bdev_partno(dev_to_bdev(dev)));
+	return sysfs_emit(buf, "%d\n", bdev_partno(dev_to_bdev(dev)));
 }
 
 static ssize_t part_start_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%llu\n", dev_to_bdev(dev)->bd_start_sect);
+	return sysfs_emit(buf, "%llu\n", dev_to_bdev(dev)->bd_start_sect);
 }
 
 static ssize_t part_ro_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", bdev_read_only(dev_to_bdev(dev)));
+	return sysfs_emit(buf, "%d\n", bdev_read_only(dev_to_bdev(dev)));
 }
 
 static ssize_t part_alignment_offset_show(struct device *dev,
 					  struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%u\n", bdev_alignment_offset(dev_to_bdev(dev)));
+	return sysfs_emit(buf, "%u\n", bdev_alignment_offset(dev_to_bdev(dev)));
 }
 
 static ssize_t part_discard_alignment_show(struct device *dev,
 					   struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%u\n", bdev_discard_alignment(dev_to_bdev(dev)));
+	return sysfs_emit(buf, "%u\n", bdev_discard_alignment(dev_to_bdev(dev)));
 }
 
 static DEVICE_ATTR(partition, 0444, part_partition_show, NULL);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

