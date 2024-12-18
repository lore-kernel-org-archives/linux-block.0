Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6355198822
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734529433; cv=none; b=mRxuz+PUFWUr1YviX+miTdfQBRZ9ZO7yalXuBTFIhNpk1TVv9OE7SEg05Zj9MmpqXn5bOSLX8Lr7Afzup877TLyjc5VfoOLhpdNDGXgsAGf8sUiH5Sz/kWwTx92/gsYFA97u3l7Vfi7XL4/hjiRY/8NJd29gJvKR+wesME8crI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734529433; c=relaxed/simple;
	bh=dX+iPzUhR933k8bXeD5xkk2m7shzyVAPHNh76LBqDu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O/fMTalan5zoV42B3RWZ4r9q0zSO0SajWl6+1YtQnq+OlyUkl/WWgh8MhSRvPPh8ncg62zVZ0zP5kDxOic3sHzscrsEIub+WI2OGUZntwjl91K3a1CJheJtWygxrsTI5eSs3yyJHHf9toTnk2GNlEkG4/QjL/VaFldznLHSD5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m6cZDM5s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m6cZDM5s"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BICwMbL020841;
	Wed, 18 Dec 2024 13:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Es/AbkIM8u967BQVwtf5kJF/O0oo4WvyjO6elT5Fj
	kc=; b=m6cZDM5sGUIeaMV7VPH4wOTCQDhMk+ala5fGa9tkcYhYmG5pB2mSSYa0v
	S85vLgrsrcs4IFeKncCU8D/TVwpK2Lth+ujZSkDfm64Ix3qzA7ijFD6K3MGJN5Y1
	n3E/AyNB7WvQ0z/sanWDHCWWin1tYE+/n4vnwemhc0Z501YSSd/mliyIDCZRQr9t
	mRBykMoDCkLpHpKOIDQo7jSp82s7Vb+GTRkoAC0DypPzhaRC+5cyHoVY4Mc+Eiq5
	tTFFI6JWbWRqlzvkPVMDOoCgcGcCPZiHz6DmVoodVBxrh+FI6bvN55QzhAmaeLVe
	uP9PTHxSWFLa9Ig+AN28h5mtqzvWQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kas4wp3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 13:43:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BICN9ks005694;
	Wed, 18 Dec 2024 13:43:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbn83ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 13:43:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIDhTwd32899462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 13:43:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED70A2004B;
	Wed, 18 Dec 2024 13:43:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C15920040;
	Wed, 18 Dec 2024 13:43:27 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Dec 2024 13:43:27 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: yukuai3@huawei.com, shinichiro.kawasaki@wdc.com, yi.zhang@redhat.com,
        bvanassche@acm.org, gjoyce@ibm.com
Subject: [PATCHv2 blktests 0/2] throtl: fix IO block-size and race while submitting IO
Date: Wed, 18 Dec 2024 19:13:20 +0530
Message-ID: <20241218134326.2164105-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FHorni_Zkt1mPN_-94Lept5tL1nAak3X
X-Proofpoint-GUID: FHorni_Zkt1mPN_-94Lept5tL1nAak3X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=594 mlxscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1011 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180106

Hi,

The first patch fixes the IO block-size used for submitting IO depending
on the throttle device max-sectors settings.

The second patch fixes the potential race condition between submitting IO
and setting PID of the background IO process to cgroup.procs.

Changes from v1:
    - Use $BASHPID to write the child sub-shell PID into cgroup.procs
      (Shinichiro Kawasaki)
    - Link to v1: https://lore.kernel.org/all/20241217131440.1980151-1-nilay@linux.ibm.com/

Nilay Shroff (2):
  throtl/002: calculate block-size based on device max-sectors setting
  throtl: fix the race between submitting IO and setting cgroup.procs

 tests/throtl/002 | 14 ++++++++++----
 tests/throtl/004 |  7 ++-----
 tests/throtl/005 |  7 ++-----
 tests/throtl/rc  | 11 ++++++-----
 4 files changed, 20 insertions(+), 19 deletions(-)

-- 
2.45.2

