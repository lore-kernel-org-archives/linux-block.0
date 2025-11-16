Received: from sg-1-13.ptr.blmpb.com (sg-1-13.ptr.blmpb.com [118.26.132.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813D3224B05
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 02:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763260922; cv=none; b=uFg3suskFkoE0Dlscm9ilYCZThLqKo8UnGSRKcqMCZx9LkclU4aZFtLkwJOl81yiSTzTT9lgq42jS9mhMlTfD0hMxoZHbT7dpI/EAkTpWITwHmR3JZIz9MqDf1101xRdAOTRXdTtBsoxsnmK68nc7fdm/YKejYlYxqqJMMDcGOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763260922; c=relaxed/simple;
	bh=HLjPqFaoHIFiWPXiwwXVxhO02rNyp3qzfkPNjGwUDxI=;
	h=Mime-Version:Subject:Content-Type:To:Message-Id:Cc:From:Date; b=f1tS2cxyKP2JsmlX42m+dC/481PXsIJwXKRI5CqNf2KYzob8c9qVLOkQ/UC31kSw8wQeFtU9GSzKwjCYxJ8vHgjPHEOQz+3NGuvHFcyFEdCCaaDFNj3zZO5bCCM1oZnvPIWuhEY6iMEluD+xiJ+B1GxLnD/EmJrjGCNefEmhwcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=LPI7MpHf; arc=none smtp.client-ip=118.26.132.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="LPI7MpHf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763260915;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Y6zcxxSDkCGi74MCT9K0qutBP57MyuiyeywsRqy1TGU=;
 b=LPI7MpHfR5IbkAJBmJr6pxCai8iPQXK/yNslOs7uSoSuEcvX7qGvQBOV7TrZ56x9jkmOo3
 t5Ct9Umun/7k8H31wV1c7Yaju+Sw/91q4upTANpA4goY6yYyphhuA+YVwBPS3yKOvf0dIy
 mQXQ88/wShqED3Ap46Peb7hSXmwQzRo2DHtGjWFdgscSm+FoEE/3JDZeLXXngQBzOsy0oi
 R1iRz0eFb/zH36iuzBBIUz/h3z4VfV0vXJw8tBPmDT99/5Kqj8UXdwGpwzhQDg7GkPVzyO
 MxucXODtumr4j1OpSlNR08tLdryWtghDHk955lj/O8ZE2xL69QrvzUnjYtoAjA==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3/5] blk-iocost: fix incorrect lock order for rq_qos_mutex and freeze queue
Received: from localhost.localdomain ([39.182.0.135]) by smtp.feishu.cn with ESMTPS; Sun, 16 Nov 2025 10:41:52 +0800
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <tj@kernel.org>, <nilay@linux.ibm.com>, 
	<ming.lei@redhat.com>
Message-Id: <20251116024134.115685-4-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Cc: <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Sun, 16 Nov 2025 10:41:32 +0800
X-Lms-Return-Path: <lba+2691939f1+65929b+vger.kernel.org+yukuai@fnnas.com>

Like wbt, rq_qos_add() can be called from two path and the lock order
are inversely:

- From ioc_qos_write(), queue is already freezed before rq_qos_add();
- From ioc_cost_model_write(), rq_qos_add() is called directly;

Fix this problem by converting to use blkg_conf_open_bdev_frozen()
from ioc_cost_model_write(), then since all rq_qos_add() callers
already freeze queue, convert to use rq_qos_add_freezed().

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-iocost.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 5bfd70311359..233c9749bfc9 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2927,7 +2927,7 @@ static int blk_iocost_init(struct gendisk *disk)
 	 * called before policy activation completion, can't assume that the
 	 * target bio has an iocg associated and need to test for NULL iocg.
 	 */
-	ret = rq_qos_add(&ioc->rqos, disk, RQ_QOS_COST, &ioc_rqos_ops);
+	ret = rq_qos_add_freezed(&ioc->rqos, disk, RQ_QOS_COST, &ioc_rqos_ops);
 	if (ret)
 		goto err_free_ioc;
 
@@ -3410,7 +3410,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 {
 	struct blkg_conf_ctx ctx;
 	struct request_queue *q;
-	unsigned int memflags;
+	unsigned long memflags;
 	struct ioc *ioc;
 	u64 u[NR_I_LCOEFS];
 	bool user;
@@ -3419,9 +3419,11 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 
 	blkg_conf_init(&ctx, input);
 
-	ret = blkg_conf_open_bdev(&ctx);
-	if (ret)
+	memflags = blkg_conf_open_bdev_frozen(&ctx);
+	if (IS_ERR_VALUE(memflags)) {
+		ret = memflags;
 		goto err;
+	}
 
 	body = ctx.body;
 	q = bdev_get_queue(ctx.bdev);
@@ -3438,7 +3440,6 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 		ioc = q_to_ioc(q);
 	}
 
-	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	spin_lock_irq(&ioc->lock);
@@ -3490,20 +3491,18 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	spin_unlock_irq(&ioc->lock);
 
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q, memflags);
 
-	blkg_conf_exit(&ctx);
+	blkg_conf_exit_frozen(&ctx, memflags);
 	return nbytes;
 
 einval:
 	spin_unlock_irq(&ioc->lock);
 
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q, memflags);
 
 	ret = -EINVAL;
 err:
-	blkg_conf_exit(&ctx);
+	blkg_conf_exit_frozen(&ctx, memflags);
 	return ret;
 }
 
-- 
2.51.0
