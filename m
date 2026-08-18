Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F6A36B927;
	Tue, 18 Aug 2026 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036325; cv=none; b=H2TEDPJNH+02AJNY/qrz3jZPmPisXEAgIRfH7cilNKD2oDb/sNQpIzETMjuH4FvrGuuMx85zQxcqArpWKafauVxXwkytxqu7qc4vmyIlnxntFnIbE9DeiFwNqWnca3KRxupBu5wzR2ks1W2fG9wEVPLA/UpC5RsfxUDmMXJ0F8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036325; c=relaxed/simple;
	bh=21tzVTdHNeo2I8XC8Uotr9Q42EgPZR8zx5bgNogihTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j1ZcCAHv1VkUQolEP0TMf66Gnt3HmFPy6lJ9hv8hkNO3/RMRQf36shQjKxSuY+Y804TJ09clBWicytX3/fdW6/j0s2M5Yurk95qOReE4KSThZJ0ytqAO42C+FCGwx+ve0S5Y3IkY8lCnfMWui8HpDCiRDTMetoBfwGnfkP9Ge28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcdQFpIN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcdQFpIN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672F71F000E9;
	Tue, 18 Aug 2026 06:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787036313;
	bh=guyl95+llmb2iA+aEyVc9H2IOcwS4GmrgNnMoT71uL8=;
	h=From:To:Cc:Subject:Date;
	b=TcdQFpINNup0VnMcVRPueNRyWDUm1sZTCfXpxbMKRfb6ls3McqsKQLJkonm13HldT
	 kMJsxAGpi4/ga6+dYKlvm+BziwqMoQV1EF62Zb0Hk7K2m3piJq0N+IkK36Jp38tEF/
	 w3ZZYZqYxeTwmF5SuAL5Zo09zyPV7tI1qmlXQA5TxBgDfWIskNioL8WHuLLJokLQl4
	 bObjJWkeAd9qLj89w5m3JH6Rosn38E2Ep1op23+atY8ihEljf9cSgYUtBX+/DKKqRS
	 kBy5uVPu9SRFE07nC2pSYZqFH73sxihPcI7/6Tu6844v36m0sgMoEDx9SHKYSLBvb6
	 yGN9FmAk1XDVg==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yukuai@fygo.io,
	hch@lst.de,
	tj@kernel.org,
	josef@toxicpanda.com,
	ming.lei@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] blk-cgroup: wait for old blkgs to leave queue before disk rebind
Date: Tue, 18 Aug 2026 14:58:23 +0800
Message-ID: <20260818065823.753357-1-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai@fygo.io>

blkcg_init_disk() currently waits for q->root_blkg to become NULL before
initializing blkcg state for a rebound disk. However, blkg_destroy_all()
clears q->root_blkg after calling blkg_destroy() for each blkg. At that
point the initial references have only been killed, and the blkgs remain
on q->blkg_list until the remaining references drain and
blkg_free_workfn() removes them.

A rebound disk can therefore install new blkcg state while old blkgs are
still attached to the request queue. Wait for q->blkg_list to become empty
instead, and wake the waiter when the final blkg is removed. This covers
the complete queue-side blkg lifetime without adding separate state.

Fixes: 3dbaacf6ab68 ("blk-cgroup: wait for blkcg cleanup before initializing new disk")
Signed-off-by: Yu Kuai <yukuai@fygo.io>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 2b5c29434e42..6e1e12841880 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -136,6 +136,8 @@ static void blkg_free_workfn(struct work_struct *work)
 		blkg_put(blkg->parent);
 	spin_lock_irq(&q->queue_lock);
 	list_del_init(&blkg->q_node);
+	if (list_empty(&q->blkg_list))
+		wake_up_var(&q->blkg_list);
 	spin_unlock_irq(&q->queue_lock);
 	mutex_unlock(&q->blkcg_mutex);
 
@@ -612,8 +614,6 @@ static void blkg_destroy_all(struct gendisk *disk)
 	q->root_blkg = NULL;
 	spin_unlock_irq(&q->queue_lock);
 	mutex_unlock(&q->blkcg_mutex);
-
-	wake_up_var(&q->root_blkg);
 }
 
 static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
@@ -1472,14 +1472,10 @@ int blkcg_init_disk(struct gendisk *disk)
 	/*
 	 * If the queue is shared across disk rebind (e.g., SCSI), the
 	 * previous disk's blkcg state is cleaned up asynchronously via
-	 * disk_release() -> blkcg_exit_disk(). Wait for that cleanup to
-	 * finish (indicated by root_blkg becoming NULL) before setting up
-	 * new blkcg state. Otherwise, we may overwrite q->root_blkg while
-	 * the old one is still alive, and radix_tree_insert() in
-	 * blkg_create() will fail with -EEXIST because the old entries
-	 * still occupy the same queue id slot in blkcg->blkg_tree.
+	 * disk_release() -> blkcg_exit_disk(). Wait for all old blkgs to be
+	 * removed from the queue list before setting up new blkcg state.
 	 */
-	wait_var_event(&q->root_blkg, !READ_ONCE(q->root_blkg));
+	wait_var_event(&q->blkg_list, list_empty_careful(&q->blkg_list));
 
 	new_blkg = blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
 	if (!new_blkg)
-- 
2.51.0

