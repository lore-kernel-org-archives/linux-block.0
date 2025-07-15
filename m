Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5D42DA759
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580425; cv=none; b=RfIV6otXuFzjYFH3C75WEHoZ4AL/L0mkRSAqncMYXaSnpviVerH4OLFlK3s+huHGlHmv8TJUvfzOsnpws35JDBjsT/52pglCqkVDcfaDLf6tLD9/JEuci9Vd227yz+TM/FbIMdxEo+pLoSsdcfgTjPtvzfzS29yj7MZBzae7yoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580425; c=relaxed/simple;
	bh=4uuZs4ra9KBtwSuSsk9Oa1+HhGvNiQ7sWC4qZRUGqt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M8wiJh5zGVAC6f4aZE9AHXev21ATyvqmYuXTsr0esZhv41QRDaZ5G0d6Nm/TlRZ0uny8lX2JQX07O3XE0ge32Od41je2yvw9gtv9qyrW5bdowgfty24g9xR64BA6yL8u8NoEgmiUgyRuLH4OHxeU6XgtjkT2kTiXdPGvhcIlm5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jafBuI9R; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jafBuI9R"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752580423; x=1784116423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4uuZs4ra9KBtwSuSsk9Oa1+HhGvNiQ7sWC4qZRUGqt4=;
  b=jafBuI9RrNrw+3SyJJ1D6qpgEKVCLwRH3c5L9hVu8pK0V+6GY6hNwwV3
   QiYocQuQuQqw8ThWxCootz4GC6WoyFDGrlpssgQg4mcHbHirfM3GNsfQZ
   31gL070WxYRpGR4N2pYlyFNqN1A7ZPdcBfUlMNXBbeguGxO2hF0A2hqFs
   EzMxpW4fn+zK78PykhRJ9QX8Rljvtl51hUyMEwTTGIBzX43WyccGlTFaE
   YPqyoCWXFHaV9d63N0CZNlsWHX2JlauG3keUVTm0g6LukvP0GKGxoUEeF
   HZK3LSt0irK+MtwuhelUuZn7NeJx0K7fVonB3epBKg47C2nf7rtkVi5HD
   A==;
X-CSE-ConnectionGUID: VfSUhZX0RPSjJas+N2pbjQ==
X-CSE-MsgGUID: 3yuok6iUQ76Ld052eJkuKA==
X-IronPort-AV: E=Sophos;i="6.16,313,1744041600"; 
   d="scan'208";a="87768600"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2025 19:53:42 +0800
IronPort-SDR: 687632a6_qWW80mmK6qC8m5874gs6YXwdNvMASAj0mEtTn7SwEIKSIPC
 VLS8DeYeqv10nVXLUGsxI8JiWqfVg4SYOKyNq+Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2025 03:51:18 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jul 2025 04:53:41 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-block@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v3 3/5] block: add tracepoint for blk_zone_update_request_bio
Date: Tue, 15 Jul 2025 13:53:22 +0200
Message-Id: <20250715115324.53308-4-johannes.thumshirn@wdc.com>
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

Add a tracepoint in blk_zone_update_request_bio() to trace the bio sector
update on ZONE APPEND completions.

An example for this tracepoint is as follows:

<idle>-0 [001] d.h1.  381.746444: blk_zone_update_request_bio: 259,5 ZAS 131072 () 1048832 + 256 none,0,0 [swapper/1]

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c            |  3 +++
 include/trace/events/block.h | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index e79e0357d1f1..2584ffb6b022 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -17,6 +17,8 @@
 #include <linux/refcount.h>
 #include <linux/mempool.h>
 
+#include <trace/events/block.h>
+
 #include "blk.h"
 #include "blk-mq-sched.h"
 #include "blk-mq-debugfs.h"
@@ -1216,6 +1218,7 @@ void blk_zone_append_update_request_bio(struct request *rq, struct bio *bio)
 	 * lookup the zone write plug.
 	 */
 	bio->bi_iter.bi_sector = rq->__sector;
+	trace_blk_zone_append_update_request_bio(rq);
 }
 
 void blk_zone_write_plug_bio_endio(struct bio *bio)
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index d88669b3ce02..4855abdf9880 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -404,6 +404,17 @@ DEFINE_EVENT(block_bio, block_getrq,
 	TP_ARGS(bio)
 );
 
+/**
+ * block_zone_update_request_bio - update the bio sector after a zone append
+ * @bio: the completed block IO operation
+ *
+ * Update the bio's bi_sector after a zone append command has been completed.
+ */
+DEFINE_EVENT(block_rq, blk_zone_append_update_request_bio,
+	     TP_PROTO(struct request *rq),
+	     TP_ARGS(rq)
+);
+
 /**
  * block_plug - keep operations requests in request queue
  * @q: request queue to plug
-- 
2.50.0

