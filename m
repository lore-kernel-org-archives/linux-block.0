Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA9F26461F
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 06:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391222; cv=none; b=t+GJgspPVHzrCOFoooBAanYhhSfZ66jjy1NOBFmChrP5lvFbs4CZl90U6xngL6kyYFO66opxuVByZsjZUj/0d+ow2pn+tKWq6YV5LfiFaIhrCIAOwO9QckuJJV0LIOyj3DYwgp7DBrKMeUsKV0gJNDzMiU1D0ngbS2yBLEEeEVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391222; c=relaxed/simple;
	bh=GF5zZTlAcByL0kvUAg4XzrpQ65mzvFA2h3Kvm9zblAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OPOf1RWE6jF0V0ZlMLt3sjwuy5IzlqXezyZsKIcnHa394+/aR+pQS66dHXtjxU5WXKI3QIIsunBaPVUffQ2iQx9keciUxXrPr1vQiCRzYce7H1yfPO6yKFsAK8pCrYYuvS0oeDYHQesVi+NLC8aiBQhoB/GnjVFutTKcQNK8zTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EObBrOSA; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EObBrOSA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1785391220; x=1816927220;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GF5zZTlAcByL0kvUAg4XzrpQ65mzvFA2h3Kvm9zblAM=;
  b=EObBrOSA+nnYfa68NakZ67anKeC4QYV84+uqFvJDgNSrwvCE898ikr41
   9KObMwt4v5iNVqWXL0eCywG+WQyusNsZs7bP2thULC63P9F1/B3wAVf0S
   SxOrj2k9TPU4koZtixdx4XZmy2j+e4llGb9mffTe/xeb28wVB8AyD0Ywc
   BvkL4fN1uP6A0wHezlFGpGdiE0209eil8K3TmVsW6ktjX98D3Q3H6YVeo
   CxLSaGWXlmp8EoelCO34+PnCmgZVBfln9d1331ArWtgqhz7poGKjlrk4v
   8xlAwdywylMc1NTqOnAF4+FN6X5HKvFYzl0IR5GYKf+rCVu7uGLLEQt6M
   w==;
X-CSE-ConnectionGUID: JG04EPvWRsyIoLUyYJ0xPw==
X-CSE-MsgGUID: ksiHDvy4RW6LGbKr59BZkQ==
X-IronPort-AV: E=Sophos;i="6.25,194,1779120000"; 
   d="scan'208";a="152079867"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2026 13:59:11 +0800
X-CSE-ConnectionGUID: 0A0wQnGdRxOJjC9vyDLm+w==
X-CSE-MsgGUID: lsqKGZx1SDmY11A9KXQBxg==
IronPort-SDR: 6a6ae80a_c0JJ6riA6/kizVAs2vQslUXR43XNF6L5l8+EIofcJAMFh0S
 BppyZc63hjMADoS9JgPLND3bIrbanegDIQVZBCw==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2026 22:58:34 -0700
X-CSE-ConnectionGUID: ACU7ayR3RtihgmWKXhtPDg==
X-CSE-MsgGUID: cQXpxHx8QVC0GkD3Oit0Ug==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 29 Jul 2026 22:58:33 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] zloop: zero out only the unread tail of short reads
Date: Thu, 30 Jul 2026 14:58:32 +0900
Message-ID: <20260730055832.1826093-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zloop_complete_rq() handles a short read from a zone's backing file by
zero-filling every bio in the request. This is correct when the entire
request is beyond the written part of the zone. When a read request
straddles the boundary between written and unwritten data, read_iter()
returns a partial byte count and zloop then zeroes the whole request
even for the partially read area with valid data.

Such an unexpected zero data read was observed with fio test script
t/zbd/test-zbd-support and its test case 69, failing with "bad magic
header 0".

Avoid the unexpected zero data read by zeroing out only the unread tail
part. When read data size cmd->ret is smaller than the request size,
call the new helper function zloop_fill_zero_rq() that walks through
each bio_vec and fills zeros from the specified start offset.

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
The fio test case 69 of t/zbd/test-zbd-support started failing since the
recent kernel commit 9cbbac29d752 ("block: Remove redundant plug in
__submit_bio()"). My understanding is that this commit in block layer
changed request merge behavior, and unveiled the bug in zloop.

 drivers/block/zloop.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 55eeb6aac0ea..42967e7aea58 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -798,6 +798,26 @@ static void zloop_cmd_workfn(struct work_struct *work)
 	current->flags = orig_flags;
 }
 
+static void zloop_fill_zero_rq(struct request *rq, unsigned int zero_from)
+{
+	struct req_iterator iter;
+	struct bio_vec bv;
+	unsigned int pos = 0;
+	unsigned int end, off;
+
+	rq_for_each_segment(bv, rq, iter) {
+		end = pos + bv.bv_len;
+		if (end > zero_from) {
+			off = 0;
+			if (pos < zero_from)
+				off = zero_from - pos;
+			memzero_page(bv.bv_page, bv.bv_offset + off,
+				     bv.bv_len - off);
+		}
+		pos = end;
+	}
+}
+
 static void zloop_complete_rq(struct request *rq)
 {
 	struct zloop_cmd *cmd = blk_mq_rq_to_pdu(rq);
@@ -812,13 +832,9 @@ static void zloop_complete_rq(struct request *rq)
 			pr_err("Zone %u: failed read sector %llu, %llu sectors\n",
 			       zone_no, cmd->sector, cmd->nr_sectors);
 
-		if (cmd->ret >= 0 && cmd->ret != blk_rq_bytes(rq)) {
-			/* short read */
-			struct bio *bio;
-
-			__rq_for_each_bio(bio, rq)
-				zero_fill_bio(bio);
-		}
+		/* Short read. Zero out the unread tail beyond cmd->ret. */
+		if (cmd->ret >= 0 && cmd->ret != blk_rq_bytes(rq))
+			zloop_fill_zero_rq(rq, cmd->ret);
 		break;
 	case REQ_OP_WRITE:
 	case REQ_OP_ZONE_APPEND:
-- 
2.54.0

