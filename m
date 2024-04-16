Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F754101E2
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 02:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233379; cv=none; b=mtJYAeCKd6iuka+FBTBAm/1Z/Ww0BfS1X4NM3glkR0ZOivKciAW4stkcYYZnZXO2nLUXNXaygOYeDkEGtMcLmKlECWmRI5llwNFj4kC9o8aTvu9/s/yp5OQAGJ36Q7hJWJnfVmtVpB7x+oFZZGLiEmtlXx5Mndjqw2a0AXf3m2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233379; c=relaxed/simple;
	bh=5R5XIlFRSueQFPENVDXwCkXhhyDD4OCbFLx1d1JaQe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SDxZz4q+fGXT+220DXCngrdpB46TJpG7H9Ev9QBsqPZA+sRzoVvkLq6w66HKGsh5dkNW7G0IIFOFGQP0v+ozf+tRexLU7K51P88qmtfqfHuEA/hG6i2jE7Vd68XOnlNvMOM2xwHhFhnR0mwrKIWHAViTFcqJq5q82HU3US0ITzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VJSCM12QPz4f3nVC
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:09:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 05B3F1A0568
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:09:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7U3R1mMNVnKA--.11112S8;
	Tue, 16 Apr 2024 10:09:27 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: linux-block@vger.kernel.org,
	saranyamohan@google.com,
	axboe@kernel.dk,
	tj@kernel.org
Cc: yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yangerkun@huawei.com
Subject: [PATCH blktests 4/5] tests/throtl: add a new test 004
Date: Tue, 16 Apr 2024 10:00:41 +0800
Message-Id: <20240416020042.509291-5-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX5g7U3R1mMNVnKA--.11112S8
X-Coremail-Antispam: 1UD129KBjvJXoW7ur43Zw4xKw1xtFW5ArWfuFg_yoW5JF1xpr
	WUGa1Fyr4xCFnIqr13KanrZayrZws5Zr4Sy3srJr1SyFyjq34UJr1Ikr1SvFZ5CF9xWryr
	ZF48XrWfK3W8GrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Test delete the disk while IO is throttled, regerssion test for:

commit 884f0e84f1e3 ("blk-throttle: fix UAF by deleteing timer in blk_throtl_exit()")
commit 8f9e7b65f833 ("block: cancel all throttled bios in del_gendisk()")

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 tests/throtl/004     | 79 ++++++++++++++++++++++++++++++++++++++++++++
 tests/throtl/004.out |  4 +++
 2 files changed, 83 insertions(+)
 create mode 100755 tests/throtl/004
 create mode 100644 tests/throtl/004.out

diff --git a/tests/throtl/004 b/tests/throtl/004
new file mode 100755
index 0000000..d07f9d5
--- /dev/null
+++ b/tests/throtl/004
@@ -0,0 +1,79 @@
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
+CG=/sys/fs/cgroup
+TEST_DIR=$CG/blktests_throtl
+devname=nullb0
+dev=""
+
+set_up_test() {
+	if ! _init_null_blk nr_devices=0; then
+		return 1;
+	fi
+
+	if ! _configure_null_blk $devname power=1; then
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
+	limit=$((1024 * 1024))
+	echo "$dev wbps=$limit" > $TEST_DIR/io.max
+}
+
+test_io() {
+	config_throtl
+
+	{
+		sleep 0.1
+		start_time=$(date +%s.%N)
+
+		dd of=/dev/$devname if=/dev/zero bs=10M count=1 oflag=direct status=none
+
+		end_time=$(date +%s.%N)
+		elapsed=$(echo "$end_time - $start_time" | bc)
+		printf "%.0f\n" "$elapsed"
+	} &
+
+	pid=$!
+	echo $! > $TEST_DIR/cgroup.procs
+
+	sleep 1
+	echo 0 > /sys/kernel/config/nullb/$devname/power
+	wait $pid
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
diff --git a/tests/throtl/004.out b/tests/throtl/004.out
new file mode 100644
index 0000000..03331fe
--- /dev/null
+++ b/tests/throtl/004.out
@@ -0,0 +1,4 @@
+Running throtl/004
+dd: error writing '/dev/nullb0': Input/output error
+1
+Test complete
-- 
2.39.2

