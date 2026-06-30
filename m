Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEA43ED105
	for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819467; cv=none; b=Y4W5NFrzqLvr0Mm33tqM35aa3Q0fORV2HPhQda9On23cS7t543HIuUhuzsaZuTHttHIr5GUs1hmN17/tDB+Btd2vEd3Q8BZvF5dqcv1N3WUhlTNkZRp00JF1Nvsn4MEWKSFI0QgyBWKXJ83makUW6lc0WX4vcqiRZgplveNc6Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819467; c=relaxed/simple;
	bh=+HVu7mDN+CXWGG0DJXEGwlMa4oxLfgHrBMsk0sOdekc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q+oNDaZLinC8gKwdZbd5Y/j6x8/1isR7luaRHr1CLqrsv2Gy4lUSAlcGAorftslCZIEPkxzCX5RP9R5VngK/qD4EE1EtiFgPvQ2GRwPPPokiX/XT4uZdroj22FFrgi71+oRV4Cw96EYQwpXdNG2vI6tsPp15pXuNowPJh1m3FIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z9/IJoau; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z9/IJoau"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=A6hMf3EAlWNKJd6b4Ms8Ut3n46d4Jc157Z8QxUQ8nuo=; b=Z9/IJoauomHxkUa3VVPKheq1XN
	yh8jp5GiULvif7hfyBVxMjqBaWIQeNLRk402C3q3OItqb8kG8lBTJ3iVcrMWV/UWfaNPlU/ie4UcZ
	qLuM97ELidfb5X1y6A+3LZI0mEWHRxGAIdzNuiH+DAnxDU9iHgw4URnanMq5SMYl1FzfyjcDPXOAx
	2XqNgmiS7BB7D2uoxZhLwu3rMJXOCF2SIGkL9tmamlXPj0LAqKgOnWidD26Kcrkf1LIazJApgchvb
	uWGBm3ZmrI4aknNFyhx9yn5IE4IL+bRRR2Ek0kd5ojD19kXiSx1GuAtNca84r6FgSCciycazDQehj
	3do0Jw3A==;
Received: from [2001:4bb8:2cc:ddd4:3632:f4c1:dd9a:7516] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weWme-0000000Grmo-0IdT;
	Tue, 30 Jun 2026 11:37:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH v2 blktests] block/044: basic block error injection sanity test
Date: Tue, 30 Jun 2026 13:37:03 +0200
Message-ID: <20260630113739.3601443-1-hch@lst.de>
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

Changes since v1:
 - change license to GPLv2 or later
 - incorporate various improvements from Shin'ichiro

 tests/block/044     | 62 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/044.out |  9 +++++++
 2 files changed, 71 insertions(+)
 create mode 100755 tests/block/044
 create mode 100644 tests/block/044.out

diff --git a/tests/block/044 b/tests/block/044
new file mode 100755
index 000000000000..097dd79d3bda
--- /dev/null
+++ b/tests/block/044
@@ -0,0 +1,62 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
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
+	_have_kernel_option BLK_ERROR_INJECTION
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
+	echo "add,op=WRITE,status=RESOURCE,start=0,nr_sectors=8" > "$debugfs_file"
+	echo "add,op=READ,status=IOERR,start=16,nr_sectors=8" > "$debugfs_file"
+	xfs_io -d -c 'pwrite -q 0 4096' /dev/"$dev"
+	xfs_io -d -c 'pread -q 0 4096' /dev/"$dev"
+	xfs_io -d -c 'pwrite -q 4096 4096' /dev/"$dev"
+	xfs_io -d -c 'pread -q 8192 8192' /dev/"$dev"
+
+	echo "Testing invalid rules"
+	echo "op=READ,status=IOERR" > "$debugfs_file"
+	echo "add,op=READ,status=EIO,start=32" > "$debugfs_file"
+	_exit_scsi_debug
+}
+
+test()
+{
+	echo "Running ${TEST_NAME}"
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

