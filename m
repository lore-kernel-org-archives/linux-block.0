Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6908189F3C;
	Thu, 29 Aug 2024 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918080; cv=none; b=rIgLDWgitjrxkrsZpteF3Jm8r/bCK5+BvDm4SlKLWTXYHTE6k9cEluEIQ50z6DMWSNFLQZBcDZSbkj8ICoov1FU1d/j0R+V5udL12UP6DSyz0Jbkoql14ms1ANm4zEf9Tbccyu8fcGNJ0H9/8KuJ7DAaGhMLD6cygATcmmCqXvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918080; c=relaxed/simple;
	bh=6ctqR1JOxjRDrvBOIC24P/w4dBCCpjzFRRxbNdyaogM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZygL0NLxdvn95oARiLqWjCZ7sP+DIMoIn1tGPKOVZAiM8PXNWCm70CUV+Ccwcq3h1dDKrYSnA+HHzd/vCGeK0J3ZH80XgJtEmRbn6t4+5NNfNWWWU9nW/QH6+vEQ+0FNXwhIrx4eStF6vtu3AsSzGJQOUO1/T+40hVSkq9/nuq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+Uoi8rM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+Uoi8rM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724918079; x=1756454079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ctqR1JOxjRDrvBOIC24P/w4dBCCpjzFRRxbNdyaogM=;
  b=b+Uoi8rMN78MYkrsZ+N3eRy7UlPCTvPP+VquJwhbqxq54vmrgd7jLYUE
   A8dWMe2WgP1zG4MqnXhj/JU0kvgnOvqN7+vBZIuO7FGcE4MH5NmcB+a9r
   gllzX7Vuy37cYz3m9JKmlO3yi9jd7WE1nhgf6GV+YDlxPO9cUtSBhj7pK
   TyaoLYTKBJmBJKafCvzNF4oD3u0AASy/KMrFImGtXZolig8EYqRtHiIXX
   K0B/9h8yJIYlbmyEBhtN+Xho5g/qLqhgiOXMS3XvmsLhimobVYvsRg36a
   L1fhmhULnzF/wtyLjTNJbwxCsAH0XAeaQ57LeTLHH/oCc1RhoaaVlkyKr
   g==;
X-CSE-ConnectionGUID: aXwbDyAlQTyNyZsGJltvow==
X-CSE-MsgGUID: YC5x3lNoQVGOtK1wffbqgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="13275405"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="13275405"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 00:54:39 -0700
X-CSE-ConnectionGUID: RlnBxwenRv2Adg5yY7l2TA==
X-CSE-MsgGUID: /SJSYfs3SYa7mC7K8Q+Urw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="68161193"
Received: from carterle-desk.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.205])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 00:54:38 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] block/genhd: add sysfs knobs for the CPU latency PM QoS settings
Date: Thu, 29 Aug 2024 10:18:20 +0300
Message-ID: <20240829075423.1345042-3-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829075423.1345042-1-tero.kristo@linux.intel.com>
References: <20240829075423.1345042-1-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sysfs knobs for the following parameters:

  cpu_lat_limit_us: for limiting the CPU latency to given value when block IO
		    is running
  cpu_lat_timeout_ms: for clearing up the CPU latency limit after block IO
		      is complete

This can be used to prevent the CPU from entering deep idle states when
block IO is running and waiting for an interrupt, potentially causing
large latencies to the operation.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 block/genhd.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 8f1f3c6b4d67..2fbd967a3e36 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1046,6 +1046,48 @@ static ssize_t partscan_show(struct device *dev,
 	return sprintf(buf, "%u\n", disk_has_partscan(dev_to_disk(dev)));
 }
 
+static ssize_t cpu_lat_limit_us_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct block_device *bdev = dev_to_bdev(dev);
+
+	return sprintf(buf, "%d\n", bdev->cpu_lat_limit);
+}
+
+static ssize_t cpu_lat_limit_us_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct block_device *bdev = dev_to_bdev(dev);
+	int i;
+
+	if (count > 0 && !kstrtoint(buf, 10, &i))
+		bdev->cpu_lat_limit = i;
+
+	return count;
+}
+
+static ssize_t cpu_lat_timeout_ms_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct block_device *bdev = dev_to_bdev(dev);
+
+	return sprintf(buf, "%d\n", bdev->cpu_lat_timeout);
+}
+
+static ssize_t cpu_lat_timeout_ms_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct block_device *bdev = dev_to_bdev(dev);
+	int i;
+
+	if (count > 0 && !kstrtoint(buf, 10, &i))
+		bdev->cpu_lat_timeout = i;
+
+	return count;
+}
+
 static DEVICE_ATTR(range, 0444, disk_range_show, NULL);
 static DEVICE_ATTR(ext_range, 0444, disk_ext_range_show, NULL);
 static DEVICE_ATTR(removable, 0444, disk_removable_show, NULL);
@@ -1060,6 +1102,8 @@ static DEVICE_ATTR(inflight, 0444, part_inflight_show, NULL);
 static DEVICE_ATTR(badblocks, 0644, disk_badblocks_show, disk_badblocks_store);
 static DEVICE_ATTR(diskseq, 0444, diskseq_show, NULL);
 static DEVICE_ATTR(partscan, 0444, partscan_show, NULL);
+static DEVICE_ATTR_RW(cpu_lat_limit_us);
+static DEVICE_ATTR_RW(cpu_lat_timeout_ms);
 
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 ssize_t part_fail_show(struct device *dev,
@@ -1111,6 +1155,8 @@ static struct attribute *disk_attrs[] = {
 	&dev_attr_events_poll_msecs.attr,
 	&dev_attr_diskseq.attr,
 	&dev_attr_partscan.attr,
+	&dev_attr_cpu_lat_limit_us.attr,
+	&dev_attr_cpu_lat_timeout_ms.attr,
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	&dev_attr_fail.attr,
 #endif
-- 
2.43.1

