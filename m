Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9A4537E9
	for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 02:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764470639; cv=none; b=H+tLxfKJ4Q6Hl30vOZlxOZjc6bxaFQZU8QXDqI8IktLcvyKPiqwTONilQU+qCRjmLLs1tDq3/cbuTeyxEg7fFBi/HLOypHJ1FWcF8Iib/A2jpkQTYd4eqJJT48Zz1zAjj2f7X2IFlGjn3DpGLYDMnu/oNUwTLcPZf155XvuRWjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764470639; c=relaxed/simple;
	bh=xVTV+yNcfRoFS1A1JClFhLCAMlpfyy8Y+Ll+sSgUZ6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5hDc1RYgn3VW/MurUOZMo21qNLUttdfXq/+3UJtrX3N4Bl8x20GpQB1Qx60hKK/GmnF1MVABJrE2XO4hjqqA3aTq6onnqdkXA3PAYmFT/HxKF7TjV2cK63vBpUBS6JZPvJ/KUausHZ1sOuxGtG8Z+ap2Xu1GBe6WQu93m50heU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31952C4CEF7;
	Sun, 30 Nov 2025 02:43:56 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	bvanassche@acm.org
Cc: yukuai@fnnas.com
Subject: [PATCH v3 02/10] blk-rq-qos: fix possible debugfs_mutex deadlock
Date: Sun, 30 Nov 2025 10:43:41 +0800
Message-ID: <20251130024349.2302128-3-yukuai@fnnas.com>
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

Currently rq-qos debugfs entries are created from rq_qos_add(), while
rq_qos_add() can be called while queue is still frozen. This can
deadlock because creating new entries can trigger fs reclaim.

Fix this problem by delaying creating rq-qos debugfs entries after queue
is unfrozen.

- For wbt, 1) it can be initialized by default, fix it by calling new
  helper after wbt_init() from wbt_enable_default; 2) it can be
  initialized by sysfs, fix it by calling new helper after queue is
  unfrozen from queue_wb_lat_store().
- For iocost and iolatency, they can only be initialized by blkcg
  configuration, however, they don't have debugfs entries for now, hence
  they are not handled yet.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-rq-qos.c | 7 -------
 block/blk-sysfs.c  | 4 ++++
 block/blk-wbt.c    | 6 +++++-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 654478dfbc20..d7ce99ce2e80 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -347,13 +347,6 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
 
 	blk_mq_unfreeze_queue(q, memflags);
-
-	if (rqos->ops->debugfs_attrs) {
-		mutex_lock(&q->debugfs_mutex);
-		blk_mq_debugfs_register_rqos(rqos);
-		mutex_unlock(&q->debugfs_mutex);
-	}
-
 	return 0;
 ebusy:
 	blk_mq_unfreeze_queue(q, memflags);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 8684c57498cc..cb0a12253c6e 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -681,6 +681,10 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 out:
 	blk_mq_unfreeze_queue(q, memflags);
 
+	mutex_lock(&q->debugfs_mutex);
+	blk_mq_debugfs_register_rq_qos(q);
+	mutex_unlock(&q->debugfs_mutex);
+
 	return ret;
 }
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index eb8037bae0bd..b1ab0f297f24 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -724,8 +724,12 @@ void wbt_enable_default(struct gendisk *disk)
 	if (!blk_queue_registered(q))
 		return;
 
-	if (queue_is_mq(q) && enable)
+	if (queue_is_mq(q) && enable) {
 		wbt_init(disk);
+		mutex_lock(&q->debugfs_mutex);
+		blk_mq_debugfs_register_rq_qos(q);
+		mutex_unlock(&q->debugfs_mutex);
+	}
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
 
-- 
2.51.0

