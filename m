Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233774BEE43
	for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541845; cv=none; b=d70Mll6aJ5IZkC91zw3kVdZWaDj9Jj7DPUwCUfGXgl9KSc5/uCy0PHmjzNW/+jzPsCvagoOERvWs5q2260Kyk5CviS1T85XkRJapppz8bI3kuzEg8XpgW7EmIhXsiA2cgmh3CnRwZY6oLJgKFNvOfaSna+2vutz92/uAGeODpa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541845; c=relaxed/simple;
	bh=pA7rNlMjcElCfP2xeC3ZUnRICzP6xnGxNr9nEWX+IDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3JRhJEJlVBJciGBYI8ZAzFSKUkr8aujcCvqtz6bupYMSk+eWLZOTR9OJYEhlVBbGeTPp99pCjzcczmKn8pUCUIlDUJdhgBjp9ZHIkn5IOVKwfdSbWdeQ8MPXcqiOGr8PXxnkB7+Alfw/i4dfNfBUbAZdUejsHH5mFLdItHSLtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com; spf=pass smtp.mailfrom=opensource.wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JuaWtDXn; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JuaWtDXn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1789541843; x=1821077843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pA7rNlMjcElCfP2xeC3ZUnRICzP6xnGxNr9nEWX+IDg=;
  b=JuaWtDXn8IAIyZx8ikf1wAVcj2kulIqOjnLyANmVU+7c/pAwxdRY1K8j
   FJDRdtPcGTZYcxtxRCrKeKHJA9LBL6WLRyDJ8tFYlyVHEzuRIqdTyIU+S
   27ijWV7pzIKbb8kvpFqSZLsuT4wjQ+LcVWoKa+EsMTReCdel0rZfVrPVc
   um5/X95GN+wfzpo+G7KdVP/GlaOTrV0BYscWhD4KxrBrMYOhDMqi5ms2Z
   vHsVEVdYJY47Xptt0b77V16Nx2LG448ssp95NhvRFBsBQrFjguGuZT5M2
   mkS6M3ApokGFj3Vbeoadealojoq0bWE4KoZKkeNC5lggKrMb/e5iIyMsv
   w==;
X-CSE-ConnectionGUID: jCPa/wcUQdmD3sb7eLUY0g==
X-CSE-MsgGUID: cCnIEb+BSAmO+nzpy93XKw==
X-IronPort-AV: E=Sophos;i="6.27,103,1786982400"; 
   d="scan'208";a="156715125"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2026 14:57:23 +0800
X-CSE-ConnectionGUID: EtQYpsHfQYe2zKMn0E6Tyg==
X-CSE-MsgGUID: v3Uwhg1fRkynxaEtKTHOgg==
IronPort-SDR: 6aaa3dbb_/FW3108pBmrC3LOaMtbO1f8atIH5OLYIk8XQ5iafSs79nsO
 635r+HN65JV56A19+GdUDDr8JJt4XzwtoNpb6HQ==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2026 23:56:59 -0700
X-CSE-ConnectionGUID: 6uX81nAMR5evdlscjqaDlA==
X-CSE-MsgGUID: HqOH9ew3SG2bihIIy7Ff1A==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 15 Sep 2026 23:56:58 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@opensource.wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3 REPOST] zloop: zero out only the unread tail of short reads
Date: Wed, 16 Sep 2026 15:56:57 +0900
Message-ID: <20260916065657.62724-1-shinichiro.kawasaki@opensource.wdc.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Jens, please consider this patch for upstream.

The fio test case 69 of t/zbd/test-zbd-support started failing since the
recent kernel commit 9cbbac29d752 ("block: Remove redundant plug in
__submit_bio()") in v7.2-rc1 tag. This commit in block layer changed
request merge behavior, and unveiled the bug in zloop.

Changes from v2:
- Added Reviwed-by tags
- Link to v2: https://lore.kernel.org/linux-block/20260730072633.1831826-1-shinichiro.kawasaki@wdc.com/

Changes from v1:
- Adjusted if-else form per review comment
- Link to v1: https://lore.kernel.org/linux-block/20260730055832.1826093-1-shinichiro.kawasaki@wdc.com/

 drivers/block/zloop.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index f0ca221524db..394dc2408ed7 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -800,6 +800,27 @@ static void zloop_cmd_workfn(struct work_struct *work)
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
+			if (pos < zero_from)
+				off = zero_from - pos;
+			else
+				off = 0;
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
@@ -814,13 +835,9 @@ static void zloop_complete_rq(struct request *rq)
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

