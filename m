Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACAA2459F2
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564383; cv=none; b=Bxu8UgRs93IHw+dwGy93y/evHiRFkfLr8gpt7B9zuwrazV3waaKH3EEJwHUlOuklHzwqjrlvNdsgsp7SBpWC51L23HKtC4ojClZxTycSgySv7xv+YVbHxErECsqAb9D1xZGog+bWKpv3IAFGbjnULfgyHcTw3szYtuHLt8CoPO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564383; c=relaxed/simple;
	bh=2E71PjPgI7Q7GwU+02XdDOnGYleQKImVpRoWjiwHArs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMBOzWW9akXNaIibMvsKLEK7M2fbP1nG9EwXZOxastKmCwQxffVx/xsJzGyWKyxVweU+qu9VT9B3ShvtfWq7ZNNQu/m4IzhrZeGuvdbRZi3m9fGd2OcCHBYd5ZB1223fnQUUybPJNbdtvWadSZZDBxTyC/RkU4dYPHNQKqxfNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nQSyeimW; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nQSyeimW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740564381; x=1772100381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2E71PjPgI7Q7GwU+02XdDOnGYleQKImVpRoWjiwHArs=;
  b=nQSyeimWmQfUdZ66CVsYn/ZMFbID3l6NfIeXsVXlN6Osi/MNenx0SIjp
   pbwpTV5/wV1HhdFszz7cE8ojgrj2tUjCaYJTZF8ZPRqIVhBmajpMWeMyo
   eCnP9o6CEhfDvl0XprA+c57kOglen0iZgxw40rp/5ACx8KvAJMu8u0nMb
   2VSrvG+MFh4WGMiopFPqElSi5kVbPRq9pTk22giXI02w0PtD/MQnzbGBq
   JIlUIEYu3S+q71zmSIHqPz6eLg/kOXRnVwKOf+QhjLQBzbHiLC9pDHCNl
   v8LSqSZi281fa5whJkdWN+rw1mI9XFTQvGAQCPuBjA7ccco9FJOVpa6Sw
   A==;
X-CSE-ConnectionGUID: +bY6cJQ7TOS3k7NKG+Hekg==
X-CSE-MsgGUID: qRLf/mRcT66c9kznUzcasQ==
X-IronPort-AV: E=Sophos;i="6.13,316,1732550400"; 
   d="scan'208";a="39484529"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2025 18:06:20 +0800
IronPort-SDR: 67bed9d8_OG193xk9xxujhPlw6YYQdKHm6wWJG/bR5R3w4copAyRm/UT
 1et7VKjul4+J8TSxjN1kY3Xri3RKeqV4Kf3LRiQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2025 01:07:37 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Feb 2025 02:06:20 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH for-next v7 4/5] null_blk: pass transfer size to null_handle_rq()
Date: Wed, 26 Feb 2025 19:06:12 +0900
Message-ID: <20250226100613.1622564-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250226100613.1622564-1-shinichiro.kawasaki@wdc.com>
References: <20250226100613.1622564-1-shinichiro.kawasaki@wdc.com>
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

