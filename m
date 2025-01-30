Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887A51AF0CD
	for <linux-block@vger.kernel.org>; Thu, 30 Jan 2025 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738225636; cv=none; b=DvO7SWeXZyK1+kqyi1/bHX4p780sjYnJibrGXFMupSExj4ZQE7QOS3mI9vNwZ4ORI88Cr7rPeMQ1hX5ZnMB+MCD5rt6faxuAPYJhCelGxjCn60WRSG1LpK3GHCm5Qem/jTG+9Vu/NhcVTVsxe2D274fokBfUzl7s/VQY4u97WOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738225636; c=relaxed/simple;
	bh=2E71PjPgI7Q7GwU+02XdDOnGYleQKImVpRoWjiwHArs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYCNLfA8iX198Tq9fDqky5N9tAxD/CbRZ//ibVmqKHofaC3QhCRTjRUvIdAFYZ6/cA7MTbt5R/PwOuMuuyz8Zjaq7LZ7EyAb+0EKg6W2s725nC6IzikpmKu21BxiUkBxqxCskeJbmD3J6OvjfwRZcpDmjWl+hsbAQQOD3SUwtH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cEJNllFx; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cEJNllFx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738225634; x=1769761634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2E71PjPgI7Q7GwU+02XdDOnGYleQKImVpRoWjiwHArs=;
  b=cEJNllFx9fUovzv74hRl9fUYiFlQTAwgbI0EyR+NtmZj1k2cxO0Ncm9D
   G0I/5h2wjKjXpSfp7N3iBpS8qnXwtEVEVpj8iZ98SfVyXpUeILJoPPou9
   wtxCFuuQ4bm9vm1hJlQjlwuQP/iyFduL2PbqHMZzgp14LeXCHRVBdshuZ
   DKDBOg0UgIZMX0KimnLl07rPI/02CbfCep+KPKVJKFYyazMSxPF0cuJyq
   bQjZH1/qeSV+QTgnJ3/yHTiGNwixsLLoooYkpCD2TkcoJyBAzNg1hCmdk
   00QnqHAiDcmTQAhlMlh+h0k364Im7eb2bItYxtt5x97olLw5JTPo1AiUu
   w==;
X-CSE-ConnectionGUID: e5TFarNAT9q9YOu/udAVQQ==
X-CSE-MsgGUID: rpJq3Hn+Rx6n2hE+Ji0UZQ==
X-IronPort-AV: E=Sophos;i="6.13,244,1732550400"; 
   d="scan'208";a="38377849"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2025 16:27:10 +0800
IronPort-SDR: 679b2a3d_zmuaSJtVIZRAcS6GHBde+nywXA3itPsZcJy8+nNrb0ljoEL
 mJwFFhwjq49dHNW0QMq940j+f7S+TlHj0ruZuQw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2025 23:29:02 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jan 2025 00:27:10 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v6 4/5] null_blk: pass transfer size to null_handle_rq()
Date: Thu, 30 Jan 2025 17:27:02 +0900
Message-ID: <20250130082703.1330857-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250130082703.1330857-1-shinichiro.kawasaki@wdc.com>
References: <20250130082703.1330857-1-shinichiro.kawasaki@wdc.com>
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

