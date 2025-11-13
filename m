Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6209430EF6E
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763065413; cv=none; b=lK9DXR26AQk0f0lr2lesE0gCfYCjDyrDcdEmXuhKYwZsO9UbwXU7XGyKNBJ/PlwwZeNEYJJkI4lFw29u8xYl+l3UD4UMc2n8mN5sNFhi2zQ+uP7i79RyouZYtBpoidHJeRt+Oa/nCNsAAsOhmbj+zS/3X+0OIrCTnnFFZuRs8NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763065413; c=relaxed/simple;
	bh=Xd8e9PxFt/1T1ILnDz5UmK744w7sLUGsU4XrNqGphBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eMHLiDu0dFRu8ssNwHzhmZ2URn8kF4uaGrgaRjcypfzzzfK2ks0xNHyVDRnasRH/n/SD4WGv7jSYJdJupgvup6hjfB0T8tBHhgxjvRfgwNXx9V4z8XKmtThEYFw0KzHC0WjhFNEerQH0KiQmStILkBdunvDtKcaIzMAfmSrjJnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SVliUJ6u; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SVliUJ6u"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b55517e74e3so1048803a12.2
        for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 12:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763065410; x=1763670210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6+cxABZnS3YSrSISK/yjuFruYB/W5uByVrGxiYBwl4=;
        b=SVliUJ6uqDI7tqPv/JoKeWP+k7eKoBS8K7aVqSN6QNflvDj5QdgZWcLqfYeH/gOfcS
         zOl48plrQm6Mz2pbJsH9/lD4BR5Kh7ZixOYgrOk6NH1bolzz9e9OsGVzWrsVlYb1xxiF
         QYTdQ1v6+hY3Qvgl0hGIELEFuq3mJJPp6ttRfHqktELRrFyU9zOHrvKAFyukirouiw5F
         FiQikt2dwxAe4SEpQUxecGjVZShPqLcMTE/7qa6z+yA4zsa5KrnBdTxfOhDrY07yosQn
         BVZMDNktUkeRr35+qiHS8tYGeHO0sC+VvRYukCHLfFC2TcP0IEmZ90D6CYob9E4ZpiGr
         nMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763065410; x=1763670210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6+cxABZnS3YSrSISK/yjuFruYB/W5uByVrGxiYBwl4=;
        b=loLKJHNUDFXZpIr4NeDCZQFqYkGTYKG8yY0RR2+CXbEcFkgrkJlAnYw2s6H4V45W+W
         Xh5bCRgSi1O/5JEXc25QnWypCZVgvTIo9B+KWM99qxsxVgwL5UQe2PG8g1zdBSMH0K/j
         BQQFJkeGmKx2f53vOzDEJ9F+0hMdIwHnC1CeNTGfPTNeMj128GzxHPEJTMfgsEIeXfyk
         MbP69qV6im5+ggoGpGb9gHrwvgLqJYL6qHihlO9b6qGP6aoAl7q51U2+Pn5+B90q0GJr
         F6TaaTtpahtIFHJOUB3o39pQjCBbVJLGWHbTos0wB12KUMDRMozUZiTROA3w/cuAMW4E
         JKSg==
X-Forwarded-Encrypted: i=1; AJvYcCVkRxux2DjgbWHeAim7ZBeq5WnIsTDRFLt/FDt3xMJiwzHOGqrN2uqnFhk/kM9R1/77AkrUbRO/QeRNWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ3IvnuSLCJjNRsxMJuOwgFtWPM3CEJNjIBRX6x7VGkodyMsZP
	9+C8faG7y7DyYAwJbhuvPeAazL3TQ0erUAh22y/W3fKIepIF1TAVBbCsaRLiK6EgOrY=
X-Gm-Gg: ASbGncu85tYYT245Xl9b2n8Kj6Mwrbg5pa7y2kMUu6IvJMHyPSYhT9owPS1TdPHsXvT
	Re+qNVGJC3UKv21ZFeYsbuCz7W0DNnZ8NLLV8dI94NhjoBjBz48vZ1if+sPgOjvMY2IAFS/eTUF
	3aDE1bLxkfe6frtIHciFaWKofuXTvH3BgUlnr0LawIsvXWPX9mKOiSKV/U5PwlRC92yBNwS5dzi
	V38LYpr7ipcKbidVVOmANqlbbMK2vIOfZd75BPWDQ7yLwVJ+2O8rFGmqGPAKluAum+pJfjezw/y
	DGvzccHkmy7mWaXfrCB5BizT37D1nbHKqrea7e0zEa/pWFqukd0VkdXjCkPZ3sjz668aFiZ2hzq
	9LQwVf0kreSDbLIPi84ce8TfQsbY+Lk1vxfnoPEdWOfLLfjloo8kuegnxZ1oE6IyaxTyqd/ghAl
	UUGN1YTjDXXjJ7M06w/2Y8kxpf6h+uI82oPQ==
X-Google-Smtp-Source: AGHT+IEYO/JgfmWFmQJJ50sNXc0ugIY37iQsusoHNsW0AfOtpwPE5bHkyVT0KdhbbYmvBIUvJBEA/Q==
X-Received: by 2002:a05:7022:984:b0:11a:2ec0:dd02 with SMTP id a92af1059eb24-11b41605e91mr305714c88.33.1763065410097;
        Thu, 13 Nov 2025 12:23:30 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11b060885cdsm1151961c88.6.2025.11.13.12.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 12:23:29 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Casey Chen <cachen@purestorage.com>,
	Vikas Manocha <vmanocha@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH] nvme: Convert tag_list mutex to rwsemaphore to avoid deadlock
Date: Thu, 13 Nov 2025 12:23:20 -0800
Message-ID: <20251113202320.2530531-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
tagset, the functions make sure that tagset and queues are marked as
shared when two or more queues are attached to the same tagset.
Initially a tagset starts as unshared and when the number of added
queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
with all the queues attached to it. When the number of attached queues
drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
the remaining queues as unshared.

Both functions need to freeze current queues in tagset before setting on
unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
hold set->tag_list_lock mutex, which makes sense as we do not want
queues to be added or deleted in the process. This used to work fine
until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
made the nvme driver quiesce tagset instead of quiscing individual
queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
set->tag_list while holding set->tag_list_lock also.

This results in deadlock between two threads with these stacktraces:

  __schedule+0x48e/0xed0
  schedule+0x5a/0xc0
  schedule_preempt_disabled+0x11/0x20
  __mutex_lock.constprop.0+0x3cc/0x760
  blk_mq_quiesce_tagset+0x26/0xd0
  nvme_dev_disable_locked+0x77/0x280 [nvme]
  nvme_timeout+0x268/0x320 [nvme]
  blk_mq_handle_expired+0x5d/0x90
  bt_iter+0x7e/0x90
  blk_mq_queue_tag_busy_iter+0x2b2/0x590
  ? __blk_mq_complete_request_remote+0x10/0x10
  ? __blk_mq_complete_request_remote+0x10/0x10
  blk_mq_timeout_work+0x15b/0x1a0
  process_one_work+0x133/0x2f0
  ? mod_delayed_work_on+0x90/0x90
  worker_thread+0x2ec/0x400
  ? mod_delayed_work_on+0x90/0x90
  kthread+0xe2/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x2d/0x50
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20

  __schedule+0x48e/0xed0
  schedule+0x5a/0xc0
  blk_mq_freeze_queue_wait+0x62/0x90
  ? destroy_sched_domains_rcu+0x30/0x30
  blk_mq_exit_queue+0x151/0x180
  disk_release+0xe3/0xf0
  device_release+0x31/0x90
  kobject_put+0x6d/0x180
  nvme_scan_ns+0x858/0xc90 [nvme_core]
  ? nvme_scan_work+0x281/0x560 [nvme_core]
  nvme_scan_work+0x281/0x560 [nvme_core]
  process_one_work+0x133/0x2f0
  ? mod_delayed_work_on+0x90/0x90
  worker_thread+0x2ec/0x400
  ? mod_delayed_work_on+0x90/0x90
  kthread+0xe2/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x2d/0x50
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20

The top stacktrace is showing nvme_timeout() called to handle nvme
command timeout. timeout handler is trying to disable the controller and
as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
to call queue callback handlers. The thread is stuck waiting for
set->tag_list_lock as it tires to walk the queues in set->tag_list.

The lock is held by the second thread in the bottom stack which is
waiting for one of queues to be frozen. The queue usage counter will
drop to zero after nvme_timeout() finishes, and this will not happen
because the thread will wait for this mutex forever.

Convert set->tag_list_lock mutex to set->tag_list_rwsem rwsemaphore to
avoid the deadlock. Update blk_mq_[un]quiesce_tagset() to take the
semaphore for read since this is enough to guarantee no queues will be
added or removed. Update blk_mq_{add,del}_queue_tag_set() to take the
semaphore for write while updating set->tag_list and downgrade it to
read while freezing the queues. It should be safe to update set->flags
and hctx->flags while holding the semaphore for read since the queues
are already frozen.

Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 block/blk-mq-sysfs.c   | 10 +++----
 block/blk-mq.c         | 63 ++++++++++++++++++++++--------------------
 include/linux/blk-mq.h |  4 +--
 3 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 58ec293373c6..f474781654fb 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -230,13 +230,13 @@ int blk_mq_sysfs_register(struct gendisk *disk)
 
 	kobject_uevent(q->mq_kobj, KOBJ_ADD);
 
-	mutex_lock(&q->tag_set->tag_list_lock);
+	down_read(&q->tag_set->tag_list_rwsem);
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
 		if (ret)
 			goto out_unreg;
 	}
-	mutex_unlock(&q->tag_set->tag_list_lock);
+	up_read(&q->tag_set->tag_list_rwsem);
 	return 0;
 
 out_unreg:
@@ -244,7 +244,7 @@ int blk_mq_sysfs_register(struct gendisk *disk)
 		if (j < i)
 			blk_mq_unregister_hctx(hctx);
 	}
-	mutex_unlock(&q->tag_set->tag_list_lock);
+	up_read(&q->tag_set->tag_list_rwsem);
 
 	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(q->mq_kobj);
@@ -257,10 +257,10 @@ void blk_mq_sysfs_unregister(struct gendisk *disk)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-	mutex_lock(&q->tag_set->tag_list_lock);
+	down_read(&q->tag_set->tag_list_rwsem);
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
-	mutex_unlock(&q->tag_set->tag_list_lock);
+	up_read(&q->tag_set->tag_list_rwsem);
 
 	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(q->mq_kobj);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d626d32f6e57..1770277fe453 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -335,12 +335,12 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
 {
 	struct request_queue *q;
 
-	mutex_lock(&set->tag_list_lock);
+	down_read(&set->tag_list_rwsem);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		if (!blk_queue_skip_tagset_quiesce(q))
 			blk_mq_quiesce_queue_nowait(q);
 	}
-	mutex_unlock(&set->tag_list_lock);
+	up_read(&set->tag_list_rwsem);
 
 	blk_mq_wait_quiesce_done(set);
 }
@@ -350,12 +350,12 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
 {
 	struct request_queue *q;
 
-	mutex_lock(&set->tag_list_lock);
+	down_read(&set->tag_list_rwsem);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		if (!blk_queue_skip_tagset_quiesce(q))
 			blk_mq_unquiesce_queue(q);
 	}
-	mutex_unlock(&set->tag_list_lock);
+	up_read(&set->tag_list_rwsem);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
 
@@ -4280,7 +4280,7 @@ static void blk_mq_update_tag_set_shared(struct blk_mq_tag_set *set,
 	struct request_queue *q;
 	unsigned int memflags;
 
-	lockdep_assert_held(&set->tag_list_lock);
+	lockdep_assert_held(&set->tag_list_rwsem);
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		memflags = blk_mq_freeze_queue(q);
@@ -4293,37 +4293,40 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 
-	mutex_lock(&set->tag_list_lock);
+	down_write(&set->tag_list_rwsem);
 	list_del(&q->tag_set_list);
-	if (list_is_singular(&set->tag_list)) {
-		/* just transitioned to unshared */
-		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
-		/* update existing queue */
-		blk_mq_update_tag_set_shared(set, false);
+	if (!list_is_singular(&set->tag_list)) {
+		up_write(&set->tag_list_rwsem);
+		goto out;
 	}
-	mutex_unlock(&set->tag_list_lock);
+
+	/* Transitioning to unshared. */
+	set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
+	downgrade_write(&set->tag_list_rwsem);
+	blk_mq_update_tag_set_shared(set, false);
+	up_read(&set->tag_list_rwsem);
+out:
 	INIT_LIST_HEAD(&q->tag_set_list);
 }
 
 static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 				     struct request_queue *q)
 {
-	mutex_lock(&set->tag_list_lock);
+	down_write(&set->tag_list_rwsem);
+	if (!list_is_singular(&set->tag_list)) {
+		if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+			queue_set_hctx_shared(q, true);
+		list_add_tail(&q->tag_set_list, &set->tag_list);
+		up_write(&set->tag_list_rwsem);
+		return;
+	}
 
-	/*
-	 * Check to see if we're transitioning to shared (from 1 to 2 queues).
-	 */
-	if (!list_empty(&set->tag_list) &&
-	    !(set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
-		set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
-		/* update existing queue */
-		blk_mq_update_tag_set_shared(set, true);
-	}
-	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-		queue_set_hctx_shared(q, true);
+	/* Transitioning to shared. */
+	set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
 	list_add_tail(&q->tag_set_list, &set->tag_list);
-
-	mutex_unlock(&set->tag_list_lock);
+	downgrade_write(&set->tag_list_rwsem);
+	blk_mq_update_tag_set_shared(set, true);
+	up_read(&set->tag_list_rwsem);
 }
 
 /* All allocations will be freed in release handler of q->mq_kobj */
@@ -4855,7 +4858,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (ret)
 		goto out_free_mq_map;
 
-	mutex_init(&set->tag_list_lock);
+	init_rwsem(&set->tag_list_rwsem);
 	INIT_LIST_HEAD(&set->tag_list);
 
 	return 0;
@@ -5044,7 +5047,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	struct xarray elv_tbl, et_tbl;
 	bool queues_frozen = false;
 
-	lockdep_assert_held(&set->tag_list_lock);
+	lockdep_assert_held_write(&set->tag_list_rwsem);
 
 	if (set->nr_maps == 1 && nr_hw_queues > nr_cpu_ids)
 		nr_hw_queues = nr_cpu_ids;
@@ -5129,9 +5132,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 {
 	down_write(&set->update_nr_hwq_lock);
-	mutex_lock(&set->tag_list_lock);
+	down_write(&set->tag_list_rwsem);
 	__blk_mq_update_nr_hw_queues(set, nr_hw_queues);
-	mutex_unlock(&set->tag_list_lock);
+	up_write(&set->tag_list_rwsem);
 	up_write(&set->update_nr_hwq_lock);
 }
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b25d12545f46..4c8441671518 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -502,7 +502,7 @@ enum hctx_type {
  * @shared_tags:
  *		   Shared set of tags. Has @nr_hw_queues elements. If set,
  *		   shared by all @tags.
- * @tag_list_lock: Serializes tag_list accesses.
+ * @tag_list_rwsem: Serializes tag_list accesses.
  * @tag_list:	   List of the request queues that use this tag set. See also
  *		   request_queue.tag_set_list.
  * @srcu:	   Use as lock when type of the request queue is blocking
@@ -530,7 +530,7 @@ struct blk_mq_tag_set {
 
 	struct blk_mq_tags	*shared_tags;
 
-	struct mutex		tag_list_lock;
+	struct rw_semaphore	tag_list_rwsem;
 	struct list_head	tag_list;
 	struct srcu_struct	*srcu;
 	struct srcu_struct	tags_srcu;
-- 
2.51.0

