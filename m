Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674592;
	b=FwDxqb0g/dSaUZNwhRM0l3x4eoWPkTPdhAU5J/aNNyvigASC5ri98TT7Z3c89vSaCjS4
	 k7Rx3W0lMMWsSYcCc2Gsg1iG7uUtalg7Fic8srtz1Ws6QrzyKyhT55PYZl2DhnMeKXz9x
	 tT7tJ2Gohs/hUUfw31V+vUjESf5fTfzTo1e0Ze9pYAIBkSs/pTPdHRO8yFvu0sAzMCPfL
	 I1yY7yL+RRAwJ1FCQwn2d5qWqLq39z/cg5NwHLmNI1DzkxQfX2r3jLWvFe3sYSenfs5bC
	 mQ6y3Ko38Ik7dI3G1qu0YVp1oJyLZc1zvEwkb5yyfJdXWqHjSAC7iDonXuoHCupyqLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KkBAWb8M/VmKX7IuVDiW1Jf257xwCls4UjhLRxqmku8=;
	b=YqtJOd4gJqH9HpwTYmRvlLLDFa3hfAQIeb/9YWmEpZSkC4VNoiWw13zVJ9aNHfeA1tsN
	 qy9uQ3u6NQQTfzthWucLGwSP5LtjPN03Lj2cgAbyEFYwh4vebVL/DPw8c8KvI9MzGSpkK
	 ne6OwcIpWF1/sx/f7ZjhlzbR1aq6oX/6aBX+n/j45d8G7atKWz6Eq8DYJJxv72piQgMVI
	 z1WRa0zwqtxfB50s1yr7lVBgPtGdJR1YW+VkVLIuihE14pe+FXMZ/kEyEbOxshdJ2VW3T
	 Cd0cYdB5wXEZYu0ox5nOqs/+D/rFO0R4Zd81KyG0OQLe1/hU5c+TrIhapVzce5EJS+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=srqPidgp;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581A2606A31A
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 13:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 581A2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=srqPidgp
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso4993015e9.1
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 06:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792674586; x=1793279386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KkBAWb8M/VmKX7IuVDiW1Jf257xwCls4UjhLRxqmku8=;
        b=srqPidgpU6P0xwDzEUT9ZhMa2o9f+AMu1IsubzFGvpPhONrhPAHsRYvYCcLYFCHfTv
         Ojs1br1eDqV5OiBQ0J4Il5PRvx2SvDjHvEFIZZ9Py+FaAXpqPVeqhUV7TbxWrLD/woq0
         4w7lT+UrG0SMTIL3v0Lb4CLlmNKBfFgCyMATS0R27dcaW57TOhqcPImFMKyPi0DYzn9F
         DuzkUi+O8qPk9R3/RE3GzdGNplpo292C5bcnkjcL28yfpBSzWpP8TI6VNYQgMclhECZ2
         9gKZuQISMTv73CjFFAxq3MDb7UK/RqjAokJ0D7Ckkp5kAn2w2yJqCNY03a1JFn1yDg5v
         vkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674586; x=1793279386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KkBAWb8M/VmKX7IuVDiW1Jf257xwCls4UjhLRxqmku8=;
        b=VRFXmqWvFCrXds02TDHjk4rJm217g9W8fBor1E58MULWSEOdbd1ZQR2zR362lypoCV
         7mk1MM+TmM9yakj4eRxPbYdXgi80LbDxYZgXSNVcp9iiJiMmJwV+nkA5EUBXhtfRVOkb
         kQTBOruLlxWjYVqwk+JPtjp4p76ao4uQW6YUtL969Nn617qDTmn6zru6MJReP0L1r4sr
         R50YKmP2yAghBN9TUXVcKtaYijzK2EjvqyXrScu3c/GMU2NcxRFOGCzmhsjDL9DDZExY
         4PK2iIQ1yiSgvVofL5qeeKVuAza7WQKnlECWONWdNyuGmEfGTwEABK4vKF6sQDDKPcsS
         aYTw==
X-Forwarded-Encrypted: i=1; AKwUvBy+OvSSxtXEA5jXdYcMznZmOy6kj3y6XTeQQF+zwKl3sSBPiMom423nV2wWV7I0SLBMYxuLqwkPxgUHpg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ06Ur9sDaC6knPwVL1NgtC0RKF/2u0A1GQfG3jQtVd2uK7tzKa
	hS3vq5AJtIlLJGyxFVshPExeUtnFlTzE5oNZ8A8CTUd7QwR2Dknp2sI5
X-Gm-Gg: AYBFou3jkrezocEZEpEvtgOlpLPajuFeE3upsU0pccNpZuRRgp70bV4FnhpVCoY7oAp
	i9FcSWQVaBXMbIoZ4441iQh6eZl/3+VzUdyvFveu97MRpp4epjC4mgWsfR4fSjr2lET8zSgHNxc
	zigw28Iywj0ZlAlJv9xRGFZ0/YGqgPbzYEoqOP+3iQofaSE7rOdkxfndXXDmF8RB9NcRxur+It0
	uUWKz7BQykvMPnyvQVivh5ovRtqE7Mc1rukUWvsH3qPzT2TPO7pwQeoMGpZ5gv0YswzxnHDbesg
	Er0ZjKbwuhKuSv2pDzuSN9YX6b3fqbf2fAtcy5XHlJWnDwlbOWKEAtcEdv/4CpxXf+aHnqmEeX8
	nzMP4w3sf88QWXVb3Y/WA/rBvWHPM/W31UHC6aq1kSt6O7BzCk8vG6pgUc2ZXG8oPp8o6SVpivX
	ZOySpZfAWXm4s7iBqfDcg3UGot2Jg0IsKMrWwumMZIJC09z1zuQRmfNxj27WuGBFu4SwQqaq488
	YeCtepL6epNJVC8y500Pu6taw3QLlsJjMie1Ha6MMkJMaXJkQosqVCAXOplEt/Xh1MTzl539wHh
	7yr1pWN9WO/8XoN/QpTxLgLW
X-Received: by 2002:a05:600c:3b0d:b0:4a2:a9:ed87 with SMTP id 5b1f17b1804b1-4a200a9efc4mr99645355e9.19.1792674585354;
        Thu, 22 Oct 2026 06:09:45 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm119664695e9.4.2026.10.22.06.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:09:41 -0700 (PDT)
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
Subject: [PATCH blktests v2 2/4] nvme/072: test that nvmet sends no data for a failed read
Date: Thu, 22 Oct 2026 15:09:22 +0200
Message-ID: <20261022130927.3583166-3-parri.andrea@gmail.com>
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

Issue a failing Identify into a buffer filled with a sentinel and verify
that the target transfers no data, with a successful Identify as a
control. The test runs on every configured transport; only nvmet-fc
failed it before the fix. Add a small helper because nvme-cli cannot
prefill the data buffer.

The test fails over fc on the unpatched kernel and passes with the fix
applied.

Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 src/.gitignore           |  1 +
 src/Makefile             |  1 +
 src/nvme-sentinel-read.c | 89 ++++++++++++++++++++++++++++++++++++++++
 tests/nvme/072           | 72 ++++++++++++++++++++++++++++++++
 tests/nvme/072.out       |  2 +
 5 files changed, 165 insertions(+)
 create mode 100644 src/nvme-sentinel-read.c
 create mode 100755 tests/nvme/072
 create mode 100644 tests/nvme/072.out

diff --git a/src/.gitignore b/src/.gitignore
index f9a3916304c0f..57d14df3a2540 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -19,3 +19,4 @@
 /ioctl-lbmd-query
 /nvme-passthru-admin-uring
 /nvme-delay-ioctl
+/nvme-sentinel-read
diff --git a/src/Makefile b/src/Makefile
index 1e571c6b0b4eb..1133f34d7f07c 100644
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
diff --git a/tests/nvme/072 b/tests/nvme/072
new file mode 100755
index 0000000000000..a651fa0b0c672
--- /dev/null
+++ b/tests/nvme/072
@@ -0,0 +1,72 @@
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
+issue_identify() {
+	src/nvme-sentinel-read "$1" 0x06 "$2" 4096 2>>"$FULL"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local changed ctrl status
+
+	_setup_nvmet
+	_nvmet_target_setup
+	_nvme_connect_subsys
+
+	ctrl=$(_find_nvme_dev "$def_subsysnqn")
+
+	# Identify Controller succeeds and must overwrite the sentinel.
+	if ! read -r status changed < <(issue_identify "/dev/$ctrl" 0x01); then
+		echo "successful Identify could not be issued"
+	else
+		echo "cns=0x01 status=$status changed=$changed" >>"$FULL"
+		if ((status != 0 || changed == 0)); then
+			echo "successful Identify returned status $status with $changed bytes"
+		fi
+	fi
+
+	# An unsupported CNS fails and must leave the sentinel intact.
+	if ! read -r status changed < <(issue_identify "/dev/$ctrl" 0xff); then
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
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
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

