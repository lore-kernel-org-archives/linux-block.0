Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EFF1ADC9D
	for <linux-block@vger.kernel.org>; Sat,  1 Feb 2025 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738435231; cv=none; b=Hon9mHccBwYBRCXb+sS93ex/ZXqiyoCxISeBGWLHuD2I9QA10+DXKY0fLm4U9uCUsSfysadbUwpJQynvPVip+fWrhDwmwQb+zTHyrtkqjT8clrgX4b043o+GbMg17MpH7ZeHZBnCQA718uAwqXU5QmyhF0WY1mP9jFyDyJqawxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738435231; c=relaxed/simple;
	bh=1o7sOkPb5nJdnBqBtICR2UF/HxZ3MzNFgwk5GGH7JWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=StGr8mkgtXLKx9IVmoviHfWIvoT+YNCRl3oVcPaXQnNsSSrlWISQHXUqA+/ONwLnz0ucufLomFbNDso0gKLw98ObJWDc3o7M3oIAofvDpjJbXW3A37YUcI1KqZ8zhwqnSSBYhEJfq/7cWEDP0RZwAe2lAx4Nbk9y6ms1MSC7se8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ly7nN9/c; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ly7nN9/c"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5115CPHs023233;
	Sat, 1 Feb 2025 18:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=s0x1j4WXm+nEf5UF1Ri4rpkXs2VBLDfrms72NlTQ+
	wo=; b=Ly7nN9/cQJ+/Trx80OsuWsx6joi+ZuvYFYath68Xo3lkM5mpBli5nN7en
	28EigAR1pt2Xj+oqIPuU9fJp/6AwkTwmSRHaUbhqog4vv0iZq9jsayFXPcMu5hPI
	Ax1ezQvhdczYUu4KpZboohaz9rjDUZpLTfqlqwnXByLnoi7OLD6SbVU9Ep932YqG
	OIdVHVspKjBBsRKHMLJe3CrBmEy1e5hpzz/zmBxTcO7LdrrUHfdvaKfOezoojVLf
	k5Ipxj2aesLGR44760/JRAYZejbLtwDUMq+WFb/nhG5hioafjsYnceUw82RJs6qS
	t01ssZdC9fg8QLgtOUBnYaQ37IZNQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44hd8k1vkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Feb 2025 18:40:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 511GA5ZO000922;
	Sat, 1 Feb 2025 18:40:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hdb029kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Feb 2025 18:40:27 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 511IePBH34603590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Feb 2025 18:40:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29F7120108;
	Sat,  1 Feb 2025 18:40:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AA4720105;
	Sat,  1 Feb 2025 18:40:23 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.82.150])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Feb 2025 18:40:23 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
Subject: [PATCH blktests] srp: skip test if scsi_transport_srp module is loaded and in use
Date: Sun,  2 Feb 2025 00:10:11 +0530
Message-ID: <20250201184021.278437-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Wf-6IKhGhQo_bfI3rN-dAad3LPsQ5Zd2
X-Proofpoint-GUID: Wf-6IKhGhQo_bfI3rN-dAad3LPsQ5Zd2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-01_08,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502010161

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
 common/rc    | 11 +++++++++++
 tests/srp/rc |  1 +
 2 files changed, 12 insertions(+)

diff --git a/common/rc b/common/rc
index bcb215d..73e0b9a 100644
--- a/common/rc
+++ b/common/rc
@@ -78,6 +78,17 @@ _have_module() {
 	return 0
 }
 
+_have_module_not_in_use() {
+       _have_module "$1" || return
+
+       if [ -d "/sys/module/$1" ]; then
+               refcnt="$(cat /sys/module/$1/refcnt)"
+               if [ "$refcnt" -ne "0" ]; then
+                       SKIP_REASONS+=("module $1 is in use")
+               fi
+       fi
+}
+
 _have_module_param() {
 	 _have_driver "$1" || return
 
diff --git a/tests/srp/rc b/tests/srp/rc
index 85bd1dd..1bc7b20 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -61,6 +61,7 @@ group_requires() {
 	_have_module scsi_debug
 	_have_module target_core_iblock
 	_have_module target_core_mod
+	_have_module_not_in_use scsi_transport_srp
 
 	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof rdma \
 		 sg_reset fio; do
-- 
2.47.1

