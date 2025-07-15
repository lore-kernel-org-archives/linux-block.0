Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16252DA759
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580422; cv=none; b=RWE5CZNBV8YEPHf4OKyZ3DA4bV6qsN5wziTdlmMmJuHtCB1OqxA6N6ds/LNntxPAAXnX6AkqhxoGlOr5eWl+U261OrS4tIqoD8meFjR+l8gzd6c/nq2nlrlFNVewtpq24tM5B90WKSHEmyMjIG15VOlQ5nhYSXba5XPCrMKfvvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580422; c=relaxed/simple;
	bh=qWjoRZAV23f6CICUc6FULAwkOGBJH6VSrQd8Tj73Rs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gw2sGktUXJVxndjHODG3dxNUPofgg5DUUUtel7z1eofVcoQr7GCPYOL3Hc8GUQgw/3g3h6bAj6cepxeYcDSa5UkaoBFnaPluLD4XyWLKsTbJJAItlSuWIvXIIHLKkRL2+wPDPf1B10R37JNf+fxncMkSmDzCtCMlfUhJU+gjDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=btEch3mz; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="btEch3mz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752580420; x=1784116420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qWjoRZAV23f6CICUc6FULAwkOGBJH6VSrQd8Tj73Rs8=;
  b=btEch3mzRxhtKmKfuSzmXVuZlZLwcW+6lEP/dybiOVw3SKlxmyG7valE
   wLc/+Ip4yZkkQkY3cMtH91LLE6u/zGGBsy3DuFnDiK9bpi/AU3yymiVZ+
   sCniNg1n7W3GVpOFYo/h4rCOa9A1KSzZZdlMIVtuD20tHZz51f07/CcMv
   MGLEkYqG0oe+BAqmSlOBpjwaJv9xCBMPSapHQRfIqevR6XCuBSzv5Ap9m
   fnNJHZrIKehp2iBPPcThwrGVTe/cpKkgMjDcTav/SavWw/zbb4vnIWOfh
   wKnuR1c+/0ej8v7m5HzT3UZ3bnf4J3h05mSbBwTPqTgitUbKKvm1clRSL
   w==;
X-CSE-ConnectionGUID: kZ1pPsCARiu3fxrPagmaRQ==
X-CSE-MsgGUID: IiCe9vEoT9GrhW1nUlXt4w==
X-IronPort-AV: E=Sophos;i="6.16,313,1744041600"; 
   d="scan'208";a="87768587"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2025 19:53:40 +0800
IronPort-SDR: 687632a4_0/tG7Bq5vqiwxOwP8PMLT1lUh7/Etfw+v9xsUX89u735qlr
 nqLP1A6qaOBEnhnIjhmVNAmqpJvYhAJZQQe7IAw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2025 03:51:16 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jul 2025 04:53:39 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-block@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v3 2/5] block: split blk_zone_update_request_bio into two functions
Date: Tue, 15 Jul 2025 13:53:21 +0200
Message-Id: <20250715115324.53308-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250715115324.53308-1-johannes.thumshirn@wdc.com>
References: <20250715115324.53308-1-johannes.thumshirn@wdc.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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

