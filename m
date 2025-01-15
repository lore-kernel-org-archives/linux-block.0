Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E33B22DF94
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 04:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736915358; cv=none; b=C449BqPksnfvufqB2VdGOj0Y4jxV21m4XiPDWukAVr1Fe+7kXm/YlPtmNZzl7AYzW2M2+FHIcsgwJQTErbTKbFu25ol7vjRVO2YUekCQzO/w5mtB5gJt0swmScGFYQhp2M6FTYl0RTOCiiv4IMYz3PT//U4wfRSuBx//JM0l2P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736915358; c=relaxed/simple;
	bh=8aFKwrbP5VKYUeHE0gnURUQeSbFYrv1bomTi9GpNmO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxJw0n1p9JYJgOi8IJjCDoU8B9UN4gGMdMAJKQNDpjguBYYfaeoEBNBLkgSCwhVwufrei1e31Ny0sofcHGs8VpDm2x7xXdxQUz0tNsl+fA7o+rigK5oP6+GpYZJNur1lcr6lvRX07YhBH92CYKTMMekJWfEjRTJyjoK5YmnhUdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=h/k9oSzT; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h/k9oSzT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736915357; x=1768451357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8aFKwrbP5VKYUeHE0gnURUQeSbFYrv1bomTi9GpNmO8=;
  b=h/k9oSzT4w5gVjz9K2F7Vpj+JoVwLidBbOK6u9Nq88MwyBkwQuMnSHTt
   OdqErSuewAIKM1rpPCVusOGzmZ4on5QyKtg8W7j48cdBLYtn+t1s8e26s
   l6CHqEyugBX0UutnnLBz7FrCmhxmoWvIVNEbfunb3MB9XER0TqVHQPFL8
   k9/8IQF6X9kO2nrb8ovTz3IF/Q+wufoz/WLus/1yElro/Qkg4NA+QHU3Q
   zlJq+UYHakxNWP4wmnPPQiu1t2Et+m3AoPOOJIRGQm5p1Xlf/23aEYKYb
   o4cFEjAjpG3BaEsP4t3vUXYBSfgur2D9W6ApSI//niuulYBWRTtODEiPU
   Q==;
X-CSE-ConnectionGUID: p+IocXt4QgWAdUnfqXDN9g==
X-CSE-MsgGUID: vgcx3g3ZSRqTF0hCTBNC0w==
X-IronPort-AV: E=Sophos;i="6.12,316,1728921600"; 
   d="scan'208";a="35958017"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2025 12:29:17 +0800
IronPort-SDR: 67872ac4_vVVt+sqI+JKYe5B9i8u8+AD3+3KK8d60GxK3g1KOe+2iWw0
 RSRH3UDprg6UJOFGp2VpNwhnss8d11BKFOOjdIQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jan 2025 19:25:57 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Jan 2025 20:29:15 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH for-next v3 4/5] null_blk: pass transfer size to null_handle_rq()
Date: Wed, 15 Jan 2025 13:29:09 +0900
Message-ID: <20250115042910.1149966-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250115042910.1149966-1-shinichiro.kawasaki@wdc.com>
References: <20250115042910.1149966-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As preparation to support partial data transfer, add a new argument to
null_handle_rq() to pass the number of sectors to transfer. This commit
does not change the behavior.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/block/null_blk/main.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 87037cb375c9..71c86775354e 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1263,25 +1263,36 @@ static int null_transfer(struct nullb *nullb, struct page *page,
 	return err;
 }
 
-static blk_status_t null_handle_rq(struct nullb_cmd *cmd)
+/*
+ * Transfer data for the given request. The transfer size is capped with the
+ * nr_sectors argument.
+ */
+static blk_status_t null_handle_rq(struct nullb_cmd *cmd, sector_t nr_sectors)
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
 
@@ -1333,7 +1344,7 @@ blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd, enum req_op op,
 	if (op == REQ_OP_DISCARD)
 		return null_handle_discard(dev, sector, nr_sectors);
 
-	return null_handle_rq(cmd);
+	return null_handle_rq(cmd, nr_sectors);
 }
 
 static void nullb_zero_read_cmd_buffer(struct nullb_cmd *cmd)
-- 
2.47.0

