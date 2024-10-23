Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F1C1A7271
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677316; cv=none; b=B5vO4mVYmhGm951MZPDeM4yGwRlUsFWG/RI6FzSyLSVQn/x2LwnNCQunne+mG++GGiuTCanQfBgwVGASqMyTtwTxPsHW4ImNrrSeOtUKStj1LMgtHkTfNWhqLa6Oe9q4ZTfGg82kR0EKwmx4AsACu2FJckluA3+7qY/nKQltV6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677316; c=relaxed/simple;
	bh=+FVdnVre7ofwoYH68Sy4BzXcOlIiJ2nUaR3uwNdr1gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t17snfj3fh92bA55n8VaYpNwmh6A0ij5Oa/45rvmo3DWXpxc0OtTKTWh2LA0e6034Pr3/5EEPZs5lL7KoFkEssBSqoO/U0LYg1RJ7HLKFHt5yIYyl+lKZZxTfemKRqwENsfhtYwGPSUWnxhuc+aWU7EFCfTo6JPUxIqqy8Tb3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hqnjyEJ7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqnjyEJ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729677313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fChrjJ4PBXmjzA74oq7U7p9U5IYVMMbrVBQiegw/Jo=;
	b=hqnjyEJ7Ncf+mC+m6K6VCj9eDQHlYWmzA96uI9dnA91mMMzX0+JSwyP2JvNgca+roQ9smM
	cOeKfjxTXRjzgxft3IoINhl/G7RhpEf8AJygZ8oipICRr+rtSDr38Iyb13j0j2WVG/Kmao
	Wg5PPoM2bYIDGiR8kl+LiTc74RqMueU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-JsdOgAHqOP2Uo6xuvAd7IA-1; Wed,
 23 Oct 2024 05:55:10 -0400
X-MC-Unique: JsdOgAHqOP2Uo6xuvAd7IA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA19E1956083;
	Wed, 23 Oct 2024 09:55:08 +0000 (UTC)
Received: from localhost (unknown [10.72.116.171])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D8D81956056;
	Wed, 23 Oct 2024 09:55:07 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/3] block: model freeze & enter queue as lock for supporting lockdep
Date: Wed, 23 Oct 2024 17:54:35 +0800
Message-ID: <20241023095438.3451156-4-ming.lei@redhat.com>
In-Reply-To: <20241023095438.3451156-1-ming.lei@redhat.com>
References: <20241023095438.3451156-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Recently we got several deadlock report[1][2][3] caused by blk_mq_freeze_queue
and blk_enter_queue().

Turns out the two are just like acquiring read/write lock, so model them as
read/write lock for supporting lockdep:

1) model q->q_usage_counter as two locks(io and queue lock)
- queue lock covers sync with blk_enter_queue()

- io lock covers sync with bio_enter_queue()

2) make the lockdep class/key as per-queue:

- different subsystem has very different lock use pattern, shared lock class
causes false positive easily

- freeze_queue degrades to no lock in case that disk state becomes DEAD because
  bio_enter_queue() won't be blocked any more

- freeze_queue degrades to no lock in case that request queue becomes dying
  because blk_enter_queue() won't be blocked any more

3) model blk_mq_freeze_queue() as acquire_exclusive & try_lock
- it is exclusive lock, so dependency with blk_enter_queue() is covered

- it is trylock because blk_mq_freeze_queue() are allowed to run concurrently

4) model blk_enter_queue() & bio_enter_queue() as acquire_read()
- nested blk_enter_queue() are allowed

- dependency with blk_mq_freeze_queue() is covered

- blk_queue_exit() is often called from other contexts(such as irq), and
it can't be annotated as lock_release(), so simply do it in
blk_enter_queue(), this way still covered cases as many as possible

With lockdep support, such kind of reports may be reported asap and
needn't wait until the real deadlock is triggered.

For example, the following lockdep report can be triggered in the
report[3].

[   31.671822] ======================================================
[   31.673169] WARNING: possible circular locking dependency detected
[   31.674456] 6.11.0_nbd+ #411 Not tainted
[   31.675220] ------------------------------------------------------
[   31.676379] bash/1425 is trying to acquire lock:
[   31.676861] ffff990b8ea27530 (&q->limits_lock){+.+.}-{3:3}, at: queue_wc_store+0x8e/0x180
[   31.677268]
               but task is already holding lock:
[   31.677548] ffff990b8ea27410 (&q->sysfs_lock){+.+.}-{3:3}, at: queue_attr_store+0x75/0xc0
[   31.677931]
               which lock already depends on the new lock.

[   31.678315]
               the existing dependency chain (in reverse order) is:
[   31.678664]
               -> #2 (&q->sysfs_lock){+.+.}-{3:3}:
[   31.678951]        __mutex_lock+0xad/0xb20
[   31.679157]        queue_attr_store+0x75/0xc0
[   31.679366]        kernfs_fop_write_iter+0x15c/0x210
[   31.679608]        vfs_write+0x2a7/0x540
[   31.679801]        ksys_write+0x75/0x100
[   31.679999]        do_syscall_64+0x95/0x180
[   31.680209]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   31.680488]
               -> #1 (&q->q_usage_counter(queue)#2){++++}-{0:0}:
[   31.680839]        blk_queue_enter+0x195/0x1d0
[   31.681060]        blk_mq_alloc_request+0x136/0x2d0
[   31.681301]        scsi_execute_cmd+0x9c/0x4c0
[   31.681528]        read_capacity_16+0x116/0x410
[   31.681765]        sd_revalidate_disk.isra.0+0x54d/0x2f00
[   31.682044]        sd_probe+0x2ec/0x520
[   31.682238]        really_probe+0xd3/0x390
[   31.682445]        __driver_probe_device+0x78/0x150
[   31.682682]        driver_probe_device+0x1f/0x90
[   31.682908]        __device_attach_driver+0x89/0x110
[   31.683161]        bus_for_each_drv+0x95/0xf0
[   31.683377]        __device_attach_async_helper+0xa7/0xf0
[   31.683639]        async_run_entry_fn+0x31/0x130
[   31.683875]        process_one_work+0x212/0x700
[   31.684100]        worker_thread+0x1ce/0x380
[   31.684308]        kthread+0xd2/0x110
[   31.684490]        ret_from_fork+0x31/0x50
[   31.684700]        ret_from_fork_asm+0x1a/0x30
[   31.684922]
               -> #0 (&q->limits_lock){+.+.}-{3:3}:
[   31.685499]        __lock_acquire+0x15c0/0x23e0
[   31.685872]        lock_acquire+0xd8/0x300
[   31.686207]        __mutex_lock+0xad/0xb20
[   31.686535]        queue_wc_store+0x8e/0x180
[   31.686877]        queue_attr_store+0x84/0xc0
[   31.687231]        kernfs_fop_write_iter+0x15c/0x210
[   31.687594]        vfs_write+0x2a7/0x540
[   31.687907]        ksys_write+0x75/0x100
[   31.688219]        do_syscall_64+0x95/0x180
[   31.688534]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   31.688910]
               other info that might help us debug this:

[   31.689621] Chain exists of:
                 &q->limits_lock --> &q->q_usage_counter(queue)#2 --> &q->sysfs_lock

[   31.690549]  Possible unsafe locking scenario:

[   31.691060]        CPU0                    CPU1
[   31.691389]        ----                    ----
[   31.691716]   lock(&q->sysfs_lock);
[   31.691999]                                lock(&q->q_usage_counter(queue)#2);
[   31.692460]                                lock(&q->sysfs_lock);
[   31.692863]   lock(&q->limits_lock);
[   31.693155]
                *** DEADLOCK ***

[   31.693746] 6 locks held by bash/1425:
[   31.694043]  #0: ffff990b8007e420 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x75/0x100
[   31.694543]  #1: ffff990bcf1a3288 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x115/0x210
[   31.695119]  #2: ffff990b91888378 (kn->active#166){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x11e/0x210
[   31.695685]  #3: ffff990b8ea26ee8 (&q->q_usage_counter(io)#2){++++}-{0:0}, at: queue_attr_store+0x60/0xc0
[   31.696269]  #4: ffff990b8ea26f20 (&q->q_usage_counter(queue)#2){++++}-{0:0}, at: queue_attr_store+0x60/0xc0
[   31.696846]  #5: ffff990b8ea27410 (&q->sysfs_lock){+.+.}-{3:3}, at: queue_attr_store+0x75/0xc0
[   31.697381]
               stack backtrace:
[   31.697826] CPU: 9 UID: 0 PID: 1425 Comm: bash Not tainted 6.11.0_nbd+ #411
[   31.698285] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39 04/01/2014
[   31.698807] Call Trace:
[   31.699058]  <TASK>
[   31.699289]  dump_stack_lvl+0x93/0xf0
[   31.699598]  print_circular_bug+0x26e/0x340
[   31.699924]  check_noncircular+0x16c/0x190
[   31.700251]  ? lock_acquire+0x2a1/0x300
[   31.700561]  __lock_acquire+0x15c0/0x23e0
[   31.700877]  lock_acquire+0xd8/0x300
[   31.701181]  ? queue_wc_store+0x8e/0x180
[   31.701502]  __mutex_lock+0xad/0xb20
[   31.701806]  ? queue_wc_store+0x8e/0x180
[   31.702128]  ? queue_wc_store+0x8e/0x180
[   31.702446]  ? queue_wc_store+0x8e/0x180
[   31.702761]  queue_wc_store+0x8e/0x180
[   31.703084]  ? __mutex_lock+0xad/0xb20
[   31.703385]  ? __mutex_lock+0x6e4/0xb20
[   31.703691]  ? mark_held_locks+0x40/0x70
[   31.704004]  ? queue_attr_store+0x75/0xc0
[   31.704317]  queue_attr_store+0x84/0xc0
[   31.704643]  kernfs_fop_write_iter+0x15c/0x210
[   31.704987]  vfs_write+0x2a7/0x540
[   31.705274]  ksys_write+0x75/0x100
[   31.705559]  do_syscall_64+0x95/0x180
[   31.705864]  ? do_user_addr_fault+0x361/0x790
[   31.706239]  ? trace_hardirqs_off+0x4b/0xc0
[   31.706564]  ? clear_bhb_loop+0x25/0x80
[   31.706966]  ? clear_bhb_loop+0x25/0x80
[   31.707272]  ? clear_bhb_loop+0x25/0x80
[   31.707568]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   31.707927] RIP: 0033:0x7fb69d85e174
[   31.708227] Code: 89 02 48 c7 c0 ff ff ff ff eb bd 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 80 3d 6d b4 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
[   31.709343] RSP: 002b:00007ffed933fb48 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   31.709834] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fb69d85e174
[   31.710311] RDX: 0000000000000005 RSI: 000055713d6fb7d0 RDI: 0000000000000001
[   31.710779] RBP: 00007ffed933fb70 R08: 0000000000000073 R09: 0000000000000001
[   31.711263] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000005
[   31.711755] R13: 000055713d6fb7d0 R14: 00007fb69d932780 R15: 0000000000000005
[   31.712242]  </TASK>

[1] occasional block layer hang when setting 'echo noop > /sys/block/sda/queue/scheduler'
https://bugzilla.kernel.org/show_bug.cgi?id=219166

[2] del_gendisk() vs blk_queue_enter() race condition
https://lore.kernel.org/linux-block/20241003085610.GK11458@google.com/

[3] queue_freeze & queue_enter deadlock in scsi
https://lore.kernel.org/linux-block/ZxG38G9BuFdBpBHZ@fedora/T/#u

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c       | 18 ++++++++++++++++--
 block/blk-mq.c         | 26 ++++++++++++++++++++++----
 block/blk.h            | 29 ++++++++++++++++++++++++++---
 block/genhd.c          | 15 +++++++++++----
 include/linux/blkdev.h |  6 ++++++
 5 files changed, 81 insertions(+), 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bc5e8c5eaac9..09d10bb95fda 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -261,6 +261,8 @@ static void blk_free_queue(struct request_queue *q)
 		blk_mq_release(q);
 
 	ida_free(&blk_queue_ida, q->id);
+	lockdep_unregister_key(&q->io_lock_cls_key);
+	lockdep_unregister_key(&q->q_lock_cls_key);
 	call_rcu(&q->rcu_head, blk_free_queue_rcu);
 }
 
@@ -278,18 +280,20 @@ void blk_put_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_put_queue);
 
-void blk_queue_start_drain(struct request_queue *q)
+bool blk_queue_start_drain(struct request_queue *q)
 {
 	/*
 	 * When queue DYING flag is set, we need to block new req
 	 * entering queue, so we call blk_freeze_queue_start() to
 	 * prevent I/O from crossing blk_queue_enter().
 	 */
-	blk_freeze_queue_start(q);
+	bool freeze = __blk_freeze_queue_start(q);
 	if (queue_is_mq(q))
 		blk_mq_wake_waiters(q);
 	/* Make blk_queue_enter() reexamine the DYING flag. */
 	wake_up_all(&q->mq_freeze_wq);
+
+	return freeze;
 }
 
 /**
@@ -321,6 +325,8 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 			return -ENODEV;
 	}
 
+	rwsem_acquire_read(&q->q_lockdep_map, 0, 0, _RET_IP_);
+	rwsem_release(&q->q_lockdep_map, _RET_IP_);
 	return 0;
 }
 
@@ -352,6 +358,8 @@ int __bio_queue_enter(struct request_queue *q, struct bio *bio)
 			goto dead;
 	}
 
+	rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
+	rwsem_release(&q->io_lockdep_map, _RET_IP_);
 	return 0;
 dead:
 	bio_io_error(bio);
@@ -441,6 +449,12 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL);
 	if (error)
 		goto fail_stats;
+	lockdep_register_key(&q->io_lock_cls_key);
+	lockdep_register_key(&q->q_lock_cls_key);
+	lockdep_init_map(&q->io_lockdep_map, "&q->q_usage_counter(io)",
+			 &q->io_lock_cls_key, 0);
+	lockdep_init_map(&q->q_lockdep_map, "&q->q_usage_counter(queue)",
+			 &q->q_lock_cls_key, 0);
 
 	q->nr_requests = BLKDEV_DEFAULT_RQ;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c84c2d2510d..60c58142819e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -120,17 +120,29 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
 	inflight[1] = mi.inflight[1];
 }
 
-void blk_freeze_queue_start(struct request_queue *q)
+bool __blk_freeze_queue_start(struct request_queue *q)
 {
+	int freeze;
+
 	mutex_lock(&q->mq_freeze_lock);
 	if (++q->mq_freeze_depth == 1) {
 		percpu_ref_kill(&q->q_usage_counter);
 		mutex_unlock(&q->mq_freeze_lock);
 		if (queue_is_mq(q))
 			blk_mq_run_hw_queues(q, false);
+		freeze = true;
 	} else {
 		mutex_unlock(&q->mq_freeze_lock);
+		freeze = false;
 	}
+
+	return freeze;
+}
+
+void blk_freeze_queue_start(struct request_queue *q)
+{
+	if (__blk_freeze_queue_start(q))
+		blk_freeze_acquire_lock(q, false, false);
 }
 EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
 
@@ -176,8 +188,10 @@ void blk_mq_freeze_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
 
-void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
+bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 {
+	int unfreeze = false;
+
 	mutex_lock(&q->mq_freeze_lock);
 	if (force_atomic)
 		q->q_usage_counter.data->force_atomic = true;
@@ -186,13 +200,17 @@ void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 	if (!q->mq_freeze_depth) {
 		percpu_ref_resurrect(&q->q_usage_counter);
 		wake_up_all(&q->mq_freeze_wq);
+		unfreeze = true;
 	}
 	mutex_unlock(&q->mq_freeze_lock);
+
+	return unfreeze;
 }
 
 void blk_mq_unfreeze_queue(struct request_queue *q)
 {
-	__blk_mq_unfreeze_queue(q, false);
+	if (__blk_mq_unfreeze_queue(q, false))
+		blk_unfreeze_release_lock(q, false, false);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
@@ -204,7 +222,7 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
  */
 void blk_freeze_queue_start_non_owner(struct request_queue *q)
 {
-	blk_freeze_queue_start(q);
+	__blk_freeze_queue_start(q);
 }
 EXPORT_SYMBOL_GPL(blk_freeze_queue_start_non_owner);
 
diff --git a/block/blk.h b/block/blk.h
index c718e4291db0..832e54c5a271 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -4,6 +4,7 @@
 
 #include <linux/bio-integrity.h>
 #include <linux/blk-crypto.h>
+#include <linux/lockdep.h>
 #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
 #include <linux/sched/sysctl.h>
 #include <linux/timekeeping.h>
@@ -35,8 +36,9 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
 void blk_freeze_queue(struct request_queue *q);
-void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
-void blk_queue_start_drain(struct request_queue *q);
+bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
+bool blk_queue_start_drain(struct request_queue *q);
+bool __blk_freeze_queue_start(struct request_queue *q);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
 void submit_bio_noacct_nocheck(struct bio *bio);
 void bio_await_chain(struct bio *bio);
@@ -69,8 +71,11 @@ static inline int bio_queue_enter(struct bio *bio)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 
-	if (blk_try_enter_queue(q, false))
+	if (blk_try_enter_queue(q, false)) {
+		rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
+		rwsem_release(&q->io_lockdep_map, _RET_IP_);
 		return 0;
+	}
 	return __bio_queue_enter(q, bio);
 }
 
@@ -734,4 +739,22 @@ void blk_integrity_verify(struct bio *bio);
 void blk_integrity_prepare(struct request *rq);
 void blk_integrity_complete(struct request *rq, unsigned int nr_bytes);
 
+static inline void blk_freeze_acquire_lock(struct request_queue *q, bool
+		disk_dead, bool queue_dying)
+{
+	if (!disk_dead)
+		rwsem_acquire(&q->io_lockdep_map, 0, 1, _RET_IP_);
+	if (!queue_dying)
+		rwsem_acquire(&q->q_lockdep_map, 0, 1, _RET_IP_);
+}
+
+static inline void blk_unfreeze_release_lock(struct request_queue *q, bool
+		disk_dead, bool queue_dying)
+{
+	if (!queue_dying)
+		rwsem_release(&q->q_lockdep_map, _RET_IP_);
+	if (!disk_dead)
+		rwsem_release(&q->io_lockdep_map, _RET_IP_);
+}
+
 #endif /* BLK_INTERNAL_H */
diff --git a/block/genhd.c b/block/genhd.c
index 1c05dd4c6980..6ad3fcde0110 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -581,13 +581,13 @@ static void blk_report_disk_dead(struct gendisk *disk, bool surprise)
 	rcu_read_unlock();
 }
 
-static void __blk_mark_disk_dead(struct gendisk *disk)
+static bool __blk_mark_disk_dead(struct gendisk *disk)
 {
 	/*
 	 * Fail any new I/O.
 	 */
 	if (test_and_set_bit(GD_DEAD, &disk->state))
-		return;
+		return false;
 
 	if (test_bit(GD_OWNS_QUEUE, &disk->state))
 		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
@@ -600,7 +600,7 @@ static void __blk_mark_disk_dead(struct gendisk *disk)
 	/*
 	 * Prevent new I/O from crossing bio_queue_enter().
 	 */
-	blk_queue_start_drain(disk->queue);
+	return blk_queue_start_drain(disk->queue);
 }
 
 /**
@@ -641,6 +641,7 @@ void del_gendisk(struct gendisk *disk)
 	struct request_queue *q = disk->queue;
 	struct block_device *part;
 	unsigned long idx;
+	bool start_drain, queue_dying;
 
 	might_sleep();
 
@@ -668,7 +669,10 @@ void del_gendisk(struct gendisk *disk)
 	 * Drop all partitions now that the disk is marked dead.
 	 */
 	mutex_lock(&disk->open_mutex);
-	__blk_mark_disk_dead(disk);
+	start_drain = __blk_mark_disk_dead(disk);
+	queue_dying = blk_queue_dying(q);
+	if (start_drain)
+		blk_freeze_acquire_lock(q, true, queue_dying);
 	xa_for_each_start(&disk->part_tbl, idx, part, 1)
 		drop_partition(part);
 	mutex_unlock(&disk->open_mutex);
@@ -725,6 +729,9 @@ void del_gendisk(struct gendisk *disk)
 		if (queue_is_mq(q))
 			blk_mq_exit_queue(q);
 	}
+
+	if (start_drain)
+		blk_unfreeze_release_lock(q, true, queue_dying);
 }
 EXPORT_SYMBOL(del_gendisk);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50c3b959da28..57f1ee386b57 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -25,6 +25,7 @@
 #include <linux/uuid.h>
 #include <linux/xarray.h>
 #include <linux/file.h>
+#include <linux/lockdep.h>
 
 struct module;
 struct request_queue;
@@ -471,6 +472,11 @@ struct request_queue {
 	struct xarray		hctx_table;
 
 	struct percpu_ref	q_usage_counter;
+	struct lock_class_key	io_lock_cls_key;
+	struct lockdep_map	io_lockdep_map;
+
+	struct lock_class_key	q_lock_cls_key;
+	struct lockdep_map	q_lockdep_map;
 
 	struct request		*last_merge;
 
-- 
2.46.0

