Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89EC259C9A
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503923; cv=none; b=numc1fs4kTF+SUEU7ScQnd/elqPQonkUNM0CTchX3x/c9ezobbdwpgn18yYpVKUI5xTvOi2uMZ5OHL6KaZk4CtKZQFd0eYlpnOAa2XcDfqj5zBGci9ACj6N1rMsDv0bEPLI+paOt8nW/HiewodBG6kO8nJPbzvFf+EzNQTLDcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503923; c=relaxed/simple;
	bh=ryD4dsD0Exoz1WhVJgK+jgbobb5TRKA6gJJ9BSuT4MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cdfQIhUAgqKc+uNDQOApNeMEXAaSr6mU6IdixWbc09QVVqdJ9ZM2QUve2oTuJqLavLOIh50fuE7Lo+UL1j5xN+RseKNxQDA1EtKjJcu8kdWyF2oNfFa77vOHM99HeoFQcBHetWWghl8ebaRT5hmWKQfhnEwvZjXcHQXV9VqDZRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aV6x6nN+; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aV6x6nN+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752503920; x=1784039920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ryD4dsD0Exoz1WhVJgK+jgbobb5TRKA6gJJ9BSuT4MQ=;
  b=aV6x6nN+2zNVy6iGcrmBHAtDcSteQ31JEujiDN/AYEwITjJGs/QZk++m
   1pPVKg7bldzGCk1jNX0BLV75IWsvbT57cNQEmR/gG0oTexbDsdX9JQbox
   vRSmKzz64FGnwSQCQvUeBERWyudj1Md5KqQGD2X5TEu66Z+qXc75ascPK
   lM9Y6vhuyi6rTEWgduUURFOP01AZq0lNyUu50n8mixoxB72zs2W+0yBmX
   1d5e9qB9seXLX6yBn9aGRmzKNHHfNOzGHOYhjkury8ZkeYLbGLPMyYIen
   jpU6Q5/+P8JG9vOiRXSqjyMDZLuO4+Cy7jK+TDsJckJ5OBtZxEH7vWDTW
   w==;
X-CSE-ConnectionGUID: zjciGAJpRmKagbhP3Sf2gA==
X-CSE-MsgGUID: 3/FjFjEsT7+7UX5GQSLOrw==
X-IronPort-AV: E=Sophos;i="6.16,311,1744041600"; 
   d="scan'208";a="86591363"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2025 22:38:40 +0800
IronPort-SDR: 687507d1_wFZVxE3Gjk9LqXFZyAlGypin3rl54SLWr6uaBKJ1abvv/LR
 w9ciK6fqDrp1IBmN5HIvvcssmhbucAYsLKtn4SA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jul 2025 06:36:17 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Jul 2025 07:38:38 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 5/5] block: add trace messages to zone write plugging
Date: Mon, 14 Jul 2025 16:38:25 +0200
Message-Id: <20250714143825.3575-6-johannes.thumshirn@wdc.com>
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

Add tracepoints to zone write plugging plug and unplug events.

  kworker/u9:3-162  [000] d..1. 2231.939277: disk_zone_wplug_add_bio: 8,0 zone 12, BIO 6291456 + 14
  kworker/0:1H-59   [000] d..1. 2231.939884: blk_zone_wplug_bio: 8,0 zone 24, BIO 12775168 + 4

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c            |  5 ++++
 include/trace/events/block.h | 44 ++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 48f75f58d05e..1e2e957c4fb2 100644
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
+				 bio->bi_iter.bi_sector, bio_sectors(bio));
+
 	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
 		blk_zone_wplug_bio_io_error(zwplug, bio);
 		goto again;
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index ff7698efdfde..eeaea02f5535 100644
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

