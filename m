Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97FB1AF0D7
	for <linux-block@vger.kernel.org>; Thu, 30 Jan 2025 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738225636; cv=none; b=lG7WnSlGTHnMk7o1PSz8zYpYD/8pGTdaQAvNLp3RcWox9yZCtB/AicddvilV+L1tuGMkVVElr5cn8TpUNVELlRRkMec57wQ6fwzg9l9Lkv3KB93ghMhh9ELi02/6nPDxDCb8FJ/4F0G98wl9NcyyV4Y2REd73iDys8Vy3gMRqzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738225636; c=relaxed/simple;
	bh=zhe0pdwzf2uOiD5VesC6f1bzIygt0zrPPVitBcmWA7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9JveRcTZMmQkCdGA+oMWJhWFs33JjudIqS3IPNIiRHAdxDqrQ8JSmmSm1f5AEqtnxptCO2QXUq7FMVsfSgkFmWWnPnrs8xn/WVN2AU5GiixHUz/X8ELOZvC0WFcItQ/pywt73rb3LHa9BmR0MRsi+mY4zX1czLK1kHRZm6C0Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Yq9cvY4n; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yq9cvY4n"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738225634; x=1769761634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zhe0pdwzf2uOiD5VesC6f1bzIygt0zrPPVitBcmWA7s=;
  b=Yq9cvY4nNPKieJxwn1cwbQfan5yHDDpYTYLnshKasmCxYwTYdUMxaxSy
   /XBWCWxOAEfYFDNAstz2zBOrWx71HJNgi4r36XPMCKSDXnWDRJEJ5j7zI
   ttdCKvCqC3xi9l6mfvyHnlmjTPws+vcJt3Qt7euQQ8xc6kOt2HpJCekzW
   HBiPUtulWpD113qndxsaY/VGB2He4f3SoWarhgxKOSGaQ9C0mA2lRdABK
   Zv1qpK8GQSjCmDCPcn+9HnuEG+Ns9xTUhzaSaDxVmJoWP18MMDum+ixt1
   ZUnLY3Zcr54YY7VkdfZ8beyOPbhHhe4TXMoOkGfNDJSw8/0QUUEv6Lefn
   Q==;
X-CSE-ConnectionGUID: EW8D5KfZT261RMNzE1i/6g==
X-CSE-MsgGUID: Wdqfh3tXSX6Esfz0Qc52rQ==
X-IronPort-AV: E=Sophos;i="6.13,244,1732550400"; 
   d="scan'208";a="38377847"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2025 16:27:09 +0800
IronPort-SDR: 679b2a3c_07sPj6BuG9JRRATL5UMyH/nur6F4LoXRe4O5NI5jlIekWpW
 qqVkmGGnKzwwbqXuU5D6gOmQIG+FOi8J82oeH2Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2025 23:29:00 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jan 2025 00:27:09 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v6 3/5] null_blk: replace null_process_cmd() call in null_zone_write()
Date: Thu, 30 Jan 2025 17:27:01 +0900
Message-ID: <20250130082703.1330857-4-shinichiro.kawasaki@wdc.com>
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

As a preparation to support partial data transfer due to badblocks,
replace the null_process_cmd() call in null_zone_write() with equivalent
calls to null_handle_badblocks() and null_handle_memory_backed(). This
commit does not change behavior. It will enable null_handle_badblocks()
to return the size of partial data transfer in the following commit,
allowing null_zone_write() to move write pointers appropriately.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/block/null_blk/main.c     | 11 ++++-------
 drivers/block/null_blk/null_blk.h |  5 +++++
 drivers/block/null_blk/zoned.c    | 15 ++++++++++++---
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 2a060a6ea8c0..87037cb375c9 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1309,9 +1309,8 @@ static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
 	return sts;
 }
 
-static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
-						 sector_t sector,
-						 sector_t nr_sectors)
+blk_status_t null_handle_badblocks(struct nullb_cmd *cmd, sector_t sector,
+				   sector_t nr_sectors)
 {
 	struct badblocks *bb = &cmd->nq->dev->badblocks;
 	sector_t first_bad;
@@ -1326,10 +1325,8 @@ static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
 	return BLK_STS_IOERR;
 }
 
-static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
-						     enum req_op op,
-						     sector_t sector,
-						     sector_t nr_sectors)
+blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd, enum req_op op,
+				       sector_t sector, sector_t nr_sectors)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 3c4c07f0418b..ee60f3a88796 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -132,6 +132,11 @@ blk_status_t null_handle_discard(struct nullb_device *dev, sector_t sector,
 				 sector_t nr_sectors);
 blk_status_t null_process_cmd(struct nullb_cmd *cmd, enum req_op op,
 			      sector_t sector, unsigned int nr_sectors);
+blk_status_t null_handle_badblocks(struct nullb_cmd *cmd, sector_t sector,
+				   sector_t nr_sectors);
+blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd, enum req_op op,
+				       sector_t sector, sector_t nr_sectors);
+
 
 #ifdef CONFIG_BLK_DEV_ZONED
 int null_init_zoned_dev(struct nullb_device *dev, struct queue_limits *lim);
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 0d5f9bf95229..7677f6cf23f4 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -412,9 +412,18 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		zone->cond = BLK_ZONE_COND_IMP_OPEN;
 	}
 
-	ret = null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
-	if (ret != BLK_STS_OK)
-		goto unlock_zone;
+	if (dev->badblocks.shift != -1) {
+		ret = null_handle_badblocks(cmd, sector, nr_sectors);
+		if (ret != BLK_STS_OK)
+			goto unlock_zone;
+	}
+
+	if (dev->memory_backed) {
+		ret = null_handle_memory_backed(cmd, REQ_OP_WRITE, sector,
+						nr_sectors);
+		if (ret != BLK_STS_OK)
+			goto unlock_zone;
+	}
 
 	zone->wp += nr_sectors;
 	if (zone->wp == zone->start + zone->capacity) {
-- 
2.47.0

