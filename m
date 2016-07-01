Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36767 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbcGAHju (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Fri, 1 Jul 2016 03:39:50 -0400
Received: by mail-pf0-f180.google.com with SMTP id t190so37938750pfb.3
        for <linux-block@vger.kernel.org>; Fri, 01 Jul 2016 00:39:50 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, linux-block@vger.kernel.org,
	kernel-team@fb.com, stable@vger.kernel.org
Subject: [PATCH] block: fix use-after-free in sys_ioprio_get()
Date: Fri,  1 Jul 2016 00:39:35 -0700
Message-Id: <fa9c9a3ee7355f932d4f40322602aae5fb293f97.1467358615.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

get_task_ioprio() accesses the task->io_context without holding the task
lock and thus can race with exit_io_context(), leading to a
use-after-free. The reproducer below hits this within a few seconds on
my 4-core QEMU VM:

#define _GNU_SOURCE
#include <assert.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/wait.h>

int main(int argc, char **argv)
{
	pid_t pid, child;
	long nproc, i;

	/* ioprio_set(IOPRIO_WHO_PROCESS, 0, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0)); */
	syscall(SYS_ioprio_set, 1, 0, 0x6000);

	nproc = sysconf(_SC_NPROCESSORS_ONLN);

	for (i = 0; i < nproc; i++) {
		pid = fork();
		assert(pid != -1);
		if (pid == 0) {
			for (;;) {
				pid = fork();
				assert(pid != -1);
				if (pid == 0) {
					_exit(0);
				} else {
					child = wait(NULL);
					assert(child == pid);
				}
			}
		}

		pid = fork();
		assert(pid != -1);
		if (pid == 0) {
			for (;;) {
				/* ioprio_get(IOPRIO_WHO_PGRP, 0); */
				syscall(SYS_ioprio_get, 2, 0);
			}
		}
	}

	for (;;) {
		/* ioprio_get(IOPRIO_WHO_PGRP, 0); */
		syscall(SYS_ioprio_get, 2, 0);
	}

	return 0;
}

This gets us KASAN dumps like this:

[   35.526914] ==================================================================
[   35.530009] BUG: KASAN: out-of-bounds in get_task_ioprio+0x7b/0x90 at addr ffff880066f34e6c
[   35.530009] Read of size 2 by task ioprio-gpf/363
[   35.530009] =============================================================================
[   35.530009] BUG blkdev_ioc (Not tainted): kasan: bad access detected
[   35.530009] -----------------------------------------------------------------------------

[   35.530009] Disabling lock debugging due to kernel taint
[   35.530009] INFO: Allocated in create_task_io_context+0x2b/0x370 age=0 cpu=0 pid=360
[   35.530009] 	___slab_alloc+0x55d/0x5a0
[   35.530009] 	__slab_alloc.isra.20+0x2b/0x40
[   35.530009] 	kmem_cache_alloc_node+0x84/0x200
[   35.530009] 	create_task_io_context+0x2b/0x370
[   35.530009] 	get_task_io_context+0x92/0xb0
[   35.530009] 	copy_process.part.8+0x5029/0x5660
[   35.530009] 	_do_fork+0x155/0x7e0
[   35.530009] 	SyS_clone+0x19/0x20
[   35.530009] 	do_syscall_64+0x195/0x3a0
[   35.530009] 	return_from_SYSCALL_64+0x0/0x6a
[   35.530009] INFO: Freed in put_io_context+0xe7/0x120 age=0 cpu=0 pid=1060
[   35.530009] 	__slab_free+0x27b/0x3d0
[   35.530009] 	kmem_cache_free+0x1fb/0x220
[   35.530009] 	put_io_context+0xe7/0x120
[   35.530009] 	put_io_context_active+0x238/0x380
[   35.530009] 	exit_io_context+0x66/0x80
[   35.530009] 	do_exit+0x158e/0x2b90
[   35.530009] 	do_group_exit+0xe5/0x2b0
[   35.530009] 	SyS_exit_group+0x1d/0x20
[   35.530009] 	entry_SYSCALL_64_fastpath+0x1a/0xa4
[   35.530009] INFO: Slab 0xffffea00019bcd00 objects=20 used=4 fp=0xffff880066f34ff0 flags=0x1fffe0000004080
[   35.530009] INFO: Object 0xffff880066f34e58 @offset=3672 fp=0x0000000000000001
[   35.530009] ==================================================================

Fix it by grabbing the task lock while we poke at the io_context.

Cc: stable@vger.kernel.org
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Applies to v4.7-rc5.

 block/ioprio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/ioprio.c b/block/ioprio.c
index cc7800e9eb44..01b8116298a1 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -150,8 +150,10 @@ static int get_task_ioprio(struct task_struct *p)
 	if (ret)
 		goto out;
 	ret = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, IOPRIO_NORM);
+	task_lock(p);
 	if (p->io_context)
 		ret = p->io_context->ioprio;
+	task_unlock(p);
 out:
 	return ret;
 }
-- 
2.9.0

