Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081EF2D0606
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764578067; cv=none; b=EhkK09c8doIIrXwXxMoN+OQzciwjHbtBeS5vVMC1/g2y+Ql0mLd99Kb5Nsmt9KX6pethG8Vy2ZhWt11twKjvKBX8umKPqshTfLAM4iCi5g/tnqL/xLS4hlIpapOiAaGXsd6PuTm53NRR6iWwiwNz94B+Vvrholrh7hCBjGU9BfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764578067; c=relaxed/simple;
	bh=Isbs/git6yKNS9kWV0zpq/v59/84eBFia6ZDTcAX8R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NB+s/lODWd6ag8l0eFtyxxw+AP9lLO5/TvfsYSetCMGNaqpiIlsJ6Y2x9oTwjnDK+onYaxoW/OIXnbm9J4W1yVuYC8lckYhStGGaiBcEYDV3x89ygyDV67qGYsIWkPl8NkCuT5Pabm4UtxA2lpXX+S70m2/Kzmo59Co6gmOSP7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6B8C4CEF1;
	Mon,  1 Dec 2025 08:34:24 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	bvanassche@acm.org
Cc: yukuai@fnnas.com
Subject: [PATCH v4 04/12] blk-rq-qos: fix possible debugfs_mutex deadlock
Date: Mon,  1 Dec 2025 16:34:07 +0800
Message-ID: <20251201083415.2407888-5-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201083415.2407888-1-yukuai@fnnas.com>
References: <20251201083415.2407888-1-yukuai@fnnas.com>
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
 block/blk-wbt.c    | 10 +++++++++-
 2 files changed, 9 insertions(+), 8 deletions(-)

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
index 3777255b99ad..c471d11b756f 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -758,8 +758,12 @@ void wbt_enable_default(struct gendisk *disk)
 	if (queue_is_mq(q) && enable) {
 		struct rq_wb *rwb = wbt_alloc();
 
-		if (rwb)
+		if (rwb) {
 			wbt_init(disk, rwb);
+			mutex_lock(&q->debugfs_mutex);
+			blk_mq_debugfs_register_rq_qos(q);
+			mutex_unlock(&q->debugfs_mutex);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
@@ -999,5 +1003,9 @@ int wbt_set_lat(struct gendisk *disk, s64 val)
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

