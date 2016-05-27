Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:44737 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbcE0LA3 (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 27 May 2016 07:00:29 -0400
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Markus Pargmann <mpa@pengutronix.de>, Jens Axboe <axboe@fb.com>
Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Paul Clements <paul.clements@steeleye.com>,
	Pavel Machek <pavel@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] nbd: fix race in ioctl
Date: Fri, 27 May 2016 12:59:35 +0200
Message-Id: <1464346775-370-1-git-send-email-vegard.nossum@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Quentin ran into this bug:

WARNING: CPU: 64 PID: 10085 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x65/0x80
sysfs: cannot create duplicate filename '/devices/virtual/block/nbd3/pid'
Modules linked in: nbd
CPU: 64 PID: 10085 Comm: qemu-nbd Tainted: G      D         4.6.0+ #7
 0000000000000000 ffff8820330bba68 ffffffff814b8791 ffff8820330bbac8
 0000000000000000 ffff8820330bbab8 ffffffff810d04ab ffff8820330bbaa8
 0000001f00000296 0000000000017681 ffff8810380bf000 ffffffffa0001790
Call Trace:
 [<ffffffff814b8791>] dump_stack+0x4d/0x6c
 [<ffffffff810d04ab>] __warn+0xdb/0x100
 [<ffffffff810d0574>] warn_slowpath_fmt+0x44/0x50
 [<ffffffff81218c65>] sysfs_warn_dup+0x65/0x80
 [<ffffffff81218a02>] sysfs_add_file_mode_ns+0x172/0x180
 [<ffffffff81218a35>] sysfs_create_file_ns+0x25/0x30
 [<ffffffff81594a76>] device_create_file+0x36/0x90
 [<ffffffffa0000e8d>] __nbd_ioctl+0x32d/0x9b0 [nbd]
 [<ffffffff814cc8e8>] ? find_next_bit+0x18/0x20
 [<ffffffff810f7c29>] ? select_idle_sibling+0xe9/0x120
 [<ffffffff810f6cd7>] ? __enqueue_entity+0x67/0x70
 [<ffffffff810f9bf0>] ? enqueue_task_fair+0x630/0xe20
 [<ffffffff810efa76>] ? resched_curr+0x36/0x70
 [<ffffffff810f0078>] ? check_preempt_curr+0x78/0x90
 [<ffffffff810f00a2>] ? ttwu_do_wakeup+0x12/0x80
 [<ffffffff810f01b1>] ? ttwu_do_activate.constprop.86+0x61/0x70
 [<ffffffff810f0c15>] ? try_to_wake_up+0x185/0x2d0
 [<ffffffff810f0d6d>] ? default_wake_function+0xd/0x10
 [<ffffffff81105471>] ? autoremove_wake_function+0x11/0x40
 [<ffffffffa0001577>] nbd_ioctl+0x67/0x94 [nbd]
 [<ffffffff814ac0fd>] blkdev_ioctl+0x14d/0x940
 [<ffffffff811b0da2>] ? put_pipe_info+0x22/0x60
 [<ffffffff811d96cc>] block_ioctl+0x3c/0x40
 [<ffffffff811ba08d>] do_vfs_ioctl+0x8d/0x5e0
 [<ffffffff811aa329>] ? ____fput+0x9/0x10
 [<ffffffff810e9092>] ? task_work_run+0x72/0x90
 [<ffffffff811ba627>] SyS_ioctl+0x47/0x80
 [<ffffffff8185f5df>] entry_SYSCALL_64_fastpath+0x17/0x93
---[ end trace 7899b295e4f850c8 ]---

It seems fairly obvious that device_create_file() is not being protected
from being run concurrently on the same nbd.

Quentin found the following relevant commits:

1a2ad21 nbd: add locking to nbd_ioctl
90b8f28 [PATCH] end of methods switch: remove the old ones
d4430d6 [PATCH] beginning of methods conversion
08f8585 [PATCH] move block_device_operations to blkdev.h

It would seem that the race was introduced in the process of moving nbd
from BKL to unlocked ioctls.

By setting nbd->task_recv while the mutex is held, we can prevent other
processes from running concurrently (since nbd->task_recv is also checked
while the mutex is held).

Reported-and-tested-by: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc: Markus Pargmann <mpa@pengutronix.de>
Cc: Paul Clements <paul.clements@steeleye.com>
Cc: Pavel Machek <pavel@suse.cz>
Cc: Jens Axboe <axboe@fb.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/block/nbd.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 31e73a7..a831f2b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -451,14 +451,9 @@ static int nbd_thread_recv(struct nbd_device *nbd, struct block_device *bdev)
 
 	sk_set_memalloc(nbd->sock->sk);
 
-	nbd->task_recv = current;
-
 	ret = device_create_file(disk_to_dev(nbd->disk), &pid_attr);
 	if (ret) {
 		dev_err(disk_to_dev(nbd->disk), "device_create_file failed!\n");
-
-		nbd->task_recv = NULL;
-
 		return ret;
 	}
 
@@ -477,9 +472,6 @@ static int nbd_thread_recv(struct nbd_device *nbd, struct block_device *bdev)
 	nbd_size_clear(nbd, bdev);
 
 	device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
-
-	nbd->task_recv = NULL;
-
 	return ret;
 }
 
@@ -788,6 +780,8 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		if (!nbd->sock)
 			return -EINVAL;
 
+		/* We have to claim the device under the lock */
+		nbd->task_recv = current;
 		mutex_unlock(&nbd->tx_lock);
 
 		nbd_parse_flags(nbd, bdev);
@@ -796,6 +790,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 				     nbd_name(nbd));
 		if (IS_ERR(thread)) {
 			mutex_lock(&nbd->tx_lock);
+			nbd->task_recv = NULL;
 			return PTR_ERR(thread);
 		}
 
@@ -805,6 +800,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		kthread_stop(thread);
 
 		mutex_lock(&nbd->tx_lock);
+		nbd->task_recv = NULL;
 
 		sock_shutdown(nbd);
 		nbd_clear_que(nbd);
-- 
1.9.1

