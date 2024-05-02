Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DB082498
	for <linux-block@vger.kernel.org>; Thu,  2 May 2024 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714654844; cv=none; b=bBWgcmZXoFmQaNTwaKEbTQ3jFr50ag70YISwodVyORuGGX7Pc4NuJANFgohfMWpU+5CdWA/TjJcW70uXdVpCgDU/A3ym0I4Mm6RKeonLugZgUcWOzPn4HNsnje/1irXttur8+U5KTaok0dgqgnzSxVhSRnA3taukuRJmdiZjJ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714654844; c=relaxed/simple;
	bh=1U+Kh3hlSED8HrnAdOsdy60sZC6TEyEX1hh69gbLIYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kSpFjQCV6YYWpRGCh2VxNsgnM471oyfpTRdF8rvuJk+tgDfRjXzhkCmnDXlRidig3XHdqJJVn21bD/Av4V9R/wcuS33XAHFBW4peXaPiy1BIJAgeHO1Gs7wHxjYNyYBaInPZpdNvrTl1WSBisA02lFULiGg2nhuo1yQLqgXiI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hb1fbeqB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hb1fbeqB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XMA0Y4ySVhUqfZ5XnqoqS75sxnrPA9ZX/CVdHty0VuM=; b=hb1fbeqB8F4zAnBJ1eaLW4zNj4
	X6dv8KqmhbAubYAa1ZviYfGt1WjWav0xRfbh7AL75oocCaULXnYNFF+qtXKJLUvp9x21Hq01HWy6+
	GReLBu0c2uQEUJR83PXxu7TvBbNEI+LVwA3QqH3rl5nvNIbGFdmCvWrgv6YgMEMKHqh77WRqbc/oT
	N4G5DM2Y6se8ix058BZQChn9TAx2S7K7roN8Z+c8oleo1lJxe9IYSBIQgeKD1SXu43P02+KA3fhxe
	hVDtmcbnAJeUhSgCkMztL/HY3P9xBxYNjWvsqC4w0skDNFP3ksGSSooIDfKEgyd/+rPRw8XB4s+UA
	FM4W2baw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2W3C-0000000CjCK-328u;
	Thu, 02 May 2024 13:00:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Lennart Poettering <mzxreary@0pointer.de>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: add a disk_has_partscan helper
Date: Thu,  2 May 2024 15:00:32 +0200
Message-Id: <20240502130033.1958492-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502130033.1958492-1-hch@lst.de>
References: <20240502130033.1958492-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a helper to check if partition scanning is enabled instead of
open coding the check in a few places.  This now always checks for
the hidden flag even if all but one of the callers are never reachable
for hidden gendisks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c           |  7 ++-----
 block/partitions/core.c |  5 +----
 include/linux/blkdev.h  | 13 +++++++++++++
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index eb893df56d510e..4b85963d09dbb4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -345,9 +345,7 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 	struct file *file;
 	int ret = 0;
 
-	if (disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN))
-		return -EINVAL;
-	if (test_bit(GD_SUPPRESS_PART_SCAN, &disk->state))
+	if (!disk_has_partscan(disk))
 		return -EINVAL;
 	if (disk->open_partitions)
 		return -EBUSY;
@@ -503,8 +501,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 			goto out_unregister_bdi;
 
 		/* Make sure the first partition scan will be proceed */
-		if (get_capacity(disk) && !(disk->flags & GENHD_FL_NO_PART) &&
-		    !test_bit(GD_SUPPRESS_PART_SCAN, &disk->state))
+		if (get_capacity(disk) && disk_has_partscan(disk))
 			set_bit(GD_NEED_PART_SCAN, &disk->state);
 
 		bdev_add(disk->part0, ddev->devt);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b11e88c82c8cfa..37b5f92d07fec9 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -573,10 +573,7 @@ static int blk_add_partitions(struct gendisk *disk)
 	struct parsed_partitions *state;
 	int ret = -EAGAIN, p;
 
-	if (disk->flags & GENHD_FL_NO_PART)
-		return 0;
-
-	if (test_bit(GD_SUPPRESS_PART_SCAN, &disk->state))
+	if (!disk_has_partscan(disk))
 		return 0;
 
 	state = check_partition(disk);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 040a22e0eda0ec..3b18a40a1fc109 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -230,6 +230,19 @@ static inline unsigned int disk_openers(struct gendisk *disk)
 	return atomic_read(&disk->part0->bd_openers);
 }
 
+/**
+ * disk_has_partscan - return %true if partition scanning is enabled on a disk
+ * @disk: disk to check
+ *
+ * Returns %true if partitions scanning is enabled for @disk, or %false if
+ * partition scanning is disabled either permanently or temporarily.
+ */
+static inline bool disk_has_partscan(struct gendisk *disk)
+{
+	return !(disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN)) &&
+		!test_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
+}
+
 /*
  * The gendisk is refcounted by the part0 block_device, and the bd_device
  * therein is also used for device model presentation in sysfs.
-- 
2.39.2

