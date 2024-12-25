Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B405118A950
	for <linux-block@vger.kernel.org>; Wed, 25 Dec 2024 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735121402; cv=none; b=WTq5bgYbEqL/ihUiq8SH2SELV9UEmwD3KyN94ToAGcj9MQWtBeybR/MvtpPS53HRh6ldds4djy+W7b29nEdQO6aOj1qj2AN+1Yal+fmh501/4azvYHjhv0bf0uL1HF7yEgFlfv3qogKnfFXgldiN1T8galnAJUK0b/DB6llSxhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735121402; c=relaxed/simple;
	bh=3uWnWJ8f1VMdw9xEZlLwVcZZxvJJEqP244ybmgiDSRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQIrX9I0leRXiBvAdMX6JGA6caSRnke5AMMPbkg8GXVpp1Ip2aMHc4ioAgDFrhCxDdt/TwwVGCbP6Rbr8qqSqfOnlM05Dr0PJNhzo7SrD1vV9LH9smxq5TqpdV9aG72l1/CrO8qZYs0WMxRcsQCjWzjuJximaOkI5V1Sa3ddRTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=errF6grs; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="errF6grs"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1735121400; x=1766657400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3uWnWJ8f1VMdw9xEZlLwVcZZxvJJEqP244ybmgiDSRU=;
  b=errF6grsTioOg3q6FkKWO11orq6q7fAz5Jw8xio2NlzX9W+gZ0AZFaat
   451r8Vdy6I8eiOX87Uumap/9Z4e7YBCyWK0JATUvbC+08y9AmUCIKlIHl
   YVR5JivCbTqXbNJNcuRgPCwy+8wKErsqe+gesikSnb2VuUjdiXM7rA/QL
   ToK6QVugMtlOUOUQVFQeCx9PxboqQ9I6XK5SbptJeXOO1BW5TywQes/Wv
   zUQ+5pDJk3ffk63hiUTUKyrX2dlVsrFFDgbP5vt6L7OIGoaUVUXMFsdUP
   tQ6HWWMkcHgDqsOpBj9SAiztFepBrq/zrT6cNhFwYkKiD/YJRD4IShoxS
   A==;
X-CSE-ConnectionGUID: EsZMeWd/QZObDBMJczyJjA==
X-CSE-MsgGUID: 4d7e5U6oTu+5WQPk56td8Q==
X-IronPort-AV: E=Sophos;i="6.12,263,1728921600"; 
   d="scan'208";a="35812598"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Dec 2024 18:09:53 +0800
IronPort-SDR: 676bcc7d_urqbSFw/nBoMJ8ZvzrIaKifCO6BhrVpd45L1aBq0y3k54kV
 99CDSJpGx3aSObo+xgVlJDwRZUy3PG5ZGOIVqfw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Dec 2024 01:12:30 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Dec 2024 02:09:52 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH for-next v2 3/4] null_blk: move write pointers for partial writes
Date: Wed, 25 Dec 2024 19:09:48 +0900
Message-ID: <20241225100949.930897-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241225100949.930897-1-shinichiro.kawasaki@wdc.com>
References: <20241225100949.930897-1-shinichiro.kawasaki@wdc.com>
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
index d155eb040077..1675dec0b0e6 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1330,6 +1330,7 @@ static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
 }
 
 static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
+						 enum req_op op,
 						 sector_t sector,
 						 sector_t nr_sectors)
 {
@@ -1347,6 +1348,8 @@ static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
 			transfer_bytes = (first_bad - sector) << SECTOR_SHIFT;
 			__null_handle_rq(cmd, transfer_bytes);
 		}
+		if (dev->zoned && op == REQ_OP_WRITE)
+			null_move_zone_wp(dev, sector, first_bad - sector);
 		return BLK_STS_IOERR;
 	}
 
@@ -1413,7 +1416,7 @@ blk_status_t null_process_cmd(struct nullb_cmd *cmd, enum req_op op,
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

