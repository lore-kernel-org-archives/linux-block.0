Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A4A1CAB3
	for <linux-block@vger.kernel.org>; Fri,  2 Aug 2024 05:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722576904; cv=none; b=cojI6md1mlsHCMR+5jQLIZDPNfjTmvlg5n+axOxs79cMGrB3WMUFsdugxXc79r4Al7FK9KZU87y0sjkyirlYVVnEHZCy6mZQCT+/IoUd/1Pc0HWFnVTcZ+SP7QvR75Ooz1ksOLrKlSQqnq/t1TFCghihPERbPhYa2xaBxtUarqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722576904; c=relaxed/simple;
	bh=sEQiiyvKscLaan1ItCDGtwkZ21ti3E2V1jbNLzRM4es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBxl+DIzcdSea75DVPcJ7aiDX3d/oMvsFpH079XESJ26PBVmtQByltokY+JxFm9jFteryfcLGyJva3uQKSLthFajOg/yp5fZybXF1Ijtb7iGAVeirPuO7fBaKuoqBPGB47AcUAf3xbQz31jD8bDsF/6+3FDTY6Y83anlwx1UXig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D+0VfH3C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D+0VfH3C"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4725ADW3005291;
	Fri, 2 Aug 2024 05:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=UKgeUC+b2JrRWAqrOSzRmh9e+q0XmP5eMk4/jYn
	hSUg=; b=D+0VfH3Ca+u5KnY7brzXwVl8PD3yd9Wqol+JfL/gj2L/o41nNO6Pw4K
	RHwX2pxIMg+YsBCzDcORow9FLt9ADFbbLOfdGNaE8NdNKA82Uo72Ak/B25vDK6jd
	Xg0uZp4s/RKguHYxEvOEBXLqzjPJmKnMdxH0eDJu2pCc4M7Q2brtCH0iYRAepf1c
	+ChXtDsYr5NVsa/F3SuHYVDh3B0OAhJ4FmoJDD80WhprDFnOBs5Ypkjr7btkp/WF
	O1DmZwRacdLqdLS66Hi4zMCxrQu2QsJbvLcNNXKTJTKcsy2rJvwZi3UHigd9IRau
	TmZDv5BXck/5EMmB2C4gyRYuQaq1dKg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rq5087nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 05:34:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4722JGJv029100;
	Fri, 2 Aug 2024 05:34:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm15tqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 05:34:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4725YnXV14615024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 05:34:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 676E020077;
	Fri,  2 Aug 2024 05:34:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF6BC20085;
	Fri,  2 Aug 2024 05:34:40 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.216])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Aug 2024 05:34:40 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: chrubis@suse.cz, shinichiro.kawasaki@wdc.com, bvanassche@acm.org,
        gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 blktests] loop/011: skip if running on kernel older than v6.9.11
Date: Fri,  2 Aug 2024 11:04:04 +0530
Message-ID: <20240802053421.1350297-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: he_ZEAGhsQwUi8LGoFHcdem_R0FSS5K3
X-Proofpoint-ORIG-GUID: he_ZEAGhsQwUi8LGoFHcdem_R0FSS5K3
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_02,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 suspectscore=0 mlxlogscore=662 adultscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408020035

The loop/011 is regression test for commit 5f75e081ab5c ("loop: Disable
fallocate() zero and discard if not supported") which requires minimum
kernel version 6.9.11. So running this test on kernel version older than
v6.9.11 would FAIL. This patch ensures that we skip running loop/011 if
kernel version is older than v6.9.11.

Link: https://lore.kernel.org/all/20240731111804.1161524-1-nilay@linux.ibm.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
    Changes from v2:
      - add a comment explaining why the kernel version check is present (Bart)
    Changes from v1:
      - loop/011 requires minimum kernel version 6.9.11 (Cyril, Shinichiro)
---
 tests/loop/011 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/loop/011 b/tests/loop/011
index 35eb39b..fe4d6d6 100755
--- a/tests/loop/011
+++ b/tests/loop/011
@@ -3,12 +3,16 @@
 # Copyright (C) 2024 Cyril Hrubis
 #
 # Regression test for the commit 5f75e081ab5c ("loop: Disable fallocate() zero
-# and discard if not supported").
+# and discard if not supported"). This commit is merged into the kernel v6.10
+# and later backported to kernel v6.9.11. Running this test on a kernel older
+# than v6.9.11 would obviously fail, so we enforce that this test is skipped
+# if it's started on a kernel version older than v6.9.11.
 
 . tests/loop/rc
 DESCRIPTION="Make sure unsupported backing file fallocate does not fill dmesg with errors"
 
 requires() {
+	_have_kver 6 9 11
 	_have_program mkfs.ext2
 }
 
-- 
2.45.2

