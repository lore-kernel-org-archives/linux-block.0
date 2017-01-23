Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38406 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdAWOHO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 09:07:14 -0500
Received: by mail-wm0-f46.google.com with SMTP id r144so156981327wme.1
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2017 06:07:14 -0800 (PST)
From: Alexander Potapenko <glider@google.com>
To: dvyukov@google.com, kcc@google.com, axboe@fb.com, tahsin@google.com
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] block: Initialize cfqq->ioprio_class in cfq_get_queue()
Date: Mon, 23 Jan 2017 15:06:43 +0100
Message-Id: <20170123140643.32805-1-glider@google.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

KMSAN (KernelMemorySanitizer, a new error detection tool) reports use of
uninitialized memory in cfq_init_cfqq():

==================================================================
BUG: KMSAN: use of unitialized memory
...
Call Trace:
 [<     inline     >] __dump_stack lib/dump_stack.c:15
 [<ffffffff8202ac97>] dump_stack+0x157/0x1d0 lib/dump_stack.c:51
 [<ffffffff813e9b65>] kmsan_report+0x205/0x360 ??:?
 [<ffffffff813eabbb>] __msan_warning+0x5b/0xb0 ??:?
 [<     inline     >] cfq_init_cfqq block/cfq-iosched.c:3754
 [<ffffffff8201e110>] cfq_get_queue+0xc80/0x14d0 block/cfq-iosched.c:3857
...
origin:
 [<ffffffff8103ab37>] save_stack_trace+0x27/0x50 arch/x86/kernel/stacktrace.c:67
 [<ffffffff813e836b>] kmsan_internal_poison_shadow+0xab/0x150 ??:?
 [<ffffffff813e88ab>] kmsan_poison_slab+0xbb/0x120 ??:?
 [<     inline     >] allocate_slab mm/slub.c:1627
 [<ffffffff813e533f>] new_slab+0x3af/0x4b0 mm/slub.c:1641
 [<     inline     >] new_slab_objects mm/slub.c:2407
 [<ffffffff813e0ef3>] ___slab_alloc+0x323/0x4a0 mm/slub.c:2564
 [<     inline     >] __slab_alloc mm/slub.c:2606
 [<     inline     >] slab_alloc_node mm/slub.c:2669
 [<ffffffff813dfb42>] kmem_cache_alloc_node+0x1d2/0x1f0 mm/slub.c:2746
 [<ffffffff8201d90d>] cfq_get_queue+0x47d/0x14d0 block/cfq-iosched.c:3850
...
==================================================================
(the line numbers are relative to 4.8-rc6, but the bug persists
upstream)

The uninitialized struct cfq_queue is created by kmem_cache_alloc_node()
and then passed to cfq_init_cfqq(), which accesses cfqq->ioprio_class
before it's initialized.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 block/cfq-iosched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index c73a6fcaeb9d..611061ae470a 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -3864,6 +3864,8 @@ cfq_get_queue(struct cfq_data *cfqd, bool is_sync, struct cfq_io_cq *cic,
 		goto out;
 	}
 
+	/* cfq_init_cfqq() assumes cfqq->ioprio_class is initialized. */
+	cfqq->ioprio_class = IOPRIO_CLASS_NONE;
 	cfq_init_cfqq(cfqd, cfqq, current->pid, is_sync);
 	cfq_init_prio_data(cfqq, cic);
 	cfq_link_cfqq_cfqg(cfqq, cfqg);
-- 
2.11.0.483.g087da7b7c-goog

