Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D916A395
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707479; cv=none; b=MKDEecJtszpB0a/qQv9hCheNEIsteSblG/1YEJ4uRky2yPmBVeAsOL7HuS3LQsJRiKzMSkzUtJlPjv5hpQOez/YNhapfcVYJsE2yUvpQFkw54UyJUE7qMV3m9WqMYMvR7AipKvn9s+lZxWYecfzOVqwwfQLauAzydWc/nWunk0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707479; c=relaxed/simple;
	bh=t5uRfxDF7qOYzj8Kz1EFN+edA5rfvzBDnCRulwGCQ6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKTf2+cmlIT+5WpTPc69H+nUyjeTx/TwqUfZngE/dKLhT5f/wqz9Ngw9C+ZaLKvr8MpHWXjOyx5I12TeUiNo9+LApUc39WqWkoqVzYiTZ0UDt14PihfWtDjPBOr6Sy0BVp26bUHeWwADIScV6cflpmVj5YSWqNi/R6o43sZkl6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ED705TBk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ED705TBk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761707476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWrFXyHxIqRt8XsFUm61dbcpwhVzn9gLTCKPNmVXN+Y=;
	b=ED705TBk3Rz/1y6+/ZnZ9Oy6aoujzPKTm+FCnEJdNTKl41TGVeHoR9etBrbu9LLRO+Asq5
	tLNR0T6eJJoYQPUA29PUDGpvEW/yaGc11P9L0VuC+tD/aR0k49eFJuKwfIWThnmN2hL0IP
	vdB+yXlD2QkRLB3oGC7HkMNLNMEEPEo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-ZKQHMHZXOuK7o6txSWO2EA-1; Tue,
 28 Oct 2025 23:11:12 -0400
X-MC-Unique: ZKQHMHZXOuK7o6txSWO2EA-1
X-Mimecast-MFC-AGG-ID: ZKQHMHZXOuK7o6txSWO2EA_1761707471
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 521AE188093C;
	Wed, 29 Oct 2025 03:11:11 +0000 (UTC)
Received: from localhost (unknown [10.72.120.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C6281800579;
	Wed, 29 Oct 2025 03:11:09 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 5/5] selftests: ublk: make ublk_thread thread-local variable
Date: Wed, 29 Oct 2025 11:10:31 +0800
Message-ID: <20251029031035.258766-6-ming.lei@redhat.com>
In-Reply-To: <20251029031035.258766-1-ming.lei@redhat.com>
References: <20251029031035.258766-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
  instead of struct ublk_thread *, and use pthread_setaffinity_np()
  instead of sched_setaffinity()

- Reorder struct ublk_thread fields to group related state together

This change makes each thread's ublk_thread structure truly local to
the thread, improving cache locality and reducing memory usage.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 76 +++++++++++++++-------------
 tools/testing/selftests/ublk/kublk.h |  9 ++--
 2 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 062537ab8976..f8fa102a627f 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -836,62 +836,70 @@ static int ublk_process_io(struct ublk_thread *t)
 	return reapped;
 }
 
-static void ublk_thread_set_sched_affinity(const struct ublk_thread *t,
-		cpu_set_t *cpuset)
-{
-	if (pthread_setaffinity_np(pthread_self(), sizeof(*cpuset), cpuset) < 0)
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
+	if (pthread_setaffinity_np(pthread_self(), sizeof(*info->affinity), info->affinity) < 0)
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

