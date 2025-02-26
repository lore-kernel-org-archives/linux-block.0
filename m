Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C270623815A
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564380; cv=none; b=oqzRREHvjmG1bSCqkfQPMePFAoc603QetCZ3B6Wa1dU80ZjSPQllVoR9df6K5wSNzcAFzlmEcc2sprCUZdp7SdVEXVuU/HYRNe/JIfk6mHtQQDTYUB+iOzadV1Tjr/KGuCAd9bOut6+TQNXi9L+gBsJyTMzQWbGvPEgdpLgfqmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564380; c=relaxed/simple;
	bh=kNdSdeAHTow2OCfTg8+WQjcPf/Mj+vRVfPO159Qw7MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgW6hzAs7Ppk1i/CC3pit/CnVxjXuu9uW+DUxBsgm/5yXd2P9eRpcpa3XpCqvjjS5a6FW5Gid0fsTs+uIOlQ4A+flmok8Y1DcZwoNyWozEpMM6OyHENAWg41YBfcFfsNol7mQ7SrmHQydNt4o5mfoFeTscfcXzdNCrDE0Xst6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fsVniUWC; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fsVniUWC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740564378; x=1772100378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kNdSdeAHTow2OCfTg8+WQjcPf/Mj+vRVfPO159Qw7MY=;
  b=fsVniUWCmX8ydHB1PKzK4Qz4fPgGKnaxZyPggjioajPlG6VNX9AfwgGG
   Yb31y/g4o2NolBNU3Jn1wgqvQiAXmRoWnuaE7kIOVdxuEwvUSxQ4jyTXP
   fPzKMEAz42j7nI6bXvaFb2MOxqC2P2p8Mr6aeztSMbWNzW6+AGnUyYfep
   nOftrD+a804YlzE6ybm78UKvE6X5vQaGNT5ypgZ6TOrSo1HwpTrFVS45N
   pobP5CLvTuAvwsRZtXNAeW7P56Aphc90VjE5mwXSfKRYrKr1Rl9y3Zyg2
   EOtqf7xNNQRd5u3Ptj5oyYslJRdJTTYnSOc/CqhuuQP4S4yKieCYfKzkC
   w==;
X-CSE-ConnectionGUID: 1jxvqJwIQw+epRo40kZCwg==
X-CSE-MsgGUID: jsGg0HCBTLWywXOE7HlNoQ==
X-IronPort-AV: E=Sophos;i="6.13,316,1732550400"; 
   d="scan'208";a="39484511"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2025 18:06:18 +0800
IronPort-SDR: 67bed9d6_cSIr+TAu0cdpGUr+Xyu/AKmBqBFSnsdj6lauCO0jrKV+nXX
 4flEpveZXueFbq6vM7lOVm+iPxmE6LLKCP8O3Wg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2025 01:07:34 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Feb 2025 02:06:17 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH for-next v7 2/5] null_blk: introduce badblocks_once parameter
Date: Wed, 26 Feb 2025 19:06:10 +0900
Message-ID: <20250226100613.1622564-3-shinichiro.kawasaki@wdc.com>
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

When IO errors happen on real storage devices, the IOs repeated to the
same target range can success by virtue of recovery features by devices,
such as reserved block assignment. To simulate such IO errors and
recoveries, introduce the new parameter badblocks_once parameter. When
this parameter is set to 1, the specified badblocks are cleared after
the first IO error, so that the next IO to the blocks succeed.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/block/null_blk/main.c     | 11 ++++++++---
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 0725d221cff4..2a060a6ea8c0 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -473,6 +473,7 @@ NULLB_DEVICE_ATTR(shared_tags, bool, NULL);
 NULLB_DEVICE_ATTR(shared_tag_bitmap, bool, NULL);
 NULLB_DEVICE_ATTR(fua, bool, NULL);
 NULLB_DEVICE_ATTR(rotational, bool, NULL);
+NULLB_DEVICE_ATTR(badblocks_once, bool, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
 {
@@ -593,6 +594,7 @@ CONFIGFS_ATTR_WO(nullb_device_, zone_offline);
 
 static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_badblocks,
+	&nullb_device_attr_badblocks_once,
 	&nullb_device_attr_blocking,
 	&nullb_device_attr_blocksize,
 	&nullb_device_attr_cache_size,
@@ -1315,10 +1317,13 @@ static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
 	sector_t first_bad;
 	int bad_sectors;
 
-	if (badblocks_check(bb, sector, nr_sectors, &first_bad, &bad_sectors))
-		return BLK_STS_IOERR;
+	if (!badblocks_check(bb, sector, nr_sectors, &first_bad, &bad_sectors))
+		return BLK_STS_OK;
 
-	return BLK_STS_OK;
+	if (cmd->nq->dev->badblocks_once)
+		badblocks_clear(bb, first_bad, bad_sectors);
+
+	return BLK_STS_IOERR;
 }
 
 static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 6f9fe6171087..3c4c07f0418b 100644
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

