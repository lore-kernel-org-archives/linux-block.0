Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C6C1ADC8D
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744962881; cv=none; b=Suzyc6fbD97gmNb/LXFi8xLWQ2xTu05EnmxhfniP9hUwBOOnb2zZd31v5wTVa+cVPeLwi2HQTFVz4SLhSsjuapZxNqwEwKK4a2QyG9twxOPkLkosQ0BP1aQPJxh/5XKZBprp6YJqThB4qNuCbR+78AU+aFmcAWKKYoVN7V9dj9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744962881; c=relaxed/simple;
	bh=02st3mTf5KPZGWSdZ8mqjp1p5IrGh73zUN2anbyaf24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ovmvn77WiCmWWzYpzqPY23mQB4F0+poJA+wdVuktFNT/I0PIi/ShuuAZoxSoKBSPAfiL+Mg99YoIJrZKBvMPj4sJq41Hbc4AJkeH1ZCvQxrQldwqgqNiVAqMLCKCoi2ytbOXihCq2oNs51d68MWPbGgQKbrmy23pQKYaqrKJZaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Vb7vWxWI; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Vb7vWxWI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744962880; x=1776498880;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=02st3mTf5KPZGWSdZ8mqjp1p5IrGh73zUN2anbyaf24=;
  b=Vb7vWxWIToq692lcRYl+nsAofW0TKruPrraDidx6M939Q9JVkV8Ifi1v
   AW/L18sTrXdy91j8Lr+aMMObA9Tz2332I5zwPE8/XLAAUK5odanfuRSHc
   oa6dYoOHHNsFt5k1K86f1RllnWGMf3CuR/5TO6Kd9HB0VLDk+hHUlx9x/
   z+SuvYmDssM2mGL4DoDdjtRqxmxJY3VOgFzpiJvQMGvSNlDgeOEh6RKn0
   l4YZSD/Trh5lGIrxWXIttLN9U5Qn7yPRu1+1+QPrLGA4rjG4YfMewmvXn
   ahNScFF6XaSQrldt5r53X5ohj2F6fNVggaf7kVQ36kQwzpY1n0ijnc8yC
   A==;
X-CSE-ConnectionGUID: bmlPmNuWSVudibMNwKnahQ==
X-CSE-MsgGUID: 0hzKnbCETSC09ZQer07pag==
X-IronPort-AV: E=Sophos;i="6.15,221,1739808000"; 
   d="scan'208";a="77134401"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2025 15:54:33 +0800
IronPort-SDR: 6801f728_a0eXlhbV41PQ0cMHNpeYUTOO/WYTwRt5fS+tKoG1clj5azt
 6iCc/EdoeyPiuSg3VF+fu59yfOHQVhISmXkM3yg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2025 23:54:32 -0700
WDCIronportException: Internal
Received: from 5cg2148fqg.ad.shared (HELO shinmob.wdc.com) ([10.224.104.106])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Apr 2025 00:54:32 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] block: add test for race between set_blocksize and read paths
Date: Fri, 18 Apr 2025 16:54:31 +0900
Message-ID: <20250418075431.1851353-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new large sector support in the kernel version 6.15-rcX caused
kernel crash due to race between set_blocksize and read paths [1]. Add
a test case to trigger the crash and confirm its fix.

Link: [1] https://lore.kernel.org/linux-block/20250415001405.GA25659@frogsfrogsfrogs/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
The test case number block/039 conflicts with the test case in Ming's recent
patch. I will renumber this test case or Ming's test case when I apply it,
depending on the order of patch application.

 tests/block/039     | 54 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/039.out |  2 ++
 2 files changed, 56 insertions(+)
 create mode 100755 tests/block/039
 create mode 100644 tests/block/039.out

diff --git a/tests/block/039 b/tests/block/039
new file mode 100755
index 0000000..dfe790e
--- /dev/null
+++ b/tests/block/039
@@ -0,0 +1,54 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Western Digital Corporation or its affiliates.
+#
+# Confirm that concurrent set_blocksize() calls and read paths do not race.
+# This is the regression test to confirm the fix by the commit titled ("block:
+# fix race between set_blocksize and read paths").
+
+. tests/block/rc
+. common/null_blk
+
+DESCRIPTION="test race between set_blocksize and read paths"
+TIMED=1
+CAN_BE_ZONED=1
+
+requires() {
+	_have_fio
+}
+
+change_blocksize() {
+	local deadline
+
+	deadline=$(( $(_uptime_s) + TIMEOUT))
+
+	while (($(_uptime_s) < deadline)); do
+		blockdev --setbsz 4096 /dev/nullb1
+		sleep .1
+		blockdev --setbsz 8192 /dev/nullb1
+		sleep .1
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	if ! _configure_null_blk nullb1 power=1; then
+		return 1
+	fi
+
+	if ! blockdev --setbsz 8192 /dev/nullb1; then
+		SKIP_REASONS+=("kernel does not support block size larger than 4kb")
+		_exit_null_blk
+		return
+	fi
+
+	: "${TIMEOUT:=10}"
+	change_blocksize &
+	_run_fio --rw=randread --bs=4K --filename=/dev/nullb1 --name=nullb1
+	wait
+
+	_exit_null_blk
+
+	echo "Test complete"
+}
diff --git a/tests/block/039.out b/tests/block/039.out
new file mode 100644
index 0000000..0638940
--- /dev/null
+++ b/tests/block/039.out
@@ -0,0 +1,2 @@
+Running block/039
+Test complete
-- 
2.49.0

