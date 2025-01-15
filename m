Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E584922E40A
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 04:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736915357; cv=none; b=fNo5R4VA0v9dnvCGdcK8jJb7ovmK0RZtkRQd0CwKAfC5WWIjXnw5s3y/YBRSCvJ/XMdNmFUZn6TpDJzQsOF5o4CqcJ1EOIYl+VXscczn6/P0fw84SqiGGF7g7qopYi9iMWPZ2GN1B/wNLCLhQOiInOkM31xxwKXFjrBp9pFBxzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736915357; c=relaxed/simple;
	bh=BJjNFYAZw7k5DHjdhIv0vo04Mcnk9r/teFd1WG73BFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFXqaS3yv4rpGQK4XYnrspU1mO1N63fmp0Gmh+AQvtv4m8q5C3ayyn02XNyQNtuf6S3yCADDbg0A6S5FN3A43KaaVYzU5IgiRy4cdfg/UoBM72KqVrkkmT9VezfYRS3xIv2l36SzONk3cIXcN/ouUB+X50RM1mrWdN6SSUCQtJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LZZ04W+C; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LZZ04W+C"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736915356; x=1768451356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BJjNFYAZw7k5DHjdhIv0vo04Mcnk9r/teFd1WG73BFg=;
  b=LZZ04W+CgxEQEHTnbd5Wj0BgfIaOgLAcQgasOr7jfmxB46SzNn1Jtp4y
   taKIQ3pevGrMLkeSS+bZF/DJrWuF4VMFunGcjgLunU4t/iXG95zrrPdQh
   bsGbItf76TNIQEbC0RMXkQGYM1Io4ei3OUwHKnde+aQcF3v+DV25unUXw
   6+KeEqPXx7UDC6tEFbuZaH0OOXhUbHOFGcTRxB82Kp60BOqjiQlv4CbMj
   KHN5h8mq1bKQ1Sim+Gu5Jl8waeYbhzDmbYJOaQqDcuWKlZRsyC8cCDv6y
   h/aZj3W9OjzVeyGg5vC3QSThoLyrQ5NVCIbdPw+T8L9QsYRaAfGTWI5ql
   Q==;
X-CSE-ConnectionGUID: C11NvTncQNuacc0yI3aoUg==
X-CSE-MsgGUID: giI9RGLHSR+eIA4edLypww==
X-IronPort-AV: E=Sophos;i="6.12,316,1728921600"; 
   d="scan'208";a="35958015"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2025 12:29:16 +0800
IronPort-SDR: 67872ac3_tE6snDHfTz3sZwtJ1rfMSNt/6ItsDKWEn+F3bWB01MSfX9L
 knmbOis4ivjZ+gxVM/yvyB+b3XJNG189TzGj3GQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jan 2025 19:25:55 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Jan 2025 20:29:14 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH for-next v3 3/5] null_blk: fix zone resource management for badblocks
Date: Wed, 15 Jan 2025 13:29:08 +0900
Message-ID: <20250115042910.1149966-4-shinichiro.kawasaki@wdc.com>
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

When the badblocks parameter is set for zoned null_blk, zone resource
management does not work correctly. This issue arises because
null_zone_write() modifies the zone resource status and then call
null_process_cmd(), which handles the badblocks parameter. When
badblocks cause IO failures and no IO happens, the zone resource status
should not change. However, it has already changed.

To fix the unexpected change in zone resource status, when writes are
requested for sequential write required zones, handle badblocks not in
null_process_cmd() but in null_zone_write(). Modify null_zone_write() to
call null_handle_badblocks() before changing the zone resource status.
Also, call null_handle_memory_backed() instead of null_process_cmd().

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
index 0d5f9bf95229..09dae8d018aa 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -389,6 +389,12 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		goto unlock_zone;
 	}
 
+	if (dev->badblocks.shift != -1) {
+		ret = null_handle_badblocks(cmd, sector, nr_sectors);
+		if (ret != BLK_STS_OK)
+			goto unlock_zone;
+	}
+
 	if (zone->cond == BLK_ZONE_COND_CLOSED ||
 	    zone->cond == BLK_ZONE_COND_EMPTY) {
 		if (dev->need_zone_res_mgmt) {
@@ -412,9 +418,12 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		zone->cond = BLK_ZONE_COND_IMP_OPEN;
 	}
 
-	ret = null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
-	if (ret != BLK_STS_OK)
-		goto unlock_zone;
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

