Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783B7156F44
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734508166; cv=none; b=F3Kj2mCCr20w+5+gllpspPJhp7k2v5YqlAw1Fi+YO7Gbz01ZAgvQXDYmQYR7cbGCLpr7vjEr5wc5ZyIkc8cwRpz+Al21TZugcFQ+xkvcMGnQRe1o0dWIR0kFSDfQS/jxrWwZFW9OSCjB/1JuG7xgjr61Iq2LQe82vu9W1uoKib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734508166; c=relaxed/simple;
	bh=3KB3H4DfwDXO8hdAQQG+UYF9+AbD1zJdISjf4AjmmHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPKZNaMGSaFPgYxBeIwsAPGx+cq5AQW1UmlK27UGg3iHK2e/HruF01Bf12X9H3GWQQET8jVH65wmX/wFiK7SmVtmGwkRwiLmv4A3b1gMHXu75k7Zt0CmREtK50+RJZBB/Cesfk+BKsjjxn3e324rFj3TFBBsf/FCUzTS7VDTnFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EG4roO8+; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EG4roO8+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734508164; x=1766044164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3KB3H4DfwDXO8hdAQQG+UYF9+AbD1zJdISjf4AjmmHw=;
  b=EG4roO8+DCEmOF/JGuq9gvvXb9cUnSxuRt1N9zOTajLd2NCfrQX4ZoO8
   U/xLo+DIfozsDGjMaFnZZTLFn5Rz4pBOdLyLs/OcHiJkcktW7+7gjBMWJ
   14PCplEh2R1XNcUIeVJdm3wLV4ZAc3SMjPcGtDizkV1I5iHyb11heRMEY
   i65qXsMSC7jEh4QhNrX1SXDaMItrcC6YWjuj6G16U2qoJ8TVNvpRGN5ZW
   F5VCb7n0dwyM/PeEc1NkXqJWSBJymQGukx7HyQksSTTMn/wxskMOp9uvE
   0AwE+swWlsen4J+dv64T2zwhUdpuc48YxvsBdSP88MW01EUGXYLq0nISS
   A==;
X-CSE-ConnectionGUID: tKyrRf+qS16ci++XI3OcVA==
X-CSE-MsgGUID: /7ZaP3QUTliYKrWy0c5+0Q==
X-IronPort-AV: E=Sophos;i="6.12,244,1728921600"; 
   d="scan'208";a="35269664"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2024 15:49:16 +0800
IronPort-SDR: 67626fc7_gTxOnrVn4vkX1GiktErsMRYTg8jhGBxTa+z5N/YUjU0fGZg
 ZOII68e4mw8b2ypNRggvRNt/DvIWLVMsKPdWvjw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2024 22:46:32 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Dec 2024 23:49:17 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH for-next 2/3] null_blk: move write pointers for partial writes
Date: Wed, 18 Dec 2024 16:49:13 +0900
Message-ID: <20241218074914.814913-3-shinichiro.kawasaki@wdc.com>
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

The previous commit modified bad blocks handling to do the partial IOs.
When such partial IOs happen for zoned null_blk devices, it is expected
that the write pointers also move partially. To test and debug partial
write by userland tools for zoned block devices, move write pointers
partially.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/block/null_blk/main.c     |  5 ++++-
 drivers/block/null_blk/null_blk.h |  6 ++++++
 drivers/block/null_blk/zoned.c    | 10 ++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 018a1a54dfa1..0f02e763cd9e 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1315,6 +1315,7 @@ static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
 }
 
 static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
+						 enum req_op op,
 						 sector_t sector,
 						 sector_t nr_sectors)
 {
@@ -1332,6 +1333,8 @@ static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
 			transfer_bytes = (first_bad - sector) << SECTOR_SHIFT;
 			__null_handle_rq(cmd, transfer_bytes);
 		}
+		if (dev->zoned && op == REQ_OP_WRITE)
+			null_move_zone_wp(dev, sector, first_bad - sector);
 		return BLK_STS_IOERR;
 	}
 
@@ -1398,7 +1401,7 @@ blk_status_t null_process_cmd(struct nullb_cmd *cmd, enum req_op op,
 	blk_status_t ret;
 
 	if (dev->badblocks.shift != -1) {
-		ret = null_handle_badblocks(cmd, sector, nr_sectors);
+		ret = null_handle_badblocks(cmd, op, sector, nr_sectors);
 		if (ret != BLK_STS_OK)
 			return ret;
 	}
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 6f9fe6171087..c6ceede691ba 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -144,6 +144,8 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
 				sector_t sector, unsigned int len);
 ssize_t zone_cond_store(struct nullb_device *dev, const char *page,
 			size_t count, enum blk_zone_cond cond);
+void null_move_zone_wp(struct nullb_device *dev, sector_t zone_sector,
+		       sector_t nr_sectors);
 #else
 static inline int null_init_zoned_dev(struct nullb_device *dev,
 		struct queue_limits *lim)
@@ -173,6 +175,10 @@ static inline ssize_t zone_cond_store(struct nullb_device *dev,
 {
 	return -EOPNOTSUPP;
 }
+static inline void null_move_zone_wp(struct nullb_device *dev,
+				     sector_t zone_sector, sector_t nr_sectors)
+{
+}
 #define null_report_zones	NULL
 #endif /* CONFIG_BLK_DEV_ZONED */
 #endif /* __NULL_BLK_H */
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 0d5f9bf95229..e2b8396aa318 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -347,6 +347,16 @@ static blk_status_t null_check_zone_resources(struct nullb_device *dev,
 	}
 }
 
+void null_move_zone_wp(struct nullb_device *dev, sector_t zone_sector,
+		       sector_t nr_sectors)
+{
+	unsigned int zno = null_zone_no(dev, zone_sector);
+	struct nullb_zone *zone = &dev->zones[zno];
+
+	if (zone->type != BLK_ZONE_TYPE_CONVENTIONAL)
+		zone->wp += nr_sectors;
+}
+
 static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 				    unsigned int nr_sectors, bool append)
 {
-- 
2.47.0

