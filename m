Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47496299AAB
	for <linux-block@vger.kernel.org>; Sun, 14 Dec 2025 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765707277; cv=none; b=utnNtvMXdxeAn/KTDntgFkXR9WctpcPqvX1t2/0ylqKXbfbb4DRMls3Ln1iEDJUiZs2eKxZo0FVDELg3AxhG4U4g41StpoGAA5QpebhlsuybVSVPPVVk0Bw7a5QVwDm/QwIGeCYjD6pVtx1uDXtH2IH5/izKRucwYqWhwq9Bad4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765707277; c=relaxed/simple;
	bh=9OXNx8y2Qn7Uo4/ysL/75jlvXaGzY6XbNk4pGLgZdGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbetX2I6297I/+E9Au10NNiSgObTGxDnTagV+bDLk67Fil+N50mVb/VIS204kc08IqDMjuHt9BL/JMEokncj0mTcXPBb7kgwFQVbw4QNXBstl1NkfKdDLYdCYfCjRBnidVnMFWVkXJVkl/z1+8GMIrvaM5iF8Nrk1mqckMQNAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57541C4CEF1;
	Sun, 14 Dec 2025 10:14:35 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v5 09/13] blk-wbt: fix incorrect lock order for rq_qos_mutex and freeze queue
Date: Sun, 14 Dec 2025 18:14:04 +0800
Message-ID: <20251214101409.1723751-10-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251214101409.1723751-1-yukuai@fnnas.com>
References: <20251214101409.1723751-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wbt_init() can be called from sysfs attribute and wbt_enable_default(),
however the lock order are inversely.

- queue_wb_lat_store() freeze queue first, and then wbt_init() hold
  rq_qos_mutex. In this case queue will be frozen again inside
  rq_qos_add(), however, in this case freeze queue recursively is
  inoperative;
- wbt_enable_default() from elevator switch will hold rq_qos_mutex
  first, and then rq_qos_add() will freeze queue;

Fix this problem by converting to use new helper rq_qos_add_frozen() in
wbt_init(), and for wbt_enable_default(), freeze queue before calling
wbt_init().

Fixes: a13bd91be223 ("block/rq_qos: protect rq_qos apis with a new lock")
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-wbt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 4bf6f42bef2e..d852317c9cb1 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -19,6 +19,7 @@
  * Copyright (C) 2016 Jens Axboe
  *
  */
+#include "linux/blk-mq.h"
 #include <linux/kernel.h>
 #include <linux/blk_types.h>
 #include <linux/slab.h>
@@ -763,14 +764,18 @@ void wbt_enable_default(struct gendisk *disk)
 
 	if (queue_is_mq(q) && enable) {
 		struct rq_wb *rwb = wbt_alloc();
+		unsigned int memflags;
 
 		if (WARN_ON_ONCE(!rwb))
 			return;
 
+		memflags = blk_mq_freeze_queue(q);
 		if (WARN_ON_ONCE(wbt_init(disk, rwb))) {
+			blk_mq_unfreeze_queue(q, memflags);
 			wbt_free(rwb);
 			return;
 		}
+		blk_mq_unfreeze_queue(q, memflags);
 
 		mutex_lock(&q->debugfs_mutex);
 		blk_mq_debugfs_register_rq_qos(q);
@@ -947,7 +952,7 @@ static int wbt_init(struct gendisk *disk, struct rq_wb *rwb)
 	 * Assign rwb and add the stats callback.
 	 */
 	mutex_lock(&q->rq_qos_mutex);
-	ret = rq_qos_add(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
+	ret = rq_qos_add_frozen(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
 	mutex_unlock(&q->rq_qos_mutex);
 	if (ret)
 		return ret;
-- 
2.51.0

