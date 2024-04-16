Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94899107A6
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 02:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233378; cv=none; b=LlLGa/ZY/2Ytat3KzOlsYjuCv/qFkLPyjYljX8zkvdJtzq6ybM76zDFlewDDqvDoGCIqnK32tXKAv0c4gn2uRREfE0UFiBHrhUloH8zSbbEKpwhPXtzjX3BJ3Al7ujfxo2DiAReE4J6MWz1l8gW9J+Yny7bosK2WMJgqv0CZiU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233378; c=relaxed/simple;
	bh=ZCcOZ0EfdxN6M+eQ+PeubeyX5Yxm8vec6Pj6kVsb1bs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xoe6pW0Q1fb9Ql5j7K3fGPM1297z8+rkL15u481TcajYSuksTx+jI7wiQHVuFg4JnlY/QK4dNP1KsZXq5M59+1sKHQXTzI4p7MXWM/flLxV/mIcvyiXZE4HhmNq2aK1uBmbwcAMO/ayAIQvTNCZ0k22GWvgLuIjGWwLJI2vaflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VJSCQ5LXbz4f3lX6
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:09:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 55FC51A016E
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:09:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7U3R1mMNVnKA--.11112S6;
	Tue, 16 Apr 2024 10:09:27 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: linux-block@vger.kernel.org,
	saranyamohan@google.com,
	axboe@kernel.dk,
	tj@kernel.org
Cc: yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yangerkun@huawei.com
Subject: [PATCH blktests 2/5] tests/throtl: add a new test 002
Date: Tue, 16 Apr 2024 10:00:39 +0800
Message-Id: <20240416020042.509291-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240416020042.509291-1-yukuai1@huaweicloud.com>
References: <20240416020042.509291-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g7U3R1mMNVnKA--.11112S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4DZw47Gw4kCr15Cw4kZwb_yoW8KF1xpF
	WUGF4rKF48WFnrtFy3t3Wj9ayrZws5ArW7A343Xr1FvFnFv3y7KF1Iyr1IyFWfGr9rWr1r
	Za1vqFZ5K3WUX37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
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
 tests/throtl/002     | 81 ++++++++++++++++++++++++++++++++++++++++++++
 tests/throtl/002.out |  4 +++
 2 files changed, 85 insertions(+)
 create mode 100755 tests/throtl/002
 create mode 100644 tests/throtl/002.out

diff --git a/tests/throtl/002 b/tests/throtl/002
new file mode 100755
index 0000000..e0df4b8
--- /dev/null
+++ b/tests/throtl/002
@@ -0,0 +1,81 @@
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
+CG=/sys/fs/cgroup
+TEST_DIR=$CG/blktests_throtl
+devname=nullb0
+dev=""
+
+set_up_test() {
+	if ! _init_null_blk max_sectors=8; then
+		return 1;
+	fi
+
+	dev=$(cat /sys/block/$devname/dev)
+	echo +io > $CG/cgroup.subtree_control
+	mkdir $TEST_DIR
+
+	return 0;
+}
+
+clean_up_test() {
+	rmdir $TEST_DIR
+	echo -io > $CG/cgroup.subtree_control
+	_exit_null_blk
+}
+
+config_throtl() {
+	echo "$dev $*" > $TEST_DIR/io.max
+}
+
+remove_config() {
+	echo "$dev rbps=max wbps=max riops=max wiops=max" > $TEST_DIR/io.max
+}
+
+test_io() {
+	config_throtl "$1"
+
+	{
+		sleep 0.1
+		start_time=$(date +%s.%N)
+
+		if [ "$2" == "read" ]; then
+			dd if=/dev/$devname of=/dev/null bs=1M count=1 iflag=direct status=none
+		elif [ "$2" == "write" ]; then
+			dd of=/dev/$devname if=/dev/zero bs=1M count=1 oflag=direct status=none
+		fi
+
+		end_time=$(date +%s.%N)
+		elapsed=$(echo "$end_time - $start_time" | bc)
+		printf "%.0f\n" "$elapsed"
+	} &
+
+	pid=$!
+	echo $! > $TEST_DIR/cgroup.procs
+	wait $pid
+
+	remove_config
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	if ! set_up_test; then
+		return 1;
+	fi
+
+	test_io wiops=256 write
+	test_io riops=256 read
+
+	clean_up_test
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

