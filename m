Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A525F25745
	for <linux-block@vger.kernel.org>; Sun,  7 Apr 2024 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712494767; cv=none; b=CnjPbV7KtDHh60/fRPxv44tg91Czzt8S4mXKNK6gPWbo1CI60ydG1Yovy33E2/Y2w2/1DDpVHsFUMY8yUYPVrSBbJKX5xyFMEm/CMuI15OWP1KTmftj6WoL1PV2QTRUaG1LtnsKKTkGXK2O3C0Ig+6heEMxEHEnxCKXQArPlwlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712494767; c=relaxed/simple;
	bh=bZFZufnE+h134VWAHi3p4iZttnMh45Ccd/lC/UQS0yA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DuI3u6W5rSI9Tf/pMZEPH7vmU+BzHURRpd3A9OEZftqyBpVkcmPfGnuIQ2uiZvdO+mSiHgYVmRR31GuLHC1gZvYbZXPgP2CTqHLF/CyD1g50sOEBWNop4lcud64oba9pzWgUJdIDRYgc6orcr+FUMsJL5pnMsMemMMMkqy7liLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dYemNW1i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYemNW1i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712494764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BMCfj1THZAFaPRDdHusa+yxgjY6yngIDuN34dY8Lz0U=;
	b=dYemNW1ib0Xnvwy7Wm8tp+drjU5fE4q7Y0cJV5bVhPkwkltJ59zE1bcoQtco0jLKkHdL/F
	TgotOJzBarM12uKWJ/ziaVZxaCQx6fAQZh5REty2ImtlBIm0XBq4BxaNiErn+kElwpI543
	Bgz2fr4cHXY3PdhSh0x5Du/TkersQMo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-VdPgkymnO0-7nZ3Q-6rCjA-1; Sun,
 07 Apr 2024 08:59:20 -0400
X-MC-Unique: VdPgkymnO0-7nZ3Q-6rCjA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C12A29AC014;
	Sun,  7 Apr 2024 12:59:20 +0000 (UTC)
Received: from localhost (unknown [10.72.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 495851C0DD80;
	Sun,  7 Apr 2024 12:59:18 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH] block: fix q->blkg_list corruption during disk rebind
Date: Sun,  7 Apr 2024 20:59:10 +0800
Message-ID: <20240407125910.4053377-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Multiple gendisk instances can allocated/added for single request queue
in case of disk rebind. blkg may still stay in q->blkg_list when calling
blkcg_init_disk() for rebind, then q->blkg_list becomes corrupted.

Fix the list corruption issue by:

- add blkg_init_queue() to initialize q->blkg_list & q->blkcg_mutex only
- move calling blkg_init_queue() into blk_alloc_queue()

The list corruption should be started since commit f1c006f1c685 ("blk-cgroup:
synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
which delays removing blkg from q->blkg_list into blkg_free_workfn().

Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
Fixes: 1059699f87eb ("block: move blkcg initialization/destroy into disk allocation/release handler")
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
blktests:
	https://lore.kernel.org/linux-block/20240407125717.4052964-1-ming.lei@redhat.com/

 block/blk-cgroup.c | 9 ++++++---
 block/blk-cgroup.h | 2 ++
 block/blk-core.c   | 2 ++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bdbb557feb5a..059467086b13 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1409,6 +1409,12 @@ static int blkcg_css_online(struct cgroup_subsys_state *css)
 	return 0;
 }
 
+void blkg_init_queue(struct request_queue *q)
+{
+	INIT_LIST_HEAD(&q->blkg_list);
+	mutex_init(&q->blkcg_mutex);
+}
+
 int blkcg_init_disk(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
@@ -1416,9 +1422,6 @@ int blkcg_init_disk(struct gendisk *disk)
 	bool preloaded;
 	int ret;
 
-	INIT_LIST_HEAD(&q->blkg_list);
-	mutex_init(&q->blkcg_mutex);
-
 	new_blkg = blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
 	if (!new_blkg)
 		return -ENOMEM;
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 78b74106bf10..90b3959d88cf 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -189,6 +189,7 @@ struct blkcg_policy {
 extern struct blkcg blkcg_root;
 extern bool blkcg_debug_stats;
 
+void blkg_init_queue(struct request_queue *q);
 int blkcg_init_disk(struct gendisk *disk);
 void blkcg_exit_disk(struct gendisk *disk);
 
@@ -482,6 +483,7 @@ struct blkcg {
 };
 
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
+static inline void blkg_init_queue(struct request_queue *q) { }
 static inline int blkcg_init_disk(struct gendisk *disk) { return 0; }
 static inline void blkcg_exit_disk(struct gendisk *disk) { }
 static inline int blkcg_policy_register(struct blkcg_policy *pol) { return 0; }
diff --git a/block/blk-core.c b/block/blk-core.c
index a16b5abdbbf5..3a6f5603fb44 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -442,6 +442,8 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 	init_waitqueue_head(&q->mq_freeze_wq);
 	mutex_init(&q->mq_freeze_lock);
 
+	blkg_init_queue(q);
+
 	/*
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
 	 * See blk_register_queue() for details.
-- 
2.41.0

