Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB546FBE
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 02:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320938; cv=none; b=F3XP7ChDrTSNUfCsj9zcL5aLV1SXlSEgD81w+Jmjo4VToWAh0JOFiuUPQr1a3vlzLzjKxoRlCtCXnEoOGfQoER+YY2W1zBkpO3mV/RW1Mt86IInpwLJ96hKzfj/5D9O/uBwV72yxb4Fstq9HUiw3NC2MOreYiz7N4wYW+U86Yqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320938; c=relaxed/simple;
	bh=M/yDhWAvN868jyzyqCs8S/BdaNUmTOLOiP2hKqzU270=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fHHCBpbio4BIzKJvlRuqQ8F7ktPEh5sPL4Miq/qg2nfRyFPohtwP//6X+G8kOPdIm6DXUs9BLGtxdPTQK79iS8EKq966+kqIc05h62YCf8tFk6oE9CJjslpRhtEI2/maZWSxxofKDUctSeeBo/7E1iNUoZitQKxyFAPNL0jh7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VK4bP4dbXz4f3mW2
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 10:28:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 465D91A058D
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 10:28:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHiMx9mtJvAKA--.38748S9;
	Wed, 17 Apr 2024 10:28:54 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: saranyamohan@google.com,
	tj@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yangerkun@huawei.com
Subject: [PATCH v2 blktests 5/5] tests/throtl: add a new test 005
Date: Wed, 17 Apr 2024 10:20:05 +0800
Message-Id: <20240417022005.1410525-6-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBHiMx9mtJvAKA--.38748S9
X-Coremail-Antispam: 1UD129KBjvJXoW7tw13KryrJF48Wr4xtrWfAFb_yoW8XrW3pa
	y2ka1Fkw4xWFnrKr4fGa17WayrZr4kZr4UA3srWr13ZFyjq34UGFn2gw1IyrZayFnrZryx
	u3W0qFW8KF4UZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Test change config while IO is throttled, regression test for:

commit a880ae93e5b5 ("blk-throttle: fix io hung due to configuration updates")

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 tests/throtl/005     | 37 +++++++++++++++++++++++++++++++++++++
 tests/throtl/005.out |  3 +++
 2 files changed, 40 insertions(+)
 create mode 100755 tests/throtl/005
 create mode 100644 tests/throtl/005.out

diff --git a/tests/throtl/005 b/tests/throtl/005
new file mode 100755
index 0000000..5ee5e7d
--- /dev/null
+++ b/tests/throtl/005
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Yu Kuai
+#
+# Test change config while IO is throttled, regression test for
+# commit a880ae93e5b5 ("blk-throttle: fix io hung due to configuration updates")
+
+. tests/throtl/rc
+
+DESCRIPTION="change config with throttled IO"
+QUICK=1
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	if ! _set_up_test nr_devices=1; then
+		return 1;
+	fi
+
+	_set_limits wbps=$((512 * 1024))
+
+	{
+		sleep 0.1
+		_issue_io write 1M 1
+	} &
+
+	pid=$!
+	echo "$pid" > $TEST_DIR/cgroup.procs
+
+	sleep 1
+	_set_limits wbps=$((256 * 1024))
+	wait $pid
+	_remove_limits
+
+	_clean_up_test
+	echo "Test complete"
+}
diff --git a/tests/throtl/005.out b/tests/throtl/005.out
new file mode 100644
index 0000000..1d23210
--- /dev/null
+++ b/tests/throtl/005.out
@@ -0,0 +1,3 @@
+Running throtl/005
+3
+Test complete
-- 
2.39.2

