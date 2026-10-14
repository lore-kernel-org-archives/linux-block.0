Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C123BCD3A
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997264; cv=none; b=BZogF90kxTr2atj33V4u+RToNwk3q+Ogf1HrvYH4+o/CkJk0dtXdhKxpjV0S9ydnMMvB28sjD96qq4kdogmaTv2WFYSZ9G2NEglb/48QfU+A/kMNMyaV+btuXD1ZHRCfxjZznZMC1UcaodWGtaofZYeZb4ouvdz3qixvJceYTNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997264; c=relaxed/simple;
	bh=M2d1lZqT4JSuhg0ekGD4vXsNeN4EdH6zAdeV7fFdgdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4NLFrOOLkLicPrMDC/PAoxxfNffhUCR0986MNd79WipEtr7Ym1YGSQVAQ4+TbUxr2UxVm6Wd39s8c1jcrnPMFOjc+BHXK+Z1ZSVFyp21jT4LAUfNscIPMYilyb/4kKUx0H/Y92rhnEP8BXZbxzD4GjuaytNDKJW/eaaU1hMKGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmpRdfQq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmpRdfQq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so39901505e9.1
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 10:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791997261; x=1792602061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b4EOz8oNcujmRPotVW/3oA0Xk0tvmFoYm47gqUKw16U=;
        b=CmpRdfQqJ5r6MH9AJOLBQoU3k6JX0k8IIT+vSupTaCIOXd3IVe3XDXcXV0sSgduxWN
         dD//lxhSyjCaiXGRejcUGqqUcdeD9/1xSfvAPoCMGvBx91jZGnQeU+WGOXlMnB83VOQq
         4VTnFVHMZSvUZn7TA9zjB0/46JJYaH8/EAU4G/NuSd+yF90+5Uy4QWUQ2bp4LmB4KSIB
         8TFezJQNxNurShQARjKF+DFWYO5qn1KAo3eEPhdru2UTXMNpQ3Eg2LZ29+ZeOCflFur9
         O5cKSaZUEeIXwvJbSQATizY40iDP7Q+Z1uaEJTabhob+7i5RGlk841ZKEhFeCiHFzi/n
         OHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997261; x=1792602061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b4EOz8oNcujmRPotVW/3oA0Xk0tvmFoYm47gqUKw16U=;
        b=Mqg9v3NztT83p1kz0QdzLUGBNvG/GGyzCVpu4X4uXy8qTyKWo0g1tqSF5/VH60LWJ7
         SOi+Jdfe7Hn6U0hq4G9XVk6dkEwLMWwxGdgE5LY2vKR2msbUkf+WYeAPChcamNq+4WAR
         SUDmUy/1zVMGFoO9XHqGYyhbusEUrvKSzipE2/c0s3NJcY9geO3ZVsyn25cV21Nb38Xc
         5CmGNHhoqPoS9XkEilCoJ28Uw13kxjtouWkUn7fc9acxIJglsFf+Rr3UZBrZM2OvUBeK
         NzwvH6O3jbjC99I4qVnPleTHX6YA2EZxC6r2TiZGO+WsXFqexs8HRTnhpxpkMdWTEGR8
         2u4A==
X-Forwarded-Encrypted: i=1; AKwUvBwGEnXkBGU0afznf8jfe3qWOOAMUnicRz059Ap8mkTpPdogTwOYrwPgX6lGa0J7HbuBsWcvBJDUoo49dg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJCDF3MaePmteiGtG8nE9kI6O0HdCZEBO2jCPVJKvd6/0XacHem
	xRGK0G3FSiUlBRq3HX+HDUcWBrp4lEeYuaCwSw1M3hYHmM5JYwMt8eRg
X-Gm-Gg: AYBFou3PPw5qU+SQnufwT5j7tUJAa879OlGcx6CqytfWN0CGF2Z4DMymiLjhMOUVZFb
	Y9q3SaCUYMiw5G5yrO+wbUBLFXO6oN5MpIaj9QRxdasYbudFyZWLkuaOu/V2dFDkx1m58+uWPGf
	5LtSeW/n9QpbJ7RwMCYLrrB4bnQpfsn1OsH1qOx0rKZRjNPyGJE8FLaRi/OeRNPrZrPPjj/FP0I
	AE4gvtEccvgerMWtGoi15H2e3tsqj+tlwBwtjrg12SchJkqMYpl8EDdpKQBvWZfasd5kWkHnDti
	oluBoEe0YAZ5HTRcHTlLTQM3xLKH6RDFF2OtTI00ovfenCB17AeBXant8HbKaWUKXMwuhjce5Lq
	W5nAWHydgED5gPdpKZfgADlUK2FUd5xMZMiA3X+n3XrVCBaB00qrmSAjEASzFFtKC13Ry1AuQNa
	oUDne8xmZITxldsNKXOV9yUMPdd//CYtkLcDWO1dxk9vyQLDZ3DVgpHNrJq+kO5bU4mla4CDSwc
	dktsNsXk1U6Cw7FquBN1BZArqLHpvcR38NL2XOfeolw+g==
X-Received: by 2002:a05:600c:4fcb:b0:4a1:811c:8083 with SMTP id 5b1f17b1804b1-4a18e4c3600mr330167855e9.33.1791997261055;
        Wed, 14 Oct 2026 10:01:01 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9a8a22sm5349415e9.5.2026.10.14.10.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:00:59 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests 2/4] nvme/071: test that nvmet sends no data for a failed read
Date: Wed, 14 Oct 2026 19:00:39 +0200
Message-ID: <20261014170046.2516-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014170046.2516-1-parri.andrea@gmail.com>
References: <20261014170046.2516-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Issue a failing Identify into a buffer filled with a sentinel and verify
that the target transfers no data, with a successful Identify and a
namespace read as controls. The test runs on every configured transport;
only nvmet-fc failed it before the fix. Add a small helper because
nvme-cli cannot prefill the data buffer.

The test fails over fc on the unpatched kernel and passes with the fix
applied.

Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 src/.gitignore           |  1 +
 src/Makefile             |  1 +
 src/nvme-sentinel-read.c | 89 ++++++++++++++++++++++++++++++++++++++++
 tests/nvme/071           | 80 ++++++++++++++++++++++++++++++++++++
 tests/nvme/071.out       |  2 +
 5 files changed, 173 insertions(+)
 create mode 100644 src/nvme-sentinel-read.c
 create mode 100755 tests/nvme/071
 create mode 100644 tests/nvme/071.out

diff --git a/src/.gitignore b/src/.gitignore
index e9869e172b20f..2429da9d9cf44 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -18,3 +18,4 @@
 /ioctl-lbmd-query
 /nvme-passthru-admin-uring
 /nvme-delay-ioctl
+/nvme-sentinel-read
diff --git a/src/Makefile b/src/Makefile
index dd646940fa25e..78433f0762b4a 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -24,6 +24,7 @@ C_TARGETS := \
 	mount_clear_sock \
 	nvme-delay-ioctl \
 	nvme-passthrough-meta \
+	nvme-sentinel-read \
 	ioctl-lbmd-query \
 	nbdsetsize \
 	openclose \
diff --git a/src/nvme-sentinel-read.c b/src/nvme-sentinel-read.c
new file mode 100644
index 0000000000000..dd36f283f46e2
--- /dev/null
+++ b/src/nvme-sentinel-read.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-3.0+
+// Copyright (C) 2026 Andrea Parri
+
+/*
+ * Issue an NVMe admin read command into a buffer filled with a sentinel and
+ * print the NVMe status and the number of bytes the command overwrote.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/nvme_ioctl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#define SENTINEL	0xa5
+
+static int parse_u32(const char *s, uint32_t *val)
+{
+	unsigned long v;
+	char *end;
+
+	errno = 0;
+	v = strtoul(s, &end, 0);
+	if (errno || end == s || *end || v > UINT32_MAX)
+		return -1;
+	*val = v;
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	struct nvme_passthru_cmd cmd = { };
+	uint32_t opcode, cdw10, len, i, changed = 0;
+	unsigned char *buf;
+	void *p;
+	int fd, ret;
+
+	if (argc != 5 || parse_u32(argv[2], &opcode) || opcode > 0xff ||
+	    parse_u32(argv[3], &cdw10) || parse_u32(argv[4], &len) || !len) {
+		fprintf(stderr, "usage: %s /dev/nvmeX opcode cdw10 data-len\n",
+			argv[0]);
+		return 2;
+	}
+
+	/*
+	 * Page-align the buffer so that the kernel maps it for the transfer
+	 * instead of bouncing it: a bounce buffer is zero-filled and copied
+	 * back even when the command fails, which would hide the sentinel.
+	 */
+	ret = posix_memalign(&p, 4096, len);
+	if (ret) {
+		fprintf(stderr, "posix_memalign: %s\n", strerror(ret));
+		return 2;
+	}
+	buf = p;
+	memset(buf, SENTINEL, len);
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0) {
+		perror(argv[1]);
+		free(buf);
+		return 2;
+	}
+
+	cmd.opcode = opcode;
+	cmd.addr = (uintptr_t)buf;
+	cmd.data_len = len;
+	cmd.cdw10 = cdw10;
+
+	ret = ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
+	close(fd);
+	if (ret < 0) {
+		perror("NVME_IOCTL_ADMIN_CMD");
+		free(buf);
+		return 2;
+	}
+
+	for (i = 0; i < len; i++)
+		if (buf[i] != SENTINEL)
+			changed++;
+
+	printf("%#x %u\n", ret, changed);
+	free(buf);
+	return 0;
+}
diff --git a/tests/nvme/071 b/tests/nvme/071
new file mode 100755
index 0000000000000..5333bfac8db53
--- /dev/null
+++ b/tests/nvme/071
@@ -0,0 +1,80 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Andrea Parri
+#
+# Check that the NVMe target transfers no read data for a failed command.
+# The host buffer is filled with a sentinel, so any data the target sends
+# shows up as changed bytes.
+#
+# Regression test for patch "nvmet-fc: only send read data for successful
+# commands".
+
+. tests/nvme/rc
+
+DESCRIPTION="verify nvmet does not transfer data for failed reads"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_kernel_nvme_target
+	_have_src_program nvme-sentinel-read
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+# Issue an Identify with CNS $2 to controller $1 and print the NVMe status
+# and the number of changed bytes in the 4096-byte data buffer.
+_identify() {
+	src/nvme-sentinel-read "$1" 0x06 "$2" 4096 2>>"$FULL"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local changed ctrl ns status
+
+	_setup_nvmet
+	# File backing: the namespace read below fails over loop with the
+	# default loop device backing, for reasons unrelated to this test.
+	_nvmet_target_setup --blkdev file
+	_nvme_connect_subsys
+
+	ctrl=$(_find_nvme_dev "$def_subsysnqn")
+	ns="/dev/${ctrl}n1"
+
+	# Identify Controller succeeds and must overwrite the sentinel.
+	if ! read -r status changed < <(_identify "/dev/$ctrl" 0x01); then
+		echo "successful Identify could not be issued"
+	else
+		echo "cns=0x01 status=$status changed=$changed" >>"$FULL"
+		if ((status != 0 || changed == 0)); then
+			echo "successful Identify returned status $status with $changed bytes"
+		fi
+	fi
+
+	# An unsupported CNS fails and must leave the sentinel intact.
+	if ! read -r status changed < <(_identify "/dev/$ctrl" 0xff); then
+		echo "failed Identify could not be issued"
+	else
+		echo "cns=0xff status=$status changed=$changed" >>"$FULL"
+		if (((status & 0x7ff) != 2)); then
+			echo "failed Identify returned status $status, expected 0x2"
+		fi
+		if ((changed != 0)); then
+			echo "failed Identify transferred data: $changed bytes changed"
+		fi
+	fi
+
+	if ! dd if="$ns" of=/dev/null bs=4096 count=256 iflag=direct \
+	     status=none >>"$FULL" 2>&1; then
+		echo "namespace read failed"
+	fi
+
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/071.out b/tests/nvme/071.out
new file mode 100644
index 0000000000000..146809b91e0a3
--- /dev/null
+++ b/tests/nvme/071.out
@@ -0,0 +1,2 @@
+Running nvme/071
+Test complete
-- 
2.53.0

