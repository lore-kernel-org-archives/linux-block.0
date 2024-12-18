Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F9158853
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734529741; cv=none; b=gxxZPYayjTHM1ecqmJQf3EkKZQN/9YBinfY+oGz5NGVC8iACSl9ajSuiCnCmJx6Q87B+1iSNlI6sXveBxyQkIvvNFnDnHnBThyq6Dv/DV/D2hEvyiXtArPSxblC7XAXKdezK9xerEenoNrBDMzIohUtoSm6bJod1v9kW+fBaPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734529741; c=relaxed/simple;
	bh=9ziGMtUxb9G4RpQP8pJEKwR+fHLxvKA9XA1MHnLmcXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyn/tb/R/X9XdJUJKZJekB21GxouPW1LCySYS8PZfxnComACYdCjzfw8sevjn8PuC6W9O35cTc/KmuezK9mysbfkUoq8BgS9opkRFETenzBwqGCHpMsnVn0lWEOirVIvmCzGdJHqE0r2ZylM73+1oIesR4xP9vZKHLlnDRNLg9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KijQs5wu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KijQs5wu"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BICvnaA032381;
	Wed, 18 Dec 2024 13:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9L/6f5TRlcyaS+aNY
	zHctSQ4jp6WHZNaa3IqBO9hSYQ=; b=KijQs5wuVGinCYqfPWYftaggDK+eekAu0
	L2X9VAPcrow96xuJtHRtvEx0MlLuF8Gm1kIiBMJ4+ce+7aq9DOejmQXupKrcAZln
	KFmeR5F8vxJ9HXgT/UNcaknCCvB+aFjD1NJXtRce/C/zGPNqEvSe6jef37LyfnWt
	lae55Oz4nwqEWovtW4n5mfOnvjbG/OnqrPuSR7y02OqdrXzWmUo/KkTWP/VPiIvq
	LnwGzmmAZBsmDoet/469vutEbhRg7qe1eZffKCzDG/VeHgtq5jh7ZdITc7ncuuLw
	mY/rR6ud5gg4KNiK2g9FJlcbqofFBIFSAVPFd/vFO+QcvKEQ5CX2g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kkehb7d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 13:43:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BICFZ5T014350;
	Wed, 18 Dec 2024 13:43:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqy87bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 13:43:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIDhUgX58917336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 13:43:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6F9F2004B;
	Wed, 18 Dec 2024 13:43:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C8F620040;
	Wed, 18 Dec 2024 13:43:29 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Dec 2024 13:43:29 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: yukuai3@huawei.com, shinichiro.kawasaki@wdc.com, yi.zhang@redhat.com,
        bvanassche@acm.org, gjoyce@ibm.com
Subject: [PATCHv2 blktests 1/2] throtl/002: calculate block-size based on device max-sectors setting
Date: Wed, 18 Dec 2024 19:13:21 +0530
Message-ID: <20241218134326.2164105-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218134326.2164105-1-nilay@linux.ibm.com>
References: <20241218134326.2164105-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vUMIsd2p6HhE7Q_-ewL5UJBDxzZ4-xwd
X-Proofpoint-ORIG-GUID: vUMIsd2p6HhE7Q_-ewL5UJBDxzZ4-xwd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412180106

The commit 60fa2e3ff3ab ("update max_sectors setting") added max-sectors
while setting up throttle device. So now we should also calculate block-
size which matches the wiops. Typically, size of each IO which is submitted
to the block device depends on the max-sectors setting of the block device.
For example setting max-sectors to 128 results into 64kb of max. IO size
which should be used for sending read/write command to the device. So take
into account the max-sectors-kb and wiops settings and calculate the
appropriate block-size which is then used to issue IO to the block device.
This change would result in always submitting 256 I/O read/write commands
to block device.

Without this change on a system with 64k PAGE SIZE, using block-size of 1M
would result in 16 I/O being submitted to the device and this operation may
finish in a fraction of a section and result in test failure. However the
intent of this test case is that we want to test submitting 256 I/O after
setting wiops limit to 256.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 tests/throtl/002 | 14 ++++++++++----
 tests/throtl/rc  |  4 ++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tests/throtl/002 b/tests/throtl/002
index 185e66b..02b0969 100755
--- a/tests/throtl/002
+++ b/tests/throtl/002
@@ -14,6 +14,9 @@ test() {
 	echo "Running ${TEST_NAME}"
 
 	local page_size max_secs
+	local io_size_kb block_size
+	local iops=256
+
 	page_size=$(getconf PAGE_SIZE)
 	max_secs=$((page_size / 512))
 
@@ -21,12 +24,15 @@ test() {
 		return 1;
 	fi
 
-	_throtl_set_limits wiops=256
-	_throtl_test_io write 1M 1
+	io_size_kb=$(($(_throtl_get_max_io_size) * 1024))
+	block_size=$((iops * io_size_kb))
+
+	_throtl_set_limits wiops="${iops}"
+	_throtl_test_io write "${block_size}" 1
 	_throtl_remove_limits
 
-	_throtl_set_limits riops=256
-	_throtl_test_io read 1M 1
+	_throtl_set_limits riops="${iops}"
+	_throtl_test_io read "${block_size}" 1
 	_throtl_remove_limits
 
 	_clean_up_throtl
diff --git a/tests/throtl/rc b/tests/throtl/rc
index 9c264bd..330e6b9 100644
--- a/tests/throtl/rc
+++ b/tests/throtl/rc
@@ -71,6 +71,10 @@ _throtl_remove_limits() {
 		"$CGROUP2_DIR/$THROTL_DIR/io.max"
 }
 
+_throtl_get_max_io_size() {
+	cat "/sys/block/$THROTL_DEV/queue/max_sectors_kb"
+}
+
 _throtl_issue_io() {
 	local start_time
 	local end_time
-- 
2.45.2

