Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674590;
	b=eAqMk+1BTDiSbPcXykDNz8hdH+nPTgrdOD+Xz3Xx+jayd8alB6SM1xvhp0AQ8t9xg0mc
	 GV/bHOruHWfXf4OWUeCfMwtLr9yb1s7XpD2mXgsRuPC7jZRcNrdfueOGgCOx6NwI+h2u5
	 pw6OM3VWwqQqm+yTJCc/wHOybdecV6YL58L4s8pnYB1/lKTxjS07T5MBEnW+Dz3sPjWEp
	 jY3lxkEmJWZXqMIem3+gHxMfEIVep6bsBDplaxJ5bwGTzCKWU0+r/QMiV5fLHkxfM/qVk
	 F5zAez4/V4pZGQ63XHRbJJOIYhcbI4qNSbsVBilpY/t7WuUgWkGP2U0VKbEjB7PSgcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2BqGwuPW1LSqC01ykDlKxwwUb1RW6AH4YD+EZwCze/4=;
	b=YFqs1eKG5+tgw2PfH8DIdR5GyLCrDNgBADbBR3aZ3o/T10mcXMiuiQgvcTdzmGyrRIO/
	 QBLOAKaLTAScHBnjDesbNk8Po06Trl5cnVOgK1VkyCul1qKYLR0egTWKcj6xL08ciQ03a
	 E+RqmwZFineIOCW1LMgtXUP1eGnmXr3OMWqOg1Hl67L2ClqCxSM7+ISPzoHawPM13MVt4
	 XUTNoPgj25UrA1xgEiY8hH7Mg/hWCBE2giPVUrsL95naE9wJAhY7hDrQdClY3eZTHSxwP
	 a1UYb7A9oU3j2jbndGpKSCU57n13r+aQXyVKrACpmi5fSO6sP1dU4qCcq5Trte9zB/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n1QzXxgo;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE66606A31E
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 13:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DE66606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n1QzXxgo
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dee593f18so1524957f8f.3
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 06:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792674588; x=1793279388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2BqGwuPW1LSqC01ykDlKxwwUb1RW6AH4YD+EZwCze/4=;
        b=n1QzXxgoiHRyIFNJx3PxohQEP7SK8XopcbB3TGKLhb4L/OXThtNkRZJJ7rBL2aJ1IX
         E3RtTMHuCuoTV5F9+70lPBYlWbZBjJb+BL+DhnWMYq8a79+XgTo+LjmxHWJIP9Pc6u/8
         7JokzEmGuAqEB01oFp64mnHPDjR6glY9hABZJgT6/PAH09b6NYdO1e6tUQFBO63yYGQO
         gdZglHMLVRiQYfxLnb0R80seX5DS1vaOFl7hUx+C/IWwtTjlWxW0/4g6EoeIAgUmVcRS
         +qbcOq9hotlyp2bSdg5mY+MXingn3WRYOwuwvXq5cYPncasp1bQewGqzWs/TbNtvD0pp
         TjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674588; x=1793279388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2BqGwuPW1LSqC01ykDlKxwwUb1RW6AH4YD+EZwCze/4=;
        b=S1jgDjafSOcpO4LWOcRoN0UiQewVV1RTM4yUZIPX0P+z9wQijXmht+Zxuzstmnl+kF
         QZoIGoZP9mqAxQ7NeecKRNAZKs2PNY+xciXwAxBclHkIZiRaivCqs/YxvDGAZirGUwj/
         OBpmyCJIga8gdZ5RLUA2y156zgP0YpAdldw2QNdtsa+x3jB2XLl+Gq0cuTHfGdJVP5r8
         6xLX3ZxLG+rQG7gRo2eEOg8LAClIX/JnmypPFIXzpJqRpXpPi94ShnlfUF4TgHrYp9VV
         Snv4XqIBDLacNGsYT2AYttWuHe1w6S+MGcHZFnd1I+igamXxA8Jt1wv4tL1v1rcmZzP4
         pU5g==
X-Forwarded-Encrypted: i=1; AKwUvBwzCAkRuMq8LuPLCUFJxegBz3AK9sGBmnj7czLv14wsxsYBaW/x/IEw0QcpKxQ0hhaxp+/c3GCRxIZqtQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYILORyvGYDVJPeY1Pw4z1Y1Qs0qC3eRbWFtjR44B3cXPOO1KKRi
	ClxAN+5eEZyIuobCqwZO+XQf/T14y5ng6Joq1fkkA22+8ZqQ2dEOn4QC
X-Gm-Gg: AYBFou25pWj7yG4FHezBPwwzQ5MLbVdxoaHU0l4DtJPTTizaGwPw9MGpWuxNdo1qh/v
	cmuxbY4XsiXaI4V7hzg1SwOCOOeI0iimRAmZ5/uB7/RPS3XAtKj+Imd0WChOn00Ylhlnw4C28mc
	Kcaghib1MzEUhmX/eEZJ360KyXjStinY1oEtN4xsVoFUYasUgjIBfo2OjS7Yk+D7HbsuzagrIIL
	gTVShD8/VrJ3NkN6HG1J4TTdlJxjBx89T/LXrSsWn1odTpYcxuaLqaDIoLNSOWLOfF/wkUmcmM7
	l4Ih/YYg+IBQAfkDSQhOAdpYrptj5P7hYmUHI/IpLa85DXXfPNeo2lg5AFZHrHPyhSTIaoj6xfc
	wnXtYBeRyIOToNcJPuQhb3UhykNb03NzTcUBit+bBCaRlQiogwP+LoUHXBAioboQPXAIAsYnlRr
	XVu9rhXxaj7O1vgjzFL1G993DcD4oAIfet9vY3KquXJgUunD12zyz9SNbTpCtY/ueDSvcVms1BR
	Vos9DsimnKS93r/pwect3T3I818yIhJltk3gqdnJ3cG8KHWmM00o/zBE3aoZsmyjqFdyYFp3CwF
	5j+Z8SXtSsy+Tg08siz2QNMO
X-Received: by 2002:a05:600c:3e8e:b0:4a1:eccb:53eb with SMTP id 5b1f17b1804b1-4a1fdaef48cmr106086885e9.6.1792674587622;
        Thu, 22 Oct 2026 06:09:47 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm119664695e9.4.2026.10.22.06.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:09:47 -0700 (PDT)
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
Subject: [PATCH blktests v2 3/4] nvme/073: test nvmet zone report initialization and length
Date: Thu, 22 Oct 2026 15:09:23 +0200
Message-ID: <20261022130927.3583166-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022130927.3583166-1-parri.andrea@gmail.com>
References: <20261022130927.3583166-1-parri.andrea@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export a zoned null_blk device through the NVMe target and verify that
Zone Management Receive zeroes reserved and unused report bytes and
rejects a transfer length inconsistent with NUMD. The test runs on every
configured transport, with RDMA restricted to 4 KiB page kernels so that
the preparatory write exceeds the default inline-data limit. Add a small
passthrough helper because nvme-cli does not expose the reserved report
bytes.

The test fails on the unpatched kernel and passes with the fix applied.

Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 src/.gitignore         |   1 +
 src/Makefile           |   1 +
 src/nvme-zone-report.c | 165 +++++++++++++++++++++++++++++++++++++++++
 tests/nvme/073         |  68 +++++++++++++++++
 tests/nvme/073.out     |   2 +
 5 files changed, 237 insertions(+)
 create mode 100644 src/nvme-zone-report.c
 create mode 100755 tests/nvme/073
 create mode 100644 tests/nvme/073.out

diff --git a/src/.gitignore b/src/.gitignore
index 57d14df3a2540..7d9ffb45185e7 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -20,3 +20,4 @@
 /nvme-passthru-admin-uring
 /nvme-delay-ioctl
 /nvme-sentinel-read
+/nvme-zone-report
diff --git a/src/Makefile b/src/Makefile
index 1133f34d7f07c..9ff1166887851 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -25,6 +25,7 @@ C_TARGETS := \
 	nvme-delay-ioctl \
 	nvme-passthrough-meta \
 	nvme-sentinel-read \
+	nvme-zone-report \
 	ioctl-lbmd-query \
 	nbdsetsize \
 	openclose \
diff --git a/src/nvme-zone-report.c b/src/nvme-zone-report.c
new file mode 100644
index 0000000000000..438c91897e32e
--- /dev/null
+++ b/src/nvme-zone-report.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-3.0+
+// Copyright (C) 2026 Andrea Parri
+
+/* Check that unused bytes in an NVMe zone report are zeroed. */
+#define _GNU_SOURCE
+#include <endian.h>
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
+#define REPORT_LEN		4096
+/*
+ * Larger than the default RDMA in-capsule data size on 4 KiB page kernels.
+ * nvme/073 skips RDMA on other page sizes, where this write could stay
+ * inline rather than use buffers allocated and freed per command.
+ */
+#define POISON_LEN		8192
+#define WRITE_OPCODE		0x01
+#define ZONE_REPORT_OPCODE	0x7a
+#define PARTIAL_REPORT		(1U << 16)
+#define ZONE_REPORT_HEADER	64
+#define ZONE_DESC_LEN		64
+#define ZONE_START_OFFSET	16
+#define NR_ATTEMPTS		64
+
+static int poison_target(int fd, unsigned int iteration)
+{
+	unsigned char data[POISON_LEN];
+	struct nvme_passthru_cmd cmd = {
+		.opcode = WRITE_OPCODE,
+		.nsid = 1,
+		.addr = (uintptr_t)data,
+		.data_len = sizeof(data),
+		.cdw10 = iteration * (POISON_LEN / 512),
+		.cdw12 = POISON_LEN / 512 - 1,
+	};
+
+	memset(data, 0x5a, sizeof(data));
+	return ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+}
+
+static uint64_t read_le64(const unsigned char *p)
+{
+	uint64_t value;
+
+	memcpy(&value, p, sizeof(value));
+	return le64toh(value);
+}
+
+int main(int argc, char **argv)
+{
+	unsigned char *report;
+	unsigned long long slba;
+	char *end;
+	void *p;
+	int fd, i, j, ret, rc = 0;
+
+	if (argc != 3) {
+		fprintf(stderr, "usage: %s /dev/nvmeXnY last-zone-slba\n",
+			argv[0]);
+		return 2;
+	}
+
+	errno = 0;
+	slba = strtoull(argv[2], &end, 0);
+	if (errno || *end) {
+		fprintf(stderr, "invalid SLBA: %s\n", argv[2]);
+		return 2;
+	}
+
+	/*
+	 * Page-align the report so that the kernel maps it for the transfer
+	 * instead of bouncing it: a bounce buffer is zero-filled, which would
+	 * hide the sentinel and any bytes the target left unwritten.
+	 */
+	ret = posix_memalign(&p, 4096, REPORT_LEN);
+	if (ret) {
+		fprintf(stderr, "posix_memalign: %s\n", strerror(ret));
+		return 2;
+	}
+	report = p;
+
+	fd = open(argv[1], O_RDWR);
+	if (fd < 0) {
+		perror(argv[1]);
+		free(report);
+		return 2;
+	}
+
+	for (i = 0; i < NR_ATTEMPTS; i++) {
+		struct nvme_passthru_cmd cmd = {
+			.opcode = ZONE_REPORT_OPCODE,
+			.nsid = 1,
+			.addr = (uintptr_t)report,
+			.data_len = REPORT_LEN,
+			.cdw10 = (uint32_t)slba,
+			.cdw11 = (uint32_t)(slba >> 32),
+			.cdw12 = REPORT_LEN / 4 - 1,
+			.cdw13 = PARTIAL_REPORT,
+		};
+		unsigned int nonzero = 0, stale = 0, poisoned = 0;
+		unsigned char sentinel = i & 1 ? 0xa5 : 0x3c;
+
+		ret = poison_target(fd, i);
+		if (ret) {
+			if (ret < 0)
+				perror("poison_target");
+			else
+				fprintf(stderr, "poison write status: %#x\n", ret);
+			rc = 2;
+			goto out;
+		}
+
+		memset(report, sentinel, REPORT_LEN);
+		ret = ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+		if (ret) {
+			if (ret < 0)
+				perror("NVME_IOCTL_IO_CMD");
+			else
+				fprintf(stderr, "NVMe status: %#x\n", ret);
+			rc = 2;
+			goto out;
+		}
+
+		if (read_le64(report) != 1 ||
+		    read_le64(report + ZONE_REPORT_HEADER +
+			      ZONE_START_OFFSET) != slba) {
+			fprintf(stderr, "unexpected zone report header or SLBA\n");
+			rc = 1;
+			goto out;
+		}
+
+		for (j = 8; j < REPORT_LEN; j++) {
+			if (j >= ZONE_REPORT_HEADER &&
+			    j < ZONE_REPORT_HEADER + ZONE_DESC_LEN)
+				continue;
+			if (!report[j])
+				continue;
+			nonzero++;
+			if (report[j] == sentinel)
+				stale++;
+			if (report[j] == 0x5a)
+				poisoned++;
+		}
+
+		fprintf(stderr, "attempt %d: %u nonzero bytes "
+			"(%u poison, %u sentinel)\n", i + 1, nonzero,
+			poisoned, stale);
+		if (nonzero) {
+			rc = 1;
+			goto out;
+		}
+	}
+
+out:
+	close(fd);
+	free(report);
+	return rc;
+}
diff --git a/tests/nvme/073 b/tests/nvme/073
new file mode 100755
index 0000000000000..4416367fee67b
--- /dev/null
+++ b/tests/nvme/073
@@ -0,0 +1,68 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Andrea Parri
+#
+# Check that NVMe target zone reports are fully initialized and that their
+# transfer length matches NUMD.
+#
+# Regression test for patch "nvmet: zns: don't leak stale memory in zone
+# management receive".
+
+. tests/nvme/rc
+. common/null_blk
+
+DESCRIPTION="check NVMe target zone report initialization and length"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_kernel_nvme_target
+	_have_null_blk
+	_have_kernel_options BLK_DEV_ZONED
+	_have_src_program nvme-zone-report
+
+	# RDMA defaults to PAGE_SIZE bytes of inline data. The helper's
+	# 8 KiB preparatory write must exceed that limit.
+	if [[ "$nvme_trtype" == "rdma" ]]; then
+		_page_size_equals 4096
+	fi
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local block_size dev last_sector ret sectors slba zone_sectors
+
+	_setup_nvmet
+	_register_test_cleanup _cleanup_nvmet_zoned_target
+	if ! _nvmet_zoned_target_setup; then
+		return 1
+	fi
+	dev="/dev/$(_find_nvme_ns "$def_subsys_uuid")"
+
+	sectors=$(cat /sys/block/nullb1/size)
+	zone_sectors=$(cat /sys/block/nullb1/queue/chunk_sectors)
+	block_size=$(cat /sys/block/nullb1/queue/logical_block_size)
+	last_sector=$(((sectors - 1) / zone_sectors * zone_sectors))
+	slba=$((last_sector * 512 / block_size))
+
+	src/nvme-zone-report "$dev" "$slba" >>"$FULL" 2>&1
+	ret=$?
+	case $ret in
+	0) ;;
+	1) echo "zone report contained stale data" ;;
+	*) echo "zone report checker failed" ;;
+	esac
+
+	_check_zone_report "$dev" 4096 1023 0
+	_check_zone_report "$dev" 8192 1023 15
+
+	_nvmet_zoned_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/073.out b/tests/nvme/073.out
new file mode 100644
index 0000000000000..ed6690e578688
--- /dev/null
+++ b/tests/nvme/073.out
@@ -0,0 +1,2 @@
+Running nvme/073
+Test complete
-- 
2.53.0

