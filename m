Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5614235063
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768495125; cv=none; b=XmDfze2RdA5ZO5vnFmmHMyzyPxeKJIU31YfI3U1NDnWPYZ1tKoQdwQxtCDB5kW/msdsRy1mcfcKvMAV1ERYN4KOFyD8t2fFpo+uQfZgJi7YrHL3A0LhPED0keO7evePI7OyKRb5yvIzZF3A98md+KvWWfhwB5n9zdA+XewmKCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768495125; c=relaxed/simple;
	bh=H1WLugF1S3qGvdGrjnehJ35HMDhGWpV/FtrdkXru0cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkVZ+FKU00m7JIpsOmEQFCNppCY/vhA08lEm3IEmaxwiTQU/7sTaZyiJv19s4+jDDdwovKEP8pFXn5bzRl6QSLxZs2K+trGriC5j32SAqSrCYIljNMzlJ7upYrkiQBBh8uH0s1ivJEFLdBIZS23PvW8EFSq234X+T8iFf2/YJXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38A3C116D0;
	Thu, 15 Jan 2026 16:38:41 +0000 (UTC)
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
Subject: [PATCH 4/6] blk-cgroup: skip dying blkg in blkcg_activate_policy()
Date: Fri, 16 Jan 2026 00:38:16 +0800
Message-ID: <20260115163818.162968-5-yukuai@fnnas.com>
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

When switching IO schedulers on a block device, blkcg_activate_policy()
can race with concurrent blkcg deletion, leading to a use-after-free in
rcu_accelerate_cbs.

T1:                               T2:
                                  blkg_destroy
                                  kill(&blkg->refcnt) // blkg->refcnt=1->0
                                  blkg_release // call_rcu(__blkg_release)
                                  ...
                                  blkg_free_workfn
                                  ->pd_free_fn(pd)
elv_iosched_store
elevator_switch
...
iterate blkg list
blkg_get(blkg) // blkg->refcnt=0->1
                                  list_del_init(&blkg->q_node)
blkg_put(pinned_blkg) // blkg->refcnt=1->0
blkg_release // call_rcu again
rcu_accelerate_cbs // uaf

Fix this by checking hlist_unhashed(&blkg->blkcg_node) before getting
a reference to the blkg. This is the same check used in blkg_destroy()
to detect if a blkg has already been destroyed. If the blkg is already
unhashed, skip processing it since it's being destroyed.

Link: https://lore.kernel.org/all/20260108014416.3656493-4-zhengqixing@huaweicloud.com/
Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index a6ac6ba9430d..8d9273f61dd5 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1625,6 +1625,8 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 			 * GFP_NOWAIT failed.  Free the existing one and
 			 * prealloc for @blkg w/ GFP_KERNEL.
 			 */
+			if (hlist_unhashed(&blkg->blkcg_node))
+				continue;
 			if (pinned_blkg)
 				blkg_put(pinned_blkg);
 			blkg_get(blkg);
-- 
2.51.0

