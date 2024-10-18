Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9AE42052
	for <linux-block@vger.kernel.org>; Fri, 18 Oct 2024 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729215362; cv=none; b=DtL2L0LFeQLoqTudBgckbQaRuZaxs46NC6ft4/EIGoTmaTE481o4lcpnS94SbH75cmVxxI8O0UESNAzK9+P797zu3tyuKMUi3BHyO5s8s9nvMRq9NJecL55uofv5KfdGLfKpfV3aYeU5WlSVllQv6He3wSD6/nryB1uVpbOqSA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729215362; c=relaxed/simple;
	bh=uzbyww0fmKo7tgkQY91i+nj7NKUyowu0VlKA6sZxVNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OvEA5379686NUKAmgA50YYSbBTLrdSMHro57EhWY/pB7R5SBCgyqUBLiTHsbmKcCMLOpTn0X6GPru11YYew+zy34QTjGJGQGMYWzIh2JQQwZJVj69AksMVo7yy21T00faUIauii6YWCjtZdjoTpAgyaBs3esS1RZ3qjugLKIFgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hAjMJUYT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAjMJUYT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729215358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xGcMnSD84PeKJ+hpAg5pWB5Bi0hILYcn+WQq8wrM1As=;
	b=hAjMJUYTCtPqdukGwGr5sGTCmTYHzo5BItJsXyZIYdCFOi+3cFAE1q0onpcKvHoRVJZzFM
	7Wp+jE8uya6mg4hftKRIBts1QjDTke/iVSa0T5V+RuwRsD1unf/SIwXnQlq4cZADPk4Zk6
	V4IchOIJepxwg9/X0MGPegiqTI3Qo0M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-ZlorA9ASPNWdkgqV5I19kA-1; Thu,
 17 Oct 2024 21:35:52 -0400
X-MC-Unique: ZlorA9ASPNWdkgqV5I19kA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86DEC1956096;
	Fri, 18 Oct 2024 01:35:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.56])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 168681956086;
	Fri, 18 Oct 2024 01:35:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: model freeze & enter queue as rwsem for supporting lockdep
Date: Fri, 18 Oct 2024 09:35:42 +0800
Message-ID: <20241018013542.3013963-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Recently we got several deadlock report[1][2][3] caused by blk_mq_freeze_queue
and blk_enter_queue().

Turns out the two are just like one rwsem, so model them as rwsem for
supporting lockdep:

1) model blk_mq_freeze_queue() as down_write_trylock()
- it is exclusive lock, so dependency with blk_enter_queue() is covered
- it is trylock because blk_mq_freeze_queue() are allowed to run concurrently

2) model blk_enter_queue() as down_read()
- it is shared lock, so concurrent blk_enter_queue() are allowed
- it is read lock, so dependency with blk_mq_freeze_queue() is modeled
- blk_queue_exit() is often called from other contexts(such as irq), and
it can't be annotated as rwsem_release(), so simply do it in
blk_enter_queue(), this way still covered cases as many as possible

NVMe is the only subsystem which may call blk_mq_freeze_queue() and
blk_mq_unfreeze_queue() from different context, so it is the only
exception for the modeling. Add one tagset flag to exclude it from
the lockdep support.

With lockdep support, such kind of reports may be reported asap and
needn't wait until the real deadlock is triggered.

For example, the following lockdep report can be triggered in the
report[3].

[   45.701432] ======================================================
[   45.702621] WARNING: possible circular locking dependency detected
[   45.703829] 6.12.0-rc1_uring_dev+ #188 Not tainted
[   45.704806] ------------------------------------------------------
[   45.705903] bash/1323 is trying to acquire lock:
[   45.706153] ffff88813e075870 (&q->limits_lock){+.+.}-{3:3}, at: queue_wc_store+0x11c/0x380
[   45.706602]
               but task is already holding lock:
[   45.706927] ffff88813e075730 (&q->sysfs_lock){+.+.}-{3:3}, at: queue_attr_store+0xd9/0x170
[   45.707391]
               which lock already depends on the new lock.

[   45.707838]
               the existing dependency chain (in reverse order) is:
[   45.708238]
               -> #2 (&q->sysfs_lock){+.+.}-{3:3}:
[   45.708558]        __mutex_lock+0x177/0x10d0
[   45.708797]        queue_attr_store+0xd9/0x170
[   45.709039]        kernfs_fop_write_iter+0x39f/0x5a0
[   45.709304]        vfs_write+0x5d3/0xe80
[   45.709514]        ksys_write+0xfb/0x1d0
[   45.709723]        do_syscall_64+0x95/0x180
[   45.709946]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   45.710256]
               -> #1 (q->q_usage_counter){++++}-{0:0}:
[   45.710589]        blk_try_enter_queue+0x32/0x340
[   45.710842]        blk_queue_enter+0x97/0x4c0
[   45.711080]        blk_mq_alloc_request+0x347/0x900
[   45.711340]        scsi_execute_cmd+0x183/0xc20
[   45.711584]        read_capacity_16+0x1ce/0xbb0
[   45.711823]        sd_revalidate_disk.isra.0+0xf78/0x8b40
[   45.712119]        sd_probe+0x813/0xf40
[   45.712320]        really_probe+0x1e0/0x8a0
[   45.712542]        __driver_probe_device+0x18c/0x370
[   45.712801]        driver_probe_device+0x4a/0x120
[   45.713053]        __device_attach_driver+0x162/0x270
[   45.713327]        bus_for_each_drv+0x115/0x1a0
[   45.713572]        __device_attach_async_helper+0x1a0/0x240
[   45.713872]        async_run_entry_fn+0x97/0x4f0
[   45.714127]        process_one_work+0x85d/0x1430
[   45.714377]        worker_thread+0x5be/0xff0
[   45.714610]        kthread+0x293/0x350
[   45.714811]        ret_from_fork+0x31/0x70
[   45.715032]        ret_from_fork_asm+0x1a/0x30
[   45.715667]
               -> #0 (&q->limits_lock){+.+.}-{3:3}:
[   45.716819]        __lock_acquire+0x310a/0x6060
[   45.717476]        lock_acquire.part.0+0x122/0x360
[   45.718133]        __mutex_lock+0x177/0x10d0
[   45.718759]        queue_wc_store+0x11c/0x380
[   45.719384]        queue_attr_store+0xff/0x170
[   45.720007]        kernfs_fop_write_iter+0x39f/0x5a0
[   45.720647]        vfs_write+0x5d3/0xe80
[   45.721252]        ksys_write+0xfb/0x1d0
[   45.721847]        do_syscall_64+0x95/0x180
[   45.722433]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   45.723085]
               other info that might help us debug this:

[   45.724532] Chain exists of:
                 &q->limits_lock --> q->q_usage_counter --> &q->sysfs_lock

[   45.726122]  Possible unsafe locking scenario:

[   45.727114]        CPU0                    CPU1
[   45.727687]        ----                    ----
[   45.728270]   lock(&q->sysfs_lock);
[   45.728792]                                lock(q->q_usage_counter);
[   45.729466]                                lock(&q->sysfs_lock);
[   45.730119]   lock(&q->limits_lock);
[   45.730655]
                *** DEADLOCK ***

[   45.731983] 5 locks held by bash/1323:
[   45.732524]  #0: ffff88811a4a0450 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0xfb/0x1d0
[   45.733290]  #1: ffff88811fa35890 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x25d/0x5a0
[   45.734113]  #2: ffff888118e9fc20 (kn->active#133){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x281/0x5a0
[   45.734939]  #3: ffff88813e0751e0 (q->q_usage_counter){++++}-{0:0}, at: blk_mq_freeze_queue+0x12/0x20
[   45.735797]  #4: ffff88813e075730 (&q->sysfs_lock){+.+.}-{3:3}, at: queue_attr_store+0xd9/0x170
[   45.736626]
               stack backtrace:
[   45.737598] CPU: 9 UID: 0 PID: 1323 Comm: bash Not tainted 6.12.0-rc1_uring_dev+ #188
[   45.738388] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39 04/01/2014
[   45.739222] Call Trace:
[   45.739762]  <TASK>
[   45.740309]  dump_stack_lvl+0x84/0xd0
[   45.740962]  print_circular_bug.cold+0x1e4/0x278
[   45.741628]  check_noncircular+0x331/0x410
[   45.742289]  ? __pfx_check_noncircular+0x10/0x10
[   45.742933]  ? lock_release+0x588/0xcc0
[   45.743536]  ? lockdep_lock+0xbe/0x1c0
[   45.744156]  ? __pfx_lockdep_lock+0x10/0x10
[   45.744785]  ? is_bpf_text_address+0x21/0x100
[   45.745442]  __lock_acquire+0x310a/0x6060
[   45.746088]  ? __pfx___lock_acquire+0x10/0x10
[   45.746735]  ? __pfx___bfs+0x10/0x10
[   45.747325]  lock_acquire.part.0+0x122/0x360
[   45.747947]  ? queue_wc_store+0x11c/0x380
[   45.748564]  ? __pfx_lock_acquire.part.0+0x10/0x10
[   45.749254]  ? trace_lock_acquire+0x12f/0x1a0
[   45.749903]  ? queue_wc_store+0x11c/0x380
[   45.750545]  ? lock_acquire+0x2f/0xb0
[   45.751168]  ? queue_wc_store+0x11c/0x380
[   45.751777]  __mutex_lock+0x177/0x10d0
[   45.752379]  ? queue_wc_store+0x11c/0x380
[   45.752988]  ? queue_wc_store+0x11c/0x380
[   45.753586]  ? __pfx___mutex_lock+0x10/0x10
[   45.754202]  ? __pfx___lock_acquire+0x10/0x10
[   45.754823]  ? lock_acquire.part.0+0x122/0x360
[   45.755456]  ? queue_wc_store+0x11c/0x380
[   45.756063]  queue_wc_store+0x11c/0x380
[   45.756653]  ? __pfx_lock_acquired+0x10/0x10
[   45.757305]  ? lock_acquire+0x2f/0xb0
[   45.757904]  ? trace_contention_end+0xd4/0x110
[   45.758524]  ? __pfx_queue_wc_store+0x10/0x10
[   45.759172]  ? queue_attr_store+0xd9/0x170
[   45.759899]  ? __pfx_autoremove_wake_function+0x10/0x10
[   45.760587]  queue_attr_store+0xff/0x170
[   45.761213]  ? sysfs_kf_write+0x41/0x170
[   45.761823]  ? __pfx_sysfs_kf_write+0x10/0x10
[   45.762461]  kernfs_fop_write_iter+0x39f/0x5a0
[   45.763109]  vfs_write+0x5d3/0xe80
[   45.763690]  ? lockdep_hardirqs_on_prepare+0x274/0x3f0
[   45.764368]  ? __pfx_vfs_write+0x10/0x10
[   45.764964]  ksys_write+0xfb/0x1d0
[   45.765544]  ? __pfx_ksys_write+0x10/0x10
[   45.766160]  ? ksys_dup3+0xce/0x2b0
[   45.766710]  do_syscall_64+0x95/0x180
[   45.767267]  ? filp_close+0x1d/0x30
[   45.767801]  ? do_dup2+0x27c/0x4f0
[   45.768334]  ? syscall_exit_to_user_mode+0x97/0x290
[   45.768930]  ? lockdep_hardirqs_on_prepare+0x274/0x3f0
[   45.769538]  ? syscall_exit_to_user_mode+0x97/0x290
[   45.770136]  ? do_syscall_64+0xa1/0x180
[   45.770665]  ? clear_bhb_loop+0x25/0x80
[   45.771206]  ? clear_bhb_loop+0x25/0x80
[   45.771735]  ? clear_bhb_loop+0x25/0x80
[   45.772261]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   45.772843] RIP: 0033:0x7f3b17be9984
[   45.773363] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 06 0e 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
[   45.775131] RSP: 002b:00007fffaa975ba8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   45.775909] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f3b17be9984
[   45.776672] RDX: 0000000000000005 RSI: 0000556af3758790 RDI: 0000000000000001
[   45.777454] RBP: 00007fffaa975bd0 R08: 0000000000000073 R09: 00000000ffffffff
[   45.778251] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000005
[   45.779039] R13: 0000556af3758790 R14: 00007f3b17cc35c0 R15: 00007f3b17cc0f00
[   45.779822]  </TASK>

[1] occasional block layer hang when setting 'echo noop > /sys/block/sda/queue/scheduler'
https://bugzilla.kernel.org/show_bug.cgi?id=219166

[2] del_gendisk() vs blk_queue_enter() race condition
https://lore.kernel.org/linux-block/20241003085610.GK11458@google.com/

[3] queue_freeze & queue_enter deadlock in scsi
https://lore.kernel.org/linux-block/ZxG38G9BuFdBpBHZ@fedora/T/#u

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c         |  3 +++
 block/blk-mq-debugfs.c   |  1 +
 block/blk-mq.c           | 15 +++++++++++++++
 block/blk.h              |  9 +++++++++
 block/genhd.c            |  3 +++
 drivers/nvme/host/core.c |  4 ++--
 include/linux/blk-mq.h   |  5 ++++-
 include/linux/blkdev.h   |  6 ++++++
 8 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bc5e8c5eaac9..2c3ca6d405e2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -384,6 +384,7 @@ static void blk_timeout_work(struct work_struct *work)
 
 struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 {
+	static struct lock_class_key __q_usage_counter_key;
 	struct request_queue *q;
 	int error;
 
@@ -441,6 +442,8 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL);
 	if (error)
 		goto fail_stats;
+	lockdep_init_map(&q->q_usage_counter_map, "q->q_usage_counter",
+			 &__q_usage_counter_key, 0);
 
 	q->nr_requests = BLKDEV_DEFAULT_RQ;
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 5463697a8442..d0edac3b8b08 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -188,6 +188,7 @@ static const char *const hctx_flag_name[] = {
 	HCTX_FLAG_NAME(BLOCKING),
 	HCTX_FLAG_NAME(NO_SCHED),
 	HCTX_FLAG_NAME(NO_SCHED_BY_DEFAULT),
+	HCTX_FLAG_NAME(SKIP_FREEZE_LOCKDEP),
 };
 #undef HCTX_FLAG_NAME
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b2c8e940f59..b1b970650641 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -122,7 +122,10 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
 
 void blk_freeze_queue_start(struct request_queue *q)
 {
+	int sub_class;
+
 	mutex_lock(&q->mq_freeze_lock);
+	sub_class = q->mq_freeze_depth;
 	if (++q->mq_freeze_depth == 1) {
 		percpu_ref_kill(&q->q_usage_counter);
 		mutex_unlock(&q->mq_freeze_lock);
@@ -131,6 +134,12 @@ void blk_freeze_queue_start(struct request_queue *q)
 	} else {
 		mutex_unlock(&q->mq_freeze_lock);
 	}
+	/*
+	 * model as down_write_trylock() so that two concurrent freeze queue
+	 * can be allowed
+	 */
+	if (blk_queue_freeze_lockdep(q))
+		rwsem_acquire(&q->q_usage_counter_map, sub_class, 1, _RET_IP_);
 }
 EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
 
@@ -188,6 +197,9 @@ void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 		wake_up_all(&q->mq_freeze_wq);
 	}
 	mutex_unlock(&q->mq_freeze_lock);
+
+	if (blk_queue_freeze_lockdep(q))
+		rwsem_release(&q->q_usage_counter_map, _RET_IP_);
 }
 
 void blk_mq_unfreeze_queue(struct request_queue *q)
@@ -4185,6 +4197,9 @@ void blk_mq_destroy_queue(struct request_queue *q)
 	blk_queue_start_drain(q);
 	blk_mq_freeze_queue_wait(q);
 
+	/* counter pair of acquire in blk_queue_start_drain */
+	if (blk_queue_freeze_lockdep(q))
+		rwsem_release(&q->q_usage_counter_map, _RET_IP_);
 	blk_sync_queue(q);
 	blk_mq_cancel_work_sync(q);
 	blk_mq_exit_queue(q);
diff --git a/block/blk.h b/block/blk.h
index c718e4291db0..d6274f3bece9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -4,6 +4,7 @@
 
 #include <linux/bio-integrity.h>
 #include <linux/blk-crypto.h>
+#include <linux/lockdep.h>
 #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
 #include <linux/sched/sysctl.h>
 #include <linux/timekeeping.h>
@@ -43,6 +44,8 @@ void bio_await_chain(struct bio *bio);
 
 static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
 {
+	/* model as down_read() for lockdep */
+	rwsem_acquire_read(&q->q_usage_counter_map, 0, 0, _RET_IP_);
 	rcu_read_lock();
 	if (!percpu_ref_tryget_live_rcu(&q->q_usage_counter))
 		goto fail;
@@ -56,12 +59,18 @@ static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
 		goto fail_put;
 
 	rcu_read_unlock();
+	/*
+	 * queue exit often happen in other context, so we simply annotate
+	 * release here, still lots of cases can be covered
+	 */
+	rwsem_release(&q->q_usage_counter_map, _RET_IP_);
 	return true;
 
 fail_put:
 	blk_queue_exit(q);
 fail:
 	rcu_read_unlock();
+	rwsem_release(&q->q_usage_counter_map, _RET_IP_);
 	return false;
 }
 
diff --git a/block/genhd.c b/block/genhd.c
index 1c05dd4c6980..4016a83a0d83 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -722,6 +722,9 @@ void del_gendisk(struct gendisk *disk)
 		blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
 		__blk_mq_unfreeze_queue(q, true);
 	} else {
+		/* counter pair of acquire in blk_queue_start_drain */
+		if (blk_queue_freeze_lockdep(q))
+			rwsem_release(&q->q_usage_counter_map, _RET_IP_);
 		if (queue_is_mq(q))
 			blk_mq_exit_queue(q);
 	}
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba6508455e18..6575f0f5a5fe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4528,7 +4528,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 		/* Reserved for fabric connect and keep alive */
 		set->reserved_tags = 2;
 	set->numa_node = ctrl->numa_node;
-	set->flags = BLK_MQ_F_NO_SCHED;
+	set->flags = BLK_MQ_F_NO_SCHED | BLK_MQ_F_SKIP_FREEZE_LOCKDEP;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
 		set->flags |= BLK_MQ_F_BLOCKING;
 	set->cmd_size = cmd_size;
@@ -4598,7 +4598,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 		/* Reserved for fabric connect */
 		set->reserved_tags = 1;
 	set->numa_node = ctrl->numa_node;
-	set->flags = BLK_MQ_F_SHOULD_MERGE;
+	set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SKIP_FREEZE_LOCKDEP;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
 		set->flags |= BLK_MQ_F_BLOCKING;
 	set->cmd_size = cmd_size;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 4fecf46ef681..9c5c9dc0e7e2 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -687,7 +687,10 @@ enum {
 	 * or shared hwqs instead of 'mq-deadline'.
 	 */
 	BLK_MQ_F_NO_SCHED_BY_DEFAULT	= 1 << 6,
-	BLK_MQ_F_ALLOC_POLICY_START_BIT = 7,
+
+	BLK_MQ_F_SKIP_FREEZE_LOCKDEP	= 1 << 7,
+
+	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 };
 #define BLK_MQ_FLAG_TO_ALLOC_POLICY(flags) \
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50c3b959da28..5f25521bf2f6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -25,6 +25,7 @@
 #include <linux/uuid.h>
 #include <linux/xarray.h>
 #include <linux/file.h>
+#include <linux/lockdep.h>
 
 struct module;
 struct request_queue;
@@ -471,6 +472,9 @@ struct request_queue {
 	struct xarray		hctx_table;
 
 	struct percpu_ref	q_usage_counter;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	q_usage_counter_map;
+#endif
 
 	struct request		*last_merge;
 
@@ -635,6 +639,8 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
 #define blk_queue_skip_tagset_quiesce(q) \
 	((q)->limits.features & BLK_FEAT_SKIP_TAGSET_QUIESCE)
+#define blk_queue_freeze_lockdep(q) \
+	!(q->tag_set->flags & BLK_MQ_F_SKIP_FREEZE_LOCKDEP)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.46.0

