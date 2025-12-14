Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD032040B6
	for <linux-block@vger.kernel.org>; Sun, 14 Dec 2025 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765707264; cv=none; b=adQQEuAvAafLPPfnsGrO5dl7C6MSZz9V8e6vuixn9JAMusY6rprBZABLwFbal6Jci4kMZE+WWIMxvObsHjey/+EpceHYoOEHXKbvm6YnLLYJA2t4jr2c2mSfrf0wCS7m4CheVBPj/s42I2P3dVrjFQ/AXHlbwsE/3atTbTM4Zhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765707264; c=relaxed/simple;
	bh=3a3IlJqEoYUHGAR3c7GChz2t7OSPlNSMUQbq2dDCpFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1Bs6PYX5hD9rdn98pLS/hZABAVnLQOAZAhSB+prNIpFUnNHiyKlSGaxfhsnVqUVDsKf9K1eXsI5r+kSZCLyEFExgR3Rx5U6b21c9z8w7YzYJ44kJ7QMlKitwbWpSiXG6cd0FsDq6gjpi64GbZRc0RfvP7r49vCEhg2rW2xlr6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6C4C4CEF1;
	Sun, 14 Dec 2025 10:14:23 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v5 04/13] blk-rq-qos: fix possible debugfs_mutex deadlock
Date: Sun, 14 Dec 2025 18:13:59 +0800
Message-ID: <20251214101409.1723751-5-yukuai@fnnas.com>
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
 block/blk-rq-qos.c |  7 -------
 block/blk-wbt.c    | 12 +++++++++++-
 2 files changed, 11 insertions(+), 8 deletions(-)

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
index 696baa681717..4bf6f42bef2e 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -767,8 +767,14 @@ void wbt_enable_default(struct gendisk *disk)
 		if (WARN_ON_ONCE(!rwb))
 			return;
 
-		if (WARN_ON_ONCE(wbt_init(disk, rwb)))
+		if (WARN_ON_ONCE(wbt_init(disk, rwb))) {
 			wbt_free(rwb);
+			return;
+		}
+
+		mutex_lock(&q->debugfs_mutex);
+		blk_mq_debugfs_register_rq_qos(q);
+		mutex_unlock(&q->debugfs_mutex);
 	}
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
@@ -995,5 +1001,9 @@ int wbt_set_lat(struct gendisk *disk, s64 val)
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

