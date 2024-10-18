Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154E618CBEA;
	Fri, 18 Oct 2024 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238074; cv=none; b=FT17VNoi+G87fmOY3AgdXttz4Q2FVe30O1lENsVyfSCcE8bWHB+hzkos3cMyh17IrwO3pcL3bZmNUVDRzoUq24FskkxElc3AOZUe363yImttTQKfN1Lae6ICtkuNgVWYnPPditdD4gPpH6yTBst2vRpcY8OrY6q6NXI/gNb4hIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238074; c=relaxed/simple;
	bh=hFiA3yVMRXmu3FFPYS/22OGs0zS/sa/t+OHctXnHRxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFurnjQNcbIVrM9a0Kwy97gj8kh3mROyspsYoYb33K0o+eqBHOPEDZiVKpvYFsrf36J+QrchNwAyX9XesIjNVjicz6pqQDgk0kAvRIQlT/o7QDn1H2KQ34itX8bxKmvIDirUNhDPcSwRLdrXIPzwBSI5Ct7zBmb8IRILuUZMgow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nbz983L2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nbz983L2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729238073; x=1760774073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hFiA3yVMRXmu3FFPYS/22OGs0zS/sa/t+OHctXnHRxw=;
  b=Nbz983L2AGPkpFPZbPp9hF4U3ZGe2i/IcU3bk+tA7Dh/n2sT2n7k0985
   WQl+eQj/WWrWK9kVA6Zo8B/KO3yyZXMr+Q2/Lc4OQxwDFFle1ddbB19DU
   3OD15nbp/jk817fmuSx698jn3vIIezpod9v+aeQYzZiMJZg34wrhy1QdP
   XimWEV1dp6QyyPM4j2dK94nbyK9MVomqC+YkleIdpnP3P6MfJMutNRY8t
   IEF+5hjEErCt/yCOYPW9eH4/rx5TK+5maDTu3P8C02SMKMWjGyAWPLy5m
   9TnXVkvUs70npPsizQ5uSxWQFpq3fPk2bu7eVj1oDZBrEvZ1E5W4v/2ZR
   Q==;
X-CSE-ConnectionGUID: dUPcKe/9QC2rdK007xLv7g==
X-CSE-MsgGUID: z5cLq1ubTSC1XaeMtNUIug==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28549567"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28549567"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 00:54:33 -0700
X-CSE-ConnectionGUID: lmYFe0tdSnawla+UrnCTMg==
X-CSE-MsgGUID: Q7JGkfbBQNCA8IW3wANpIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="79604068"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.169])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 00:54:25 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: axboe@kernel.dk
Cc: hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 1/2] block/genhd: add sysfs knobs for the CPU latency PM QoS settings
Date: Fri, 18 Oct 2024 10:30:37 +0300
Message-ID: <20241018075416.436916-2-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241018075416.436916-1-tero.kristo@linux.intel.com>
References: <20241018075416.436916-1-tero.kristo@linux.intel.com>
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
 block/genhd.c          | 47 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  3 +++
 2 files changed, 50 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 1c05dd4c6980..e60af2639136 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1046,6 +1046,48 @@ static ssize_t partscan_show(struct device *dev,
 	return sprintf(buf, "%u\n", disk_has_partscan(dev_to_disk(dev)));
 }
 
+static ssize_t cpu_lat_limit_us_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+
+	return sprintf(buf, "%d\n", disk->cpu_lat_limit);
+}
+
+static ssize_t cpu_lat_limit_us_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	int i;
+
+	if (count > 0 && !kstrtoint(buf, 10, &i))
+		disk->cpu_lat_limit = i;
+
+	return count;
+}
+
+static ssize_t cpu_lat_timeout_ms_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+
+	return sprintf(buf, "%d\n", disk->cpu_lat_timeout);
+}
+
+static ssize_t cpu_lat_timeout_ms_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	int i;
+
+	if (count > 0 && !kstrtoint(buf, 10, &i))
+		disk->cpu_lat_timeout = i;
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
@@ -1377,6 +1423,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
 	INIT_LIST_HEAD(&disk->slave_bdevs);
 #endif
+	disk->cpu_lat_limit = -1;
 	return disk;
 
 out_erase_part0:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50c3b959da28..8bf76da2efac 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -213,6 +213,9 @@ struct gendisk {
 	u64 diskseq;
 	blk_mode_t open_mode;
 
+	int cpu_lat_limit;
+	int cpu_lat_timeout;
+
 	/*
 	 * Independent sector access ranges. This is always NULL for
 	 * devices that do not have multiple independent access ranges.
-- 
2.43.1

