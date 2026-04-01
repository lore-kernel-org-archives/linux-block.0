Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E6636BCD7
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027304; cv=none; b=aBsS9gH2BQC7mHvVA+e7CuQj1ZRL4oqdW+yfota0PhPW2wBHSHM40zjGOMyYJqLwSEziDhZLnXK3YGG4zx8SgOKsqPdPU1eDtj+GcPAiFZOIxaB8bSjkW54r8bwrcNijxJoEFCga3qgqTHTJSAUG93aPJJCwYbqDVEyMeI+cdjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027304; c=relaxed/simple;
	bh=oki9Ye+NY+/Q4tb/P4dNK3f+vA8JkcPusZULwUsoVgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsJhKoyWYTURD+/mAIvRzIBQGQcepgxUf/m3N7CZwoFCI8sGgpsc66tCM+WGLjHSzQIXNvL67as5fNAAgUwC/vUWexcPtyQ/QyXaNC2kh2LE9yXqOcMvK+P+grv9ZGeh+AwI4WOG+Pmd8IhDMUt6rMqY31hQ8xaqqvEVLZeQ+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ECTNUkHV; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ECTNUkHV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775027300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQ4NF6Kw/CrnmTOzxipIUBof2Dar5S2ibZH/zYluup4=;
	b=ECTNUkHVcYrD6B5Uv227LykRvbTnJ8w9/7rpo3L0YRh9X8TrHe/7wa5YdHnJ43Hl1uQQY5
	by/VI7o1xonfmh+e601/apLPtaZ9nHgDoaACxukuhz/2hutSoOee6MKsHI3AnTmGoDASQv
	Cak+tzCHZxy8vGsvhiyqfs/ynfk8yjY=
From: Jackie Liu <liu.yun@linux.dev>
To: axboe@kernel.dk,
	yukuai@fnnas.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 04/10] block: convert partition sysfs show to sysfs_emit()
Date: Wed,  1 Apr 2026 15:07:10 +0800
Message-ID: <20260401070716.991-5-liu.yun@linux.dev>
In-Reply-To: <20260401070716.991-1-liu.yun@linux.dev>
References: <20260401070716.991-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jackie Liu <liuyun01@kylinos.cn>

Use sysfs_emit() instead of sprintf() for partition attribute
show functions.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/partitions/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 740228750aaf..41b5c09d4551 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -177,31 +177,31 @@ static struct parsed_partitions *check_partition(struct gendisk *hd)
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
2.51.1

