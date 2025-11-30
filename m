Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D542367DF
	for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 02:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764470647; cv=none; b=ib6iG9oGMECMfNwoYvvCONcu4ThM80jJzxeOPGLBdS4i/vCDO0ymfhVjMKZ+Sf++VbgOVypR/pBGUMDjKjlHSDfgnNcbDmPav3rTYzvhBq59XAoKGt7dtRQ0IDp3CLa1mx+j1JCbDdrcyuW+qeTk5yQcBni1agu2roKyW8nCWJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764470647; c=relaxed/simple;
	bh=c3aLZjvDp6l3olq8KrGp4TqLW3JuGKAI7BwQXlM8CyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNmH5U9ausAedbSVISnrk3SRpxWEKplhLX2xWu00h4dmk5qBbv1nAYOK9qPd940acqwshNoc1YUQcGC3GgaiOvXrZCE9Mke1GdlQk959tWCx8M4wCs8NWAgjpWg+Ph6/SS7DhVxhb3/XgEjmrKDrY3skMrkNi3/liQaxDmisXnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E422C113D0;
	Sun, 30 Nov 2025 02:44:05 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	bvanassche@acm.org
Cc: yukuai@fnnas.com
Subject: [PATCH v3 06/10] blk-wbt: fix incorrect lock order for rq_qos_mutex and freeze queue
Date: Sun, 30 Nov 2025 10:43:45 +0800
Message-ID: <20251130024349.2302128-7-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251130024349.2302128-1-yukuai@fnnas.com>
References: <20251130024349.2302128-1-yukuai@fnnas.com>
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
 block/blk-wbt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index b1ab0f297f24..5e7e481103a1 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -725,7 +725,11 @@ void wbt_enable_default(struct gendisk *disk)
 		return;
 
 	if (queue_is_mq(q) && enable) {
+		unsigned int memflags = blk_mq_freeze_queue(q);
+
 		wbt_init(disk);
+		blk_mq_unfreeze_queue(q, memflags);
+
 		mutex_lock(&q->debugfs_mutex);
 		blk_mq_debugfs_register_rq_qos(q);
 		mutex_unlock(&q->debugfs_mutex);
@@ -926,7 +930,7 @@ int wbt_init(struct gendisk *disk)
 	 * Assign rwb and add the stats callback.
 	 */
 	mutex_lock(&q->rq_qos_mutex);
-	ret = rq_qos_add(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
+	ret = rq_qos_add_frozen(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
 	mutex_unlock(&q->rq_qos_mutex);
 	if (ret)
 		goto err_free;
-- 
2.51.0

