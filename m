Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555912DBF75
	for <linux-block@vger.kernel.org>; Wed, 31 Dec 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767171116; cv=none; b=LhEZgU+DjFTfaYc3wkVr7PB+HUxlOzqcZEs9R2fNgid3J2J42bL5J34FWAC9YWFZNnNh2YcdgnlaeRziM9OTKw6uV0ilk/3SxeMrKD4wcijhASjw8n+V2LnRrnEHrZpDGiyvVhDTtDa6pVwe9+uh4wnDFPgtSNuotW5Zq84c8ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767171116; c=relaxed/simple;
	bh=dcvsFra26tRBCZYW6JVVVp2OPoWwgKEiTrjdLD8DrgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQOa/B2q2eLikGY3esvPK/uFSunPdt0qxnxcYFdipwJh0VdsVMLA6xlrU+uh0WZ3P9i2sfiGI7eo4VeQLb8dYTDMCH+MsSBsUYSSLCDDRE3U8uGya8aRRYwPIWJ2+nDwvlqNc6aRHVR15C5btBi7PA+l08j6EgW+FUMzRzh+H/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B48C116D0;
	Wed, 31 Dec 2025 08:51:54 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v7 11/16] blk-wbt: fix incorrect lock order for rq_qos_mutex and freeze queue
Date: Wed, 31 Dec 2025 16:51:21 +0800
Message-ID: <20251231085126.205310-12-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231085126.205310-1-yukuai@fnnas.com>
References: <20251231085126.205310-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wbt_init() can be called from sysfs attribute and
wbt_init_enable_default(), however queue_wb_lat_store() can freeze queue
first, and then wbt_init() will hold rq_qos_mutex.

Fix this problem by converting to use new helper rq_qos_add_frozen() in
wbt_init(), and freeze queue before calling wbt_init() from
wbt_init_enable_default().

Fixes: a13bd91be223 ("block/rq_qos: protect rq_qos apis with a new lock")
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-wbt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index de3528236545..ed8231b6b6e9 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -775,6 +775,7 @@ EXPORT_SYMBOL_GPL(wbt_enable_default);
 void wbt_init_enable_default(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
+	unsigned int memflags;
 	struct rq_wb *rwb;
 
 	if (!__wbt_enable_default(disk))
@@ -784,10 +785,13 @@ void wbt_init_enable_default(struct gendisk *disk)
 	if (WARN_ON_ONCE(!rwb))
 		return;
 
+	memflags = blk_mq_freeze_queue(q);
 	if (WARN_ON_ONCE(wbt_init(disk, rwb))) {
+		blk_mq_unfreeze_queue(q, memflags);
 		wbt_free(rwb);
 		return;
 	}
+	blk_mq_unfreeze_queue(q, memflags);
 
 	mutex_lock(&q->debugfs_mutex);
 	blk_mq_debugfs_register_rq_qos(q);
@@ -962,7 +966,7 @@ static int wbt_init(struct gendisk *disk, struct rq_wb *rwb)
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

