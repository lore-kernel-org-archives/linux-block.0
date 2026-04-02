Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768263C9424
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775148712; cv=none; b=mLO/tpYBDiIE1E6dZlGs1Lo9gqcUcbbSGHT1N6LTCmD3uuEEy02qBmrvNQHk4GyWfi9xpyFHnHYXf9YXRixjiKwaBQFIreNHuhSDc4PiM4XJKyLMe8tnDExH0sOct6XfB4h0l8sa5AvdKuH359Oa+WjOtNufG9bkMZkQUebsI4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775148712; c=relaxed/simple;
	bh=7+ebTfKNmoY0GJbcW4ffsXXZItEMbgpQ6j+s1RZFbzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P8e3yyecPQsfHdmEcm8PmwnG/JbD8L17EeP6sP4RDK1+HyTUoJZJ49L8x16B4O22Uof8VCypc/ErJTEK+1cL06GWbzuztFXufURFYWM/HYznNPUn+fSuTb0q2lEZ+a7bJbcULQkR5dJQGmoUjME2dgJu5KEtW5dJZKKvJU+5klc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u51YtbSz; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u51YtbSz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775148695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e4OY0pFHQqF1taLpbuoZ/S+1gfsYOaYB6e+6qLBiwC8=;
	b=u51YtbSzkO9g4gp7z68UAp7pDnTk8CB3ln+PVWRTV7oW82r8aOpzSIOW5CLDL5lpOMy/HZ
	fGg2RDRo2EXZLugfGWVke2uIsjcusuar6yYXNxwsRtWIgdGidjVl7nDCBy3vyR+4ghjRXg
	GQHcPsBx0qbLPpz3FA6VEkyvCVzRGp4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jens Axboe <axboe@kernel.dk>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] block: use sysfs_emit in sysfs show functions
Date: Thu,  2 Apr 2026 18:50:00 +0200
Message-ID: <20260402164958.894879-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2186; i=thorsten.blum@linux.dev; h=from:subject; bh=nPckZVY05Ya9LYXM78UJ3KicfyNlpcwy07PqJzw0dyY=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnn5pl12c3Zqq3a6znPW2H5zrkdFze8PM58icX0qGO0R b1O6lmmjhIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjITglGhpk18ot+SF7jUe6Y 63R5rlvw/Rk7AlSsRJzio9esZk5Yv4bhu2P1sp3nY4/YvmiWrDm0JOLYjlnXGbKL2qbJVVgarrv JAAA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace sprintf() with sysfs_emit() in sysfs show functions.
sysfs_emit() is preferred for formatting sysfs output because it
provides safer bounds checking.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 block/partitions/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 740228750aaf..02ec8f663e6a 100644
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
