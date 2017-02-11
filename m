Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33226 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbdBKDkz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Feb 2017 22:40:55 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ming Lei <tom.leiming@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] block/loop: fix race between I/O and set_status
Date: Sat, 11 Feb 2017 11:40:45 +0800
Message-Id: <1486784445-25300-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Inside set_status, transfer need to setup again, so
we have to drain IO before the transition, otherwise
oops may be triggered like the following:

	divide error: 0000 [#1] SMP KASAN
	CPU: 0 PID: 2935 Comm: loop7 Not tainted 4.10.0-rc7+ #213
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs
	01/01/2011
	task: ffff88006ba1e840 task.stack: ffff880067338000
	RIP: 0010:transfer_xor+0x1d1/0x440 drivers/block/loop.c:110
	RSP: 0018:ffff88006733f108 EFLAGS: 00010246
	RAX: 0000000000000000 RBX: ffff8800688d7000 RCX: 0000000000000059
	RDX: 0000000000000000 RSI: 1ffff1000d743f43 RDI: ffff880068891c08
	RBP: ffff88006733f160 R08: ffff8800688d7001 R09: 0000000000000000
	R10: 0000000000000000 R11: 0000000000000000 R12: ffff8800688d7000
	R13: ffff880067b7d000 R14: dffffc0000000000 R15: 0000000000000000
	FS:  0000000000000000(0000) GS:ffff88006d000000(0000)
	knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 00000000006c17e0 CR3: 0000000066e3b000 CR4: 00000000001406f0
	Call Trace:
	 lo_do_transfer drivers/block/loop.c:251 [inline]
	 lo_read_transfer drivers/block/loop.c:392 [inline]
	 do_req_filebacked drivers/block/loop.c:541 [inline]
	 loop_handle_cmd drivers/block/loop.c:1677 [inline]
	 loop_queue_work+0xda0/0x49b0 drivers/block/loop.c:1689
	 kthread_worker_fn+0x4c3/0xa30 kernel/kthread.c:630
	 kthread+0x326/0x3f0 kernel/kthread.c:227
	 ret_from_fork+0x31/0x40 arch/x86/entry/entry_64.S:430
	Code: 03 83 e2 07 41 29 df 42 0f b6 04 30 4d 8d 44 24 01 38 d0 7f 08
	84 c0 0f 85 62 02 00 00 44 89 f8 41 0f b6 48 ff 25 ff 01 00 00 99 <f7>
	7d c8 48 63 d2 48 03 55 d0 48 89 d0 48 89 d7 48 c1 e8 03 83
	RIP: transfer_xor+0x1d1/0x440 drivers/block/loop.c:110 RSP:
	ffff88006733f108
	---[ end trace 0166f7bd3b0c0933 ]---

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/loop.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ed5259510857..4b52a1690329 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1097,9 +1097,12 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
 		return -EINVAL;
 
+	/* I/O need to be drained during transfer transition */
+	blk_mq_freeze_queue(lo->lo_queue);
+
 	err = loop_release_xfer(lo);
 	if (err)
-		return err;
+		goto exit;
 
 	if (info->lo_encrypt_type) {
 		unsigned int type = info->lo_encrypt_type;
@@ -1114,12 +1117,14 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 
 	err = loop_init_xfer(lo, xfer, info);
 	if (err)
-		return err;
+		goto exit;
 
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit)
-		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit))
-			return -EFBIG;
+		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
+			err = -EFBIG;
+			goto exit;
+		}
 
 	loop_config_discard(lo);
 
@@ -1156,7 +1161,9 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	/* update dio if lo_offset or transfer is changed */
 	__loop_update_dio(lo, lo->use_dio);
 
-	return 0;
+ exit:
+	blk_mq_unfreeze_queue(lo->lo_queue);
+	return err;
 }
 
 static int
-- 
2.7.4
