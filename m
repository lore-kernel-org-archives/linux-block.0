Return-Path: <baijiaju1990@gmail.com>
Return-Path: <baijiaju1990@gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] block: ioprio: Replace GFP_ATOMIC with GFP_KERNEL in set_task_ioprio()
Date: Mon, 23 Jul 2018 10:21:16 +0800
Message-Id: <20180723022116.6919-1-baijiaju1990@gmail.com>
List-ID: <linux-block@vger.kernel.org>

set_task_ioprio() is only called by SYSCALL_DEFINE3(), ext4_fill_super(),
ext4_remount() and reada_start_machine_worker().
And these functions are not called in atomic context.

set_task_ioprio() calls get_task_io_context with GFP_ATOMIC, which is
unnecessary. GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 block/ioprio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 6f5d0b6625e3..42d91ee7080f 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -51,7 +51,7 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
 	if (err)
 		return err;
 
-	ioc = get_task_io_context(task, GFP_ATOMIC, NUMA_NO_NODE);
+	ioc = get_task_io_context(task, GFP_KERNEL, NUMA_NO_NODE);
 	if (ioc) {
 		ioc->ioprio = ioprio;
 		put_io_context(ioc);
-- 
2.17.0
