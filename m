Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813932;
	b=zFvjxjWdhBZ/g9j18sPvd63QavYOTt+XViIwW+5qEMdkgF06lj6bTqfbJopeM9pPDx1l
	 ZifXPFXYieZ5ZSrYAoI4MH+ArX+41XGRNxw4eUmbZ8SLZ7BZOQskmxVLrjEX342OjdaQV
	 Y16h3qYRiCk8+xiAbok66AE3moSLVawDrdNV8mwevhcnTbbtWoxMJ/6s2Pk8K5+995ag/
	 gEJtLCqfpfPZsK6Xv6qJtYCFQ3q1ewHL+6JO57GR4GeupMo9cFX6KJuT8AQCzU+y7DuzL
	 3ghWtHreYIdRdXaBCInm/ccvI/49SKn9aMkhh7cF+UmRBthZhlXYLWHgR81PbO9BFMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813932;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=nzsMEF7eU4+4hMbPkvNYZVJlbHMc8hK3DBiDbFphCac=;
	b=DXenQXz4K9rp1BctC3m46AtFabQBu8lQIDAKwIRquOMUXMbtya0k0eFgefm/grEML68k
	 lQwc5whY1H7AhV3Cwt2QBruZfc0ryEq5dDFWw8CcV0DJCdZ9DvecpHCj4uGXPcZln+mU1
	 VNWnz+0A+dI82+d3j2o9/OdYJNCayB5PCijzI/QOgaz2Y6doCFw8ggS1oclekAiu9slaQ
	 KS8Y4b1hdu4ENn6lta84m7j9n5vR+TLpDXLhuu0J9Xj5wW6YVbe9MUPEsRjrWnha6UD3M
	 0kN3U9KzjCMVOMzMgUtTV+0f6sREhik7E14aQ8+jHRwV9kqxgXiGOUK9GsqDgGk/JvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WfDteIze;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7A9606A33A
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 17:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B7A9606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WfDteIze
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793813931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nzsMEF7eU4+4hMbPkvNYZVJlbHMc8hK3DBiDbFphCac=;
	b=WfDteIzeNgDJfK6wgz2d1xHnjNeP+arG7YRfjnxhirsIIwK0/K9P/fVvEL9yTrq6YTIksF
	F5BRZEoLR9usWA3AoSpvbXH1xU1XeHUVX2xji6uyHO77G/GZWhJqpItnj1GdzxPDh21Ko+
	6hYjQeLNGQ9B+pyCVcgm1jPQCK9DrdA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-515CpyBpPwijLf7luXZhvg-1; Wed,
 04 Nov 2026 12:38:47 -0500
X-MC-Unique: 515CpyBpPwijLf7luXZhvg-1
X-Mimecast-MFC-AGG-ID: 515CpyBpPwijLf7luXZhvg_1793813926
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB641180131A;
	Wed,  4 Nov 2026 17:38:45 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.17.16.153])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D233D187C363;
	Wed,  4 Nov 2026 17:38:43 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	shinichiro.kawasaki@wdc.com,
	John Meneghini <jmeneghi@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>,
	kbusch@kernel.org,
	kch@nvidia.com,
	hch@lst.de,
	sagi@grimberg.me,
	"Ewan D . Milne" <emilne@redhat.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [blktests] nvme/077: Add ANA log page information leak test
Date: Wed,  4 Nov 2026 12:38:42 -0500
Message-ID: <20261104173842.2937092-1-jtaubepe@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Regression test for reading memory contents beyond valid data when
reading ANA log page. The NVMe target must zero-fill the ANA log page
response buffer beyond the valid data so that stale kernel memory is
not leaked to the host.

The helper program (nvme-ana-log), requests the ANA log page,
parses the response header to find where valid data ends, and checks
that every trailing byte is zero. The check is repeated 64 times because
leaked data may incidentally be zeroed.

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
---
This test is meant to test:
Lore Link: https://lore.kernel.org/linux-nvme/20261104172833.161567-1-emilne@redhat.com/
---
 src/Makefile       |   1 +
 src/nvme-ana-log.c | 224 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/077     |  51 +++++++++++
 tests/nvme/077.out |   3 +
 4 files changed, 279 insertions(+)
 create mode 100644 src/nvme-ana-log.c
 create mode 100644 tests/nvme/077
 create mode 100644 tests/nvme/077.out

diff --git a/src/Makefile b/src/Makefile
index da25842..a88d912 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -24,6 +24,7 @@ C_TARGETS := \
 	mount_clear_sock \
 	nvme-delay-ioctl \
 	nvme-passthrough-meta \
+	nvme-ana-log \
 	nvme-sentinel-read \
 	nvme-zone-report \
 	ioctl-lbmd-query \
diff --git a/src/nvme-ana-log.c b/src/nvme-ana-log.c
new file mode 100644
index 0000000..f7c6093
--- /dev/null
+++ b/src/nvme-ana-log.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-3.0+
+// Copyright (C) 2026 Jesse Taube
+
+/*
+ * Check that unused bytes in an NVMe ANA log page are zeroed.
+ *
+ * The ANA (Asymmetric Namespace Access) log page has a 16-byte header
+ * followed by variable-length group descriptors. When the host requests
+ * more bytes than the valid data occupies, the target must zero-fill the
+ * remainder. A vulnerable target leaks stale kernel memory there.
+ *
+ * Strategy per attempt:
+ *   1. Fill the host buffer with a easy-to-recognize pattern (0xAA).
+ *   2. Request the ANA log page into that buffer.
+ *   3. Parse the response header to find where valid data ends.
+ *   4. Verify every byte beyond that point is zero.
+ *   5. Repeat NR_ATTEMPTS times as the trailing data might incedentally be zeroed.
+ *
+ * Exit codes: 0 = all clean, 1 = stale data detected, 2 = setup error.
+ */
+#define _GNU_SOURCE
+#include <ctype.h>
+#include <endian.h>
+#include <fcntl.h>
+#include <linux/nvme_ioctl.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#define BUF_LEN		(1024*256)
+#define NR_ATTEMPTS	64
+
+
+/* NUMD: Number of Dwords to return, 0's based
+ * CDW10 for Get Log Page: NUMDL sits at bits [27:16]
+ * (NVMe Base Spec, Figure 294)
+ */
+#define BYTES_TO_DWORDS(bytes)	((bytes) / sizeof(uint32_t))
+#define NVME_LOG_NUMDL(bytes)	(((BYTES_TO_DWORDS(bytes) - 1) & 0xFFFF) << 16)
+
+/* Broadcast namespace identifier */
+#define NVME_NSID_ALL		0xFFFFFFFF
+
+/* NVMe admin opcodes */
+#define NVME_ADMIN_GET_LOG_PAGE	0x02
+
+
+/* ANA log page identifier */
+#define NVME_LOG_ANA		0x0C
+
+/*
+ * ANA structures mirrored from the kernel's include/linux/nvme.h.
+ * Not exported to UAPI, so we define them here.
+ */
+struct nvme_ana_rsp_hdr {
+	uint64_t	chgcnt;
+	uint16_t	ngrps;
+	uint16_t	rsvd10[3];
+};
+
+struct nvme_ana_group_desc {
+	uint32_t	grpid;
+	uint32_t	nnsids;
+	uint64_t	chgcnt;
+	uint8_t		state;
+	uint8_t		rsvd17[15];
+	uint32_t	nsids[];
+};
+
+static void hexdump(const char *label, const unsigned char *buf,
+		    unsigned int len)
+{
+	unsigned int i, j;
+
+	fprintf(stderr, "%s (%u bytes):\n", label, len);
+	for (i = 0; i < len; i += 16) {
+		fprintf(stderr, "0x%04x: ", i);
+		for (j = 0; j < 16; j++) {
+			if (i + j < len)
+				fprintf(stderr, "%02x ", buf[i + j]);
+			else
+				fprintf(stderr, "   ");
+			if (j == 7)
+				fprintf(stderr, " ");
+		}
+		fprintf(stderr, " |");
+		for (j = 0; j < 16 && i + j < len; j++)
+			fprintf(stderr, "%c",
+				isprint(buf[i + j]) ? buf[i + j] : '.');
+		fprintf(stderr, "|\n");
+	}
+}
+
+static int nvme_admin_cmd(int fd, struct nvme_passthru_cmd *cmd)
+{
+	int ret;
+
+	ret = ioctl(fd, NVME_IOCTL_ADMIN_CMD, cmd);
+	if (ret < 0)
+		perror("NVME_IOCTL_ADMIN_CMD");
+	else if (ret)
+		fprintf(stderr, "NVMe admin status: %#x\n", ret);
+	return ret;
+}
+
+/*
+ * Request the ANA log page. NUMD (Number of Dwords, 0-based) is encoded
+ * in CDW10[27:16] and tells the target how many bytes to return.
+ */
+static int get_ana_log(int fd, unsigned char *buf)
+{
+	struct nvme_passthru_cmd cmd = {
+		.opcode		= NVME_ADMIN_GET_LOG_PAGE,
+		.nsid		= NVME_NSID_ALL,
+		.addr		= (uintptr_t)buf,
+		.data_len	= BUF_LEN,
+		.cdw10		= NVME_LOG_ANA | NVME_LOG_NUMDL(BUF_LEN),
+	};
+
+	return nvme_admin_cmd(fd, &cmd);
+}
+
+/*
+ * Walk the ANA header and group descriptors to find the first byte past
+ * the valid data. Everything from this offset to the end of the buffer
+ * must be zero.
+ */
+static unsigned int ana_valid_end(const unsigned char *buf)
+{
+	const struct nvme_ana_rsp_hdr *hdr = (const void *)buf;
+	unsigned int offset = sizeof(*hdr);
+	uint16_t ngrps = le16toh(hdr->ngrps);
+	uint16_t g;
+
+	for (g = 0; g < ngrps && offset + sizeof(struct nvme_ana_group_desc) <= BUF_LEN; g++) {
+		const struct nvme_ana_group_desc *desc = (const void *)(buf + offset);
+		uint32_t nnsids = le32toh(desc->nnsids);
+
+		offset += sizeof(*desc) + nnsids * sizeof(desc->nsids[0]);
+	}
+
+	return offset;
+}
+
+/* Return true if every byte in buf[start .. end) is zero. */
+static bool is_zero(const unsigned char *buf,
+		    unsigned int start, unsigned int end)
+{
+	unsigned int i;
+
+	for (i = start; i < end; i++) {
+		if (buf[i])
+			return false;
+	}
+	return true;
+}
+
+int main(int argc, char **argv)
+{
+	unsigned char *buf;
+	void *p;
+	int fd, ret, rc = 0;
+	int i;
+
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s /dev/nvmeX\n", argv[0]);
+		return 2;
+	}
+
+	/*
+	 * Page-align the buffer so that the kernel maps it for the transfer
+	 * instead of bouncing it: a bounce buffer is zero-filled, which would
+	 * hide the existing data and any bytes the target left unwritten.
+	 */
+	ret = posix_memalign(&p, 4096, BUF_LEN);
+	if (ret) {
+		fprintf(stderr, "posix_memalign: %s\n", strerror(ret));
+		return 2;
+	}
+	buf = p;
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0) {
+		perror(argv[1]);
+		free(buf);
+		return 2;
+	}
+
+	for (i = 0; i < NR_ATTEMPTS; i++) {
+		unsigned int valid_end;
+		bool clean;
+
+		/* Set the buffer to a distinct pattern for debugging */
+		memset(buf, 0xAA, BUF_LEN);
+
+		if (get_ana_log(fd, buf)) {
+			rc = 2;
+			break;
+		}
+
+		valid_end = ana_valid_end(buf);
+		clean = is_zero(buf, valid_end, BUF_LEN);
+
+		if (!clean)
+			hexdump("ANA log page", buf, BUF_LEN);
+
+		fprintf(stderr, "attempt %d: valid data ends at offset 0x%02x, "
+			"tail %s\n", i + 1, valid_end,
+			clean ? "clean" : "stale");
+
+		if (!clean) {
+			rc = 1;
+			break;
+		}
+	}
+
+	close(fd);
+	free(buf);
+	return rc;
+}
diff --git a/tests/nvme/077 b/tests/nvme/077
new file mode 100644
index 0000000..640735b
--- /dev/null
+++ b/tests/nvme/077
@@ -0,0 +1,51 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Jesse Taube <jtaubepe@redhat.com>
+#
+# Regression test for reading memory contents beyond valid data when reading ANA log page.
+# It checks that the NVMe target zeroes the ANA log page response buffer so that stale kernel
+# memory is not leaked to the host.
+#
+
+. tests/nvme/rc
+
+DESCRIPTION="Check NVMe target ANA log page zeroing"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_nvme_trtype fc rdma tcp
+	_have_src_program nvme-ana-log
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local ctrl ret
+
+	_setup_nvmet
+
+	_nvmet_target_setup
+
+	_nvme_connect_subsys --port 0
+
+	ctrl=$(_find_nvme_dev "${def_subsysnqn}")
+
+	src/nvme-ana-log "/dev/${ctrl}" >>"$FULL" 2>&1
+	ret=$?
+	case $ret in
+	0) echo "ANA log page was zeroed" ;;
+	1) echo "ANA log page contained stale data" ;;
+	*) echo "ANA log page checker failed" ;;
+	esac
+
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/077.out b/tests/nvme/077.out
new file mode 100644
index 0000000..48a0299
--- /dev/null
+++ b/tests/nvme/077.out
@@ -0,0 +1,3 @@
+Running nvme/077
+ANA log page was zeroed
+Test complete
-- 
2.56.0

