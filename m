Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8530C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 15:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiGUPbh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiGUPbg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 11:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FF353C159
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658417494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=twM686el8o1QFMYazyj1zebhKygEMIdVZN/qupWWZPQ=;
        b=XYxqg4q5g71JpVv7/WSsywRhCq5TUN32CeBIUeXeCTx4vR2EYoPeTKWfR1uRbtN6HOHUZS
        5AVoF0zY93SKMI9YdP/d/d83tfAYrNGfyVJvU4/88+ZdhSeWjT3n4/lc5j47tqCvOUkdeI
        +CmnoeM8INirwhFlJuZKkF3G8lilE9Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-NmZ4a4lDNvWCkXVZYoVKBA-1; Thu, 21 Jul 2022 11:31:25 -0400
X-MC-Unique: NmZ4a4lDNvWCkXVZYoVKBA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA51B811E76;
        Thu, 21 Jul 2022 15:31:24 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E637240466B1;
        Thu, 21 Jul 2022 15:31:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] ublk_drv: fix lockdep warning
Date:   Thu, 21 Jul 2022 23:31:17 +0800
Message-Id: <20220721153117.591394-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ub->mutex is used to protecting reading and writing ub->mm, then the
following lockdep warning is triggered.

Fix it by using one dedicated spin lock for protecting ub->mm.

[1] lockdep warning
[   25.046186] ======================================================
[   25.048886] WARNING: possible circular locking dependency detected
[   25.051610] 5.19.0-rc4_for-v5.20+ #149 Not tainted
[   25.053665] ------------------------------------------------------
[   25.056334] ublk/989 is trying to acquire lock:
[   25.058296] ffff975d0329a918 (&disk->open_mutex){+.+.}-{3:3}, at: bd_register_pending_holders+0x2a/0x110
[   25.063678]
[   25.063678] but task is already holding lock:
[   25.066246] ffff975d1df59708 (&ub->mutex){+.+.}-{3:3}, at: ublk_ctrl_uring_cmd+0x2df/0x730
[   25.069423]
[   25.069423] which lock already depends on the new lock.
[   25.069423]
[   25.072603]
[   25.072603] the existing dependency chain (in reverse order) is:
[   25.074908]
[   25.074908] -> #3 (&ub->mutex){+.+.}-{3:3}:
[   25.076386]        __mutex_lock+0x93/0x870
[   25.077470]        ublk_ch_mmap+0x3a/0x140
[   25.078494]        mmap_region+0x375/0x5a0
[   25.079386]        do_mmap+0x33a/0x530
[   25.080168]        vm_mmap_pgoff+0xb9/0x150
[   25.080979]        ksys_mmap_pgoff+0x184/0x1f0
[   25.081838]        do_syscall_64+0x37/0x80
[   25.082653]        entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   25.083730]
[   25.083730] -> #2 (&mm->mmap_lock#2){++++}-{3:3}:
[   25.084707]        __might_fault+0x55/0x80
[   25.085344]        _copy_from_user+0x1e/0xa0
[   25.086020]        get_sg_io_hdr+0x26/0xb0
[   25.086651]        scsi_ioctl+0x42f/0x960
[   25.087267]        sr_block_ioctl+0xe8/0x100
[   25.087734]        blkdev_ioctl+0x134/0x2b0
[   25.088196]        __x64_sys_ioctl+0x8a/0xc0
[   25.088677]        do_syscall_64+0x37/0x80
[   25.089044]        entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   25.089548]
[   25.089548] -> #1 (&cd->lock){+.+.}-{3:3}:
[   25.090072]        __mutex_lock+0x93/0x870
[   25.090452]        sr_block_open+0x64/0xe0
[   25.090837]        blkdev_get_whole+0x26/0x90
[   25.091445]        blkdev_get_by_dev.part.0+0x1ce/0x2f0
[   25.092203]        blkdev_open+0x52/0x90
[   25.092617]        do_dentry_open+0x1ca/0x360
[   25.093499]        path_openat+0x78d/0xcb0
[   25.094136]        do_filp_open+0xa1/0x130
[   25.094759]        do_sys_openat2+0x76/0x130
[   25.095454]        __x64_sys_openat+0x5c/0x70
[   25.096078]        do_syscall_64+0x37/0x80
[   25.096637]        entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   25.097304]
[   25.097304] -> #0 (&disk->open_mutex){+.+.}-{3:3}:
[   25.098229]        __lock_acquire+0x12e2/0x1f90
[   25.098789]        lock_acquire+0xbf/0x2c0
[   25.099256]        __mutex_lock+0x93/0x870
[   25.099706]        bd_register_pending_holders+0x2a/0x110
[   25.100246]        device_add_disk+0x209/0x370
[   25.100712]        ublk_ctrl_uring_cmd+0x405/0x730
[   25.101205]        io_issue_sqe+0xfe/0x2ac0
[   25.101665]        io_submit_sqes+0x352/0x1820
[   25.102131]        __do_sys_io_uring_enter+0x848/0xdc0
[   25.102646]        do_syscall_64+0x37/0x80
[   25.103087]        entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   25.103640]
[   25.103640] other info that might help us debug this:
[   25.103640]
[   25.104549] Chain exists of:
[   25.104549]   &disk->open_mutex --> &mm->mmap_lock#2 --> &ub->mutex
[   25.104549]
[   25.105611]  Possible unsafe locking scenario:
[   25.105611]
[   25.106258]        CPU0                    CPU1
[   25.106677]        ----                    ----
[   25.107100]   lock(&ub->mutex);
[   25.107446]                                lock(&mm->mmap_lock#2);
[   25.108045]                                lock(&ub->mutex);
[   25.108802]   lock(&disk->open_mutex);
[   25.109265]
[   25.109265]  *** DEADLOCK ***
[   25.109265]
[   25.110117] 2 locks held by ublk/989:
[   25.110490]  #0: ffff975d07bbf8a8 (&ctx->uring_lock){+.+.}-{3:3}, at: __do_sys_io_uring_enter+0x83e/0xdc0
[   25.111249]  #1: ffff975d1df59708 (&ub->mutex){+.+.}-{3:3}, at: ublk_ctrl_uring_cmd+0x2df/0x730
[   25.111943]
[   25.111943] stack backtrace:
[   25.112557] CPU: 2 PID: 989 Comm: ublk Not tainted 5.19.0-rc4_for-v5.20+ #149
[   25.113137] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1.fc33 04/01/2014
[   25.113792] Call Trace:
[   25.114130]  <TASK>
[   25.114417]  dump_stack_lvl+0x71/0xa0
[   25.114771]  check_noncircular+0xdf/0x100
[   25.115137]  ? register_lock_class+0x38/0x470
[   25.115524]  __lock_acquire+0x12e2/0x1f90
[   25.115887]  ? find_held_lock+0x2b/0x80
[   25.116244]  lock_acquire+0xbf/0x2c0
[   25.116590]  ? bd_register_pending_holders+0x2a/0x110
[   25.117009]  __mutex_lock+0x93/0x870
[   25.117362]  ? bd_register_pending_holders+0x2a/0x110
[   25.117780]  ? bd_register_pending_holders+0x2a/0x110
[   25.118201]  ? kobject_add+0x71/0x90
[   25.118546]  ? bd_register_pending_holders+0x2a/0x110
[   25.118958]  bd_register_pending_holders+0x2a/0x110
[   25.119373]  device_add_disk+0x209/0x370
[   25.119732]  ublk_ctrl_uring_cmd+0x405/0x730
[   25.120109]  ? rcu_read_lock_sched_held+0x3c/0x70
[   25.120514]  io_issue_sqe+0xfe/0x2ac0
[   25.120863]  io_submit_sqes+0x352/0x1820
[   25.121228]  ? rcu_read_lock_sched_held+0x3c/0x70
[   25.121626]  ? __do_sys_io_uring_enter+0x83e/0xdc0
[   25.122028]  ? find_held_lock+0x2b/0x80
[   25.122390]  ? __do_sys_io_uring_enter+0x848/0xdc0
[   25.122791]  __do_sys_io_uring_enter+0x848/0xdc0
[   25.123190]  ? syscall_enter_from_user_mode+0x20/0x70
[   25.123606]  ? syscall_enter_from_user_mode+0x20/0x70
[   25.124024]  do_syscall_64+0x37/0x80
[   25.124383]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   25.124829] RIP: 0033:0x7f120a762af6
[   25.125223] Code: 45 c1 41 89 c2 41 b9 08 00 00 00 41 83 ca 10 f6 87 d0 00 00 00 01 8b bf cc 00 00 00 44 0f 44 d0 45 31 c0c
[   25.126576] RSP: 002b:00007ffdcb3c5518 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
[   25.127153] RAX: ffffffffffffffda RBX: 00000000013aef50 RCX: 00007f120a762af6
[   25.127748] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000004
[   25.128351] RBP: 000000000000000b R08: 0000000000000000 R09: 0000000000000008
[   25.128956] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdcb3c74a6
[   25.129524] R13: 00000000013aef50 R14: 0000000000000000 R15: 00000000000003df
[   25.130121]  </TASK>

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 81bfdda0f1af..f058f40b639c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -131,6 +131,7 @@ struct ublk_device {
 
 	struct mutex		mutex;
 
+	spinlock_t		mm_lock;
 	struct mm_struct	*mm;
 
 	struct completion	completion;
@@ -678,12 +679,12 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 	unsigned long pfn, end, phys_off = vma->vm_pgoff << PAGE_SHIFT;
 	int q_id, ret = 0;
 
-	mutex_lock(&ub->mutex);
+	spin_lock(&ub->mm_lock);
 	if (!ub->mm)
 		ub->mm = current->mm;
 	if (current->mm != ub->mm)
 		ret = -EINVAL;
-	mutex_unlock(&ub->mutex);
+	spin_unlock(&ub->mm_lock);
 
 	if (ret)
 		return ret;
@@ -1122,6 +1123,7 @@ static int ublk_add_dev(struct ublk_device *ub)
 
 	ublk_align_max_io_size(ub);
 	mutex_init(&ub->mutex);
+	spin_lock_init(&ub->mm_lock);
 
 	/* add char dev so that ublksrv daemon can be setup */
 	return ublk_add_chdev(ub);
-- 
2.31.1

