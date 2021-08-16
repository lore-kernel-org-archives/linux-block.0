Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872E1C4338F
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 14:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660D56054E
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 14:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhHPOpS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:45:18 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64612 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhHPOpR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 10:45:17 -0400
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17GEiGjL036117;
        Mon, 16 Aug 2021 23:44:16 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Mon, 16 Aug 2021 23:44:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17GEiFMO036104
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 16 Aug 2021 23:44:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] block: genhd: don't call probe function with
 major_names_lock held
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hillf Danton <hdanton@sina.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-block <linux-block@vger.kernel.org>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
 <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp>
 <20210816073313.GA27275@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <2901b9c2-f798-413e-4073-451259718288@i-love.sakura.ne.jp>
Date:   Mon, 16 Aug 2021 23:44:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210816073313.GA27275@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/16 16:33, Christoph Hellwig wrote:
> This is the wrong way to approach it.  Instead of making things ever
> more complex try to make it simpler.  In this case, ensure that the
> destroy_workqueue is not held with pointless locks.  Given that the
> loop device already is known to not have a reference and marked as in
> the rundown state there shouldn't be anything that is required to
> be protected by lo_mutex.  So something like this untested patch
> should probably do the work:

I tested your untested patch, and I confirmed that your untested patch
does not fix the circular locking problem, for you are not seeing the
entire dependency chain.

> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index fa1c298a8cfb..c734dc768316 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1347,16 +1347,15 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>  	 * became visible.
>  	 */
>  
> -	mutex_lock(&lo->lo_mutex);
>  	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
>  		err = -ENXIO;
> -		goto out_unlock;
> +		goto out;
>  	}

Would you please write your patch as verbose as mine? Since your patch
lacks why it is safe to make such change, I can't review your patch.
I wonder why "goto out;" (which sets lo->lo_state = Lo_unbound) is
the correct choice here.

>  
>  	filp = lo->lo_backing_file;
>  	if (filp == NULL) {
>  		err = -EINVAL;
> -		goto out_unlock;
> +		goto out;
>  	}

I also wonder when lo->lo_backing_file == NULL case is possible.

As far as I can see, "lo->lo_state = Lo_rundown;" is done only when
"lo->lo_state == Lo_bound". And "lo->lo_state = Lo_bound;" is done
only when "lo->lo_backing_file = file;" was done.

I guess this is another sanity check which should use WARN_ON_ONCE().

>  
>  	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
> @@ -1366,6 +1365,8 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>  	blk_mq_freeze_queue(lo->lo_queue);

I also wonder why it is safe to call blk_mq_freeze_queue() without holding
lo->lo_mutex. loop_change_fd(), loop_set_status(), lo_release() etc. are
calling blk_mq_freeze_queue() with lo->lo_mutex held.

If we need to hold lo->lo_mutex when calling blk_mq_freeze_queue() from
__loop_clr_fd(), why it is safe to once release lo->lo_mutex before
destroy_workqueue() and reacquire lo->lo_mutex after destroy_workqueue() ?

Since there is too little comment regarding what lock protects what resource
and/or operation, nobody can review the correctness of locking in loop module.
The loop module is a labyrinth...

>  
>  	destroy_workqueue(lo->workqueue);
> +
> +	mutex_lock(&lo->lo_mutex);
>  	spin_lock_irq(&lo->lo_work_lock);
>  	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
>  				idle_list) {
> @@ -1413,8 +1414,8 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>  	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN && bdev;
>  	lo_number = lo->lo_number;
>  	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
> -out_unlock:
>  	mutex_unlock(&lo->lo_mutex);
> +
>  	if (partscan) {
>  		/*
>  		 * open_mutex has been held already in release path, so don't
> @@ -1435,7 +1436,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>  		/* Device is gone, no point in returning error */
>  		err = 0;
>  	}
> -
> +out:
>  	/*
>  	 * lo->lo_state is set to Lo_unbound here after above partscan has
>  	 * finished.
> 

Anyway, I modified your patch as below and tested on v5.14-rc6.

----------------------------------------
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f0cdff0c5fbf..daa47cea8a32 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1349,17 +1349,12 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	 * became visible.
 	 */
 
-	mutex_lock(&lo->lo_mutex);
-	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
-		err = -ENXIO;
-		goto out_unlock;
-	}
+	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown))
+		return -ENXIO;
 
 	filp = lo->lo_backing_file;
-	if (filp == NULL) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
+	if (WARN_ON_ONCE(!filp))
+		return -EINVAL;
 
 	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
 		blk_queue_write_cache(lo->lo_queue, false, false);
@@ -1368,6 +1363,8 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	blk_mq_freeze_queue(lo->lo_queue);
 
 	destroy_workqueue(lo->workqueue);
+
+	mutex_lock(&lo->lo_mutex);
 	spin_lock_irq(&lo->lo_work_lock);
 	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
 				idle_list) {
@@ -1415,8 +1412,8 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN && bdev;
 	lo_number = lo->lo_number;
-out_unlock:
 	mutex_unlock(&lo->lo_mutex);
+
 	if (partscan) {
 		/*
 		 * open_mutex has been held already in release path, so don't
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 6ce4bc57f919..d02412055e6c 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -525,14 +525,10 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
 	if (!blktrans_notifier.list.next)
 		register_mtd_user(&blktrans_notifier);
 
-
-	mutex_lock(&mtd_table_mutex);
-
 	ret = register_blkdev(tr->major, tr->name);
 	if (ret < 0) {
 		printk(KERN_WARNING "Unable to register %s block device on major %d: %d\n",
 		       tr->name, tr->major, ret);
-		mutex_unlock(&mtd_table_mutex);
 		return ret;
 	}
 
@@ -542,12 +538,12 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
 	tr->blkshift = ffs(tr->blksize) - 1;
 
 	INIT_LIST_HEAD(&tr->devs);
-	list_add(&tr->list, &blktrans_majors);
 
+	mutex_lock(&mtd_table_mutex);
+	list_add(&tr->list, &blktrans_majors);
 	mtd_for_each_device(mtd)
 		if (mtd->type != MTD_ABSENT)
 			tr->add_mtd(tr, mtd);
-
 	mutex_unlock(&mtd_table_mutex);
 	return 0;
 }
----------------------------------------

And I immediately got the following lockdep warning (as I expected).

----------------------------------------
[  124.519262] loop0: detected capacity change from 0 to 4096
[  124.552028] EXT4-fs error (device loop0): ext4_fill_super:4956: inode #2: comm a.out: iget: root inode unallocated
[  124.556889] EXT4-fs (loop0): get root inode failed
[  124.559074] EXT4-fs (loop0): mount failed

[  124.917463] ======================================================
[  124.919741] WARNING: possible circular locking dependency detected
[  124.922233] 5.14.0-rc6+ #744 Not tainted
[  124.923799] ------------------------------------------------------
[  124.925996] systemd-udevd/6710 is trying to acquire lock:
[  124.928106] ffff88800dc82948 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x85/0x560
[  124.931100]
               but task is already holding lock:
[  124.933388] ffff88800dc87128 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x30/0x180
[  124.936216]
               which lock already depends on the new lock.

[  124.939807]
               the existing dependency chain (in reverse order) is:
[  124.942741]
               -> #6 (&disk->open_mutex){+.+.}-{3:3}:
[  124.945672]        lock_acquire+0xd0/0x300
[  124.947321]        __mutex_lock+0x97/0x950
[  124.948938]        del_gendisk+0x4e/0x1d0
[  124.950666]        loop_remove+0x10/0x40
[  124.952238]        loop_control_ioctl+0x193/0x1a0
[  124.954068]        __x64_sys_ioctl+0x6a/0xa0
[  124.955736]        do_syscall_64+0x35/0xb0
[  124.957326]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  124.959358]
               -> #5 (loop_ctl_mutex){+.+.}-{3:3}:
[  124.962171]        lock_acquire+0xd0/0x300
[  124.963810]        __mutex_lock+0x97/0x950
[  124.965426]        loop_add+0x44/0x2c0
[  124.966890]        blk_request_module+0x63/0xc0
[  124.968526]        blkdev_get_no_open+0x98/0xc0
[  124.970361]        blkdev_get_by_dev+0x54/0x330
[  124.972108]        blkdev_open+0x59/0xa0
[  124.973681]        do_dentry_open+0x14c/0x3a0
[  124.975321]        path_openat+0x78e/0xa50
[  124.977043]        do_filp_open+0xad/0x120
[  124.979067]        do_sys_openat2+0x241/0x310
[  124.980969]        do_sys_open+0x3f/0x80
[  124.982581]        do_syscall_64+0x35/0xb0
[  124.984201]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  124.986265]
               -> #4 (major_names_lock){+.+.}-{3:3}:
[  124.988750]        lock_acquire+0xd0/0x300
[  124.990405]        __mutex_lock+0x97/0x950
[  124.992091]        blkdev_show+0x18/0x90
[  124.993674]        devinfo_show+0x58/0x70
[  124.995404]        seq_read_iter+0x27b/0x3f0
[  124.997072]        proc_reg_read_iter+0x3c/0x60
[  124.998719]        new_sync_read+0x110/0x190
[  125.000428]        vfs_read+0x11d/0x1b0
[  125.001867]        ksys_read+0x63/0xe0
[  125.003429]        do_syscall_64+0x35/0xb0
[  125.005099]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  125.007527]
               -> #3 (&p->lock){+.+.}-{3:3}:
[  125.009796]        lock_acquire+0xd0/0x300
[  125.011675]        __mutex_lock+0x97/0x950
[  125.013469]        seq_read_iter+0x4c/0x3f0
[  125.015295]        generic_file_splice_read+0xf7/0x1a0
[  125.017381]        splice_direct_to_actor+0xc0/0x230
[  125.019268]        do_splice_direct+0x8c/0xd0
[  125.021085]        do_sendfile+0x319/0x5a0
[  125.022737]        __x64_sys_sendfile64+0xad/0xc0
[  125.024571]        do_syscall_64+0x35/0xb0
[  125.026347]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  125.028731]
               -> #2 (sb_writers#3){.+.+}-{0:0}:
[  125.031219]        lock_acquire+0xd0/0x300
[  125.032799]        lo_write_bvec+0xe1/0x260
[  125.034456]        loop_process_work+0x3e5/0xcf0
[  125.036629]        process_one_work+0x2aa/0x600
[  125.038524]        worker_thread+0x48/0x3d0
[  125.040279]        kthread+0x13e/0x170
[  125.041824]        ret_from_fork+0x1f/0x30
[  125.043639]
               -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
[  125.047124]        lock_acquire+0xd0/0x300
[  125.048763]        process_one_work+0x27e/0x600
[  125.050544]        worker_thread+0x48/0x3d0
[  125.052206]        kthread+0x13e/0x170
[  125.053703]        ret_from_fork+0x1f/0x30
[  125.055324]
               -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
[  125.057947]        check_prev_add+0x91/0xc00
[  125.059585]        __lock_acquire+0x14a8/0x1f40
[  125.061433]        lock_acquire+0xd0/0x300
[  125.063203]        flush_workqueue+0xa9/0x560
[  125.064891]        drain_workqueue+0x9b/0x100
[  125.066638]        destroy_workqueue+0x2f/0x210
[  125.068305]        __loop_clr_fd+0xa9/0x5b0
[  125.070086]        blkdev_put+0xaf/0x180
[  125.071606]        blkdev_close+0x20/0x30
[  125.073522]        __fput+0xa0/0x240
[  125.074924]        task_work_run+0x57/0xa0
[  125.076564]        exit_to_user_mode_prepare+0x252/0x260
[  125.078666]        syscall_exit_to_user_mode+0x19/0x60
[  125.080784]        do_syscall_64+0x42/0xb0
[  125.082360]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  125.084403]
               other info that might help us debug this:

[  125.087757] Chain exists of:
                 (wq_completion)loop0 --> loop_ctl_mutex --> &disk->open_mutex

[  125.092256]  Possible unsafe locking scenario:

[  125.094994]        CPU0                    CPU1
[  125.096963]        ----                    ----
[  125.098729]   lock(&disk->open_mutex);
[  125.100224]                                lock(loop_ctl_mutex);
[  125.102521]                                lock(&disk->open_mutex);
[  125.104862]   lock((wq_completion)loop0);
[  125.106511]
                *** DEADLOCK ***

[  125.109224] 1 lock held by systemd-udevd/6710:
[  125.111072]  #0: ffff88800dc87128 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x30/0x180
[  125.114270]
               stack backtrace:
[  125.116193] CPU: 3 PID: 6710 Comm: systemd-udevd Not tainted 5.14.0-rc6+ #744
[  125.118706] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[  125.122536] Call Trace:
[  125.123604]  dump_stack_lvl+0x57/0x7d
[  125.125064]  check_noncircular+0x114/0x130
[  125.126621]  check_prev_add+0x91/0xc00
[  125.128264]  ? __lock_acquire+0x5c1/0x1f40
[  125.129953]  __lock_acquire+0x14a8/0x1f40
[  125.131544]  lock_acquire+0xd0/0x300
[  125.132936]  ? flush_workqueue+0x85/0x560
[  125.134500]  ? lockdep_init_map_type+0x51/0x220
[  125.136299]  ? lockdep_init_map_type+0x51/0x220
[  125.138086]  flush_workqueue+0xa9/0x560
[  125.139761]  ? flush_workqueue+0x85/0x560
[  125.141318]  ? drain_workqueue+0x9b/0x100
[  125.142822]  drain_workqueue+0x9b/0x100
[  125.144486]  destroy_workqueue+0x2f/0x210
[  125.146190]  __loop_clr_fd+0xa9/0x5b0
[  125.147655]  ? __mutex_unlock_slowpath+0x40/0x2a0
[  125.149516]  blkdev_put+0xaf/0x180
[  125.151042]  blkdev_close+0x20/0x30
[  125.152548]  __fput+0xa0/0x240
[  125.153865]  task_work_run+0x57/0xa0
[  125.155394]  exit_to_user_mode_prepare+0x252/0x260
[  125.157248]  syscall_exit_to_user_mode+0x19/0x60
[  125.158997]  do_syscall_64+0x42/0xb0
[  125.160510]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  125.162554] RIP: 0033:0x7eff14494987
[  125.164075] Code: ff ff e8 9c 11 02 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 c3 5d f8 ff
[  125.170670] RSP: 002b:00007ffde2ab8e58 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  125.173563] RAX: 0000000000000000 RBX: 00007eff13f1c788 RCX: 00007eff14494987
[  125.176138] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
[  125.178858] RBP: 0000000000000006 R08: 0000562c4155aaf0 R09: 0000000000000000
[  125.181641] R10: 00007eff13f1c788 R11: 0000000000000246 R12: 0000000000000000
[  125.184197] R13: 0000000000000000 R14: 0000000000000000 R15: 0000562c41542635
[  125.187428] loop0: detected capacity change from 0 to 4096
----------------------------------------

I was expecting this result from the beginning.

Before your patch, lockdep thinks that there are

  loop_ctl_mutex => &lo->lo_mutex => (wq_completion)loop$M =>
  (work_completion)&lo->rootcg_work => sb_writers#$N => &p->lock =>
  major_names_lock => loop_ctl_mutex

dependency chain and

  &disk->open_mutex => &lo->lo_mutex => (wq_completion)loop$M =>
  (work_completion)&lo->rootcg_work => sb_writers#$N => &p->lock =>
  major_names_lock => loop_ctl_mutex

dependency chain (as explained in my patch). Since your patch attempts to
take (wq_completion)loop$M without &lo->lo_mutex, the dependency chain
after your patch will become

  &disk->open_mutex => (wq_completion)loop$M =>
  (work_completion)&lo->rootcg_work => sb_writers#$N => &p->lock =>
  major_names_lock => loop_ctl_mutex

but after all

  loop_ctl_mutex => &disk->open_mutex

dependency is appended when loop_control_remove() from
loop_control_ioctl(LOOP_CTL_REMOVE) is called...

Not only it is unclear what lo->lo_mutex lock is protecting, but also it is
unclear and erroneous what loop_ctl_mutex lock is protecting. Nobody noticed
lack of loop_ctl_mutex protection in the following patch.

On 2021/08/15 15:52, Tetsuo Handa wrote:
> There would be two approaches for breaking this circular dependency.
> One is to kill loop_ctl_mutex => &lo->lo_mutex chain. The other is to
> kill major_names_lock => loop_ctl_mutex chain. This patch implements
> the latter, due to the following reasons.

F.Y.I. Below is a patch for implementing the former.
This is less suitable for backport, for this is more difficult to review.

 From 1b95e875071961b22420f69ac6c5a8ae9aa11638 Mon Sep 17 00:00:00 2001From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 14 Aug 2021 14:21:36 +0900
Subject: [PATCH] loop: break loop_ctl_mutex into loop_idr_spinlock and loop_removal_mutex

syzbot is reporting circular locking problem at __loop_clr_fd() [1], for
commit a160c6159d4a0cf8 ("block: add an optional probe callback to
major_names") is calling the module's probe function with major_names_lock
held.

Fortunately, since commit 990e78116d38059c ("block: loop: fix deadlock
between open and remove") stopped holding loop_ctl_mutex in lo_open(),
current role of loop_ctl_mutex is to serialize access to loop_index_idr
and loop_add()/loop_remove(); in other words, management of id for IDR.

Since IDR allows idr_replace(), we can reserve id for not-yet-initialized
and to-be-released loop devices, by assigning a dummy pointer to that
reserved id. By using idr_replace(), we can replace loop_ctl_mutex with
loop_idr_spinlock for protecting access to loop_index_idr.

By introducing loop_idr_spinlock, remaining role of loop_ctl_mutex can be
reduced to serialization of loop_control_remove(). Thus, let's rename
loop_ctl_mutex to loop_removal_mutex. Note that removing serialization
between loop_add() and loop_remove() has a side effect

  Thread A:             Thread B:

  loop_remove(1) {
    Lock loop_removal_mutex.
    lo = idr_find(1);
    idr_replace(dummy, 1);
    Unlock loop_removal_mutex.
                        loop_remove(1) {
                          Lock loop_removal_mutex.
                          lo = idr_find(1);
                          Unlock loop_removal_mutex.
                          Fails with -ENODEV due to lo == dummy.
                        }
                        loop_add(1) {
                          Fails with -EEXIST due to idr_alloc(1) failure.
                        }
    loop_remove(lo) {
      idr_remove(1);
    }
    return 0;
  }

which we could argue such sequence as a caller's bug. /dev/loop-control
users are expected to serialize ioctl() calls when passing non-negative
same id value. As long as ioctl() calls with non-negative same id value
are serialized, this approach can minimize serialization by
loop_removal_mutex.

In loop_control_remove(), we might expect that we can get rid of
loop_removal_mutex if we temporarily hide this lo (using idr_replace())
before holding lo_mutex and show this lo again (using idr_replace()) if
loop_remove() cannot be called. But we can't get rid of loop_removal_mutex
in order to close a use-after-free race window explained below.

I found that loop_unregister_transfer() which is called from
cleanup_cryptoloop() lacks serialization between kfree() from
loop_remove() from loop_control_remove() and mutex_lock() from
unregister_transfer_cb().

Both loop_control_remove() and loop_unregister_transfer() hold lo_mutex
of lo found from loop_index_idr, but loop_unregister_transfer() must
synchronously check all lo found from loop_index_idr (and call
loop_release_xfer() as needed) due to being called by module unloading
operation. Temporarily hiding lo on loop_control_remove() side can result
in failing to call loop_release_xfer() from unregister_transfer_cb() from
loop_unregister_transfer().

Given that cryptoloop is not safe for journaled file systems, I wonder
how many cryptoloop users are there. We could consider getting rid of
loop_unregister_transfer() by removing cleanup_cryptoloop() (i.e. make
cryptoloop no longer unloadable) which is the only in-tree caller of
loop_unregister_transfer() function.

For now, we need to hold loop_removal_mutex in loop_unregister_transfer().
In contrast, holding loop_removal_mutex in loop_exit() is pointless, for
all users must close /dev/loop-control and /dev/loop$num (in order to drop
module's refcount to 0) before loop_exit() starts, and nobody can open
/dev/loop-control or /dev/loop$num afterwards.

Link: https://syzkaller.appspot.com/bug?id=7bb10e8b62f83e4d445cdf4c13d69e407e629558 [1]
Reported-by: syzbot <syzbot+f61766d5763f9e7a118f@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+f61766d5763f9e7a118f@syzkaller.appspotmail.com>
---

 drivers/block/loop.c | 130 +++++++++++++++++++++++++++++--------------
 1 file changed, 89 insertions(+), 41 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f0cdff0c5fbf..424d90f978d5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -86,8 +86,15 @@
 
 #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
 
+/*
+ * Used for avoiding -EEXIST error at bdi_register() which happens when id is reused
+ * before bdi_unregister() completes, by preserving specific id for loop_index_idr.
+ */
+#define HIDDEN_LOOP_DEVICE ((struct loop_device *) -1)
+
 static DEFINE_IDR(loop_index_idr);
-static DEFINE_MUTEX(loop_ctl_mutex);
+static DEFINE_SPINLOCK(loop_idr_spinlock);
+static DEFINE_MUTEX(loop_removal_mutex);
 static DEFINE_MUTEX(loop_validate_mutex);
 
 /**
@@ -2113,28 +2120,37 @@ int loop_register_transfer(struct loop_func_table *funcs)
 	return 0;
 }
 
-static int unregister_transfer_cb(int id, void *ptr, void *data)
-{
-	struct loop_device *lo = ptr;
-	struct loop_func_table *xfer = data;
-
-	mutex_lock(&lo->lo_mutex);
-	if (lo->lo_encryption == xfer)
-		loop_release_xfer(lo);
-	mutex_unlock(&lo->lo_mutex);
-	return 0;
-}
-
 int loop_unregister_transfer(int number)
 {
 	unsigned int n = number;
 	struct loop_func_table *xfer;
+	struct loop_device *lo;
+	int id;
 
 	if (n == 0 || n >= MAX_LO_CRYPT || (xfer = xfer_funcs[n]) == NULL)
 		return -EINVAL;
 
 	xfer_funcs[n] = NULL;
-	idr_for_each(&loop_index_idr, &unregister_transfer_cb, xfer);
+
+	/*
+	 * Use loop_removal_mutex in order to make sure that
+	 * loop_control_remove() won't call loop_remove().
+	 */
+	mutex_lock(&loop_removal_mutex);
+	spin_lock(&loop_idr_spinlock);
+	idr_for_each_entry(&loop_index_idr, lo, id) {
+		if (lo == HIDDEN_LOOP_DEVICE)
+			continue;
+		spin_unlock(&loop_idr_spinlock);
+		mutex_lock(&lo->lo_mutex);
+		if (lo->lo_encryption == xfer)
+			loop_release_xfer(lo);
+		mutex_unlock(&lo->lo_mutex);
+		spin_lock(&loop_idr_spinlock);
+	}
+	spin_unlock(&loop_idr_spinlock);
+	mutex_unlock(&loop_removal_mutex);
+
 	return 0;
 }
 
@@ -2313,20 +2329,21 @@ static int loop_add(int i)
 		goto out;
 	lo->lo_state = Lo_unbound;
 
-	err = mutex_lock_killable(&loop_ctl_mutex);
-	if (err)
-		goto out_free_dev;
-
 	/* allocate id, if @id >= 0, we're requesting that specific id */
+	idr_preload(GFP_KERNEL);
+	/* Reserve id for this loop device, but keep this loop device hidden. */
+	spin_lock(&loop_idr_spinlock);
 	if (i >= 0) {
-		err = idr_alloc(&loop_index_idr, lo, i, i + 1, GFP_KERNEL);
+		err = idr_alloc(&loop_index_idr, HIDDEN_LOOP_DEVICE, i, i + 1, GFP_ATOMIC);
 		if (err == -ENOSPC)
 			err = -EEXIST;
 	} else {
-		err = idr_alloc(&loop_index_idr, lo, 0, 0, GFP_KERNEL);
+		err = idr_alloc(&loop_index_idr, HIDDEN_LOOP_DEVICE, 0, 0, GFP_ATOMIC);
 	}
+	spin_unlock(&loop_idr_spinlock);
+	idr_preload_end();
 	if (err < 0)
-		goto out_unlock;
+		goto out_free_dev;
 	i = err;
 
 	err = -ENOMEM;
@@ -2392,16 +2409,21 @@ static int loop_add(int i)
 	disk->private_data	= lo;
 	disk->queue		= lo->lo_queue;
 	sprintf(disk->disk_name, "loop%d", i);
+	/* Make this loop device reachable from pathname. */
 	add_disk(disk);
-	mutex_unlock(&loop_ctl_mutex);
+	/* Show this loop device. */
+	spin_lock(&loop_idr_spinlock);
+	idr_replace(&loop_index_idr, lo, i);
+	spin_unlock(&loop_idr_spinlock);
 	return i;
 
 out_cleanup_tags:
 	blk_mq_free_tag_set(&lo->tag_set);
 out_free_idr:
+	/* Release id reserved for lo->lo_number. */
+	spin_lock(&loop_idr_spinlock);
 	idr_remove(&loop_index_idr, i);
-out_unlock:
-	mutex_unlock(&loop_ctl_mutex);
+	spin_unlock(&loop_idr_spinlock);
 out_free_dev:
 	kfree(lo);
 out:
@@ -2410,9 +2432,15 @@ static int loop_add(int i)
 
 static void loop_remove(struct loop_device *lo)
 {
+	/* Make this loop device unreachable from pathname. */
 	del_gendisk(lo->lo_disk);
 	blk_cleanup_disk(lo->lo_disk);
 	blk_mq_free_tag_set(&lo->tag_set);
+	/* Release id used by lo->lo_number. */
+	spin_lock(&loop_idr_spinlock);
+	idr_remove(&loop_index_idr, lo->lo_number);
+	spin_unlock(&loop_idr_spinlock);
+	/* There is no route which can find this loop device. */
 	mutex_destroy(&lo->lo_mutex);
 	kfree(lo);
 }
@@ -2435,52 +2463,68 @@ static int loop_control_remove(int idx)
 		pr_warn("deleting an unspecified loop device is not supported.\n");
 		return -EINVAL;
 	}
-		
-	ret = mutex_lock_killable(&loop_ctl_mutex);
+
+	/* Serialize concurrent loop_control_remove() and loop_unregister_transfer(). */
+	ret = mutex_lock_killable(&loop_removal_mutex);
 	if (ret)
 		return ret;
 
+	/*
+	 * Identify the loop device to remove. Skip the device if it is owned by
+	 * loop_remove()/loop_add() where it is not safe to access lo_mutex.
+	 */
+	spin_lock(&loop_idr_spinlock);
 	lo = idr_find(&loop_index_idr, idx);
-	if (!lo) {
+	if (!lo || lo == HIDDEN_LOOP_DEVICE) {
+		spin_unlock(&loop_idr_spinlock);
 		ret = -ENODEV;
-		goto out_unlock_ctrl;
+		goto out_unlock;
 	}
+	spin_unlock(&loop_idr_spinlock);
 
 	ret = mutex_lock_killable(&lo->lo_mutex);
 	if (ret)
-		goto out_unlock_ctrl;
+		goto out_unlock;
 	if (lo->lo_state != Lo_unbound ||
 	    atomic_read(&lo->lo_refcnt) > 0) {
 		mutex_unlock(&lo->lo_mutex);
 		ret = -EBUSY;
-		goto out_unlock_ctrl;
+		goto out_unlock;
 	}
+	/* Mark this loop device no longer open()-able. */
 	lo->lo_state = Lo_deleting;
 	mutex_unlock(&lo->lo_mutex);
 
-	idr_remove(&loop_index_idr, lo->lo_number);
+	/* Hide this loop device, but keep lo->lo_number still held. */
+	spin_lock(&loop_idr_spinlock);
+	idr_replace(&loop_index_idr, HIDDEN_LOOP_DEVICE, lo->lo_number);
+	spin_unlock(&loop_idr_spinlock);
+	/* Allow loop_control_remove() and loop_unregister_transfer() to resume. */
+	mutex_unlock(&loop_removal_mutex);
+	/* Remove this loop device. */
 	loop_remove(lo);
-out_unlock_ctrl:
-	mutex_unlock(&loop_ctl_mutex);
+	return 0;
+out_unlock:
+	mutex_unlock(&loop_removal_mutex);
 	return ret;
 }
 
 static int loop_control_get_free(int idx)
 {
 	struct loop_device *lo;
-	int id, ret;
+	int id;
 
-	ret = mutex_lock_killable(&loop_ctl_mutex);
-	if (ret)
-		return ret;
+	spin_lock(&loop_idr_spinlock);
 	idr_for_each_entry(&loop_index_idr, lo, id) {
+		if (lo == HIDDEN_LOOP_DEVICE)
+			continue;
 		if (lo->lo_state == Lo_unbound)
 			goto found;
 	}
-	mutex_unlock(&loop_ctl_mutex);
+	spin_unlock(&loop_idr_spinlock);
 	return loop_add(-1);
 found:
-	mutex_unlock(&loop_ctl_mutex);
+	spin_unlock(&loop_idr_spinlock);
 	return id;
 }
 
@@ -2590,10 +2634,14 @@ static void __exit loop_exit(void)
 	unregister_blkdev(LOOP_MAJOR, "loop");
 	misc_deregister(&loop_misc);
 
-	mutex_lock(&loop_ctl_mutex);
+	/*
+	 * There can't be hidden loop device on loop_index_idr, for loop_add()/loop_remove()
+	 * can't be in progress when this module is unloading. Also, there is no need to use
+	 * loop_idr_spinlock here, for nobody else can access loop_index_idr when this module
+	 * is unloading.
+	 */
 	idr_for_each_entry(&loop_index_idr, lo, id)
 		loop_remove(lo);
-	mutex_unlock(&loop_ctl_mutex);
 
 	idr_destroy(&loop_index_idr);
 }
-- 
2.18.4

