Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADA71862BD
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741334886; cv=none; b=lSmMYFOo6BfAWYYbGCfqmHMi2fF3G+Sl+xpaek2MmhZYnv6SUobP5zYWBcEH6vS1TdRlRJ0CnZagPjnV+gO7gKfxqqkRTMLXH8vDo7THhqleMKAAnn5QyM/LrKsW6GLgMVSSZVSnd7w1/HYgmN9Y17kjr/YO6Ye7rzF/TR8q3Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741334886; c=relaxed/simple;
	bh=Bb6kk14AFjH6YbJ06jfANWCoHUjR7ZzsQ6haQN53kFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PQcNY4x2cLtewKkId5tFp0bsafTWVsx5pgrv88X8XoZ/j7a89C+M51Uw3oTrubHd1ePafDexcU2NxgC0cNV0ilH1Nk0NV0Q4A2ItsihWoKjYrZ3Nl8uYJ5/oSREWp1gCVthHXxKUhI6kYVv471qaVlT1m7bomA8bKrAk4x2gKFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z8Jmh1MY3z4f3jQv
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 16:07:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 609841A0D30
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 16:07:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGBYqcpn7EMnFw--.24390S5;
	Fri, 07 Mar 2025 16:07:54 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: shinichiro.kawasaki@wdc.com,
	ming.lei@redhat.com,
	linux-block@vger.kernel.org
Cc: yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC 1/2] tests/throtl: add a new test 007
Date: Fri,  7 Mar 2025 16:03:17 +0800
Message-Id: <20250307080318.3860858-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250307080318.3860858-1-yukuai1@huaweicloud.com>
References: <20250307080318.3860858-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXvGBYqcpn7EMnFw--.24390S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1kGw15XFyUZrWUtF1xAFb_yoW8ZFW8p3
	yYgF4rKF4xJ3ZFkrnxJ3WUGayrtw4rZF17Ary3Gr15Ar1jv347KF1Iyr4IyFyrJF4xWrW8
	ZF4vqFW8KF48AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
	1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	wksgUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Add test for IO merge over iops limit.

Noted this test will fail for now, kernel solution is in development.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 tests/throtl/007     | 65 ++++++++++++++++++++++++++++++++++++++++++++
 tests/throtl/007.out |  4 +++
 2 files changed, 69 insertions(+)
 create mode 100755 tests/throtl/007
 create mode 100644 tests/throtl/007.out

diff --git a/tests/throtl/007 b/tests/throtl/007
new file mode 100755
index 0000000..597f879
--- /dev/null
+++ b/tests/throtl/007
@@ -0,0 +1,65 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Yu Kuai
+#
+# Test iops limit over io merge
+
+. tests/throtl/rc
+
+DESCRIPTION="basic functionality"
+QUICK=1
+
+requires() {
+	_have_program taskset
+	_have_program fio
+}
+
+# every 16 0.5k IO will merge into one 8k IO, ideally runtime is 1s,
+# however it's about 1.3s in practice
+__fio() {
+	taskset -c 0 \
+	fio -filename=/dev/$THROTL_DEV \
+	-name=test \
+	-size=1600k \
+	-rw=write \
+	-bs=512 \
+	-iodepth=32 \
+	-iodepth_low=16 \
+	-iodepth_batch=16 \
+	-numjobs=1 \
+	-direct=1 \
+	-ioengine=io_uring &> /dev/null
+}
+
+test_io() {
+	start_time=$(date +%s.%N)
+
+	{
+		echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
+		__fio
+	} &
+
+	wait $!
+	end_time=$(date +%s.%N)
+	elapsed=$(echo "$end_time - $start_time" | bc)
+	printf "%.0f\n" "$elapsed"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	# iolatency is 10ms, iops is at most 200/s
+	if ! _set_up_throtl irqmode=2 completion_nsec=10000000 hw_queue_depth=2; then
+		return 1;
+	fi
+
+	test_io
+
+	# 300 means 50% error range, no IO should be throttled
+	_throtl_set_limits wiops=300
+	test_io
+	_throtl_remove_limits
+
+	_clean_up_throtl
+	echo "Test complete"
+}
diff --git a/tests/throtl/007.out b/tests/throtl/007.out
new file mode 100644
index 0000000..0d568ef
--- /dev/null
+++ b/tests/throtl/007.out
@@ -0,0 +1,4 @@
+Running throtl/007
+1
+1
+Test complete
-- 
2.39.2

