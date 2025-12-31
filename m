Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4EE31327A
	for <linux-block@vger.kernel.org>; Wed, 31 Dec 2025 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767171124; cv=none; b=OcetsA+vv2FKMnlWPMtgwUdD3/l7R0WuBA7w8gDq8/qzW/f1FzhkK7w+dpWxUVJRVQNcHnaxd3IJ2fLHoZHq4wwRpZQEkz95wyyrkv/UiRTaY1ST0kzBkafuoP0H/QY8/0RUlWvjtcPnpt09EC1ImXW+CCMJrzunqNIJl5mVYcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767171124; c=relaxed/simple;
	bh=R4+S3GKh0+LokRRWVBj8W1u5W9NkvWzTRyHf4hPicBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lg3tyXtVPcG/6tOYjK2CAoglQFGRYQibmpVUiIVmwqy/uVpuswR3ge/lmpdnG2UKpa4iyhtd+1fqEY+8gy8mxXyOzIy76RaUAGlFGMu50GtfgdeD6lIQa2oCmwLdDQyi8UXAFEVmJbjphU8FBjD80kTMZZrKDqRVX87IWpTgUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4208AC113D0;
	Wed, 31 Dec 2025 08:52:03 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v7 16/16] blk-cgroup: remove queue frozen from blkcg_activate_policy()
Date: Wed, 31 Dec 2025 16:51:26 +0800
Message-ID: <20251231085126.205310-17-yukuai@fnnas.com>
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

On the one hand, nest q_usage_counter under rq_qos_mutex is wrong;

On the other hand, policy activation is now all under queue frozen:
 - for bfq queue is frozen from elevator_change();
 - for blk-throttle, iocost, iolatency, queue is frozen from
 blkg_conf_open_bdev_frozen(&ctx);

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-cgroup.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3cffb68ba5d8..31ac518b347c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1580,12 +1580,13 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	struct request_queue *q = disk->queue;
 	struct blkg_policy_data *pd_prealloc = NULL;
 	struct blkcg_gq *blkg, *pinned_blkg = NULL;
-	unsigned int memflags;
 	int ret;
 
 	if (blkcg_policy_enabled(q, pol))
 		return 0;
 
+	WARN_ON_ONCE(q->mq_freeze_depth == 0);
+
 	/*
 	 * Policy is allowed to be registered without pd_alloc_fn/pd_free_fn,
 	 * for example, ioprio. Such policy will work on blkcg level, not disk
@@ -1594,8 +1595,6 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	if (WARN_ON_ONCE(!pol->pd_alloc_fn || !pol->pd_free_fn))
 		return -EINVAL;
 
-	if (queue_is_mq(q))
-		memflags = blk_mq_freeze_queue(q);
 retry:
 	spin_lock_irq(&q->queue_lock);
 
@@ -1658,8 +1657,6 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 
 	spin_unlock_irq(&q->queue_lock);
 out:
-	if (queue_is_mq(q))
-		blk_mq_unfreeze_queue(q, memflags);
 	if (pinned_blkg)
 		blkg_put(pinned_blkg);
 	if (pd_prealloc)
-- 
2.51.0

