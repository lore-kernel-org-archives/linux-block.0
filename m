Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2545A127E23
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263535; cv=none; b=HZ2JtzxaC3Iz4Ufd0WXbf/Wflai4UsmeH5nQ9V2w5EvcW6VYYNYidE1bOqJORYpHfBWkfv2FiGHov6/tp7V7uPo//LvyQ8ZTewf7rh/mwZwhQjG6Q7ZVMFNYVrZBXlPKyQ6+QWTqaaO2A4+fYCpVQEIRYPZKoDGN8CtJUWUBFq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263535; c=relaxed/simple;
	bh=SBK3Pk2xC4hSF2vaKeplEtIivVa/MUAt4a7KOe5+oVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQGmlP4fqBRlkhfvc90/Lwnrzctp9GB/5Yu2bNsnYM7RL/a+dDdCc0tnFiGAsFvtbNudHyB6Ij0FUcvWFlUxarPnSUaKO8GBWZNzfsP36j3yv/zgeDQuHO8pIxXNg33/TdAnxd9+Kxp70ML8qA8b6LwIZZiQgnkWVt5f0V1+ZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZSD7MQuZ; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZSD7MQuZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263533; x=1744799533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SBK3Pk2xC4hSF2vaKeplEtIivVa/MUAt4a7KOe5+oVQ=;
  b=ZSD7MQuZRhmWsqTQhOm0D4Yl0s7WTRlAMw6pM6u92TAzBXYSHZ26GG7W
   B7XmdNmqbMk6p5k4idAURyeI/+0mygquiuf4FMpB+e1TggkblqiplyLHR
   iOjQjPbvPXDGMiUfrdqbF7vqvrKI9afl0rI29cbB7c8G5sOlydzK2ZI7M
   /5OB/dX0xme7xmca9M1JvWgCMtXr9QEA5m6MaDVZo0eCGm/H+O5w4qIyV
   jPQ7AABPK+13MjqDWBRN6I/XbHbYfUPWOuWOyKiDPQC5qqRfLNag54zEy
   60tz3MXixqJMbFpI2iryJJYbpyeWqbNnEWqFr3JLdubsOXRFCrRAuF7uB
   g==;
X-CSE-ConnectionGUID: H1z4N5aYTPCseXnu+PQuxw==
X-CSE-MsgGUID: zwd/wuJyQeqiL27fFt3RAQ==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14322614"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:32:12 +0800
IronPort-SDR: dXCnut5dyEnJrgul75GYXII/2vhrgrIrgcrUpvSqHaiFBht9ZHh8/x19hRaxG4T9KCPrY7BSst
 WRpLrv65NOqWTHq2A8uz7s9oJ2v3us0Utr49YXdY9fYN8JxzZWLId0vsXh8B0pO8oz3NnE81v6
 K1u6Hcc3Pix5z0oOaMYnhrTuL4QcS7ZIxwz93yvTt+4vjAQpfax27ejdO8iabB7sZ8S0GB3frT
 2ZOrc/m4IL6yYaD3Q6bZpqzdfUQUbsAtSDZyvsrzKl5XP+y6w2yH92xEvJw3fR/xAxcB1vHNdc
 hIE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:40:32 -0700
IronPort-SDR: L5ID6y2Q1evLzQ/zMTOCtLSa3e1X2AwMG+baz6+K+5WsER991wuHNF63C47ggf+WQN2VZj6J8t
 jDyGKHiqD4ocCL8CyQiDxO0CUrJt1sbJdossf4m5BU43T47WvKdlxwsSIj2HoxjRTokz8kjZIK
 +E4uAvyUJv+nqu+4i0IA997HHtFFRLgUg3OiUtV1XNq8NreVS6L7IOHJi+kMlZvsfX0GtGplvs
 JguOLi2+bcrvrsx0hgQ4qFvKCOl/4YBcZROhlDIWxGuqSULjCw5Xlh82IkRvWv4l7oyvvCHC6I
 EOc=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2024 03:32:12 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 04/11] meta/{016,017}: add test cases to check repeated test case runs
Date: Tue, 16 Apr 2024 19:32:00 +0900
Message-ID: <20240416103207.2754778-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test cases to confirm the feature to repeat test case runs with
different conditions is working.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/meta/016     | 29 +++++++++++++++++++++++++++++
 tests/meta/016.out |  2 ++
 tests/meta/017     | 29 +++++++++++++++++++++++++++++
 tests/meta/017.out |  2 ++
 4 files changed, 62 insertions(+)
 create mode 100755 tests/meta/016
 create mode 100644 tests/meta/016.out
 create mode 100755 tests/meta/017
 create mode 100644 tests/meta/017.out

diff --git a/tests/meta/016 b/tests/meta/016
new file mode 100755
index 0000000..caf876d
--- /dev/null
+++ b/tests/meta/016
@@ -0,0 +1,29 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Western Digital Corporation or its affiliates.
+#
+# Test repeated test() run with set_conditions()
+
+. tests/meta/rc
+
+DESCRIPTION="repeat test()"
+
+declare cond_set_index
+
+set_conditions() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo 2
+		return
+	fi
+
+	cond_set_index=$index
+	COND_DESC="condition set $index"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+	echo "condition set $cond_set_index" >> "$FULL"
+	echo "Test complete"
+}
diff --git a/tests/meta/016.out b/tests/meta/016.out
new file mode 100644
index 0000000..cccfec4
--- /dev/null
+++ b/tests/meta/016.out
@@ -0,0 +1,2 @@
+Running meta/016
+Test complete
diff --git a/tests/meta/017 b/tests/meta/017
new file mode 100755
index 0000000..03f92d6
--- /dev/null
+++ b/tests/meta/017
@@ -0,0 +1,29 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Western Digital Corporation or its affiliates.
+#
+# Test repeated test_device() run with set_conditions()
+
+. tests/meta/rc
+
+DESCRIPTION="repeat test_device()"
+
+declare cond_set_index
+
+set_conditions() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo 2
+		return
+	fi
+
+	cond_set_index=$index
+	COND_DESC="condition set $index"
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+	echo "condition set $cond_set_index" >> "$FULL"
+	echo "Test complete"
+}
diff --git a/tests/meta/017.out b/tests/meta/017.out
new file mode 100644
index 0000000..7fc55ff
--- /dev/null
+++ b/tests/meta/017.out
@@ -0,0 +1,2 @@
+Running meta/017
+Test complete
-- 
2.44.0

