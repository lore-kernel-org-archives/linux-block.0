Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AD633F39E
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763411104; cv=none; b=O2FbySyxoi0xITtoSiAAYdcUy937Pb+T4dU3AzQLm8mJdIXRoDyJW2e7/sM2Qpd1YE97UE5WmhRGkkVFvbgJqMg/TPQOIeqEMr9wDaVoae+5FIuQ6j/ubd38bCJVpMXXNAb7cqTVwC3LUfWP0LaWFzH1qpHu1eLtCQDGmXK5/yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763411104; c=relaxed/simple;
	bh=3UDBUKAqRk5CFdQFEYaPWsQgkn5sB9aDlg+wgYeT7Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzwrQvRjpr7JeYfaCM2AWIE//RGN0LD6atkJtxdv+PneH5MGNKEy/BAhEpA0fN2oDl27MJMaa47wuxQbee0Tf7viS1Wlqg8z+4R7e01FVyS40Mu0fwHAzusioA0rgmlXpjA+/J825uYdwz9CXy9rpzH5kPXwXPTApsM5D1a1fMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SD5eg7VF; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SD5eg7VF"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso3410923a12.3
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 12:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763411085; x=1764015885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyF6/V4nS8wYWlGdOSa2UCNoJb0kxdxyGdDvo969ZXQ=;
        b=SD5eg7VFjJ62WIsjbU+si2vyTjrpppN1sb63C45Q6fpgvURJhFbXaw+6wXupfLwHnF
         z+g9HMxAOGKj2ZP4HyzqJyBy3tZnOQzmEzEqHsHdL2NPL6F+yBcLyy4F4WUA1HO98IJX
         bUMscmlwZd/lnu1jgzefePvDMdwvv2oVozR7QztTP4fyuTF+klo9ofTcbqW56MCe3EPr
         9QyhJrw4yb720F4c+YyFNL+FQMawVCDor7xY0VdMoHZKC5cOVn2rRVWfnNH9Bz5jfhg3
         xomJtyGk9x4B28l9yl5wtn6Jimg3FXu4ywA/t1M5A/OfngvlemRlCfC6jkbN/BfbXuwG
         pBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763411085; x=1764015885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HyF6/V4nS8wYWlGdOSa2UCNoJb0kxdxyGdDvo969ZXQ=;
        b=I0FoV/sUgqTeeptqn2YjZw5dh76RhWWeO+e6oYDQEV5Dno4BfULpe4TRuopwGQW5/v
         rFJ5S3NKfS9gVe72DS6rOHdQKxhojYJeMSB/PKML64tj3/GOiDNmHOo0AQ5ywmHC559S
         y8fQTjAhl2UdCyD9VCb+diO/p6BtunIPyG2M1DXTi8X0JyoqNaw1GlWj36VgewEgCVW0
         Hx2k6ibRu1MwV0iOIdgi9YsqtBA02/Hw1IqjjVLub4yt9plXuNbODFNPMDLzcOhYvsw6
         W9ojgntHVL7/KdVYtzuxvrwIvJt4cCK/Hwk0g8ZA/1rkJKB8NrTDOwWd3QWdEEtB9KMC
         sy6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCazHSiZ3AG4WiS4MAHaH32w5e1bAPQ+HtVtjaSUMrKAvb527Iy1U+r1qDzjKcBCCSTjZPNtm85NmwNg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm31iSaXjJsG412TJeS+VARx0cjpW33Fnq1Wn8/fkiBsHxNWHj
	HlUlT9FcCFxHir0bTE0buzUZYTlzVnCOWXqdQunMwZmWJ+TfgPGD9JHatfxMxV+zR18=
X-Gm-Gg: ASbGncsJBf++u15pp568m+vgFytH7PeY048R7m01+15dje+RVyJ0VtoXBrXSJCmw+bV
	nJ94L8A8bO+gFyNs1mCuHYyscuz+35qA0mbeBGa525qEc8CHA5qm9dk+/C4XP8x3RZGvTjx7zJQ
	Nrq7WR3O/DpqwKCTDf8QHkS6aQ353AztTq6Nk8BgVrQgnVE7QF9J3G6OUwit/bIUZZul2sQ0rIx
	VB+ASiSD5z19xqnC3LDH6LANhTyrUcs62g8acq403u+OTtwCWk534Hl5pPmxm1sGE10WgW5Dk6Q
	IeRUwCQFQa6C0Qc9Ewd+T42fLl9rjSReTPW38f9HM/Ul1IV4WKNmZaLcyT93X80tNfH5yD9h1yB
	uGAxbIoRoYvZjThlA/MDnPYgcVyQvTwNpj51we+C8WDYIwBjBZT+rU+wH7zfScyUYT8OZmRChS4
	NOE5oyoTC1cN5gNRSEKmOC/6ymd4EG3C/ChDrDzx4oJOwT5Fwx4N10nKw=
X-Google-Smtp-Source: AGHT+IGAK8CgmTY+UZx0Sv+IjKS2O7b9jc98OXKXQYt3KWF2GTn3BjqKch0SpUJq0k9Oh0eqhxxLUg==
X-Received: by 2002:a05:7300:a987:b0:2a4:3593:6464 with SMTP id 5a478bee46e88-2a4abb1c750mr7667244eec.20.1763411084735;
        Mon, 17 Nov 2025 12:24:44 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2a49db7a753sm49298281eec.6.2025.11.17.12.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 12:24:44 -0800 (PST)
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
Subject: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to avoid deadlock
Date: Mon, 17 Nov 2025 12:23:53 -0800
Message-ID: <20251117202414.4071380-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117202414.4071380-1-mkhalfella@purestorage.com>
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
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
 block/blk-mq-sysfs.c   | 10 ++---
 block/blk-mq.c         | 95 +++++++++++++++++++++++-------------------
 include/linux/blk-mq.h |  4 +-
 3 files changed, 58 insertions(+), 51 deletions(-)

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
index d626d32f6e57..9211d32ce820 100644
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
 
@@ -4274,56 +4274,63 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
 	}
 }
 
-static void blk_mq_update_tag_set_shared(struct blk_mq_tag_set *set,
-					 bool shared)
-{
-	struct request_queue *q;
-	unsigned int memflags;
-
-	lockdep_assert_held(&set->tag_list_lock);
-
-	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		memflags = blk_mq_freeze_queue(q);
-		queue_set_hctx_shared(q, shared);
-		blk_mq_unfreeze_queue(q, memflags);
-	}
-}
-
 static void blk_mq_del_queue_tag_set(struct request_queue *q)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
+	struct request_queue *firstq;
+	unsigned int memflags;
 
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
+	/*
+	 * Transitioning the remaining firstq to unshared.
+	 * Also, downgrade the semaphore to avoid deadlock
+	 * with blk_mq_quiesce_tagset() while waiting for
+	 * firstq to be frozen.
+	 */
+	set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
+	downgrade_write(&set->tag_list_rwsem);
+	firstq = list_first_entry(&set->tag_list, struct request_queue,
+				  tag_set_list);
+	memflags = blk_mq_freeze_queue(firstq);
+	queue_set_hctx_shared(firstq, false);
+	blk_mq_unfreeze_queue(firstq, memflags);
+	up_read(&set->tag_list_rwsem);
+out:
 	INIT_LIST_HEAD(&q->tag_set_list);
 }
 
 static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 				     struct request_queue *q)
 {
-	mutex_lock(&set->tag_list_lock);
+	struct request_queue *firstq;
+	unsigned int memflags;
 
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
-	list_add_tail(&q->tag_set_list, &set->tag_list);
+	down_write(&set->tag_list_rwsem);
+	if (!list_is_singular(&set->tag_list)) {
+		if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+			queue_set_hctx_shared(q, true);
+		list_add_tail(&q->tag_set_list, &set->tag_list);
+		up_write(&set->tag_list_rwsem);
+		return;
+	}
 
-	mutex_unlock(&set->tag_list_lock);
+	/* Transitioning firstq and q to shared. */
+	set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
+	list_add_tail(&q->tag_set_list, &set->tag_list);
+	downgrade_write(&set->tag_list_rwsem);
+	queue_set_hctx_shared(q, true);
+	firstq = list_first_entry(&set->tag_list, struct request_queue,
+				  tag_set_list);
+	memflags = blk_mq_freeze_queue(firstq);
+	queue_set_hctx_shared(firstq, true);
+	blk_mq_unfreeze_queue(firstq, memflags);
+	up_read(&set->tag_list_rwsem);
 }
 
 /* All allocations will be freed in release handler of q->mq_kobj */
@@ -4855,7 +4862,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (ret)
 		goto out_free_mq_map;
 
-	mutex_init(&set->tag_list_lock);
+	init_rwsem(&set->tag_list_rwsem);
 	INIT_LIST_HEAD(&set->tag_list);
 
 	return 0;
@@ -5044,7 +5051,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	struct xarray elv_tbl, et_tbl;
 	bool queues_frozen = false;
 
-	lockdep_assert_held(&set->tag_list_lock);
+	lockdep_assert_held_write(&set->tag_list_rwsem);
 
 	if (set->nr_maps == 1 && nr_hw_queues > nr_cpu_ids)
 		nr_hw_queues = nr_cpu_ids;
@@ -5129,9 +5136,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
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

