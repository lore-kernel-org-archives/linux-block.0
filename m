Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D773F3BE651
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785396417; cv=none; b=UUKTDrvp6q+hE8CrEJehAbXsFpn5AWurpMNJ1LtpsTpFnilh8dXqkGwQBVxGec0SRlu8gHnHo3S6vRCL/Z4VhdXA96YJ4M5lVpKQV/nceJM9w30ZjpqQzEVgDvhXJdkNhjMwH3L21QivRm7KswONibnlB7xkykj0ZfNFmxzbhaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785396417; c=relaxed/simple;
	bh=bsp5fYlt/70n/I+S/qLWRKhGY0bD/PvDoyKk1WmEH0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LvGcDZ3zLsS8Ay5JTIyidk5NDu7bcGKsgsfuEyL8nvyDpOEv9IM6TkUaxSOPTpR6PK5wuVDLEJmMRwWVIITJP2UKsEcWbLK174W+K26S9UoD2lpKSzOoQZyZ+EIEb3cJSQ1kJFeeNPwsBmhkAY6sLqnm1Tr3x0xH8d3RVF2Bf0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ov3elORa; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ov3elORa"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1785396415; x=1816932415;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bsp5fYlt/70n/I+S/qLWRKhGY0bD/PvDoyKk1WmEH0Y=;
  b=Ov3elORaHG+HDWbNVDAJCGP6ufW9w/7jcr981N9dyvp37DHpJFDj4DQw
   g9a2EB5/hs3u2yy1YBHxQ5xgAwyczmJ0vfteQeUwTNbnkwTdBtvJGI5u7
   yyfXCkGmitYi/UsyD6rzk+mNbBmk+YA0fWSuTPIEvC7rW0ny7ycokoCCV
   h9DMdn4V+NcXcS2VVFvPwhcjN4WZK0WXj7mc1PhMhotu9XyVRZWC4PlCG
   xMPjiABwcnMlcH30x73Lh9k3WG/i9vfZRjFCZ+o2lF4MwbFrSZrOjoKpT
   N7I+FsXfQE21Jli44Is0Llvj6GHSlkKGjUTJve0zJbUA/FXEuM6Ft3S6n
   w==;
X-CSE-ConnectionGUID: yuufy5V6TQaEJFBzvC3ehw==
X-CSE-MsgGUID: NQopE/ebSSKgyNbjUVSy8w==
X-IronPort-AV: E=Sophos;i="6.25,194,1779120000"; 
   d="scan'208";a="151804992"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2026 15:26:54 +0800
X-CSE-ConnectionGUID: Toi4OB5PRHmH2e94FQdBvQ==
X-CSE-MsgGUID: tGtCKFGURo6jb1zkyuzg4g==
IronPort-SDR: 6a6afcab_cOZaaRbQ6ww44wQsE8edjwT8faETBdVowx/i899fQSWtp0w
 w/4xRUhDH/+ZP3oVsSoVyA8NUCku/37PTqsseaQ==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jul 2026 00:26:34 -0700
X-CSE-ConnectionGUID: vqAglBtQTCq7FsvA+Yajzw==
X-CSE-MsgGUID: Yvc4GZLbT/eNcq9yT4UIdQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai2-o.wdc.com with ESMTP; 30 Jul 2026 00:26:34 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] zloop: zero out only the unread tail of short reads
Date: Thu, 30 Jul 2026 16:26:33 +0900
Message-ID: <20260730072633.1831826-1-shinichiro.kawasaki@wdc.com>
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

Changes from v1:
- Adjusted if-else form per review comment
- Link to v1: https://lore.kernel.org/linux-block/20260730055832.1826093-1-shinichiro.kawasaki@wdc.com/

 drivers/block/zloop.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 55eeb6aac0ea..947afe618795 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -798,6 +798,27 @@ static void zloop_cmd_workfn(struct work_struct *work)
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
@@ -812,13 +833,9 @@ static void zloop_complete_rq(struct request *rq)
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

