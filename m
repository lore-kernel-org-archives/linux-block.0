Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB195FEED
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734508165; cv=none; b=WOaKPsKdCfA6FNe4fD5N30PNEpnjIKPFQEprZZ+j9lJ3RbNU/KovZdR1fRw/P5H3GpQAVNQLISZkSET+gkr/3kSScedQmq/BQi3mjVWX7n4SfIBOZRc421bzwODEcgzNJ91xDeM+R3Gks6CnJF9WvtCC1f9urlX+AqQ8E90t4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734508165; c=relaxed/simple;
	bh=E63JxYB7LSkjK413CzHl2y+wDZA0LhAWLrrPvos+zMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAviiy8SVBLEKD4FzmB2GV0NH8Ia2vJZH5PALEDI39XkNi+eCkeq6lA72AF66epG/9endVj65nUof3R/8MEWm/uX8qxmkA2A9xKGNiBs+HzWWKGGI32mvO7WbME1u+y1Phf/goPvoPv2ewh7XCe8/jQnDpseoOnYo4sFCCnT1Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Zw1gW2eQ; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zw1gW2eQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734508163; x=1766044163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E63JxYB7LSkjK413CzHl2y+wDZA0LhAWLrrPvos+zMQ=;
  b=Zw1gW2eQt0FqnRwyvsZm8uoxzMVaUko0e8KdULpibL8w1xEY3q1W0UrN
   vNh/tVBDFJ5QpHWuU46+Iy/8L8ssts9mxB0Q8n0v+YA/UTHDs+58dqDzi
   nP7clTzYy++yAM/x8vkWaKw3rPgU+LZ1qD3/OPLt3VfzzPu4jAJaEATnI
   S5IkVJ3ZFLBLmVQxcclVtTjnEgMIeZQwOZXGVeZl7SIleUJyjnqRXgJ5K
   vE0JY8MybX/nin5fig7fqzhlKgNC1SANDpsK5KTD+7N1LsnL6Xt2pE1I2
   t3jiPXcs5axufUt0DQGGmm552GzmnwffCetSh+2LfUoXMdnZw+Ym6Tl1F
   w==;
X-CSE-ConnectionGUID: 9oUQgST1SEK5S1U1R6AIUQ==
X-CSE-MsgGUID: A9J25bNoSOmIzY0vvgrmqQ==
X-IronPort-AV: E=Sophos;i="6.12,244,1728921600"; 
   d="scan'208";a="35269662"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2024 15:49:16 +0800
IronPort-SDR: 67626fc6_VkM4yfR7yL/WM7WYd8V/6teSoY5PwMwBaLA9PEKt0+8AhBk
 kaA9NysePJTs/dUUH0NneYj6o+YWPC6riviob4Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2024 22:46:31 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Dec 2024 23:49:16 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH for-next 1/3] null_blk: do partial IO for bad blocks
Date: Wed, 18 Dec 2024 16:49:12 +0900
Message-ID: <20241218074914.814913-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241218074914.814913-1-shinichiro.kawasaki@wdc.com>
References: <20241218074914.814913-1-shinichiro.kawasaki@wdc.com>
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
index 7b674187c096..018a1a54dfa1 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1249,31 +1249,50 @@ static int null_transfer(struct nullb *nullb, struct page *page,
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
@@ -1300,11 +1319,21 @@ static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
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

