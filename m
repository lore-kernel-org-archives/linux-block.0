Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A772A157A48
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741334886; cv=none; b=Do99/0HPxE/lYnEx08DttrmVdlP5GQfoRmg5i+29RtIMQnv9pXxgU9XgS1NuaLYCQr6RT8Z80OYXSjkRCYAUFNhmtMESjMBio+hw7zPfcW62UOnoyt8XJXv1NR1DyUHJ7WG2pKfGiHH468/nLfsNxVp/ioFjQaYdMVf4PmSBooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741334886; c=relaxed/simple;
	bh=mPpCT33HXQIpVaS3vi7PCC7IIC7cPdvQnRtIdFGrS3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PFugpjlHy0AC+k0N9vVL1cuT9w1ULAp642HkRqAWAGq5fUvIEcXo6eF3PjHeV/YNGxCWPP9Tc9jhBkQPSEiZl9GweZsCOUzJAtLTxrZmS64NXTjzgnJPCcw/UnFFFJEYo1LII5X07Bh1SK2KW6maPsg5STW1BAyhAezu+JshmHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z8Jmn5hdjz4f3jtJ
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 16:07:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A1F711A058E
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 16:07:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGBYqcpn7EMnFw--.24390S6;
	Fri, 07 Mar 2025 16:07:54 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: shinichiro.kawasaki@wdc.com,
	ming.lei@redhat.com,
	linux-block@vger.kernel.org
Cc: yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC 2/2] tests/throtl: add a new test 008
Date: Fri,  7 Mar 2025 16:03:18 +0800
Message-Id: <20250307080318.3860858-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250307080318.3860858-1-yukuai1@huaweicloud.com>
References: <20250307080318.3860858-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXvGBYqcpn7EMnFw--.24390S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4fZry7Xr1fGw45uFyUWrg_yoW8WFykpr
	y7CanY9r4IgF9rJFy3G3W7CayFyw4kuF17A3W3Wrn8Ar1jgw1UGF1I9r10yFWfJF1xWr18
	Z3WqqFykGF47ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
	1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	7PfHUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Test that a high iops limit won't affect bps limit.

Noted this test will fail for now, kernel solution is in development.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 tests/throtl/008     | 39 +++++++++++++++++++++++++++++++++++++++
 tests/throtl/008.out |  6 ++++++
 2 files changed, 45 insertions(+)
 create mode 100755 tests/throtl/008
 create mode 100644 tests/throtl/008.out

diff --git a/tests/throtl/008 b/tests/throtl/008
new file mode 100755
index 0000000..c64f427
--- /dev/null
+++ b/tests/throtl/008
@@ -0,0 +1,39 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Yu Kuai
+#
+# Test bps limit with iops limit over io split
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
diff --git a/tests/throtl/008.out b/tests/throtl/008.out
new file mode 100644
index 0000000..72f4db1
--- /dev/null
+++ b/tests/throtl/008.out
@@ -0,0 +1,6 @@
+Running throtl/008
+1
+2
+1
+2
+Test complete
-- 
2.39.2

