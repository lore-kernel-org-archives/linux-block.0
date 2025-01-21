Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8D51B4156
	for <linux-block@vger.kernel.org>; Tue, 21 Jan 2025 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737447329; cv=none; b=H10eBF9xT6HhdSXJfQSVKe+bPH0x/aZ7sRI4oKyRkVVv07kah3uKzlO6+dNzoYeg00KnRAGGNSGm+l0GVEfQaniCIRUiwB5GfAOlQKvs8mVddtI8zdt4JtT3nEJIDXMbPJyAHp4viaacmKoGWpp3oBBSMHBJT3AoAC0x5CPACYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737447329; c=relaxed/simple;
	bh=RarQCw0Q/MlT/SjTk/J/KIrVuLDkJ91fM5OsKJ2AiRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOrfejW+tL2XbVPOGDev8q6dlJkcWuCFO24o9fhcpOS3G8m+9yGX6kLMYK7Ybxaw5BMfSMgGRS7oHAKmjbe4lRreYdsKGQD6npidrVVO9lOTllK/d9B4pHWYnTA5S0cvE5gXB7kizDhew6DQJ5qUemyy4hsAVd28emQW2MkQgIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eGchEs3n; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eGchEs3n"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737447328; x=1768983328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RarQCw0Q/MlT/SjTk/J/KIrVuLDkJ91fM5OsKJ2AiRk=;
  b=eGchEs3nW0r7jBneXKZthCcIwOGHO/HZDfJh5IxdhHE3Z6wYf5jvpFDc
   whA6ungLkD6zpEcTrd4Y8DTj/xrdlP9QAlzYpaIWIDrAFkh6/CFPSq+eE
   US14ko+DyTev8TkwKm2x10x5nXieK53X9HIFz24gv3q1syCgamPIG/iv1
   RnJxazsml1I7eFJMOotSkyqOjEaVpEES6n2/WD9JRE/cXEyG+m47Np2Lv
   kONow00QlPMaxPQUevFEzCHH5KEYidwnfbpFLi+QU3P3j+Bt3fs5+FpH6
   NUk+9pGt2Bam7ZaFB+aVGEOPrZ0fAKhH2c1gucYi73fc+xM3Gj8Fn2GFE
   Q==;
X-CSE-ConnectionGUID: qe0dpo4HQGmvWefALMCxUA==
X-CSE-MsgGUID: wOTOJ8ToReaNKyHY271t5w==
X-IronPort-AV: E=Sophos;i="6.13,221,1732550400"; 
   d="scan'208";a="36182076"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2025 16:15:23 +0800
IronPort-SDR: 678f4a06_pnnUR6FvKru/rjqkJPCSiGM7VvwL6IkMPMeyZb0vPevWvrl
 gsDgP+rWUo1KF+0JhIRAAfodA/FUc0OevxWdXnA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jan 2025 23:17:26 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Jan 2025 00:15:22 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH for-next v4 4/5] null_blk: pass transfer size to null_handle_rq()
Date: Tue, 21 Jan 2025 17:15:16 +0900
Message-ID: <20250121081517.1212575-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250121081517.1212575-1-shinichiro.kawasaki@wdc.com>
References: <20250121081517.1212575-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As preparation to support partial data transfer, add a new argument to
null_handle_rq() to pass the number of sectors to transfer. While at it,
rename the function from null_handle_rq to null_handle_data_transfer.
This commit does not change the behavior.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/block/null_blk/main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 87037cb375c9..802576698812 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1263,25 +1263,37 @@ static int null_transfer(struct nullb *nullb, struct page *page,
 	return err;
 }
 
-static blk_status_t null_handle_rq(struct nullb_cmd *cmd)
+/*
+ * Transfer data for the given request. The transfer size is capped with the
+ * nr_sectors argument.
+ */
+static blk_status_t null_handle_data_transfer(struct nullb_cmd *cmd,
+					      sector_t nr_sectors)
 {
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
 	struct nullb *nullb = cmd->nq->dev->nullb;
 	int err = 0;
 	unsigned int len;
 	sector_t sector = blk_rq_pos(rq);
+	unsigned int max_bytes = nr_sectors << SECTOR_SHIFT;
+	unsigned int transferred_bytes = 0;
 	struct req_iterator iter;
 	struct bio_vec bvec;
 
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
 
@@ -1333,7 +1345,7 @@ blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd, enum req_op op,
 	if (op == REQ_OP_DISCARD)
 		return null_handle_discard(dev, sector, nr_sectors);
 
-	return null_handle_rq(cmd);
+	return null_handle_data_transfer(cmd, nr_sectors);
 }
 
 static void nullb_zero_read_cmd_buffer(struct nullb_cmd *cmd)
-- 
2.47.0

