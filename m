Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C183713C8EE
	for <linux-block@vger.kernel.org>; Thu,  1 Aug 2024 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504598; cv=none; b=qqWspytyZj/E4X4lZjZU9IPbXMyVhjvAArZFP70oiypObpVrcTR2jOo27I6bYEnRhDLDEJ+Z454Ze/mbhqXuMbJ5locu/1op9pZvEL+KmZbSq3JNgpHL9hyeSJQiqdGLj0PCezPBmY2b4f2LhwJvgVFMSzvTdzCrt8NwI7EAHrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504598; c=relaxed/simple;
	bh=AX8sXMAPXdYVPTKtLHPcKUeFmDng5ysUTk6D/7Yt/zA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTMunhMW6faalgc8ovNa5G96u0BqefgRs1TM37BoQl28Cb0zkZyxvOENcid3bc5HaYsYDh1HNR2b8PjVUACYlKcacv/ryYMzDafr6aA19gHlAoexmTynKrtsNeMEpjQ1wEOkfXAxmdOEcSrYifJ//PH14N8P7JhzfFeVJJPG7r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f7131Oo/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f7131Oo/"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4719QVwS012985;
	Thu, 1 Aug 2024 09:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=rW6yJNgT3SBRVmzRLAUCww9cePFbl1td/wCuS2I
	FSjI=; b=f7131Oo/prI7KEV11G6gCNiCldvzeviMK2Qgwyk7CS8nKLODwyYelcE
	JLpb5jPcsZT4AqUen5M2/2DyAQLL4eiTSgKfn2xtCAG15g65noG9gi0VDXMdnoSC
	BF1Dx6KqeG4x1TqqW77cOHze1n7NcPcWag/TWpVd2TrhuI7awjzpGwPNV3+2xIKs
	1jkuMWFUeZ4Yr52bHOXKEr+OwYu0an86Jg4D4eDto+OiVqHFzZ769OH58i4EeBeM
	vaNOo1UZ11D+Fju08LRqn5AyCTk44XWW+lOOyencNAPgF07kmRgxU0nFalD7kr2p
	EHWGop9NB9A1dHfAOabuzV6+Zhz11aA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40r1m68uh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 09:29:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4716CxEA009218;
	Thu, 1 Aug 2024 09:29:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndx38mrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 09:29:51 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4719Tjhs51904778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 09:29:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAE6120043;
	Thu,  1 Aug 2024 09:29:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A6742004D;
	Thu,  1 Aug 2024 09:29:44 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.179.0.4])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 09:29:44 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: chrubis@suse.cz, shinichiro.kawasaki@wdc.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 blktests] loop/011: skip if running on kernel older than v6.9.11
Date: Thu,  1 Aug 2024 14:58:42 +0530
Message-ID: <20240801092904.1258520-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KpJRBZpm-IfN8cYaFzXhkCT4lddHweZW
X-Proofpoint-ORIG-GUID: KpJRBZpm-IfN8cYaFzXhkCT4lddHweZW
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
 definitions=2024-08-01_06,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=657 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010057

The loop/011 is regression test for commit 5f75e081ab5c ("loop: Disable
fallocate() zero and discard if not supported") which requires minimum
kernel version 6.9.11. So running this test on kernel version older than
v6.9.11 would FAIL. This patch ensures that we skip running loop/011 if
kernel version is older than v6.9.11.

Link: https://lore.kernel.org/all/20240731111804.1161524-1-nilay@linux.ibm.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
  Changes from v1:
    - loop/011 requires minimum kernel version 6.9.11 (Cyril, Shinichiro)
---
 tests/loop/011 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/loop/011 b/tests/loop/011
index 35eb39b..a454848 100755
--- a/tests/loop/011
+++ b/tests/loop/011
@@ -9,6 +9,7 @@
 DESCRIPTION="Make sure unsupported backing file fallocate does not fill dmesg with errors"
 
 requires() {
+	_have_kver 6 9 11
 	_have_program mkfs.ext2
 }
 
-- 
2.45.2

