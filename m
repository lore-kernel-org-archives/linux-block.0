Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B392DA763
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061641; cv=none; b=Wgv+/LcerpFfLUg70CF9Bb+Meev1bUsxJ0tWx9r35+khKO8XzssEP5s+B4J+k+o3i7nE1NTwg/j5zkWQneeBT9knV288x88vP0VYGAqhEXzJP5vlfLD9m+q+cmbz4Fl65LSP4frw+NX64aXZzIsA4mx3jha7ixyeBPyGz7yUzZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061641; c=relaxed/simple;
	bh=OzGmX4J55ru5QnljkTZMx7ZW/PcHfYwkbE2NpUoVYkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F1HgspkET+ZTh0x+nv1dl0cC9/BcHzeU7MjKB3HGCQjtj75LO3a6dYa4sJ8XK0qhWrBFt3oTTFJB+Q3Zoo9BO4U3BEGOyUGut7F/qN0GbaJwXuS3LK6OwDdkQN477+EqPRjor/esVhhcweu3rvw8k1R/N4suuTaRcka7oEtFjLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=klFdzw0G; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="klFdzw0G"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752061639; x=1783597639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OzGmX4J55ru5QnljkTZMx7ZW/PcHfYwkbE2NpUoVYkU=;
  b=klFdzw0GvBWuLYWK8pbaK4UVTfLEz8RELKvLkOneAZim7vhOh4ezm+re
   nLO6+EU+7KhllIZQC2s/WUP5FUZlC8Gaktc85G487REUKr/ZgZH1iJM0A
   bhdPfVxrX+2AXtbBcOhlPWBUy9wQd/mjuxRCKoexdJF/L7s2bGUVydbBs
   Y4kPIVFSHgtkFgl5LRSGo0IRT6w7G+44xh3oXm9+RbLCHdEMWbqqoavB+
   JzPqeoVp9HwTGzlWid/M2P+DQmLF3EnBRkkj1Agk4JWCNvcZmgUDWEov/
   h5fLJVzEc75kO0QlsJ91Oi/msNN7K+/sOomgdU68Y/EgfCIv+iTNLdyEy
   Q==;
X-CSE-ConnectionGUID: jR99sEFARAeVMFWcy3FRGw==
X-CSE-MsgGUID: xvshnF68Trm/jWL6j6Cf3Q==
X-IronPort-AV: E=Sophos;i="6.16,298,1744041600"; 
   d="scan'208";a="91096350"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2025 19:47:18 +0800
IronPort-SDR: 686e482f_966mpeOgioxdvOY3f8LJYZgpLld3ZEriIG2Jy9kQORW7uWg
 s4EU196l1y/PVhaqcFHAX/ZuMDAQ4SRe6Oe2nKg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2025 03:45:03 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Jul 2025 04:47:16 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/5] block: add tracepoint for blk_zone_update_request_bio
Date: Wed,  9 Jul 2025 13:47:02 +0200
Message-Id: <20250709114704.70831-4-johannes.thumshirn@wdc.com>
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

Add a tracepoint in blk_zone_update_request_bio() to trace the bio sector
update on ZONE APPEND completions.

An example for this tracepoint is as follows:

<idle>-0 [001] d.h1.  381.746444: blk_zone_update_request_bio: 259,5 ZAS 131072 () 1048832 + 256 none,0,0 [swapper/1]

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
index 14a924c0e303..16d51f868064 100644
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

