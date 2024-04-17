Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0549A6FA8
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320938; cv=none; b=ruRYLMS7Gy5UmjiLnnpzMKo2Qkc9WkREwkYAXZBmwjKpaTnW/znFwL78J5fCmSOwgLh1YvSmGF3aQYoCkUHsuRcjKP5WC8yNradNHOLIHHuozctKSgcZajcqPmCRoveTCo0QmgP75zRjKDRWM17VQd3voroaezF8qAJU8MCoRk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320938; c=relaxed/simple;
	bh=Vgv55XaMpM+582oe5iGGYUY4yeDTxWAZXfZLzwQOUpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BWFtZ5at3DDqiFPBaTXhv4jafRD2cwigXs3KAT2JE2/pJqEQ9XNqifsBpnDdjdCxU+Hx0VauBQFg/iquhsYLNB3uH73uIkp87OLWt5THlGMr5VjJFKbEATFCnZJSZSYFuvf1hlP4HxTZkgGYa+2dWLu5fbBVbt5Uf9KN0a+VYRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VK4bK0Gmtz4f3nKV
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 10:28:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EA3331A0175
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 10:28:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHiMx9mtJvAKA--.38748S8;
	Wed, 17 Apr 2024 10:28:53 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: saranyamohan@google.com,
	tj@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yangerkun@huawei.com
Subject: [PATCH v2 blktests 4/5] tests/throtl: add a new test 004
Date: Wed, 17 Apr 2024 10:20:04 +0800
Message-Id: <20240417022005.1410525-5-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBHiMx9mtJvAKA--.38748S8
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1xKrWxZFyDGw1UtFWkWFg_yoW5tw4xpr
	WUCF4Fyr4xAFnrZr13G3ZI9FWfZr4kAFWxA3srCr15AF1jgrW8tF12kr10vFWrCF9rWryr
	ZF48XFWxKa18ZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 tests/throtl/004     | 37 +++++++++++++++++++++++++++++++++++
 tests/throtl/004.out |  4 ++++
 tests/throtl/rc      | 46 +++++++++++++++++++++++++++++++++-----------
 3 files changed, 76 insertions(+), 11 deletions(-)
 create mode 100755 tests/throtl/004
 create mode 100644 tests/throtl/004.out

diff --git a/tests/throtl/004 b/tests/throtl/004
new file mode 100755
index 0000000..f2567c0
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
+	if ! _set_up_test_by_configfs power=1; then
+		return 1;
+	fi
+
+	_set_limits wbps=$((1024 * 1024))
+
+	{
+		sleep 0.1
+		_issue_io write 10M 1
+	} &
+
+	pid=$!
+	echo "$pid" > $TEST_DIR/cgroup.procs
+
+	sleep 1
+	echo 0 > /sys/kernel/config/nullb/$devname/power
+	wait "$pid"
+
+	_clean_up_test
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
diff --git a/tests/throtl/rc b/tests/throtl/rc
index 871102c..f70e250 100644
--- a/tests/throtl/rc
+++ b/tests/throtl/rc
@@ -30,6 +30,21 @@ _set_up_test() {
 	return 0;
 }
 
+_set_up_test_by_configfs() {
+	if ! _init_null_blk nr_devices=0; then
+		return 1;
+	fi
+
+	if ! _configure_null_blk $devname "$*"; then
+		return 1;
+	fi
+
+	echo +io > $CG/cgroup.subtree_control
+	mkdir $TEST_DIR
+
+	return 0;
+}
+
 _clean_up_test() {
 	rmdir $TEST_DIR
 	echo -io > $CG/cgroup.subtree_control
@@ -46,23 +61,32 @@ _remove_limits() {
 	echo "$dev rbps=max wbps=max riops=max wiops=max" > $TEST_DIR/io.max
 }
 
+_issue_io()
+{
+	start_time=$(date +%s.%N)
+
+	if [ "$1" == "read" ]; then
+		dd if=/dev/$devname of=/dev/null bs="$2" count="$3" iflag=direct status=none
+	elif [ "$1" == "write" ]; then
+		dd of=/dev/$devname if=/dev/zero bs="$2" count="$3" oflag=direct status=none
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
 _test_io() {
 	{
-		sleep 0.1
-		start_time=$(date +%s.%N)
+		rw=$1
+		bs=$2
+		count=$3
 
-		if [ "$1" == "read" ]; then
-			dd if=/dev/$devname of=/dev/null bs="$2" count="$3" iflag=direct status=none
-		elif [ "$1" == "write" ]; then
-			dd of=/dev/$devname if=/dev/zero bs="$2" count="$3" oflag=direct status=none
-		fi
-
-		end_time=$(date +%s.%N)
-		elapsed=$(echo "$end_time - $start_time" | bc)
-		printf "%.0f\n" "$elapsed"
+		sleep 0.1
+		_issue_io "$rw" "$bs" "$count"
 	} &
 
 	pid=$!
-- 
2.39.2

