Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1171E9917
	for <linux-block@vger.kernel.org>; Sat, 25 Jan 2025 01:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768556; cv=none; b=ToRNVdjE6EwjIMJMRlTQ68waPT6cBLoImqffj7r0tQhZ87X+aRiDvc0Y+YRjretfKUhJU7+4YH/ZWFQ30F1yP8FUa4T5c4bQPhtO53bP52Xus1zJDOnN0hlKFSu3CTro1JAydyFR8tRcPL1jAOTzufZS+DFvG4OglRG9Q1T+5AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768556; c=relaxed/simple;
	bh=jC2+DpbTafKWxG2bzE12PTGD3SAM47DFkXad3Ai9r5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRcXP4NzfFShVmsYmjsdzU5g4gxJzvdMf+KiDUTRGA+J9zj9dRMdEXw6BmoVqhJZeafGuxU31JuItKxK9yuHxZsnJUnBm+olqdDhPgtHdRY3PlRFe9uHjdIdiWZCvkGA4sHmCD8sgmAGm+I/I4zu8RedcJrCSAG3t8ZeEsaEzLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=THjyMMp6; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="THjyMMp6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737768554; x=1769304554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jC2+DpbTafKWxG2bzE12PTGD3SAM47DFkXad3Ai9r5g=;
  b=THjyMMp6Kfu/Qdq/7AeTgl4lbaP5YvVi6m6YOh02xM4Ir9lgQIpp7qqz
   wV/PbGl8jk2iQ/sNDJobtNGOO7eNMQKYezCvLaknCubDFbxdQrt33262o
   X/M/BnSa+GDlGHlur5HiqtAxvd/u9LjKQswBFnxXatFS4izuMbT7n1L0i
   gIW1BoRC5RAzEvfwm0BcFgqVHVXUhZVXe3+hg39Dt8/JH9PK45fO4ztK6
   iYe82vK81NhAH3RX+MSbn6BHF2nAWpRTKwhZ1ovWG/cCLjWeXmD4oasGZ
   w7706ixPJZnRAnFoAXglM+HWt3kCCmG42v97sSUJd/AiNWzagPecDkVlF
   Q==;
X-CSE-ConnectionGUID: oqYNTziJSOOfmBWQUrVVAQ==
X-CSE-MsgGUID: lDWy8bNKSwWV/QP4W4Dhag==
X-IronPort-AV: E=Sophos;i="6.13,232,1732550400"; 
   d="scan'208";a="37973938"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2025 09:29:14 +0800
IronPort-SDR: 679430cf_qTAcYBHnT+heo2KRiEXBmIZ2LZEKTesvFQ0wJUZkUWgbt4r
 q3cbH3kaaaM0SggQWNOWmEbqo/ZdCNoK3rgogIg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2025 16:31:12 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Jan 2025 17:29:13 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v5 4/5] null_blk: pass transfer size to null_handle_rq()
Date: Sat, 25 Jan 2025 10:29:07 +0900
Message-ID: <20250125012908.1259887-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250125012908.1259887-1-shinichiro.kawasaki@wdc.com>
References: <20250125012908.1259887-1-shinichiro.kawasaki@wdc.com>
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
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
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

