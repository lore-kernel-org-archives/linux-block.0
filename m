Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F09101D4
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 02:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233379; cv=none; b=ncKEz6rhKnY645zj7uKc210Ljkpo/UG0x/wJN/zm60Y5VEk52OcwAcoWF6af4tpjcLexRY6Nw/c/y6M4+MAJqortT/okRKOr966jf0YX9dG1mSN6e0SMyLhqAyziZ1twGTyjN3NIrp204ZWjWrwz940ze/sR7P2TzW0GRzdM1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233379; c=relaxed/simple;
	bh=QY2UmapfjHqKpWTR86/iwDu8gIFov+9M/HigXIwD8c8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jYuP0EQfcWFJ7RGINDtvc4M4XSGV4OAYZ4Jdss1zWTEKC/BvvNXTS87ORywgLYupDrTMWUSoySJsCeOerEXyJ7bLChXXgNLwT+tmdvkDh12MxxAsEKZwL9HZyPWzsgHI1vWkgyXz8gjotSHtxCBBBsJxreu2iv1uNGCkcYHUQ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VJSCL14nYz4f3nV5
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:09:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 085AD1A0179
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:09:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7U3R1mMNVnKA--.11112S5;
	Tue, 16 Apr 2024 10:09:26 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: linux-block@vger.kernel.org,
	saranyamohan@google.com,
	axboe@kernel.dk,
	tj@kernel.org
Cc: yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yangerkun@huawei.com
Subject: [PATCH blktests 1/5] tests/throtl: add first test for blk-throttle
Date: Tue, 16 Apr 2024 10:00:38 +0800
Message-Id: <20240416020042.509291-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX5g7U3R1mMNVnKA--.11112S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4fJr1fAw48Gr4UXr1xAFb_yoW5XFy8pa
	yUWa1Fkr4xGFnrtFy3K3WUWayrZws3AF47A347Wr15Ar42q3yUtF12kw1UtrWrJFZFgFWr
	Za18XF4FkF18ZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Test basic functionality.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 tests/throtl/001     | 84 ++++++++++++++++++++++++++++++++++++++++++++
 tests/throtl/001.out |  6 ++++
 tests/throtl/rc      | 15 ++++++++
 3 files changed, 105 insertions(+)
 create mode 100755 tests/throtl/001
 create mode 100644 tests/throtl/001.out
 create mode 100644 tests/throtl/rc

diff --git a/tests/throtl/001 b/tests/throtl/001
new file mode 100755
index 0000000..79ecf07
--- /dev/null
+++ b/tests/throtl/001
@@ -0,0 +1,84 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Yu Kuai
+#
+# Test basic functionality of blk-throttle
+
+. tests/throtl/rc
+
+DESCRIPTION="basic functionality"
+QUICK=1
+
+CG=/sys/fs/cgroup
+TEST_DIR=$CG/blktests_throtl
+devname=nullb0
+dev=""
+
+set_up_test() {
+	if ! _init_null_blk nr_devices=1; then
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
+			dd if=/dev/$devname of=/dev/null bs=4k count=256 iflag=direct status=none
+		elif [ "$2" == "write" ]; then
+			dd of=/dev/$devname if=/dev/zero bs=4k count=256 oflag=direct status=none
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
+	_1MB=$((1024 * 1024))
+
+	test_io wbps=$_1MB write
+	test_io wiops=256 write
+	test_io rbps=$_1MB read
+	test_io riops=256 read
+
+	clean_up_test
+	echo "Test complete"
+}
diff --git a/tests/throtl/001.out b/tests/throtl/001.out
new file mode 100644
index 0000000..a3edfdd
--- /dev/null
+++ b/tests/throtl/001.out
@@ -0,0 +1,6 @@
+Running throtl/001
+1
+1
+1
+1
+Test complete
diff --git a/tests/throtl/rc b/tests/throtl/rc
new file mode 100644
index 0000000..8fa8b58
--- /dev/null
+++ b/tests/throtl/rc
@@ -0,0 +1,15 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Yu Kuai
+#
+# Tests for blk-throttle
+
+. common/rc
+. common/null_blk
+
+group_requires() {
+	_have_root
+	_have_null_blk
+	_have_kernel_option BLK_DEV_THROTTLING
+	_have_cgroup2_controller io
+}
-- 
2.39.2

