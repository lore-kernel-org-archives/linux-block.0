Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E82AF1D;
	Sun, 19 Apr 2026 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776591677; cv=none; b=cl12gzwM9X2tCNoN54wBxZHewEeoXBHD2vP6o4nJPgkCS2jBfvE1UCKAYRasiBYP2y2qnHh87FA8KWYOqSd6JxvHuE8t4qPDIvP5DCf0MDepsqoyzEiwI3unJyXnu4XmzmOJ2sVmcysTSc8vaWn7m19KNPqABvVHaU+FANVx65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776591677; c=relaxed/simple;
	bh=Jr5oUQiELIiQeLQa/7/t58UO5nbL6CQqy7gQ771b/lM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KRuZmuV3V4YncJcPsmV5iyEOn7tNdI9YoQsGSRmdW4LHGjWU/opydOV48gXrZzNEAxoCLK7nO8/XMqFZk+PQhQRqgWeywm0E1cICvqcjZ7JUsr/e0MQezAz9P48ZlAAZyYWl6BvHAFqHI/nc5VqMrcgeCN5jlyBgkp+9EcYMcl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=WvHNclLZ; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="WvHNclLZ"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3b457dc87;
	Sun, 19 Apr 2026 17:05:31 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: idryomov@gmail.com
Cc: axboe@kernel.dk,
	dongsheng.yang@linux.dev,
	mcgrof@kernel.org,
	ceph-devel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] rbd: fix null-ptr-deref when device_add_disk() fails
Date: Sun, 19 Apr 2026 17:03:48 +0800
Message-Id: <20260419090348.1817082-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9da4fce98c03a2kunm56c851691d06de
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSB9DVh5CGkxNTUtITx8dSFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=WvHNclLZKsOl2IPn9Y892RwspSmoi+WoagtbI1A35WAvFzkqdz6k3IGOiaF6EVJIWTMM+LFCFt0BIxQh4pjZm2aDmIBltUr4vii8eQNgv7UqcNIR5VwOpCxt9fKWvaxuFHqPAUzmTw5/hC2nINeADoqKF6XIigjQoUgoEZLiwTU=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=CdmJzqe0YXQQdfal4sK7CioKUZTavqi01VlJKBezrNs=;
	h=date:mime-version:subject:message-id:from;

do_rbd_add() publishes the device with device_add() before calling
device_add_disk(). If device_add_disk() fails after device_add()
succeeds, the error path calls rbd_free_disk() directly and then later
falls through to rbd_dev_device_release(), which calls rbd_free_disk()
again. This double teardown can leave blk-mq cleanup operating on
invalid state and trigger a null-ptr-deref in
__blk_mq_free_map_and_rqs(), reached from blk_mq_free_tag_set().

Fix this by following the normal remove ordering: call device_del()
before rbd_dev_device_release() when device_add_disk() fails after
device_add(). That keeps the teardown sequence consistent and avoids
re-entering disk cleanup through the wrong path.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available.

We reproduced the bug on v7.0 with a real Ceph backend and a QEMU x86_64
guest booted with KASAN and CONFIG_FAILSLAB enabled. The reproducer
confines failslab injections to the __add_disk() range and injects
fail-nth while mapping an RBD image through
/sys/bus/rbd/add_single_major.

On the unpatched kernel, fail-nth=4 reliably triggered the fault:

	Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
	KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
	CPU: 0 UID: 0 PID: 273 Comm: bash Not tainted 7.0.0-01247-gd60bc1401583 #6 PREEMPT(lazy)
	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
	RIP: 0010:__blk_mq_free_map_and_rqs+0x8c/0x240
	Code: 00 00 48 8b 6b 60 41 89 f4 49 c1 e4 03 4c 01 e5 45 85 ed 0f 85 0a 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 e9 48 c1 e9 03 <80> 3c 01 00 0f 85 31 01 00 00 4c 8b 6d 00 4d 85 ed 0f 84 e2 00 00
	RSP: 0018:ff1100000ab0fac8 EFLAGS: 00000246
	RAX: dffffc0000000000 RBX: ff1100000c4806a0 RCX: 0000000000000000
	RDX: 0000000000000002 RSI: 0000000000000000 RDI: ff1100000c4806f4
	RBP: 0000000000000000 R08: 0000000000000001 R09: ffe21c000189001b
	R10: ff1100000c4800df R11: ff1100006cf37be0 R12: 0000000000000000
	R13: 0000000000000000 R14: ff1100000c480700 R15: ff1100000c480004
	FS:  00007f0fbe8fe740(0000) GS:ff110000e5851000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 00007fe53473b2e0 CR3: 0000000012eef000 CR4: 00000000007516f0
	PKRU: 55555554
	Call Trace:
	 <TASK>
	 blk_mq_free_tag_set+0x77/0x460
	 do_rbd_add+0x1446/0x2b80
	 ? __pfx_do_rbd_add+0x10/0x10
	 ? lock_acquire+0x18c/0x300
	 ? find_held_lock+0x2b/0x80
	 ? sysfs_file_kobj+0xb6/0x1b0
	 ? __pfx_sysfs_kf_write+0x10/0x10
	 kernfs_fop_write_iter+0x2f4/0x4a0
	 vfs_write+0x98e/0x1000
	 ? expand_files+0x51f/0x850
	 ? __pfx_vfs_write+0x10/0x10
	 ksys_write+0xf2/0x1d0
	 ? __pfx_ksys_write+0x10/0x10
	 do_syscall_64+0x115/0x690
	 entry_SYSCALL_64_after_hwframe+0x77/0x7f
	RIP: 0033:0x7f0fbea15907
	Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
	RSP: 002b:00007ffe22346ea8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
	RAX: ffffffffffffffda RBX: 0000000000000058 RCX: 00007f0fbea15907
	RDX: 0000000000000058 RSI: 0000563ace6c0ef0 RDI: 0000000000000001
	RBP: 0000563ace6c0ef0 R08: 0000563ace6c0ef0 R09: 6b6435726d694141
	R10: 5250337279762f78 R11: 0000000000000246 R12: 0000000000000058
	R13: 00007f0fbeb1c780 R14: ff1100000c480700 R15: ff1100000c480004
	 </TASK>

With this fix applied, rerunning the reproducer over fail-nth=1..256
yields no KASAN reports.

Fixes: 27c97abc30e2 ("rbd: add add_disk() error handling")
Cc: stable@vger.kernel.org # 5.16+
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/block/rbd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e7da06200c1e..d92730d8c342 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -7165,7 +7165,7 @@ static ssize_t do_rbd_add(const char *buf, size_t count)
 
 	rc = device_add_disk(&rbd_dev->dev, rbd_dev->disk, NULL);
 	if (rc)
-		goto err_out_cleanup_disk;
+		goto err_out_device_del;
 
 	spin_lock(&rbd_dev_list_lock);
 	list_add_tail(&rbd_dev->node, &rbd_dev_list);
@@ -7179,8 +7179,8 @@ static ssize_t do_rbd_add(const char *buf, size_t count)
 	module_put(THIS_MODULE);
 	return rc;
 
-err_out_cleanup_disk:
-	rbd_free_disk(rbd_dev);
+err_out_device_del:
+	device_del(&rbd_dev->dev);
 err_out_image_lock:
 	rbd_dev_image_unlock(rbd_dev);
 	rbd_dev_device_release(rbd_dev);
-- 
2.34.1

