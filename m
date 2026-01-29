Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D119ABC6
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769654293; cv=none; b=olxeAWYq1u/dahjGG5Tes65eXerKF0qIC2vxXILQ03qEav6PpqOWDtGQW4ZjsOxWLHMcdccfuaPMRqZ55WKdTZa3o/IrsAISKR2zJC6nU04aAbRRK29rqsfH7ofWwzKGgB+X/V3xxSutcSaLgaRNiR9+jdkpycUcY/t9xw3QLpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769654293; c=relaxed/simple;
	bh=nuCZern0A1BLKVtHgI/TYv/Qfi7vDUCbKeSVFFJv5LQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pSAnsGob1toXuavewbbBbnDhOynsBmogl9IEnaWk07UREVeihnt1yg4TMymnAVkb/wg6wKhPm7S4T1xACmYBVDTwUlvMKK9knefXOrUM5W2bidthLzPa7P1UZxUOzRmC0gpfC22pDZlneD9Jm3YPOYaqEeSTOvxSz5ga8iGXouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxXiDe/0; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxXiDe/0"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7942fca0da6so4176207b3.3
        for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 18:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769654290; x=1770259090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AW04mo6flZtJtoW67l3fXxLzAFNyt4xmSM/HN5J0cR4=;
        b=ZxXiDe/0jhWUoPVePAQBwA+wPr6jcoLRU/W41J1LV/b0ohYiDxOVoIHaNoUjJgVVya
         Xs/bRbecnYlhJjW0fAdcMz5Sn+JIzA/cgqkMHEyd8lnkfoEcAEE0iGXvUi2SXWsLj81q
         UAoCDxnslRk3hWEo8I5UY0WVJL5RYllm7oew3nbmkxzOPN7luVqjlzL52W0Y2jSyWexI
         OOWS0QY91NIUe7/aqqnVXxCbzEL1jst6lQTU/yB7K76dqRYecs2Vk3HFTo9ppedM/0RM
         8XI9WfmjCKzOp4MMJxSJONUX7n2+zxcWoSPJBIY8MUWQ4vHkcfI1oa+j/J/m44dv2NrU
         uQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769654290; x=1770259090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AW04mo6flZtJtoW67l3fXxLzAFNyt4xmSM/HN5J0cR4=;
        b=OpncLcPJqfHcStBAxgFArIiFszuVCfKJTc3dGcsJ1j6yxclWp2zO/hHBVHNTZzfLWM
         JCKCz/nlTbPvUds1xNvArIaBdiHluO+N7dF0t28cS+qJPF2nepeQyC+ML1zqG9Z+wqJv
         MhQ6F5ftQdNommOc6ZwrxezQBQPvWnY7D4lvkKFwv3KR6tQTGgJ9cns9ZH8ifamY2koQ
         nk9cq5QaCJOQYheP2nQOi+KDX4l2Fmn/pfSOliN9AkpL2cRF2pjPpmXlxlA2V5El6ZHq
         kZt4qnzeXgPZyaZJX+lssi78//MVAbnbF0n6lICRI5Eh2dgQINTmHRwJZS6vPZM3clLo
         GGLA==
X-Gm-Message-State: AOJu0YyrahmOBjCXkiKgRiYP63F1lbHXZKByI8wG6cey6IoJAh11u+hU
	uT2AckF9fQFZ2l4OnrkZM2GCF4U1IjjvKOv+00OQWuFDATOyf06HmKzskAARhHhw
X-Gm-Gg: AZuq6aIv6j7YWzhv3gIN9Lv6fhAEZpK+j7plEKqpj0smdJ7dL7r1NABAH5KmAgwyJRx
	KxDPFVl/hPnjNPIsqbVMVc4MkN5NEHkwFAFLso6wWy4o9D/XsAwFwelW9jHwvH0/fuQhio08cD/
	rQW/VUvP5pMhO2mCe10Re2zPck00DSi66ZOLzcQqvrnyBcW0VrfwdC0eSCP6MP4OjLOyjiPKaYP
	w3Ts8p3ZnfZjeOWsw53U6dKO/2s9FbIzSz7QY708JEkn/mnxxUl4AWFMr7IwLcZOFCO7XyRs1uT
	r4E6AjX3/SDS187VL1Pt+kuDnr4n8Z7rzWF26r+BlshayYiFZ+Aj9hLS/8Ehx88LYzISVOyFaI4
	9Bzs92o1UpC4df0gZUisxQFPwUe/iLovGxtKwaqa+ImXJf7EZVurmiKe6ivRQMGaMepnh/czgjS
	+OhpNhVtrAhm2vVoliOuaroaSyH0BQ2yaXwJ8=
X-Received: by 2002:a05:690c:5a8f:b0:794:7184:a634 with SMTP id 00721157ae682-7947abfae6cmr46448707b3.36.1769654290267;
        Wed, 28 Jan 2026 18:38:10 -0800 (PST)
Received: from 5163NRD-SPRABHU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79482789221sm18724527b3.15.2026.01.28.18.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 18:38:09 -0800 (PST)
From: sw.prabhu6@gmail.com
To: linux-block@vger.kernel.org,
	shinichiro.kawasaki@wdc.com
Cc: vincentfu@gmail.com,
	joshi.k@samsung.com,
	Swarna Prabhu <s.prabhu@samsung.com>
Subject: [PATCH blktests] nvme/067: test io_uring pass through for NVMe admin queue
Date: Wed, 28 Jan 2026 18:37:54 -0800
Message-Id: <20260129023754.685508-1-sw.prabhu6@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Swarna Prabhu <s.prabhu@samsung.com>

Simple test to excersie the nvme admin commands usage with
io uring passthrough interfaces.

Signed-off-by: Swarna Prabhu <s.prabhu@samsung.com>
---
 src/Makefile                 |  3 +-
 src/nvme-passthrough-admin.c | 94 ++++++++++++++++++++++++++++++++++++
 tests/nvme/067               | 27 +++++++++++
 tests/nvme/067.out           |  2 +
 4 files changed, 125 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 src/Makefile
 create mode 100755 src/nvme-passthrough-admin.c
 create mode 100755 tests/nvme/067
 create mode 100755 tests/nvme/067.out

diff --git a/src/Makefile b/src/Makefile
old mode 100644
new mode 100755
index dac07c7..0cb8d4e
--- a/src/Makefile
+++ b/src/Makefile
@@ -23,7 +23,8 @@ C_TARGETS := \
 	zbdioctl
 
 C_URING_TARGETS := miniublk \
-		metadata
+		metadata \
+		nvme-passthrough-admin
 
 HAVE_LIBURING := $(call HAVE_C_MACRO,liburing.h,IORING_OP_URING_CMD)
 HAVE_UBLK_HEADER := $(call HAVE_C_HEADER,linux/ublk_cmd.h,1)
diff --git a/src/nvme-passthrough-admin.c b/src/nvme-passthrough-admin.c
new file mode 100755
index 0000000..ef5c241
--- /dev/null
+++ b/src/nvme-passthrough-admin.c
@@ -0,0 +1,94 @@
+/*
+ * Simple test exercising the admin queue accesses via  io_uring passthrough
+ * commands.
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <liburing.h>
+#include <linux/nvme_ioctl.h>
+
+#define NVME_IDENTIFY_ADMIN_CMD 0x06     /*Identify command using admin queue */
+#define NVME_IDENTIFY_CNS_CTRL 0x01    /*Identify controller command to a NVME device*/
+struct nvme_id_ctrl {
+           __le16 vid;
+           __le16 ssvid;
+           char sn[20];
+           char mn[40];
+           char fr[8];
+           __u8 rab;
+           __u8 ieee[3];
+	   char pad[4020];
+};
+
+int main(int argc, char **argv)
+{
+	int fd, ret;
+	struct nvme_passthru_cmd *cmd;
+	struct nvme_id_ctrl *nctrl;
+	struct io_uring nvring;
+	int queue_depth = 80;
+	struct io_uring_sqe *sqe = NULL;
+	struct io_uring_cqe *cqe = NULL;
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s /dev/nvmeXnY", argv[0]);
+		return -EINVAL;
+	}
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0) {
+		perror("open");
+		return -errno;
+	}
+
+	nctrl = (struct nvme_id_ctrl *)calloc(1, sizeof(struct nvme_id_ctrl));
+	if (!nctrl) {
+		fprintf(stderr, "Memory allocation failure\n");
+		return -ENOMEM;
+	}
+
+	ret = io_uring_queue_init(queue_depth, &nvring, IORING_SETUP_SQE128 | IORING_SETUP_CQE32);
+	if (ret < 0) {
+		fprintf(stderr, "Initialize io uring fail %d \n", ret);
+		return ret;
+	}
+	/* Prepare the SQE to use the IORING_OP_URING_CMD opcode */
+	sqe = io_uring_get_sqe(&nvring);
+	sqe->fd = fd;
+	sqe->opcode = IORING_OP_URING_CMD;
+	sqe->cmd_op = NVME_URING_CMD_ADMIN;
+
+	cmd = (struct nvme_passthru_cmd *)&sqe->cmd;
+	memset(cmd, 0, sizeof(*cmd));
+
+	/* populate the cmd struct for the opcode */
+	cmd->opcode = NVME_IDENTIFY_ADMIN_CMD;
+	cmd->addr = (__u64)(uintptr_t)nctrl;
+	cmd->data_len = sizeof(struct nvme_id_ctrl);
+	cmd->cdw10 = NVME_IDENTIFY_CNS_CTRL;
+
+	/*submit the SQE */
+	io_uring_submit(&nvring);
+
+	ret = io_uring_wait_cqe(&nvring, &cqe);
+
+	if (ret < 0) {
+		fprintf(stderr, "wait_cqe: %s\n", strerror(-ret));
+	} else if (cqe && cqe->res < 0) {
+		fprintf(stderr, "Command failed (cqe->res): %d\n", cqe->res);
+		ret = cqe->res;
+	} else {
+		ret = 0;
+	}
+
+	if (cqe)
+		io_uring_cqe_seen(&nvring, cqe);
+	io_uring_queue_exit(&nvring);
+	close(fd);
+	free(nctrl);
+
+	return ret;
+}
\ No newline at end of file
diff --git a/tests/nvme/067 b/tests/nvme/067
new file mode 100755
index 0000000..8c273fa
--- /dev/null
+++ b/tests/nvme/067
@@ -0,0 +1,27 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Test out admin commands through the io uring passthrough interfaces.
+
+. tests/nvme/rc
+
+requires() {
+	_nvme_requires
+	_have_kernel_option IO_URING
+}
+
+DESCRIPTION="exercise the nvme admin commands usage with io uring passthrough interfaces"
+QUICK=1
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	# extract the ctrl dev from the test dev
+	devname=${TEST_DEV#/dev/}
+	ctrl_dev="/dev/${devname%n*}"
+
+	if ! sudo src/nvme-passthrough-admin "${ctrl_dev}"; then
+		echo "src/nvme-passthrough-admin failed"
+	fi
+
+	echo "Test Complete"
+}
diff --git a/tests/nvme/067.out b/tests/nvme/067.out
new file mode 100755
index 0000000..c56866e
--- /dev/null
+++ b/tests/nvme/067.out
@@ -0,0 +1,2 @@
+Running nvme/067
+Test Complete
-- 
2.39.5

