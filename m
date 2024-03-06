Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBBAD517
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 00:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709685561; cv=none; b=cby3HSyOrlJqPFQtFovl0vrT2Y0gj1gji9r7MwHQnH8oL1VH48PU1Km2Z47qqw8uqVNgk/O3yq+TrVsscnIl4GhvKamU5u1haF9qRh+23T2lktJtBtpqAiq8ZDcPjqtXusudoO7J0iwKEdMrGXzcJ+KNo1DVi3vMj3dP2RFNLyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709685561; c=relaxed/simple;
	bh=Jilvsu9Z8cQQ5pDTZdwfUdNqtDBtVBDuqYZRl9/KC+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jrbo4Ts2ah/qy0YzjyAOBZhxLFezvx/JFUS1Z6MJhMAoGEzf2FCDfWhTgTJ9F1H4xJ9YoUPOSw8sI+uXBq8qDZiyjcRMYo11Nz6HdNcoZKQzmU09ejFX32KGrRhQ/cJWrnR3RX5vlUSllRhpuXAv4rQ+ZZIYyvnrGYvyqlegct4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dcab44747bso51806315ad.1
        for <linux-block@vger.kernel.org>; Tue, 05 Mar 2024 16:39:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709685559; x=1710290359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eBOpeM8MurzfU1gylGB7+zdqXB8mbZSFaVNQsXZ2EA=;
        b=R7rKTvHC9TCI692LQTgvVTBbg1H4/EUcPNCr4sIf0RCI4Pt8G0WO/HGxOnmurM0txJ
         3pGOne13kiLg7zgycBXaXL6grL04EB7c+0hGHoGFB7nEbFD7yFCVZAU+3BQVtwEHdo9E
         ZCAXt2xbzJQ0bGgCP8gGB8LYM3qnqgBZJazHDaA5lnLupnDbIGYrMYBFQKlVW0r7T1rQ
         doSfe/MgKXPDeBHsW7McctHEOZr7IraqvlMIxs4dNGxzF/8oXBVB9/oUV/Ibc7zR8Rpw
         U8a/o0InYrRjGgKOMt7PZwcmYDKv7f/jKskltQBBFkp3OPhjFa24dKx3EAjYnbif326l
         6xiQ==
X-Gm-Message-State: AOJu0YwT21n9wV2d+HAhtjNLJCnRWlaQyCr2+d6YHg6uZDiF3JI8Y4hs
	Sz/p3CeAShSTj5Kf0y7o3XN7p+MSjo8s/ZpJvAfx7OYOXHYgtpbzkcwxifX2
X-Google-Smtp-Source: AGHT+IHVed/gFwPg3NwbqArizMKEd1Zm0qHFFBbK1/xRdnAHeLfrejbSJwY/x3ziK1rS8NcuGtq0ZQ==
X-Received: by 2002:a17:902:c146:b0:1dc:b874:583f with SMTP id 6-20020a170902c14600b001dcb874583fmr3382835plj.38.1709685559335;
        Tue, 05 Mar 2024 16:39:19 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:3e11:2c1a:c1ee:7fe1])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001da15580ca8sm11172252plh.52.2024.03.05.16.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 16:39:18 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] block: Support building the iocost and iolatency policies as kernel modules
Date: Tue,  5 Mar 2024 16:39:11 -0800
Message-ID: <20240306003911.78697-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Distributors of Linux kernel binary images, including the Android kernel
team, have to make a difficult choice: either enable the iocost and
iolatency cgroup policies in the kernel build and increase the kernel
size or disable these cgroup policies in the kernel configuration. This
patch supports building the iocost and iolatency cgroup policies as
kernel modules. This allows users to only load these policies that they
need.

If these policies are loaded as a kernel module these may be loaded
after request queues have already been created instead of before and
blkcg_policy_register() and blkcg_policy_unregister() will be called
while request queues already exist. The BFQ I/O scheduler already calls
blkcg_policy_register() and blkcg_policy_unregister() after request
queues have been created so this is not a new use case for these
functions.

The changes in this patch are as follows:
* Change 'bool' into 'tristate' in block/Kconfig for the iocost and
  iolatency controllers.
* Change #ifdef CONFIG_BLK_CGROUP_IOCOST into #if
  IS_ENABLED(CONFIG_BLK_CGROUP_IOCOST).
* Export the symbols necessary to build iocost and iolatency as kernel
  modules.
* Add MODULE_AUTHOR/LICENSE/DESCRIPTION() declarations.

Cc: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/Kconfig             | 4 ++--
 block/bio.c               | 2 +-
 block/blk-cgroup.c        | 7 ++++++-
 block/blk-iocost.c        | 4 ++++
 block/blk-iolatency.c     | 4 ++++
 block/blk-rq-qos.c        | 4 ++++
 block/blk-stat.c          | 3 +++
 fs/kernfs/dir.c           | 1 +
 include/linux/blk_types.h | 2 +-
 kernel/cgroup/cgroup.c    | 1 +
 10 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 1de4682d48cc..abbfa9c0bb8e 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -148,7 +148,7 @@ config BLK_WBT_MQ
 	Enable writeback throttling by default for request-based block devices.
 
 config BLK_CGROUP_IOLATENCY
-	bool "Enable support for latency based cgroup IO protection"
+	tristate "Enable support for latency based cgroup IO protection"
 	depends on BLK_CGROUP
 	help
 	Enabling this option enables the .latency interface for IO throttling.
@@ -168,7 +168,7 @@ config BLK_CGROUP_FC_APPID
 	  application specific identification into the FC frame.
 
 config BLK_CGROUP_IOCOST
-	bool "Enable support for cost model based cgroup IO controller"
+	tristate "Enable support for cost model based cgroup IO controller"
 	depends on BLK_CGROUP
 	select BLK_RQ_ALLOC_TIME
 	help
diff --git a/block/bio.c b/block/bio.c
index 496867b51609..32f801520282 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -262,7 +262,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	bio->bi_issue.value = 0;
 	if (bdev)
 		bio_associate_blkg(bio);
-#ifdef CONFIG_BLK_CGROUP_IOCOST
+#if IS_ENABLED(CONFIG_BLK_CGROUP_IOCOST)
 	bio->bi_iocost_cost = 0;
 #endif
 #endif
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bdbb557feb5a..d096db4fb53c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -56,7 +56,8 @@ static struct blkcg_policy *blkcg_policy[BLKCG_MAX_POLS];
 
 static LIST_HEAD(all_blkcgs);		/* protected by blkcg_pol_mutex */
 
-bool blkcg_debug_stats = false;
+bool blkcg_debug_stats;
+EXPORT_SYMBOL_GPL(blkcg_debug_stats);
 
 static DEFINE_RAW_SPINLOCK(blkg_stat_lock);
 
@@ -666,6 +667,7 @@ const char *blkg_dev_name(struct blkcg_gq *blkg)
 		return NULL;
 	return bdi_dev_name(blkg->q->disk->bdi);
 }
+EXPORT_SYMBOL_GPL(blkg_dev_name);
 
 /**
  * blkcg_print_blkgs - helper for printing per-blkg data
@@ -793,6 +795,7 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 	ctx->bdev = bdev;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(blkg_conf_open_bdev);
 
 /**
  * blkg_conf_prep - parse and prepare for per-blkg config update
@@ -1976,6 +1979,7 @@ void blkcg_schedule_throttle(struct gendisk *disk, bool use_memdelay)
 		current->use_memdelay = use_memdelay;
 	set_notify_resume(current);
 }
+EXPORT_SYMBOL_GPL(blkcg_schedule_throttle);
 
 /**
  * blkcg_add_delay - add delay to this blkg
@@ -1993,6 +1997,7 @@ void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta)
 	blkcg_scale_delay(blkg, now);
 	atomic64_add(delta, &blkg->delay_nsec);
 }
+EXPORT_SYMBOL_GPL(blkcg_add_delay);
 
 /**
  * blkg_tryget_closest - try and get a blkg ref on the closet blkg
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 4b0b483a9693..879eb699b90d 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3534,3 +3534,7 @@ static void __exit ioc_exit(void)
 
 module_init(ioc_init);
 module_exit(ioc_exit);
+
+MODULE_AUTHOR("Tejun Heo");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("blkio cost cgroup policy");
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index ebb522788d97..bac13ee02ac4 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -1069,3 +1069,7 @@ static void __exit iolatency_exit(void)
 
 module_init(iolatency_init);
 module_exit(iolatency_exit);
+
+MODULE_AUTHOR("Josef Bacik");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("blkio latency cgroup policy");
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index dd7310c94713..d2bf466ebc0e 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -22,6 +22,7 @@ bool rq_wait_inc_below(struct rq_wait *rq_wait, unsigned int limit)
 {
 	return atomic_inc_below(&rq_wait->inflight, limit);
 }
+EXPORT_SYMBOL_GPL(rq_wait_inc_below);
 
 void __rq_qos_cleanup(struct rq_qos *rqos, struct bio *bio)
 {
@@ -285,6 +286,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 	} while (1);
 	finish_wait(&rqw->wait, &data.wq);
 }
+EXPORT_SYMBOL_GPL(rq_qos_wait);
 
 void rq_qos_exit(struct request_queue *q)
 {
@@ -332,6 +334,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 	blk_mq_unfreeze_queue(q);
 	return -EBUSY;
 }
+EXPORT_SYMBOL_GPL(rq_qos_add);
 
 void rq_qos_del(struct rq_qos *rqos)
 {
@@ -353,3 +356,4 @@ void rq_qos_del(struct rq_qos *rqos)
 	blk_mq_debugfs_unregister_rqos(rqos);
 	mutex_unlock(&q->debugfs_mutex);
 }
+EXPORT_SYMBOL_GPL(rq_qos_del);
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 7ff76ae6c76a..639d9887ad91 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -23,6 +23,7 @@ void blk_rq_stat_init(struct blk_rq_stat *stat)
 	stat->max = stat->nr_samples = stat->mean = 0;
 	stat->batch = 0;
 }
+EXPORT_SYMBOL_GPL(blk_rq_stat_init);
 
 /* src is a per-cpu stat, mean isn't initialized */
 void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
@@ -38,6 +39,7 @@ void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 
 	dst->nr_samples += src->nr_samples;
 }
+EXPORT_SYMBOL_GPL(blk_rq_stat_sum);
 
 void blk_rq_stat_add(struct blk_rq_stat *stat, u64 value)
 {
@@ -46,6 +48,7 @@ void blk_rq_stat_add(struct blk_rq_stat *stat, u64 value)
 	stat->batch += value;
 	stat->nr_samples++;
 }
+EXPORT_SYMBOL_GPL(blk_rq_stat_add);
 
 void blk_stat_add(struct request *rq, u64 now)
 {
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index bce1d7ac95ca..6893c7edc6b6 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -279,6 +279,7 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
 out:
 	spin_unlock_irqrestore(&kernfs_pr_cont_lock, flags);
 }
+EXPORT_SYMBOL_GPL(pr_cont_kernfs_path);
 
 /**
  * kernfs_get_parent - determine the parent node and pin it
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 1c07848dea7e..a58c4d2f8438 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -244,7 +244,7 @@ struct bio {
 	 */
 	struct blkcg_gq		*bi_blkg;
 	struct bio_issue	bi_issue;
-#ifdef CONFIG_BLK_CGROUP_IOCOST
+#if IS_ENABLED(CONFIG_BLK_CGROUP_IOCOST)
 	u64			bi_iocost_cost;
 #endif
 #endif
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a66c088c851c..9b30123af809 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6950,6 +6950,7 @@ int cgroup_parse_float(const char *input, unsigned dec_shift, s64 *v)
 	*v = whole * power_of_ten(dec_shift) + frac;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cgroup_parse_float);
 
 /*
  * sock->sk_cgrp_data handling.  For more info, see sock_cgroup_data
