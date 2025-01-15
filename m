Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB09F22DF94
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 04:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736915356; cv=none; b=ibFPaNUuzVUo2MytRqzrLRGII0Xmx2TwXjOsA9Y3iiUtZGjvxerl8hH3bXgI8y4o/rlcEpTNwvNfBM5FnmLMpzsYPo6u/ppgvP+EVHu02/dOfYuMT48cdLsEmhPUS80VTbNl5dGWPMf0LkhoiHtVjh4AfCiUsqRdHa/N7q9nQ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736915356; c=relaxed/simple;
	bh=JZklDGRe/WQ+gygrKg1PQfeKzvjIHpxPUO+kve/WG8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5FYLdxTCj+oNegSJd4gt/ZvU005YJXFADfrjcF2Y21Psu0JZ7WuEybQflZ3VHSkjbmwxpTNK0tYA1G14zH8C7LY13lzYD4IlzaGilfL3RjeQL2pbSCKCDCQcFto2bA2f0cq6Gdjzc37ukPfNcH2sMLwOH2wf84QXt4z7pXdvzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PIfZISwJ; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PIfZISwJ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736915355; x=1768451355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JZklDGRe/WQ+gygrKg1PQfeKzvjIHpxPUO+kve/WG8w=;
  b=PIfZISwJYy2VHusH8zo58iU6xOjviSCUbj+1pkmA1IXnuW6gqYlLORH4
   9lglrb7eQ8dK8N5CYtdl7chbvUCMN8xVRl49VZzmS2fQPZyX/uggRUXEO
   uqbaIaPM8gCjyS9ZPTPEr+S6NDOW9Tj5R2Q4CfyBcUnZIdLuqoSF8njBm
   TXNw9iZUZLDVRDP9lW9QGlv992oxvxuFm6aX7NDxcUjFuj5Zzkc782suq
   4/Av33Rwvp/VRqvJ5eYd6ePvRnFRW3rvT7ZntlbALlmfnfbYI2FRgSVpQ
   jAtzwnQ71a4LFl4zSZtyVTyN0x1oK860ET3IrCHR476IlOH1qf3THhN4y
   w==;
X-CSE-ConnectionGUID: pKeAiCAhS7mykckBkHjiOQ==
X-CSE-MsgGUID: WzdRqO8AS32fCkXMgTcJjw==
X-IronPort-AV: E=Sophos;i="6.12,316,1728921600"; 
   d="scan'208";a="35958011"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2025 12:29:15 +0800
IronPort-SDR: 67872ac2_BZ2g718y97ydymD1vTM5QdH8UU1WrXyUy4Y3MWBEMQh95rf
 MMo8yLFv+1qvbHma3xP/yLs6d+F7YKATjTyppaA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jan 2025 19:25:54 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Jan 2025 20:29:13 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH for-next v3 2/5] null_blk: introduce badblocks_once parameter
Date: Wed, 15 Jan 2025 13:29:07 +0900
Message-ID: <20250115042910.1149966-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250115042910.1149966-1-shinichiro.kawasaki@wdc.com>
References: <20250115042910.1149966-1-shinichiro.kawasaki@wdc.com>
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

