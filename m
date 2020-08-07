Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46B4C433E0
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 09:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F2F22CAE
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 09:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgHGJGb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:06:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726655AbgHGJGa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Aug 2020 05:06:30 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 014544670811174E059E;
        Fri,  7 Aug 2020 17:06:29 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Fri, 7 Aug 2020
 17:06:21 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <lengchao@huawei.com>
Subject: [PATCH v2 1/3] rcu: introduce async mechanism for sync SRCU
Date:   Fri, 7 Aug 2020 17:06:21 +0800
Message-ID: <20200807090621.29639-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In some scenarios we need sync lots of SRCUs together, if sync one by
one, may need long time.
Introduce async mechanism for sync SRCU: sync SRCUs together but no wait,
and then wait until all SRCUs read-side critical-section complete.
Thus reduce serial wait time.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 include/linux/rcupdate_wait.h |  6 ++++++
 include/linux/srcu.h          |  1 +
 include/linux/srcutiny.h      |  2 ++
 include/linux/srcutree.h      |  2 ++
 kernel/rcu/srcutiny.c         | 15 +++++++++++++++
 kernel/rcu/srcutree.c         | 26 ++++++++++++++++++++++++++
 kernel/rcu/update.c           | 11 +++++++++++
 7 files changed, 63 insertions(+)

diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index 699b938358bf..c8af1b8916f5 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -16,7 +16,13 @@ struct rcu_synchronize {
 	struct rcu_head head;
 	struct completion completion;
 };
+struct rcu_synchronize_async {
+	struct rcu_head head;
+	atomic_t *count;
+};
+
 void wakeme_after_rcu(struct rcu_head *head);
+void wakeme_after_rcu_async(struct rcu_head *head);
 
 void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 		   struct rcu_synchronize *rs_array);
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index e432cc92c73d..f657ce9f73b0 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -60,6 +60,7 @@ void cleanup_srcu_struct(struct srcu_struct *ssp);
 int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
 void synchronize_srcu(struct srcu_struct *ssp);
+void synchronize_srcu_async(struct srcu_struct *ssp, atomic_t *count);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 5a5a1941ca15..54b257bc0ee5 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -11,6 +11,7 @@
 #ifndef _LINUX_SRCU_TINY_H
 #define _LINUX_SRCU_TINY_H
 
+#include <linux/rcupdate_wait.h>
 #include <linux/swait.h>
 
 struct srcu_struct {
@@ -23,6 +24,7 @@ struct srcu_struct {
 	struct rcu_head *srcu_cb_head;	/* Pending callbacks: Head. */
 	struct rcu_head **srcu_cb_tail;	/* Pending callbacks: Tail. */
 	struct work_struct srcu_work;	/* For driving grace periods. */
+	struct rcu_synchronize_async srcu_async;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 9cfcc8a756ae..81ec38002e49 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -11,6 +11,7 @@
 #ifndef _LINUX_SRCU_TREE_H
 #define _LINUX_SRCU_TREE_H
 
+#include <linux/rcupdate_wait.h>
 #include <linux/rcu_node_tree.h>
 #include <linux/completion.h>
 
@@ -82,6 +83,7 @@ struct srcu_struct {
 						/*  callback for the barrier */
 						/*  operation. */
 	struct delayed_work work;
+	struct rcu_synchronize_async srcu_async;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 6208c1dae5c9..96bea76b78b8 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -190,6 +190,21 @@ void synchronize_srcu(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(synchronize_srcu);
 
+/*
+ * synchronize_srcu_async - do not wait until prior SRCU read-side
+ * critical-section completion, used for sync lots of SRCUs together
+ * to reduce wait time.
+ * Caution: do not support concurrent.
+ */
+void synchronize_srcu_async(struct srcu_struct *ssp, atomic_t *count)
+{
+	init_rcu_head(&ssp->srcu_async.head);
+	atomic_inc(count);
+	ssp->srcu_async.count = count;
+	call_srcu(ssp, &ssp->srcu_async.head, wakeme_after_rcu_async);
+}
+EXPORT_SYMBOL_GPL(synchronize_srcu_async);
+
 /* Lockdep diagnostics.  */
 void __init rcu_scheduler_starting(void)
 {
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6d3ef700fb0e..b4045cc0d7f2 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1014,6 +1014,32 @@ void synchronize_srcu(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(synchronize_srcu);
 
+/*
+ * synchronize_srcu_async - do not wait until prior SRCU read-side
+ * critical-section completion, used for sync lots of SRCUs together
+ * to reduce wait time.
+ * Caution: do not support concurrent.
+ */
+void synchronize_srcu_async(struct srcu_struct *ssp, atomic_t *count)
+{
+	RCU_LOCKDEP_WARN(lock_is_held(&ssp->dep_map) ||
+		lock_is_held(&rcu_bh_lock_map) ||
+		lock_is_held(&rcu_lock_map) ||
+		lock_is_held(&rcu_sched_lock_map),
+		"Illegal synchronize_srcu() in same-type SRCU (or in RCU) read-side critical section");
+	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
+		return;
+
+	might_sleep();
+	check_init_srcu_struct(ssp);
+	init_rcu_head(&ssp->srcu_async.head);
+
+	atomic_inc(count);
+	ssp->srcu_async.count = count;
+	call_srcu(ssp, &ssp->srcu_async.head, wakeme_after_rcu_async);
+}
+EXPORT_SYMBOL_GPL(synchronize_srcu_async);
+
 /*
  * Callback function for srcu_barrier() use.
  */
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 84843adfd939..6433ae9c54cf 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -377,6 +377,17 @@ void wakeme_after_rcu(struct rcu_head *head)
 }
 EXPORT_SYMBOL_GPL(wakeme_after_rcu);
 
+void wakeme_after_rcu_async(struct rcu_head *head)
+{
+	struct rcu_synchronize_async *rcu_asnc;
+
+	rcu_asnc = container_of(head, struct rcu_synchronize_async, head);
+
+	atomic_dec(rcu_asnc->count);
+	destroy_rcu_head_on_stack(&rcu_asnc->head);
+}
+EXPORT_SYMBOL_GPL(wakeme_after_rcu_async);
+
 void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 		   struct rcu_synchronize *rs_array)
 {
-- 
2.16.4

