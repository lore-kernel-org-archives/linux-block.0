Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97396255240
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031797; cv=none; b=EWidbS1s30wiY2xrHtQ1qZeVsRX+ORjHUs87B23MMZK9/O1Oji5j4VryVMQPr7+2X6O25/c3QR6WYmrZgEoiXMpzk1RzyL5HBkMMqaieulCbh7k7MWws+btB66l1PoaGu/OISW19uNZuqJqodUjk69qpP9KlG/rP0KQ05n9mvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031797; c=relaxed/simple;
	bh=bETqw565/KIzdlwdmmDMt2ea7v7ZriHBwOXwaUv4nKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXIg1HSyvV8LM61QOr8qBFQLtOXtsFsvvuYuTLqLrHeGqUjUKDb9kMNzdEBiQbFNKiiu9EIy7Vm3kBu2h0zg2v7z5RcxJVFKgSbiXL/xLxiCjn2dz9bw0gYnoBpf94lUVqw7ARYr8/YFT4CBgM7zeusw6p+TCwozPq13qhDrEMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GGJrjmPx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGJrjmPx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744031794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jpAaKbptsRrk4AdqKJbkLwYhJAfYRQC+/AkJboHn3k=;
	b=GGJrjmPxiTe0bLT1LiAwzoSWAq4T48r5hPG0DBKUIM7Hvz9p3bUMEZ9MU0sMadEzH/cdo2
	H/BAGJgDoJupvLIMVM8cFy2S3mId2EJ/LV1u58CnBh5bYs0xsnK6zh/ETQzb/YQaaD+uc0
	BTrlIMUWVqj9ko2wTCjKU3VleJwZORE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-Y3BN58veMUyMsiK-SY0uPA-1; Mon,
 07 Apr 2025 09:16:31 -0400
X-MC-Unique: Y3BN58veMUyMsiK-SY0uPA-1
X-Mimecast-MFC-AGG-ID: Y3BN58veMUyMsiK-SY0uPA_1744031790
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54E0C19560AB;
	Mon,  7 Apr 2025 13:16:30 +0000 (UTC)
Received: from localhost (unknown [10.72.120.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F265C192C7C3;
	Mon,  7 Apr 2025 13:16:28 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 09/13] selftests: ublk: set queue pthread's cpu affinity
Date: Mon,  7 Apr 2025 21:15:20 +0800
Message-ID: <20250407131526.1927073-10-ming.lei@redhat.com>
In-Reply-To: <20250407131526.1927073-1-ming.lei@redhat.com>
References: <20250407131526.1927073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In NUMA machine, ublk IO performance is very sensitive with queue
pthread's affinity setting.

Retrieve queue's affinity and select the 1st cpu as queue thread's sched
affinity, and it is observed that single cpu task affinity can get
stable & good performance if client application is put on proper cpu.

Dump this info when adding one ublk device. Use shmem to communicate
queue's tid between parent and daemon.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 156 +++++++++++++++++++++++++--
 tools/testing/selftests/ublk/kublk.h |  11 +-
 2 files changed, 159 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index a78eaa123859..464abacdbbcb 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -206,10 +206,73 @@ static const char *ublk_dev_state_desc(struct ublk_dev *dev)
 	};
 }
 
+static void ublk_print_cpu_set(const cpu_set_t *set, char *buf, unsigned len)
+{
+	unsigned done = 0;
+	int i;
+
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		if (CPU_ISSET(i, set))
+			done += snprintf(&buf[done], len - done, "%d ", i);
+	}
+}
+
+static void ublk_adjust_affinity(cpu_set_t *set)
+{
+	int j, updated = 0;
+
+	/*
+	 * Just keep the 1st CPU now.
+	 *
+	 * In future, auto affinity selection can be tried.
+	 */
+	for (j = 0; j < CPU_SETSIZE; j++) {
+		if (CPU_ISSET(j, set)) {
+			if (!updated) {
+				updated = 1;
+				continue;
+			}
+			CPU_CLR(j, set);
+		}
+	}
+}
+
+/* Caller must free the allocated buffer */
+static int ublk_ctrl_get_affinity(struct ublk_dev *ctrl_dev, cpu_set_t **ptr_buf)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_GET_QUEUE_AFFINITY,
+		.flags	= CTRL_CMD_HAS_DATA | CTRL_CMD_HAS_BUF,
+	};
+	cpu_set_t *buf;
+	int i, ret;
+
+	buf = malloc(sizeof(cpu_set_t) * ctrl_dev->dev_info.nr_hw_queues);
+	if (!buf)
+		return -ENOMEM;
+
+	for (i = 0; i < ctrl_dev->dev_info.nr_hw_queues; i++) {
+		data.data[0] = i;
+		data.len = sizeof(cpu_set_t);
+		data.addr = (__u64)&buf[i];
+
+		ret = __ublk_ctrl_cmd(ctrl_dev, &data);
+		if (ret < 0) {
+			free(buf);
+			return ret;
+		}
+		ublk_adjust_affinity(&buf[i]);
+	}
+
+	*ptr_buf = buf;
+	return 0;
+}
+
 static void ublk_ctrl_dump(struct ublk_dev *dev)
 {
 	struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
 	struct ublk_params p;
+	cpu_set_t *affinity;
 	int ret;
 
 	ret = ublk_ctrl_get_params(dev, &p);
@@ -218,12 +281,31 @@ static void ublk_ctrl_dump(struct ublk_dev *dev)
 		return;
 	}
 
+	ret = ublk_ctrl_get_affinity(dev, &affinity);
+	if (ret < 0) {
+		ublk_err("failed to get affinity %m\n");
+		return;
+	}
+
 	ublk_log("dev id %d: nr_hw_queues %d queue_depth %d block size %d dev_capacity %lld\n",
 			info->dev_id, info->nr_hw_queues, info->queue_depth,
 			1 << p.basic.logical_bs_shift, p.basic.dev_sectors);
 	ublk_log("\tmax rq size %d daemon pid %d flags 0x%llx state %s\n",
 			info->max_io_buf_bytes, info->ublksrv_pid, info->flags,
 			ublk_dev_state_desc(dev));
+
+	if (affinity) {
+		char buf[512];
+		int i;
+
+		for (i = 0; i < info->nr_hw_queues; i++) {
+			ublk_print_cpu_set(&affinity[i], buf, sizeof(buf));
+			printf("\tqueue %u: tid %d affinity(%s)\n",
+					i, dev->q[i].tid, buf);
+		}
+		free(affinity);
+	}
+
 	fflush(stdout);
 }
 
@@ -603,9 +685,24 @@ static int ublk_process_io(struct ublk_queue *q)
 	return reapped;
 }
 
+static void ublk_queue_set_sched_affinity(const struct ublk_queue *q,
+		cpu_set_t *cpuset)
+{
+        if (sched_setaffinity(0, sizeof(*cpuset), cpuset) < 0)
+                ublk_err("ublk dev %u queue %u set affinity failed",
+                                q->dev->dev_info.dev_id, q->q_id);
+}
+
+struct ublk_queue_info {
+	struct ublk_queue 	*q;
+	sem_t 			*queue_sem;
+	cpu_set_t 		*affinity;
+};
+
 static void *ublk_io_handler_fn(void *data)
 {
-	struct ublk_queue *q = data;
+	struct ublk_queue_info *info = data;
+	struct ublk_queue *q = info->q;
 	int dev_id = q->dev->dev_info.dev_id;
 	int ret;
 
@@ -615,6 +712,10 @@ static void *ublk_io_handler_fn(void *data)
 				dev_id, q->q_id);
 		return NULL;
 	}
+	/* IO perf is sensitive with queue pthread affinity on NUMA machine*/
+	ublk_queue_set_sched_affinity(q, info->affinity);
+	sem_post(info->queue_sem);
+
 	ublk_dbg(UBLK_DBG_QUEUE, "tid %d: ublk dev %d queue %d started\n",
 			q->tid, dev_id, q->q_id);
 
@@ -640,7 +741,7 @@ static void ublk_set_parameters(struct ublk_dev *dev)
 				dev->dev_info.dev_id, ret);
 }
 
-static int ublk_send_dev_event(const struct dev_ctx *ctx, int dev_id)
+static int ublk_send_dev_event(const struct dev_ctx *ctx, struct ublk_dev *dev, int dev_id)
 {
 	uint64_t id;
 	int evtfd = ctx->_evtfd;
@@ -653,10 +754,14 @@ static int ublk_send_dev_event(const struct dev_ctx *ctx, int dev_id)
 	else
 		id = ERROR_EVTFD_DEVID;
 
+	if (dev && ctx->shadow_dev)
+		memcpy(&ctx->shadow_dev->q, &dev->q, sizeof(dev->q));
+
 	if (write(evtfd, &id, sizeof(id)) != sizeof(id))
 		return -EINVAL;
 
 	close(evtfd);
+	shmdt(ctx->shadow_dev);
 
 	return 0;
 }
@@ -664,24 +769,46 @@ static int ublk_send_dev_event(const struct dev_ctx *ctx, int dev_id)
 
 static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 {
-	int ret, i;
-	void *thread_ret;
 	const struct ublksrv_ctrl_dev_info *dinfo = &dev->dev_info;
+	struct ublk_queue_info *qinfo;
+	cpu_set_t *affinity_buf;
+	void *thread_ret;
+	sem_t queue_sem;
+	int ret, i;
 
 	ublk_dbg(UBLK_DBG_DEV, "%s enter\n", __func__);
 
+	qinfo = (struct ublk_queue_info *)calloc(sizeof(struct ublk_queue_info),
+			dinfo->nr_hw_queues);
+	if (!qinfo)
+		return -ENOMEM;
+
+	sem_init(&queue_sem, 0, 0);
 	ret = ublk_dev_prep(ctx, dev);
 	if (ret)
 		return ret;
 
+	ret = ublk_ctrl_get_affinity(dev, &affinity_buf);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < dinfo->nr_hw_queues; i++) {
 		dev->q[i].dev = dev;
 		dev->q[i].q_id = i;
+
+		qinfo[i].q = &dev->q[i];
+		qinfo[i].queue_sem = &queue_sem;
+		qinfo[i].affinity = &affinity_buf[i];
 		pthread_create(&dev->q[i].thread, NULL,
 				ublk_io_handler_fn,
-				&dev->q[i]);
+				&qinfo[i]);
 	}
 
+	for (i = 0; i < dinfo->nr_hw_queues; i++)
+		sem_wait(&queue_sem);
+	free(qinfo);
+	free(affinity_buf);
+
 	/* everything is fine now, start us */
 	ublk_set_parameters(dev);
 	ret = ublk_ctrl_start_dev(dev, getpid());
@@ -694,7 +821,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	if (ctx->fg)
 		ublk_ctrl_dump(dev);
 	else
-		ublk_send_dev_event(ctx, dev->dev_info.dev_id);
+		ublk_send_dev_event(ctx, dev, dev->dev_info.dev_id);
 
 	/* wait until we are terminated */
 	for (i = 0; i < dinfo->nr_hw_queues; i++)
@@ -873,7 +1000,7 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 
 fail:
 	if (ret < 0)
-		ublk_send_dev_event(ctx, -1);
+		ublk_send_dev_event(ctx, dev, -1);
 	ublk_ctrl_deinit(dev);
 	return ret;
 }
@@ -887,6 +1014,16 @@ static int cmd_dev_add(struct dev_ctx *ctx)
 	if (ctx->fg)
 		goto run;
 
+	ctx->_shmid = shmget(IPC_PRIVATE, sizeof(struct ublk_dev), IPC_CREAT | 0666);
+	if (ctx->_shmid < 0) {
+		ublk_err("%s: failed to shmget %s\n", __func__, strerror(errno));
+		exit(-1);
+	}
+	ctx->shadow_dev = (struct ublk_dev *)shmat(ctx->_shmid, NULL, 0);
+	if (ctx->shadow_dev == (struct ublk_dev *)-1) {
+		ublk_err("%s: failed to shmat %s\n", __func__, strerror(errno));
+		exit(-1);
+	}
 	ctx->_evtfd = eventfd(0, 0);
 	if (ctx->_evtfd < 0) {
 		ublk_err("%s: failed to create eventfd %s\n", __func__, strerror(errno));
@@ -923,6 +1060,8 @@ static int cmd_dev_add(struct dev_ctx *ctx)
 			if (__cmd_dev_list(ctx) >= 0)
 				exit_code = EXIT_SUCCESS;
 		}
+		shmdt(ctx->shadow_dev);
+		shmctl(ctx->_shmid, IPC_RMID, NULL);
 		/* wait for child */
 		wait(NULL);
 		exit(exit_code);
@@ -989,6 +1128,9 @@ static int __cmd_dev_list(struct dev_ctx *ctx)
 			ublk_err("%s: can't get dev info from %d: %d\n",
 					__func__, ctx->dev_id, ret);
 	} else {
+		if (ctx->shadow_dev)
+			memcpy(&dev->q, ctx->shadow_dev->q, sizeof(dev->q));
+
 		ublk_ctrl_dump(dev);
 	}
 
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index d87d6c376283..526b55bceb27 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -20,10 +20,15 @@
 #include <sys/wait.h>
 #include <sys/eventfd.h>
 #include <sys/uio.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
 #include <linux/io_uring.h>
 #include <liburing.h>
-#include <linux/ublk_cmd.h>
+#include <semaphore.h>
+
+/* allow ublk_dep.h to override ublk_cmd.h */
 #include "ublk_dep.h"
+#include <linux/ublk_cmd.h>
 
 #define __maybe_unused __attribute__((unused))
 #define MAX_BACK_FILES   4
@@ -72,6 +77,10 @@ struct dev_ctx {
 	unsigned int    chunk_size;
 
 	int _evtfd;
+	int _shmid;
+
+	/* built from shmem, only for ublk_dump_dev() */
+	struct ublk_dev *shadow_dev;
 };
 
 struct ublk_ctrl_cmd_data {
-- 
2.47.0

