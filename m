Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2588F158A35
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945610; cv=none; b=iOzOj3p6tiusvxtATL1YAL7WLc8b78/3BWBgEEBwEQIegnfa7hAJt0rM9GTSeQIE3mRNi/8lwOI5aSbTSbCM+EBmLQ2esbw6QXCXSU0Up8qe7L1j31zDuD2cvHUoTFTGXLV5CX2psntqOII5/7sMHUiQO35jhehraMFnaTlEdyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945610; c=relaxed/simple;
	bh=3dx9il75eOILsBu5G1//4p+1/FA3YyekAV1bi+io5+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUl100uGEBe29mIWUbqjyZOLdA03Tmw11mKdV3tTp3jbCZa+vRMrOwHzVs/nhpHOv4JcdfvxgxaZO0ojDxOp6gaz3dkmqqQSNdos77sNAGi56i0Dvydm+2c+SktPEXwB5gSlpjpjge73l7jUAuCoyWLMTnKdQP218z89UT+/z28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BU+uXQq9; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BU+uXQq9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945606; x=1745481606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3dx9il75eOILsBu5G1//4p+1/FA3YyekAV1bi+io5+Q=;
  b=BU+uXQq9eMo3ugAKi4xeQPEiTdsCUwQM7feB6SO2IY9wDHS+gmCJNMSP
   zQoDtqT/GmxzD8LAi4hildHk+Cye1I/MK5FNTVE9H2chdMX2pPCApx/eU
   NtKIyCzuW9gVTbOa/r4YaSECg3K+80LY+wDIOb8vlho6DYUIRK6bS/ZRm
   NpJjjUhTQyeVz30yhd4HDXuPiADyaof2gIAdXI3WBobVB+KI5yY5AD1SP
   SscaBb0Max/HhxlCYXf8/Yd9B5s90tfy43HU1x4yd4TTvUz7a/Sx87Ds5
   MdDMyBto0GPip5PA0GeGnuRSvbJRPDo3SoW5dRUhwKaSxL69TtKAFTKYx
   A==;
X-CSE-ConnectionGUID: K7qNyQZtTtmqpwPUtEihIQ==
X-CSE-MsgGUID: TZPjq2FGRhmO/OfQq015JA==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14515679"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:01 +0800
IronPort-SDR: t2ByMtkuTT7HiRvhOPp9OJr9B5wK5d0A90oGv39U3ONgA/jweTmWJQnC0smnT+AOqw3fyeV2bw
 0C1BfZ5wHESBm2/l73V/zsimm3aF1EaMcwpAzn+RAhaaq171SdgQ9qVvldIkM6mZ9RemGhD82Z
 wYW6eSiop6ICuoKM6w/e6I5gXevQqvOALzeNYs7rah8LInA6286Dt5OQDkAv1dhuuBPvONogOn
 AXy098K1kE08txoaHe4IhGpaDxOYrOk2zsq1Yh3x384kWU8wlxOLuEqd1CAUAF7+dj80XetCbS
 7x8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:11 -0700
IronPort-SDR: 5eQpFKT9/T8nkJ8Clm2XKneTWPatvF+Rgcfg581snZinkRIpgrPpuomMpDtXGoKWr0AVyG6Q4O
 PULOvIqEsLQ+9RnttqUkUAEPcFgGe+dEXoyluVIlsy7m7hMkEUBdgO6oXLRqjYoN++GBznP5sK
 jMA9c4TLoYTASJY7OVK6Jd3dB53wVWm7SQPdvZ3lmzePFENpUzwwOGO3odrI+5i/5bMg4Phbqg
 AJm44hIFtLTgPuoEt1KMhMdE+KJ2m/pgkQomKLoC4TNDesqwHWwx+npsd8itwLdkjbafHFs9Q9
 IU0=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:00 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 04/15] meta/{016,017}: add test cases to check repeated test case runs
Date: Wed, 24 Apr 2024 16:59:44 +0900
Message-ID: <20240424075955.3604997-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test cases to confirm the feature to repeat test case runs with
different conditions is working.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
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

