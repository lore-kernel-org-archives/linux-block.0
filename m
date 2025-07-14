Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3D42571B3
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503920; cv=none; b=tUiWR5coOTte0KeIjPc4InTMWDYMSLckQvJNj87IcRIEVhR612ojX1te113ykJCQG+zik3eLot1FtCrGS/GBL4jtHsE/1zmZPzYAWlHCvmRomCfVF3V2WDLXF/+HLFMaPV4YW/EXxrsfnJn6EnFBlv856JqrOwD4HwFftrJgxOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503920; c=relaxed/simple;
	bh=muwY08qb4qJDdH+pi9WeSldxoC+wFo2mFwZhWQwmgbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXloUDYeacDo5os5eV4gC48fQMH/14LihUQgSplY86p2RbEeU8iN1rZzr75yb1EeRwbf/vzGFQRKAi1aZtj8nnjSuVUlvO5XefJ9feo8q86hueUb/tl2cLdnESjwQhloKWrCFx3eVHZsHvf6wzChrn1Vwc1f1X92uqtOfxDawYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jAImdRne; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jAImdRne"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752503918; x=1784039918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=muwY08qb4qJDdH+pi9WeSldxoC+wFo2mFwZhWQwmgbs=;
  b=jAImdRneMLtYIOl8blZi5Onf+rlgw2evalZy6MyyuSg2ruqR/2zDiq+C
   fARQk0fzm0sMB35N5WxiENl+BkxCTKVztleMsW9uY3qUvh2qqEeI4+ppl
   ClxO5lLKPG0BgfO0ULEGImFwSGTjR+IZ1geT4icm2uLjp5vGNpnvuvbSF
   t1q6noyEcA9DvTF2Y0sMVap6h3wE5Aj+7KSZamVFZSIzf0pNQgTRUQbPE
   Re+tEEKHGKayy+7WYJZgPyXcCsyLGMTrHLYQiqQ08Q4d9P9fdOPUcquF7
   Lg1IByzNI/HDEhm/rTDNvkrGLgSOl4YZst1DPimKNeaceGEUAYSGNBLhZ
   g==;
X-CSE-ConnectionGUID: csuRktM+TvmTkVvJ8IPflw==
X-CSE-MsgGUID: 7WLaTx8HTg6l0NQ3v4xWrQ==
X-IronPort-AV: E=Sophos;i="6.16,311,1744041600"; 
   d="scan'208";a="86591351"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2025 22:38:34 +0800
IronPort-SDR: 687507cb_mLRGY0WQ1JknQFBRjNhRAY6rSWH7WzZxp4JYeyUQqdfJ7EX
 tqPo96pUTYGl584gtQ5ZYMJuqH974yZi8c3Mlqg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jul 2025 06:36:11 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Jul 2025 07:38:32 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/5] block: split blk_zone_update_request_bio into two functions
Date: Mon, 14 Jul 2025 16:38:22 +0200
Message-Id: <20250714143825.3575-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250714143825.3575-1-johannes.thumshirn@wdc.com>
References: <20250714143825.3575-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_zone_update_request_bio() does two things. First it checks if the
request to be completed was written via ZONE APPEND and if yes it then
updates the sector to the one that the data was written to.

This is small enough to be an inline function. But upcoming changes adding
a tracepoint don't work if the function is inlined.

Split the function into two, the first is blk_req_bio_is_zone_append()
checking if the sector needs to be updated. This can still be an inline
function. The second is blk_zone_append_update_request_bio() doing the
sector update.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-mq.c    |  6 ++++--
 block/blk-zoned.c | 13 +++++++++++++
 block/blk.h       | 31 ++++++++++++++-----------------
 3 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4806b867e37d..755ea0335831 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -883,7 +883,8 @@ static void blk_complete_request(struct request *req)
 		/* Completion has already been traced */
 		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
 
-		blk_zone_update_request_bio(req, bio);
+		if (blk_req_bio_is_zone_append(req, bio))
+			blk_zone_append_update_request_bio(req, bio);
 
 		if (!is_flush)
 			bio_endio(bio);
@@ -982,7 +983,8 @@ bool blk_update_request(struct request *req, blk_status_t error,
 
 		/* Don't actually finish bio if it's part of flush sequence */
 		if (!bio->bi_iter.bi_size) {
-			blk_zone_update_request_bio(req, bio);
+			if (blk_req_bio_is_zone_append(req, bio))
+				blk_zone_append_update_request_bio(req, bio);
 			if (!is_flush)
 				bio_endio(bio);
 		}
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 351d659280e1..e79e0357d1f1 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1205,6 +1205,19 @@ static void disk_zone_wplug_unplug_bio(struct gendisk *disk,
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 }
 
+void blk_zone_append_update_request_bio(struct request *rq, struct bio *bio)
+{
+	/*
+	 * For zone append requests, the request sector indicates the location
+	 * at which the BIO data was written. Return this value to the BIO
+	 * issuer through the BIO iter sector.
+	 * For plugged zone writes, which include emulated zone append, we need
+	 * the original BIO sector so that blk_zone_write_plug_bio_endio() can
+	 * lookup the zone write plug.
+	 */
+	bio->bi_iter.bi_sector = rq->__sector;
+}
+
 void blk_zone_write_plug_bio_endio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
diff --git a/block/blk.h b/block/blk.h
index 37ec459fe656..b4c01774df98 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -467,23 +467,15 @@ static inline bool bio_zone_write_plugging(struct bio *bio)
 {
 	return bio_flagged(bio, BIO_ZONE_WRITE_PLUGGING);
 }
-void blk_zone_write_plug_bio_merged(struct bio *bio);
-void blk_zone_write_plug_init_request(struct request *rq);
-static inline void blk_zone_update_request_bio(struct request *rq,
-					       struct bio *bio)
+static inline bool blk_req_bio_is_zone_append(struct request *rq,
+					      struct bio *bio)
 {
-	/*
-	 * For zone append requests, the request sector indicates the location
-	 * at which the BIO data was written. Return this value to the BIO
-	 * issuer through the BIO iter sector.
-	 * For plugged zone writes, which include emulated zone append, we need
-	 * the original BIO sector so that blk_zone_write_plug_bio_endio() can
-	 * lookup the zone write plug.
-	 */
-	if (req_op(rq) == REQ_OP_ZONE_APPEND ||
-	    bio_flagged(bio, BIO_EMULATES_ZONE_APPEND))
-		bio->bi_iter.bi_sector = rq->__sector;
+	return req_op(rq) == REQ_OP_ZONE_APPEND ||
+	       bio_flagged(bio, BIO_EMULATES_ZONE_APPEND);
 }
+void blk_zone_write_plug_bio_merged(struct bio *bio);
+void blk_zone_write_plug_init_request(struct request *rq);
+void blk_zone_append_update_request_bio(struct request *rq, struct bio *bio);
 void blk_zone_write_plug_bio_endio(struct bio *bio);
 static inline void blk_zone_bio_endio(struct bio *bio)
 {
@@ -516,14 +508,19 @@ static inline bool bio_zone_write_plugging(struct bio *bio)
 {
 	return false;
 }
+static inline bool blk_req_bio_is_zone_append(struct request *req,
+					      struct bio *bio)
+{
+	return false;
+}
 static inline void blk_zone_write_plug_bio_merged(struct bio *bio)
 {
 }
 static inline void blk_zone_write_plug_init_request(struct request *rq)
 {
 }
-static inline void blk_zone_update_request_bio(struct request *rq,
-					       struct bio *bio)
+static inline void blk_zone_append_update_request_bio(struct request *rq,
+						      struct bio *bio)
 {
 }
 static inline void blk_zone_bio_endio(struct bio *bio)
-- 
2.50.0

