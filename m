Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B66302CD9
	for <linux-block@vger.kernel.org>; Mon,  2 Feb 2026 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060449; cv=none; b=rNu9J/09H3VFPunNxuH49dbqsuoe4mYTGDXu7UJU0z58BE+CdsVIy6SwcJtN5dNquWxwnMX4CuW8K2otadPn938B/ZNwM1ADC3cv5OziJCfTAejyJNoPUeEpW6cSKXqYjubAVndUbD5FOK1OQwgoA07UVbXxCuReaPAOhV9TucQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060449; c=relaxed/simple;
	bh=3B8HTQFgNNzgqlf42XTaLpBsQ0fTdaYVL1EvDWjmHiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dg5WFz6ZnAnMESikMOv2NVDm+gQLsNzGBi7xlYs8clIkOwtZ8/MWbGNX8vbUfaBHgW6J+3BHbWl4fmR/PByZQc+dmMWQwbUpjqFVe+RViFhlyTMth7qj2yYsrIoARX0g4C9dzEMa92OEGqZNRN4OtGf18qBmUbqSChhaxXwgY6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewWb2J84; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewWb2J84"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-7927261a3acso49528497b3.0
        for <linux-block@vger.kernel.org>; Mon, 02 Feb 2026 11:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770060446; x=1770665246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0W2kOVha/xcUKncXKOZvuRNwgi05sLURL2p+L0mfW94=;
        b=ewWb2J84PR0LwpwX13xq13jOFwCaU5mE/wqqc+WNDg13E8Ll2Irm6BeQ/2+671/EV7
         55jQpr94sq/G5zi2x/gT73TEj8v+TQFfruVyX0tvE09Zc6qc+5hrTXfyUTzYLy0gVt2u
         wOq6PJUqHGXdkjLcJ0Pn1AHnrveH9Eav+qqIaYts6GfdI7M+Em7qocdwjZqzViERtolm
         cYQ9hJVnQ486cG012FFpPLLkwlHEcq9QxrccMrZ4vq6OdFV3/Dg5gvs1xSo8w6offCHo
         txqjRNfy3qPmSd4yh1lP3Fmzue3Oosr+Gwa+PcE2TDffVIDTqZ7xVLjTMQVvU6/sp7Z9
         kp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770060446; x=1770665246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0W2kOVha/xcUKncXKOZvuRNwgi05sLURL2p+L0mfW94=;
        b=DunzFUdz+eouGlq9lxhMEoJk8Kc1RaP1AidoUjlqSXKvuLFQa+qRCOSf2CSBSx4TbI
         pkbBw1Dtth3/1ucq7PLjWlMlH7sOtgSnVRPDj1nk+cPcTGjSBAdd2+oAQ5dUQeJwcIqj
         YSdDpAKlLONx/dzVShFXSRd+HMvUOSqvhwyLPDEbSFApH5sEhZPVnlKXnIaooYpHLmIa
         px0CaBGbd2iXgrfF6MBxy+PmLWWMR94Ao7u5B7/9U+I7mF9qeaBHrOX3j/QDeunxGNgI
         1kOwuXt/ugTmidcgd2AwLe2gO7hTQXHX6DSEd7Apf/uUJgfn6QFiNWesad4T2XAMx6MT
         NBEQ==
X-Gm-Message-State: AOJu0Yx4DfdD0wTPQByHHCWx+V9M/cNc4KtC4f5hB6MdRWriwaqPue/q
	CddsQzaXrajok1jwOtNV+RS9NhjYAtJxzLScE9sZol4OUS2h/hP+s9uyH2jv6sPC
X-Gm-Gg: AZuq6aKosqzPH8CsXD0k/9AsdXrX4Zbu2biADv+iUz4XHcx93oedQlmHoHXxIRTtz9h
	fC10ZZE0lY56UVndhaixtRDnI5xzdED16CAINT/Xdd3iXxyFrpx18hS4sgHhf2/IzCDQl4OC1Qm
	idHGjWhQGaG3N8ft/3AEa0FoM+LsupPlVegemgkTxppiQK4TtmdyO37CP0GLkm2gPutRFBTqMOV
	xKVzyQEoKupRbGf20pJ49VmPlgQQDS4Xw39CWW8JAnnmPsQ6Vae/oOKeVcmjwOxhd2Tk+wN0tfA
	XK5CGt6hwLr28nGPLEb2fvge6Nm7YO07+WBtTN2BCGfGi63EqgftGPBo0b0yBfmJ8LunP5sgwvf
	9aWv3mcIVzeO0alsjMuanqJLaLRtW3hHT7aJyg2IaKF84X+Bin4Pp4GlIMBgmLFIPTrLyxW9YHu
	w1xR1Z9EsPc3vCXlf3PhkSEQ7yZ8tiCT80aFc=
X-Received: by 2002:a05:690c:63c8:b0:794:24fc:863 with SMTP id 00721157ae682-7949e00721dmr111061487b3.52.1770060446064;
        Mon, 02 Feb 2026 11:27:26 -0800 (PST)
Received: from 5163NRD-SPRABHU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794828f9cb2sm92649997b3.56.2026.02.02.11.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 11:27:25 -0800 (PST)
From: sw.prabhu6@gmail.com
To: linux-block@vger.kernel.org,
	shinichiro.kawasaki@wdc.com
Cc: vincentfu@gmail.com,
	joshi.k@samsung.com,
	Swarna Prabhu <s.prabhu@samsung.com>
Subject: [PATCH blktests v2] nvme/067: test io_uring pass through for NVMe admin queue
Date: Mon,  2 Feb 2026 11:26:33 -0800
Message-Id: <20260202192631.194256-1-sw.prabhu6@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Swarna Prabhu <s.prabhu@samsung.com>

Simple test to exercise the nvme admin commands usage with
io uring passthrough interfaces. The motivation for the test
is to extend the kernel code coverage for NVMe admin commands
via io_uring passthrough.

Signed-off-by: Swarna Prabhu <s.prabhu@samsung.com>
---
Changes since v1:
- Fixed typo in the git commit description and included motivation.
- Revert the file mode of src/Makefile to 644 from 755.
- Change src program name from "nvme-passthrough-admin.c" to "nvme-passthru-admin-uring.c".
- Change the file mode of src/nvme-passthru-admin-uring.c from 755 to 644.
- Added missing SPDX-License-Identifier and copyright in src/nvme-passthru-admin-uring.c
- Add space after commment markers in src/nvme-passthru-admin-uring.c.
- Added tab for indentation to 'struct nvme_id_ctrl' declaration in
  src/nvme-passthru-admin-uring.c.
- Added missing "\n" to the end of fprintf statement in src/nvme-passthru-admin-uring.c.
- Replaced direct return statements with goto to do resource clean up in
  src/nvme-passthru-admin-uring.c
- Added missing copyright and SPDX-License-Identifier in tests/nvme/067 script.
- Added '_io_uring_enable' and '_io_uring_restore' functions to script tests/nvme/067 to enable
  and restore io_uring setting for the test run.

Link to v1: https://lore.kernel.org/all/20260129023754.685508-1-sw.prabhu6@gmail.com/

 src/Makefile                    |   3 +-
 src/nvme-passthru-admin-uring.c | 100 ++++++++++++++++++++++++++++++++
 tests/nvme/067                  |  34 +++++++++++
 tests/nvme/067.out              |   2 +
 4 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 src/nvme-passthru-admin-uring.c
 create mode 100755 tests/nvme/067
 create mode 100644 tests/nvme/067.out

diff --git a/src/Makefile b/src/Makefile
index dac07c7..bd94636 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -23,7 +23,8 @@ C_TARGETS := \
 	zbdioctl
 
 C_URING_TARGETS := miniublk \
-		metadata
+		metadata \
+		nvme-passthru-admin-uring
 
 HAVE_LIBURING := $(call HAVE_C_MACRO,liburing.h,IORING_OP_URING_CMD)
 HAVE_UBLK_HEADER := $(call HAVE_C_HEADER,linux/ublk_cmd.h,1)
diff --git a/src/nvme-passthru-admin-uring.c b/src/nvme-passthru-admin-uring.c
new file mode 100644
index 0000000..d7868a6
--- /dev/null
+++ b/src/nvme-passthru-admin-uring.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-3.0+
+// Copyright (C) 2026 Swarna Prabhu, Samsung Electronics
+/*
+ * Simple test exercising the admin queue accesses via io_uring passthrough
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
+#define NVME_IDENTIFY_ADMIN_CMD 0x06     /* Identify command using admin queue */
+#define NVME_IDENTIFY_CNS_CTRL 0x01    /* Identify controller command to a NVME device */
+struct nvme_id_ctrl {
+	__le16 vid;
+	__le16 ssvid;
+	char sn[20];
+	char mn[40];
+	char fr[8];
+	__u8 rab;
+	__u8 ieee[3];
+	char pad[4020];
+};
+
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
+		fprintf(stderr, "usage: %s /dev/nvmeXnY\n", argv[0]);
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
+		ret = -ENOMEM;
+		goto free_fd;
+	}
+
+	ret = io_uring_queue_init(queue_depth, &nvring, IORING_SETUP_SQE128 | IORING_SETUP_CQE32);
+	if (ret < 0) {
+		fprintf(stderr, "Initialize io uring fail %d \n", ret);
+		goto free_nctrl;
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
+free_nctrl:
+	free(nctrl);
+free_fd:
+        close(fd);
+
+	return ret;
+}
\ No newline at end of file
diff --git a/tests/nvme/067 b/tests/nvme/067
new file mode 100755
index 0000000..38d55ad
--- /dev/null
+++ b/tests/nvme/067
@@ -0,0 +1,34 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Swarna Prabhu, Samsung Electronics
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
+	# enable io_uring when it is disabled
+	_io_uring_enable
+
+	if ! sudo src/nvme-passthrough-admin "${ctrl_dev}"; then
+		echo "src/nvme-passthrough-admin failed"
+	fi
+
+	# reset io_uring setting before test exits
+	_io_uring_restore
+
+	echo "Test Complete"
+}
diff --git a/tests/nvme/067.out b/tests/nvme/067.out
new file mode 100644
index 0000000..c56866e
--- /dev/null
+++ b/tests/nvme/067.out
@@ -0,0 +1,2 @@
+Running nvme/067
+Test Complete
-- 
2.39.5

