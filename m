Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1377157472
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734508167; cv=none; b=pUwQ2Qe8QTd4s81pgALIgrZiXVZf2ivLEVMm8CyIrHMwKx9rxqqL4pPkrRV800E0JOkAoi/YKZUiiVMqJxRr9Y+6tw6kX99NrJMy5TltJD7wOSWnPxxtf7QidU4ItXJs7/08o+D0lKgt3CgOVmh0Ntr962YRlXwwKRwWyeqWeMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734508167; c=relaxed/simple;
	bh=ArHPCKbBcyvmFDJUzdBCChdAglHFP6YwsnM4roDKVw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrcvTUnX5gYNoTjz0UAF09yvGuosK8FDWvqU6w6LV8A8avdmWW2tYBM2+wxLkKz50sscMmfroELv+7yEWuoZkU4su0I6jdsUdHTQwDI1VEiDxLU2QB8lTF87GXHro3D4db+yNl5s9nJOEc//I0RRKhIYAKe6Sp2TMaufJgz/ht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ldNFj04B; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ldNFj04B"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734508165; x=1766044165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ArHPCKbBcyvmFDJUzdBCChdAglHFP6YwsnM4roDKVw8=;
  b=ldNFj04BHDxVopQQCbuOvjF6XvnLgTMGXLHrvEfcStGjibRGfDxX1tuR
   tdPgyH5YBKaJ7DJc19dRzHBsGUEuiFoGQsi+B5nfOQHyTXGloBSQ9YGGn
   8IXAGxot1mDMX2V3bzU6mEopT7kRRkGHhB+ztex+gNpBEuLvKOOwFyz2V
   xD5xWi/hyq829ZNG65Z0JAkuJ6++4XWIEscKZaVoHWY34kdKjZF7gCUL3
   NT8b64zyBMoGi8KA5puhrgnUyL+ovbiUmijpb6FEqIQzv9aRlDbnDSZjF
   Tj8/HJQebklPFX+NrgVe16es9/nKP6MO4lqsPys5g06ECWLA9ExQ6ZPNX
   A==;
X-CSE-ConnectionGUID: 7P1mSLJRTr6b+rw/o9C0+w==
X-CSE-MsgGUID: DyxcYAITR66i3KKadC7bzg==
X-IronPort-AV: E=Sophos;i="6.12,244,1728921600"; 
   d="scan'208";a="35269665"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2024 15:49:17 +0800
IronPort-SDR: 67626fc8_e6fuRHvNEg3KuVOSeZDzAJhdLfhtObUHcaOWbV7DvruPrD7
 X9MgFFQOfjzGGh2N2+ou0/mHECZ0gbA20xAYuhA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2024 22:46:33 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Dec 2024 23:49:18 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH for-next 3/3] null_blk: introduce badblocks_once parameter
Date: Wed, 18 Dec 2024 16:49:14 +0900
Message-ID: <20241218074914.814913-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241218074914.814913-1-shinichiro.kawasaki@wdc.com>
References: <20241218074914.814913-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When IO errors happen on real storage devices, the IOs repeated to the
same target range can success by virtue of recovery features by devices,
such as reserved block assignment. To simulate such IO errors and
recoveries, introduce the new parameter badblocks_once parameter. When
this parameter is set to 1, the specified badblocks are cleared after
the first IO error, so that the next IO to the blocks succeed.

While at it, split the long string constant in
memb_group_features_show() into multiple lines to make future changes
easier to understand.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/block/null_blk/main.c     | 30 +++++++++++++++++++++---------
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 0f02e763cd9e..f5dd25fd1bbf 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -473,6 +473,7 @@ NULLB_DEVICE_ATTR(shared_tags, bool, NULL);
 NULLB_DEVICE_ATTR(shared_tag_bitmap, bool, NULL);
 NULLB_DEVICE_ATTR(fua, bool, NULL);
 NULLB_DEVICE_ATTR(rotational, bool, NULL);
+NULLB_DEVICE_ATTR(badblocks_once, bool, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
 {
@@ -611,6 +612,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_mbps,
 	&nullb_device_attr_cache_size,
 	&nullb_device_attr_badblocks,
+	&nullb_device_attr_badblocks_once,
 	&nullb_device_attr_zoned,
 	&nullb_device_attr_zone_size,
 	&nullb_device_attr_zone_capacity,
@@ -705,15 +707,23 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
 	return snprintf(page, PAGE_SIZE,
-			"badblocks,blocking,blocksize,cache_size,fua,"
-			"completion_nsec,discard,home_node,hw_queue_depth,"
-			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
-			"poll_queues,power,queue_mode,shared_tag_bitmap,"
-			"shared_tags,size,submit_queues,use_per_node_hctx,"
-			"virt_boundary,zoned,zone_capacity,zone_max_active,"
-			"zone_max_open,zone_nr_conv,zone_offline,zone_readonly,"
-			"zone_size,zone_append_max_sectors,zone_full,"
-			"rotational\n");
+			"badblocks,badblocks_once,blocking,blocksize,"
+			"cache_size,completion_nsec,"
+			"discard,"
+			"fua,"
+			"home_node,hw_queue_depth,"
+			"irqmode,"
+			"max_sectors,mbps,memory_backed,"
+			"no_sched,"
+			"poll_queues,power,"
+			"queue_mode,"
+			"rotational,"
+			"shared_tag_bitmap,shared_tags,size,submit_queues,"
+			"use_per_node_hctx,"
+			"virt_boundary,"
+			"zoned,zone_capacity,zone_max_active,zone_max_open,"
+			"zone_nr_conv,zone_offline,zone_readonly,zone_size,"
+			"zone_append_max_sectors,zone_full\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -1327,6 +1337,8 @@ static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
 	int bad_sectors;
 
 	if (badblocks_check(bb, sector, nr_sectors, &first_bad, &bad_sectors)) {
+		if (cmd->nq->dev->badblocks_once)
+			badblocks_clear(bb, first_bad, bad_sectors);
 		if (!IS_ALIGNED(first_bad, block_sectors))
 			first_bad = ALIGN_DOWN(first_bad, block_sectors);
 		if (dev->memory_backed && sector < first_bad) {
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index c6ceede691ba..b9cd85542498 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -63,6 +63,7 @@ struct nullb_device {
 	unsigned long flags; /* device flags */
 	unsigned int curr_cache;
 	struct badblocks badblocks;
+	bool badblocks_once;
 
 	unsigned int nr_zones;
 	unsigned int nr_zones_imp_open;
-- 
2.47.0

