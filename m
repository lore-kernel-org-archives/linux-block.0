Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20512DBF75
	for <linux-block@vger.kernel.org>; Wed, 31 Dec 2025 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767171113; cv=none; b=aNr2vwpUgppr9uW1YZ2ybRVEy7LE8KaHAubi6KsJRXrzUtd4BVp2rqmkSRQ4FCiwCsdJ5ASymY14Rfy4LzMieK46dFrlNnbTeuyxaFWpGUt3bGlLq/v/e1v/6GLCpKkabxhSX3FSA62rJMf5bFodCH7IsEeCDwfn9TqVSdwlRHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767171113; c=relaxed/simple;
	bh=cZAjn3i/1KoYmp6iXvX1OGA7E4xiCxKR1MXi3PWn7sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbsMtWnwFTLY2QSjP7ocw9Te8iX8KGfyqx91BPBMs9p19R+5Y32oMDR9+Q8E7yoBMm8SXuyinB8UK3qaj0UjWXvA3brfv4R3WlhQT0God00VjU+jEScLnjUia+iBJGJVqjz4a9zkaWVO8lMIEaRENAmXlVWfRJBTKkB0/3X+/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29132C116D0;
	Wed, 31 Dec 2025 08:51:50 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v7 09/16] blk-throttle: fix possible deadlock for fs reclaim under rq_qos_mutex
Date: Wed, 31 Dec 2025 16:51:19 +0800
Message-ID: <20251231085126.205310-10-yukuai@fnnas.com>
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

blk_throtl_init() can be called with rq_qos_mutex held from blkcg
configuration, and fs reclaim can be triggered because GFP_KERNEL is used
to allocate memory. This can deadlock because rq_qos_mutex can be held
with queue frozen.

Fix the problem by using blkg_conf_open_bdev_frozen(), also remove
useless queue frozen from blk_throtl_init().

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-throttle.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 97188a795848..6b9e76c6a24b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1310,7 +1310,6 @@ static int blk_throtl_init(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct throtl_data *td;
-	unsigned int memflags;
 	int ret;
 
 	td = kzalloc_node(sizeof(*td), GFP_KERNEL, q->node);
@@ -1319,8 +1318,6 @@ static int blk_throtl_init(struct gendisk *disk)
 
 	INIT_WORK(&td->dispatch_work, blk_throtl_dispatch_work_fn);
 	throtl_service_queue_init(&td->service_queue);
-
-	memflags = blk_mq_freeze_queue(disk->queue);
 	blk_mq_quiesce_queue(disk->queue);
 
 	q->td = td;
@@ -1334,8 +1331,6 @@ static int blk_throtl_init(struct gendisk *disk)
 	}
 
 	blk_mq_unquiesce_queue(disk->queue);
-	blk_mq_unfreeze_queue(disk->queue, memflags);
-
 	return ret;
 }
 
@@ -1345,15 +1340,18 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 {
 	struct blkcg *blkcg = css_to_blkcg(of_css(of));
 	struct blkg_conf_ctx ctx;
+	unsigned long memflags;
 	struct throtl_grp *tg;
-	int ret;
+	int ret = 0;
 	u64 v;
 
 	blkg_conf_init(&ctx, buf);
 
-	ret = blkg_conf_open_bdev(&ctx);
-	if (ret)
+	memflags = blkg_conf_open_bdev_frozen(&ctx);
+	if (IS_ERR_VALUE(memflags)) {
+		ret = memflags;
 		goto out_finish;
+	}
 
 	if (!blk_throtl_activated(ctx.bdev->bd_queue)) {
 		ret = blk_throtl_init(ctx.bdev->bd_disk);
@@ -1382,7 +1380,7 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 	tg_conf_updated(tg, false);
 	ret = 0;
 out_finish:
-	blkg_conf_exit(&ctx);
+	blkg_conf_exit_frozen(&ctx, memflags);
 	return ret ?: nbytes;
 }
 
@@ -1529,15 +1527,18 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 {
 	struct blkcg *blkcg = css_to_blkcg(of_css(of));
 	struct blkg_conf_ctx ctx;
+	unsigned long memflags;
 	struct throtl_grp *tg;
+	int ret = 0;
 	u64 v[4];
-	int ret;
 
 	blkg_conf_init(&ctx, buf);
 
-	ret = blkg_conf_open_bdev(&ctx);
-	if (ret)
+	memflags = blkg_conf_open_bdev_frozen(&ctx);
+	if (IS_ERR_VALUE(memflags)) {
+		ret = memflags;
 		goto out_finish;
+	}
 
 	if (!blk_throtl_activated(ctx.bdev->bd_queue)) {
 		ret = blk_throtl_init(ctx.bdev->bd_disk);
@@ -1600,7 +1601,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	tg_conf_updated(tg, false);
 	ret = 0;
 out_finish:
-	blkg_conf_exit(&ctx);
+	blkg_conf_exit_frozen(&ctx, memflags);
 	return ret ?: nbytes;
 }
 
-- 
2.51.0

