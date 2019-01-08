Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC026C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 19:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90026206BB
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 19:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977270;
	bh=U4OoqIiJ4QuP7dXlysjRbWTqkuQ7rETP9U1UxyBPDj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W+yetGtuaadjey7uyTd5X4+FyJRcQ1eKulm7wmICG6OPC9MMz9vOTCp9nPa8ZSFUz
	 kH0cpomTrmaDF50kQ654RJYt8lacSq4YqHsDh/VPhidrdScj9oatLqaG5c18Rlw34M
	 0tBTrfRzx1HVOax1EzRWyPnV4iUfM36TGIEsynNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfAHTam (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:30:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:38316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730792AbfAHTad (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jan 2019 14:30:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4183F20665;
        Tue,  8 Jan 2019 19:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975831;
        bh=U4OoqIiJ4QuP7dXlysjRbWTqkuQ7rETP9U1UxyBPDj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A6nOfR6AWhzxEgs3IOONbFWPNJpLyyqf2eC8NmPJgoyNpIT2taA192NIQUPKIzDNO
         1Bx7vgVVnHQaiDZ/ynhpmcryy4uW5Bu84bYTnXUol4C2nLdA2zXBb+g1cpaXKDWh9G
         gAYCiPSqD5N3+6kdZ1YB9Dp9V52K2rUpSSUQlclY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yufen Yu <yuyufen@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 27/97] block: use rcu_work instead of call_rcu to avoid sleep in softirq
Date:   Tue,  8 Jan 2019 14:28:36 -0500
Message-Id: <20190108192949.122407-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yufen Yu <yuyufen@huawei.com>

[ Upstream commit 94a2c3a32b62e868dc1e3d854326745a7f1b8c7a ]

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

Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index 25c08c6c7f99..f767293b00e6 100644
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
2.19.1

