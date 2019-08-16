Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A02AC3A59C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 13:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DED6206C1
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 13:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfHPNzT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 09:55:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5503 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfHPNzT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 09:55:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A3054309BF06;
        Fri, 16 Aug 2019 13:55:18 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA65083E81;
        Fri, 16 Aug 2019 13:55:10 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] block: don't acquire .sysfs_lock before removing mq & iosched kobjects
Date:   Fri, 16 Aug 2019 21:55:06 +0800
Message-Id: <20190816135506.29253-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 16 Aug 2019 13:55:18 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The kernfs built-in lock of 'kn->count' is held in sysfs .show/.store
path. Meantime, inside block's .show/.store callback, q->sysfs_lock is
required.

However, when mq & iosched kobjects are removed via
blk_mq_unregister_dev() & elv_unregister_queue(), q->sysfs_lock is held
too. This way causes AB-BA lock because the kernfs built-in lock of
'kn-count' is required inside kobject_del() too, see the lockdep warning[1].

On the other hand, it isn't necessary to acquire q->sysfs_lock for
both blk_mq_unregister_dev() & elv_unregister_queue() because
clearing REGISTERED flag prevents storing to 'queue/scheduler'
from being happened. Also sysfs write(store) is exclusive, so no
necessary to hold the lock for elv_unregister_queue() when it is
called in switching elevator path.

Fixes the issue by not holding the q->sysfs_lock for blk_mq_unregister_dev() &
elv_unregister_queue().

[1] lockdep warning
======================================================
WARNING: possible circular locking dependency detected
5.3.0-rc3-00044-g73277fc75ea0 #1380 Not tainted
------------------------------------------------------
rmmod/777 is trying to acquire lock:
00000000ac50e981 (kn->count#202){++++}, at: kernfs_remove_by_name_ns+0x59/0x72

but task is already holding lock:
00000000fb16ae21 (&q->sysfs_lock){+.+.}, at: blk_unregister_queue+0x78/0x10b

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&q->sysfs_lock){+.+.}:
       __lock_acquire+0x95f/0xa2f
       lock_acquire+0x1b4/0x1e8
       __mutex_lock+0x14a/0xa9b
       blk_mq_hw_sysfs_show+0x63/0xb6
       sysfs_kf_seq_show+0x11f/0x196
       seq_read+0x2cd/0x5f2
       vfs_read+0xc7/0x18c
       ksys_read+0xc4/0x13e
       do_syscall_64+0xa7/0x295
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (kn->count#202){++++}:
       check_prev_add+0x5d2/0xc45
       validate_chain+0xed3/0xf94
       __lock_acquire+0x95f/0xa2f
       lock_acquire+0x1b4/0x1e8
       __kernfs_remove+0x237/0x40b
       kernfs_remove_by_name_ns+0x59/0x72
       remove_files+0x61/0x96
       sysfs_remove_group+0x81/0xa4
       sysfs_remove_groups+0x3b/0x44
       kobject_del+0x44/0x94
       blk_mq_unregister_dev+0x83/0xdd
       blk_unregister_queue+0xa0/0x10b
       del_gendisk+0x259/0x3fa
       null_del_dev+0x8b/0x1c3 [null_blk]
       null_exit+0x5c/0x95 [null_blk]
       __se_sys_delete_module+0x204/0x337
       do_syscall_64+0xa7/0x295
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->sysfs_lock);
                               lock(kn->count#202);
                               lock(&q->sysfs_lock);
  lock(kn->count#202);

 *** DEADLOCK ***

2 locks held by rmmod/777:
 #0: 00000000e69bd9de (&lock){+.+.}, at: null_exit+0x2e/0x95 [null_blk]
 #1: 00000000fb16ae21 (&q->sysfs_lock){+.+.}, at: blk_unregister_queue+0x78/0x10b

stack backtrace:
CPU: 0 PID: 777 Comm: rmmod Not tainted 5.3.0-rc3-00044-g73277fc75ea0 #1380
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS ?-20180724_192412-buildhw-07.phx4
Call Trace:
 dump_stack+0x9a/0xe6
 check_noncircular+0x207/0x251
 ? print_circular_bug+0x32a/0x32a
 ? find_usage_backwards+0x84/0xb0
 check_prev_add+0x5d2/0xc45
 validate_chain+0xed3/0xf94
 ? check_prev_add+0xc45/0xc45
 ? mark_lock+0x11b/0x804
 ? check_usage_forwards+0x1ca/0x1ca
 __lock_acquire+0x95f/0xa2f
 lock_acquire+0x1b4/0x1e8
 ? kernfs_remove_by_name_ns+0x59/0x72
 __kernfs_remove+0x237/0x40b
 ? kernfs_remove_by_name_ns+0x59/0x72
 ? kernfs_next_descendant_post+0x7d/0x7d
 ? strlen+0x10/0x23
 ? strcmp+0x22/0x44
 kernfs_remove_by_name_ns+0x59/0x72
 remove_files+0x61/0x96
 sysfs_remove_group+0x81/0xa4
 sysfs_remove_groups+0x3b/0x44
 kobject_del+0x44/0x94
 blk_mq_unregister_dev+0x83/0xdd
 blk_unregister_queue+0xa0/0x10b
 del_gendisk+0x259/0x3fa
 ? disk_events_poll_msecs_store+0x12b/0x12b
 ? check_flags+0x1ea/0x204
 ? mark_held_locks+0x1f/0x7a
 null_del_dev+0x8b/0x1c3 [null_blk]
 null_exit+0x5c/0x95 [null_blk]
 __se_sys_delete_module+0x204/0x337
 ? free_module+0x39f/0x39f
 ? blkcg_maybe_throttle_current+0x8a/0x718
 ? rwlock_bug+0x62/0x62
 ? __blkcg_punt_bio_submit+0xd0/0xd0
 ? trace_hardirqs_on_thunk+0x1a/0x20
 ? mark_held_locks+0x1f/0x7a
 ? do_syscall_64+0x4c/0x295
 do_syscall_64+0xa7/0x295
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fb696cdbe6b
Code: 73 01 c3 48 8b 0d 1d 20 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 008
RSP: 002b:00007ffec9588788 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
RAX: ffffffffffffffda RBX: 0000559e589137c0 RCX: 00007fb696cdbe6b
RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000559e58913828
RBP: 0000000000000000 R08: 00007ffec9587701 R09: 0000000000000000
R10: 00007fb696d4eae0 R11: 0000000000000206 R12: 00007ffec95889b0
R13: 00007ffec95896b3 R14: 0000559e58913260 R15: 0000559e589137c0

Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sysfs.c |  4 ++--
 block/blk-sysfs.c    |  9 ++++-----
 block/elevator.c     | 16 +++++++++++++---
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index e0b97c22726c..d5e805281130 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -247,8 +247,6 @@ void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	lockdep_assert_held(&q->sysfs_lock);
-
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
 
@@ -256,7 +254,9 @@ void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 	kobject_del(q->mq_kobj);
 	kobject_put(&dev->kobj);
 
+	mutex_lock(&q->sysfs_lock);
 	q->mq_sysfs_init_done = false;
+	mutex_unlock(&q->sysfs_lock);
 }
 
 void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 977c659dcd18..46f033b48917 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -1021,6 +1021,7 @@ EXPORT_SYMBOL_GPL(blk_register_queue);
 void blk_unregister_queue(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
+	bool has_elevator;
 
 	if (WARN_ON(!q))
 		return;
@@ -1035,8 +1036,9 @@ void blk_unregister_queue(struct gendisk *disk)
 	 * concurrent elv_iosched_store() calls.
 	 */
 	mutex_lock(&q->sysfs_lock);
-
 	blk_queue_flag_clear(QUEUE_FLAG_REGISTERED, q);
+	has_elevator = q->elevator;
+	mutex_unlock(&q->sysfs_lock);
 
 	/*
 	 * Remove the sysfs attributes before unregistering the queue data
@@ -1044,16 +1046,13 @@ void blk_unregister_queue(struct gendisk *disk)
 	 */
 	if (queue_is_mq(q))
 		blk_mq_unregister_dev(disk_to_dev(disk), q);
-	mutex_unlock(&q->sysfs_lock);
 
 	kobject_uevent(&q->kobj, KOBJ_REMOVE);
 	kobject_del(&q->kobj);
 	blk_trace_remove_sysfs(disk_to_dev(disk));
 
-	mutex_lock(&q->sysfs_lock);
-	if (q->elevator)
+	if (has_elevator)
 		elv_unregister_queue(q);
-	mutex_unlock(&q->sysfs_lock);
 
 	kobject_put(&disk_to_dev(disk)->kobj);
 }
diff --git a/block/elevator.c b/block/elevator.c
index 2f17d66d0e61..4a12c60ba946 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -495,16 +495,17 @@ int elv_register_queue(struct request_queue *q)
 
 void elv_unregister_queue(struct request_queue *q)
 {
-	lockdep_assert_held(&q->sysfs_lock);
-
 	if (q) {
 		struct elevator_queue *e = q->elevator;
 
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
 		kobject_del(&e->kobj);
+
+		mutex_lock(&q->sysfs_lock);
 		e->registered = 0;
 		/* Re-enable throttling in case elevator disabled it */
 		wbt_enable_default(q);
+		mutex_unlock(&q->sysfs_lock);
 	}
 }
 
@@ -567,8 +568,17 @@ int elevator_switch_mq(struct request_queue *q,
 	lockdep_assert_held(&q->sysfs_lock);
 
 	if (q->elevator) {
-		if (q->elevator->registered)
+		if (q->elevator->registered) {
+			/*
+			 * sysfs write is exclusively, release
+			 * sysfs_lock for avoiding deadlock with
+			 * sysfs built-in lock which is required
+			 * in either .show or .store path.
+			 */
+			mutex_unlock(&q->sysfs_lock);
 			elv_unregister_queue(q);
+			mutex_lock(&q->sysfs_lock);
+		}
 		ioc_clear_queue(q);
 		elevator_exit(q, q->elevator);
 	}
-- 
2.20.1

