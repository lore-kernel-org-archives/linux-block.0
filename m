Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41972411618
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971175; cv=none; b=XlUWGmGUAYU2t6oHDwnW21aaRo2y8Uc9I0ao9u5xvIrPrtn/h39uSHMhdojsM8DTGD/x8FSst4Xkk3WcGeg7E/ZKZDE7MI05Cuwc6L0XH6XQ3WToz518QsBU0hdVPMet+MnlYdxAG+upTEEAmI8vf+UdH2JOJ3J6SkMNOO6223k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971175; c=relaxed/simple;
	bh=k00XtUfmU5zXkHH3yMCXeJWNUtO+YLIJUpEyFOwngUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOOK4EfSzGlzZBamOayehHYDdtkBVg3uzsPdpVVg+/UR7RHM54WXsyuy1PavMV9xW3xS9QljE6UAt0ksv3x4DajA3pWC3K4iY1YTYQelvW4xXVAtXfm058Gtj4k657CSgiMxaj4IUDhh94rznehww5czaiVxpuiitrOAPkg2LbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IvgkiQD+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvgkiQD+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774971159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5JbyLDgtWk2+OqV5aBNltotznfuZsbrV+mM/55fpQg=;
	b=IvgkiQD+PuxDm/QSTvyG7X4eka/vh4l/wbYYc5vmgGAKaenNWCX1yaoRBK3bVMLg0RiUNN
	9HwUu6/tiXXOvkIxOqOdJ/jGLpGV0lyBnNIdSfUmbQQK7ykC9wrHWANpE4VVbE8jVBpc96
	47v/BTvg5lQ/ExyeFXuQq704k+zVTAs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-r71ABmgHMzK-hBxxOD-3Lw-1; Tue,
 31 Mar 2026 11:32:36 -0400
X-MC-Unique: r71ABmgHMzK-hBxxOD-3Lw-1
X-Mimecast-MFC-AGG-ID: r71ABmgHMzK-hBxxOD-3Lw_1774971155
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28FC619560AA;
	Tue, 31 Mar 2026 15:32:35 +0000 (UTC)
Received: from localhost (unknown [10.72.116.55])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4CF8B19560AB;
	Tue, 31 Mar 2026 15:32:33 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 05/10] selftests/ublk: add shared memory zero-copy support in kublk
Date: Tue, 31 Mar 2026 23:31:56 +0800
Message-ID: <20260331153207.3635125-6-ming.lei@redhat.com>
In-Reply-To: <20260331153207.3635125-1-ming.lei@redhat.com>
References: <20260331153207.3635125-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add infrastructure for UBLK_F_SHMEM_ZC shared memory zero-copy:

- kublk.h: struct ublk_shmem_entry and table for tracking registered
  shared memory buffers
- kublk.c: per-device unix socket listener that accepts memfd
  registrations from clients via SCM_RIGHTS fd passing. The listener
  mmaps the memfd and registers the VA range with the kernel for PFN
  matching. Also adds --shmem_zc command line option.
- kublk.c: --htlb <path> option to open a pre-allocated hugetlbfs
  file, mmap it with MAP_SHARED|MAP_POPULATE, and register it with
  the kernel via ublk_ctrl_reg_buf(). Any process that mmaps the same
  hugetlbfs file shares the same physical pages, enabling zero-copy
  without socket-based fd passing.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 340 ++++++++++++++++++++++++++-
 tools/testing/selftests/ublk/kublk.h |  14 ++
 2 files changed, 352 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index e1c3b3c55e56..bd97e34f131b 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/fs.h>
+#include <sys/un.h>
 #include "kublk.h"
 
 #define MAX_NR_TGT_ARG 	64
@@ -1085,13 +1086,312 @@ static int ublk_send_dev_event(const struct dev_ctx *ctx, struct ublk_dev *dev,
 }
 
 
+/*
+ * Shared memory registration socket listener.
+ *
+ * The parent daemon context listens on a per-device unix socket at
+ * /run/ublk/ublkb<dev_id>.sock for shared memory registration requests
+ * from clients. Clients send a memfd via SCM_RIGHTS; the server
+ * registers it with the kernel, mmaps it, and returns the assigned index.
+ */
+#define UBLK_SHMEM_SOCK_DIR	"/run/ublk"
+
+/* defined in kublk.h, shared with file_backed.c (loop target) */
+struct ublk_shmem_entry shmem_table[UBLK_BUF_MAX];
+int shmem_count;
+
+static void ublk_shmem_sock_path(int dev_id, char *buf, size_t len)
+{
+	snprintf(buf, len, "%s/ublkb%d.sock", UBLK_SHMEM_SOCK_DIR, dev_id);
+}
+
+static int ublk_shmem_sock_create(int dev_id)
+{
+	struct sockaddr_un addr = { .sun_family = AF_UNIX };
+	char path[108];
+	int fd;
+
+	mkdir(UBLK_SHMEM_SOCK_DIR, 0755);
+	ublk_shmem_sock_path(dev_id, path, sizeof(path));
+	unlink(path);
+
+	fd = socket(AF_UNIX, SOCK_STREAM | SOCK_NONBLOCK, 0);
+	if (fd < 0)
+		return -1;
+
+	snprintf(addr.sun_path, sizeof(addr.sun_path), "%s", path);
+	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	listen(fd, 4);
+	ublk_dbg(UBLK_DBG_DEV, "shmem socket created: %s\n", path);
+	return fd;
+}
+
+static void ublk_shmem_sock_destroy(int dev_id, int sock_fd)
+{
+	char path[108];
+
+	if (sock_fd >= 0)
+		close(sock_fd);
+	ublk_shmem_sock_path(dev_id, path, sizeof(path));
+	unlink(path);
+}
+
+/* Receive a memfd from a client via SCM_RIGHTS */
+static int ublk_shmem_recv_fd(int client_fd)
+{
+	char buf[1];
+	struct iovec iov = { .iov_base = buf, .iov_len = sizeof(buf) };
+	union {
+		char cmsg_buf[CMSG_SPACE(sizeof(int))];
+		struct cmsghdr align;
+	} u;
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = u.cmsg_buf,
+		.msg_controllen = sizeof(u.cmsg_buf),
+	};
+	struct cmsghdr *cmsg;
+
+	if (recvmsg(client_fd, &msg, 0) <= 0)
+		return -1;
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	if (!cmsg || cmsg->cmsg_level != SOL_SOCKET ||
+	    cmsg->cmsg_type != SCM_RIGHTS)
+		return -1;
+
+	return *(int *)CMSG_DATA(cmsg);
+}
+
+/* Register a shared memory buffer: store fd, mmap it, return index */
+static int ublk_shmem_register(int shmem_fd)
+{
+	off_t size;
+	void *base;
+	int idx;
+
+	if (shmem_count >= UBLK_BUF_MAX)
+		return -1;
+
+	size = lseek(shmem_fd, 0, SEEK_END);
+	if (size <= 0)
+		return -1;
+
+	base = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED,
+		    shmem_fd, 0);
+	if (base == MAP_FAILED)
+		return -1;
+
+	idx = shmem_count++;
+	shmem_table[idx].fd = shmem_fd;
+	shmem_table[idx].mmap_base = base;
+	shmem_table[idx].size = size;
+
+	ublk_dbg(UBLK_DBG_DEV, "shmem registered: index=%d fd=%d size=%zu\n",
+		 idx, shmem_fd, (size_t)size);
+	return idx;
+}
+
+static void ublk_shmem_unregister_all(void)
+{
+	int i;
+
+	for (i = 0; i < shmem_count; i++) {
+		if (shmem_table[i].mmap_base) {
+			munmap(shmem_table[i].mmap_base,
+			       shmem_table[i].size);
+			close(shmem_table[i].fd);
+			shmem_table[i].mmap_base = NULL;
+		}
+	}
+	shmem_count = 0;
+}
+
+static int ublk_ctrl_reg_buf(struct ublk_dev *dev, void *addr, size_t size)
+{
+	struct ublk_buf_reg buf_reg = {
+		.addr = (unsigned long)addr,
+		.len = size,
+	};
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op = UBLK_U_CMD_REG_BUF,
+		.flags = CTRL_CMD_HAS_BUF,
+		.addr = (unsigned long)&buf_reg,
+		.len = sizeof(buf_reg),
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+/*
+ * Handle one client connection: receive memfd, mmap it, register
+ * the VA range with kernel, send back the assigned index.
+ */
+static void ublk_shmem_handle_client(int sock_fd, struct ublk_dev *dev)
+{
+	int client_fd, memfd, idx, ret;
+	int32_t reply;
+	off_t size;
+	void *base;
+
+	client_fd = accept(sock_fd, NULL, NULL);
+	if (client_fd < 0)
+		return;
+
+	memfd = ublk_shmem_recv_fd(client_fd);
+	if (memfd < 0) {
+		reply = -1;
+		goto out;
+	}
+
+	/* mmap the memfd in server address space */
+	size = lseek(memfd, 0, SEEK_END);
+	if (size <= 0) {
+		reply = -1;
+		close(memfd);
+		goto out;
+	}
+	base = mmap(NULL, size, PROT_READ | PROT_WRITE,
+		    MAP_SHARED | MAP_POPULATE, memfd, 0);
+	if (base == MAP_FAILED) {
+		reply = -1;
+		close(memfd);
+		goto out;
+	}
+
+	/* Register server's VA range with kernel for PFN matching */
+	ret = ublk_ctrl_reg_buf(dev, base, size);
+	if (ret < 0) {
+		ublk_dbg(UBLK_DBG_DEV,
+			 "shmem_zc: kernel reg failed %d\n", ret);
+		munmap(base, size);
+		close(memfd);
+		reply = ret;
+		goto out;
+	}
+
+	/* Store in table for I/O handling */
+	idx = ublk_shmem_register(memfd);
+	if (idx >= 0) {
+		shmem_table[idx].mmap_base = base;
+		shmem_table[idx].size = size;
+	}
+	reply = idx;
+out:
+	send(client_fd, &reply, sizeof(reply), 0);
+	close(client_fd);
+}
+
+struct shmem_listener_info {
+	int dev_id;
+	int stop_efd;		/* eventfd to signal listener to stop */
+	int sock_fd;		/* listener socket fd (output) */
+	struct ublk_dev *dev;
+};
+
+/*
+ * Socket listener thread: runs in the parent daemon context alongside
+ * the I/O threads. Accepts shared memory registration requests from
+ * clients via SCM_RIGHTS. Exits when stop_efd is signaled.
+ */
+static void *ublk_shmem_listener_fn(void *data)
+{
+	struct shmem_listener_info *info = data;
+	struct pollfd pfds[2];
+
+	info->sock_fd = ublk_shmem_sock_create(info->dev_id);
+	if (info->sock_fd < 0)
+		return NULL;
+
+	pfds[0].fd = info->sock_fd;
+	pfds[0].events = POLLIN;
+	pfds[1].fd = info->stop_efd;
+	pfds[1].events = POLLIN;
+
+	while (1) {
+		int ret = poll(pfds, 2, -1);
+
+		if (ret < 0)
+			break;
+
+		/* Stop signal from parent */
+		if (pfds[1].revents & POLLIN)
+			break;
+
+		/* Client connection */
+		if (pfds[0].revents & POLLIN)
+			ublk_shmem_handle_client(info->sock_fd, info->dev);
+	}
+
+	return NULL;
+}
+
+static int ublk_shmem_htlb_setup(const struct dev_ctx *ctx,
+				 struct ublk_dev *dev)
+{
+	int fd, idx, ret;
+	struct stat st;
+	void *base;
+
+	fd = open(ctx->htlb_path, O_RDWR);
+	if (fd < 0) {
+		ublk_err("htlb: can't open %s\n", ctx->htlb_path);
+		return -errno;
+	}
+
+	if (fstat(fd, &st) < 0 || st.st_size <= 0) {
+		ublk_err("htlb: invalid file size\n");
+		close(fd);
+		return -EINVAL;
+	}
+
+	base = mmap(NULL, st.st_size, PROT_READ | PROT_WRITE,
+		    MAP_SHARED | MAP_POPULATE, fd, 0);
+	if (base == MAP_FAILED) {
+		ublk_err("htlb: mmap failed\n");
+		close(fd);
+		return -ENOMEM;
+	}
+
+	ret = ublk_ctrl_reg_buf(dev, base, st.st_size);
+	if (ret < 0) {
+		ublk_err("htlb: reg_buf failed: %d\n", ret);
+		munmap(base, st.st_size);
+		close(fd);
+		return ret;
+	}
+
+	if (shmem_count >= UBLK_BUF_MAX) {
+		munmap(base, st.st_size);
+		close(fd);
+		return -ENOMEM;
+	}
+
+	idx = shmem_count++;
+	shmem_table[idx].fd = fd;
+	shmem_table[idx].mmap_base = base;
+	shmem_table[idx].size = st.st_size;
+
+	ublk_dbg(UBLK_DBG_DEV, "htlb registered: index=%d size=%zu\n",
+		 idx, (size_t)st.st_size);
+	return 0;
+}
+
 static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 {
 	const struct ublksrv_ctrl_dev_info *dinfo = &dev->dev_info;
+	struct shmem_listener_info linfo = {};
 	struct ublk_thread_info *tinfo;
 	unsigned long long extra_flags = 0;
 	cpu_set_t *affinity_buf;
 	unsigned char (*q_thread_map)[UBLK_MAX_QUEUES] = NULL;
+	uint64_t stop_val = 1;
+	pthread_t listener;
 	void *thread_ret;
 	sem_t ready;
 	int ret, i;
@@ -1180,15 +1480,44 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 		goto fail_start;
 	}
 
+	if (ctx->htlb_path) {
+		ret = ublk_shmem_htlb_setup(ctx, dev);
+		if (ret < 0) {
+			ublk_err("htlb setup failed: %d\n", ret);
+			ublk_ctrl_stop_dev(dev);
+			goto fail_start;
+		}
+	}
+
 	ublk_ctrl_get_info(dev);
 	if (ctx->fg)
 		ublk_ctrl_dump(dev);
 	else
 		ublk_send_dev_event(ctx, dev, dev->dev_info.dev_id);
 fail_start:
-	/* wait until we are terminated */
-	for (i = 0; i < dev->nthreads; i++)
+	/*
+	 * Wait for I/O threads to exit. While waiting, a listener
+	 * thread accepts shared memory registration requests from
+	 * clients via a per-device unix socket (SCM_RIGHTS fd passing).
+	 */
+	linfo.dev_id = dinfo->dev_id;
+	linfo.dev = dev;
+	linfo.stop_efd = eventfd(0, 0);
+	if (linfo.stop_efd >= 0)
+		pthread_create(&listener, NULL,
+			       ublk_shmem_listener_fn, &linfo);
+
+	for (i = 0; i < (int)dev->nthreads; i++)
 		pthread_join(tinfo[i].thread, &thread_ret);
+
+	/* Signal listener thread to stop and wait for it */
+	if (linfo.stop_efd >= 0) {
+		write(linfo.stop_efd, &stop_val, sizeof(stop_val));
+		pthread_join(listener, NULL);
+		close(linfo.stop_efd);
+		ublk_shmem_sock_destroy(dinfo->dev_id, linfo.sock_fd);
+	}
+	ublk_shmem_unregister_all();
 	free(tinfo);
  fail:
 	for (i = 0; i < dinfo->nr_hw_queues; i++)
@@ -1618,6 +1947,7 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_SAFE_STOP_DEV),
 		FEAT_NAME(UBLK_F_BATCH_IO),
 		FEAT_NAME(UBLK_F_NO_AUTO_PART_SCAN),
+		FEAT_NAME(UBLK_F_SHMEM_ZC),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
@@ -1790,6 +2120,8 @@ int main(int argc, char *argv[])
 		{ "safe",		0,	NULL,  0 },
 		{ "batch",              0,      NULL, 'b'},
 		{ "no_auto_part_scan",	0,	NULL,  0 },
+		{ "shmem_zc",		0,	NULL,  0  },
+		{ "htlb",		1,	NULL,  0  },
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -1905,6 +2237,10 @@ int main(int argc, char *argv[])
 				ctx.safe_stop = 1;
 			if (!strcmp(longopts[option_idx].name, "no_auto_part_scan"))
 				ctx.flags |= UBLK_F_NO_AUTO_PART_SCAN;
+			if (!strcmp(longopts[option_idx].name, "shmem_zc"))
+				ctx.flags |= UBLK_F_SHMEM_ZC;
+			if (!strcmp(longopts[option_idx].name, "htlb"))
+				ctx.htlb_path = strdup(optarg);
 			break;
 		case '?':
 			/*
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 02f0c55d006b..20d0a1eab41f 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -95,6 +95,8 @@ struct dev_ctx {
 	/* for 'update_size' command */
 	unsigned long long size;
 
+	char *htlb_path;
+
 	union {
 		struct stripe_ctx 	stripe;
 		struct fault_inject_ctx fault_inject;
@@ -599,6 +601,18 @@ static inline void ublk_queued_tgt_io(struct ublk_thread *t, struct ublk_queue *
 	}
 }
 
+/* shared memory zero-copy support */
+#define UBLK_BUF_MAX		256
+
+struct ublk_shmem_entry {
+	int fd;
+	void *mmap_base;
+	size_t size;
+};
+
+extern struct ublk_shmem_entry shmem_table[UBLK_BUF_MAX];
+extern int shmem_count;
+
 extern const struct ublk_tgt_ops null_tgt_ops;
 extern const struct ublk_tgt_ops loop_tgt_ops;
 extern const struct ublk_tgt_ops stripe_tgt_ops;
-- 
2.53.0

