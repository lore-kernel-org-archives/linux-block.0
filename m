Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4B25103F
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580429; cv=none; b=twcoi3PSsgwtOjqSFg+JXvauZ90hEGnZCmNQ7LlKJK/K4EgN7oA2uLBmBdxevqzsa6rgEAl8tN9onaqimVAOnWWvRdJz6nolZDkS2pIuSjuCeMOSBSeoBMy7677hKOXUTu5WD7v+Z9IhauilKVXsgoCz9jnPRzXz8pU5b2IS8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580429; c=relaxed/simple;
	bh=cBH9UFmgKVC85uSfEjHvYPVgaUaRygjmLW3nRLI8Lx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h1mHqPY66e4DeAtvHFxZwrKpyhSAsE+anyYk3CecQU1M8EEMW6b6jtKge3DY+jAESuBsmiMpLfLD90nAFJG1+j0yhne19xy0MpxTvaBJ7RCVUeg68U4ZXR9VwQebZKLh4shzZk2pNYYZsYjxIQRsOPWWhJ68YjB35hdSRYdvFVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=R0EVI8Z9; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R0EVI8Z9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752580428; x=1784116428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cBH9UFmgKVC85uSfEjHvYPVgaUaRygjmLW3nRLI8Lx0=;
  b=R0EVI8Z9uvb4cvxtCQf2y0H/uZfuPbWxj/Zst0kJx8FWAFdU8NG0zskf
   UGgq8BVO+wg3RA8GzJDhRhm2WE7hOFacDvcb4TTEKvNV8x6KuFav+0++t
   zSXKicohEocQK0VP0Vg5zOol6nxbo9fgTLzTcC3wF2DUN0BDX7chRaLdK
   K2Bx9dXAs9S/3g6BE6x2UjsR4oJEdIT1mhjCMNjxGKyRg3AS9F6h9tBX7
   RH+Ms4HoyGywhJxmkEVvsTVoRiiBTr/mP9IgB1njW3XEB7M3OntfoqFeh
   dUhdA0E5wt5oPylFmaN/n81e/aJNKzj9jeyGhzxpdGr/r8LkEbl2SCepc
   g==;
X-CSE-ConnectionGUID: kz14kptYSZy6sJVwrhvg2w==
X-CSE-MsgGUID: Hk/AsdlzS5mWRXJu/hCDuA==
X-IronPort-AV: E=Sophos;i="6.16,313,1744041600"; 
   d="scan'208";a="87768626"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2025 19:53:47 +0800
IronPort-SDR: 687632ab_jw3Oj7/ZFAyYAC9EXRFcc8o8YvI3bGgcxyjGzokNcrbhfPD
 MsICa5TgDvQuBI8BYKYaNrKQl+IfFahhBCt2wJA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2025 03:51:23 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jul 2025 04:53:46 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-block@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v3 5/5] block: add trace messages to zone write plugging
Date: Tue, 15 Jul 2025 13:53:24 +0200
Message-Id: <20250715115324.53308-6-johannes.thumshirn@wdc.com>
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

Add tracepoints to zone write plugging plug and unplug events.

Examples for these events are:

  kworker/u10:4-393  [001] d..1. 282.991660: disk_zone_wplug_add_bio: 8,0 zone 16, BIO 8388608 + 128
  kworker/0:1H-58    [ [000] d..1. 283.083294: blk_zone_wplug_bio: 8,0 zone 15, BIO 7864320 + 128

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c            |  5 ++++
 include/trace/events/block.h | 44 ++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 48f75f58d05e..5c409c118135 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -822,6 +822,8 @@ static inline void disk_zone_wplug_add_bio(struct gendisk *disk,
 	 * at the tail of the list to preserve the sequential write order.
 	 */
 	bio_list_add(&zwplug->bio_list, bio);
+	trace_disk_zone_wplug_add_bio(zwplug->disk->queue, zwplug->zone_no,
+				      bio->bi_iter.bi_sector, bio_sectors(bio));
 
 	zwplug->flags |= BLK_ZONE_WPLUG_PLUGGED;
 
@@ -1317,6 +1319,9 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
 		goto put_zwplug;
 	}
 
+	trace_blk_zone_wplug_bio(zwplug->disk->queue, zwplug->zone_no,
+				 bio->bi_iter.bi_sector, bio_sectors(bio));
+
 	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
 		blk_zone_wplug_bio_io_error(zwplug, bio);
 		goto again;
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index ff7698efdfde..3e582d5e3a57 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -633,6 +633,50 @@ TRACE_EVENT(blkdev_zone_mgmt,
 		  (unsigned long long)__entry->sector,
 		  __entry->nr_sectors)
 );
+
+DECLARE_EVENT_CLASS(block_zwplug,
+
+	TP_PROTO(struct request_queue *q, unsigned int zno, sector_t sector,
+		 unsigned int nr_sectors),
+
+	TP_ARGS(q, zno, sector, nr_sectors),
+
+	TP_STRUCT__entry(
+		__field( dev_t,		dev		)
+		__field( unsigned int,	zno		)
+		__field( sector_t,	sector		)
+		__field( unsigned int,	nr_sectors	)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= disk_devt(q->disk);
+		__entry->zno		= zno;
+		__entry->sector		= sector;
+		__entry->nr_sectors	= nr_sectors;
+	),
+
+	TP_printk("%d,%d zone %u, BIO %llu + %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->zno,
+		  (unsigned long long)__entry->sector,
+		  __entry->nr_sectors)
+);
+
+DEFINE_EVENT(block_zwplug, disk_zone_wplug_add_bio,
+
+	TP_PROTO(struct request_queue *q, unsigned int zno, sector_t sector,
+		 unsigned int nr_sectors),
+
+	TP_ARGS(q, zno, sector, nr_sectors)
+);
+
+DEFINE_EVENT(block_zwplug, blk_zone_wplug_bio,
+
+	TP_PROTO(struct request_queue *q, unsigned int zno, sector_t sector,
+		 unsigned int nr_sectors),
+
+	TP_ARGS(q, zno, sector, nr_sectors)
+);
+
 #endif /* _TRACE_BLOCK_H */
 
 /* This part must be outside protection */
-- 
2.50.0

