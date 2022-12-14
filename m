Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C930C4332F
	for <linux-block@archiver.kernel.org>; Wed, 14 Dec 2022 02:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbiLNCxH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Dec 2022 21:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbiLNCws (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2022 21:52:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A392714C
        for <linux-block@vger.kernel.org>; Tue, 13 Dec 2022 18:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670986297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJTsGV35CYOraEoRISqpKpr/2uwkfrZs9x/0odiJU0M=;
        b=Qhf6XmZ6+DOvOD+cHMC2wmKE7w0yk3FUSdRsIs9t0UQaR8kB5qngi0cUgL2fi3Zg+XS7ME
        VEefOyxhvfPXZgVWB12b9pQIdoR70JKetB6z5VonOAvtDm2z1KPURM2KS7sAfPdSXymsmP
        P9ZwIm96/sdBPW9pLgS0PnBE4JhYr0g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-J8NTIGfpNlG_jTgAlDFv2Q-1; Tue, 13 Dec 2022 21:51:31 -0500
X-MC-Unique: J8NTIGfpNlG_jTgAlDFv2Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C42023832786;
        Wed, 14 Dec 2022 02:51:30 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECD2540ED784;
        Wed, 14 Dec 2022 02:51:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        Yu Kuai <yukuai3@huawei.com>, Dennis Zhou <dennis@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/3] lib/percpu-refcount: drain ->release() in perpcu_ref_exit()
Date:   Wed, 14 Dec 2022 10:51:01 +0800
Message-Id: <20221214025101.1268437-4-ming.lei@redhat.com>
In-Reply-To: <20221214025101.1268437-1-ming.lei@redhat.com>
References: <20221214025101.1268437-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pattern of wait_event(percpu_ref_is_zero()) has been used in several
kernel components, and this way actually has the following risk:

- percpu_ref_is_zero() can be returned just between
  atomic_long_sub_and_test() and ref->data->release(ref)

- given the refcount is found as zero, percpu_ref_exit() could
  be called, and the host data structure is freed

- then use-after-free is triggered in ->release() when the user host
  data structure is freed after percpu_ref_exit() returns

Reported-by: Zhong Jinghua <zhongjinghua@huawei.com>
Fixes: 2b0d3d3e4fcf ("percpu_ref: reduce memory footprint of percpu_ref in fast path")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/percpu-refcount.h | 41 ++++++++++++++++++++++-----------
 lib/percpu-refcount.c           | 22 ++++++++++++++++++
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 006c6aae261e..6ef29ebffd58 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -55,6 +55,7 @@
 #include <linux/rcupdate.h>
 #include <linux/types.h>
 #include <linux/gfp.h>
+#include <linux/sched.h>
 
 struct percpu_ref;
 typedef void (percpu_ref_func_t)(struct percpu_ref *);
@@ -104,6 +105,7 @@ struct percpu_ref_data {
 	bool			force_atomic:1;
 	bool			allow_reinit:1;
 	bool			auto_exit:1;
+	bool			being_release:1;
 	struct rcu_head		rcu;
 	struct percpu_ref	*ref;
 };
@@ -137,6 +139,7 @@ void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 void percpu_ref_resurrect(struct percpu_ref *ref);
 void percpu_ref_reinit(struct percpu_ref *ref);
 bool percpu_ref_is_zero(struct percpu_ref *ref);
+wait_queue_head_t *percpu_ref_get_switch_waitq(void);
 
 /**
  * percpu_ref_kill - drop the initial ref
@@ -319,6 +322,29 @@ static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
 	return ret;
 }
 
+/* Internal helper, please do not call it outside */
+static inline void __percpu_ref_put_many(struct percpu_ref *ref,
+		unsigned long nr)
+{
+	struct percpu_ref_data *data = ref->data;
+	struct percpu_ref copy = *ref;
+	bool release = false;
+
+	data->being_release = 1;
+	if (unlikely(atomic_long_sub_and_test(nr, &data->count))) {
+		data->release(ref);
+		release = true;
+	}
+	data->being_release = 0;
+
+	if (release) {
+		if (data->auto_exit)
+			percpu_ref_exit(&copy);
+		/* re-use switch waitq for ack the release done */
+		wake_up_all(percpu_ref_get_switch_waitq());
+	}
+}
+
 /**
  * percpu_ref_put_many - decrement a percpu refcount
  * @ref: percpu_ref to put
@@ -337,19 +363,8 @@ static inline void percpu_ref_put_many(struct percpu_ref *ref, unsigned long nr)
 
 	if (__ref_is_percpu(ref, &percpu_count))
 		this_cpu_sub(*percpu_count, nr);
-	else {
-		struct percpu_ref_data *data = ref->data;
-		struct percpu_ref copy = *ref;
-		bool release = false;
-
-		if (unlikely(atomic_long_sub_and_test(nr, &data->count))) {
-			data->release(ref);
-			release = true;
-		}
-
-		if (release && data->auto_exit)
-			percpu_ref_exit(&copy);
-	}
+	else
+		__percpu_ref_put_many(ref, nr);
 
 	rcu_read_unlock();
 }
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index c0cadf92948f..fd50eda233ed 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -140,6 +140,22 @@ void percpu_ref_exit(struct percpu_ref *ref)
 	if (!data)
 		return;
 
+	/*
+	 * We may reach here because wait_event(percpu_ref_is_zero())
+	 * returns, and ->release() may not be completed or even started
+	 * ye, then use-after-free is caused, so drain ->release() here
+	 */
+	if (!data->auto_exit) {
+		/*
+		 * Order reading the atomic count in percpu_ref_is_zero
+		 * and reading data->being_release. The counter pair is
+		 * the one implied in atomic_long_sub_and_test() called
+		 * from __percpu_ref_put_many().
+		 */
+		smp_rmb();
+		wait_event(percpu_ref_switch_waitq, !data->being_release);
+	}
+
 	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
 	ref->percpu_count_ptr |= atomic_long_read(&ref->data->count) <<
 		__PERCPU_REF_FLAG_BITS;
@@ -480,3 +496,9 @@ void percpu_ref_resurrect(struct percpu_ref *ref)
 	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_resurrect);
+
+wait_queue_head_t *percpu_ref_get_switch_waitq()
+{
+	return &percpu_ref_switch_waitq;
+}
+EXPORT_SYMBOL_GPL(percpu_ref_get_switch_waitq);
-- 
2.38.1

