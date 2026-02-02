Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F8F311975;
	Mon,  2 Feb 2026 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770019536; cv=none; b=SFxyks0MSkOBoDoJwk4wj2kL7vDcFAKZsNcNgGS9wstPZJXhJQquZw8nbdqTRec1Ftbk3tylXcN8q4OTjJNvdfeX+BZCo3pbpPqomxDbzZwtCbzNPSULT0t7rIyonwnmYwf/xqqqJthxHK+Mf6JyWWDIDWCiMvZoDPIz8n1J9FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770019536; c=relaxed/simple;
	bh=WgAZHah0jtN76dcJY5zFLPK/BQJtvQwBkHW+vLk2c3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFAJo7w8me9ttiJFIoTSwnZ9v2EoAzyx0OBxTOTDAQDEk4WV64Mw4KO+RzHXZA6yV2pOCx1k9lFZd+WB9g2ojEVegwAHFaFMimEqliAVvJXKZKc+xtgloSE9wlAshoLyxar1d45om0UHw4hFBrEV+zNQIBLRDfpl4pOkahL+hT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65C2C116D0;
	Mon,  2 Feb 2026 08:05:34 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>,
	yukuai@fnnas.com
Subject: [PATCH v9 4/8] blk-rq-qos: fix possible debugfs_mutex deadlock
Date: Mon,  2 Feb 2026 16:05:19 +0800
Message-ID: <20260202080523.3947504-5-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202080523.3947504-1-yukuai@fnnas.com>
References: <20260202080523.3947504-1-yukuai@fnnas.com>
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
  helper after wbt_init() from wbt_init_enable_default(); 2) it can be
  initialized by sysfs, fix it by calling new helper after queue is
  unfrozen from wbt_set_lat().
- For iocost and iolatency, they can only be initialized by blkcg
  configuration, however, they don't have debugfs entries for now, hence
  they are not handled yet.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-rq-qos.c |  7 -------
 block/blk-wbt.c    | 13 ++++++++++++-
 2 files changed, 12 insertions(+), 8 deletions(-)

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
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 665760274e60..1415f2bf8611 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -774,6 +774,7 @@ EXPORT_SYMBOL_GPL(wbt_enable_default);
 
 void wbt_init_enable_default(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
 	struct rq_wb *rwb;
 
 	if (!__wbt_enable_default(disk))
@@ -783,8 +784,14 @@ void wbt_init_enable_default(struct gendisk *disk)
 	if (WARN_ON_ONCE(!rwb))
 		return;
 
-	if (WARN_ON_ONCE(wbt_init(disk, rwb)))
+	if (WARN_ON_ONCE(wbt_init(disk, rwb))) {
 		wbt_free(rwb);
+		return;
+	}
+
+	mutex_lock(&q->debugfs_mutex);
+	blk_mq_debugfs_register_rq_qos(q);
+	mutex_unlock(&q->debugfs_mutex);
 }
 
 static u64 wbt_default_latency_nsec(struct request_queue *q)
@@ -1008,5 +1015,9 @@ int wbt_set_lat(struct gendisk *disk, s64 val)
 	blk_mq_unquiesce_queue(q);
 out:
 	blk_mq_unfreeze_queue(q, memflags);
+	mutex_lock(&q->debugfs_mutex);
+	blk_mq_debugfs_register_rq_qos(q);
+	mutex_unlock(&q->debugfs_mutex);
+
 	return ret;
 }
-- 
2.51.0

