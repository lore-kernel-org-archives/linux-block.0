Return-Path: <SRS0=nGx8=CR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D0CC43461
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 01:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB0621941
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 01:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLC0EsI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgIHBYZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Sep 2020 21:24:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54588 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728185AbgIHBYX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Sep 2020 21:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599528261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GjJ7/ESKg63Kf1G7EBO2ioM63fi6tOzgFHp2+4FCOOA=;
        b=GLC0EsI52yyyrTRidm7Di42YTYcE5zj9IfkGqxRVgR6gABEKzeKvRSSpeCbGXf11vnZbsh
        XlW5I8gDDiosu4x3R/7EfmCkGzDV49ux0M95F4+IKdHACzu+Z5waZq30zQw12NW/SV7rQ0
        PX1M/ub8xZmYomhHKjRzrIp0GYbKJgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-kkOSjvw5O0m8CbJvT3MXZg-1; Mon, 07 Sep 2020 21:24:18 -0400
X-MC-Unique: kkOSjvw5O0m8CbJvT3MXZg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ADCB801A9D;
        Tue,  8 Sep 2020 01:24:17 +0000 (UTC)
Received: from localhost (ovpn-12-217.pek2.redhat.com [10.72.12.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA66C16EC2;
        Tue,  8 Sep 2020 01:24:10 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V3 2/3] percpu_ref: reduce memory footprint of percpu_ref in fast path
Date:   Tue,  8 Sep 2020 09:23:50 +0800
Message-Id: <20200908012351.1092986-3-ming.lei@redhat.com>
In-Reply-To: <20200908012351.1092986-1-ming.lei@redhat.com>
References: <20200908012351.1092986-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

'struct percpu_ref' is often embedded into one user structure, and the
instance is usually referenced in fast path, however actually only
'percpu_count_ptr' is needed in fast path.

So move other fields into one new structure of 'percpu_ref_data', and
allocate it dynamically via kzalloc(), then memory footprint of
'percpu_ref' in fast path is reduced a lot and becomes suitable to put
into hot cacheline of user structure.

Tested-by: Veronika Kabatova <vkabatov@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/infiniband/sw/rdmavt/mr.c |   2 +-
 include/linux/percpu-refcount.h   |  45 ++++------
 lib/percpu-refcount.c             | 131 ++++++++++++++++++++++--------
 3 files changed, 116 insertions(+), 62 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 2f7c25fea44a..8490fdb9c91e 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -499,7 +499,7 @@ static int rvt_check_refs(struct rvt_mregion *mr, const char *t)
 		rvt_pr_err(rdi,
 			   "%s timeout mr %p pd %p lkey %x refcount %ld\n",
 			   t, mr, mr->pd, mr->lkey,
-			   atomic_long_read(&mr->refcount.count));
+			   atomic_long_read(&mr->refcount.data->count));
 		rvt_get_mr(mr);
 		return -EBUSY;
 	}
diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index aed01562387b..db500c7ff823 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -92,18 +92,23 @@ enum {
 	PERCPU_REF_ALLOW_REINIT	= 1 << 2,
 };
 
-struct percpu_ref {
+struct percpu_ref_data {
 	atomic_long_t		count;
-	/*
-	 * The low bit of the pointer indicates whether the ref is in percpu
-	 * mode; if set, then get/put will manipulate the atomic_t.
-	 */
-	unsigned long		percpu_count_ptr;
 	percpu_ref_func_t	*release;
 	percpu_ref_func_t	*confirm_switch;
 	bool			force_atomic:1;
 	bool			allow_reinit:1;
 	struct rcu_head		rcu;
+	struct percpu_ref	*ref;
+};
+
+struct percpu_ref {
+	/*
+	 * The low bit of the pointer indicates whether the ref is in percpu
+	 * mode; if set, then get/put will manipulate the atomic_t.
+	 */
+	unsigned long		percpu_count_ptr;
+	struct percpu_ref_data  *data;
 };
 
 int __must_check percpu_ref_init(struct percpu_ref *ref,
@@ -119,6 +124,7 @@ void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 				 percpu_ref_func_t *confirm_kill);
 void percpu_ref_resurrect(struct percpu_ref *ref);
 void percpu_ref_reinit(struct percpu_ref *ref);
+bool percpu_ref_is_zero(struct percpu_ref *ref);
 
 /**
  * percpu_ref_kill - drop the initial ref
@@ -192,7 +198,7 @@ static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
 	if (__ref_is_percpu(ref, &percpu_count))
 		this_cpu_add(*percpu_count, nr);
 	else
-		atomic_long_add(nr, &ref->count);
+		atomic_long_add(nr, &ref->data->count);
 
 	rcu_read_unlock();
 }
@@ -232,7 +238,7 @@ static inline bool percpu_ref_tryget_many(struct percpu_ref *ref,
 		this_cpu_add(*percpu_count, nr);
 		ret = true;
 	} else {
-		ret = atomic_long_add_unless(&ref->count, nr, 0);
+		ret = atomic_long_add_unless(&ref->data->count, nr, 0);
 	}
 
 	rcu_read_unlock();
@@ -280,7 +286,7 @@ static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
 		this_cpu_inc(*percpu_count);
 		ret = true;
 	} else if (!(ref->percpu_count_ptr & __PERCPU_REF_DEAD)) {
-		ret = atomic_long_inc_not_zero(&ref->count);
+		ret = atomic_long_inc_not_zero(&ref->data->count);
 	}
 
 	rcu_read_unlock();
@@ -306,8 +312,8 @@ static inline void percpu_ref_put_many(struct percpu_ref *ref, unsigned long nr)
 
 	if (__ref_is_percpu(ref, &percpu_count))
 		this_cpu_sub(*percpu_count, nr);
-	else if (unlikely(atomic_long_sub_and_test(nr, &ref->count)))
-		ref->release(ref);
+	else if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count)))
+		ref->data->release(ref);
 
 	rcu_read_unlock();
 }
@@ -340,21 +346,4 @@ static inline bool percpu_ref_is_dying(struct percpu_ref *ref)
 	return ref->percpu_count_ptr & __PERCPU_REF_DEAD;
 }
 
-/**
- * percpu_ref_is_zero - test whether a percpu refcount reached zero
- * @ref: percpu_ref to test
- *
- * Returns %true if @ref reached zero.
- *
- * This function is safe to call as long as @ref is between init and exit.
- */
-static inline bool percpu_ref_is_zero(struct percpu_ref *ref)
-{
-	unsigned long __percpu *percpu_count;
-
-	if (__ref_is_percpu(ref, &percpu_count))
-		return false;
-	return !atomic_long_read(&ref->count);
-}
-
 #endif
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 9e7c4ab5b7bb..5b556d42757c 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
+#include <linux/slab.h>
 #include <linux/percpu-refcount.h>
 
 /*
@@ -64,18 +65,25 @@ int percpu_ref_init(struct percpu_ref *ref, percpu_ref_func_t *release,
 	size_t align = max_t(size_t, 1 << __PERCPU_REF_FLAG_BITS,
 			     __alignof__(unsigned long));
 	unsigned long start_count = 0;
+	struct percpu_ref_data *data;
 
 	ref->percpu_count_ptr = (unsigned long)
 		__alloc_percpu_gfp(sizeof(unsigned long), align, gfp);
 	if (!ref->percpu_count_ptr)
 		return -ENOMEM;
 
-	ref->force_atomic = flags & PERCPU_REF_INIT_ATOMIC;
-	ref->allow_reinit = flags & PERCPU_REF_ALLOW_REINIT;
+	data = kzalloc(sizeof(*ref->data), gfp);
+	if (!data) {
+		free_percpu((void __percpu *)ref->percpu_count_ptr);
+		return -ENOMEM;
+	}
+
+	data->force_atomic = flags & PERCPU_REF_INIT_ATOMIC;
+	data->allow_reinit = flags & PERCPU_REF_ALLOW_REINIT;
 
 	if (flags & (PERCPU_REF_INIT_ATOMIC | PERCPU_REF_INIT_DEAD)) {
 		ref->percpu_count_ptr |= __PERCPU_REF_ATOMIC;
-		ref->allow_reinit = true;
+		data->allow_reinit = true;
 	} else {
 		start_count += PERCPU_COUNT_BIAS;
 	}
@@ -85,10 +93,12 @@ int percpu_ref_init(struct percpu_ref *ref, percpu_ref_func_t *release,
 	else
 		start_count++;
 
-	atomic_long_set(&ref->count, start_count);
+	atomic_long_set(&data->count, start_count);
 
-	ref->release = release;
-	ref->confirm_switch = NULL;
+	data->release = release;
+	data->confirm_switch = NULL;
+	data->ref = ref;
+	ref->data = data;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(percpu_ref_init);
@@ -99,6 +109,18 @@ bool percpu_ref_inited(struct percpu_ref *ref)
 }
 EXPORT_SYMBOL_GPL(percpu_ref_inited);
 
+static void __percpu_ref_exit(struct percpu_ref *ref)
+{
+	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
+
+	if (percpu_count) {
+		/* non-NULL confirm_switch indicates switching in progress */
+		WARN_ON_ONCE(ref->data->confirm_switch);
+		free_percpu(percpu_count);
+		ref->percpu_count_ptr = __PERCPU_REF_ATOMIC_DEAD;
+	}
+}
+
 /**
  * percpu_ref_exit - undo percpu_ref_init()
  * @ref: percpu_ref to exit
@@ -111,27 +133,36 @@ EXPORT_SYMBOL_GPL(percpu_ref_inited);
  */
 void percpu_ref_exit(struct percpu_ref *ref)
 {
-	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
+	struct percpu_ref_data *data = ref->data;
+	unsigned long flags;
 
-	if (percpu_count) {
-		/* non-NULL confirm_switch indicates switching in progress */
-		WARN_ON_ONCE(ref->confirm_switch);
-		free_percpu(percpu_count);
-		ref->percpu_count_ptr = __PERCPU_REF_ATOMIC_DEAD;
-	}
+	if (!percpu_ref_inited(ref))
+		return;
+
+	__percpu_ref_exit(ref);
+
+	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
+	ref->percpu_count_ptr |= atomic_long_read(&ref->data->count) <<
+		__PERCPU_REF_FLAG_BITS;
+	ref->data = NULL;
+	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+
+	kfree(data);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_exit);
 
 static void percpu_ref_call_confirm_rcu(struct rcu_head *rcu)
 {
-	struct percpu_ref *ref = container_of(rcu, struct percpu_ref, rcu);
+	struct percpu_ref_data *data = container_of(rcu,
+			struct percpu_ref_data, rcu);
+	struct percpu_ref *ref = data->ref;
 
-	ref->confirm_switch(ref);
-	ref->confirm_switch = NULL;
+	data->confirm_switch(ref);
+	data->confirm_switch = NULL;
 	wake_up_all(&percpu_ref_switch_waitq);
 
-	if (!ref->allow_reinit)
-		percpu_ref_exit(ref);
+	if (!data->allow_reinit)
+		__percpu_ref_exit(ref);
 
 	/* drop ref from percpu_ref_switch_to_atomic() */
 	percpu_ref_put(ref);
@@ -139,7 +170,9 @@ static void percpu_ref_call_confirm_rcu(struct rcu_head *rcu)
 
 static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
 {
-	struct percpu_ref *ref = container_of(rcu, struct percpu_ref, rcu);
+	struct percpu_ref_data *data = container_of(rcu,
+			struct percpu_ref_data, rcu);
+	struct percpu_ref *ref = data->ref;
 	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
 	unsigned long count = 0;
 	int cpu;
@@ -148,7 +181,7 @@ static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
 		count += *per_cpu_ptr(percpu_count, cpu);
 
 	pr_debug("global %lu percpu %lu\n",
-		 atomic_long_read(&ref->count), count);
+		 atomic_long_read(&data->count), count);
 
 	/*
 	 * It's crucial that we sum the percpu counters _before_ adding the sum
@@ -162,11 +195,11 @@ static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
 	 * reaching 0 before we add the percpu counts. But doing it at the same
 	 * time is equivalent and saves us atomic operations:
 	 */
-	atomic_long_add((long)count - PERCPU_COUNT_BIAS, &ref->count);
+	atomic_long_add((long)count - PERCPU_COUNT_BIAS, &data->count);
 
-	WARN_ONCE(atomic_long_read(&ref->count) <= 0,
+	WARN_ONCE(atomic_long_read(&data->count) <= 0,
 		  "percpu ref (%ps) <= 0 (%ld) after switching to atomic",
-		  ref->release, atomic_long_read(&ref->count));
+		  data->release, atomic_long_read(&data->count));
 
 	/* @ref is viewed as dead on all CPUs, send out switch confirmation */
 	percpu_ref_call_confirm_rcu(rcu);
@@ -192,10 +225,11 @@ static void __percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 	 * Non-NULL ->confirm_switch is used to indicate that switching is
 	 * in progress.  Use noop one if unspecified.
 	 */
-	ref->confirm_switch = confirm_switch ?: percpu_ref_noop_confirm_switch;
+	ref->data->confirm_switch = confirm_switch ?:
+		percpu_ref_noop_confirm_switch;
 
 	percpu_ref_get(ref);	/* put after confirmation */
-	call_rcu(&ref->rcu, percpu_ref_switch_to_atomic_rcu);
+	call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);
 }
 
 static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
@@ -208,10 +242,10 @@ static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
 	if (!(ref->percpu_count_ptr & __PERCPU_REF_ATOMIC))
 		return;
 
-	if (WARN_ON_ONCE(!ref->allow_reinit))
+	if (WARN_ON_ONCE(!ref->data->allow_reinit))
 		return;
 
-	atomic_long_add(PERCPU_COUNT_BIAS, &ref->count);
+	atomic_long_add(PERCPU_COUNT_BIAS, &ref->data->count);
 
 	/*
 	 * Restore per-cpu operation.  smp_store_release() is paired
@@ -229,6 +263,8 @@ static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
 static void __percpu_ref_switch_mode(struct percpu_ref *ref,
 				     percpu_ref_func_t *confirm_switch)
 {
+	struct percpu_ref_data *data = ref->data;
+
 	lockdep_assert_held(&percpu_ref_switch_lock);
 
 	/*
@@ -236,10 +272,10 @@ static void __percpu_ref_switch_mode(struct percpu_ref *ref,
 	 * its completion.  If the caller ensures that ATOMIC switching
 	 * isn't in progress, this function can be called from any context.
 	 */
-	wait_event_lock_irq(percpu_ref_switch_waitq, !ref->confirm_switch,
+	wait_event_lock_irq(percpu_ref_switch_waitq, !data->confirm_switch,
 			    percpu_ref_switch_lock);
 
-	if (ref->force_atomic || (ref->percpu_count_ptr & __PERCPU_REF_DEAD))
+	if (data->force_atomic || (ref->percpu_count_ptr & __PERCPU_REF_DEAD))
 		__percpu_ref_switch_to_atomic(ref, confirm_switch);
 	else
 		__percpu_ref_switch_to_percpu(ref);
@@ -272,7 +308,7 @@ void percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 
 	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
 
-	ref->force_atomic = true;
+	ref->data->force_atomic = true;
 	__percpu_ref_switch_mode(ref, confirm_switch);
 
 	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
@@ -290,7 +326,7 @@ EXPORT_SYMBOL_GPL(percpu_ref_switch_to_atomic);
 void percpu_ref_switch_to_atomic_sync(struct percpu_ref *ref)
 {
 	percpu_ref_switch_to_atomic(ref, NULL);
-	wait_event(percpu_ref_switch_waitq, !ref->confirm_switch);
+	wait_event(percpu_ref_switch_waitq, !ref->data->confirm_switch);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_switch_to_atomic_sync);
 
@@ -318,7 +354,7 @@ void percpu_ref_switch_to_percpu(struct percpu_ref *ref)
 
 	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
 
-	ref->force_atomic = false;
+	ref->data->force_atomic = false;
 	__percpu_ref_switch_mode(ref, NULL);
 
 	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
@@ -350,7 +386,8 @@ void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
 
 	WARN_ONCE(ref->percpu_count_ptr & __PERCPU_REF_DEAD,
-		  "%s called more than once on %ps!", __func__, ref->release);
+		  "%s called more than once on %ps!", __func__,
+		  ref->data->release);
 
 	ref->percpu_count_ptr |= __PERCPU_REF_DEAD;
 	__percpu_ref_switch_mode(ref, confirm_kill);
@@ -360,6 +397,34 @@ void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 }
 EXPORT_SYMBOL_GPL(percpu_ref_kill_and_confirm);
 
+/**
+ * percpu_ref_is_zero - test whether a percpu refcount reached zero
+ * @ref: percpu_ref to test
+ *
+ * Returns %true if @ref reached zero.
+ *
+ * This function is safe to call as long as @ref is between init and exit.
+ */
+bool percpu_ref_is_zero(struct percpu_ref *ref)
+{
+	unsigned long __percpu *percpu_count;
+	unsigned long count, flags;
+
+	if (__ref_is_percpu(ref, &percpu_count))
+		return false;
+
+	/* protect us from being destroyed */
+	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
+	if (ref->data)
+		count = atomic_long_read(&ref->data->count);
+	else
+		count = ref->percpu_count_ptr >> __PERCPU_REF_FLAG_BITS;
+	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+
+	return count == 0;
+}
+EXPORT_SYMBOL_GPL(percpu_ref_is_zero);
+
 /**
  * percpu_ref_reinit - re-initialize a percpu refcount
  * @ref: perpcu_ref to re-initialize
-- 
2.25.2

