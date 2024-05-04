Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A7B11182
	for <linux-block@vger.kernel.org>; Sat,  4 May 2024 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714810502; cv=none; b=uvdY7JmD16TocVgi9/WvcH9Jm+crHJ9L00wQ9X6a9gqjCvLA30EQcXSSGoEG4H09Gn4fAmicWKYFAXOU9C593+aBctn0gqFcSkTmr+0LKP6zb0lRlJkkMHD8qzUUgNIOtPHR16sKdnfcuSzJ40q5rd9K5gglAwrCCKXbgYY3lHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714810502; c=relaxed/simple;
	bh=3dx9il75eOILsBu5G1//4p+1/FA3YyekAV1bi+io5+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b//mT3GHYwsydcMeiC5uJQuzoii4kzlTTt52TrSHY75op5GF4gwoeYv8BIxau2kK8vmtbo3iHuHJ9Jn3pUExlZ0LR7NnybGcB9Uh1Xt6CFakf67IGruqcUteDepStvOZkWSZfkG5Wnt7+dtTTk5AtDKxxpAMvyaYwzrBSo2CtkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=i8N4IUCg; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i8N4IUCg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810500; x=1746346500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3dx9il75eOILsBu5G1//4p+1/FA3YyekAV1bi+io5+Q=;
  b=i8N4IUCg4LuD9dhl+EatA1JqMdsEjHPkFfAPCxa3SNAlqTdkzmQdxF6r
   glzaYyZ0ZWpOq4dWo5DrcWF+ldti2bRoctVNEJE94QgJaHJbQfLTJX7Sz
   aKMxl5p2hVXDd92XhT8VyXQK/G0y6EqtYzXQYKHFxGzd00JR2xudKXtuK
   vgg9MoGvFwwnjly4SHcbrqRtxDUziiD/76f7FfkcKamCxjS94Sj18OoLm
   oLuI8Pc7SagF7QLk8HTb1Mz/YQR0wnFtcjYV3XKsuNY3EJs/bFTB+dRvg
   V4VwNo+eVSCnaw7Z7l4svAOuuhYGFk1mNmg4zcZdyG9eC3uv9diy6G3Kw
   Q==;
X-CSE-ConnectionGUID: bbhQeZbXTJ+Ol9dwIn2+Dg==
X-CSE-MsgGUID: JZCDeBHdSTK3wLUPUYYtfw==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540301"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:14:55 +0800
IronPort-SDR: /8pPZjO5rl/bvPNDu2+qv7p2tv9WW9FDnyrYsnL3nnswDW4CRxF47bgB0Rw2Q+rBHaFNp2c2EK
 pq4OcP0BdPMbng7ipFlLPyiX6r9ndnMj9bv5MQ3FZLmRxtBSz0r7+fJaFOMCLLmwEqN0FQPiEg
 8iQq4GKagLAC6exdg8VMkOJFZsR6vdAJE426IcSY5KLurvGGExT6czAnuX7ffncWVdcbOD0C5p
 oti9KrzRoFWe1vuNavYz48CJlX4BI4VBQ5L64vKe5tFH1g+Qh9zGmpVTDH7tCY7mZHJ81sVz0p
 haM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:22:53 -0700
IronPort-SDR: RMXPPeVNTWfKYFpWcZbwf4Grcr0pwykG/6Buw98+qScc/vTanYcj+uhpgrg0fankKuBP2qa7ao
 DTfYsOnK7FTVCLXWVP9CNJdI7EAWdu0X91Evr94BkNg4yINe2OonRejotts/tMsZkF57WUl1Id
 UTORGJWWHMlk5H0aGWtaPDbtEoTYlWZzzbGvRUDrzFFUg731ElOE1+3yQJV9qhcrwRr9tQSAeU
 CSHScQTRXdq95p3SGH7+L2r0RdXyi7CS27hJIoAAF/QUGEwlGH878pZbOzVmKO/mJASJDvRUGY
 gnE=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:14:54 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 04/17] meta/{016,017}: add test cases to check repeated test case runs
Date: Sat,  4 May 2024 17:14:35 +0900
Message-ID: <20240504081448.1107562-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
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

