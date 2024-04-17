Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BED63A9
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 02:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320938; cv=none; b=MeAt4RV1JkWF/2ptZcwbWM36SZvk3rsK5U5iG9qldWAXMg3OaQfnpteeh6jkA+gC7im8OIN6vXr6fg7z/FXY+2hscqLBHf2RvmgpBYYIhc+mC7V9QDRNg/a8NhB9/BM8D83EV1GTWZ5a1PihTH/03Nl1rvh8BnCCvQOeT49xc74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320938; c=relaxed/simple;
	bh=Rs53PvVtWoj89AYAR6ac06EuH4mNAwmWrIzPjqdd988=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z88PCN/3thL2IKse29rJjFoCdzHeIplCY1B5/bmqLwx9a6Rx7vbW63Zju8AZhBjj1urVesYkvaK7j1jOlfeC9Pl9HIPyFrOSjaB01K09FkWqY1rE2QlXe7olIrNdlDkw/v7lMY+bew+6Ua/fB/BqhiROWmlF5TIBQ2oPAjMr9dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VK4bN2BySz4f3kkP
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 10:28:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E65A81A016E
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 10:28:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHiMx9mtJvAKA--.38748S5;
	Wed, 17 Apr 2024 10:28:52 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: saranyamohan@google.com,
	tj@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yangerkun@huawei.com
Subject: [PATCH v2 blktests 1/5] tests/throtl: add first test for blk-throttle
Date: Wed, 17 Apr 2024 10:20:01 +0800
Message-Id: <20240417022005.1410525-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBHiMx9mtJvAKA--.38748S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGw18KrWDWrykKryktr1kKrg_yoW5ZF45p3
	yUWFWFkr4xGFsrtr13K3W29a4rZw4kAFW7A3srGr15Zr42qrWUtF1Iyr1YyFWfJFy7WFWr
	Za10qFWkK3WUZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
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
 tests/throtl/001     | 39 ++++++++++++++++++++++++
 tests/throtl/001.out |  6 ++++
 tests/throtl/rc      | 71 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100755 tests/throtl/001
 create mode 100644 tests/throtl/001.out
 create mode 100644 tests/throtl/rc

diff --git a/tests/throtl/001 b/tests/throtl/001
new file mode 100755
index 0000000..739efe2
--- /dev/null
+++ b/tests/throtl/001
@@ -0,0 +1,39 @@
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
+test() {
+	echo "Running ${TEST_NAME}"
+
+	if ! _set_up_test nr_devices=1; then
+		return 1;
+	fi
+
+	bps_limit=$((1024 * 1024))
+
+	_set_limits wbps=$bps_limit
+	_test_io write 4k 256
+	_remove_limits
+
+	_set_limits wiops=256
+	_test_io write 4k 256
+	_remove_limits
+
+	_set_limits rbps=$bps_limit
+	_test_io read 4k 256
+	_remove_limits
+
+	_set_limits riops=256
+	_test_io read 4k 256
+	_remove_limits
+
+	_clean_up_test
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
index 0000000..871102c
--- /dev/null
+++ b/tests/throtl/rc
@@ -0,0 +1,71 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Yu Kuai
+#
+# Tests for blk-throttle
+
+. common/rc
+. common/null_blk
+
+CG=/sys/fs/cgroup
+TEST_DIR=$CG/blktests_throtl
+devname=nullb0
+
+group_requires() {
+	_have_root
+	_have_null_blk
+	_have_kernel_option BLK_DEV_THROTTLING
+	_have_cgroup2_controller io
+}
+
+# Create a new null_blk device, and create a new blk-cgroup for test.
+_set_up_test() {
+	if ! _init_null_blk "$*"; then
+		return 1;
+	fi
+
+	echo +io > $CG/cgroup.subtree_control
+	mkdir $TEST_DIR
+
+	return 0;
+}
+
+_clean_up_test() {
+	rmdir $TEST_DIR
+	echo -io > $CG/cgroup.subtree_control
+	_exit_null_blk
+}
+
+_set_limits() {
+	dev=$(cat /sys/block/$devname/dev)
+	echo "$dev $*" > $TEST_DIR/io.max
+}
+
+_remove_limits() {
+	dev=$(cat /sys/block/$devname/dev)
+	echo "$dev rbps=max wbps=max riops=max wiops=max" > $TEST_DIR/io.max
+}
+
+# Create an asynchronous thread and bind it to the specified blk-cgroup, issue
+# IO and then print time elapsed to the second, blk-throttle limits should be
+# set before this function.
+_test_io() {
+	{
+		sleep 0.1
+		start_time=$(date +%s.%N)
+
+		if [ "$1" == "read" ]; then
+			dd if=/dev/$devname of=/dev/null bs="$2" count="$3" iflag=direct status=none
+		elif [ "$1" == "write" ]; then
+			dd of=/dev/$devname if=/dev/zero bs="$2" count="$3" oflag=direct status=none
+		fi
+
+		end_time=$(date +%s.%N)
+		elapsed=$(echo "$end_time - $start_time" | bc)
+		printf "%.0f\n" "$elapsed"
+	} &
+
+	pid=$!
+	echo "$pid" > $TEST_DIR/cgroup.procs
+	wait $pid
+}
-- 
2.39.2

