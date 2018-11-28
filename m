Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD73C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 08:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5FA2081C
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 08:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5FA2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeK1TkA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:40:00 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55887 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbeK1Tj7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 14:39:59 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 23EA7C1BF9B83;
        Wed, 28 Nov 2018 16:39:07 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 28 Nov 2018
 16:39:03 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <tj@kernel.org>,
        <paulmck@linux.vnet.ibm.com>, <ming.lei@redhat.com>
Subject: [PATCH] block: use rcu_work instead of call_rcu to avoid sleep in softirq
Date:   Wed, 28 Nov 2018 16:42:01 +0800
Message-ID: <20181128084201.69211-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We recently got a stack by syzkaller like this:

BUG: sleeping function called from invalid context at mm/slab.h:361
in_atomic(): 1, irqs_disabled(): 0, pid: 6644, name: blkid
INFO: lockdep is turned off.
CPU: 1 PID: 6644 Comm: blkid Not tainted 4.4.163-514.55.6.9.x86_64+ #76
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
 0000000000000000 5ba6a6b879e50c00 ffff8801f6b07b10 ffffffff81cb2194
 0000000041b58ab3 ffffffff833c7745 ffffffff81cb2080 5ba6a6b879e50c00
 0000000000000000 0000000000000001 0000000000000004 0000000000000000
Call Trace:
 <IRQ>  [<ffffffff81cb2194>] __dump_stack lib/dump_stack.c:15 [inline]
 <IRQ>  [<ffffffff81cb2194>] dump_stack+0x114/0x1a0 lib/dump_stack.c:51
 [<ffffffff8129a981>] ___might_sleep+0x291/0x490 kernel/sched/core.c:7675
 [<ffffffff8129ac33>] __might_sleep+0xb3/0x270 kernel/sched/core.c:7637
 [<ffffffff81794c13>] slab_pre_alloc_hook mm/slab.h:361 [inline]
 [<ffffffff81794c13>] slab_alloc_node mm/slub.c:2610 [inline]
 [<ffffffff81794c13>] slab_alloc mm/slub.c:2692 [inline]
 [<ffffffff81794c13>] kmem_cache_alloc_trace+0x2c3/0x5c0 mm/slub.c:2709
 [<ffffffff81cbe9a7>] kmalloc include/linux/slab.h:479 [inline]
 [<ffffffff81cbe9a7>] kzalloc include/linux/slab.h:623 [inline]
 [<ffffffff81cbe9a7>] kobject_uevent_env+0x2c7/0x1150 lib/kobject_uevent.c:227
 [<ffffffff81cbf84f>] kobject_uevent+0x1f/0x30 lib/kobject_uevent.c:374
 [<ffffffff81cbb5b9>] kobject_cleanup lib/kobject.c:633 [inline]
 [<ffffffff81cbb5b9>] kobject_release+0x229/0x440 lib/kobject.c:675
 [<ffffffff81cbb0a2>] kref_sub include/linux/kref.h:73 [inline]
 [<ffffffff81cbb0a2>] kref_put include/linux/kref.h:98 [inline]
 [<ffffffff81cbb0a2>] kobject_put+0x72/0xd0 lib/kobject.c:692
 [<ffffffff8216f095>] put_device+0x25/0x30 drivers/base/core.c:1237
 [<ffffffff81c4cc34>] delete_partition_rcu_cb+0x1d4/0x2f0 block/partition-generic.c:232
 [<ffffffff813c08bc>] __rcu_reclaim kernel/rcu/rcu.h:118 [inline]
 [<ffffffff813c08bc>] rcu_do_batch kernel/rcu/tree.c:2705 [inline]
 [<ffffffff813c08bc>] invoke_rcu_callbacks kernel/rcu/tree.c:2973 [inline]
 [<ffffffff813c08bc>] __rcu_process_callbacks kernel/rcu/tree.c:2940 [inline]
 [<ffffffff813c08bc>] rcu_process_callbacks+0x59c/0x1c70 kernel/rcu/tree.c:2957
 [<ffffffff8120f509>] __do_softirq+0x299/0xe20 kernel/softirq.c:273
 [<ffffffff81210496>] invoke_softirq kernel/softirq.c:350 [inline]
 [<ffffffff81210496>] irq_exit+0x216/0x2c0 kernel/softirq.c:391
 [<ffffffff82c2cd7b>] exiting_irq arch/x86/include/asm/apic.h:652 [inline]
 [<ffffffff82c2cd7b>] smp_apic_timer_interrupt+0x8b/0xc0 arch/x86/kernel/apic/apic.c:926
 [<ffffffff82c2bc25>] apic_timer_interrupt+0xa5/0xb0 arch/x86/entry/entry_64.S:746
 <EOI>  [<ffffffff814cbf40>] ? audit_kill_trees+0x180/0x180
 [<ffffffff8187d2f7>] fd_install+0x57/0x80 fs/file.c:626
 [<ffffffff8180989e>] do_sys_open+0x45e/0x550 fs/open.c:1043
 [<ffffffff818099c2>] SYSC_open fs/open.c:1055 [inline]
 [<ffffffff818099c2>] SyS_open+0x32/0x40 fs/open.c:1050
 [<ffffffff82c299e1>] entry_SYSCALL_64_fastpath+0x1e/0x9a

In softirq context, we call rcu callback function delete_partition_rcu_cb(),
which may allocate memory by kzalloc with GFP_KERNEL flag. If the
allocation cannot be satisfied, it may sleep. However, That is not allowed
in softirq contex.

Although we found this problem on linux 4.4, the latest kernel version
seems to have this problem as well. And it is very similar to the
previous one:
	https://lkml.org/lkml/2018/7/9/391

Fix it by using RCU workqueue, which allows sleep.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/partition-generic.c | 8 +++++---
 include/linux/genhd.h     | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index d3d14e81fb12..5f8db5c5140f 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -249,9 +249,10 @@ struct device_type part_type = {
 	.uevent		= part_uevent,
 };
 
-static void delete_partition_rcu_cb(struct rcu_head *head)
+static void delete_partition_work_fn(struct work_struct *work)
 {
-	struct hd_struct *part = container_of(head, struct hd_struct, rcu_head);
+	struct hd_struct *part = container_of(to_rcu_work(work), struct hd_struct,
+					rcu_work);
 
 	part->start_sect = 0;
 	part->nr_sects = 0;
@@ -262,7 +263,8 @@ static void delete_partition_rcu_cb(struct rcu_head *head)
 void __delete_partition(struct percpu_ref *ref)
 {
 	struct hd_struct *part = container_of(ref, struct hd_struct, ref);
-	call_rcu(&part->rcu_head, delete_partition_rcu_cb);
+	INIT_RCU_WORK(&part->rcu_work, delete_partition_work_fn);
+	queue_rcu_work(system_wq, &part->rcu_work);
 }
 
 /*
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 70fc838e6773..0c5ee17b4d88 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -129,7 +129,7 @@ struct hd_struct {
 	struct disk_stats dkstats;
 #endif
 	struct percpu_ref ref;
-	struct rcu_head rcu_head;
+	struct rcu_work rcu_work;
 };
 
 #define GENHD_FL_REMOVABLE			1
-- 
2.16.2.dirty

