Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42242F9D82
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186227; cv=none; b=Or2wIqf1BHbmM9C8fFpEXzZbaMGKC1zht2tfpHWOPD0/fpCyKf0N1sQvWm8PihTKyi8kpRu9MxSqYho1xMsWVtM0S/tinn5/+IxMzH4KoOP6/ryTHxOY015MaRzeY+1M97Q24jAU9ZjUNO3kH8o3LYQOVj2f8JRgKoA9jzvXgW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186227; c=relaxed/simple;
	bh=fTJssQnlSSJNWyy0sV2yJqcoEcAf8tzHqQ3BpQfqWnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JhKAKYUbXBcZfnfa7YsJ/RQDyx5XBm/hHDLz6CLyUodqcobsLP2mQcl3RNawjc/qzePfxIjlbhIJelLjS7NNL+CUi/pJJEyRka8SwqsLDRBQ5vX9aH2kcvhhb+SJALAQpl1v9OVu79xCld4e6TyqjfrdBigeO+Lr2aCYJRbmJQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cS8nQ2J77zYQtvJ
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 17:03:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EAB2A1A0F2B
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 17:03:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDXIY7mystofFCkCw--.4335S5;
	Thu, 18 Sep 2025 17:03:36 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: linux-block@vger.kernel.org,
	shinichiro.kawasaki@wdc.com
Cc: nilay@linux.ibm.com,
	ming.lei@redhat.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 1/1] tests/throtl/004: add scsi_debug for test device
Date: Thu, 18 Sep 2025 16:53:41 +0800
Message-Id: <20250918085341.3686939-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250918085341.3686939-1-yukuai1@huaweicloud.com>
References: <20250918085341.3686939-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXIY7mystofFCkCw--.4335S5
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW3ArWxZw13CrWxKr4UArb_yoW8uFWUpF
	W5Ga1rKr4rCFnrAr1ayanrGFW3Xa1kJrW3C3y7A390yr1DXrW7G3ZFkrWUXFWrCF9xXFWx
	uFW8XFWrK3WUZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7qjgUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

While testing throtl manually, it's found there is a deadlock problem,
add this regression test.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 tests/throtl/004 | 20 ++++++++++++++++++++
 tests/throtl/rc  | 11 +++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/tests/throtl/004 b/tests/throtl/004
index d1461b9..05a1c9d 100755
--- a/tests/throtl/004
+++ b/tests/throtl/004
@@ -7,6 +7,7 @@
 # commit 8f9e7b65f833 ("block: cancel all throttled bios in del_gendisk()")
 
 . tests/throtl/rc
+. common/scsi_debug
 
 DESCRIPTION="delete disk while IO is throttled"
 QUICK=1
@@ -14,7 +15,12 @@ QUICK=1
 test() {
 	echo "Running ${TEST_NAME}"
 
+	if ! _configure_scsi_debug; then
+		return 1;
+	fi
+
 	if ! _set_up_throtl; then
+		_exit_scsi_debug
 		return 1;
 	fi
 
@@ -29,6 +35,20 @@ test() {
 	echo 0 > "/sys/kernel/config/nullb/$THROTL_DEV/power"
 	wait $!
 
+	echo "$(cat /sys/block/${SCSI_DEBUG_DEVICES[0]}/dev) wbps=$((1024 * 1024))" > \
+			"$CGROUP2_DIR/$THROTL_DIR/io.max"
+
+	{
+		echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
+		_throtl_issue_io write 10M 1 ${SCSI_DEBUG_DEVICES[0]} &> /dev/null
+	} &
+
+	sleep 0.6
+	echo 1 > "/sys/block/${SCSI_DEBUG_DEVICES[0]}/device/delete"
+	wait $!
+
 	_clean_up_throtl
+	_exit_scsi_debug
+
 	echo "Test complete"
 }
diff --git a/tests/throtl/rc b/tests/throtl/rc
index 327084b..5f9f1d7 100644
--- a/tests/throtl/rc
+++ b/tests/throtl/rc
@@ -98,13 +98,20 @@ _throtl_issue_io() {
 	local start_time
 	local end_time
 	local elapsed
+	local testdev
+
+	if [ $# -ge 4 ]; then
+		testdev=$4
+	else
+		testdev=$THROTL_DEV
+	fi
 
 	start_time=$(date +%s.%N)
 
 	if [ "$1" == "read" ]; then
-		dd if=/dev/$THROTL_DEV of=/dev/null bs="$2" count="$3" iflag=direct status=none
+		dd if=/dev/$testdev of=/dev/null bs="$2" count="$3" iflag=direct status=none
 	elif [ "$1" == "write" ]; then
-		dd of=/dev/$THROTL_DEV if=/dev/zero bs="$2" count="$3" oflag=direct status=none
+		dd of=/dev/$testdev if=/dev/zero bs="$2" count="$3" oflag=direct status=none
 	fi
 
 	end_time=$(date +%s.%N)
-- 
2.39.2

