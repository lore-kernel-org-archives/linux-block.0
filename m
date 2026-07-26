Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180B5280018
	for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 05:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785043967; cv=none; b=qegeincVySqkfbIa8H5GE4/M+4gEFljnv5OR6kS/+NiRiU6wUJiWxch8x4G1RngtV2e02O/XLj00xUQhrO6qnBh2eoDW2q2qe/BnG57B3n04/FsUg8kI6eWrTaxq4huz/w92KaQJxy8qb9vwAyRMx7jRjHYtmtktZD0gvAnUTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785043967; c=relaxed/simple;
	bh=tyd7jy1Rsa4ofewYyq//RuL7ah99kRAlflGIQeKWw4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApGtQqPGmdQDpOu7AGQzjfgWkkjz6fQgslEwGmI+174+P/KTpN3xnU1dI0Lk4M6T0LqimZBAoHLr+34/jX793ig5zrHiwAXBbNDroxe1mlzzo1GL2fvvYusUwtdMxVl/9WcJNxAeOvgCB+GoaVhnwcMbhrp01HDkTeDOMzP/FFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AuHYfrvZ; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AuHYfrvZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1785043968; x=1816579968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tyd7jy1Rsa4ofewYyq//RuL7ah99kRAlflGIQeKWw4o=;
  b=AuHYfrvZt6H4oBpWrnp8/CNC1ADZ7bn/U6NQ2thCfvt5reC0VyjK39Px
   E4CWMJP/qU3IkMmpbH7qZKs6bMp8PfRPcveyIOIqLmG4VNswh1Deh6UvJ
   BhewOoboEd+zSMnL92jTPK+1wERQr177S2Ox4K+Ezt0ytd9z755xbzapS
   hmds6uLNQX096Hioe3tLJNZZm0j2LKXltropihSPBNmo3XTLSNLlGxmin
   dXiGrrZTS6Bug30A1oegpGI094xw+O0tUVEHNA9wvWDdhcqx05dsQyBWV
   CVYf2l2yVUa4uSoB/gv18wB44a1kaiZZeK5YHQIVn6hUepSyt+P32bQ5q
   g==;
X-CSE-ConnectionGUID: idwGqvjIRNyMHMxDdfFNMQ==
X-CSE-MsgGUID: mBNebdAKSwuY9WPNY9X5sA==
X-IronPort-AV: E=Sophos;i="6.25,185,1779120000"; 
   d="scan'208";a="150242809"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2026 13:32:41 +0800
X-CSE-ConnectionGUID: OqM71TUQRDSDoogg2nwDNg==
X-CSE-MsgGUID: 2j9pqEpCSu63thMUDAbBMg==
IronPort-SDR: 6a659bd9_LAzRg0V81tpSFS33xQQoGWAFrxjXgKygI4CsHuBi63QgpQe
 2R1CB+fifpObCtHJ8cwGoPw8bIlHcoWRWHWtiMQ==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2026 22:32:09 -0700
X-CSE-ConnectionGUID: q1dUyx4dR/WHnWx6MPT5lw==
X-CSE-MsgGUID: +b5IRaM9Riu5FxbFPIC5mw==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai2-o.wdc.com with ESMTP; 25 Jul 2026 22:32:09 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/3] block: add test for concurrent IO scheduler switching
Date: Sun, 26 Jul 2026 14:32:05 +0900
Message-ID: <20260726053207.1673066-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260726053207.1673066-1-shinichiro.kawasaki@wdc.com>
References: <20260726053207.1673066-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test to confirm that multiple processes can write to queue/scheduler
sysfs attribute of single block device concurrently. This is the fix
confirmation test for the recent bug in the kernel fixed by the kernel
commit 4ff58d6bc9dd ("block: serialize elevator changes for the same
queue using a writer lock").

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/045     | 49 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/045.out |  2 ++
 2 files changed, 51 insertions(+)
 create mode 100755 tests/block/045
 create mode 100644 tests/block/045.out

diff --git a/tests/block/045 b/tests/block/045
new file mode 100755
index 0000000..ef84bc4
--- /dev/null
+++ b/tests/block/045
@@ -0,0 +1,49 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Western Digital Corporation or its affiliates.
+#
+# Switch IO schedulers concurrently to exercise the scheduler change path under
+# contention. This is the regression test for the kernel fix commit 4ff58d6bc9dd
+# ("block: serialize elevator changes for the same queue using a writer lock").
+
+. tests/block/rc
+. common/null_blk
+
+DESCRIPTION="switch schedulers concurrently"
+TIMED=1
+
+switch_schedulers() {
+	local start_time idx
+
+	start_time=$(date +%s)
+	while (( $(date +%s) - start_time <= timeout )); do
+		idx=$((RANDOM % ${#scheds[@]}))
+		{ echo "${scheds[$idx]}" > \
+                       /sys/block/nullb1/queue/scheduler ;} 2> /dev/null
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local timeout pid1 pid2
+	local -a scheds
+
+	if ! _configure_null_blk nullb1 power=1; then
+		return 1
+	fi
+
+	timeout=${TIMEOUT:=30}
+	read -r -a scheds < <(_io_schedulers nullb1)
+
+	switch_schedulers &
+	pid1=$!
+	switch_schedulers &
+	pid2=$!
+
+	wait $pid1 $pid2
+
+	_exit_null_blk
+
+	echo "Test complete"
+}
diff --git a/tests/block/045.out b/tests/block/045.out
new file mode 100644
index 0000000..2301a37
--- /dev/null
+++ b/tests/block/045.out
@@ -0,0 +1,2 @@
+Running block/045
+Test complete
-- 
2.54.0

