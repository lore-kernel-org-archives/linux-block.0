Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8496913A244
	for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 01:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750123699; cv=none; b=ldGAFTQ0wuQ3KU8mVMM4dP9pYAuCEpI06cKDxeo2hgrUqO3GEidmqTwtW9dd0FgwA7be1cjzb1/odnSUO1U3eb5JcUXhYc0Xid33bOoKG6p89e1+FK+2gk2Cu16kuh9JtoQsP3WHSp0xglHe7MZefLdQXH3BTOGEYyjS8JtTPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750123699; c=relaxed/simple;
	bh=waMU2wFkC1QpjSSR1I8RR3nOriLDSDexqtuztX/kXyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fQs4pUsxpbeplv3fEf/FxR29aM2HbfRIS8kK0IYIRaSTY614d6SZBEKFtbwbkfhRK2A2XJ++MPJyAY/lvk2ZlhAAXZfbXN+rbgtZXyGjvF3iCQD4X4fg5WdLMmWhXlcI3Uze58MEvCj+vD3afD98kmE/BVq10+JTQqxnPuD3tV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bLq4v1Pn9zYQvWw
	for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 09:28:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2C70F1A193E
	for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 09:28:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBXul6sxFBotpgEPw--.20824S4;
	Tue, 17 Jun 2025 09:28:14 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: shinichiro.kawasaki@wdc.com,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	yukuai3@huawei.com
Cc: yangerkun@huawei.com,
	wozizhi@huaweicloud.com
Subject: [PATCH V2] tests/throtl: add a new test 007
Date: Tue, 17 Jun 2025 09:21:59 +0800
Message-Id: <20250617012159.3454463-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul6sxFBotpgEPw--.20824S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyDtr1xJr47Jr1kJry8AFb_yoW8ZF1kpF
	y7ua9YkF4xJ3ZrJFnxJa17uayFyws3ZF1UAw13Wrn8Zr1jq34UKF1Igr1rAFWfJFnrur48
	Z3WjqFykGF13AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Test the combination of bps and iops limits under io splitting scenarios.
Regression test for commit d1ba22ab2bec ("blk-throttle: Prevents the bps
restricted io from entering the bps queue again").

Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>
---
 tests/throtl/007     | 45 ++++++++++++++++++++++++++++++++++++++++++++
 tests/throtl/007.out |  6 ++++++
 2 files changed, 51 insertions(+)
 create mode 100755 tests/throtl/007
 create mode 100644 tests/throtl/007.out

diff --git a/tests/throtl/007 b/tests/throtl/007
new file mode 100755
index 0000000..ae59c6f
--- /dev/null
+++ b/tests/throtl/007
@@ -0,0 +1,45 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Zizhi Wo
+#
+# Test the combination of bps and iops limits under io splitting scenarios.
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
+	local page_size max_secs
+	page_size=$(getconf PAGE_SIZE)
+	max_secs=$((page_size / 512))
+
+	if ! _set_up_throtl max_sectors="${max_secs}"; then
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

