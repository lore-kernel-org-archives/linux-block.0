Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4D73CB2FE
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144494; cv=none; b=M/Th+6TYaLRXihIMsoYNfC9ScewJOS7Ry0OBr6sIHd/N48X79JhlXeZs7aLSBoURBKpZHdtaXigzSSez+rQNpsDCl9ByXqU1Y7wNaEKwMV+c0ClqwHh7ent6vOzo70CAsms/hizOkJyAOkYWMnrd8k6ulY8mH7fx3L153TCGUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144494; c=relaxed/simple;
	bh=FM8hfFhL4TlA9YZAoXWPP1MqD8zpFI/mh0v+GdOXkjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYCisxPWGvLCwN9PRvxt+le1m6Tlc6EJ7jwuZCLZR4xkxLrzxkJe0l43G9OPIKlUeHFVEcNsqTk2V69d6O52p2UeFXdOiVkUyOzoi1JQ5Rs972AMCLTH+xY6HLdwnKAkHo9sD/Qvz1YGsidq+Vv/l0+5wx8+hhnBy9mDaroB9dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xDtzql2A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xDtzql2A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=vtbaFf9XrcKmpL4UFDdUqHPTunAxnGDnLtI6B5M2aTU=; b=xDtzql2A9Vhe1qdAnpUE3KdNl8
	mFeCC0DVRCzUkEUDpx4rULavsM1b/YtPHjs5AhmN0CHnrHeaDgO3IcOffsZT9iruHf+VT6VJoi8vT
	2fqcD4aAYDigu3CuFCy3K6MXF44Q+/J5uSKc/j9YlY8U7cAE5NzKu4+FfdnPkFDFNSIjO1Kb8tMsZ
	znxTuOp84UdcYvnY8OLdeqJPQrXgMkNFd7GiQRUXdY5Ly8vZLw89t6gCELPc6k647swD8beUvvw8J
	65bK9CgiVo+I5xgv7MDRPQ93lGXGUVBOPHJ+iXqm4Y2V3I2DfH4T5QkayobXndkVAhCjvbMZ/SDAw
	3TkJAUfQ==;
Received: from [2001:4bb8:2ea:7da1:ebb4:65ed:3162:8230] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbhBz-00000005AOr-21Zq;
	Mon, 22 Jun 2026 16:08:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH blktests] block/044: basic block error injection sanity test
Date: Mon, 22 Jun 2026 18:08:08 +0200
Message-ID: <20260622160808.1552568-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Test the basic block layer error injection functionality.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/block/044     | 71 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/044.out |  9 ++++++
 2 files changed, 80 insertions(+)
 create mode 100755 tests/block/044
 create mode 100644 tests/block/044.out

diff --git a/tests/block/044 b/tests/block/044
new file mode 100755
index 000000000000..8baf9fa59c68
--- /dev/null
+++ b/tests/block/044
@@ -0,0 +1,71 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Christoph Hellwig.
+#
+# Basic block error injection test.
+
+. tests/block/rc
+. common/scsi_debug
+
+DESCRIPTION="basic block error injection test"
+QUICK=1
+
+requires()
+{	
+	_have_loadable_scsi_debug
+	_have_program xfs_io
+}
+
+# load and remove scsi_debug once to test the static_key bug in the
+# initial commit
+_test_load_unload()
+{
+	if ! _init_scsi_debug dev_size_mb=500; then
+		return 1
+	fi
+
+	local dev=${SCSI_DEBUG_DEVICES[0]}
+	local debugfs_file="/sys/kernel/debug/block/$dev/error_injection"
+	if [[ ! -f "${debugfs_file}" ]]; then
+		SKIP_REASONS+=("error injection not supported")
+		_exit_scsi_debug
+		return 1
+	fi
+	echo "Testing unload without rules"
+	_exit_scsi_debug
+}
+
+_test_rules()
+{
+	if ! _init_scsi_debug dev_size_mb=500; then
+		return 1
+	fi
+
+	local dev=${SCSI_DEBUG_DEVICES[0]}
+	local debugfs_file="/sys/kernel/debug/block/$dev/error_injection"
+
+	echo "Testing valid rules"
+	echo "add,op=WRITE,status=RESOURCE,start=0,nr_sectors=8" > $debugfs_file
+	echo "add,op=READ,status=IOERR,start=16,nr_sectors=8" > $debugfs_file
+	xfs_io -d -c 'pwrite -q 0 4096' /dev/$dev
+	xfs_io -d -c 'pread -q 0 4096' /dev/$dev
+	xfs_io -d -c 'pwrite -q 4096 4096' /dev/$dev
+	xfs_io -d -c 'pread -q 8192 8192' /dev/$dev
+
+	echo "Testing invalid rules"
+	echo "op=READ,status=IOERR" > $debugfs_file
+	echo "add,op=READ,status=EIO,start=32" > $debugfs_file
+	_exit_scsi_debug
+}
+
+test()
+{
+	echo "Running ${TEST_NAME}"
+
+	local ret
+
+	_test_load_unload
+	_test_rules
+
+	echo "Test complete"
+}
diff --git a/tests/block/044.out b/tests/block/044.out
new file mode 100644
index 000000000000..92efcddf7c8e
--- /dev/null
+++ b/tests/block/044.out
@@ -0,0 +1,9 @@
+Running block/044
+Testing unload without rules
+Testing valid rules
+pwrite: Cannot allocate memory
+pread: Input/output error
+Testing invalid rules
+tests/block/044: line 56: echo: write error: Invalid argument
+tests/block/044: line 57: echo: write error: Invalid argument
+Test complete
-- 
2.53.0

