Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D201DE4EA
	for <linux-block@vger.kernel.org>; Sat, 25 Jan 2025 01:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768556; cv=none; b=pUFN5veTvj4IgeZFNvFShaW36TAXAQwwCNm95B6MkbcIuIE3Nri4Afam09SN5v7/5iLqnZfwKsKcAUJ3qa0U6kJlJIY6OyO+GNpgeCugBbJZH6TICLHI9yDA3Rny5k7aMBygy4v+3IUWtXOBHB65RUMDM7n1s6Xol4IzF6rnueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768556; c=relaxed/simple;
	bh=8Pdt1tvIrVsMimgcN/uIRrJNkh8c0fD9AG3fRrXntgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmwvXzfWupb9hUqnAHANvWX6/rh/ARI8RrTDD+mzGxCslKtcnVyKmLAJDjTWd8MNgelzG4CtQ0ogdgjmkf5+teuLNo+pgR4gBEECnl25UyQ9EcLTXBshYHnXB5WzG2I7Ca5cDmbvKrupkTlyLdfAf1F4ptuWyKiIEf/Jjyqh9yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gb4duPT3; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gb4duPT3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737768553; x=1769304553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Pdt1tvIrVsMimgcN/uIRrJNkh8c0fD9AG3fRrXntgY=;
  b=gb4duPT3u/Zy1x9sCz45qAsI2HyWiZ6WJNbXte7MHvIF4oTc4SegfL2o
   NfAnJdWT1RMIlvMSlqcMk26nHBmI+5OpASQ3RXolchYd3ydFp/QrQWna/
   +ksXhJhHivMH3/0sn1LJEczi+rs9K06TnobOTeS5CQ3Wg6Lxb8YMEsR4t
   YJH23+8UQ4LH6g0MSUF/de3hX3ALu7gErqWWjczLSj25d4rHnQxQwer/+
   QLcct0BwFdGERUB6wPbbUdMsjyw+CdHYBRI6AIoJvOJbwLxJSC0vaNdNn
   eVppi8eHu4AXH//+v17/uQBd4e84lDQVyEoFVJbMeylpUY5W6QPLidDkr
   A==;
X-CSE-ConnectionGUID: fcrWzTVNTMSDIFBoh8IQ0A==
X-CSE-MsgGUID: 1b+klE8jT8aBsl4N2i4JUQ==
X-IronPort-AV: E=Sophos;i="6.13,232,1732550400"; 
   d="scan'208";a="37973937"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2025 09:29:12 +0800
IronPort-SDR: 679430ce_vP3c4PU4sEN6i1z7lgJf054vCv0xk5KmDoKTFgjmyr10vXH
 +icp6ykjTNtLgwMn/fhiouuGM8RsL8erUClP9gw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2025 16:31:11 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Jan 2025 17:29:12 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v5 3/5] null_blk: replace null_process_cmd() call in null_zone_write()
Date: Sat, 25 Jan 2025 10:29:06 +0900
Message-ID: <20250125012908.1259887-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250125012908.1259887-1-shinichiro.kawasaki@wdc.com>
References: <20250125012908.1259887-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a preparation to support partial data transfer by badblocks, replace
the null_process_cmd() call in null_zone_write() with equivalent calls
to null_handle_badblocks() and null_handle_memory_backed(). This commit
does not change behavior. It enables null_handle_badblocks() to return
the size of partial data transfer in the following commit, allowing
null_zone_write() to move write pointers appropriately.

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

