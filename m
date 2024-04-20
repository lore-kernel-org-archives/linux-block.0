Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755C14A83
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713603249; cv=none; b=rAAirem/NPW40iGam3LVsYGOpLJ4FfvLSIbrl1Z1910lNWtEfFwJI1yNHDW31PljIWIfeoEDZY+lxKzt8QoymaTfLoo1QI9wNZTMfGpJ7tp0jRsWImCVGsBzT/reW4mt3F0fV+CxbJlhiQjTb9hnRjehq4plwE+7/mGiBlSEfJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713603249; c=relaxed/simple;
	bh=6VofsT0Owod0SwNu1JDal8Ks16T7IBAuM6dwAj6s3Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jyB3+3nCn8WxdObH04iSYzmAYmBEeBmDxTX8vwa/Zf6eqSf+xyATj0ZWCVrIubJmYJRnvLbfjrndR2VpWlKnJ4nTTCsaEE7seZzoIfj+lvZ9T6DlaA0q1wtYGKMWJli/k0PkyWG+f/euStld1jyPZzuH32CUhzdEf9O1Cwt9mJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VM50N61tVz4f3khn
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 16:53:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2F5191A0175
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 16:54:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBGqgiNmW_HiKQ--.35908S6;
	Sat, 20 Apr 2024 16:54:04 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: saranyamohan@google.com,
	tj@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yangerkun@huawei.com
Subject: [PATCH v3 blktests 2/5] tests/throtl: add a new test 002
Date: Sat, 20 Apr 2024 16:45:02 +0800
Message-Id: <20240420084505.3624763-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240420084505.3624763-1-yukuai1@huaweicloud.com>
References: <20240420084505.3624763-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBGqgiNmW_HiKQ--.35908S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4DZw1DXF1fuw4UurWUXFb_yoW8Xr1Up3
	y7Ka1rKF4IgF9rJry3G3W7uayFyws3Zr47Aw13Xr15Zr1qqw17KF1Ivr1SyFWfJFZrur1F
	93WvqFWrGF4DJ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r106r15McIj6xkF7I0En7xvr7AKxVWUJVW8JwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU29aPUUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Test iops limit over IO split, regression tests for:

commit 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 tests/throtl/002     | 30 ++++++++++++++++++++++++++++++
 tests/throtl/002.out |  4 ++++
 2 files changed, 34 insertions(+)
 create mode 100755 tests/throtl/002
 create mode 100644 tests/throtl/002.out

diff --git a/tests/throtl/002 b/tests/throtl/002
new file mode 100755
index 0000000..8bbe18b
--- /dev/null
+++ b/tests/throtl/002
@@ -0,0 +1,30 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Yu Kuai
+#
+# Test iops limit work correctly for big IO of blk-throttle, regression test
+# for commit 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
+
+. tests/throtl/rc
+
+DESCRIPTION="iops limit over IO split"
+QUICK=1
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	if ! _set_up_throtl max_sectors=8; then
+		return 1;
+	fi
+
+	_throtl_set_limits wiops=256
+	_throtl_test_io write 1M 1
+	_throtl_remove_limits
+
+	_throtl_set_limits riops=256
+	_throtl_test_io read 1M 1
+	_throtl_remove_limits
+
+	_clean_up_throtl
+	echo "Test complete"
+}
diff --git a/tests/throtl/002.out b/tests/throtl/002.out
new file mode 100644
index 0000000..7e1ae85
--- /dev/null
+++ b/tests/throtl/002.out
@@ -0,0 +1,4 @@
+Running throtl/002
+1
+1
+Test complete
-- 
2.39.2

