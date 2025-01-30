Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCDB1A4AAA
	for <linux-block@vger.kernel.org>; Thu, 30 Jan 2025 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738225635; cv=none; b=HgrFJHXiqySW0haskrBb8Szi4JWep4vIUXUOgRGbOkBjHVP8T9FjU0bRdcyC2IMzC7fAGm84BnA0s96xPhBvAEy0HCXH9w+DyLMZkGou+c/Pv3M+s9ro98f1HCgMIfIhm8ai2gwtTgoBBKcxLygur/dVHbffW1OE/oCm45t9k58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738225635; c=relaxed/simple;
	bh=kNdSdeAHTow2OCfTg8+WQjcPf/Mj+vRVfPO159Qw7MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EP7BOqGq6m8/pupLIjdHstb/dqb6159RELJQRtNwfQfU11DV43GFJEGSzs8iv0L03pyAG0mzGPdhve2fdGX+1ITDaFY0ci+oNYY9e7tPBLG8bSOrR1xzcOnTT5q5AZXzzAO1qetyw2hpjXSmt2p19CqcaVY4f61qxMMyBfemcIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VKOk4dIh; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VKOk4dIh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738225633; x=1769761633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kNdSdeAHTow2OCfTg8+WQjcPf/Mj+vRVfPO159Qw7MY=;
  b=VKOk4dIh37HTbD4TMBbRjRf3tTBHfWoySrYC1ccW5/hgbbXLWKAfmose
   AiHxt57tLzj23DPiGGe72k6e9Rw3cBpSeK0h1TU+F/5xYKCgIxmRraSgs
   oZu/OK+VswmCLhl3kP8iLbHYO9Ps4wOCa+QjQVfzj98b8S/ApaSll9dL2
   YnxURScqBP0cdpACqMSHDTo57kREiGJqt4c9IanUXELHFzKP+xms4uLnP
   LH/PX3zNBtI15xQFv3rUi8dprFWZPRvXDUrD8eujAw3Eg7Fbf7botTQC2
   CAaraFwP6a6YL6+Ys+04fS/BpbhLVzQAJRBOSWyZMxyxHV5TudZa1ZPhf
   Q==;
X-CSE-ConnectionGUID: p+a2BTgYTAi/nVGHRy5GTg==
X-CSE-MsgGUID: 8D5xOAiqQwGY8ceMZbGnZg==
X-IronPort-AV: E=Sophos;i="6.13,244,1732550400"; 
   d="scan'208";a="38377845"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2025 16:27:07 +0800
IronPort-SDR: 679b2a3a_UUzzT7UKuSOUIkqKlbR3noMKti4LIJo9YmAb41BFfkq57Of
 Ehkpr4Lh214Vr8wBX64q2tj+wtDMKg9EakJvBWA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2025 23:28:59 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jan 2025 00:27:07 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v6 2/5] null_blk: introduce badblocks_once parameter
Date: Thu, 30 Jan 2025 17:27:00 +0900
Message-ID: <20250130082703.1330857-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250130082703.1330857-1-shinichiro.kawasaki@wdc.com>
References: <20250130082703.1330857-1-shinichiro.kawasaki@wdc.com>
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

