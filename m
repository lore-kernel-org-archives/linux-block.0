Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A20C32751
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 05:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5499A20657
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 05:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725209AbfGaF4m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 01:56:42 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:58350 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfGaF4m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 01:56:42 -0400
X-QQ-mid: bizesmtp24t1564552590t6zlbhv3
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Wed, 31 Jul 2019 13:56:29 +0800 (CST)
X-QQ-SSF: 01400000002000Q0WQ80000A0000000
X-QQ-FEAT: nEzlC54BmSuJ+ltvy70guJbwe5auh0Bun7Q1XO+HcdFR+9rFn61cJyQb8OvrQ
        sfY+ogYTe4opeiMZeUnn3Ft2nnef8z8ZYK9B+6wAzL7wVJ2dACTWm4lJQG+nULt/YNLKbT4
        njUDEe/f5ndYPUd71PC1uHeES+iHr0UgiM7dYLTsFJ8//w4RHsFzVwQmRgYYNQkw7Y983Jh
        s6VfAnSA+gvwReCS9t04/U2U9SmPk0ezSd+1YUx8qVGdS/nFThn2D8IYzOEu7/k54I9vjAr
        zW/ddwuiF6++fprp/Q92J30m2jmJG5DFExKb9v0V0MPdNQotbci9vwdkJCgyOhIpOqQyPa4
        oOMObifoIKhpfYX+2Ev9I+R71ixhA==
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Subject: [PATCH] io_uring: fix KASAN use after free in io_sq_wq_submit_work
Date:   Wed, 31 Jul 2019 13:56:20 +0800
Message-Id: <1564552580-10287-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[root@localhost ~]# ./liburing/test/link

QEMU Standard PC report that:

[   29.379892] CPU: 0 PID: 84 Comm: kworker/u2:2 Not tainted 5.3.0-rc2-00051-g4010b622f1d2-dirty #86
[   29.379902] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   29.379913] Workqueue: io_ring-wq io_sq_wq_submit_work
[   29.379929] Call Trace:
[   29.379953]  dump_stack+0xa9/0x10e
[   29.379970]  ? io_sq_wq_submit_work+0xbf4/0xe90
[   29.379986]  print_address_description.cold.6+0x9/0x317
[   29.379999]  ? io_sq_wq_submit_work+0xbf4/0xe90
[   29.380010]  ? io_sq_wq_submit_work+0xbf4/0xe90
[   29.380026]  __kasan_report.cold.7+0x1a/0x34
[   29.380044]  ? io_sq_wq_submit_work+0xbf4/0xe90
[   29.380061]  kasan_report+0xe/0x12
[   29.380076]  io_sq_wq_submit_work+0xbf4/0xe90
[   29.380104]  ? io_sq_thread+0xaf0/0xaf0
[   29.380152]  process_one_work+0xb59/0x19e0
[   29.380184]  ? pwq_dec_nr_in_flight+0x2c0/0x2c0
[   29.380221]  worker_thread+0x8c/0xf40
[   29.380248]  ? __kthread_parkme+0xab/0x110
[   29.380265]  ? process_one_work+0x19e0/0x19e0
[   29.380278]  kthread+0x30b/0x3d0
[   29.380292]  ? kthread_create_on_node+0xe0/0xe0
[   29.380311]  ret_from_fork+0x3a/0x50

[   29.380635] Allocated by task 209:
[   29.381255]  save_stack+0x19/0x80
[   29.381268]  __kasan_kmalloc.constprop.6+0xc1/0xd0
[   29.381279]  kmem_cache_alloc+0xc0/0x240
[   29.381289]  io_submit_sqe+0x11bc/0x1c70
[   29.381300]  io_ring_submit+0x174/0x3c0
[   29.381311]  __x64_sys_io_uring_enter+0x601/0x780
[   29.381322]  do_syscall_64+0x9f/0x4d0
[   29.381336]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[   29.381633] Freed by task 84:
[   29.382186]  save_stack+0x19/0x80
[   29.382198]  __kasan_slab_free+0x11d/0x160
[   29.382210]  kmem_cache_free+0x8c/0x2f0
[   29.382220]  io_put_req+0x22/0x30
[   29.382230]  io_sq_wq_submit_work+0x28b/0xe90
[   29.382241]  process_one_work+0xb59/0x19e0
[   29.382251]  worker_thread+0x8c/0xf40
[   29.382262]  kthread+0x30b/0x3d0
[   29.382272]  ret_from_fork+0x3a/0x50

[   29.382569] The buggy address belongs to the object at ffff888067172140
                which belongs to the cache io_kiocb of size 224
[   29.384692] The buggy address is located 120 bytes inside of
                224-byte region [ffff888067172140, ffff888067172220)
[   29.386723] The buggy address belongs to the page:
[   29.387575] page:ffffea00019c5c80 refcount:1 mapcount:0 mapping:ffff88806ace5180 index:0x0
[   29.387587] flags: 0x100000000000200(slab)
[   29.387603] raw: 0100000000000200 dead000000000100 dead000000000122 ffff88806ace5180
[   29.387617] raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
[   29.387624] page dumped because: kasan: bad access detected

[   29.387920] Memory state around the buggy address:
[   29.388771]  ffff888067172080: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[   29.390062]  ffff888067172100: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
[   29.391325] >ffff888067172180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   29.392578]                                         ^
[   29.393480]  ffff888067172200: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
[   29.394744]  ffff888067172280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   29.396003] ==================================================================
[   29.397260] Disabling lock debugging due to kernel taint

io_sq_wq_submit_work free and read req again.

Cc: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc: linux-block@vger.kernel.org
Fixes: f7b76ac9d17e ("io_uring: fix counter inc/dec mismatch in async_list")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 012bc0efb9d3..7e775ee702f6 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1832,6 +1832,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 	LIST_HEAD(req_list);
 	mm_segment_t old_fs;
 	int ret;
+	bool finish = false;
 
 	async_list = io_async_list_from_sqe(ctx, req->submit.sqe);
 restart:
@@ -1871,6 +1872,10 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 			} while (1);
 		}
 
+		/* req from defer and link list needn't decrease async cnt */
+		if (req->flags & (REQ_F_IO_DRAINED | REQ_F_LINK_DONE))
+			finish = true;
+
 		/* drop submission reference */
 		io_put_req(req);
 
@@ -1882,8 +1887,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 		/* async context always use a copy of the sqe */
 		kfree(sqe);
 
-		/* req from defer and link list needn't decrease async cnt */
-		if (req->flags & (REQ_F_IO_DRAINED | REQ_F_LINK_DONE))
+		if (finish)
 			goto out;
 
 		if (!async_list)
-- 
2.20.1



