Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEF9258CE0
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564380; cv=none; b=kPmTDKZV/obKrGEDsFMzQPML57RKMk5z8B3f+goE/90FMVtCHyloYUdWDwB6j9G+/YejoKEzBbA0eDfWWu8dqPgVdPvMAoBpkkEM94sEUmiAufgVsaRxnCZemmUqUV0TyMahwj1Ow36WCQAk2Um2Nw6G2gmT9GGZksLDOAoUcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564380; c=relaxed/simple;
	bh=MZcWaUv4BjrdXoiXTePsbpPpTSePEla6L3tbWaLAPIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzZj+3eU3zBd7vh/JJfEKv5kv1zP4mr9hVK+GfGJ2KJCrUONs/WvhFIazQ2CmWntn74h4C4JFftmimE4woBEc3EF4CXHLuyFpIFNelFSKaYU4suCnVjAy9HK79W41r1CWzDvb60cgA+ujQQ0sQKrgj+CQEwu8KA0UfUYVjDBSOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BN0FfBLy; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BN0FfBLy"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740564377; x=1772100377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MZcWaUv4BjrdXoiXTePsbpPpTSePEla6L3tbWaLAPIw=;
  b=BN0FfBLyBKCXPHmjxY5TK/p9ZMNlMvwuVfs+g5r4xPcxtJAhhTetAr65
   Lxx0YgrA8aqy1v55cpV8z+1yp0vWd5wwI5AEMIGF15YBaIuKVUIaFc40p
   ToliifZwjyd69HvFoHDvJX9NLRmEWse6/L98x+yU1qYp3fjl2sFtGMJbQ
   i0rBUCxtvLcXw4iSfH2u5BhzlDDAhvgwdD6Nf1yCg/gKLmefeHOxsLA3K
   fJe9r6CVZWztR4R/gjBz8Iq8vUhXpmFi7AWYf9yAkVoK2YWim0Doezzpd
   1mDoBIbvD89Lm+xsTrfP2LJZ/h8qIZOteBjfSMqXpninUD7vkgbQXu3rI
   A==;
X-CSE-ConnectionGUID: BPpl33fxSpSbJ8ssYjhO7w==
X-CSE-MsgGUID: N4rPjujsTcuvcnIPR8bV5Q==
X-IronPort-AV: E=Sophos;i="6.13,316,1732550400"; 
   d="scan'208";a="39484502"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2025 18:06:16 +0800
IronPort-SDR: 67bed9d4_vnMpdRUaM+FHGrjapybHRi8BnhDpqhgWhbsj5Ww0OC5JZJ2
 BBtZNOhbpbfLdFSIn4TYyf4E6e+OSza9AAu14WA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2025 01:07:33 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Feb 2025 02:06:16 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH for-next v7 1/5] null_blk: generate null_blk configfs features string
Date: Wed, 26 Feb 2025 19:06:09 +0900
Message-ID: <20250226100613.1622564-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250226100613.1622564-1-shinichiro.kawasaki@wdc.com>
References: <20250226100613.1622564-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The null_blk configfs file 'features' provides a string that lists
available null_blk features for userspace programs to reference.
The string is defined as a long constant in the code, which tends to be
forgotten for updates. It also causes checkpatch.pl to report
"WARNING: quoted string split across lines".

To avoid these drawbacks, generate the feature string on the fly. Refer
to the ca_name field of each element in the nullb_device_attrs table and
concatenate them in the given buffer. Also, sorted nullb_device_attrs
table elements in alphabetical order.

Of note is that the feature "index" was missing before this commit.
This commit adds it to the generated string.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/block/null_blk/main.c | 90 ++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 39 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d94ef37480bd..0725d221cff4 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -592,41 +592,41 @@ static ssize_t nullb_device_zone_offline_store(struct config_item *item,
 CONFIGFS_ATTR_WO(nullb_device_, zone_offline);
 
 static struct configfs_attribute *nullb_device_attrs[] = {
-	&nullb_device_attr_size,
-	&nullb_device_attr_completion_nsec,
-	&nullb_device_attr_submit_queues,
-	&nullb_device_attr_poll_queues,
-	&nullb_device_attr_home_node,
-	&nullb_device_attr_queue_mode,
+	&nullb_device_attr_badblocks,
+	&nullb_device_attr_blocking,
 	&nullb_device_attr_blocksize,
-	&nullb_device_attr_max_sectors,
-	&nullb_device_attr_irqmode,
+	&nullb_device_attr_cache_size,
+	&nullb_device_attr_completion_nsec,
+	&nullb_device_attr_discard,
+	&nullb_device_attr_fua,
+	&nullb_device_attr_home_node,
 	&nullb_device_attr_hw_queue_depth,
 	&nullb_device_attr_index,
-	&nullb_device_attr_blocking,
-	&nullb_device_attr_use_per_node_hctx,
-	&nullb_device_attr_power,
-	&nullb_device_attr_memory_backed,
-	&nullb_device_attr_discard,
+	&nullb_device_attr_irqmode,
+	&nullb_device_attr_max_sectors,
 	&nullb_device_attr_mbps,
-	&nullb_device_attr_cache_size,
-	&nullb_device_attr_badblocks,
-	&nullb_device_attr_zoned,
-	&nullb_device_attr_zone_size,
-	&nullb_device_attr_zone_capacity,
-	&nullb_device_attr_zone_nr_conv,
-	&nullb_device_attr_zone_max_open,
-	&nullb_device_attr_zone_max_active,
-	&nullb_device_attr_zone_append_max_sectors,
-	&nullb_device_attr_zone_readonly,
-	&nullb_device_attr_zone_offline,
-	&nullb_device_attr_zone_full,
-	&nullb_device_attr_virt_boundary,
+	&nullb_device_attr_memory_backed,
 	&nullb_device_attr_no_sched,
-	&nullb_device_attr_shared_tags,
-	&nullb_device_attr_shared_tag_bitmap,
-	&nullb_device_attr_fua,
+	&nullb_device_attr_poll_queues,
+	&nullb_device_attr_power,
+	&nullb_device_attr_queue_mode,
 	&nullb_device_attr_rotational,
+	&nullb_device_attr_shared_tag_bitmap,
+	&nullb_device_attr_shared_tags,
+	&nullb_device_attr_size,
+	&nullb_device_attr_submit_queues,
+	&nullb_device_attr_use_per_node_hctx,
+	&nullb_device_attr_virt_boundary,
+	&nullb_device_attr_zone_append_max_sectors,
+	&nullb_device_attr_zone_capacity,
+	&nullb_device_attr_zone_full,
+	&nullb_device_attr_zone_max_active,
+	&nullb_device_attr_zone_max_open,
+	&nullb_device_attr_zone_nr_conv,
+	&nullb_device_attr_zone_offline,
+	&nullb_device_attr_zone_readonly,
+	&nullb_device_attr_zone_size,
+	&nullb_device_attr_zoned,
 	NULL,
 };
 
@@ -704,16 +704,28 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
-	return snprintf(page, PAGE_SIZE,
-			"badblocks,blocking,blocksize,cache_size,fua,"
-			"completion_nsec,discard,home_node,hw_queue_depth,"
-			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
-			"poll_queues,power,queue_mode,shared_tag_bitmap,"
-			"shared_tags,size,submit_queues,use_per_node_hctx,"
-			"virt_boundary,zoned,zone_capacity,zone_max_active,"
-			"zone_max_open,zone_nr_conv,zone_offline,zone_readonly,"
-			"zone_size,zone_append_max_sectors,zone_full,"
-			"rotational\n");
+
+	struct configfs_attribute **entry;
+	char delimiter = ',';
+	size_t left = PAGE_SIZE;
+	size_t written = 0;
+	int ret;
+
+	for (entry = &nullb_device_attrs[0]; *entry && left > 0; entry++) {
+		if (!*(entry + 1))
+			delimiter = '\n';
+		ret = snprintf(page + written, left, "%s%c", (*entry)->ca_name,
+			       delimiter);
+		if (ret >= left) {
+			WARN_ONCE(1, "Too many null_blk features to print\n");
+			memzero_explicit(page, PAGE_SIZE);
+			return -ENOBUFS;
+		}
+		left -= ret;
+		written += ret;
+	}
+
+	return written;
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
-- 
2.47.0

