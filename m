Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E9EC6379F
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 03:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjBPDD1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 22:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBPDD0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 22:03:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A134121A2D
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 19:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676516559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eSSpa2gC0uxPXl40RA4EDAQrBMhsFfj+6lPJNek1BK0=;
        b=WO8ABiNQ7kHyradllKK/MMMA5bUWDxo8k84fJN8FC0w8Wk8nPNFm3RgLqodnwYeO0UQpEK
        SScKJvM2xycb1kAPW+SmRuuml1fGw/SY9StuM/wffaib95xcAP3W5eU0GvltXxuFehzPgn
        M5EBo2XlgrdxQS/wiiTnIio9JcnTEIA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-MpWH3gKyPFuIHvstwqu-fg-1; Wed, 15 Feb 2023 22:02:36 -0500
X-MC-Unique: MpWH3gKyPFuIHvstwqu-fg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFABE1802CE4;
        Thu, 16 Feb 2023 03:02:35 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E3FB1121314;
        Thu, 16 Feb 2023 03:02:33 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] blktests/src: add mini ublk source code
Date:   Thu, 16 Feb 2023 11:01:33 +0800
Message-Id: <20230216030134.1368607-2-ming.lei@redhat.com>
In-Reply-To: <20230216030134.1368607-1-ming.lei@redhat.com>
References: <20230216030134.1368607-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for adding ublk related test:

1) ublk delete is sync removal, this way is convenient to
   blkg/queue/disk instance leak issue

2) mini ublk has two builtin target(null, loop), and loop IO is
handled by io_uring, so we can use ublk to cover part of io_uring
workloads

3) not like loop/nbd, ublk won't pre-allocate/add disk, and always
add/delete disk dynamically, this way may cover disk plug & unplug
tests

4) ublk specific test given people starts to use it, so better to
let blktest cover ublk related tests

Add mini ublk source for test purpose only, which is easy to use:

./miniublk add -t {null|loop} [-q nr_queues] [-d depth] [-n dev_id]
	 default: nr_queues=2(max 4), depth=128(max 128), dev_id=-1(auto allocation)
	 -t loop -f backing_file
	 -t null
./miniublk del [-n dev_id] [--disk/-d disk_path ] -a
	 -a delete all devices, -n delete specified device
./miniublk list [-n dev_id] -a
	 -a list all devices, -n list specified device, default -a

ublk depends on liburing 2.2, so allow to ignore ublk build failure
in case of missing liburing, and we will check if ublk program exits
inside test.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 Makefile            |    2 +-
 src/Makefile        |   13 +-
 src/ublk/miniublk.c | 1385 +++++++++++++++++++++++++++++++++++++++++++
 src/ublk/ublk_cmd.h |  278 +++++++++
 4 files changed, 1674 insertions(+), 4 deletions(-)
 create mode 100644 src/ublk/miniublk.c
 create mode 100644 src/ublk/ublk_cmd.h

diff --git a/Makefile b/Makefile
index 5a04479..b9bbade 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@ prefix ?= /usr/local
 dest = $(DESTDIR)$(prefix)/blktests
 
 all:
-	$(MAKE) -C src all
+	$(MAKE) -i -C src all
 
 clean:
 	$(MAKE) -C src clean
diff --git a/src/Makefile b/src/Makefile
index 3b587f6..83e8a62 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -13,23 +13,27 @@ C_TARGETS := \
 	sg/syzkaller1 \
 	zbdioctl
 
+C_MINIUBLK := ublk/miniublk
+
 CXX_TARGETS := \
 	discontiguous-io
 
 TARGETS := $(C_TARGETS) $(CXX_TARGETS)
+ALL_TARGETS := $(TARGETS) $(C_MINIUBLK)
 
 CONFIG_DEFS := $(call HAVE_C_HEADER,linux/blkzoned.h,-DHAVE_LINUX_BLKZONED_H)
 
 override CFLAGS   := -O2 -Wall -Wshadow $(CFLAGS) $(CONFIG_DEFS)
 override CXXFLAGS := -O2 -std=c++11 -Wall -Wextra -Wshadow -Wno-sign-compare \
 		     -Werror $(CXXFLAGS) $(CONFIG_DEFS)
+MINIUBLK_FLAGS :=  -D_GNU_SOURCE -lpthread -luring
 
-all: $(TARGETS)
+all: $(ALL_TARGETS)
 
 clean:
-	rm -f $(TARGETS)
+	rm -f $(ALL_TARGETS)
 
-install: $(TARGETS)
+install: $(ALL_TARGETS)
 	install -m755 -d $(dest)
 	install $(TARGETS) $(dest)
 
@@ -39,4 +43,7 @@ $(C_TARGETS): %: %.c
 $(CXX_TARGETS): %: %.cpp
 	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ $^
 
+$(C_MINIUBLK): %: ublk/miniublk.c
+	$(CC) $(CFLAGS) $(MINIUBLK_FLAGS) -o $@ ublk/miniublk.c
+
 .PHONY: all clean install
diff --git a/src/ublk/miniublk.c b/src/ublk/miniublk.c
new file mode 100644
index 0000000..dc80246
--- /dev/null
+++ b/src/ublk/miniublk.c
@@ -0,0 +1,1385 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (C) 2023 Ming Lei
+
+/*
+ * io_uring based mini ublk implementation with null/loop target,
+ * for test purpose only.
+ *
+ * So please keep it simple & reliable.
+ */
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <assert.h>
+#include <stdio.h>
+#include <stdarg.h>
+#include <string.h>
+#include <pthread.h>
+#include <getopt.h>
+#include <limits.h>
+#include <sys/syscall.h>
+#include <sys/mman.h>
+#include <sys/ioctl.h>
+#include <liburing.h>
+#include <ublk_cmd.h>
+
+#define CTRL_DEV		"/dev/ublk-control"
+#define UBLKC_DEV		"/dev/ublkc"
+#define UBLK_CTRL_RING_DEPTH            32
+
+#define UBLK_IO_MAX_BYTES               65536
+#define UBLK_MAX_QUEUES                 4
+#define UBLK_QUEUE_DEPTH                128
+
+#define UBLKC_PATH_MAX        32
+
+#define UBLK_MAX_TGTS			4
+
+#define UBLK_DBG_DEV            (1U << 0)
+#define UBLK_DBG_QUEUE          (1U << 1)
+#define UBLK_DBG_IO_CMD         (1U << 2)
+#define UBLK_DBG_IO             (1U << 3)
+#define UBLK_DBG_CTRL_CMD       (1U << 4)
+#define UBLK_LOG		(1U << 5)
+
+#define UBLKSRV_IO_IDLE_SECS    20
+#define UBLK_DEV_MAX_NAME_LEN 512
+
+struct ublk_dev;
+struct ublk_queue;
+
+struct ublk_ctrl_cmd_data {
+	unsigned short cmd_op;
+#define CTRL_CMD_HAS_DATA	1
+#define CTRL_CMD_HAS_BUF	2
+	unsigned short flags;
+
+	__u64 data[2];
+	__u64 addr;
+	__u32 len;
+};
+
+struct ublk_io {
+	char *buf_addr;
+
+#define UBLKSRV_NEED_FETCH_RQ		(1UL << 0)
+#define UBLKSRV_NEED_COMMIT_RQ_COMP	(1UL << 1)
+#define UBLKSRV_IO_FREE			(1UL << 2)
+	unsigned int flags;
+
+	unsigned int result;
+};
+
+struct ublk_tgt_ops {
+	const char *name;
+	int (*init_tgt)(struct ublk_dev *);
+	void (*deinit_tgt)(struct ublk_dev *);
+
+	int (*queue_io)(struct ublk_queue *, int tag);
+	void (*tgt_io_done)(struct ublk_queue *,
+			int tag, const struct io_uring_cqe *);
+};
+
+struct ublk_tgt {
+	unsigned long dev_size;
+	const struct ublk_tgt_ops *ops;
+	int argc;
+	char **argv;
+	struct ublk_params params;
+};
+
+struct ublk_queue {
+	int q_id;
+	int q_depth;
+	unsigned int cmd_inflight;
+	struct ublk_dev *dev;
+	const struct ublk_tgt_ops *tgt_ops;
+	char *io_cmd_buf;
+	struct io_uring ring;
+	struct ublk_io ios[UBLK_QUEUE_DEPTH];
+#define UBLKSRV_QUEUE_STOPPING	(1U << 0)
+#define UBLKSRV_QUEUE_IDLE	(1U << 1)
+	unsigned state;
+	int tid;
+	pthread_t thread;
+};
+
+struct ublk_dev {
+	struct ublk_tgt tgt;
+	struct ublksrv_ctrl_dev_info  dev_info;
+	struct ublk_queue q[UBLK_MAX_QUEUES];
+
+	int fds[2];
+	int nr_fds;
+	int ctrl_fd;
+	int cdev_fd;
+	struct io_uring ring;
+};
+
+#ifndef offsetof
+#define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)
+#endif
+
+#ifndef container_of
+#define container_of(ptr, type, member) ({                              \
+	unsigned long __mptr = (unsigned long)(ptr);                    \
+	((type *)(__mptr - offsetof(type, member))); })
+#endif
+
+#define round_up(val, rnd) \
+	(((val) + ((rnd) - 1)) & ~((rnd) - 1))
+
+#define ublk_assert(x)  do { \
+	if (!(x)) {     \
+		ublk_err("%s %d: assert!\n", __func__, __LINE__); \
+		assert(x);      \
+	}       \
+} while (0)
+
+static const struct ublk_tgt_ops *ublk_find_tgt(const char *name);
+
+static unsigned int ublk_dbg_mask = UBLK_LOG;
+
+static inline unsigned ilog2(unsigned x)
+{
+    return sizeof(unsigned) * 8 - 1 - __builtin_clz(x);
+}
+
+static inline int is_target_io(__u64 user_data)
+{
+	return (user_data & (1ULL << 63)) != 0;
+}
+
+static inline __u64 build_user_data(unsigned tag, unsigned op,
+		unsigned tgt_data, unsigned is_target_io)
+{
+	assert(!(tag >> 16) && !(op >> 8) && !(tgt_data >> 16));
+
+	return tag | (op << 16) | (tgt_data << 24) | (__u64)is_target_io << 63;
+}
+
+static inline unsigned int user_data_to_tag(__u64 user_data)
+{
+	return user_data & 0xffff;
+}
+
+static inline unsigned int user_data_to_op(__u64 user_data)
+{
+	return (user_data >> 16) & 0xff;
+}
+
+static void ublk_err(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+}
+
+static void ublk_log(const char *fmt, ...)
+{
+	if (ublk_dbg_mask & UBLK_LOG) {
+		va_list ap;
+
+		va_start(ap, fmt);
+		vfprintf(stdout, fmt, ap);
+	}
+}
+
+static void ublk_dbg(int level, const char *fmt, ...)
+{
+	if (level & ublk_dbg_mask) {
+		va_list ap;
+		va_start(ap, fmt);
+		vfprintf(stdout, fmt, ap);
+        }
+}
+
+static inline void *ublk_get_sqe_cmd(const struct io_uring_sqe *sqe)
+{
+	return (void *)&sqe->addr3;
+}
+
+static inline void ublk_mark_io_done(struct ublk_io *io, int res)
+{
+	io->flags |= (UBLKSRV_NEED_COMMIT_RQ_COMP | UBLKSRV_IO_FREE);
+	io->result = res;
+}
+
+static inline const struct ublksrv_io_desc *ublk_get_iod(
+                const struct ublk_queue *q, int tag)
+{
+        return (struct ublksrv_io_desc *)
+                &(q->io_cmd_buf[tag * sizeof(struct ublksrv_io_desc)]);
+}
+
+static inline void ublk_set_sqe_cmd_op(struct io_uring_sqe *sqe,
+		__u32 cmd_op)
+{
+        __u32 *addr = (__u32 *)&sqe->off;
+
+        addr[0] = cmd_op;
+        addr[1] = 0;
+}
+
+static inline int ublk_setup_ring(struct io_uring *r, int depth,
+		int cq_depth, unsigned flags)
+{
+	struct io_uring_params p;
+
+	memset(&p, 0, sizeof(p));
+	p.flags = flags | IORING_SETUP_CQSIZE;
+	p.cq_entries = cq_depth;
+
+	return io_uring_queue_init_params(depth, r, &p);
+}
+
+static inline void ublk_ctrl_init_cmd(struct ublk_dev *dev,
+		struct io_uring_sqe *sqe,
+		struct ublk_ctrl_cmd_data *data)
+{
+	struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
+	struct ublksrv_ctrl_cmd *cmd = (struct ublksrv_ctrl_cmd *)ublk_get_sqe_cmd(sqe);
+
+	sqe->fd = dev->ctrl_fd;
+	sqe->opcode = IORING_OP_URING_CMD;
+	sqe->ioprio = 0;
+
+	if (data->flags & CTRL_CMD_HAS_BUF) {
+		cmd->addr = data->addr;
+		cmd->len = data->len;
+	}
+
+	if (data->flags & CTRL_CMD_HAS_DATA)
+		cmd->data[0] = data->data[0];
+
+	cmd->dev_id = info->dev_id;
+	cmd->queue_id = -1;
+
+	ublk_set_sqe_cmd_op(sqe, data->cmd_op);
+
+	io_uring_sqe_set_data(sqe, cmd);
+}
+
+static int __ublk_ctrl_cmd(struct ublk_dev *dev,
+		struct ublk_ctrl_cmd_data *data)
+{
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
+	int ret = -EINVAL;
+
+	sqe = io_uring_get_sqe(&dev->ring);
+	if (!sqe) {
+		ublk_err("%s: can't get sqe ret %d\n", __func__, ret);
+		return ret;
+	}
+
+	ublk_ctrl_init_cmd(dev, sqe, data);
+
+	ret = io_uring_submit(&dev->ring);
+	if (ret < 0) {
+		ublk_err("uring submit ret %d\n", ret);
+		return ret;
+	}
+
+	ret = io_uring_wait_cqe(&dev->ring, &cqe);
+	if (ret < 0) {
+		ublk_err("wait cqe: %s\n", strerror(-ret));
+		return ret;
+	}
+	io_uring_cqe_seen(&dev->ring, cqe);
+
+	return cqe->res;
+}
+
+int ublk_ctrl_stop_dev(struct ublk_dev *dev)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_CMD_STOP_DEV,
+	};
+	int ret;
+
+	ret = __ublk_ctrl_cmd(dev, &data);
+	return ret;
+}
+
+int ublk_ctrl_start_dev(struct ublk_dev *dev,
+		int daemon_pid)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_CMD_START_DEV,
+		.flags	= CTRL_CMD_HAS_DATA,
+	};
+	int ret;
+
+	dev->dev_info.ublksrv_pid = data.data[0] = daemon_pid;
+
+	ret = __ublk_ctrl_cmd(dev, &data);
+
+	return ret;
+}
+
+int ublk_ctrl_add_dev(struct ublk_dev *dev)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_CMD_ADD_DEV,
+		.flags	= CTRL_CMD_HAS_BUF,
+		.addr = (__u64)&dev->dev_info,
+		.len = sizeof(struct ublksrv_ctrl_dev_info),
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+int ublk_ctrl_del_dev(struct ublk_dev *dev)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op = UBLK_CMD_DEL_DEV,
+		.flags = 0,
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+int ublk_ctrl_get_info(struct ublk_dev *dev)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_CMD_GET_DEV_INFO,
+		.flags	= CTRL_CMD_HAS_BUF,
+		.addr = (__u64)&dev->dev_info,
+		.len = sizeof(struct ublksrv_ctrl_dev_info),
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+int ublk_ctrl_set_params(struct ublk_dev *dev,
+		struct ublk_params *params)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_CMD_SET_PARAMS,
+		.flags	= CTRL_CMD_HAS_BUF,
+		.addr = (__u64)params,
+		.len = sizeof(*params),
+	};
+	params->len = sizeof(*params);
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+static int ublk_ctrl_get_params(struct ublk_dev *dev,
+		struct ublk_params *params)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_CMD_GET_PARAMS,
+		.flags	= CTRL_CMD_HAS_BUF,
+		.addr = (__u64)params,
+		.len = sizeof(*params),
+	};
+	int ret;
+
+	params->len = sizeof(*params);
+
+	ret = __ublk_ctrl_cmd(dev, &data);
+	return ret;
+}
+
+static const char *ublk_dev_state_desc(struct ublk_dev *dev)
+{
+	switch (dev->dev_info.state) {
+	case UBLK_S_DEV_DEAD:
+		return "DEAD";
+	case UBLK_S_DEV_LIVE:
+		return "LIVE";
+	case UBLK_S_DEV_QUIESCED:
+		return "QUIESCED";
+	default:
+		return "UNKNOWN";
+	};
+}
+
+static void ublk_ctrl_dump(struct ublk_dev *dev)
+{
+	struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
+	int i, ret;
+	struct ublk_params p;
+
+	ret = ublk_ctrl_get_params(dev, &p);
+	if (ret < 0) {
+		ublk_err("failed to get params %m\n");
+		return;
+	}
+
+	if (!(ublk_dbg_mask & UBLK_LOG)) {
+		fprintf(stdout, "%s%d\n", "/dev/ublkb", info->dev_id);
+		goto out;
+	}
+
+	ublk_log("dev id %d: nr_hw_queues %d queue_depth %d block size %d dev_capacity %lld\n",
+			info->dev_id,
+                        info->nr_hw_queues, info->queue_depth,
+                        1 << p.basic.logical_bs_shift, p.basic.dev_sectors);
+	ublk_log("\tmax rq size %d daemon pid %d flags 0x%llx state %s\n",
+                        info->max_io_buf_bytes,
+			info->ublksrv_pid, info->flags,
+			ublk_dev_state_desc(dev));
+	ublk_log("\tublkc: %u:%d ublkb: %u:%u owner: %u:%u\n",
+			p.devt.char_major, p.devt.char_minor,
+			p.devt.disk_major, p.devt.disk_minor,
+			info->owner_uid, info->owner_gid);
+	for (i = 0; i < dev->dev_info.nr_hw_queues; i++)
+		ublk_log("\tqueue 0 tid: %d\n", dev->q[i].tid);
+out:
+	fflush(stdout);
+}
+
+static void ublk_ctrl_deinit(struct ublk_dev *dev)
+{
+	close(dev->ctrl_fd);
+	free(dev);
+}
+
+static struct ublk_dev *ublk_ctrl_init()
+{
+	struct ublk_dev *dev = (struct ublk_dev *)calloc(1, sizeof(*dev));
+	struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
+	int ret;
+
+	dev->ctrl_fd = open(CTRL_DEV, O_RDWR);
+	if (dev->ctrl_fd < 0) {
+		ublk_err("control dev %s can't be opened: %m\n", CTRL_DEV);
+		exit(dev->ctrl_fd);
+	}
+	info->max_io_buf_bytes = UBLK_IO_MAX_BYTES;
+
+	ret = ublk_setup_ring(&dev->ring, 32, 32, IORING_SETUP_SQE128);
+	if (ret < 0) {
+		ublk_err("queue_init: %s\n", strerror(-ret));
+		free(dev);
+		return NULL;
+	}
+	dev->nr_fds = 1;
+
+	return dev;
+}
+
+static int ublk_queue_cmd_buf_sz(struct ublk_queue *q)
+{
+	int size =  q->q_depth * sizeof(struct ublksrv_io_desc);
+	unsigned int page_sz = getpagesize();
+
+	return round_up(size, page_sz);
+}
+
+static void ublk_queue_deinit(struct ublk_queue *q)
+{
+	int i;
+	int nr_ios = q->q_depth;
+
+	io_uring_unregister_ring_fd(&q->ring);
+
+	if (q->ring.ring_fd > 0) {
+		io_uring_unregister_files(&q->ring);
+		close(q->ring.ring_fd);
+		q->ring.ring_fd = -1;
+	}
+
+	if (q->io_cmd_buf)
+		munmap(q->io_cmd_buf, ublk_queue_cmd_buf_sz(q));
+
+	for (i = 0; i < nr_ios; i++)
+		free(q->ios[i].buf_addr);
+}
+
+static int ublk_queue_init(struct ublk_queue *q)
+{
+	struct ublk_dev *dev = q->dev;
+	int depth = dev->dev_info.queue_depth;
+	int i, ret = -1;
+	int cmd_buf_size, io_buf_size;
+	unsigned long off;
+	int ring_depth = depth, cq_depth = depth;
+
+	q->tgt_ops = dev->tgt.ops;
+	q->state = 0;
+	q->q_depth = depth;
+	q->cmd_inflight = 0;
+	q->tid = gettid();
+
+	cmd_buf_size = ublk_queue_cmd_buf_sz(q);
+	off = UBLKSRV_CMD_BUF_OFFSET +
+		q->q_id * (UBLK_MAX_QUEUE_DEPTH * sizeof(struct ublksrv_io_desc));
+	q->io_cmd_buf = (char *)mmap(0, cmd_buf_size, PROT_READ,
+			MAP_SHARED | MAP_POPULATE, dev->fds[0], off);
+	if (q->io_cmd_buf == MAP_FAILED) {
+		ublk_err("ublk dev %d queue %d map io_cmd_buf failed\n",
+				q->dev->dev_info.dev_id, q->q_id);
+		goto fail;
+	}
+
+	io_buf_size = dev->dev_info.max_io_buf_bytes;
+	for (i = 0; i < q->q_depth; i++) {
+		q->ios[i].buf_addr = NULL;
+
+		if (posix_memalign((void **)&q->ios[i].buf_addr,
+					getpagesize(), io_buf_size)) {
+			ublk_err("ublk dev %d queue %d io %d posix_memalign failed\n",
+					dev->dev_info.dev_id, q->q_id, i);
+			goto fail;
+		}
+		q->ios[i].flags = UBLKSRV_NEED_FETCH_RQ | UBLKSRV_IO_FREE;
+	}
+
+	ret = ublk_setup_ring(&q->ring, ring_depth, cq_depth,
+			IORING_SETUP_SQE128 | IORING_SETUP_COOP_TASKRUN);
+	if (ret < 0) {
+		ublk_err("ublk dev %d queue %d setup io_uring failed %d\n",
+				q->dev->dev_info.dev_id, q->q_id, ret);
+		goto fail;
+	}
+
+	io_uring_register_ring_fd(&q->ring);
+
+	ret = io_uring_register_files(&q->ring, dev->fds, dev->nr_fds);
+	if (ret) {
+		ublk_err("ublk dev %d queue %d register files failed %d\n",
+				q->dev->dev_info.dev_id, q->q_id, ret);
+		goto fail;
+	}
+
+	return 0;
+ fail:
+	ublk_queue_deinit(q);
+	ublk_err("ublk dev %d queue %d failed\n",
+			dev->dev_info.dev_id, q->q_id);
+	return -ENOMEM;
+}
+
+static int ublk_dev_prep(struct ublk_dev *dev)
+{
+	int dev_id = dev->dev_info.dev_id;
+	char buf[64];
+	int ret;
+
+	dev->cdev_fd = -1;
+
+	snprintf(buf, 64, "%s%d", UBLKC_DEV, dev_id);
+	dev->fds[0] = open(buf, O_RDWR);
+	if (dev->fds[0] < 0) {
+		ret = -EBADF;
+		ublk_err("can't open %s, ret %d\n", buf, dev->fds[0]);
+		goto fail;
+	}
+
+	if (dev->tgt.ops->init_tgt)
+		ret = dev->tgt.ops->init_tgt(dev);
+	else
+		ret = 0;
+
+	return ret;
+fail:
+	close(dev->fds[0]);
+	return ret;
+}
+
+static void ublk_dev_unprep(struct ublk_dev *dev)
+{
+	if (dev->tgt.ops->deinit_tgt)
+		dev->tgt.ops->deinit_tgt(dev);
+	close(dev->fds[0]);
+}
+
+static int ublk_queue_io_cmd(struct ublk_queue *q,
+		struct ublk_io *io, unsigned tag)
+{
+	struct ublksrv_io_cmd *cmd;
+	struct io_uring_sqe *sqe;
+	unsigned int cmd_op = 0;
+	__u64 user_data;
+
+	/* only freed io can be issued */
+	if (!(io->flags & UBLKSRV_IO_FREE))
+		return 0;
+
+	/* we issue because we need either fetching or committing */
+	if (!(io->flags &
+		(UBLKSRV_NEED_FETCH_RQ | UBLKSRV_NEED_COMMIT_RQ_COMP)))
+		return 0;
+
+	if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
+		cmd_op = UBLK_IO_COMMIT_AND_FETCH_REQ;
+	else if (io->flags & UBLKSRV_NEED_FETCH_RQ)
+		cmd_op = UBLK_IO_FETCH_REQ;
+
+	sqe = io_uring_get_sqe(&q->ring);
+	if (!sqe) {
+		ublk_err("%s: run out of sqe %d, tag %d\n",
+				__func__, q->q_id, tag);
+		return -1;
+	}
+
+	cmd = (struct ublksrv_io_cmd *)ublk_get_sqe_cmd(sqe);
+
+	if (cmd_op == UBLK_IO_COMMIT_AND_FETCH_REQ)
+		cmd->result = io->result;
+
+	/* These fields should be written once, never change */
+	ublk_set_sqe_cmd_op(sqe, cmd_op);
+	sqe->fd		= 0;	/*dev->cdev_fd*/
+	sqe->opcode	=  IORING_OP_URING_CMD;
+	sqe->flags	= IOSQE_FIXED_FILE;
+	sqe->rw_flags	= 0;
+	cmd->tag	= tag;
+	cmd->addr	= (__u64)io->buf_addr;
+	cmd->q_id	= q->q_id;
+
+	user_data = build_user_data(tag, cmd_op, 0, 0);
+	io_uring_sqe_set_data64(sqe, user_data);
+
+	io->flags = 0;
+
+	q->cmd_inflight += 1;
+
+	ublk_dbg(UBLK_DBG_IO_CMD, "%s: (qid %d tag %u cmd_op %u) iof %x stopping %d\n",
+			__func__, q->q_id, tag, cmd_op,
+			io->flags, !!(q->state & UBLKSRV_QUEUE_STOPPING));
+	return 1;
+}
+
+static int ublk_complete_io(struct ublk_queue *q,
+		unsigned tag, int res)
+{
+	struct ublk_io *io = &q->ios[tag];
+
+	ublk_mark_io_done(io, res);
+
+	return ublk_queue_io_cmd(q, io, tag);
+}
+
+static void ublk_submit_fetch_commands(struct ublk_queue *q)
+{
+	int i = 0;
+
+	for (i = 0; i < q->q_depth; i++)
+		ublk_queue_io_cmd(q, &q->ios[i], i);
+}
+
+static int ublk_queue_is_done(struct ublk_queue *q)
+{
+	return (q->state & UBLKSRV_QUEUE_STOPPING) &&
+		!io_uring_sq_ready(&q->ring);
+}
+
+static void ublk_queue_discard_io_pages(struct ublk_queue *q)
+{
+	const struct ublk_dev *dev = q->dev;
+	unsigned int io_buf_size = dev->dev_info.max_io_buf_bytes;
+	int i = 0;
+
+	for (i = 0; i < q->q_depth; i++)
+		madvise(q->ios[i].buf_addr, io_buf_size, MADV_DONTNEED);
+}
+
+static void ublk_queue_idle_enter(struct ublk_queue *q)
+{
+	if (q->state & UBLKSRV_QUEUE_IDLE)
+		return;
+
+	ublk_dbg(UBLK_DBG_QUEUE, "dev%d-q%d: enter idle %x\n",
+			q->dev->dev_info.dev_id, q->q_id, q->state);
+	ublk_queue_discard_io_pages(q);
+	q->state |= UBLKSRV_QUEUE_IDLE;
+}
+
+static void ublk_queue_idle_exit(struct ublk_queue *q)
+{
+	if (q->state & UBLKSRV_QUEUE_IDLE) {
+		ublk_dbg(UBLK_DBG_QUEUE, "dev%d-q%d: exit idle %x\n",
+			q->dev->dev_info.dev_id, q->q_id, q->state);
+		q->state &= ~UBLKSRV_QUEUE_IDLE;
+	}
+}
+
+static inline void ublksrv_handle_tgt_cqe(struct ublk_queue *q,
+		struct io_uring_cqe *cqe)
+{
+	unsigned tag = user_data_to_tag(cqe->user_data);
+
+	if (cqe->res < 0 && cqe->res != -EAGAIN)
+		ublk_err("%s: failed tgt io: res %d qid %u tag %u, cmd_op %u\n",
+			__func__, cqe->res, q->q_id,
+			user_data_to_tag(cqe->user_data),
+			user_data_to_op(cqe->user_data));
+
+	if (q->tgt_ops->tgt_io_done)
+		q->tgt_ops->tgt_io_done(q, tag, cqe);
+}
+
+static void ublk_handle_cqe(struct io_uring *r,
+		struct io_uring_cqe *cqe, void *data)
+{
+	struct ublk_queue *q = container_of(r, struct ublk_queue, ring);
+	unsigned tag = user_data_to_tag(cqe->user_data);
+	unsigned cmd_op = user_data_to_op(cqe->user_data);
+	int fetch = (cqe->res != UBLK_IO_RES_ABORT) &&
+		!(q->state & UBLKSRV_QUEUE_STOPPING);
+	struct ublk_io *io;
+
+	ublk_dbg(UBLK_DBG_IO_CMD, "%s: res %d (qid %d tag %u cmd_op %u target %d) stopping %d\n",
+			__func__, cqe->res, q->q_id, tag, cmd_op,
+			is_target_io(cqe->user_data),
+			(q->state & UBLKSRV_QUEUE_STOPPING));
+
+	/* Don't retrieve io in case of target io */
+	if (is_target_io(cqe->user_data)) {
+		ublksrv_handle_tgt_cqe(q, cqe);
+		return;
+	}
+
+	io = &q->ios[tag];
+	q->cmd_inflight--;
+
+	if (!fetch) {
+		q->state |= UBLKSRV_QUEUE_STOPPING;
+		io->flags &= ~UBLKSRV_NEED_FETCH_RQ;
+	}
+
+	if (cqe->res == UBLK_IO_RES_OK) {
+		ublk_assert(tag < q->q_depth);
+		q->tgt_ops->queue_io(q, tag);
+	} else {
+		/*
+		 * COMMIT_REQ will be completed immediately since no fetching
+		 * piggyback is required.
+		 *
+		 * Marking IO_FREE only, then this io won't be issued since
+		 * we only issue io with (UBLKSRV_IO_FREE | UBLKSRV_NEED_*)
+		 *
+		 * */
+		io->flags = UBLKSRV_IO_FREE;
+	}
+}
+
+static int ublk_reap_events_uring(struct io_uring *r)
+{
+	struct io_uring_cqe *cqe;
+	unsigned head;
+	int count = 0;
+
+	io_uring_for_each_cqe(r, head, cqe) {
+		ublk_handle_cqe(r, cqe, NULL);
+		count += 1;
+	}
+	io_uring_cq_advance(r, count);
+
+	return count;
+}
+
+static int ublk_process_io(struct ublk_queue *q)
+{
+	int ret, reapped;
+	struct __kernel_timespec ts = {
+		.tv_sec = UBLKSRV_IO_IDLE_SECS,
+		.tv_nsec = 0
+        };
+	struct __kernel_timespec *tsp = (q->state & UBLKSRV_QUEUE_IDLE) ?
+		NULL : &ts;
+	struct io_uring_cqe *cqe;
+
+	ublk_dbg(UBLK_DBG_QUEUE, "dev%d-q%d: to_submit %d inflight cmd %u stopping %d\n",
+				q->dev->dev_info.dev_id,
+				q->q_id, io_uring_sq_ready(&q->ring),
+				q->cmd_inflight,
+				(q->state & UBLKSRV_QUEUE_STOPPING));
+
+	if (ublk_queue_is_done(q))
+		return -ENODEV;
+
+	ret = io_uring_submit_and_wait_timeout(&q->ring, &cqe, 1, tsp, NULL);
+	reapped = ublk_reap_events_uring(&q->ring);
+
+	ublk_dbg(UBLK_DBG_QUEUE, "submit result %d, reapped %d stop %d idle %d",
+			ret, reapped, (q->state & UBLKSRV_QUEUE_STOPPING),
+			(q->state & UBLKSRV_QUEUE_IDLE));
+
+	if (!(q->state & UBLKSRV_QUEUE_STOPPING)) {
+		if (ret == -ETIME && reapped == 0 &&
+				!io_uring_sq_ready(&q->ring))
+			ublk_queue_idle_enter(q);
+		else
+			ublk_queue_idle_exit(q);
+	}
+	return reapped;
+}
+
+static void *ublk_io_handler_fn(void *data)
+{
+	struct ublk_queue *q = data;
+	int dev_id = q->dev->dev_info.dev_id;
+	int ret;
+
+	ret = ublk_queue_init(q);
+	if (ret) {
+		ublk_err("ublk dev %d queue %d init queue failed\n",
+				dev_id, q->q_id);
+		return NULL;
+	}
+
+	/* submit all io commands to ublk driver */
+	ublk_submit_fetch_commands(q);
+
+	ublk_dbg(UBLK_DBG_QUEUE, "tid %d: ublk dev %d queue %d started\n",
+			gettid(),
+			dev_id, q->q_id);
+	do {
+		if (ublk_process_io(q) < 0)
+			break;
+	} while (1);
+
+	ublk_dbg(UBLK_DBG_QUEUE, "ublk dev %d queue %d exited\n", dev_id, q->q_id);
+	ublk_queue_deinit(q);
+	return NULL;
+}
+
+static void ublk_set_parameters(struct ublk_dev *dev)
+{
+	int ret;
+
+	ret = ublk_ctrl_set_params(dev, &dev->tgt.params);
+	if (ret)
+		ublk_err("dev %d set basic parameter failed %d\n",
+				dev->dev_info.dev_id, ret);
+}
+
+static int ublk_start_daemon(struct ublk_dev *dev)
+{
+	int ret, i;
+	void *thread_ret;
+	const struct ublksrv_ctrl_dev_info *dinfo = &dev->dev_info;
+
+	ret = ublk_dev_prep(dev);
+	if (!dev)
+		return -ENOMEM;
+
+	for (i = 0; i < dinfo->nr_hw_queues; i++) {
+		dev->q[i].dev = dev;
+		dev->q[i].q_id = i;
+		pthread_create(&dev->q[i].thread, NULL,
+				ublk_io_handler_fn,
+				&dev->q[i]);
+	}
+
+	ublk_set_parameters(dev);
+
+	/* everything is fine now, start us */
+	ret = ublk_ctrl_start_dev(dev, getpid());
+	if (ret < 0)
+		goto fail;
+
+	ublk_ctrl_get_info(dev);
+	ublk_ctrl_dump(dev);
+
+	daemon(1, 1);
+
+	/* wait until we are terminated */
+	for (i = 0; i < dinfo->nr_hw_queues; i++)
+		pthread_join(dev->q[i].thread, &thread_ret);
+ fail:
+	ublk_dev_unprep(dev);
+
+	return ret;
+}
+
+static int cmd_dev_add(int argc, char *argv[])
+{
+	static const struct option longopts[] = {
+		{ "type",		1,	NULL, 't' },
+		{ "number",		1,	NULL, 'n' },
+		{ "queues",		1,	NULL, 'q' },
+		{ "depth",		1,	NULL, 'd' },
+		{ "debug_mask",	1,	NULL, 0},
+		{ "quiet",	0,	NULL, 0},
+		{ NULL }
+	};
+	const struct ublk_tgt_ops *ops;
+	struct ublksrv_ctrl_dev_info *info;
+	struct ublk_dev *dev;
+	int ret, option_idx, opt;
+	const char *tgt_type = NULL;
+	int dev_id = -1;
+	unsigned nr_queues = 2, depth = UBLK_QUEUE_DEPTH;
+
+	while ((opt = getopt_long(argc, argv, "-:t:n:d:q:",
+				  longopts, &option_idx)) != -1) {
+		switch (opt) {
+		case 'n':
+			dev_id = strtol(optarg, NULL, 10);
+			break;
+		case 't':
+			tgt_type = optarg;
+			break;
+		case 'q':
+			nr_queues = strtol(optarg, NULL, 10);
+			break;
+		case 'd':
+			depth = strtol(optarg, NULL, 10);
+			break;
+		case 0:
+			if (!strcmp(longopts[option_idx].name, "debug_mask"))
+				ublk_dbg_mask = strtol(optarg, NULL, 16);
+			if (!strcmp(longopts[option_idx].name, "quiet"))
+				ublk_dbg_mask = 0;
+			break;
+		}
+	}
+
+	optind = 0;
+
+	ops = ublk_find_tgt(tgt_type);
+	if (!ops) {
+		ublk_err("%s: no such tgt type, type %s\n",
+				__func__, tgt_type);
+		return -ENODEV;
+	}
+
+	if (nr_queues > UBLK_MAX_QUEUES || depth > UBLK_QUEUE_DEPTH) {
+		ublk_err("%s: invalid nr_queues or depth queues %u depth %u\n",
+				__func__, nr_queues, depth);
+		return -EINVAL;
+	}
+
+	dev = ublk_ctrl_init();
+	if (!dev) {
+		ublk_err("%s: can't alloc dev id %d, type %s\n",
+				__func__, dev_id, tgt_type);
+		return -ENOMEM;
+	}
+
+	info = &dev->dev_info;
+	info->dev_id = dev_id;
+        info->nr_hw_queues = nr_queues;
+        info->queue_depth = depth;
+	dev->tgt.ops = ops;
+	dev->tgt.argc = argc;
+	dev->tgt.argv = argv;
+
+	ret = ublk_ctrl_add_dev(dev);
+	if (ret < 0) {
+		ublk_err("%s: can't add dev id %d, type %s ret %d\n",
+				__func__, dev_id, tgt_type, ret);
+		goto fail;
+	}
+
+	ret = ublk_start_daemon(dev);
+	if (ret < 0) {
+		ublk_err("%s: can't start daemon id %d, type %s\n",
+				__func__, dev_id, tgt_type);
+		goto fail_del;
+	}
+
+	return ret;
+fail_del:
+	ublk_ctrl_del_dev(dev);
+fail:
+	ublk_ctrl_deinit(dev);
+	return ret;
+}
+
+static int ublk_stop_io_daemon(const struct ublk_dev *dev)
+{
+	int daemon_pid = dev->dev_info.ublksrv_pid;
+	int cnt = 0, ret;
+
+	/* wait until daemon is exited, or timeout after 3 seconds */
+	do {
+		ret = kill(daemon_pid, 0);
+		if (!ret) {
+			usleep(100000);
+			cnt++;
+		}
+	} while (!ret && cnt < 30);
+
+	return ret != 0 ? 0 : -1;
+}
+
+static int __cmd_dev_del(int number, bool log)
+{
+	struct ublk_dev *dev;
+	int ret;
+
+	dev = ublk_ctrl_init();
+	dev->dev_info.dev_id = number;
+
+	ret = ublk_ctrl_get_info(dev);
+	if (ret < 0) {
+		goto fail;
+	}
+
+	ret = ublk_ctrl_stop_dev(dev);
+	if (ret < 0) {
+		if (log)
+			ublk_err("stop dev %d failed\n", number);
+		goto fail;
+	}
+
+	ret = ublk_stop_io_daemon(dev);
+	if (ret < 0) {
+		if (log)
+			ublk_err("stop daemon %d failed\n", number);
+	}
+
+	ret = ublk_ctrl_del_dev(dev);
+	if (ret < 0) {
+		if (log)
+			ublk_err("delete dev %d failed\n", number);
+		goto fail;
+	}
+
+fail:
+	ublk_ctrl_deinit(dev);
+	return ret;
+}
+
+static int cmd_dev_del(int argc, char *argv[])
+{
+	static const struct option longopts[] = {
+		{ "number",		1,	NULL, 'n' },
+		{ "all",		0,	NULL, 'a' },
+		{ "disk",		1,	NULL, 'd' },
+		{ NULL }
+	};
+	int number = -2;
+	int opt, i;
+	char buf[UBLK_DEV_MAX_NAME_LEN];
+
+	while ((opt = getopt_long(argc, argv, "n:a",
+				  longopts, NULL)) != -1) {
+		switch (opt) {
+		case 'a':
+			number = -1;
+			break;
+
+		case 'n':
+			number = strtol(optarg, NULL, 10);
+			break;
+		case 'd':
+			if (strlen(optarg) > UBLK_DEV_MAX_NAME_LEN)
+				return -EINVAL;
+			sscanf(&optarg[5], "%5s%d", buf, &number);
+			if (strcmp(buf, "ublkb"))
+				return -EINVAL;
+			if (number < 0)
+				return -EINVAL;
+		}
+	}
+
+	if (number >= 0)
+		return __cmd_dev_del(number, true);
+	else if (number != -1) {
+		ublk_err("%s: pass wrong devid or not delete via -a\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < 255; i++)
+		__cmd_dev_del(i, false);
+
+	return 0;
+}
+
+static int __cmd_dev_list(int number, bool log)
+{
+	struct ublk_dev *dev = ublk_ctrl_init();
+	int ret;
+
+	dev->dev_info.dev_id = number;
+
+	ret = ublk_ctrl_get_info(dev);
+	if (ret < 0) {
+		if (log)
+			ublk_err("%s: can't get dev info from %d: %d\n",
+					__func__, number, ret);
+	} else {
+		ublk_ctrl_dump(dev);
+	}
+
+	ublk_ctrl_deinit(dev);
+
+	return ret;
+}
+
+
+static int cmd_dev_list(int argc, char *argv[])
+{
+	static const struct option longopts[] = {
+		{ "number",		1,	NULL, 'n' },
+		{ "all",		0,	NULL, 'a' },
+		{ NULL }
+	};
+	int number = -1;
+	int opt, i;
+
+	while ((opt = getopt_long(argc, argv, "n:a",
+				  longopts, NULL)) != -1) {
+		switch (opt) {
+		case 'a':
+			break;
+
+		case 'n':
+			number = strtol(optarg, NULL, 10);
+			break;
+		}
+	}
+
+	if (number >= 0)
+		return __cmd_dev_list(number, true);
+
+	for (i = 0; i < 255; i++)
+		__cmd_dev_list(i, false);
+
+	return 0;
+}
+
+static int cmd_dev_help(int argc, char *argv[])
+{
+	printf("%s add -t {null|loop} [-q nr_queues] [-d depth] [-n dev_id] \n",
+			argv[0]);
+	printf("\t default: nr_queues=2(max 4), depth=128(max 128), dev_id=-1(auto allocation)\n");
+	printf("\t -t loop -f backing_file \n");
+	printf("\t -t null\n");
+	printf("%s del [-n dev_id] -a \n", argv[0]);
+	printf("\t -a delete all devices, -n delete specified device\n");
+	printf("%s list [-n dev_id] -a \n", argv[0]);
+	printf("\t -a list all devices, -n list specified device, default -a \n");
+
+	return 0;
+}
+
+static int ublk_null_tgt_init(struct ublk_dev *dev)
+{
+	const struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
+	unsigned long dev_size = 250UL << 30;
+
+	dev->tgt.dev_size = dev_size;
+	dev->tgt.params = (struct ublk_params) {
+		.types = UBLK_PARAM_TYPE_BASIC,
+		.basic = {
+			.logical_bs_shift	= 9,
+			.physical_bs_shift	= 12,
+			.io_opt_shift		= 12,
+			.io_min_shift		= 9,
+			.max_sectors		= info->max_io_buf_bytes >> 9,
+			.dev_sectors		= dev_size >> 9,
+		},
+	};
+
+	return 0;
+}
+
+static int ublk_null_queue_io(struct ublk_queue *q, int tag)
+{
+	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
+
+	ublk_complete_io(q, tag, iod->nr_sectors << 9);
+
+	return 0;
+}
+
+static int loop_queue_tgt_io(struct ublk_queue *q, int tag)
+{
+	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
+	struct io_uring_sqe *sqe = io_uring_get_sqe(&q->ring);
+	unsigned ublk_op = ublksrv_get_op(iod);
+
+	if (!sqe)
+		return -ENOMEM;
+
+	switch (ublk_op) {
+	case UBLK_IO_OP_FLUSH:
+		io_uring_prep_sync_file_range(sqe, 1 /*fds[1]*/,
+				iod->nr_sectors << 9,
+				iod->start_sector << 9,
+				IORING_FSYNC_DATASYNC);
+		io_uring_sqe_set_flags(sqe, IOSQE_FIXED_FILE);
+		break;
+	case UBLK_IO_OP_WRITE_ZEROES:
+	case UBLK_IO_OP_DISCARD:
+		return -ENOTSUP;
+	case UBLK_IO_OP_READ:
+		io_uring_prep_read(sqe, 1 /*fds[1]*/,
+				(void *)iod->addr,
+				iod->nr_sectors << 9,
+				iod->start_sector << 9);
+		io_uring_sqe_set_flags(sqe, IOSQE_FIXED_FILE);
+		break;
+	case UBLK_IO_OP_WRITE:
+		io_uring_prep_write(sqe, 1 /*fds[1]*/,
+				(void *)iod->addr,
+				iod->nr_sectors << 9,
+				iod->start_sector << 9);
+		io_uring_sqe_set_flags(sqe, IOSQE_FIXED_FILE);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* bit63 marks us as tgt io */
+	sqe->user_data = build_user_data(tag, ublk_op, 0, 1);
+
+	ublk_dbg(UBLK_DBG_IO, "%s: tag %d ublk io %x %llx %u\n", __func__, tag,
+			iod->op_flags, iod->start_sector, iod->nr_sectors << 9);
+	return 1;
+}
+
+static int ublk_loop_queue_io(struct ublk_queue *q, int tag)
+{
+	int queued = loop_queue_tgt_io(q, tag);
+
+	if (queued < 0)
+		ublk_complete_io(q, tag, queued);
+
+	return 0;
+}
+
+static void ublk_loop_io_done(struct ublk_queue *q, int tag,
+		const struct io_uring_cqe *cqe)
+{
+	int cqe_tag = user_data_to_tag(cqe->user_data);
+
+	ublk_assert(tag == cqe_tag);
+	ublk_complete_io(q, tag, cqe->res);
+}
+
+static void ublk_loop_tgt_deinit(struct ublk_dev *dev)
+{
+	fsync(dev->fds[1]);
+	close(dev->fds[1]);
+}
+
+static int ublk_loop_tgt_init(struct ublk_dev *dev)
+{
+	static const struct option lo_longopts[] = {
+		{ "file",		1,	NULL, 'f' },
+		{ NULL }
+	};
+	unsigned long long bytes;
+	char **argv = dev->tgt.argv;
+	int argc = dev->tgt.argc;
+	char *file = NULL;
+	struct stat st;
+	int fd, opt;
+	struct ublk_params p = {
+		.types = UBLK_PARAM_TYPE_BASIC,
+		.basic = {
+			.logical_bs_shift	= 9,
+			.physical_bs_shift	= 12,
+			.io_opt_shift	= 12,
+			.io_min_shift	= 9,
+			.max_sectors = dev->dev_info.max_io_buf_bytes >> 9,
+		},
+	};
+
+	while ((opt = getopt_long(argc, argv, "-:f:",
+				  lo_longopts, NULL)) != -1) {
+		switch (opt) {
+		case 'f':
+			file = strdup(optarg);
+			break;
+		}
+	}
+
+	ublk_dbg(UBLK_DBG_DEV, "%s: file %s\n", __func__, file);
+
+	if (!file)
+		return -EINVAL;
+
+	fd = open(file, O_RDWR);
+	if (fd < 0) {
+		ublk_err( "%s: backing file %s can't be opened\n",
+				__func__, file);
+		return -EBADF;
+	}
+
+	if (fstat(fd, &st) < 0) {
+		close(fd);
+		return -EBADF;
+	}
+
+	if (S_ISBLK(st.st_mode)) {
+		unsigned int bs, pbs;
+
+		if (ioctl(fd, BLKGETSIZE64, &bytes) != 0)
+			return -EBADF;
+		if (ioctl(fd, BLKSSZGET, &bs) != 0)
+			return -1;
+		if (ioctl(fd, BLKPBSZGET, &pbs) != 0)
+			return -1;
+		p.basic.logical_bs_shift = ilog2(bs);
+		p.basic.physical_bs_shift = ilog2(pbs);
+	} else if (S_ISREG(st.st_mode)) {
+		bytes = st.st_size;
+	} else {
+		bytes = 0;
+	}
+
+	if (fcntl(fd, F_SETFL, O_DIRECT)) {
+		p.basic.logical_bs_shift = 9;
+		p.basic.physical_bs_shift = 12;
+	}
+
+	dev->tgt.dev_size = bytes;
+	p.basic.dev_sectors = bytes >> 9;
+	dev->fds[1] = fd;
+	dev->nr_fds += 1;
+	dev->tgt.params = p;
+
+	return 0;
+}
+
+const struct ublk_tgt_ops tgt_ops_list[] = {
+	{
+		.name = "null",
+		.init_tgt = ublk_null_tgt_init,
+		.queue_io = ublk_null_queue_io,
+	},
+
+	{
+		.name = "loop",
+		.init_tgt = ublk_loop_tgt_init,
+		.deinit_tgt = ublk_loop_tgt_deinit,
+		.queue_io = ublk_loop_queue_io,
+		.tgt_io_done = ublk_loop_io_done,
+	},
+};
+
+static const struct ublk_tgt_ops *ublk_find_tgt(const char *name)
+{
+	const struct ublk_tgt_ops *ops;
+	int i;
+
+	if (name == NULL)
+		return NULL;
+
+	for (i = 0; sizeof(tgt_ops_list) / sizeof(*ops); i++)
+		if (strcmp(tgt_ops_list[i].name, name) == 0)
+			return &tgt_ops_list[i];
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	const char *cmd = argv[1];
+	int ret = -EINVAL;
+
+	if (!strcmp(cmd, "add"))
+		ret = cmd_dev_add(argc, argv);
+	else if (!strcmp(cmd, "del"))
+		ret = cmd_dev_del(argc, argv);
+	else if (!strcmp(cmd, "list"))
+		ret = cmd_dev_list(argc, argv);
+	else if (!strcmp(cmd, "help"))
+		ret = cmd_dev_help(argc, argv);
+
+	if (ret)
+		cmd_dev_help(argc, argv);
+
+	return ret;
+}
diff --git a/src/ublk/ublk_cmd.h b/src/ublk/ublk_cmd.h
new file mode 100644
index 0000000..f6238cc
--- /dev/null
+++ b/src/ublk/ublk_cmd.h
@@ -0,0 +1,278 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef USER_BLK_DRV_CMD_INC_H
+#define USER_BLK_DRV_CMD_INC_H
+
+#include <linux/types.h>
+
+/* ublk server command definition */
+
+/*
+ * Admin commands, issued by ublk server, and handled by ublk driver.
+ */
+#define	UBLK_CMD_GET_QUEUE_AFFINITY	0x01
+#define	UBLK_CMD_GET_DEV_INFO	0x02
+#define	UBLK_CMD_ADD_DEV		0x04
+#define	UBLK_CMD_DEL_DEV		0x05
+#define	UBLK_CMD_START_DEV	0x06
+#define	UBLK_CMD_STOP_DEV	0x07
+#define	UBLK_CMD_SET_PARAMS	0x08
+#define	UBLK_CMD_GET_PARAMS	0x09
+#define	UBLK_CMD_START_USER_RECOVERY	0x10
+#define	UBLK_CMD_END_USER_RECOVERY	0x11
+#define	UBLK_CMD_GET_DEV_INFO2		0x12
+
+/*
+ * IO commands, issued by ublk server, and handled by ublk driver.
+ *
+ * FETCH_REQ: issued via sqe(URING_CMD) beforehand for fetching IO request
+ *      from ublk driver, should be issued only when starting device. After
+ *      the associated cqe is returned, request's tag can be retrieved via
+ *      cqe->userdata.
+ *
+ * COMMIT_AND_FETCH_REQ: issued via sqe(URING_CMD) after ublkserver handled
+ *      this IO request, request's handling result is committed to ublk
+ *      driver, meantime FETCH_REQ is piggyback, and FETCH_REQ has to be
+ *      handled before completing io request.
+ *
+ * NEED_GET_DATA: only used for write requests to set io addr and copy data
+ *      When NEED_GET_DATA is set, ublksrv has to issue UBLK_IO_NEED_GET_DATA
+ *      command after ublk driver returns UBLK_IO_RES_NEED_GET_DATA.
+ *
+ *      It is only used if ublksrv set UBLK_F_NEED_GET_DATA flag
+ *      while starting a ublk device.
+ */
+#define	UBLK_IO_FETCH_REQ		0x20
+#define	UBLK_IO_COMMIT_AND_FETCH_REQ	0x21
+#define	UBLK_IO_NEED_GET_DATA	0x22
+
+/* only ABORT means that no re-fetch */
+#define UBLK_IO_RES_OK			0
+#define UBLK_IO_RES_NEED_GET_DATA	1
+#define UBLK_IO_RES_ABORT		(-ENODEV)
+
+#define UBLKSRV_CMD_BUF_OFFSET	0
+#define UBLKSRV_IO_BUF_OFFSET	0x80000000
+
+/* tag bit is 12bit, so at most 4096 IOs for each queue */
+#define UBLK_MAX_QUEUE_DEPTH	4096
+
+/*
+ * zero copy requires 4k block size, and can remap ublk driver's io
+ * request into ublksrv's vm space
+ */
+#define UBLK_F_SUPPORT_ZERO_COPY	(1ULL << 0)
+
+/*
+ * Force to complete io cmd via io_uring_cmd_complete_in_task so that
+ * performance comparison is done easily with using task_work_add
+ */
+#define UBLK_F_URING_CMD_COMP_IN_TASK	(1ULL << 1)
+
+/*
+ * User should issue io cmd again for write requests to
+ * set io buffer address and copy data from bio vectors
+ * to the userspace io buffer.
+ *
+ * In this mode, task_work is not used.
+ */
+#define UBLK_F_NEED_GET_DATA (1UL << 2)
+
+#define UBLK_F_USER_RECOVERY	(1UL << 3)
+
+#define UBLK_F_USER_RECOVERY_REISSUE	(1UL << 4)
+
+/*
+ * Unprivileged user can create /dev/ublkcN and /dev/ublkbN.
+ *
+ * /dev/ublk-control needs to be available for unprivileged user, and it
+ * can be done via udev rule to make all control commands available to
+ * unprivileged user. Except for the command of UBLK_CMD_ADD_DEV, all
+ * other commands are only allowed for the owner of the specified device.
+ *
+ * When userspace sends UBLK_CMD_ADD_DEV, the device pair's owner_uid and
+ * owner_gid are stored to ublksrv_ctrl_dev_info by kernel, so far only
+ * the current user's uid/gid is stored, that said owner of the created
+ * device is always the current user.
+ *
+ * We still need udev rule to apply OWNER/GROUP with the stored owner_uid
+ * and owner_gid.
+ *
+ * Then ublk server can be run as unprivileged user, and /dev/ublkbN can
+ * be accessed and managed by its owner represented by owner_uid/owner_gid.
+ */
+#define UBLK_F_UNPRIVILEGED_DEV	(1UL << 5)
+
+/* device state */
+#define UBLK_S_DEV_DEAD	0
+#define UBLK_S_DEV_LIVE	1
+#define UBLK_S_DEV_QUIESCED	2
+
+/* shipped via sqe->cmd of io_uring command */
+struct ublksrv_ctrl_cmd {
+	/* sent to which device, must be valid */
+	__u32	dev_id;
+
+	/* sent to which queue, must be -1 if the cmd isn't for queue */
+	__u16	queue_id;
+	/*
+	 * cmd specific buffer, can be IN or OUT.
+	 */
+	__u16	len;
+	__u64	addr;
+
+	/* inline data */
+	__u64	data[1];
+
+	/*
+	 * Used for UBLK_F_UNPRIVILEGED_DEV and UBLK_CMD_GET_DEV_INFO2
+	 * only, include null char
+	 */
+	__u16	dev_path_len;
+	__u16	pad;
+	__u32	reserved;
+};
+
+struct ublksrv_ctrl_dev_info {
+	__u16	nr_hw_queues;
+	__u16	queue_depth;
+	__u16	state;
+	__u16	pad0;
+
+	__u32	max_io_buf_bytes;
+	__u32	dev_id;
+
+	__s32	ublksrv_pid;
+	__u32	pad1;
+
+	__u64	flags;
+
+	/* For ublksrv internal use, invisible to ublk driver */
+	__u64	ublksrv_flags;
+
+	__u32	owner_uid;	/* store by kernel */
+	__u32	owner_gid;	/* store by kernel */
+	__u64	reserved1;
+	__u64   reserved2;
+};
+
+#define		UBLK_IO_OP_READ		0
+#define		UBLK_IO_OP_WRITE		1
+#define		UBLK_IO_OP_FLUSH		2
+#define		UBLK_IO_OP_DISCARD	3
+#define		UBLK_IO_OP_WRITE_SAME	4
+#define		UBLK_IO_OP_WRITE_ZEROES	5
+
+#define		UBLK_IO_F_FAILFAST_DEV		(1U << 8)
+#define		UBLK_IO_F_FAILFAST_TRANSPORT	(1U << 9)
+#define		UBLK_IO_F_FAILFAST_DRIVER	(1U << 10)
+#define		UBLK_IO_F_META			(1U << 11)
+#define		UBLK_IO_F_FUA			(1U << 13)
+#define		UBLK_IO_F_NOUNMAP		(1U << 15)
+#define		UBLK_IO_F_SWAP			(1U << 16)
+
+/*
+ * io cmd is described by this structure, and stored in share memory, indexed
+ * by request tag.
+ *
+ * The data is stored by ublk driver, and read by ublksrv after one fetch command
+ * returns.
+ */
+struct ublksrv_io_desc {
+	/* op: bit 0-7, flags: bit 8-31 */
+	__u32		op_flags;
+
+	__u32		nr_sectors;
+
+	/* start sector for this io */
+	__u64		start_sector;
+
+	/* buffer address in ublksrv daemon vm space, from ublk driver */
+	__u64		addr;
+};
+
+static inline __u8 ublksrv_get_op(const struct ublksrv_io_desc *iod)
+{
+	return iod->op_flags & 0xff;
+}
+
+static inline __u32 ublksrv_get_flags(const struct ublksrv_io_desc *iod)
+{
+	return iod->op_flags >> 8;
+}
+
+/* issued to ublk driver via /dev/ublkcN */
+struct ublksrv_io_cmd {
+	__u16	q_id;
+
+	/* for fetch/commit which result */
+	__u16	tag;
+
+	/* io result, it is valid for COMMIT* command only */
+	__s32	result;
+
+	/*
+	 * userspace buffer address in ublksrv daemon process, valid for
+	 * FETCH* command only
+	 */
+	__u64	addr;
+};
+
+struct ublk_param_basic {
+#define UBLK_ATTR_READ_ONLY            (1 << 0)
+#define UBLK_ATTR_ROTATIONAL           (1 << 1)
+#define UBLK_ATTR_VOLATILE_CACHE       (1 << 2)
+#define UBLK_ATTR_FUA                  (1 << 3)
+	__u32	attrs;
+	__u8	logical_bs_shift;
+	__u8	physical_bs_shift;
+	__u8	io_opt_shift;
+	__u8	io_min_shift;
+
+	__u32	max_sectors;
+	__u32	chunk_sectors;
+
+	__u64   dev_sectors;
+	__u64   virt_boundary_mask;
+};
+
+struct ublk_param_discard {
+	__u32	discard_alignment;
+
+	__u32	discard_granularity;
+	__u32	max_discard_sectors;
+
+	__u32	max_write_zeroes_sectors;
+	__u16	max_discard_segments;
+	__u16	reserved0;
+};
+
+/*
+ * read-only, can't set via UBLK_CMD_SET_PARAMS, disk_devt is available
+ * after device is started
+ */
+struct ublk_param_devt {
+	__u32   char_major;
+	__u32   char_minor;
+	__u32   disk_major;
+	__u32   disk_minor;
+};
+
+struct ublk_params {
+	/*
+	 * Total length of parameters, userspace has to set 'len' for both
+	 * SET_PARAMS and GET_PARAMS command, and driver may update len
+	 * if two sides use different version of 'ublk_params', same with
+	 * 'types' fields.
+	 */
+	__u32	len;
+#define UBLK_PARAM_TYPE_BASIC           (1 << 0)
+#define UBLK_PARAM_TYPE_DISCARD         (1 << 1)
+#define UBLK_PARAM_TYPE_DEVT            (1 << 2)
+	__u32	types;			/* types of parameter included */
+
+	struct ublk_param_basic		basic;
+	struct ublk_param_discard	discard;
+	struct ublk_param_devt		devt;
+};
+
+#endif
-- 
2.31.1

