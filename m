Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D74A4A08
	for <linux-block@vger.kernel.org>; Sat, 12 Apr 2025 02:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744425088; cv=none; b=m9VOMMNKi6sxO3gWoHBWiaSwcs5A/Fb2Lkp/kkiYy/OK09Fv3nSn8eV2nzLHQqopvLgMubuZlsI87eWXDWvs1c6USek1XUZnmHBUMU7+ZVcM5mAURBc1teFuHcZx9+8KgZ4bVLwWroUwkGvcvHzHbzvtVcOfMFD7k5X7HMLk32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744425088; c=relaxed/simple;
	bh=jq8Qpgm/gIrqfMLFzd1Kdd+G4jlhOGuJ9d/jJCVu4Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfdjJTmDBVdg58ZoVLs34R8pVNoCR5ouQ6/pJTjpZbcCCY0bff9HFy3JzZinxMV64qFWHbOzQkjUeXZDYzAmhgHuAyDZci1AqWouyx8Aa4Rr10OpHKRMbl9dawZ68BOeeY70pAJx0Q/zOxiDAu5cNYul4AMEwb+04skH4LLpCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UfYYiJLx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UfYYiJLx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744425085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62X8a1/uBYp3J/AWmLIJZrydrV7wot5y8r0egJJ7xbU=;
	b=UfYYiJLx8CIzkE8dhX9KiPxSQ2eBR3iBwD3h6/FV20A6G167nlBCYYVeKhybELo80+KvA9
	2xDdSdA2ioqCdUaKyLLfRMqPc2ghZ/9JDYY6acoDp0xWfVkhI9bcQcq59mDvPPQ7yWJYq2
	e0APS4UVnol4+JHiykgaL+Ko2mJtBnQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-8F0ruBL3PgC1o15_4rlKGQ-1; Fri,
 11 Apr 2025 22:31:21 -0400
X-MC-Unique: 8F0ruBL3PgC1o15_4rlKGQ-1
X-Mimecast-MFC-AGG-ID: 8F0ruBL3PgC1o15_4rlKGQ_1744425080
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFCC7180025F;
	Sat, 12 Apr 2025 02:31:18 +0000 (UTC)
Received: from localhost (unknown [10.72.116.41])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E979180174E;
	Sat, 12 Apr 2025 02:31:17 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 08/13] selftests: ublk: set queue pthread's cpu affinity
Date: Sat, 12 Apr 2025 10:30:24 +0800
Message-ID: <20250412023035.2649275-9-ming.lei@redhat.com>
In-Reply-To: <20250412023035.2649275-1-ming.lei@redhat.com>
References: <20250412023035.2649275-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
index c2acd874f9af..1e21e1401a08 100644
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
@@ -922,6 +1059,8 @@ static int cmd_dev_add(struct dev_ctx *ctx)
 			if (__cmd_dev_list(ctx) >= 0)
 				exit_code = EXIT_SUCCESS;
 		}
+		shmdt(ctx->shadow_dev);
+		shmctl(ctx->_shmid, IPC_RMID, NULL);
 		/* wait for child and detach from it */
 		wait(NULL);
 		exit(exit_code);
@@ -988,6 +1127,9 @@ static int __cmd_dev_list(struct dev_ctx *ctx)
 			ublk_err("%s: can't get dev info from %d: %d\n",
 					__func__, ctx->dev_id, ret);
 	} else {
+		if (ctx->shadow_dev)
+			memcpy(&dev->q, ctx->shadow_dev->q, sizeof(dev->q));
+
 		ublk_ctrl_dump(dev);
 	}
 
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index eccf12360a14..85295d3e36cb 100644
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
@@ -74,6 +79,10 @@ struct dev_ctx {
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

