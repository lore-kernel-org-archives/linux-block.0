Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033EC2D9EEA
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580429; cv=none; b=RjZ3ZufqwwzsTRlM8QhVvgXmVClwbnqyWCVy/liIE2xqQyOOjaCkKuopqesb1UFqeODO5OJ96+9znwizS+T1u361DIa78v7YBDjNr4ZB1aHcMa5TtUQ6Ux8/RJ+S0rOjNMW4JluElbtAKdslymtljP65ruyIUNp60Ofu6uDclWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580429; c=relaxed/simple;
	bh=4h6RhvTLwDcng2amX47KJdDZ1ciCVcMQ4eCiadg3LvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oW8ZGjl7rTGhHFFDXzEjPbzLgaR8FKk6yCF0LlKM7g+d2rtrfKXHzCR/VSjjs9BR/UTFPP2XRXLolJtGtfxEmG27/Ng9PwscT4z5pGPTsPd5YQh0kbTeo7nCoRHDdoWvRaRnPFOtd52K/eOjLiXZBx5y0nN2xEI6rbYIIbZrFl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Sqz2bfbE; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Sqz2bfbE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752580426; x=1784116426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4h6RhvTLwDcng2amX47KJdDZ1ciCVcMQ4eCiadg3LvQ=;
  b=Sqz2bfbE8YWXM55to5VtlfIdMD5YsNqmHg3R4oa4praa/MtEsga7AECF
   eYqnrcOji/vjZPqkoNTyJgpV3btt+HlXpPwx6ESngN8H9YnrmSLYJP9ot
   x6lGelaYAjDKFMf8/+BNfcoEprMybviNPLUpFZVGFhODj6kLu/+Q3JaBg
   F9KbCCe+YwCvUR1xhoqpGJjvX5ml9PmaIwWaxWNFWhfC247AJISsiSyKH
   jubuN4j7Urpl+ov14R0k5pWEcZMSQNF0NtNnQwL2SuWZiGOZD9gDdqkeV
   Y65WbgdcTJsny6DJ3idTkuEn4gVcewdO+SIpxxTVNKW3MqB5uQI1TrJQY
   w==;
X-CSE-ConnectionGUID: hk7JsJMrTwC4xJbBMQmWSw==
X-CSE-MsgGUID: C9EixTKPT6CFqoh0Yb4EdA==
X-IronPort-AV: E=Sophos;i="6.16,313,1744041600"; 
   d="scan'208";a="87768615"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2025 19:53:45 +0800
IronPort-SDR: 687632a8_/pfDZL8SdBVhky2PdYHjCzdSDzCLTOoz7LzmT3QVWvVWwhk
 XeeQJIW6cl3DJnsmvUaSSb7G6Oh5W6EveanhRMg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2025 03:51:21 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jul 2025 04:53:44 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-block@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v3 4/5] block: add tracepoint for blkdev_zone_mgmt
Date: Tue, 15 Jul 2025 13:53:23 +0200
Message-Id: <20250715115324.53308-5-johannes.thumshirn@wdc.com>
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

Add a tracepoint for blkdev_zone_mgmt to trace zone management commands
submitted by higher layers like file systems or user space.

An example output for this tracepoint is as follows:

  mkfs.btrfs-203  [001] .....  42.877493: blkdev_zone_mgmt: 8,0 ZRS 5242880 + 0

This example output shows a REQ_OP_ZONE_RESET operation submitted by
mkfs.btrfs.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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

