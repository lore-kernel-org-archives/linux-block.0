Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031954FDE61
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997268; cv=none; b=soppJlQ5PvMHAuu0WN3aqCVbQeuMmnzKvOKMqfws/ZJNLye3TZHKSgQa0X4rFrDa5pM/8kbKEvgrSSp3T/9Ziw/rLIS5QrdghT04QnhTo2JDscIRLrnSKTliX79Edv7wVD+3SIBFIn7EMyX2mS6eU+n1564wLm+ZzMWBjJgX4tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997268; c=relaxed/simple;
	bh=J7zrVUGzuHLBrr9abUB70dABx28mbtfYmkt6BNXMKGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwZsnPmmVZ1IZinwsqpW3vrigMSFZduKuATAED4t/bkOvqYg/5PjLyMkMB4EjwZMWGiUP8DE07kMHpdQk/kcRDTGMnU+fxPPJNNtmxgrXzUJEB6VcYjJ8uxPypQLhYHHgxbly6KxDi1fidG/nnGgtF4TULehMYmQaot3wxnTscc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrDAhgIr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrDAhgIr"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a02753c04fso24186255e9.3
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 10:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791997263; x=1792602063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FAFnpFstu6xg6JuUcGvyEILiHZEXNErgNQhhn8gwJd8=;
        b=HrDAhgIrZv4gWYdylOAvyBDIt2f+EyK0xGCJ9DlJFfp3R54VXoTjLm6PjvkNPoNKTr
         rU2M8L625XKsdvTo2/UkNV214wZ5Ogkn63PjhDw+9nQthLnx5sWgf+h7KRIK15DBxG+j
         SYmeNa8+j7zQsVhedYUlNUmpqSucBglWSEz7KgrKjB1zUIlUZJSgdT7Iqh4Abcn1o5wR
         OMkoNDkc8S2b1c7t/u8AUHlphezgy8H4e5VfQF2u8MJ3vVTtOAbSpoo0DE3fVdZ/oHoi
         wfOicEw5MqEKQHT9XTovfp9it43fP3GCktCf8Gkd7Vzo4WDUdFluaAb0seFZqk8p8dZw
         5d8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997263; x=1792602063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FAFnpFstu6xg6JuUcGvyEILiHZEXNErgNQhhn8gwJd8=;
        b=qxIvPz6t+o7E5y6o1QQ5Vjm+ehpTKHrjnb9OwyIcOs7BpHLhi3hJYFt7b5eOrD96S2
         JC9+mXvHLvAs7V8/weL6hvqfNi0Py49c4LF97QoqQe5kG5uiZjJQnrKlBQkG9rW+LUnN
         xXvqXypeQ+2kr+PR/i+jmW8/06bcszaf83Vog6u1ENHmUvgVobX9fM1QXNwihyi4uuAC
         XokSgE3Wc+wvuh8iNAHcugIpK1w9judRkbakbFqfMO3nxXYazBCz547oksVpO37R9zKg
         xVHLLiOZ5DELWGJazaM2zwGl+H1W0cRyfms1rDIqVQ81g0r6mq2cRjkS3PeYOf0Rug5U
         Z7ew==
X-Forwarded-Encrypted: i=1; AKwUvBzpGePD+Y78+Vm4RjieykAAZDpqhhfEePtBlrRRm54Nx4lbpD37YyfPnZQ4O4lCWwAOYGrBBHsg2sN79g==@vger.kernel.org
X-Gm-Message-State: AFq9FYIF+vri+orZSCR88sC5AmuYMvDYXWFPfM8GIRy/pJVNi9LG8FNN
	O8iWlmvzaCcY16PaENSGqXxoK2YPppK7TrS+K72ZGuy0yTDsU6vjuKzA
X-Gm-Gg: AYBFou2ULcJ+So+husedsoJcgfkZKTb5o30TWShHtXuy2DqBpa0DGZ2VIBhLsWvaUiV
	S4yI/61S5NDlVejbG1auzsF0v8m+L+1BOOwQK3NwleCWBx31wpxHEKFxNwSJoq9h/tK1ILolx8H
	ulyVtJ31/kVoXlLF4AzkD51GNBy4v/1Fs5aKUwC664A26jEUzuuK+7LWFwqBQb+MxEXJHGGiqMI
	QQWkE6eP0EkQUTH0sCjvMSothtV9EUEXEOqEsDjsLhJr/M5r0Y3R6ewI61KE6jqmWQXT1Vo8aOK
	+GCFYTVlE5qvjSp29IADD5c5CyFAQwu9aaClJbQC+dUNQH3YRneFX/eeY9OYebMCHbn2P6Ejk8R
	6OcSYyZncJzY/R31MtT9IQqkIBIf8Bh7QlFj592metEXDToJpSuRp4sW3P+UBJ0C8f2s46ruXQF
	Voc+TwHpp4/ioKSc9gd+uJzpovwY7lfF3mBOHcrDhzY4IWZf9gEfuf26wqvecHFCmBOCmrK0xS5
	S+RYLGafgTI1JU2b1D4qK/9+bV3KWeBqsfnc1bqW3xcZg==
X-Received: by 2002:a05:600c:8b09:b0:49c:c0d4:53d9 with SMTP id 5b1f17b1804b1-4a18e4a95b7mr355843515e9.14.1791997262978;
        Wed, 14 Oct 2026 10:01:02 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9a8a22sm5349415e9.5.2026.10.14.10.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:01:02 -0700 (PDT)
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
Subject: [PATCH blktests 3/4] nvme/072: test nvmet zone report initialization and length
Date: Wed, 14 Oct 2026 19:00:40 +0200
Message-ID: <20261014170046.2516-4-parri.andrea@gmail.com>
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
 tests/nvme/072         |  68 +++++++++++++++++
 tests/nvme/072.out     |   2 +
 5 files changed, 237 insertions(+)
 create mode 100644 src/nvme-zone-report.c
 create mode 100755 tests/nvme/072
 create mode 100644 tests/nvme/072.out

diff --git a/src/.gitignore b/src/.gitignore
index 2429da9d9cf44..8119476416937 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -19,3 +19,4 @@
 /nvme-passthru-admin-uring
 /nvme-delay-ioctl
 /nvme-sentinel-read
+/nvme-zone-report
diff --git a/src/Makefile b/src/Makefile
index 78433f0762b4a..7c4fd600ace1d 100644
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
index 0000000000000..951b1d03d4a75
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
+ * nvme/072 skips RDMA on other page sizes, where this write could stay
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
diff --git a/tests/nvme/072 b/tests/nvme/072
new file mode 100755
index 0000000000000..c7bcf93ab4d20
--- /dev/null
+++ b/tests/nvme/072
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
+	_have_module null_blk
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
+	sectors=$(cat /sys/block/nullb0/size)
+	zone_sectors=$(cat /sys/block/nullb0/queue/chunk_sectors)
+	block_size=$(cat /sys/block/nullb0/queue/logical_block_size)
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
diff --git a/tests/nvme/072.out b/tests/nvme/072.out
new file mode 100644
index 0000000000000..3f765b30a22b0
--- /dev/null
+++ b/tests/nvme/072.out
@@ -0,0 +1,2 @@
+Running nvme/072
+Test complete
-- 
2.53.0

