Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B61A4B34
	for <linux-block@vger.kernel.org>; Wed, 31 Jul 2024 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424715; cv=none; b=sxqIPogLBdt/jJOjD3Gw0ksoIN7woDvKo/+cqAiM3NwG+MPsUrH2MfA0NkRfwHKEyk8yxSQGdE+Fg0vNjPT1FWH9/R+nk01O+1b6EpULMQxJA8C6/ipxE2cRXzLTfdFJBag3Ksq8Kyq9/r6e7Zwgi/o5/L9Dk5XKkS4WBIpWalY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424715; c=relaxed/simple;
	bh=FfSNEDF/5tkICZwcRvjUZmvy8eC0TCiHi+p8jXxPTtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TRDJcSsCUpHzXrRPDIMJIp+mDQXPFFwHQoaZfJ+tYt3JkRD3MO7x6aYN/PVBsaoQ5b+RMurAN/Y/coYsiMcs2bG5MAagc/7vJ6f7HQnNfcRLCJ578JQ/W/yfhmy7+ernfNO5S+/HEX7w8tfWNiYWIB8F6pUUWgnCbMqkJUx1Crg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j3LAd8gj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j3LAd8gj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V7wJcP014667;
	Wed, 31 Jul 2024 11:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=vdFRjJSWwj3Dpd8KwddpPJ8VsJ
	GMlFGdweU3RcYI4sw=; b=j3LAd8gjOf0JDH7SlQsWFVCsNX+YM01Dnj+IvbzFAi
	mKIe5nEwTioxN45T4290Av/OVcfRJ9OTL7TTcO3a7stMvNmcQsU1l+KxqINndIhz
	FbpWi+NA7dyq6mu/S4oa44Ql4xzozY2xpK7uyVFFyVfyX27aH8M6wOZFyoFptEFA
	PzhKopK08KdJAg+Gfq8sqXZtYz5fn28OlKFifPEUr1GaYcoPwHprKebLHR+lVeVj
	3KIEYZelyE9iyu8XuG8M7MBO7g3+FdDZeUTqMWhxH5ZvpGhIcx/gBEzpcx7bM/b9
	XEGyha10PiVuwBLP2P5e17ifIbFlTP6ltD36f7HY9jxA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qhbk0fd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 11:18:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46V8AADA029106;
	Wed, 31 Jul 2024 11:18:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm0ua2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 11:18:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46VBIJC252101472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 11:18:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E906420043;
	Wed, 31 Jul 2024 11:18:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 702CB2004D;
	Wed, 31 Jul 2024 11:18:17 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.15.87])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jul 2024 11:18:17 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: chrubis@suse.cz, shinichiro.kawasaki@wdc.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH blktests] loop/011: skip if running on kernel older than v6.10
Date: Wed, 31 Jul 2024 16:47:45 +0530
Message-ID: <20240731111804.1161524-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _5dphM8bkcvUW_awO6gvJzw5_vHKRdDN
X-Proofpoint-ORIG-GUID: _5dphM8bkcvUW_awO6gvJzw5_vHKRdDN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1011
 mlxlogscore=672 malwarescore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310077

The loop/011 is regression test for kernel commit 5f75e081ab5c ("loop: 
Disable fallocate() zero and discard if not supported") which requires 
minimum kernel version 6.10. So running this test on kernel version
older than v6.10 would FAIL. This patch ensures that we skip running 
loop/011 if kernel version is older than v6.10.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 tests/loop/011 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/loop/011 b/tests/loop/011
index 35eb39b..b674dd7 100755
--- a/tests/loop/011
+++ b/tests/loop/011
@@ -9,6 +9,7 @@
 DESCRIPTION="Make sure unsupported backing file fallocate does not fill dmesg with errors"
 
 requires() {
+	_have_kver 6 10
 	_have_program mkfs.ext2
 }
 
-- 
2.45.2

