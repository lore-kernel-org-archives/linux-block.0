Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E1187FEC
	for <linux-block@vger.kernel.org>; Tue, 21 Jan 2025 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737447330; cv=none; b=dyx8XKBbqDWveHhXVf1+tUOHwZe4o9rL9JSvZrXt3YADrA6i3JKiyE+b4wQ1Z+UdwAMt8O5ntfVdh489DvjEe4Ym4saqffVuqIaw6fa3Ms00lEvoK9AC9rbH7iYB0CE5jXfWnCNt3cGjeWmhZG9qXzsiqHi4hYZ8bE117p3yJlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737447330; c=relaxed/simple;
	bh=BJjNFYAZw7k5DHjdhIv0vo04Mcnk9r/teFd1WG73BFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YM+XCkSKHJ7zT+Ozz2SX2BDzCV+un0Q5am8MC6+oSS5Eym0ZOtVMc3Zm57vLhvwP66YSTYr07fEtgMmks4b+/yZWoKYwBIMtQn3AiBnubpQ2vGjcwpyerBxfebYUw+nqad3zyG52lpwlK3qEtFINxpX1rzMLd4ZTd4S5cWiuEn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ltgfg5X8; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ltgfg5X8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737447328; x=1768983328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BJjNFYAZw7k5DHjdhIv0vo04Mcnk9r/teFd1WG73BFg=;
  b=Ltgfg5X8n7x0mn20fHcxm/O6mN9Q7FrKA/gt/Xf9UOqJcy/hSZF1KS2f
   QOaB7zhmEebqTzN3IlSZfiKkmNQnkgEzMDmkdGm4hdugTj1Cs0H7TfGE9
   Os5ySUWLre804lFg3KZ8g/VVNceRRHFOzeh+ybnylslQ5AKnHaqZM1Hkv
   GfKMovd9gfxkJ0LAwa2IKZm4TLQlgfrkgMayTthwt1kFQEC9fBrNwUFq/
   MuQB2H3lR/VCgtW3bKsNnhhMh+V+vmJZ/WYaSR2mPHsMw3Jo6+HgCGMfb
   du+HM96fXeyI1Dx6JWurbE+JIp9NJopNTVn2ydyOWJfU8twnXT4Pey6YB
   w==;
X-CSE-ConnectionGUID: cpNWjkUJSO+zIO7ldddDIQ==
X-CSE-MsgGUID: f8mhoQq/TFK7gUK0ORj7Qg==
X-IronPort-AV: E=Sophos;i="6.13,221,1732550400"; 
   d="scan'208";a="36182073"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2025 16:15:22 +0800
IronPort-SDR: 678f4a05_x5xzCB47XmevnEwmHbOAck0XMXzc5jl+2oON+KKtyCVhgGx
 wVXLOe6f57G88CNNgNzK2hfez4RM/p9nrSWa6Ug==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jan 2025 23:17:25 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Jan 2025 00:15:21 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH for-next v4 3/5] null_blk: fix zone resource management for badblocks
Date: Tue, 21 Jan 2025 17:15:15 +0900
Message-ID: <20250121081517.1212575-4-shinichiro.kawasaki@wdc.com>
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

