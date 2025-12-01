Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB59296BCF
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764578074; cv=none; b=eVwKEHv5yAIqlJVMuamo5lpu9EgopIIoD45qgU0uHoTsOCTuAZsW7oGNpH1Pub9xrKNY3csnt1u+mQxUZ1w2F2aIKDBPPutO3NyjGQLHtCvTgT90f9LfeBUT7JKZh/S/cOVJcJkH+qve8s8kfhCuHBYuaK+HOJ5QnThpJsZOT/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764578074; c=relaxed/simple;
	bh=tOqrypKVK631ix7HfQOTNI5nX9n4upM6pUyshQVLDmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K04WPT7F+VogStOqIyRnPYDsvYYbIdD1tBafDkulX/bJxSc4oHWaSAIYBDAvXmdruBWAB/P753q5ue+tW0FGlouIujSNQ1jYce+tX1vup1irZLjGaxehZJwm0yQVRC5ws+zq22wUXOvkpcXfP3mFyQPPciOZgLJ4g7UMn0ilSu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB68C116D0;
	Mon,  1 Dec 2025 08:34:32 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	bvanassche@acm.org
Cc: yukuai@fnnas.com
Subject: [PATCH v4 08/12] blk-wbt: fix incorrect lock order for rq_qos_mutex and freeze queue
Date: Mon,  1 Dec 2025 16:34:11 +0800
Message-ID: <20251201083415.2407888-9-yukuai@fnnas.com>
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
index c471d11b756f..e035331a800f 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -759,7 +759,12 @@ void wbt_enable_default(struct gendisk *disk)
 		struct rq_wb *rwb = wbt_alloc();
 
 		if (rwb) {
+			unsigned int memflags;
+
+			memflags = blk_mq_freeze_queue(q);
 			wbt_init(disk, rwb);
+			blk_mq_unfreeze_queue(q, memflags);
+
 			mutex_lock(&q->debugfs_mutex);
 			blk_mq_debugfs_register_rq_qos(q);
 			mutex_unlock(&q->debugfs_mutex);
@@ -942,7 +947,7 @@ static int wbt_init(struct gendisk *disk, struct rq_wb *rwb)
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

