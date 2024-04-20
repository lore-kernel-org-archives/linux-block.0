Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6310F14A98
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713603249; cv=none; b=rkxuIgU2oTVmQAxNSmCW7hTCpv3nMcPZWRordvH270MfFYS71g2mBjPlhRlsPlYj5LW7SHfSR9EnNH4ra3QvYzOSc6OQrL5sHxp81YStrfas5rjlNTKNQe0VqRE67Yq7aOyqBp7SWGapm4HZ1EsjLhySfTRfCRtwbzwVyIbF/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713603249; c=relaxed/simple;
	bh=JX7BtuFfZ7/4NyL0YAncpwD7Gm2nyvXz8Lsh2PXvbMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dxa2ne/Kq1CpFhFQ2ClqNqTBv705SW8mbKwi5WxwwWDQM2RvVEJIzJPL3ach4JOazER+xxpnb6Zn0lckWU5ioh89Y67m+GUZS0pR2XuwWA62SPMQmo0HPIGYHejYshhumZBRDvWq1rilfLq6e/StQLsQX5H1325fKD69ogr3RxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VM50P5y6Nz4f3khy
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 16:53:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2EE281A0175
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 16:54:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBGqgiNmW_HiKQ--.35908S9;
	Sat, 20 Apr 2024 16:54:05 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: saranyamohan@google.com,
	tj@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yangerkun@huawei.com
Subject: [PATCH v3 blktests 5/5] tests/throtl: add a new test 005
Date: Sat, 20 Apr 2024 16:45:05 +0800
Message-Id: <20240420084505.3624763-6-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBGqgiNmW_HiKQ--.35908S9
X-Coremail-Antispam: 1UD129KBjvJXoW7tw13KryrJF48Wr4xtrWfAFb_yoW8XFWDpa
	y2ka1rKw4xWFnrKr1fGa17WFWrAw4kZr47A347Wr13ZFyjq3yUGr129w1IyFZ3tFnrZryx
	uF10qrW8KF4UA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VCY1x0262k0Y48FwI0_Jr0_Gr1lYx0Ex4A2jsIE14v26r1j
	6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI
	8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOa0P
	DUUUU
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
index 0000000..0778258
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
+	if ! _set_up_throtl; then
+		return 1;
+	fi
+
+	_throtl_set_limits wbps=$((512 * 1024))
+
+	{
+		sleep 0.1
+		_throtl_issue_io write 1M 1
+	} &
+
+	local pid=$!
+	echo "$pid" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
+
+	sleep 1
+	_throtl_set_limits wbps=$((256 * 1024))
+	wait $pid
+	_throtl_remove_limits
+
+	_clean_up_throtl
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

