Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F7014A8D
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713603249; cv=none; b=JwlKwtxkMvfKQv8jVPtizZn/VodVcAdxqg+aATu9cQtJ9MXkE9WqNSHg10p/kr/ea46UPBV3uGTAmxapJRSgL8wMONA409T5wo22Rt+yz2wdvx8iPBKwW4PuvYHYqv5bV8EHyO6IKejMKdZi1rGU8ZRKR22go5zU2Sa51XqQbCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713603249; c=relaxed/simple;
	bh=RjP/I5NNOFTjSZRoYqzsuleNX4tChazXWCb5zE60qzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZcU6mo12oMefafULagLZrJGI+wQcltWC0tczW1CBgS642/fze53T6cS+a7gBlnaBpMKfX45wI+LeRd0AHUwP+UAJxfGfJ4mWWNjuK/xZXdEUXbk0dp4hhEGYs5l+mxkwH7b3AsG9nizkZ8l6U/PYNqyr6QWm7eGY/NN22tufLtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VM50L5p1sz4f3lCm
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 16:53:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D355B1A0568
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 16:54:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBGqgiNmW_HiKQ--.35908S5;
	Sat, 20 Apr 2024 16:54:03 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: saranyamohan@google.com,
	tj@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yangerkun@huawei.com
Subject: [PATCH v3 blktests 1/5] tests/throtl: add first test for blk-throttle
Date: Sat, 20 Apr 2024 16:45:01 +0800
Message-Id: <20240420084505.3624763-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBGqgiNmW_HiKQ--.35908S5
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyUCr4ruF47Cr4xZw18Xwb_yoWrGF1fpr
	WUua1rKw4xJFsFyr13K3WUZFWrAws7ZF47A3srGr1Yyr47tw4Ygw42yryUXFWfAFnrXr4r
	Za18ZFWrCF1DZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r106r15McIj6xkF7I0En7xvr7AKxVWUJVW8JwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDManUUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Test basic functionality.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 tests/throtl/001     | 39 ++++++++++++++++++++
 tests/throtl/001.out |  6 +++
 tests/throtl/rc      | 88 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100755 tests/throtl/001
 create mode 100644 tests/throtl/001.out
 create mode 100644 tests/throtl/rc

diff --git a/tests/throtl/001 b/tests/throtl/001
new file mode 100755
index 0000000..835cac2
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
+	if ! _set_up_throtl; then
+		return 1;
+	fi
+
+	local bps_limit=$((1024 * 1024))
+
+	_throtl_set_limits wbps=$bps_limit
+	_throtl_test_io write 4k 256
+	_throtl_remove_limits
+
+	_throtl_set_limits wiops=256
+	_throtl_test_io write 4k 256
+	_throtl_remove_limits
+
+	_throtl_set_limits rbps=$bps_limit
+	_throtl_test_io read 4k 256
+	_throtl_remove_limits
+
+	_throtl_set_limits riops=256
+	_throtl_test_io read 4k 256
+	_throtl_remove_limits
+
+	_clean_up_throtl
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
index 0000000..2ddbac8
--- /dev/null
+++ b/tests/throtl/rc
@@ -0,0 +1,88 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Yu Kuai
+#
+# Tests for blk-throttle
+
+. common/rc
+. common/null_blk
+. common/cgroup
+
+THROTL_DIR=$(echo "$TEST_NAME" | tr '/' '_')
+THROTL_DEV=dev_nullb
+
+group_requires() {
+	_have_root
+	_have_null_blk
+	_have_kernel_option BLK_DEV_THROTTLING
+	_have_cgroup2_controller io
+	_have_program bc
+}
+
+# Create a new null_blk device, and create a new blk-cgroup for test.
+_set_up_throtl() {
+
+	if ! _configure_null_blk $THROTL_DEV "$@" power=1; then
+		return 1
+	fi
+
+	if ! _init_cgroup2; then
+		_exit_null_blk
+		return 1
+	fi
+
+	echo "+io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"
+	echo "+io" > "$CGROUP2_DIR/cgroup.subtree_control"
+
+	mkdir -p "$CGROUP2_DIR/$THROTL_DIR"
+	return 0;
+}
+
+_clean_up_throtl() {
+	rmdir "$CGROUP2_DIR/$THROTL_DIR"
+	echo "-io" > "$CGROUP2_DIR/cgroup.subtree_control"
+	echo "-io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"
+
+	_exit_cgroup2
+	_exit_null_blk
+}
+
+_throtl_set_limits() {
+	echo "$(cat /sys/block/$THROTL_DEV/dev) $*" > \
+		"$CGROUP2_DIR/$THROTL_DIR/io.max"
+}
+
+_throtl_remove_limits() {
+	echo "$(cat /sys/block/$THROTL_DEV/dev) rbps=max wbps=max riops=max wiops=max" > \
+		"$CGROUP2_DIR/$THROTL_DIR/io.max"
+}
+
+# Create an asynchronous thread and bind it to the specified blk-cgroup, issue
+# IO and then print time elapsed to the second, blk-throttle limits should be
+# set before this function.
+_throtl_test_io() {
+	local pid
+
+	{
+		local start_time
+		local end_time
+		local elapsed
+
+		sleep 0.1
+		start_time=$(date +%s.%N)
+
+		if [ "$1" == "read" ]; then
+			dd if=/dev/$THROTL_DEV of=/dev/null bs="$2" count="$3" iflag=direct status=none
+		elif [ "$1" == "write" ]; then
+			dd of=/dev/$THROTL_DEV if=/dev/zero bs="$2" count="$3" oflag=direct status=none
+		fi
+
+		end_time=$(date +%s.%N)
+		elapsed=$(echo "$end_time - $start_time" | bc)
+		printf "%.0f\n" "$elapsed"
+	} &
+
+	pid=$!
+	echo "$pid" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
+	wait $pid
+}
-- 
2.39.2

