Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86FB63CB
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320938; cv=none; b=L88MQO+a7DtSplW4DJiLzxddXpYgCHspFOgmhRSSR5ebsHdq5FLxj08BIpqN3CfQe/sNRGmzaKQ4GyB3LlJ++XvmZY3rSwaTw1YcUKcdkzMByC/X6RWBZ532DD7pT13moVYkUVKYZ+VOpCDh4E3tkzywLyYqePMn9e7PIMuLpGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320938; c=relaxed/simple;
	bh=YL0ObOK5sPewSKe0oyK5ramBDsXlgInE1mhUljGimVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fVYAd1IwQ2n+r7YWVsmmT+rg1JpsONmaoVf0lMS9YMy6XewASH5XFjcxHxqeIkJF6dX5R1qtepbzCy/biz1bp0BH1R5IFwujPBjgVCINNkmmP4Kd6PZ6C2fUuxC53kiZ/ZPHqtamMMIjH31J8eguQ/K5wh4KOoEDFZRA7IrfC0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VK4bJ4xk8z4f3mJ5
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 10:28:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 955EA1A0179
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 10:28:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHiMx9mtJvAKA--.38748S7;
	Wed, 17 Apr 2024 10:28:53 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: saranyamohan@google.com,
	tj@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yangerkun@huawei.com
Subject: [PATCH v2 blktests 3/5] tests/throtl: add a new test 003
Date: Wed, 17 Apr 2024 10:20:03 +0800
Message-Id: <20240417022005.1410525-4-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBHiMx9mtJvAKA--.38748S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4DJFW3CFyxAw1UtF1kKrg_yoW8GFyxp3
	y2kayrKr4xKFnrJr4fGa17WayfZws5Zr47Aw1xWr13ZFyIq345Wr1Iyr1SyFZ3JF12qr1r
	Z3WjqFZ5KFsrJFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Test bps limit over IO split, regression tests for:

commit 111be8839817 ("block-throttle: avoid double charge")

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 tests/throtl/003     | 32 ++++++++++++++++++++++++++++++++
 tests/throtl/003.out |  4 ++++
 2 files changed, 36 insertions(+)
 create mode 100755 tests/throtl/003
 create mode 100644 tests/throtl/003.out

diff --git a/tests/throtl/003 b/tests/throtl/003
new file mode 100755
index 0000000..806b602
--- /dev/null
+++ b/tests/throtl/003
@@ -0,0 +1,32 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Yu Kuai
+#
+# Test bps limit work correctly for big IO of blk-throttle, regression test for
+# commit 111be8839817 ("block-throttle: avoid double charge")
+
+. tests/throtl/rc
+
+DESCRIPTION="bps limit over IO split"
+QUICK=1
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	if ! _set_up_test max_sectors=8; then
+		return 1;
+	fi
+
+	limit=$((1024 * 1024))
+
+	_set_limits wbps=$limit
+	_test_io write 1M 1
+	_remove_limits
+
+	_set_limits rbps=$limit
+	_test_io read 1M 1
+	_remove_limits
+
+	_clean_up_test
+	echo "Test complete"
+}
diff --git a/tests/throtl/003.out b/tests/throtl/003.out
new file mode 100644
index 0000000..07a80b3
--- /dev/null
+++ b/tests/throtl/003.out
@@ -0,0 +1,4 @@
+Running throtl/003
+1
+1
+Test complete
-- 
2.39.2

