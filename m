Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AA92571BD
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503920; cv=none; b=j69BAUSV2LDXx+HSVavxhwxAexlyYyyKWGxFmNPnnohqTGmgkZjJ465lfnJTjQqJO+tKJRcjgTUNvn6gwPqUY08Lm1bkGNWCqJvbQOZK+HbwBt/Vr8A5MBg3Ngt+VJxt3BBjy6hS1MhZ+3P+XfB/+CsQ9coiERhGfYuCJMtQs50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503920; c=relaxed/simple;
	bh=RXdliINndbUJqfbop/akiL43oDmYdKvJ8QGEuT7vXlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BHEbVTwzI1y/fRbIHwRCWh29/yO1pcEacJZ48Y4uSSjr99iAWe1Ij6BYK/9YOFnP+st3gjbjyfPxJv3futi/Y2Rj5hQkPWmiPZwbv6GZo7JTzus2xCkwdwUSzd/OQal34VAql2OIpwunDgWx7KFGqI4Ab3jNqsb8TvDaOzDM7Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qELA5lz2; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qELA5lz2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752503918; x=1784039918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RXdliINndbUJqfbop/akiL43oDmYdKvJ8QGEuT7vXlM=;
  b=qELA5lz2gR1KUUG2UCp728nyIxT8P6Eic4QDIi1lIyJnF4MoGD87lqEG
   ipMlVP5kDmsy2AHnVZBY1WE1DpQQ6CLGj/lWWgcHBPBATwJ6NwI/g3su9
   mUt8Geqhnle6j5EYdXrsgNl3UAJOxR9RFjDx2PoHzWMdq7VraMK1AUTBx
   gHHEQYx13dOFgXGF9WUAQ45TzHW8OODakMxZxK9GHykuaOTDETVglAM3B
   c7GDY72ebB6R17QVQI9Hqji7R6KUf+SdrUUaweWkTH8in6Hyeq2l0hFEl
   fKEBK+9Q2T/LeRGtWeC+GmMU5xvinliSnJkgr838OaBb21poSTsOePZjR
   g==;
X-CSE-ConnectionGUID: gJcOgXnFTbCk81Y95GVqtg==
X-CSE-MsgGUID: CmsanD6UQd6S7/cwPSQA4Q==
X-IronPort-AV: E=Sophos;i="6.16,311,1744041600"; 
   d="scan'208";a="86591354"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2025 22:38:36 +0800
IronPort-SDR: 687507cd_nDVEL6AkA1FYHtJDh9n+sbAF7KJ4pzd6tDlC1oBW0NibMZj
 ZcTA4KCedVOVhHO6GmRaeazfkjBTaLC5GrhecCA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jul 2025 06:36:13 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Jul 2025 07:38:34 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/5] block: add tracepoint for blk_zone_update_request_bio
Date: Mon, 14 Jul 2025 16:38:23 +0200
Message-Id: <20250714143825.3575-4-johannes.thumshirn@wdc.com>
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

Add a tracepoint in blk_zone_update_request_bio() to trace the bio sector
update on ZONE APPEND completions.

An example for this tracepoint is as follows:

<idle>-0 [001] d.h1.  381.746444: blk_zone_update_request_bio: 259,5 ZAS 131072 () 1048832 + 256 none,0,0 [swapper/1]

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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

