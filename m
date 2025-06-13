Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118E244681
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749782504; cv=none; b=i7kPWZhWk7oOx//TPVUQihiMcUtX1ZInN8be0wgW+88gKe1kVq/l+2nuRfcpVbYW9jpQZkqsUR/P2V3oUyHgHeJBmH/lDIhOS8uMO8eoW9//A/LmQ5tCvQXGV4KEPXCw/aHIJn4jueEN7h1DKkDCoXruwXVXKmU8yNfczNxtu5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749782504; c=relaxed/simple;
	bh=cwg05hHPG0IKtD6GFhPq501oDyRMUDwmVrVl3GuPNMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CpXCJuZ/7URg3As6AfGySkH3PqdO88jGaF5HOSbkq8fnIs+nJkOUJturSdgW/42NKZbxU2ZDGEsYD96EEdMXozc3tuJHEs6SOIX6Gf9jo9uq2c1zLoflhrt3KWQygGb/cSrGPEpgAfHQQB0vUyHyG5RVAEr6kjd1QkaAAyi3AFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bJNvR6RrQzKHNGN
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 10:41:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 445E21A0D60
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 10:41:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1_gj0to6SlqPQ--.32372S4;
	Fri, 13 Jun 2025 10:41:38 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: shinichiro.kawasaki@wdc.com,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com
Subject: [PATCH] tests/throtl: add a new test 007
Date: Fri, 13 Jun 2025 10:35:38 +0800
Message-Id: <20250613023538.2900008-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe1_gj0to6SlqPQ--.32372S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zry8JFWUWr4kuw4ruF1DAwb_yoW8CFW8pr
	yUCa9YkF4xX3ZrGrn3Ga17CFWFyws7uF1UJ3sIgr15Ar1jq34UKF1I9r1ayF93JFnrur10
	v3WqqF95GF47AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
	UU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

Test change config while IO is throttled, for IO splitting scenario.
Regression test for commit d1ba22ab2bec ("blk-throttle: Prevents the bps
restricted io from entering the bps queue again").

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 tests/throtl/007     | 41 +++++++++++++++++++++++++++++++++++++++++
 tests/throtl/007.out |  6 ++++++
 2 files changed, 47 insertions(+)
 create mode 100755 tests/throtl/007
 create mode 100644 tests/throtl/007.out

diff --git a/tests/throtl/007 b/tests/throtl/007
new file mode 100755
index 0000000..98ba4ea
--- /dev/null
+++ b/tests/throtl/007
@@ -0,0 +1,41 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Zizhi Wo
+#
+# Test change config while IO is throttled, for IO splitting scenario.
+# Regression test for commit d1ba22ab2bec ("blk-throttle: Prevents the bps
+# restricted io from entering the bps queue again")
+
+. tests/throtl/rc
+
+DESCRIPTION="bps limit with iops limit over io split"
+QUICK=1
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	if ! _set_up_throtl max_sectors=8; then
+		return 1;
+	fi
+
+	local bps_limit=$((1024 * 1024))
+	local iops_limit=1000000
+
+	# just set bps limit first
+	_throtl_set_limits wbps=$bps_limit
+	_throtl_test_io write 1M 1 &
+	_throtl_test_io write 1M 1 &
+	wait
+	_throtl_remove_limits
+
+	# set the same bps limit and a high iops limit
+	# should behave the same as no iops limit
+	_throtl_set_limits wbps=$bps_limit wiops=$iops_limit
+	_throtl_test_io write 1M 1 &
+	_throtl_test_io write 1M 1 &
+	wait
+	_throtl_remove_limits
+
+	_clean_up_throtl
+	echo "Test complete"
+}
diff --git a/tests/throtl/007.out b/tests/throtl/007.out
new file mode 100644
index 0000000..d28cdef
--- /dev/null
+++ b/tests/throtl/007.out
@@ -0,0 +1,6 @@
+Running throtl/007
+1
+2
+1
+2
+Test complete
-- 
2.39.2

