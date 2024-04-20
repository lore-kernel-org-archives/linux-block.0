Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF0BC8C7
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713603249; cv=none; b=suNXUMWc/PpBHRaxVoLwvE9I459iptgN5W1x60M6QVM/mVe90ePtOUJ6ga/TCzdSPYGR3+otwLat+ydNf7AUIFoM6im6hmjVrpJUce74jWHnQ+J55e8dZlCex/pB/Ah1Q8zISe0/SIRhACnYEP/25MRTUVfcwBW+b50qp/zbUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713603249; c=relaxed/simple;
	bh=iYm4fXi54gLhCOnn0xUUW7yMkltuZ0/OPezsxkAVd+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=flaJbfw5ATiuBy72NE0hSkxP+Tlz+/Li1U1qkebQOQN+0LdQH0W0GQ0vWRRoFn3+Jsp0VkD1vi96ZOw4dSCmPEOfxfdcJ35bN/4NyJLobuqubYZ82jJ9n8gEOTBsqmnvwYlVvo6eaj/mU7t/IrtcEity0aOXj51tDVvxE9ROeg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VM50P3bC2z4f3khv
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 16:53:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D02BC1A0568
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 16:54:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBGqgiNmW_HiKQ--.35908S8;
	Sat, 20 Apr 2024 16:54:04 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: saranyamohan@google.com,
	tj@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yangerkun@huawei.com
Subject: [PATCH v3 blktests 4/5] tests/throtl: add a new test 004
Date: Sat, 20 Apr 2024 16:45:04 +0800
Message-Id: <20240420084505.3624763-5-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBGqgiNmW_HiKQ--.35908S8
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1xKrWxZFyDGw1UAFy5Jwb_yoW5uF48pr
	WrCF4rKw4fA3ZFkr13W3ZFvFWruws5ZrW3A347Cr4YyF47XrW8t3WIyr10qFyrCF9rXrWr
	ZF48XFW8KF4UZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOa0P
	DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Test delete the disk while IO is throttled, regression test for:

commit 884f0e84f1e3 ("blk-throttle: fix UAF by deleteing timer in blk_throtl_exit()")
commit 8f9e7b65f833 ("block: cancel all throttled bios in del_gendisk()")

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 tests/throtl/004     | 37 +++++++++++++++++++++++++++++++++++++
 tests/throtl/004.out |  4 ++++
 tests/throtl/rc      | 36 ++++++++++++++++++++++--------------
 3 files changed, 63 insertions(+), 14 deletions(-)
 create mode 100755 tests/throtl/004
 create mode 100644 tests/throtl/004.out

diff --git a/tests/throtl/004 b/tests/throtl/004
new file mode 100755
index 0000000..6e28612
--- /dev/null
+++ b/tests/throtl/004
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Yu Kuai
+#
+# Test delete the disk while IO is throttled, regerssion test for
+# commit 884f0e84f1e3 ("blk-throttle: fix UAF by deleteing timer in blk_throtl_exit()")
+# commit 8f9e7b65f833 ("block: cancel all throttled bios in del_gendisk()")
+
+. tests/throtl/rc
+
+DESCRIPTION="delete disk while IO is throttled"
+QUICK=1
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	if ! _set_up_throtl; then
+		return 1;
+	fi
+
+	_throtl_set_limits wbps=$((1024 * 1024))
+
+	{
+		sleep 0.1
+		_throtl_issue_io write 10M 1
+	} &
+
+	local pid=$!
+	echo "$pid" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
+
+	sleep 0.6
+	echo 0 > "/sys/kernel/config/nullb/$THROTL_DEV/power"
+	wait "$pid"
+
+	_clean_up_throtl
+	echo "Test complete"
+}
diff --git a/tests/throtl/004.out b/tests/throtl/004.out
new file mode 100644
index 0000000..e76ec3a
--- /dev/null
+++ b/tests/throtl/004.out
@@ -0,0 +1,4 @@
+Running throtl/004
+dd: error writing '/dev/dev_nullb': Input/output error
+1
+Test complete
diff --git a/tests/throtl/rc b/tests/throtl/rc
index 2ddbac8..2e26fd2 100644
--- a/tests/throtl/rc
+++ b/tests/throtl/rc
@@ -57,6 +57,24 @@ _throtl_remove_limits() {
 		"$CGROUP2_DIR/$THROTL_DIR/io.max"
 }
 
+_throtl_issue_io() {
+	local start_time
+	local end_time
+	local elapsed
+
+	start_time=$(date +%s.%N)
+
+	if [ "$1" == "read" ]; then
+		dd if=/dev/$THROTL_DEV of=/dev/null bs="$2" count="$3" iflag=direct status=none
+	elif [ "$1" == "write" ]; then
+		dd of=/dev/$THROTL_DEV if=/dev/zero bs="$2" count="$3" oflag=direct status=none
+	fi
+
+	end_time=$(date +%s.%N)
+	elapsed=$(echo "$end_time - $start_time" | bc)
+	printf "%.0f\n" "$elapsed"
+}
+
 # Create an asynchronous thread and bind it to the specified blk-cgroup, issue
 # IO and then print time elapsed to the second, blk-throttle limits should be
 # set before this function.
@@ -64,22 +82,12 @@ _throtl_test_io() {
 	local pid
 
 	{
-		local start_time
-		local end_time
-		local elapsed
+		local rw=$1
+		local bs=$2
+		local count=$3
 
 		sleep 0.1
-		start_time=$(date +%s.%N)
-
-		if [ "$1" == "read" ]; then
-			dd if=/dev/$THROTL_DEV of=/dev/null bs="$2" count="$3" iflag=direct status=none
-		elif [ "$1" == "write" ]; then
-			dd of=/dev/$THROTL_DEV if=/dev/zero bs="$2" count="$3" oflag=direct status=none
-		fi
-
-		end_time=$(date +%s.%N)
-		elapsed=$(echo "$end_time - $start_time" | bc)
-		printf "%.0f\n" "$elapsed"
+		_throtl_issue_io "$rw" "$bs" "$count"
 	} &
 
 	pid=$!
-- 
2.39.2

