Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAA1313538
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768495121; cv=none; b=mYyWgxUUfiI8d4ipchoZYm2aefoeGwnJGSTU2vTh/53CTnuBVDeq+eqPK1KzIKK1+htBBlp9lOAiESdB4Kzk2wtGfEaYoCtw7MOCJbqTfnBCOG8SaI/kA42o5MgXm7xh7JV4+BW9iNJUYNOKyvgwBwJxNOwdpM4Mi2mu9+kvh40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768495121; c=relaxed/simple;
	bh=mfoop8ZFZvTQ70rW8k+bwTmcnWPolUFqyPFaLre1q6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqFsOxiZqB6ShzMvEwfWHmqRUCuMlnSm5m1w2hD9Q0YLkWVQzBd4yFnvWHOpaawiV7v64oyQUaKLEKvBOaNhyEX0ybMd8q3kDv38+iLOn8+ndYo6aj5XnwzEPK5FThbt8Runr/LEPcPiZOotLjHU/PUM7nWvUj0wt+DG1dul83Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD0DC116D0;
	Thu, 15 Jan 2026 16:38:38 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com,
	zhengqixing@huawei.com,
	mkoutny@suse.com,
	hch@infradead.org
Subject: [PATCH 3/6] blk-cgroup: fix race between policy activation and blkg destruction
Date: Fri, 16 Jan 2026 00:38:15 +0800
Message-ID: <20260115163818.162968-4-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260115163818.162968-1-yukuai@fnnas.com>
References: <20260115163818.162968-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zheng Qixing <zhengqixing@huawei.com>

When switching an IO scheduler on a block device, blkcg_activate_policy()
allocates blkg_policy_data (pd) for all blkgs attached to the queue.
However, blkcg_activate_policy() may race with concurrent blkcg deletion,
leading to use-after-free and memory leak issues.

The use-after-free occurs in the following race:

T1 (blkcg_activate_policy):
  - Successfully allocates pd for blkg1 (loop0->queue, blkcgA)
  - Fails to allocate pd for blkg2 (loop0->queue, blkcgB)
  - Enters the enomem rollback path to release blkg1 resources

T2 (blkcg deletion):
  - blkcgA is deleted concurrently
  - blkg1 is freed via blkg_free_workfn()
  - blkg1->pd is freed

T1 (continued):
  - Rollback path accesses blkg1->pd->online after pd is freed
  - Triggers use-after-free

In addition, blkg_free_workfn() frees pd before removing the blkg from
q->blkg_list. This allows blkcg_activate_policy() to allocate a new pd
for a blkg that is being destroyed, leaving the newly allocated pd
unreachable when the blkg is finally freed.

Fix these races by extending blkcg_mutex coverage to serialize
blkcg_activate_policy() rollback and blkg destruction, ensuring pd
lifecycle is synchronized with blkg list visibility.

Link: https://lore.kernel.org/all/20260108014416.3656493-3-zhengqixing@huaweicloud.com/
Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-cgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0bc7b19399b6..a6ac6ba9430d 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1599,6 +1599,8 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 
 	if (queue_is_mq(q))
 		memflags = blk_mq_freeze_queue(q);
+
+	mutex_lock(&q->blkcg_mutex);
 retry:
 	spin_lock_irq(&q->queue_lock);
 
@@ -1661,6 +1663,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 
 	spin_unlock_irq(&q->queue_lock);
 out:
+	mutex_unlock(&q->blkcg_mutex);
 	if (queue_is_mq(q))
 		blk_mq_unfreeze_queue(q, memflags);
 	if (pinned_blkg)
-- 
2.51.0

