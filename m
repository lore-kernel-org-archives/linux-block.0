Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689F81F5432
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441301; cv=none; b=Qhb8VByb1DX1h5cdVA1Ox0Q+1MM9jx861k4XcrUYV8C5QKhNU3q/7e9lBOmSeCki/bT79VaZUtKRqtJlDYv2eeyG0iZN0jKBWRnkeUmcBzyCaHv26uxNzwnM8eZZpqWiELzF2tbmp39aoq8Q9WcjXpSkuUEl+8c2ZimqNlV/pdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441301; c=relaxed/simple;
	bh=lyj4AMgzbPsPJCrx+ci16fzZWfuoWKS/bZjJdMX1YdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDtuUJQqchI19sF/DArbcZgQTXGRj0K4309n5YIotfIvfc+WZj+7CK2WrXK/RlLeh3pVPC4s2pIZb+epwZSAz0qdZ5kOVrpUKZ/2dipQx6RqJqz87Q0xZ6dIqnePYwIVCcEGkafmQO1h0rzDPgYizJIx7H6Q+95I4oLb2Xx0Qrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hrJ00ZjV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hrJ00ZjV"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH3sBOp028730;
	Tue, 17 Dec 2024 13:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ze+mpQinHomkSHvk7
	Rw8dbp87UoRn2V/zWiixfJqQPA=; b=hrJ00ZjVwRwmyAd+6kOxqwrKjNuq2vF86
	1VJf1tPFqrH5fBg1F+E0tKnRS4QxsNHi6A2RExuU+2r+xKYMn1gg6Uh30qHRzdUU
	AZ8fAbNQvZNu9RzQ9rZRIZ30xiYPCeqyQAC8cGqWjXrFVpxHvxmqmANRy7m6tAcZ
	gT8+ahnjL+fVtESUiiV9/Wsn+J99UwoBEsT8HJ7EJ5rJT73HtsstuWV6TCBq4Tcf
	WlHVXAZMBhU2XCU2qpl1/UcDOMYn5VMC35n97elKj7WTC5Cg+/OZxLR+2Rs7NpxF
	PuwH2VYTQ6oHWdEPrLm5Eqq27bNa5zKD4d9fG9M0r2CUCxYM9J8xw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43k1sh288x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 13:14:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHD0e3D011295;
	Tue, 17 Dec 2024 13:14:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjk2m23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 13:14:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BHDEjHr47907236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 13:14:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E7932004B;
	Tue, 17 Dec 2024 13:14:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15B8E20043;
	Tue, 17 Dec 2024 13:14:44 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.52.184])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Dec 2024 13:14:43 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: yukuai3@huawei.com, shinichiro.kawasaki@wdc.com, yi.zhang@redhat.com
Subject: [PATCH blktests 1/2] throtl/002: calculate block-size based on device max-sectors setting
Date: Tue, 17 Dec 2024 18:44:21 +0530
Message-ID: <20241217131440.1980151-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241217131440.1980151-1-nilay@linux.ibm.com>
References: <20241217131440.1980151-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iTx6EeA3Aj5TsIhZfcDkkB45Y_aFrMXS
X-Proofpoint-GUID: iTx6EeA3Aj5TsIhZfcDkkB45Y_aFrMXS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170104

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

