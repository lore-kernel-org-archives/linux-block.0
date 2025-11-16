Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254A019F12D;
	Sun, 16 Nov 2025 04:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763266236; cv=none; b=S2DRjr53oj6TWOqjFEov/cwdswzruzmuQBAeASbX+J+uju6dehAM0ZueZgILzYl7XRxrWor4P2qn1BVsL06CVawiuLyJhCj8Oi7tKSUdeECf1Xyf06Tmr9qndhpwf1lOKo8tQl2L2tArEhfrGdxFKCv2LRzY/lYvb5/hWmXNxXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763266236; c=relaxed/simple;
	bh=ku3xI7O8F0GyJHOuAdN7mtEFMz7g8bN7QjLzf1OGAMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6HPPJRhl/gkkCGfVmHYooViMpo5589q9X46vSu/eTH+EJ2Lm4jCpBJjp1Y75ah34unNhg3vKN+IhOr8PcRbScaYCWiBEPr0EJyfsujFkKhljMn48/+Yq33QlexqV36w1jvKT8znFlT7SJcOyP2gOIyQzfBRzBtRwp7FauzGTS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C338C4CEF5;
	Sun, 16 Nov 2025 04:10:34 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH RESEND 3/5] blk-iocost: fix incorrect lock order for rq_qos_mutex and freeze queue
Date: Sun, 16 Nov 2025 12:10:22 +0800
Message-ID: <20251116041024.120500-4-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251116041024.120500-1-yukuai@fnnas.com>
References: <20251116041024.120500-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like wbt, rq_qos_add() can be called from two path and the lock order
are inversely:

- From ioc_qos_write(), queue is already freezed before rq_qos_add();
- From ioc_cost_model_write(), rq_qos_add() is called directly;

Fix this problem by converting to use blkg_conf_open_bdev_frozen()
from ioc_cost_model_write(), then since all rq_qos_add() callers
already freeze queue, convert to use rq_qos_add_freezed.

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

