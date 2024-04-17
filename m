Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60FC79FE
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320944; cv=none; b=BGYmx+FReWge5HhaHer+6JfAUO/+0JqhXLGcdVDmHZrrRytejiTvhTm2E1IjKXFlIAzJE0iiZOzqL4IkKrMuGX4kUrNExxrgPe5+hadQIU2P4FMAS5femhZdsaZRgTlXXIRHVlyCaFrUhVDlEW+Vb8GdHoA08+i66HNqFg4/M0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320944; c=relaxed/simple;
	bh=ZilNktfcTDIwUUPk10/qrvvnUQE4wcKVythWlrnq1Ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CLeGxjJZplq+6dwrqOUUSCAvYz7hGtm1C/q1Q1crmGvVGSE+rmT8i7UMGzgQEwp4K8yD+rFNQUE/vgLy51JnEmySN3gkHYhL8GBYeVoCXaDrOULkSbTZT4Z3H+rDyOKZvzlN35qlXeYU93tWsWDSX3XelFGIt1X3n3lfrz/DUos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VK4bL0YQHz4f3jJD
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 10:28:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 411F71A0BE2
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 10:28:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHiMx9mtJvAKA--.38748S6;
	Wed, 17 Apr 2024 10:28:53 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: saranyamohan@google.com,
	tj@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yangerkun@huawei.com
Subject: [PATCH v2 blktests 2/5] tests/throtl: add a new test 002
Date: Wed, 17 Apr 2024 10:20:02 +0800
Message-Id: <20240417022005.1410525-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240417022005.1410525-1-yukuai1@huaweicloud.com>
References: <20240417022005.1410525-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBHiMx9mtJvAKA--.38748S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4DZw1DXF1fuw4UurWUXFb_yoW8GF47pa
	y7KayFkF4xWFnrJry3G3W29a4rZws5Zr47A343Wr15ZFyqqw17KF1Iyr1SyFZ3JrW29r1F
	93WvqFZ5GF4DAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU=
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
index 0000000..83cd27f
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
+	if ! _set_up_test max_sectors=8; then
+		return 1;
+	fi
+
+	_set_limits wiops=256
+	_test_io write 1M 1
+	_remove_limits
+
+	_set_limits riops=256
+	_test_io read 1M 1
+	_remove_limits
+
+	_clean_up_test
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

