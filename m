Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8D163;
	Fri,  5 Sep 2025 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068203; cv=none; b=SZISXeIVpiG5yk2BcuBQv1ZCf8jm5XJoFpm3dlxNGBuOriZOb8S1l7TfkCdDuwNHWxlNlxDqS1ENHTd90StI9kkvC8pA/uvWr9fBtQNGtpsk6duXpAQ61FAEFNM1PI/Uogf8d/LJLExfFb9t/bzLoDRX+yhH4VXVguRV27sLwc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068203; c=relaxed/simple;
	bh=LxoUUTM4Lhq7LVBoS37CQ51tMJsfbc8SZeLeZfmdiKo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=gRbkz7cNWBFyKOaMppjdNUZ6QhtZpsFpxpqh69+F1BHtZnayiXtSuGUJMhNcMbfWbdNTWV0KuVfz1NHgr4vALe1UUdgR5eiITQlAyfebsQ6MFVodFIXQI4gUjBrz6yNKqqiwS2X75zE7f5xndvP7G1mMUQKD1e0Ac+41NcFiTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=VBXdwpkZ; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="VBXdwpkZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1757067888;
	bh=6CzGc88AhXYQStJl9NyjeWpFWRbHkdfeVp4hWLrDfJE=;
	h=From:To:Cc:Subject:Date;
	b=VBXdwpkZRQeBMpx3xu1HXJTv99/a0R+SdaM3L/LzNw2PJC6dC6Z3iB2WpKT73ScN/
	 BOX61ddMyfvPAMv+D75H5nIMls317lTRlBjzFyqbU7xgZRrVZyPTBhYEJ+1218Z/2P
	 fk9ONrZ0y1HYMwmA++blFYf8wF1qsriyz9jBGkxY=
Received: from SSOC3-SH.company.local ([58.33.109.195])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 6122C8F1; Fri, 05 Sep 2025 18:24:18 +0800
X-QQ-mid: xmsmtpt1757067858tmfm1wuve
Message-ID: <tencent_E009F9D3A4C7F814018C1DFA80304944BA0A@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uTinj3dsRo7W8LDD6ajpi3LhkMG8/QA6s0nKnaYOdOanBaiJSJcL
	 Zmab59O/XxNYUsPfBJSQywB7Xt90rzZmysydFTVg+6gZFb4tcOTjnmaLpwp59rRpWV5/Sk7lSVuy
	 Cs3B6kSJ1feF2Vig0LtAYETqtCjkDlZkB71RmExBO/II2pOWOh6V+mD82tbhTFOdE0nvSXZUIra1
	 uYk2ycZwNoo9yax8+nnYJNBBpZMgV5sA2ReaZTGjQe0rBp4Qa9Gn8keN/kFxMRpE1crcpdGpuE3X
	 kKskkLJRxoGSgQC57ZZjjwLXO8h6eBkp1QHSimGBCg8G2ovlqVPKeSUJU26aZ+U5SxueC/6Td3/R
	 JIaFVsNZyVYVFT0gcBE7r34KxM4qEsrSv+dG5magqRBjjYqfu0XTWGPyQjFnuO0puyQTN9GsGoX0
	 cIizQUrNIUg5AKljsJyAvnezaIrUahTlJFtw7k4ZPqfeKGfhbzZ9t2un3qQBldHbnvx/UsgeQ4Ft
	 vWHgS7ZNTd5k0fChoM8txK5JLnvakj0GfAKRmtxf6RuwlA6ostZ1lth7mQp9VJLTJ3kwWaOUKDQ9
	 fwRUc6gc3zR3dGqQiUlFc9OzRzO5zDlZ/lbp631cVt73va8TmXmhKBQbiwDsl5TAfHeTpvlic7Cp
	 j9VzmdHTDDBHnVr/DfACV7CHApOBFxJsyfI9JG1V0/PTl/UY7zxo699da3YLoAVvliym3LjX9GXH
	 +fh8ZyL7My/YYnr7rhBKQ4Qn2Vhnqs2qZ3xUYANHN09KRrQkvb7XQ6TkzQ8EXl6hKwTB+P0eY0OG
	 VsZm8iYS1hTypOQsrFqJZcwwBLgHMT3SGELXiJWBY/zOM+GoF/xCYA2H9GegogFmx/9pV1aUNuiL
	 9FHlH+9QjWNLu9ryiNEAOK9XtB3vHywfT8ln7St8GXaO1bMXaa0OfkA0m6MgIxXHFRvMzpe4C30p
	 Gt8SZCNZVnXhcuVCJirc8rqetucg1HRCnyjxGO0JrzsvBX1St8LkF13bWUBnEuUdJeAz8dvQvNPE
	 TM0fcbPDvVqPktFVOKKL+7Eh2s0qo=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Han Guangjiang <gj.han@foxmail.com>
To: yukuai1@huaweicloud.com,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: hanguangjiang@lixiang.com,
	fanggeng@lixiang.com,
	yangchen11@lixiang.com,
	liangjie@lixiang.com
Subject: [PATCH v3] blk-throttle: fix access race during throttle policy activation
Date: Fri,  5 Sep 2025 18:24:11 +0800
X-OQ-MSGID: <20250905102413.3973379-1-gj.han@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Han Guangjiang <hanguangjiang@lixiang.com>

On repeated cold boots we occasionally hit a NULL pointer crash in
blk_should_throtl() when throttling is consulted before the throttle
policy is fully enabled for the queue. Checking only q->td != NULL is
insufficient during early initialization, so blkg_to_pd() for the
throttle policy can still return NULL and blkg_to_tg() becomes NULL,
which later gets dereferenced.

 Unable to handle kernel NULL pointer dereference
 at virtual address 0000000000000156
 ...
 pc : submit_bio_noacct+0x14c/0x4c8
 lr : submit_bio_noacct+0x48/0x4c8
 sp : ffff800087f0b690
 x29: ffff800087f0b690 x28: 0000000000005f90 x27: ffff00068af393c0
 x26: 0000000000080000 x25: 000000000002fbc0 x24: ffff000684ddcc70
 x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
 x20: 0000000000080000 x19: ffff000684ddcd08 x18: ffffffffffffffff
 x17: 0000000000000000 x16: ffff80008132a550 x15: 0000ffff98020fff
 x14: 0000000000000000 x13: 1fffe000d11d7021 x12: ffff000688eb810c
 x11: ffff00077ec4bb80 x10: ffff000688dcb720 x9 : ffff80008068ef60
 x8 : 00000a6fb8a86e85 x7 : 000000000000111e x6 : 0000000000000002
 x5 : 0000000000000246 x4 : 0000000000015cff x3 : 0000000000394500
 x2 : ffff000682e35e40 x1 : 0000000000364940 x0 : 000000000000001a
 Call trace:
  submit_bio_noacct+0x14c/0x4c8
  verity_map+0x178/0x2c8
  __map_bio+0x228/0x250
  dm_submit_bio+0x1c4/0x678
  __submit_bio+0x170/0x230
  submit_bio_noacct_nocheck+0x16c/0x388
  submit_bio_noacct+0x16c/0x4c8
  submit_bio+0xb4/0x210
  f2fs_submit_read_bio+0x4c/0xf0
  f2fs_mpage_readpages+0x3b0/0x5f0
  f2fs_readahead+0x90/0xe8

Tighten blk_throtl_activated() to also require that the throttle policy
bit is set on the queue:

  return q->td != NULL &&
         test_bit(blkcg_policy_throtl.plid, q->blkcg_pols);

This prevents blk_should_throtl() from accessing throttle group state
until policy data has been attached to blkgs.

Fixes: a3166c51702b ("blk-throttle: delay initialization until configuration")
Co-developed-by: Liang Jie <liangjie@lixiang.com>
Signed-off-by: Liang Jie <liangjie@lixiang.com>
Signed-off-by: Han Guangjiang <hanguangjiang@lixiang.com>
---
v2:
 - remove the comment about freeze queue in blk_should_throtl()
 - Retitle: "blk-throttle: fix access race during throttle policy activation"
v3:
 - move blkcg_policy_enabled() to blk-cgroup.h
 - use blkcg_policy_enabled() instead in blk_throtl_activated()
 - remove the comment about freeze queue in blk_throtl_init()
 - add some comments to decribe the throttle init synchronization
 - Link to v2: https://lore.kernel.org/lkml/tencent_2B678DA920124B08854638A6BE68746CCC05@qq.com/
---
 block/blk-cgroup.c   |  6 ------
 block/blk-cgroup.h   |  6 ++++++
 block/blk-throttle.c |  6 +-----
 block/blk-throttle.h | 18 +++++++++++-------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index fe9ebd6a2e14..7246fc256315 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -110,12 +110,6 @@ static struct cgroup_subsys_state *blkcg_css(void)
 	return task_css(current, io_cgrp_id);
 }
 
-static bool blkcg_policy_enabled(struct request_queue *q,
-				 const struct blkcg_policy *pol)
-{
-	return pol && test_bit(pol->plid, q->blkcg_pols);
-}
-
 static void blkg_free_workfn(struct work_struct *work)
 {
 	struct blkcg_gq *blkg = container_of(work, struct blkcg_gq,
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 81868ad86330..83367086cb6a 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -459,6 +459,12 @@ static inline bool blk_cgroup_mergeable(struct request *rq, struct bio *bio)
 		bio_issue_as_root_blkg(rq->bio) == bio_issue_as_root_blkg(bio);
 }
 
+static inline bool blkcg_policy_enabled(struct request_queue *q,
+				const struct blkcg_policy *pol)
+{
+	return pol && test_bit(pol->plid, q->blkcg_pols);
+}
+
 void blk_cgroup_bio_start(struct bio *bio);
 void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta);
 #else	/* CONFIG_BLK_CGROUP */
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 397b6a410f9e..cfa1cd60d2c5 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1327,17 +1327,13 @@ static int blk_throtl_init(struct gendisk *disk)
 	INIT_WORK(&td->dispatch_work, blk_throtl_dispatch_work_fn);
 	throtl_service_queue_init(&td->service_queue);
 
-	/*
-	 * Freeze queue before activating policy, to synchronize with IO path,
-	 * which is protected by 'q_usage_counter'.
-	 */
 	memflags = blk_mq_freeze_queue(disk->queue);
 	blk_mq_quiesce_queue(disk->queue);
 
 	q->td = td;
 	td->queue = q;
 
-	/* activate policy */
+	/* activate policy, blk_throtl_activated() will return true */
 	ret = blkcg_activate_policy(disk, &blkcg_policy_throtl);
 	if (ret) {
 		q->td = NULL;
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 3b27755bfbff..9d7a42c039a1 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -156,7 +156,13 @@ void blk_throtl_cancel_bios(struct gendisk *disk);
 
 static inline bool blk_throtl_activated(struct request_queue *q)
 {
-	return q->td != NULL;
+	/*
+	 * q->td guarantees that the blk-throttle module is already loaded,
+	 * and the plid of blk-throttle is assigned.
+	 * blkcg_policy_enabled() guarantees that the policy is activated
+	 * in the request_queue.
+	 */
+	return q->td != NULL && blkcg_policy_enabled(q, &blkcg_policy_throtl);
 }
 
 static inline bool blk_should_throtl(struct bio *bio)
@@ -164,11 +170,6 @@ static inline bool blk_should_throtl(struct bio *bio)
 	struct throtl_grp *tg;
 	int rw = bio_data_dir(bio);
 
-	/*
-	 * This is called under bio_queue_enter(), and it's synchronized with
-	 * the activation of blk-throtl, which is protected by
-	 * blk_mq_freeze_queue().
-	 */
 	if (!blk_throtl_activated(bio->bi_bdev->bd_queue))
 		return false;
 
@@ -194,7 +195,10 @@ static inline bool blk_should_throtl(struct bio *bio)
 
 static inline bool blk_throtl_bio(struct bio *bio)
 {
-
+	/*
+	 * block throttling takes effect if the policy is activated
+	 * in the bio's request_queue.
+	 */
 	if (!blk_should_throtl(bio))
 		return false;
 
-- 
2.25.1

