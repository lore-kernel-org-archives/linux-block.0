Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADDF21C173
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 05:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787894568; cv=none; b=qss8OslR6w3isHESIOcXX8fufYyRyJQOla2g4C5unDavgV5cqMSIKuHZfYZGqLxNLSyv0BOwxxDrkjqz20rr1uk0qZ9f3sATREa5kuHg0P+3HkPZ3iiu9kjUakizCirH2INlQ8uOcVQ+qaVnhdUo8wQpWGymi+VyKbF8NA5621U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787894568; c=relaxed/simple;
	bh=5WLJPYHH/d706bFwyiPXUEwLuY0/Wr5W7XZsev9qIKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXom6ZXZVdtG2n2Cdvg83CzI5z8hOXeV2vMZSLVXXZ5muwJkscCfZ9kiHWv4ZI2T6zprORv0/ZZkEtysa2+eK9Uam6TMcPMKcyU9DsSoWqEN9Bl/MjHHQcX3mJprlmo5be38V1zbbpKSx8nR+Evm5TCt7KSx2EAMPD/Wkl+HniE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qHRZttB2; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qHRZttB2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787894567; x=1819430567;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5WLJPYHH/d706bFwyiPXUEwLuY0/Wr5W7XZsev9qIKk=;
  b=qHRZttB2198HCun9vL41i1VjDYMn+I6p9R/oOr6OyRxEclU9vAUgeunJ
   +L/fomPUTfnZrjZNZyz1KHH4FnJzPWMd0RJ6x+qYaI8giNIzpJ7QHvEnO
   Pbsvnv88UyiFXCJ+Kdmh7Vrs6fFEOdoNx1Eaxqx7hdjdA8opgAyxm4cON
   kgvO0eErtjrurv2xO9x4Rlep8piZlYPj4KqRW0L5RmOMqAWXnb4JFPX4V
   vfyE3FDZ/TP87rKpwaBw97FwAftyI+xq4eBRIxf+9Q9JaQC8REQdfj8KU
   NZdiX2HO/KN065pL/V6RgT0AjU+2XhlTau2TMWjixpB9rlSeG3w/416WG
   w==;
X-CSE-ConnectionGUID: 24tp0mP4Rf246ddugxmFJw==
X-CSE-MsgGUID: wTVUOIRtRoCAZiIsKs3vmQ==
X-IronPort-AV: E=Sophos;i="6.25,248,1779120000"; 
   d="scan'208";a="150239291"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2026 13:22:40 +0800
X-CSE-ConnectionGUID: XpFiVqWgQsC4YVz7OcYehw==
X-CSE-MsgGUID: NZJJtyGcQQGMg0lppHjW6g==
IronPort-SDR: 6a911b0d_UEQzeeQ8FNXADmTJI22sOa0cMjH3Oc3PtxvHYzsp4e9Idvs
 Tg57lVvaRILhFKwdSOT5K/J+/XCt2d55CPOu7VQ==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2026 22:22:21 -0700
X-CSE-ConnectionGUID: TCL9ph4jSm22XBEFGDvRdw==
X-CSE-MsgGUID: w8XNOC/gTseYd3VtDYw/8Q==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 27 Aug 2026 22:22:21 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3] zloop: zero out only the unread tail of short reads
Date: Fri, 28 Aug 2026 14:22:20 +0900
Message-ID: <20260828052220.2819827-1-shinichiro.kawasaki@wdc.com>
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
The fio test case 69 of t/zbd/test-zbd-support started failing since the
recent kernel commit 9cbbac29d752 ("block: Remove redundant plug in
__submit_bio()"). This commit in block layer changed request merge
behavior, and unveiled the bug in zloop.

Changes from v2:
- Added Reviwed-by tags
- Link to v2: https://lore.kernel.org/linux-block/20260730072633.1831826-1-shinichiro.kawasaki@wdc.com/

Changes from v1:
- Adjusted if-else form per review comment
- Link to v1: https://lore.kernel.org/linux-block/20260730055832.1826093-1-shinichiro.kawasaki@wdc.com/

 drivers/block/zloop.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 4323ac108cae..0e36349a5ad3 100644
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

