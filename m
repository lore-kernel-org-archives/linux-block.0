Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A38C433F5
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 11:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C426008E
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 11:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhIGLx3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 07:53:29 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64428 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244986AbhIGLx2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 07:53:28 -0400
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 187BqEUI078624;
        Tue, 7 Sep 2021 20:52:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Tue, 07 Sep 2021 20:52:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 187BqDuZ078618
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 7 Sep 2021 20:52:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] block: genhd: don't call blkdev_show() with major_names_lock
 held
Message-ID: <18a02da2-0bf3-550e-b071-2b4ab13c49f0@i-love.sakura.ne.jp>
Date:   Tue, 7 Sep 2021 20:52:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If CONFIG_BLK_DEV_LOOP && CONFIG_MTD (at least; there might be other
combinations), lockdep complains circular locking dependency at
__loop_clr_fd(), for major_names_lock serves as a locking dependency
aggregating hub across multiple block modules.

 ======================================================
 WARNING: possible circular locking dependency detected
 5.14.0+ #757 Tainted: G            E
 ------------------------------------------------------
 systemd-udevd/7568 is trying to acquire lock:
 ffff88800f334d48 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x70/0x560

 but task is already holding lock:
 ffff888014a7d4a0 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x4d/0x400 [loop]

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #6 (&lo->lo_mutex){+.+.}-{3:3}:
        lock_acquire+0xbe/0x1f0
        __mutex_lock_common+0xb6/0xe10
        mutex_lock_killable_nested+0x17/0x20
        lo_open+0x23/0x50 [loop]
        blkdev_get_by_dev+0x199/0x540
        blkdev_open+0x58/0x90
        do_dentry_open+0x144/0x3a0
        path_openat+0xa57/0xda0
        do_filp_open+0x9f/0x140
        do_sys_openat2+0x71/0x150
        __x64_sys_openat+0x78/0xa0
        do_syscall_64+0x3d/0xb0
        entry_SYSCALL_64_after_hwframe+0x44/0xae

 -> #5 (&disk->open_mutex){+.+.}-{3:3}:
        lock_acquire+0xbe/0x1f0
        __mutex_lock_common+0xb6/0xe10
        mutex_lock_nested+0x17/0x20
        bd_register_pending_holders+0x20/0x100
        device_add_disk+0x1ae/0x390
        loop_add+0x29c/0x2d0 [loop]
        blk_request_module+0x5a/0xb0
        blkdev_get_no_open+0x27/0xa0
        blkdev_get_by_dev+0x5f/0x540
        blkdev_open+0x58/0x90
        do_dentry_open+0x144/0x3a0
        path_openat+0xa57/0xda0
        do_filp_open+0x9f/0x140
        do_sys_openat2+0x71/0x150
        __x64_sys_openat+0x78/0xa0
        do_syscall_64+0x3d/0xb0
        entry_SYSCALL_64_after_hwframe+0x44/0xae

 -> #4 (major_names_lock){+.+.}-{3:3}:
        lock_acquire+0xbe/0x1f0
        __mutex_lock_common+0xb6/0xe10
        mutex_lock_nested+0x17/0x20
        blkdev_show+0x19/0x80
        devinfo_show+0x52/0x60
        seq_read_iter+0x2d5/0x3e0
        proc_reg_read_iter+0x41/0x80
        vfs_read+0x2ac/0x330
        ksys_read+0x6b/0xd0
        do_syscall_64+0x3d/0xb0
        entry_SYSCALL_64_after_hwframe+0x44/0xae

 -> #3 (&p->lock){+.+.}-{3:3}:
        lock_acquire+0xbe/0x1f0
        __mutex_lock_common+0xb6/0xe10
        mutex_lock_nested+0x17/0x20
        seq_read_iter+0x37/0x3e0
        generic_file_splice_read+0xf3/0x170
        splice_direct_to_actor+0x14e/0x350
        do_splice_direct+0x84/0xd0
        do_sendfile+0x263/0x430
        __se_sys_sendfile64+0x96/0xc0
        do_syscall_64+0x3d/0xb0
        entry_SYSCALL_64_after_hwframe+0x44/0xae

 -> #2 (sb_writers#3){.+.+}-{0:0}:
        lock_acquire+0xbe/0x1f0
        lo_write_bvec+0x96/0x280 [loop]
        loop_process_work+0xa68/0xc10 [loop]
        process_one_work+0x293/0x480
        worker_thread+0x23d/0x4b0
        kthread+0x163/0x180
        ret_from_fork+0x1f/0x30

 -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
        lock_acquire+0xbe/0x1f0
        process_one_work+0x280/0x480
        worker_thread+0x23d/0x4b0
        kthread+0x163/0x180
        ret_from_fork+0x1f/0x30

 -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
        validate_chain+0x1f0d/0x33e0
        __lock_acquire+0x92d/0x1030
        lock_acquire+0xbe/0x1f0
        flush_workqueue+0x8c/0x560
        drain_workqueue+0x80/0x140
        destroy_workqueue+0x47/0x4f0
        __loop_clr_fd+0xb4/0x400 [loop]
        blkdev_put+0x14a/0x1d0
        blkdev_close+0x1c/0x20
        __fput+0xfd/0x220
        task_work_run+0x69/0xc0
        exit_to_user_mode_prepare+0x1ce/0x1f0
        syscall_exit_to_user_mode+0x26/0x60
        do_syscall_64+0x4c/0xb0
        entry_SYSCALL_64_after_hwframe+0x44/0xae

 other info that might help us debug this:

 Chain exists of:
   (wq_completion)loop0 --> &disk->open_mutex --> &lo->lo_mutex

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&lo->lo_mutex);
                                lock(&disk->open_mutex);
                                lock(&lo->lo_mutex);
   lock((wq_completion)loop0);

  *** DEADLOCK ***

 2 locks held by systemd-udevd/7568:
  #0: ffff888012554128 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x4c/0x1d0
  #1: ffff888014a7d4a0 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x4d/0x400 [loop]

 stack backtrace:
 CPU: 0 PID: 7568 Comm: systemd-udevd Tainted: G            E     5.14.0+ #757
 Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
 Call Trace:
  dump_stack_lvl+0x79/0xbf
  print_circular_bug+0x5d6/0x5e0
  ? stack_trace_save+0x42/0x60
  ? save_trace+0x3d/0x2d0
  check_noncircular+0x10b/0x120
  validate_chain+0x1f0d/0x33e0
  ? __lock_acquire+0x953/0x1030
  ? __lock_acquire+0x953/0x1030
  __lock_acquire+0x92d/0x1030
  ? flush_workqueue+0x70/0x560
  lock_acquire+0xbe/0x1f0
  ? flush_workqueue+0x70/0x560
  flush_workqueue+0x8c/0x560
  ? flush_workqueue+0x70/0x560
  ? sched_clock_cpu+0xe/0x1a0
  ? drain_workqueue+0x41/0x140
  drain_workqueue+0x80/0x140
  destroy_workqueue+0x47/0x4f0
  ? blk_mq_freeze_queue_wait+0xac/0xd0
  __loop_clr_fd+0xb4/0x400 [loop]
  ? __mutex_unlock_slowpath+0x35/0x230
  blkdev_put+0x14a/0x1d0
  blkdev_close+0x1c/0x20
  __fput+0xfd/0x220
  task_work_run+0x69/0xc0
  exit_to_user_mode_prepare+0x1ce/0x1f0
  syscall_exit_to_user_mode+0x26/0x60
  do_syscall_64+0x4c/0xb0
  entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7f0fd4c661f7
 Code: 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 13 fc ff ff
 RSP: 002b:00007ffd1c9e9fd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
 RAX: 0000000000000000 RBX: 00007f0fd46be6c8 RCX: 00007f0fd4c661f7
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
 RBP: 0000000000000006 R08: 000055fff1eaf400 R09: 0000000000000000
 R10: 00007f0fd46be6c8 R11: 0000000000000246 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000002f08 R15: 00007ffd1c9ea050

Commit 1c500ad706383f1a ("loop: reduce the loop_ctl_mutex scope") is for
breaking "loop_ctl_mutex => &lo->lo_mutex" dependency chain. But enabling
a different block module results in forming circular locking dependency
due to shared major_names_lock mutex.

The simplest fix is to call probe function without holding
major_names_lock [1], but Christoph Hellwig does not like such idea.
Therefore, instead of holding major_names_lock in blkdev_show(),
introduce a different lock for blkdev_show() in order to break
"sb_writers#$N => &p->lock => major_names_lock" dependency chain.

Link: https://lkml.kernel.org/r/b2af8a5b-3c1b-204e-7f56-bea0b15848d6@i-love.sakura.ne.jp [1]
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 block/genhd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 567549a011d1..7b6e5e1cf956 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -183,6 +183,7 @@ static struct blk_major_name {
 	void (*probe)(dev_t devt);
 } *major_names[BLKDEV_MAJOR_HASH_SIZE];
 static DEFINE_MUTEX(major_names_lock);
+static DEFINE_SPINLOCK(major_names_spinlock);
 
 /* index in the above - for now: assume no multimajor ranges */
 static inline int major_to_index(unsigned major)
@@ -195,11 +196,11 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
 {
 	struct blk_major_name *dp;
 
-	mutex_lock(&major_names_lock);
+	spin_lock(&major_names_spinlock);
 	for (dp = major_names[major_to_index(offset)]; dp; dp = dp->next)
 		if (dp->major == offset)
 			seq_printf(seqf, "%3d %s\n", dp->major, dp->name);
-	mutex_unlock(&major_names_lock);
+	spin_unlock(&major_names_spinlock);
 }
 #endif /* CONFIG_PROC_FS */
 
@@ -271,6 +272,7 @@ int __register_blkdev(unsigned int major, const char *name,
 	p->next = NULL;
 	index = major_to_index(major);
 
+	spin_lock(&major_names_spinlock);
 	for (n = &major_names[index]; *n; n = &(*n)->next) {
 		if ((*n)->major == major)
 			break;
@@ -279,6 +281,7 @@ int __register_blkdev(unsigned int major, const char *name,
 		*n = p;
 	else
 		ret = -EBUSY;
+	spin_unlock(&major_names_spinlock);
 
 	if (ret < 0) {
 		printk("register_blkdev: cannot get major %u for %s\n",
@@ -298,6 +301,7 @@ void unregister_blkdev(unsigned int major, const char *name)
 	int index = major_to_index(major);
 
 	mutex_lock(&major_names_lock);
+	spin_lock(&major_names_spinlock);
 	for (n = &major_names[index]; *n; n = &(*n)->next)
 		if ((*n)->major == major)
 			break;
@@ -307,6 +311,7 @@ void unregister_blkdev(unsigned int major, const char *name)
 		p = *n;
 		*n = p->next;
 	}
+	spin_unlock(&major_names_spinlock);
 	mutex_unlock(&major_names_lock);
 	kfree(p);
 }
-- 
2.30.2

