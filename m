Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5D314A9F
	for <linux-block@vger.kernel.org>; Thu, 25 Dec 2025 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766658805; cv=none; b=SwB8X0+5IHv5fbZ+Vqddy/wpOgeOp0YsWLGW9jd8IUh4I4qi0Y6TsysCLjAK6hMV/Kf1fiu1PebodxnenxwpjRG66dHd5Jf5aHOnEozq9BpNYe3oI2l+QXe0ttuuoSXPCASsm+DZjtvT8IG2XLkY7uaT2gyh2q5DekvG8mpSdUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766658805; c=relaxed/simple;
	bh=aALcnFiv6Fjca+jZT8V6grxwx72IP2VsYuqidEf/+5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9kRTcCOuTlyENEkQffwwdSVx5dGsG54g/5CnFeSWwKccZVqpDEWZ/EzH1Yjqw+mSKXp7jCCw91SI3y7/fV2Z5vg5Cg+pw4QHrciJu7+Ccb/fhSM+J+VwbFg5xONJsgB2GlvaRE+W9g2R+CJo3G+aJCYZWp3Kb1p8PVXCpZN38g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE0AC116C6;
	Thu, 25 Dec 2025 10:33:20 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v6 11/13] blk-iocost: fix incorrect lock order for rq_qos_mutex and freeze queue
Date: Thu, 25 Dec 2025 18:32:46 +0800
Message-ID: <20251225103248.1303397-12-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251225103248.1303397-1-yukuai@fnnas.com>
References: <20251225103248.1303397-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like wbt, rq_qos_add() can be called from two path and the lock order
are inversely:

- From ioc_qos_write(), queue is already frozen before rq_qos_add();
- From ioc_cost_model_write(), rq_qos_add() is called directly;

Fix this problem by converting to use blkg_conf_open_bdev_frozen()
from ioc_cost_model_write(), then since all rq_qos_add() callers
already freeze queue, convert to use rq_qos_add_frozen().

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-iocost.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index a0416927d33d..929fc1421d7e 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2925,7 +2925,7 @@ static int blk_iocost_init(struct gendisk *disk)
 	 * called before policy activation completion, can't assume that the
 	 * target bio has an iocg associated and need to test for NULL iocg.
 	 */
-	ret = rq_qos_add(&ioc->rqos, disk, RQ_QOS_COST, &ioc_rqos_ops);
+	ret = rq_qos_add_frozen(&ioc->rqos, disk, RQ_QOS_COST, &ioc_rqos_ops);
 	if (ret)
 		goto err_free_ioc;
 
@@ -3408,7 +3408,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 {
 	struct blkg_conf_ctx ctx;
 	struct request_queue *q;
-	unsigned int memflags;
+	unsigned long memflags;
 	struct ioc *ioc;
 	u64 u[NR_I_LCOEFS];
 	bool user;
@@ -3417,9 +3417,11 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 
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
@@ -3436,7 +3438,6 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 		ioc = q_to_ioc(q);
 	}
 
-	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	spin_lock_irq(&ioc->lock);
@@ -3488,20 +3489,18 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
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

