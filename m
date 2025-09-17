Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AA336CDFE
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109769; cv=none; b=psxFJm9jCl9gynhtRURIN04VWHhUs3LnVEoAlNT06bhmCkYELGuc/ht1Eh0v7yFNq0kRf76/gQVXUdVYjUqgBXA6+U6PNGxCS92kiXtE1uA8ikD1kRYoqMu9X3jgShv2w1R0lTwdrFSk4H6cQZCA6RvHu5uPombgmqV+epRLVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109769; c=relaxed/simple;
	bh=ee85ZbHV0kuIthTCW53CVjcrg7AzCIiND7ql/JCUl0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdPZ1RdUnAKroRutJQ9GAA91Md72qnlJ7yIMutwLc2o0D1ER+jkLrNwIWfKM1PqWFVecO7FWLLMC++f/dutduICQ9cfbJrguzzsXgcru9EwHJXiJN8QVofAHBklbKJ8oFOx/CvG+vB+TwuHui29k/xCkT6zFhBZlGGdOnk1AwAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=L+Ah1sXX; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L+Ah1sXX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758109767; x=1789645767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ee85ZbHV0kuIthTCW53CVjcrg7AzCIiND7ql/JCUl0U=;
  b=L+Ah1sXXmOfuOwV3mjxI3loa6DM/lfrTusu2XKvKggRZiaQDybL3LWbm
   WkxjzfWBQbQ7uFg13hJz+y1gx72zIaJDiN+H1Ca8eTfjTYvWXt5kCFiV0
   3ZbTwRhQL3LiSqA/nfZWiVo/hAZb5cdtfwWaNMpneopT2/ybzP1fw+R7S
   dUWvCG/lXTtaROUKkNY3FUZW3EtIua8+mCTbfVdPHTK3znTBa9HUymsMY
   iuCBaR6Mm4lL1LJ4SNGkJqaOrSorvtKSAQL2Bjtdm62uHS8NlK0+JsubZ
   fFnVjL7wrFpYrQ4VgMbtswgZnkBPfexoOORNaBYMBfuwJzoFN7zSlJ9QX
   g==;
X-CSE-ConnectionGUID: pkNLiVTMRumfrspmM8bRhQ==
X-CSE-MsgGUID: yl7rGoZkS1isrkcTc5MryQ==
X-IronPort-AV: E=Sophos;i="6.18,271,1751212800"; 
   d="scan'208";a="122448685"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2025 19:49:27 +0800
IronPort-SDR: 68caa047_tLLqHN/AYSalaiwO6CPjI4Cm5u4l1C9Uubsvc7B9vBj8cPn
 Sf8KBVRPDH42MnkrIf6xQD3VvPjs04FBTJCsqDQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 04:49:28 -0700
WDCIronportException: Internal
Received: from dr34yd3.ad.shared (HELO shinmob.wdc.com) ([10.224.163.71])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Sep 2025 04:49:27 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	John Garry <john.g.garry@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 5/5] meta/02[0-4]: add test cases to check test_device_array()
Date: Wed, 17 Sep 2025 20:49:17 +0900
Message-ID: <20250917114920.142996-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917114920.142996-1-shinichiro.kawasaki@wdc.com>
References: <20250917114920.142996-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

The previous commit introduced test_device_array(). Add five test cases
to check its functionality. These test cases require the line below in
the config:

    TEST_CASE_DEV_ARRAY[meta/02?]=/dev/XX

/dev/XX should be a valid block device.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/meta/020     | 14 ++++++++++++++
 tests/meta/020.out |  2 ++
 tests/meta/021     | 15 +++++++++++++++
 tests/meta/021.out |  2 ++
 tests/meta/022     | 17 +++++++++++++++++
 tests/meta/022.out |  2 ++
 tests/meta/023     | 17 +++++++++++++++++
 tests/meta/023.out |  2 ++
 tests/meta/024     | 13 +++++++++++++
 tests/meta/024.out |  2 ++
 10 files changed, 86 insertions(+)
 create mode 100755 tests/meta/020
 create mode 100644 tests/meta/020.out
 create mode 100755 tests/meta/021
 create mode 100644 tests/meta/021.out
 create mode 100755 tests/meta/022
 create mode 100644 tests/meta/022.out
 create mode 100755 tests/meta/023
 create mode 100644 tests/meta/023.out
 create mode 100755 tests/meta/024
 create mode 100644 tests/meta/024.out

diff --git a/tests/meta/020 b/tests/meta/020
new file mode 100755
index 0000000..38fa920
--- /dev/null
+++ b/tests/meta/020
@@ -0,0 +1,14 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Western Digital Corporation or its affiliates.
+#
+# Test test_device_array()
+
+. tests/meta/rc
+
+DESCRIPTION="do nothing in test_device_array()"
+
+test_device_array() {
+	echo "Running ${TEST_NAME}"
+	echo "Test complete"
+}
diff --git a/tests/meta/020.out b/tests/meta/020.out
new file mode 100644
index 0000000..35e7722
--- /dev/null
+++ b/tests/meta/020.out
@@ -0,0 +1,2 @@
+Running meta/020
+Test complete
diff --git a/tests/meta/021 b/tests/meta/021
new file mode 100755
index 0000000..731e6b3
--- /dev/null
+++ b/tests/meta/021
@@ -0,0 +1,15 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Western Digital Corporation or its affiliates.
+#
+# Test test_device_array()
+
+. tests/meta/rc
+
+DESCRIPTION="exit with non-zero status from test_device_array()"
+
+test_device_array() {
+	echo "Running ${TEST_NAME}"
+	echo "Test complete"
+	return 1
+}
diff --git a/tests/meta/021.out b/tests/meta/021.out
new file mode 100644
index 0000000..25ee0fc
--- /dev/null
+++ b/tests/meta/021.out
@@ -0,0 +1,2 @@
+Running meta/021
+Test complete
diff --git a/tests/meta/022 b/tests/meta/022
new file mode 100755
index 0000000..8a853e7
--- /dev/null
+++ b/tests/meta/022
@@ -0,0 +1,17 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Western Digital Corporation or its affiliates.
+#
+# Test skip in device_requries() for test_device_array()
+
+. tests/meta/rc
+
+DESCRIPTION="skip test_device_array() in device_requries()"
+
+device_requires() {
+	SKIP_REASONS+=("(╯°□°)╯︵ $TEST_DEV ┻━┻")
+}
+
+test_device_array() {
+	echo '¯\_(ツ)_/¯'
+}
diff --git a/tests/meta/022.out b/tests/meta/022.out
new file mode 100644
index 0000000..c335c68
--- /dev/null
+++ b/tests/meta/022.out
@@ -0,0 +1,2 @@
+Running meta/022
+Test complete
diff --git a/tests/meta/023 b/tests/meta/023
new file mode 100755
index 0000000..646c216
--- /dev/null
+++ b/tests/meta/023
@@ -0,0 +1,17 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Western Digital Corporation or its affiliates.
+#
+# Test requires() with test_device_array()
+
+. tests/meta/rc
+
+DESCRIPTION="skip test_device_array() in requires()"
+
+requires() {
+	SKIP_REASONS+=("(╯°□°)╯︵ ┻━┻")
+}
+
+test_device_array() {
+	echo '¯\_(ツ)_/¯'
+}
diff --git a/tests/meta/023.out b/tests/meta/023.out
new file mode 100644
index 0000000..a3b3c66
--- /dev/null
+++ b/tests/meta/023.out
@@ -0,0 +1,2 @@
+Running meta/023
+Test complete
diff --git a/tests/meta/024 b/tests/meta/024
new file mode 100755
index 0000000..5d3b29e
--- /dev/null
+++ b/tests/meta/024
@@ -0,0 +1,13 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Western Digital Corporation or its affiliates.
+#
+# Test skipping from test_device_array()
+
+. tests/meta/rc
+
+DESCRIPTION="skip in test_device_array()"
+
+test_device_array() {
+	SKIP_REASONS+=("(╯°□°)╯︵ ┻━┻")
+}
diff --git a/tests/meta/024.out b/tests/meta/024.out
new file mode 100644
index 0000000..c5be615
--- /dev/null
+++ b/tests/meta/024.out
@@ -0,0 +1,2 @@
+Running meta/024
+Test complete
-- 
2.51.0

