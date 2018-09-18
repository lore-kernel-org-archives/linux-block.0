Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729233AbeIRPpV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Sep 2018 11:45:21 -0400
From: Ming Lei <ming.lei@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>, Tejun Heo <tj@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 1/3] lib/percpu-refcount: introduce percpu_ref_resurge()
Date: Tue, 18 Sep 2018 18:13:08 +0800
Message-Id: <20180918101310.13154-2-ming.lei@redhat.com>
In-Reply-To: <20180918101310.13154-1-ming.lei@redhat.com>
References: <20180918101310.13154-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Now percpu_ref_reinit() can only be done on one percpu refcounter when it
drops zero. And the limit shouldn't be so strict, and it is quite
straightforward that we can do it when the refcount doesn't drop zero
because it is at atomic mode.

This patch introduces percpu_ref_resurge() in which the above limit is
relaxed, so we may avoid extra change[1] for NVMe timeout's requirement.

[1] https://marc.info/?l=linux-kernel&m=153612052611020&w=2

Cc: Tejun Heo <tj@kernel.org>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/percpu-refcount.h |  1 +
 lib/percpu-refcount.c           | 63 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 009cdf3d65b6..641841e26256 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -109,6 +109,7 @@ void percpu_ref_switch_to_percpu(struct percpu_ref *ref);
 void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 				 percpu_ref_func_t *confirm_kill);
 void percpu_ref_reinit(struct percpu_ref *ref);
+void percpu_ref_resurge(struct percpu_ref *ref);
 
 /**
  * percpu_ref_kill - drop the initial ref
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index a220b717f6bb..3e385a1401af 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -341,6 +341,42 @@ void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 }
 EXPORT_SYMBOL_GPL(percpu_ref_kill_and_confirm);
 
+/*
+ * If @need_drop_zero isn't set, clear the DEAD & ATOMIC flag and reinit
+ * the ref without checking if its ref value drops zero.
+ */
+static void __percpu_ref_reinit(struct percpu_ref *ref, bool need_drop_zero)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
+
+	if (need_drop_zero) {
+		WARN_ON_ONCE(!percpu_ref_is_zero(ref));
+	} else {
+		unsigned long __percpu *percpu_count;
+
+		WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
+
+		/* get one extra ref for avoiding race with .release */
+		rcu_read_lock_sched();
+		atomic_long_add(1, &ref->count);
+		rcu_read_unlock_sched();
+	}
+
+	ref->percpu_count_ptr &= ~__PERCPU_REF_DEAD;
+	percpu_ref_get(ref);
+	__percpu_ref_switch_mode(ref, NULL);
+
+	if (!need_drop_zero) {
+		rcu_read_lock_sched();
+		atomic_long_sub(1, &ref->count);
+		rcu_read_unlock_sched();
+	}
+
+	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+}
+
 /**
  * percpu_ref_reinit - re-initialize a percpu refcount
  * @ref: perpcu_ref to re-initialize
@@ -354,16 +390,21 @@ EXPORT_SYMBOL_GPL(percpu_ref_kill_and_confirm);
  */
 void percpu_ref_reinit(struct percpu_ref *ref)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
-
-	WARN_ON_ONCE(!percpu_ref_is_zero(ref));
-
-	ref->percpu_count_ptr &= ~__PERCPU_REF_DEAD;
-	percpu_ref_get(ref);
-	__percpu_ref_switch_mode(ref, NULL);
-
-	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+	__percpu_ref_reinit(ref, true);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_reinit);
+
+/**
+ * percpu_ref_resurge - resurge a percpu refcount
+ * @ref: perpcu_ref to resurge
+ *
+ * Resurge @ref so that it's in the same state as before it is killed.
+ *
+ * Note that percpu_ref_tryget[_live]() are safe to perform on @ref while
+ * this function is in progress.
+ */
+void percpu_ref_resurge(struct percpu_ref *ref)
+{
+	__percpu_ref_reinit(ref, false);
+}
+EXPORT_SYMBOL_GPL(percpu_ref_resurge);
-- 
2.9.5
