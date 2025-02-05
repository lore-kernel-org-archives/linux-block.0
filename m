Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE381519B4
	for <linux-block@vger.kernel.org>; Wed,  5 Feb 2025 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738769146; cv=none; b=rbof96sfVwsCZPt8hpbuVpsrDAIIIHiyJqnVocdr7uFBVz0VFL08gbD+677WTNm+uHog7p/IVj9bVXMF7f501iTIZ75BFWaAsy/2LGm235tXmBhpIX0dQj/jePlUs4wobOh+q/sqVwNa4TkOpLvc8pmSNC1d6OhwUYhVuBYgUkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738769146; c=relaxed/simple;
	bh=QGxWL+O++OS5+5WH5RfkR4kGK0rpunvZ6ydSnBpvdus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mMKVJz1mWRpFEVEP7J0ckWIwPUgrka+bzLTEdcRltHCD5ChRQm1ZyHMHc8rPEjjI9VYLbCFTElQ9Io7IDReeSOmVcMmUWwTRxW4FfLYEB74XoF3zRGoGYP8xzt09tXD+22XG6ijSxhD8AAOkF/UTC8SOXgRJH1yDwXNpRH9nR6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SZWHDaMH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SZWHDaMH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515D7Lme012336;
	Wed, 5 Feb 2025 15:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/H7ByLpmcog/hUSRBo9ElCJHP5O+nIz28K3qMCHcx
	Dg=; b=SZWHDaMHOlKbleG05fdw7hgpviyFUIyr4a9ClwTywDshKocUyrTQ/AwyJ
	oGnCcAyMiwq1bxr6lMpJCO8yDHVbuc9z0DoH6fAaYPWFeYi1XFjvmC6p3vZjSdT5
	WBUmZLmT2d0hDS5fdhiWcQuc8adLtGkNGW9DviwO3K0QXbH0IPUhqA5kGrIw57NP
	U9hBS324e51/ORs+Je1vnOwfQa30H5loQ9kYdECVo1ZB+mk4l7gC3N0B4NF1IxRO
	WpENat+/SvwEWx5XNqWCm75H43N53E53WsWsd/VeTHe7OyLfdjk4IOgfi1IDkNwv
	a48ZmKor0ZusaEn34Q/myLUtzGrwg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kx29ktj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 15:25:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 515CXFuK024510;
	Wed, 5 Feb 2025 15:25:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxn9e25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 15:25:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 515FPca97274864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 15:25:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5F04200A0;
	Wed,  5 Feb 2025 15:04:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FD5A2009D;
	Wed,  5 Feb 2025 15:04:31 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.80.122])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 15:04:31 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, bvanassche@acm.org, gjoyce@ibm.com
Subject: [PATCHv2 blktests] srp: skip test if scsi_transport_srp module is loaded and in use
Date: Wed,  5 Feb 2025 20:34:20 +0530
Message-ID: <20250205150429.665052-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R78PUa1wb7dZckoTgYIYYZNtG_fguAY3
X-Proofpoint-ORIG-GUID: R78PUa1wb7dZckoTgYIYYZNtG_fguAY3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050117

The srp/* tests requires exclusive access to scsi_transport_srp
module. Running srp/* tests would definitely fail if the test can't
get exclusive access of scsi_transport_srp module as shown below:

$ lsmod | grep scsi_transport_srp
scsi_transport_srp    327680  1 ibmvscsi

$ ./check srp/001
srp/001 (Create and remove LUNs)                             [failed]
    runtime    ...  0.249s
tests/srp/rc: line 263: /sys/class/srp_remote_ports/port-0:1/delete: Permission denied
tests/srp/rc: line 263: /sys/class/srp_remote_ports/port-0:1/delete: Permission denied
modprobe: FATAL: Module scsi_transport_srp is in use.
error: Invalid argument
error: Invalid argument

So if the scsi_transport_srp module is loaded and in use then skip
running srp/* tests.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Changes from v1:
    - Fix formatting, replace white spaces with tabs (Shinichiro Kawasaki)
    - Rename _have_module_not_in_use to _module_not_in_use (Bart Van Assche)      

---
 common/rc    | 13 +++++++++++++
 tests/srp/rc |  1 +
 2 files changed, 14 insertions(+)

diff --git a/common/rc b/common/rc
index bcb215d..20579b0 100644
--- a/common/rc
+++ b/common/rc
@@ -78,6 +78,19 @@ _have_module() {
 	return 0
 }
 
+_module_not_in_use() {
+	local refcnt
+
+	_have_module "$1" || return
+
+	if [ -d "/sys/module/$1" ]; then
+		   refcnt="$(cat /sys/module/$1/refcnt)"
+		   if [ "$refcnt" -ne "0" ]; then
+			   SKIP_REASONS+=("module $1 is in use")
+		   fi
+	fi
+}
+
 _have_module_param() {
 	 _have_driver "$1" || return
 
diff --git a/tests/srp/rc b/tests/srp/rc
index 85bd1dd..47b9546 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -61,6 +61,7 @@ group_requires() {
 	_have_module scsi_debug
 	_have_module target_core_iblock
 	_have_module target_core_mod
+	_module_not_in_use scsi_transport_srp
 
 	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof rdma \
 		 sg_reset fio; do
-- 
2.47.1

