Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CFB101F7
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 02:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233378; cv=none; b=K1mSNChD+VaVv2vNi7PGiYlTYvnmXhaErXM//JNt29+g89zLWeHV4mkG82EGGQ3Lx5aWQfHQigsuSHupi/t26ed2NFmxfgZpzh6TUpW0Bi6SiiNxUZrJT0hN6aurzCS6FU9u/pyJoEd2rdQ3aW+LUU+rLY2R1AgbNOHk0bkNoFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233378; c=relaxed/simple;
	bh=+VXmHkl213wIRecrSZqEMt4BydB/UNzEFVl5mcTm5IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qFuLxJtXdZSFBYNbl3oksbFJBXjsR5w6Si2HNgsfnM4Qt9JvI6+D44sN4hLnP/K8HXvk9KVc5j9cTXFidqDUjVQIywFB9JHErpVz1MHbvicJrmlvcuwct8gM7zq7ANZJ7jqXqjR6dZb7pwmdcwbMhmh1YdM2CSGm2cdJDLJbpFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VJSCR5LBsz4f3lXl
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:09:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 57D241A10BA
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:09:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7U3R1mMNVnKA--.11112S9;
	Tue, 16 Apr 2024 10:09:28 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: linux-block@vger.kernel.org,
	saranyamohan@google.com,
	axboe@kernel.dk,
	tj@kernel.org
Cc: yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yangerkun@huawei.com
Subject: [PATCH blktests 5/5] tests/throtl: add a new test 005
Date: Tue, 16 Apr 2024 10:00:42 +0800
Message-Id: <20240416020042.509291-6-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX5g7U3R1mMNVnKA--.11112S9
X-Coremail-Antispam: 1UD129KBjvJXoW7tw13KryrJr48CF4rtryftFb_yoW8KFy7pa
	y7CF4rKw48WFsxtr43Ka17WFWfXws5Ar4xA3srGr1FyF12q34UKr1Iyw1xtF93tFnxuryr
	Za4rXFWkKF18urDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
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
 tests/throtl/005     | 83 ++++++++++++++++++++++++++++++++++++++++++++
 tests/throtl/005.out |  3 ++
 2 files changed, 86 insertions(+)
 create mode 100755 tests/throtl/005
 create mode 100644 tests/throtl/005.out

diff --git a/tests/throtl/005 b/tests/throtl/005
new file mode 100755
index 0000000..6caac99
--- /dev/null
+++ b/tests/throtl/005
@@ -0,0 +1,83 @@
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
+	limit=$((512 * 1024))
+	config_throtl wbps=$limit
+
+	{
+		sleep 0.1
+		start_time=$(date +%s.%N)
+
+		dd of=/dev/$devname if=/dev/zero bs=1M count=1 oflag=direct status=none
+
+		# old limit is 512k, issue 1M IO, swith to new limit 215k after 1s
+		# expected wait time is 3s
+		end_time=$(date +%s.%N)
+		elapsed=$(echo "$end_time - $start_time" | bc)
+		printf "%.0f\n" "$elapsed"
+	} &
+
+	pid=$!
+	echo $! > $TEST_DIR/cgroup.procs
+
+	sleep 1
+	limit=$((256 * 1024))
+	config_throtl wbps=$limit
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
+	test_io
+
+	clean_up_test
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

