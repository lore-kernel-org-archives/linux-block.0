Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6B12DA765
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061644; cv=none; b=DqIWM5WWL1rJGSBK0FxSvipQar5oiC89M4wISWV4y4M1DB1zb6uqTfM5ruW31/r+n7LYp2qkTpnj89bo75JveK+ho5lKaaHquTqIxhHij42DatFKxz8z5nyRATyoo4iXQgWkRzDVmgIqJ1mU6E037ekS7MPOXsqdeB/tsUK0N5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061644; c=relaxed/simple;
	bh=3ZxBF+mJRdsMCmq2cUzpeAQpBa4aynD/O3CRM1S2nm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FAG+o9qnCBgnpVSr6/+4Uyy6LNQAFhIxBFEXnJBt2HVy4Z6tpDa9LxuZpERs42MNO/YFB4vpcEudEnkNfMkmp3L1fJ/w2vpj9fykWo2ctJhP2Ub61Q/pAgzJaI9sL1dNdUbH2pRlv6JnamwOILMk00MkBDR/UPnB3JSLH416qo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QcAU8ltr; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QcAU8ltr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752061642; x=1783597642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3ZxBF+mJRdsMCmq2cUzpeAQpBa4aynD/O3CRM1S2nm8=;
  b=QcAU8ltrMd8Zo0NUOuVyNUaYH/2oRTue3wOsD7G+oHRgI6yOZBKRbQcl
   asmQBoki+Ja0wL0F91AOUm9wVQgDupna2lPH2sj236bRpRlDvsFfiwV7v
   c8NmN3UQlzPS6jqDj0PhyzwvTWKtRzcblRL5+LF9qyw+287Bkdm0OjoFf
   pWYduHF9RagMdnLnnfNMsOvKLgz4dDSGjiO8/jD58gj0Eq191aRXhbOfQ
   3o1zuYDlm9LmKC24kLhU4K4P1eerb1qf80cvbP4wdIVmlYYkS/8/yQmtd
   pTZP3KNopItDlGpEhuiXgyfQHquFDLE13os5hfahxTrRfljBRgh0XEogh
   g==;
X-CSE-ConnectionGUID: DfFfkm9fQqW3xxgCZPuWqg==
X-CSE-MsgGUID: s4giFf+jTCGclSIaX3K7Jw==
X-IronPort-AV: E=Sophos;i="6.16,298,1744041600"; 
   d="scan'208";a="91096361"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2025 19:47:22 +0800
IronPort-SDR: 686e4834_8P14r9A5rWkLltl0/lnbCck7kEHdJxd2el9x66D48AzjYU8
 vrbg+PnLdqKbVbUVH2yWUgY+ThZcedN549kU4lA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2025 03:45:08 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Jul 2025 04:47:21 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 5/5] block: add trace messages to zone write plugging
Date: Wed,  9 Jul 2025 13:47:04 +0200
Message-Id: <20250709114704.70831-6-johannes.thumshirn@wdc.com>
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

Add tracepoints to zone write plugging plug and unplug events.

  kworker/u9:3-162  [000] d..1. 2231.939277: disk_zone_wplug_add_bio: 8,0 zone 12, BIO 6291456 + 14
  kworker/0:1H-59   [000] d..1. 2231.939884: blk_zone_wplug_bio: 8,0 zone 24, BIO 12775168 + 4

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c            |  5 ++++
 include/trace/events/block.h | 44 ++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 48f75f58d05e..b881aadbe35f 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -822,6 +822,8 @@ static inline void disk_zone_wplug_add_bio(struct gendisk *disk,
 	 * at the tail of the list to preserve the sequential write order.
 	 */
 	bio_list_add(&zwplug->bio_list, bio);
+	trace_disk_zone_wplug_add_bio(zwplug->disk->queue, zwplug->zone_no,
+				      bio->bi_iter.bi_sector, nr_segs);
 
 	zwplug->flags |= BLK_ZONE_WPLUG_PLUGGED;
 
@@ -1317,6 +1319,9 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
 		goto put_zwplug;
 	}
 
+	trace_blk_zone_wplug_bio(zwplug->disk->queue, zwplug->zone_no,
+				 bio->bi_iter.bi_sector, bio->__bi_nr_segments);
+
 	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
 		blk_zone_wplug_bio_io_error(zwplug, bio);
 		goto again;
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 9a25b686fd09..16d5a87f3030 100644
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
+		 unsigned int nr_segs),
+
+	TP_ARGS(q, zno, sector, nr_segs),
+
+	TP_STRUCT__entry(
+		__field( dev_t,		dev		)
+		__field( unsigned int,	zno		)
+		__field( sector_t,	sector		)
+		__field( unsigned int,	nr_segs		)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= disk_devt(q->disk);
+		__entry->zno		= zno;
+		__entry->sector		= sector;
+		__entry->nr_segs	= nr_segs;
+	),
+
+	TP_printk("%d,%d zone %u, BIO %llu + %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->zno,
+		  (unsigned long long)__entry->sector,
+		  __entry->nr_segs)
+);
+
+DEFINE_EVENT(block_zwplug, disk_zone_wplug_add_bio,
+
+	TP_PROTO(struct request_queue *q, unsigned int zno, sector_t sector,
+		 unsigned int nr_segs),
+
+	TP_ARGS(q, zno, sector, nr_segs)
+);
+
+DEFINE_EVENT(block_zwplug, blk_zone_wplug_bio,
+
+	TP_PROTO(struct request_queue *q, unsigned int zno, sector_t sector,
+		 unsigned int nr_segs),
+
+	TP_ARGS(q, zno, sector, nr_segs)
+);
+
 #endif /* _TRACE_BLOCK_H */
 
 /* This part must be outside protection */
-- 
2.50.0

