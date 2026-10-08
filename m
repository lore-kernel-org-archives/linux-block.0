Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165DB36F914
	for <linux-block@vger.kernel.org>; Thu,  8 Oct 2026 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429460; cv=none; b=LgrnET5O5mhbha3BMt0+EeToas80xTeNHnCyDDEzOtT58MzaX3XpBTwQI/YIwkTy58PtBEjkdXlQxyoBVDCtSExJbuOngqd/iKhoLu1r9ONeE8AmzrwVzBa4sjYnoCZtTib/WsoPda9D362SXJXhZ191/jKEewBF5u38/ZjGK+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429460; c=relaxed/simple;
	bh=5oXFHZiNjK6+JCQ4bbNGLRfkNxgbRr8G3SVmcTZpvyY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h/kb4nti2WRUUjsBi/bTFLeNkxpAF8RgfQ2jWarphfb5MGJ6qrWgXeM36dZmlF8v7K4oJkmDIU4GM+0XtSmWcAibhaVsxdGjykgbiJY41svxtxCHohsKN/2EskrpIPMvxl9Jqc4Ln2yP73j75SFtFnnDJDmE1E2Ins3i3V9JZOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RT23i8BI; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RT23i8BI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=uo
	ACNr0Jcf0C3z1t+ue2OZhf3ecjkLKBBRk7KWQPF0c=; b=RT23i8BIfDETjgYCIB
	XJgjULvgTxb8UUsGykxxJtvHuScOu9yUvDcrJDeg6CCiVCHl9m70F9UZRR4/RMye
	d6IJSZNyhC+Gi2G9oKlnyBQXQXSplibYSoiyqNLjVtPNJKS2s7HtiiCb9LxN7Tcj
	WqOtRilC6p1QshOaW59+JQ1MA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD33+g8C8dqODi9DA--.41456S2;
	Thu, 08 Oct 2026 11:17:17 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH blktests v2] block/049: test polled dio with user PI metadata
Date: Thu,  8 Oct 2026 11:17:14 +0800
Message-Id: <20261008031714.529202-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33+g8C8dqODi9DA--.41456S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar4DXFyUCr45JF45GrW3KFg_yoW7uF47p3
	y0qFyrGrZ7KrnrWF93CF43uFy5Aa18Cay7JFZF934jvr13Za42yF4xKF15XF98XrWfW3y5
	Aw4vqFWqkr4UXa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UU-BiUUUUU=
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwR1e7mrHCz1EQAAA3z

IOPOLL combined with a PI attribute used to leave iocb->private as a
uio_meta and oops in bio_poll(). The kernel rejects that combination
with -EOPNOTSUPP. Add a scsi_debug reproducer that expects this result.

Assisted-by: LLM
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
---
v2:
- Resend now that 2a42e6fe1293 ("block: reject polled dio with user
  integrity metadata") is in Linus' tree.
- Add the copyright in src/metadata-iopoll.c.
- Use _have_loadable_scsi_debug instead of "_have_module scsi_debug".
- Skip kernels without IORING_FEAT_RW_ATTR.

v1: https://lore.kernel.org/linux-block/20260924025526.298050-1-yangxiuwei@kylinos.cn/

 src/Makefile          |   1 +
 src/metadata-iopoll.c | 112 ++++++++++++++++++++++++++++++++++++++++++
 tests/block/049       |  56 +++++++++++++++++++++
 tests/block/049.out   |   2 +
 4 files changed, 171 insertions(+)
 create mode 100644 src/metadata-iopoll.c
 create mode 100755 tests/block/049
 create mode 100644 tests/block/049.out

diff --git a/src/Makefile b/src/Makefile
index dd64694..1e571c6 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -31,6 +31,7 @@ C_TARGETS := \
 	zbdioctl
 
 C_URING_TARGETS := metadata \
+	metadata-iopoll \
 	nvme-passthru-admin-uring
 C_UBLK_TARGETS := miniublk
 
diff --git a/src/metadata-iopoll.c b/src/metadata-iopoll.c
new file mode 100644
index 0000000..a452b04
--- /dev/null
+++ b/src/metadata-iopoll.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-3.0+
+// Copyright (C) 2026 Yang Xiuwei <yangxiuwei@kylinos.cn>
+/*
+ * IOPOLL direct read with a PI attribute. The fixed kernel completes it
+ * with -EOPNOTSUPP.
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <liburing.h>
+
+#ifndef IORING_RW_ATTR_FLAG_PI
+#define PI_URING_COMPAT
+#define IORING_RW_ATTR_FLAG_PI (1U << 0)
+struct io_uring_attr_pi {
+	__u16 flags;
+	__u16 app_tag;
+	__u32 len;
+	__u64 addr;
+	__u64 seed;
+	__u64 rsvd;
+};
+#endif
+
+#ifndef IO_INTEGRITY_CHK_GUARD
+#define IO_INTEGRITY_CHK_GUARD  (1U << 0)
+#define IO_INTEGRITY_CHK_REFTAG (1U << 1)
+#endif
+
+#ifndef IORING_FEAT_RW_ATTR
+#define IORING_FEAT_RW_ATTR	(1U << 16)
+#endif
+
+#define DATA_LEN 4096
+#define META_LEN 64
+
+static void on_alarm(int sig)
+{
+	(void)sig;
+	dprintf(STDERR_FILENO, "timed out\n");
+	_exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	struct io_uring ring;
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
+	struct io_uring_attr_pi pi = {
+		.flags = IO_INTEGRITY_CHK_GUARD | IO_INTEGRITY_CHK_REFTAG,
+		.len = META_LEN,
+		.seed = 1,
+	};
+	void *data, *meta;
+	int fd, ret;
+
+	if (argc != 2)
+		return 1;
+
+	signal(SIGALRM, on_alarm);
+	alarm(10);
+
+	fd = open(argv[1], O_RDONLY | O_DIRECT);
+	if (fd < 0) {
+		perror("open");
+		return 1;
+	}
+	if (posix_memalign(&data, 4096, DATA_LEN) ||
+	    posix_memalign(&meta, 4096, META_LEN)) {
+		perror("posix_memalign");
+		return 1;
+	}
+	pi.addr = (__u64)(uintptr_t)meta;
+
+	ret = io_uring_queue_init(8, &ring, IORING_SETUP_IOPOLL);
+	if (ret < 0) {
+		fprintf(stderr, "queue_init: %s\n", strerror(-ret));
+		return 1;
+	}
+	if (!(ring.features & IORING_FEAT_RW_ATTR))
+		return 2;
+	sqe = io_uring_get_sqe(&ring);
+	if (!sqe)
+		return 1;
+	io_uring_prep_read(sqe, fd, data, DATA_LEN, 0);
+#ifdef PI_URING_COMPAT
+	sqe->__pad2[0] = IORING_RW_ATTR_FLAG_PI;
+	sqe->addr3 = (__u64)&pi;
+#else
+	sqe->attr_type_mask = IORING_RW_ATTR_FLAG_PI;
+	sqe->attr_ptr = (__u64)&pi;
+#endif
+	ret = io_uring_submit(&ring);
+	if (ret < 1) {
+		fprintf(stderr, "submit: %d\n", ret);
+		return 1;
+	}
+	ret = io_uring_wait_cqe(&ring, &cqe);
+	if (ret < 0) {
+		fprintf(stderr, "wait: %s\n", strerror(-ret));
+		return 1;
+	}
+	if (cqe->res != -EOPNOTSUPP) {
+		fprintf(stderr, "cqe %d\n", cqe->res);
+		return 1;
+	}
+	return 0;
+}
diff --git a/tests/block/049 b/tests/block/049
new file mode 100755
index 0000000..5ceefbe
--- /dev/null
+++ b/tests/block/049
@@ -0,0 +1,56 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Yang Xiuwei <yangxiuwei@kylinos.cn>
+#
+# IOPOLL combined with a PI attribute used to oops in bio_poll(). The kernel
+# rejects that combination with -EOPNOTSUPP.
+#
+# Regression test for kernel commit 2a42e6fe1293 ("block: reject polled dio
+# with user integrity metadata").
+#
+# Kernels without IORING_FEAT_RW_ATTR are skipped. Kernels that advertise the
+# feature but lack 2a42e6fe1293 oops in bio_poll().
+
+. tests/block/rc
+. common/scsi_debug
+
+DESCRIPTION="iopoll dio with user PI metadata returns -EOPNOTSUPP"
+QUICK=1
+
+requires() {
+	_have_kernel_option IO_URING
+	_have_kernel_option BLK_DEV_INTEGRITY
+	_have_loadable_scsi_debug
+	_have_src_program metadata-iopoll
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	if ! _init_scsi_debug dif=1 dix=1 dev_size_mb=64 sector_size=512 \
+			submit_queues=2 poll_queues=1; then
+		return 1
+	fi
+
+	local dev="${SCSI_DEBUG_DEVICES[0]}"
+
+	if [[ "$(<"/sys/block/${dev}/queue/io_poll")" != 1 ]]; then
+		SKIP_REASONS+=("scsi_debug has no poll queue")
+		_exit_scsi_debug
+		return
+	fi
+
+	src/metadata-iopoll "/dev/${dev}" >>"$FULL" 2>&1
+	local rc=$?
+
+	_exit_scsi_debug
+	if ((rc == 2)); then
+		SKIP_REASONS+=("io_uring PI attributes not supported")
+		return
+	fi
+	if ((rc)); then
+		echo "metadata-iopoll failed"
+		return 1
+	fi
+	echo "Test complete"
+}
diff --git a/tests/block/049.out b/tests/block/049.out
new file mode 100644
index 0000000..c88edfe
--- /dev/null
+++ b/tests/block/049.out
@@ -0,0 +1,2 @@
+Running block/049
+Test complete
-- 
2.25.1

