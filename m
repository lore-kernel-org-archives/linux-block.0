Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2142DA743
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061641; cv=none; b=bYgY9uNsqUHUW7QzqTbf2BaEpe/ikSyilTOo9nn/1+z/Wp0ld1lplpbnmay9SlX4PseRLB/3SOXVjs7fWNO8PpcdRHBIHQ/dos+M7+NQj/h3IUGSxIWdlNtmU3WIAw8prB6j5xMdk6RcpiUO5JoBs1zEss+pQhlVre9JL1kVSqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061641; c=relaxed/simple;
	bh=DWzPVOMzLMlbi4RkPwdGEw5gPk0/aVm/5/80ALyA6LQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rnLSQrcMKoGo8/cLyO6HFNa8i7jH+A5Kfme/DeDXw42E9nj+1wTSrvNwoy+CRNITTvTkz7jE73DoWvJiDRp+IWt2TWVF3f6vIk/PT0/ffq4oHojaJ1LZLG7Cvn1bAQptSWgTJBazIxy16sdGuL3Q9E0wahLSer7qBCE/GPhQrps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fhcc4e3c; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fhcc4e3c"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752061639; x=1783597639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DWzPVOMzLMlbi4RkPwdGEw5gPk0/aVm/5/80ALyA6LQ=;
  b=fhcc4e3cvzv5jYXWZ1hJV5Tta1XZ8++lYFzxXYdujfKZCZWO6VznSDab
   mFwHfgNAQmukFxy7tGwfDo93/LuDNYpOA+ZQ4FFqsz2zhpMvtC8zQlXDY
   GT52Jjfh/vfd/ohP/urSJBf5/jyYX1pWmumAdmkLvRRPUhmPUChIIIrBm
   8PLPFGr51MDk55MkKQ+6jgqNzKBtB3vbdOaMEv1zIeG9nNzxuC3a6XxD0
   69rmhDp5VMuBE/D6Qjkzdk4doSb7icJ8qfFeMZmA99EWFRMuNQdlzRWQt
   4zcQu5Kte8gZ32+R+pLxXBmB56rWo1a0Nmwt6tM0nCMWzSRC4JxQRGTVN
   Q==;
X-CSE-ConnectionGUID: eUowr6G1Sc6s4bTvKFsbBQ==
X-CSE-MsgGUID: c7iMXVq3RqWI+BQWYFr5Uw==
X-IronPort-AV: E=Sophos;i="6.16,298,1744041600"; 
   d="scan'208";a="91096345"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2025 19:47:15 +0800
IronPort-SDR: 686e482d_vJ55MtwJk8mb7T0Ak8dtG5ZdSRPwncBIQ8tYdNm53yA2Z7K
 Ht9p106a5VZOl1TVJ7DzUP7FUGkGGeGwsqQbK8Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2025 03:45:01 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Jul 2025 04:47:14 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/5] block: split blk_zone_update_request_bio into two functions
Date: Wed,  9 Jul 2025 13:47:01 +0200
Message-Id: <20250709114704.70831-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
References: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
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

