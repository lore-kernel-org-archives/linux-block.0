Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FEAEAD7
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503920; cv=none; b=p2IV6RpM77iUBj9X+aU1szNeaSATgOt/cfhAGVYrcpsAUSLnmni35UGGB0CBI+MbFq+W42w9UJqOziD9RuecwOpbHAbvdB37gd1ZlsX0D5Q04rhq0lLSFu2JQelzN913T3FroCdzAE7oRriwWZMxpzPGfCwa+bpN987a7RwRyt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503920; c=relaxed/simple;
	bh=KfXaGnSYsBoTBESkAXp3LA/123C1wdCKvx2ZSDm5adk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RsSo0HKDXNQqN4eA6WdKtVM9ljfcMlXTpegpiXc8JtIPBmY1Pba/ngi0i6pqm1RJFeANrEprGXPOcoWcJiHk9v7MWXgKi26/K8828c85mpvexm3Sb23tTo8oic4NhHMm3H5op2FLH8fH/XZp2cfIMS9DQ7WTUg69gftmO9wniEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=b+F4vdGK; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b+F4vdGK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752503919; x=1784039919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KfXaGnSYsBoTBESkAXp3LA/123C1wdCKvx2ZSDm5adk=;
  b=b+F4vdGKZ7H/FjHMwoXe9di+ijYRtvCpCY3g4nUtodI23e8QlNOKkAS7
   mhLQn5epwZ+UG2YxZj1jh20dFNQnlSpHsozbZ7cj9Z8D3WkGNBy416IIp
   h+i8IT+NTPMG8kDitq7LjQk02A0W2YR6Strwt/sn7X1qcw2CxJ7+naVft
   IVKQDZG4EMDnTlaq+LvD1q0SawzlQ5achmEJKUu33oKdUbh5i5+45l4wA
   uSP/cEMB64YHoPlcR7atKAl7wL+iqzHNZd8cgXAETV34J9dTzzpcCV4wQ
   H+1ejXvTdBGRUcFdYWp2DoXRBKZri3btaRuSBA7BDKfPOr7SZItdXXBvS
   Q==;
X-CSE-ConnectionGUID: BfPlC6XwRTuEuU+bL2F7Jw==
X-CSE-MsgGUID: onPsfdG3RYiXjiFRXp0fAg==
X-IronPort-AV: E=Sophos;i="6.16,311,1744041600"; 
   d="scan'208";a="86591357"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2025 22:38:38 +0800
IronPort-SDR: 687507cf_ARgtLoixrxUebap0YHsGfLQne+9pDXo5W8hUjMFIBenTgbB
 5b0fquWhvygJPGKPHv5x8BYr17SfwtjA3sUj7Xw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jul 2025 06:36:15 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Jul 2025 07:38:36 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 4/5] block: add tracepoint for blkdev_zone_mgmt
Date: Mon, 14 Jul 2025 16:38:24 +0200
Message-Id: <20250714143825.3575-5-johannes.thumshirn@wdc.com>
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

Add a tracepoint for blkdev_zone_mgmt to trace zone management commands
submitted by higher layers like file systems or user space.

An example output for this tracepoint is as follows:

  mkfs.btrfs-203  [001] .....  42.877493: blkdev_zone_mgmt: 8,0 ZRS 5242880 + 0

This example output shows a REQ_OP_ZONE_RESET operation submitted by
mkfs.btrfs.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c            |  2 ++
 include/trace/events/block.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 2584ffb6b022..48f75f58d05e 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -179,6 +179,7 @@ static int blkdev_zone_reset_all(struct block_device *bdev)
 	struct bio bio;
 
 	bio_init(&bio, bdev, NULL, 0, REQ_OP_ZONE_RESET_ALL | REQ_SYNC);
+	trace_blkdev_zone_mgmt(&bio, 0);
 	return submit_bio_wait(&bio);
 }
 
@@ -242,6 +243,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 		cond_resched();
 	}
 
+	trace_blkdev_zone_mgmt(bio, nr_sectors);
 	ret = submit_bio_wait(bio);
 	bio_put(bio);
 
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 4855abdf9880..ff7698efdfde 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -599,6 +599,40 @@ TRACE_EVENT(block_rq_remap,
 		  (unsigned long long)__entry->old_sector, __entry->nr_bios)
 );
 
+/**
+ * blkdev_zone_mgmt - Execute a zone management operation on a range of zones
+ * @bio: The block IO operation sent down to the device
+ * @nr_sectors: The number of sectors affected by this operation
+ *
+ * Execute a zone management operation on a specified range of zones. This
+ * range is encoded in %nr_sectors, which has to be a multiple of the zone
+ * size.
+ */
+TRACE_EVENT(blkdev_zone_mgmt,
+
+	TP_PROTO(struct bio *bio, sector_t nr_sectors),
+
+	TP_ARGS(bio, nr_sectors),
+
+	TP_STRUCT__entry(
+	    __field(  dev_t,	dev		)
+	    __field(  sector_t,	sector		)
+	    __field(  sector_t, nr_sectors	)
+	    __array(  char,	rwbs,	RWBS_LEN)
+	),
+
+	TP_fast_assign(
+	    __entry->dev	= bio_dev(bio);
+	    __entry->sector	= bio->bi_iter.bi_sector;
+	    __entry->nr_sectors	= bio_sectors(bio);
+	    blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
+        ),
+
+	TP_printk("%d,%d %s %llu + %llu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
+		  (unsigned long long)__entry->sector,
+		  __entry->nr_sectors)
+);
 #endif /* _TRACE_BLOCK_H */
 
 /* This part must be outside protection */
-- 
2.50.0

