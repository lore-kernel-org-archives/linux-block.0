Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E9D2DA765
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061642; cv=none; b=h7C7JT8QYQ8WWlsOQvNs3KTN2xCz8yDc3i8Qw8mrU9POa9Lchijh+rEBvFk/kYeZSqv5ZhhKVRN0hXMyp158g8zQJO4ENaTaJCpF7vEU/69/uavpbfdCQ2FLpG9iFa9V0NQlwFxYojx2bFy761D4+VrYmXseimAf4Xp2w7hGUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061642; c=relaxed/simple;
	bh=ILiheY67TyX5yYxroMUfqICdjMeh326pzTSHBLtou8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhrioeyoH8k9zZbfLbE25qiPmsdL8kOo+pixubsCicu1Wf9mT0zkBTN+FNbZhmjqJDqRfWw4WucbfOVMGfXZzKpWhFMCYAJ6nRu+XnpxsVsa+MMqx78VJ0VaSfApUMUbRnCaYTD4w7brOJBzQusE5XccOb0uDm+opNIprDteXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=U0eLeZfz; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U0eLeZfz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752061640; x=1783597640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ILiheY67TyX5yYxroMUfqICdjMeh326pzTSHBLtou8c=;
  b=U0eLeZfzGtNqQM3evuWDT8Lp20nefUqqr74TJCq/016om3VmksOEP6+Y
   bzaX2bAroQAV+RKA31ez4Iq7OucC0/lyJ9QWbFoCnd25B14ep+6fpWnYt
   +ORvLLpQogXgSXbSOwo3OCf5eDVYHshJS+894IcYMoALq7torNXFUtq1N
   trUNVoOEhgRpaADovaDRiLDVe06pWgGmewUZRK8RS3hWUmOUzNk890dHg
   FZtyEGa+4qZbGkxfKIEaHPnHlYGcbovO7dBQz1mdzh42bWRktKd0Brsfo
   OchjySz+Kpid1lo38fRgt6BNkbwgh4M7IPz2UzE3Z9SwOX7pzxWLufUjA
   Q==;
X-CSE-ConnectionGUID: e0SiMTrUT5yIzSXGgLxokg==
X-CSE-MsgGUID: g4F4U7gfT4Gj9FnDWYUNsg==
X-IronPort-AV: E=Sophos;i="6.16,298,1744041600"; 
   d="scan'208";a="91096357"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2025 19:47:20 +0800
IronPort-SDR: 686e4831_ElxgtBAQblXlzktvdhDGmkgyTkwAzV9X4sIEYsxXxTfra6f
 bT9qrakc+gaWbVcTNV0d/6CBjA6NaZuR0dB1h1w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2025 03:45:05 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Jul 2025 04:47:19 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 4/5] block: add tracepoint for blkdev_zone_mgmt
Date: Wed,  9 Jul 2025 13:47:03 +0200
Message-Id: <20250709114704.70831-5-johannes.thumshirn@wdc.com>
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

Add a tracepoint for blkdev_zone_mgmt to trace zone management commands
submitted by higher layers like file systems or user space.

An example output for this tracepoint is as follows:

 mkfs.btrfs-210 [000] .....   116.727190: blkdev_zone_mgmt: 259,6 ZRS 524288 + 0

This example output shows a REQ_OP_ZONE_RESET_ALL operation submitted by
mkfs.btrfs.

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
index 16d51f868064..9a25b686fd09 100644
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

