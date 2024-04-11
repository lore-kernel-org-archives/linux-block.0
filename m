Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE0147C7C
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834026; cv=none; b=d+2mvPrp2YfsGcHfvmY6rJr1aSoP50qtafE30vHCgSdI8MrGphoNGWNeGLXKecI3QKgb6fiBprIy6xTo8zmHLdzA9Tt5KokY6f0q+rXnrhFlUfNJYaBDNa63EdypK07gtNgV+lrTbqvcvq2xLKgc4ktaViP9CjKIFe6mpKG0Yz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834026; c=relaxed/simple;
	bh=SBK3Pk2xC4hSF2vaKeplEtIivVa/MUAt4a7KOe5+oVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNe/5PNlHDKYd9Huc+pzWyREDvQxYakuvD3DHGUu4ItWs+We5c/qCylJx6zb1e29uHiAPvk6Mem4GhQGgPOoNH1jUW4vTHzNSOsL0WvoqUvH5A7A3cVPMVabxpAvxfIEOIQXwyLTJVzl9SRiEhwz6BwD8B9Su4T7r7p8vJ2OhF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Da1TGGrm; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Da1TGGrm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712834024; x=1744370024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SBK3Pk2xC4hSF2vaKeplEtIivVa/MUAt4a7KOe5+oVQ=;
  b=Da1TGGrmGryp/PWDz4zvMxlUnH0t+VVwt74YlkjlzlYgCNucYeDfaubw
   SOxjarMuPyq7xuaIgLzsQd1czXYJvac/AeSOp1IfqH62vHjor1udv/2IC
   7vNoGGkJpuItsdJAgoaTtQnf318mJGnOnjiwZ8Ca8++Tqb/iCzarwuIqh
   uNgOamLyu2Ze4IDa+lZjYrW+pX1rdVBlQS+e7k+/RGqUS0OLG51MbwcJC
   XxT9XfBst7Ytrdl446vXlau3UtY4DPqaU39KfAsIVRxtLfepg2BAOqyYB
   iiL/TwiDZNRw0gKvlOtfNeDCL8xtN/ZU8qUAuAzLwh633wFhZ+DH7Y/gF
   g==;
X-CSE-ConnectionGUID: n59+ax8EQeeFlyTk51s6Ug==
X-CSE-MsgGUID: 67mIgJnJSYCTWBV8uSVRHg==
X-IronPort-AV: E=Sophos;i="6.07,193,1708358400"; 
   d="scan'208";a="13579865"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 19:12:33 +0800
IronPort-SDR: AX7UjpdTkNmQoN8wOdgBE8FN90ZnFL/VT89caP0xA+2F4DhpwCjwFEiXEBh3bCgJhRr4TNdCH3
 xDbY8clROe0A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 03:15:19 -0700
IronPort-SDR: 1zk0oZJf3QWQAPE0yL/TvZMIPs5Y9ahKHOaEJP6SM6VRM7P5RJTo8NRwuMTGAahkL5jUDcRXhX
 SE94E2prLikg==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Apr 2024 04:12:33 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 04/11] meta/{016,017}: add test cases to check repeated test case runs
Date: Thu, 11 Apr 2024 20:12:21 +0900
Message-ID: <20240411111228.2290407-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
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

