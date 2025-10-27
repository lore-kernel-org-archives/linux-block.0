Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915EB2FF169
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565823; cv=none; b=pssrrxktD9fnQ6uZBbfCfoUkzHnHrro+nX2Zs9FU6JfgXzbz6eLQPTZivF3gOtmUgPRb/uF6IOuEtZeWnP1rxIIOnVef2nO9qzzrHmbAp2X+k0GwI8wq6z6vTsp3TiacXnEBh4Vw9g3+a1HnO2x6uIxDy+AG9W+6nWOUuit/9C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565823; c=relaxed/simple;
	bh=9q7UzZ92gkxj3Xero+UY0TgU511sOW6yZ2aj+T7C5Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQJmYMhyxw8ujjJ/1uiGhGLfzhqB/EDKGCRCMRSNB3Fv5MYA5tqm8Ql7E0U1SLfG21AdrhuuSfiysphx7C9F6c8cIlFPVioUO+dqOwSuENvHC71KAHwiFD2aBXHXKw+pOPlhTSP4EJegyb5wFgUauU4zmba3Dts7HmYs3Jtmj/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bV+QXJtK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bV+QXJtK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761565820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFHXgvoTDhz+ddBNvE2ntrHeTt78hDa/sgaNplq9WFw=;
	b=bV+QXJtK2up5viU9ljSaVS+/Vs0QEufy3xaiZYl5QZVD/nAVjMDITeny2IpXy06viAZM9e
	vmcTRlhDHwdkOTbKLJV0bHm7p9hukP7AP9E9jCNQ4GtjKi1K2/gUxvDbp4hiVyXeA2+NQn
	3Tywoq3AR0mRpDATFXQ9rQyE5qe1QMg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-XkoEnHJBNcepX1WTseMwgg-1; Mon,
 27 Oct 2025 07:50:19 -0400
X-MC-Unique: XkoEnHJBNcepX1WTseMwgg-1
X-Mimecast-MFC-AGG-ID: XkoEnHJBNcepX1WTseMwgg_1761565818
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09FDA18089A6;
	Mon, 27 Oct 2025 11:50:18 +0000 (UTC)
Received: from localhost (unknown [10.72.120.21])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B9051955F1B;
	Mon, 27 Oct 2025 11:50:16 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/4] selftests: ublk: make ublk_thread thread-local variable
Date: Mon, 27 Oct 2025 19:49:48 +0800
Message-ID: <20251027114950.129414-5-ming.lei@redhat.com>
In-Reply-To: <20251027114950.129414-1-ming.lei@redhat.com>
References: <20251027114950.129414-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Refactor ublk_thread to be a thread-local variable instead of storing
it in ublk_dev:

- Remove pthread_t thread field from struct ublk_thread and move it to
  struct ublk_thread_info

- Remove struct ublk_thread array from struct ublk_dev, reducing memory
  footprint

- Define struct ublk_thread as local variable in __ublk_io_handler_fn()
  instead of accessing it from dev->threads[]

- Extract main IO handling logic into __ublk_io_handler_fn() which is
  marked as noinline

- Move CPU affinity setup to ublk_io_handler_fn() before calling
  __ublk_io_handler_fn()

- Update ublk_thread_set_sched_affinity() to take struct ublk_thread_info *
  instead of struct ublk_thread *

- Reorder struct ublk_thread fields to group related state together

This change makes each thread's ublk_thread structure truly local to
the thread, improving cache locality and reducing memory usage.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 76 +++++++++++++++-------------
 tools/testing/selftests/ublk/kublk.h |  9 ++--
 2 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index b13918500cdf..01585edea7f0 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -836,62 +836,70 @@ static int ublk_process_io(struct ublk_thread *t)
 	return reapped;
 }
 
-static void ublk_thread_set_sched_affinity(const struct ublk_thread *t,
-		cpu_set_t *cpuset)
-{
-        if (sched_setaffinity(0, sizeof(*cpuset), cpuset) < 0)
-		ublk_err("ublk dev %u thread %u set affinity failed",
-				t->dev->dev_info.dev_id, t->idx);
-}
-
 struct ublk_thread_info {
 	struct ublk_dev 	*dev;
+	pthread_t		thread;
 	unsigned		idx;
 	sem_t 			*ready;
 	cpu_set_t 		*affinity;
 	unsigned long long	extra_flags;
 };
 
-static void *ublk_io_handler_fn(void *data)
+static void ublk_thread_set_sched_affinity(const struct ublk_thread_info *info)
 {
-	struct ublk_thread_info *info = data;
-	struct ublk_thread *t = &info->dev->threads[info->idx];
+        if (sched_setaffinity(0, sizeof(*info->affinity), info->affinity) < 0)
+		ublk_err("ublk dev %u thread %u set affinity failed",
+				info->dev->dev_info.dev_id, info->idx);
+}
+
+static __attribute__((noinline)) int __ublk_io_handler_fn(struct ublk_thread_info *info)
+{
+	struct ublk_thread t = {
+		.dev = info->dev,
+		.idx = info->idx,
+	};
 	int dev_id = info->dev->dev_info.dev_id;
 	int ret;
 
-	t->dev = info->dev;
-	t->idx = info->idx;
-
-	/*
-	 * IO perf is sensitive with queue pthread affinity on NUMA machine
-	 *
-	 * Set sched_affinity at beginning, so following allocated memory/pages
-	 * could be CPU/NUMA aware.
-	 */
-	if (info->affinity)
-		ublk_thread_set_sched_affinity(t, info->affinity);
-
-	ret = ublk_thread_init(t, info->extra_flags);
+	ret = ublk_thread_init(&t, info->extra_flags);
 	if (ret) {
 		ublk_err("ublk dev %d thread %u init failed\n",
-				dev_id, t->idx);
-		return NULL;
+				dev_id, t.idx);
+		return ret;
 	}
 	sem_post(info->ready);
 
 	ublk_dbg(UBLK_DBG_THREAD, "tid %d: ublk dev %d thread %u started\n",
-			gettid(), dev_id, t->idx);
+			gettid(), dev_id, t.idx);
 
 	/* submit all io commands to ublk driver */
-	ublk_submit_fetch_commands(t);
+	ublk_submit_fetch_commands(&t);
 	do {
-		if (ublk_process_io(t) < 0)
+		if (ublk_process_io(&t) < 0)
 			break;
 	} while (1);
 
 	ublk_dbg(UBLK_DBG_THREAD, "tid %d: ublk dev %d thread %d exiting\n",
-		 gettid(), dev_id, t->idx);
-	ublk_thread_deinit(t);
+		 gettid(), dev_id, t.idx);
+	ublk_thread_deinit(&t);
+	return 0;
+}
+
+static void *ublk_io_handler_fn(void *data)
+{
+	struct ublk_thread_info *info = data;
+
+	/*
+	 * IO perf is sensitive with queue pthread affinity on NUMA machine
+	 *
+	 * Set sched_affinity at beginning, so following allocated memory/pages
+	 * could be CPU/NUMA aware.
+	 */
+	if (info->affinity)
+		ublk_thread_set_sched_affinity(info);
+
+	__ublk_io_handler_fn(info);
+
 	return NULL;
 }
 
@@ -989,14 +997,13 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 		 */
 		if (dev->nthreads == dinfo->nr_hw_queues)
 			tinfo[i].affinity = &affinity_buf[i];
-		pthread_create(&dev->threads[i].thread, NULL,
+		pthread_create(&tinfo[i].thread, NULL,
 				ublk_io_handler_fn,
 				&tinfo[i]);
 	}
 
 	for (i = 0; i < dev->nthreads; i++)
 		sem_wait(&ready);
-	free(tinfo);
 	free(affinity_buf);
 
 	/* everything is fine now, start us */
@@ -1019,7 +1026,8 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 
 	/* wait until we are terminated */
 	for (i = 0; i < dev->nthreads; i++)
-		pthread_join(dev->threads[i].thread, &thread_ret);
+		pthread_join(tinfo[i].thread, &thread_ret);
+	free(tinfo);
  fail:
 	for (i = 0; i < dinfo->nr_hw_queues; i++)
 		ublk_queue_deinit(&dev->q[i]);
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 5e55484fb0aa..fe42705c6d42 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -175,23 +175,20 @@ struct ublk_queue {
 
 struct ublk_thread {
 	struct ublk_dev *dev;
-	struct io_uring ring;
-	unsigned int cmd_inflight;
-	unsigned int io_inflight;
-
-	pthread_t thread;
 	unsigned idx;
 
 #define UBLKS_T_STOPPING	(1U << 0)
 #define UBLKS_T_IDLE	(1U << 1)
 	unsigned state;
+	unsigned int cmd_inflight;
+	unsigned int io_inflight;
+	struct io_uring ring;
 };
 
 struct ublk_dev {
 	struct ublk_tgt tgt;
 	struct ublksrv_ctrl_dev_info  dev_info;
 	struct ublk_queue q[UBLK_MAX_QUEUES];
-	struct ublk_thread threads[UBLK_MAX_THREADS];
 	unsigned nthreads;
 	unsigned per_io_tasks;
 
-- 
2.47.0

