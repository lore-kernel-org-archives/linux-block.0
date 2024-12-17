Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DD31F1917
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441297; cv=none; b=f7yzsU3LofT+VHVyd8jDkjj0ZVqpyJ7q9x94On6CvR2WO40mIAa7jF3XWssgqOkcYht5Fsm0X5C/ZLM27Mdxzm1iRc4uFq4whYozvNyj86kFngLxoA70oDDEPWiaYi8vCeEwtl33pnu+e9QRU1sbkB82EO9WJKMd+ZA1QD6eoeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441297; c=relaxed/simple;
	bh=+Sp0YTdBdkqigCnJ8xle/AKDkW52qIYMjCMoITEiTkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PuXUns1KsHlLkB+yeQCm+DcxIoxk2SpIFui4+IEnm7WgAjA/4PMGWf6QFMaLN0PXIUQz9bGYjdjvG+q3nlcIbd0BLolHc/XW4lqCfAE+JbbPOmVbTNzE7OBsjUKJc2TT53BD9z/UYFmHhuoq+FuulmfYC50LiGGS90bSZQg7SVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nzA3+L2P; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nzA3+L2P"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHD0DiY027977;
	Tue, 17 Dec 2024 13:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=62uI7ILhJKAiRTVh7v9WfjDV8N09sOLjVsI2UzFfT
	NQ=; b=nzA3+L2PYrStP3c2YFtUSORV9d6qFFnufHGAleFYtIOYysqWSQPrqycKW
	gddEpurY46butbvrUG+/K0/JCyhtxjb97GQoFGHGeTTAKuxJurRqhF/XVkSbfm89
	SU49hDAqDzoyxOqUGj5L686SDhnU0cl9dv96Ej45R2LLS/4lFyTPoeZrhDmcrgXu
	h5wIjOCIYVJsH3RlEvs5MBoepggIBC29P8z+j4K17SDn8E/2i8eoZh2l1/SYO/nY
	yQqui91vJvdROJ0cBdy4GFgatgRozQtjDNHRysWfnnyHBwFsv3nYs4Cg6ccWwbYX
	BUzRfAmXkMB8x/44caY6lh2ayUacQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43k9t6g1yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 13:14:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHBd9Bn005549;
	Tue, 17 Dec 2024 13:14:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbn2v9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 13:14:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BHDEh6J55705912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 13:14:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB84E2004B;
	Tue, 17 Dec 2024 13:14:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6492C20040;
	Tue, 17 Dec 2024 13:14:42 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.52.184])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Dec 2024 13:14:42 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: yukuai3@huawei.com, shinichiro.kawasaki@wdc.com, yi.zhang@redhat.com
Subject: [PATCH blktests 0/2] throtl: fix IO block-size and race while submitting IO
Date: Tue, 17 Dec 2024 18:44:20 +0530
Message-ID: <20241217131440.1980151-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sD6CqcX9rEgRlZQSKaB6N3ppn9F5tOF4
X-Proofpoint-ORIG-GUID: sD6CqcX9rEgRlZQSKaB6N3ppn9F5tOF4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=660 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412170104

Hi,

The first patch fixes the IO block-size used for submitting IO depending 
on the throttle device max-sectors settings. 

The second patch fixes the potential race condition between submitting IO 
and setting PID of the background IO process to cgroup.procs.

Nilay Shroff (2):
  throtl/002: calculate block-size based on device max-sectors setting
  throtl: fix the race between submitting IO and setting cgroup.procs

 tests/throtl/002 | 14 ++++++++++----
 tests/throtl/004 |  8 +++++++-
 tests/throtl/005 |  9 ++++++++-
 tests/throtl/rc  | 13 ++++++++++++-
 4 files changed, 37 insertions(+), 7 deletions(-)

-- 
2.45.2

