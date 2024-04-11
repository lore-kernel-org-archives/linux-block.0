Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108F81422CE
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825705; cv=none; b=pzNOcPeD9RQvP3e9hzd7pjPIdCr+V6OPgl1jqTqadmu3UzNp6NINmmwgHzMEnlmOshdeWTGmrWRy6b0xTFOFgF6j6mjQbTVmCRMcRnKdfpoegWZzwQasGWMs5KV9KSJoFjI6nLI0LuSQMGJaWSw8Kaq/dK65hTgEFSCC2LlDUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825705; c=relaxed/simple;
	bh=9efiNOT7ZhWP5YBASYmyeHI+5iESX+KwyeEBLoywJZQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2Fd3QHuUNpCouXG9p4ABxBBkRraSlM0SeDBcBeZ2epth4aRovCvqdZbWhajb+Kqd3ZLKyE5+ol54Qs/S/W0Bj6bfTBejDbk1lnqWBhpcxmXodzZx1Y5km8YfWxOYbfay1Z1CQffy+PeHyOZtHe4cgNtQYO5UpJ+8aQI8yZh68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqhWeZBY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqhWeZBY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D245C43390;
	Thu, 11 Apr 2024 08:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712825704;
	bh=9efiNOT7ZhWP5YBASYmyeHI+5iESX+KwyeEBLoywJZQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FqhWeZBYG8l7qCXQdYN4gFp7qwjwMPWVqJF9jbNuXxZ9bBkd9niq02iMOIEUlTfbb
	 rKU3pTAj4z0NlLflBbv/xyBITt2pc/SZDvxJBnVVIaIS3geRGIbBlzRw173g3SWyZV
	 Zc48ER0exVM0i6CcJC9N4rsnHkWy3Vyi060UCR2UuzlkJ4gRHsBVdHgOJ+UV5cn5yk
	 3GsK1EEhhwO+K0U9U3vr4hqKksb6qKukeuja3y4Y+y4m8Yzgb8QGmzIPfguxuC+eVt
	 v4s00xkl8DTbeESezorQoo+B42pK/iyJw5JTyTi1TJwjGEgDKbHlFHX1uEEugPnr3d
	 zZGXtRsEtdydg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/3] null_blk: Have all null_handle_xxx() return a blk_status_t
Date: Thu, 11 Apr 2024 17:55:00 +0900
Message-ID: <20240411085502.728558-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411085502.728558-1-dlemoal@kernel.org>
References: <20240411085502.728558-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the null_handle_flush() and null_handle_rq() functions to return
a blk_status_t instead of an errno to simplify the call sites of these
functions and to be consistant with other null_handle_xxx() functions.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/main.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 993e9e8a7e69..4c8089a47850 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1167,7 +1167,7 @@ blk_status_t null_handle_discard(struct nullb_device *dev,
 	return BLK_STS_OK;
 }
 
-static int null_handle_flush(struct nullb *nullb)
+static blk_status_t null_handle_flush(struct nullb *nullb)
 {
 	int err;
 
@@ -1184,7 +1184,7 @@ static int null_handle_flush(struct nullb *nullb)
 
 	WARN_ON(!radix_tree_empty(&nullb->dev->cache));
 	spin_unlock_irq(&nullb->lock);
-	return err;
+	return errno_to_blk_status(err);
 }
 
 static int null_transfer(struct nullb *nullb, struct page *page,
@@ -1222,7 +1222,7 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 {
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
 	struct nullb *nullb = cmd->nq->dev->nullb;
-	int err;
+	int err = 0;
 	unsigned int len;
 	sector_t sector = blk_rq_pos(rq);
 	struct req_iterator iter;
@@ -1234,15 +1234,13 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
 				     op_is_write(req_op(rq)), sector,
 				     rq->cmd_flags & REQ_FUA);
-		if (err) {
-			spin_unlock_irq(&nullb->lock);
-			return err;
-		}
+		if (err)
+			break;
 		sector += len >> SECTOR_SHIFT;
 	}
 	spin_unlock_irq(&nullb->lock);
 
-	return 0;
+	return errno_to_blk_status(err);
 }
 
 static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
@@ -1289,8 +1287,8 @@ static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
 
 	if (op == REQ_OP_DISCARD)
 		return null_handle_discard(dev, sector, nr_sectors);
-	return errno_to_blk_status(null_handle_rq(cmd));
 
+	return null_handle_rq(cmd);
 }
 
 static void nullb_zero_read_cmd_buffer(struct nullb_cmd *cmd)
@@ -1359,7 +1357,7 @@ static void null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 	blk_status_t sts;
 
 	if (op == REQ_OP_FLUSH) {
-		cmd->error = errno_to_blk_status(null_handle_flush(nullb));
+		cmd->error = null_handle_flush(nullb);
 		goto out;
 	}
 
-- 
2.44.0

