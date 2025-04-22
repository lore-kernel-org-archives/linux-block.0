Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137052561A6;
	Tue, 22 Apr 2025 02:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288222; cv=none; b=khcRiPtPS/UoSEL1BUxKYnvIfZd8fS1ROszfIH3wseBUJEE4ixDLzTr5icEve5Nv5jjfEc/hGJKrbNku+AlKZY92K0CyJ28ofmQvDOOaISFKVNIss/lxQcgS6UPd8icbb5hG9qUhHm4n4SZuEE6SqneMiV71lbBzXRGKPOS3rek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288222; c=relaxed/simple;
	bh=BKA1MVDM/vMZ2AYHLBeHtOtEbqYd2oJfJ3npMfZteUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E+TKXu3msRESIH43EBfg9kiTX92U3L1nFLLilW5Bnsou+fDLYUhn5I42hP3AIRuS7I+y/+3GHYAOknF7H+cexgOFdtZoXBobeaHcTWfKovDGCWBODtGAQcIM95waSyxX6ua/3eflZGAknUl+vOeoC736qF4o5M1CtUf7ZquZC1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8xWYilY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8xWYilY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FF6C4CEEE;
	Tue, 22 Apr 2025 02:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288221;
	bh=BKA1MVDM/vMZ2AYHLBeHtOtEbqYd2oJfJ3npMfZteUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D8xWYilY/Jj4uLDAc36nGaf8UBvOGhOVi3HW5x/KzGzQXaZAYBDdRjc0xwdMGA4Yl
	 xenYXuVo2JAADD8U9ppYhHcZrWVZeA9zzfp777LEqYwcU7kVh8o3MMcnuITm8NAAkG
	 2mDvmQROSI84fxw5edR8oHZRwToXal51+3oWjv7mpming85DQm1Lpvqzq/yv1iPY0q
	 EsHrfqlevqRXi6xV+g3G8+01A/f7PjSlp2X/BaVUNhxfeTutLJvzMOfbNBKpeqCYUZ
	 dUjxM0VtirISDLzikT7/hFYbCB0kAPqiTtNfTJXNMkxf9LLy33A9djLg0xb2lEN/aY
	 7yYlFwE0klVeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 29/30] ublk: rely on ->canceling for dealing with ublk_nosrv_dev_should_queue_io
Date: Mon, 21 Apr 2025 22:15:49 -0400
Message-Id: <20250422021550.1940809-29-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021550.1940809-1-sashal@kernel.org>
References: <20250422021550.1940809-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.3
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 7e26cb69c5e62152a6f05a2ae23605a983a8ef31 ]

Now ublk deals with ublk_nosrv_dev_should_queue_io() by keeping request
queue as quiesced. This way is fragile because queue quiesce crosses syscalls
or process contexts.

Switch to rely on ubq->canceling for dealing with
ublk_nosrv_dev_should_queue_io(), because it has been used for this purpose
during io_uring context exiting, and it can be reused before recovering too.
In ublk_queue_rq(), the request will be added to requeue list without
kicking off requeue in case of ubq->canceling, and finally requests added in
requeue list will be dispatched from either ublk_stop_dev() or
ublk_ctrl_end_recovery().

Meantime we have to move reset of ubq->canceling from ublk_ctrl_start_recovery()
to ublk_ctrl_end_recovery(), when IO handling can be recovered completely.

Then blk_mq_quiesce_queue() and blk_mq_unquiesce_queue() are always used
in same context.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Uday Shankar <ushankar@purestorage.com>
Link: https://lore.kernel.org/r/20250416035444.99569-4-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ublk_drv.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 611a4b2afbbf3..264b332a5faaf 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1629,13 +1629,19 @@ static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
 
 static void __ublk_quiesce_dev(struct ublk_device *ub)
 {
+	int i;
+
 	pr_devel("%s: quiesce ub: dev_id %d state %s\n",
 			__func__, ub->dev_info.dev_id,
 			ub->dev_info.state == UBLK_S_DEV_LIVE ?
 			"LIVE" : "QUIESCED");
 	blk_mq_quiesce_queue(ub->ub_disk->queue);
+	/* mark every queue as canceling */
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		ublk_get_queue(ub, i)->canceling = true;
 	ublk_wait_tagset_rqs_idle(ub);
 	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
+	blk_mq_unquiesce_queue(ub->ub_disk->queue);
 }
 
 static void ublk_force_abort_dev(struct ublk_device *ub)
@@ -2785,7 +2791,6 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
 	ubq->ubq_daemon = NULL;
 	ubq->timeout = false;
-	ubq->canceling = false;
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
@@ -2874,20 +2879,18 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
 			__func__, ublksrv_pid, header->dev_id);
 
-	if (ublk_nosrv_dev_should_queue_io(ub)) {
-		ub->dev_info.state = UBLK_S_DEV_LIVE;
-		blk_mq_unquiesce_queue(ub->ub_disk->queue);
-		pr_devel("%s: queue unquiesced, dev id %d.\n",
-				__func__, header->dev_id);
-		blk_mq_kick_requeue_list(ub->ub_disk->queue);
-	} else {
-		blk_mq_quiesce_queue(ub->ub_disk->queue);
-		ub->dev_info.state = UBLK_S_DEV_LIVE;
-		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-			ublk_get_queue(ub, i)->fail_io = false;
-		}
-		blk_mq_unquiesce_queue(ub->ub_disk->queue);
+	blk_mq_quiesce_queue(ub->ub_disk->queue);
+	ub->dev_info.state = UBLK_S_DEV_LIVE;
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		ubq->canceling = false;
+		ubq->fail_io = false;
 	}
+	blk_mq_unquiesce_queue(ub->ub_disk->queue);
+	pr_devel("%s: queue unquiesced, dev id %d.\n",
+			__func__, header->dev_id);
+	blk_mq_kick_requeue_list(ub->ub_disk->queue);
 
 	ret = 0;
  out_unlock:
-- 
2.39.5

