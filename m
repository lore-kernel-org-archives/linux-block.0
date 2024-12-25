Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3136717B50F
	for <linux-block@vger.kernel.org>; Wed, 25 Dec 2024 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735121400; cv=none; b=AkyuLXQzOyiHUWhfYnJoRYVHc3crH6oqDjSVcpYdfe6e4wnSGK9npASH9Ldf98CuyiTjnbghEpE9p7ytz3CmpTGQtU/VX6BzZybUVP8bu1wwJR1l8FEFiW5FHuztxkpeW6r8kcJH7A3whGadsDXV4WmD2sBkCk/NwaK24bjFc3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735121400; c=relaxed/simple;
	bh=0iz8JweiUvpnGy9W+Qsdh5M5SGVkAoJkNgfOBNdgkfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snf8RgmRh2dftXwNojJEd0RvyMMYbjfz1wTmVwRZ6tFvCKh2ZR3GsBuBe3au5IF6nKgQD/+mzp978mFuiRqCE1fcVjUAG2vcaqLeTOgPau9F3u4izWnJLhdo20EgaDHJUgzEQWmyThVTXIFOMyVh/u4i/ebnUeyIms+z2lFB7Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iO5fo/SB; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iO5fo/SB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1735121399; x=1766657399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0iz8JweiUvpnGy9W+Qsdh5M5SGVkAoJkNgfOBNdgkfY=;
  b=iO5fo/SBJ2MZTTxy3mQtmH2eIvY2m0oPMq5oB49TZZbWy4LJ0IlVFzsj
   YC2n0/yZYpbKrkMI+4qYlkkXG7rOcet7oU5/knzAjFgPEq5OGbHdqthGx
   Ya0cvzf4AhGKc9XlatLmM9UvvzLeZbE2bE99c3rrZlWLL5AD9b/Ko6rFw
   YePJjF2/2j+Es+kxSFmOE5m7sKG5C5jY/fCVqGBjigY57xc5/cem03cJJ
   6A1crJFfWJMf8A7hrF7JsUmaxy6WM1+Dsa06tEGjV6y9hqk8KOTcHJ1zX
   u0w/xJsupbmGHqeo7LhH+A3FzCLlN+h4GIvgodp9nRNn8V/9m2y/1F4sG
   A==;
X-CSE-ConnectionGUID: WNhkPfK+Th21BKiB7T4W7A==
X-CSE-MsgGUID: e4lLDUH7RweuE83siLgJRg==
X-IronPort-AV: E=Sophos;i="6.12,263,1728921600"; 
   d="scan'208";a="35812597"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Dec 2024 18:09:52 +0800
IronPort-SDR: 676bcc7c_VDmllqiEEl4TnzNN4FWxMn2xy1VidWCKZePIB4YZoYKVQ+M
 ziDl3F+wThZtEA3E7j1tI+ipTivbTTjIxjNm+GQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Dec 2024 01:12:29 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Dec 2024 02:09:51 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH for-next v2 2/4] null_blk: do partial IO for bad blocks
Date: Wed, 25 Dec 2024 19:09:47 +0900
Message-ID: <20241225100949.930897-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241225100949.930897-1-shinichiro.kawasaki@wdc.com>
References: <20241225100949.930897-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current null_blk implementation checks if any bad blocks exist in
the target blocks of each IO. If so, the IO fails and data is not
transferred for all of the IO target blocks. However, when real storage
devices have bad blocks, the devices may transfer data partially up to
the first bad blocks. Especially, when the IO is a write operation, such
partial IO leaves partially written data on the device.

To simulate such partial IO using null_blk, perform the data transfer
from the IO start block to the block just before the first bad block.
Introduce __null_handle_rq() to support partial data transfer. Modify
null_handle_badblocks() to calculate the size of the partial data
transfer and call __null_handle_rq().

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/block/null_blk/main.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f720707b7cfb..d155eb040077 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1264,31 +1264,50 @@ static int null_transfer(struct nullb *nullb, struct page *page,
 	return err;
 }
 
-static blk_status_t null_handle_rq(struct nullb_cmd *cmd)
+/*
+ * Transfer data for the given request. The transfer size is capped with the
+ * max_bytes argument. If max_bytes is zero, transfer all of the requested data.
+ */
+static blk_status_t __null_handle_rq(struct nullb_cmd *cmd,
+				      unsigned int max_bytes)
 {
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
 	struct nullb *nullb = cmd->nq->dev->nullb;
 	int err = 0;
 	unsigned int len;
 	sector_t sector = blk_rq_pos(rq);
+	unsigned int transferred_bytes = 0;
 	struct req_iterator iter;
 	struct bio_vec bvec;
 
+	if (!max_bytes)
+		max_bytes = blk_rq_bytes(rq);
+
 	spin_lock_irq(&nullb->lock);
 	rq_for_each_segment(bvec, rq, iter) {
 		len = bvec.bv_len;
+		if (transferred_bytes + len > max_bytes)
+			len = max_bytes - transferred_bytes;
 		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
 				     op_is_write(req_op(rq)), sector,
 				     rq->cmd_flags & REQ_FUA);
 		if (err)
 			break;
 		sector += len >> SECTOR_SHIFT;
+		transferred_bytes += len;
+		if (transferred_bytes >= max_bytes)
+			break;
 	}
 	spin_unlock_irq(&nullb->lock);
 
 	return errno_to_blk_status(err);
 }
 
+static blk_status_t null_handle_rq(struct nullb_cmd *cmd)
+{
+	return __null_handle_rq(cmd, 0);
+}
+
 static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
 {
 	struct nullb_device *dev = cmd->nq->dev;
@@ -1315,11 +1334,21 @@ static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
 						 sector_t nr_sectors)
 {
 	struct badblocks *bb = &cmd->nq->dev->badblocks;
+	struct nullb_device *dev = cmd->nq->dev;
+	unsigned int block_sectors = dev->blocksize >> SECTOR_SHIFT;
+	unsigned int transfer_bytes;
 	sector_t first_bad;
 	int bad_sectors;
 
-	if (badblocks_check(bb, sector, nr_sectors, &first_bad, &bad_sectors))
+	if (badblocks_check(bb, sector, nr_sectors, &first_bad, &bad_sectors)) {
+		if (!IS_ALIGNED(first_bad, block_sectors))
+			first_bad = ALIGN_DOWN(first_bad, block_sectors);
+		if (dev->memory_backed && sector < first_bad) {
+			transfer_bytes = (first_bad - sector) << SECTOR_SHIFT;
+			__null_handle_rq(cmd, transfer_bytes);
+		}
 		return BLK_STS_IOERR;
+	}
 
 	return BLK_STS_OK;
 }
-- 
2.47.0

