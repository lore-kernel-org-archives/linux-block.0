Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF30A1AFB36
	for <linux-block@vger.kernel.org>; Tue, 21 Jan 2025 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737447329; cv=none; b=IuWXrkAD2TO7Vae6VoqtyiZCJcuPcsKv0iOetPX9DQ0k1k9jYVW+4TRT1PjZ9HKsfaEgmnyau2JZ+9568tb9WiQ5Vf7cNNWqMcdV5Lt8auPFukJlFt/QfdLtPpEE3OZv1/KzgLMs7HNQJ2CXO6q+g7cG2y+XJOPMRxE7GlzRTZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737447329; c=relaxed/simple;
	bh=NEU8/bjKUkJ2yiA62sKp1N5ee0MPHR3UFQl5iATMtoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skKddXxTsl0+s49i/a1duRgLvC1XCG3H+fWTpeDEP16n2fYS01Kb1gyf7CPp1fWtHv0Z9pMj6SrfkCT7J715r7oi5NrGwu9rEVXgUdXVddynwTIxLf1ixKRTBAqg1id7zqA8NYfS1oDnJ3pfi7Bjl4ABV1gz9Uwkq/bO560WPfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EBgFfA20; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EBgFfA20"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737447327; x=1768983327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NEU8/bjKUkJ2yiA62sKp1N5ee0MPHR3UFQl5iATMtoY=;
  b=EBgFfA20VFNQym/P/m6GJXceB2wL9vAn6qf3v6Fmr6iCIVrS/3Rdqz9T
   YpKP+7IOUWjz8mvhg4SDd6hhS+qxaiNuXVN59qnpqqJSXVDVHbtcncUNC
   fXOYa4jm3Zs5s39AP0jc+HOqDsE+M9xJGuWKkeIxZJU0myTZLnE+8QsnZ
   iWtlwPlfx/B6H0oETbDDRyVkgm/2pbckXZsnn+RV1anw0njkm6+0svIox
   i5BaHW3T7L8MwZ3zEfNJmnDeSx0vmQVOQgBgZOmCMbyHf+1UKYdp0RbLY
   noJMO7HYfvv5aWDP/OxfzrTITneps+LPNuixhqX+BBZDNq1q9/bs0VIp9
   A==;
X-CSE-ConnectionGUID: tNw6URauQKy482JE8QmTQg==
X-CSE-MsgGUID: SG1MoTHSS6eiZywd/MzBtw==
X-IronPort-AV: E=Sophos;i="6.13,221,1732550400"; 
   d="scan'208";a="36182070"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2025 16:15:21 +0800
IronPort-SDR: 678f4a04_oKypfGbFm0Iovf4fT5bWjPPduYFtdkldL28u9D7iawBNsfB
 4LaBBZOPJ6B5jRPujZeU/1W6hi8D0jS8IA4sggw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jan 2025 23:17:24 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Jan 2025 00:15:20 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH for-next v4 2/5] null_blk: introduce badblocks_once parameter
Date: Tue, 21 Jan 2025 17:15:14 +0900
Message-ID: <20250121081517.1212575-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250121081517.1212575-1-shinichiro.kawasaki@wdc.com>
References: <20250121081517.1212575-1-shinichiro.kawasaki@wdc.com>
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

