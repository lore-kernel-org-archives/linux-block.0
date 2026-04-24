Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB1F3DBD51
	for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039938; cv=none; b=rCfDBerGURzIzc0InqKg2B1QRJzECFC684x/JXa0hf2Bq+GxBSYoi1SVdK19+MzDYOsuOMWCfdO5xHLn/r8QG562Jp5e38c+/zpe0FEkTIozxrchVjbosp0hI6JuP/M8+wmJpuGgcnE7B2ELDQq+xB1LMUQFrvMdgIFFYgs6F0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039938; c=relaxed/simple;
	bh=IH2WeXsT3LPEUfUPOk2awH5zdhEzI3QEra63QSw/o6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1zQ6vwnNaXxObHqTpBnjuToUbKD3itiL8SoON0x9V0pgt5EJ3mvja6BcOCvyil3ntoe0+VvRKbvfTkCgk7F7MlzpUQ0QFzHHioUYRbKoY2ogDmAIsGP3S5ocO0gtggXBBwJ5hxXrcOtFc8OmLld1zHZfbIGPRO6RmTwUOTjAIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=omB7s8O9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="omB7s8O9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OB9hD63658023;
	Fri, 24 Apr 2026 14:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=CeqfJtGbrztwNuGF4P36giGr4c1AkuStRDxSv9KDs
	8I=; b=omB7s8O99HIS3d/6MTSN5fYYUB3BTXc7qbI9rKrSkj2fsOaXKGzBAnZ9d
	UpI7oKBKTxYLNUEJ8UInq9qkUvEet5Qdwo9iyBwH4Nbapt6lDW8PcPzZXW+DUPel
	NEtBfq63UeD9dtOrII+b9CstzTm6fwUYEQb3dB8RkSlkSbXngWE2ImNdcwf/nccL
	ipiSX5zftgWnNAfR0SnU2CavoYZjSPWdIFd1z83LQ1J/wjztm94NlloL0qA89J56
	QzHkZFSw6Os+6YeEUkRj5heTCG+DN4efdMzD8pjzHfOqYCrSpMrijg1D/ofG2m4g
	Iv6/Yza52Rfcqnr6IpQZYGKzOn2aQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu7wax3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 14:12:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63OE5HDG025371;
	Fri, 24 Apr 2026 14:12:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky33qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 14:12:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63OECBUh26607888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 14:12:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C87820043;
	Fri, 24 Apr 2026 14:12:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 733C320040;
	Fri, 24 Apr 2026 14:12:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.194])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Apr 2026 14:12:10 +0000 (GMT)
From: Disha Goel <disgoel@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH blktests] blktrace/001: Skip test when kernel lockdown is enabled
Date: Fri, 24 Apr 2026 19:41:43 +0530
Message-ID: <20260424141143.64528-1-disgoel@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EtXKhalQPrG6NFnPyjtxvBUAjgdp7XkR
X-Authority-Analysis: v=2.4 cv=Ksp9H2WN c=1 sm=1 tr=0 ts=69eb7a3f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=lMfaIYGb8OtYOQq5FLsA:9
X-Proofpoint-GUID: EtXKhalQPrG6NFnPyjtxvBUAjgdp7XkR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDEzMyBTYWx0ZWRfX4AqM0mg+xcAl
 G13MpD7Vi2rGWxOy2zwUO1nXuZM9FDZNjtJgUH7MlGn/AK1iWHJMN1uGwBSK5+vvNwmCCZDKisS
 ev7zXn/NZdykvHfYpHKefmTuxs4ub4K0kjI/qOqyxMrkiakI54Cj1qE4XXq2BB0T05gKZiMMjeK
 WZL9O9I7t6hZb/j86DVJCvzQDc5eSVZsw2IN7ZiC7vifoIcvXFa3p8kB8z5CLercxbjEdyhh6sF
 avuW8PHcLWg9SvoDmBwOj5O0a2aAq7cn9p1UdhhZS5G3EmJ1SjNQWK4n56pO2LXPtdAnfD+6V+O
 bhNVLPtsgx+e3hCzIUobsrNIqwKKQOS/7WFmDMUN36gQOfd/9qbnTR9fXL2TA69h/0bfWSkK6nI
 nsk7GOZ6inHqSffkv/ow8EGVj1D4YVuvoaL7cwAnQsLoslECvxI5Dr0OMLZbSrVFnJ8pgutfgLK
 mYtdJNTsGgR9aIlmt7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240133

The blktrace/001 test fails on systems with Secure Boot enabled due to
kernel lockdown preventing access to debugfs. The test attempts to run
blktrace which requires access to /sys/kernel/debug/block/*/trace*
files, but kernel lockdown (enabled automatically with Secure Boot)
blocks this access, resulting in "Operation not permitted" errors.

Add _have_debugfs_access() helper function to detect kernel lockdown by
checking /sys/kernel/security/lockdown for [integrity] or
[confidentiality] modes. When detected, the test now skips gracefully
with a clear message: "kernel lockdown is enabled (Secure Boot may be
active)".

Also add _have_configfs check which was missing. The test uses
_configure_null_blk() which requires configfs to be mounted at
/sys/kernel/config.

Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
---
 common/rc          | 14 ++++++++++++++
 tests/blktrace/001 |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/common/rc b/common/rc
index 5350057..50d63e7 100644
--- a/common/rc
+++ b/common/rc
@@ -205,6 +205,20 @@ _have_blktrace() {
 	_have_program blktrace
 }
 
+_have_debugfs_access() {
+        # Check if kernel lockdown is preventing debugfs access
+        # This happens when Secure Boot is enabled
+        if [[ -f /sys/kernel/security/lockdown ]]; then
+                local lockdown_state
+                lockdown_state=$(cat /sys/kernel/security/lockdown 2>/dev/null)
+                if [[ "$lockdown_state" =~ \[integrity\]|\[confidentiality\] ]]; then
+                        SKIP_REASONS+=("kernel lockdown is enabled (Secure Boot may be active)")
+                        return 1
+                fi
+        fi
+        return 0
+}
+
 _have_configfs() {
 	if ! findmnt -t configfs /sys/kernel/config >/dev/null; then
 		SKIP_REASONS+=("configfs is not mounted at /sys/kernel/config")
diff --git a/tests/blktrace/001 b/tests/blktrace/001
index 2cdad02..4fe7807 100755
--- a/tests/blktrace/001
+++ b/tests/blktrace/001
@@ -22,6 +22,8 @@ requires() {
 	_have_program blkzone
 	_have_null_blk
 	_have_module_param null_blk zoned
+	_have_configfs
+        _have_debugfs_access
 }
 
 test() {
-- 
2.45.1

