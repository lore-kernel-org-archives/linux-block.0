Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E1926462C
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866771; cv=none; b=C9Gbmr2ubwSxNhODttaAWwgh3eaqygWv9aknE1GAf/gdARlnhn1Xzq1aJSLSJX7ZREOOENLxGPiSfAwMJfokmbQs2UU7CExV2vEsp6P+8ygChz2MDhEKPTrksYkFBUSmAbNncUdr6SyndzS+I63SW/mUe+cjVP4LU5qk2IML+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866771; c=relaxed/simple;
	bh=kP9z/YXpE1PIbr/jcszCLmV0HTn2LtlPBOQQUvbOUfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n9rPs9BnFRPVv/Ya+yFxJpGxLVwwXbBYeWIGpsUdBiXxernmKWJR5QTE06a1zWLVEF2rRIfFLPTqmEHVLDNPOf+OmmF+VS3TX7DdXMkujynOAyJRWzzU2UZpOvURAEeatnyxYqkeJsWZCps1117OFsL8oAbveDkd8nWcYxj6fuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BX518MRX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BX518MRX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DA20PJ002118;
	Thu, 13 Mar 2025 11:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NscEBKEM0q/NjIFyriS635WVoFcqs1gZwvlpOA2OT
	CY=; b=BX518MRX/14Kmo1pmjAae+d38J9VkZrHnHh3nnGOoOXxGyNE9uZhFLFhD
	5WpN0yP2oNmkleGY/REFFERmzxHYpOwVl9p8oxwrSSaKdI0t38fvrLQ2I7N0IjGU
	F45EctX1IEMndbk51Pu3mK9RXdgiDXJ+Xv2ZBtqLvSuqYYogNqeq+ukWMGaiY6jR
	cSjXknxf1cZtVyoX46Q+lH5x62laKHSsBAMRLGYt1gL7v9pt/CP5jn3877TJS0nb
	fU5sqls7zYN9pZxdPC2zNPKbCu82qWqkmfIGtuapaIi705V/52C+Nytu3iduQYwe
	f9t+gy9UV41jOFDQ+U1SsAcTkkM7Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhp5bfa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 11:52:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52D919WV007627;
	Thu, 13 Mar 2025 11:52:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsr9hrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 11:52:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52DBqb8i39387600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 11:52:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F03520043;
	Thu, 13 Mar 2025 11:52:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 123E520040;
	Thu, 13 Mar 2025 11:52:36 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.185])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Mar 2025 11:52:35 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv2 0/3] block: protect debugfs attributes using elavtor_lock
Date: Thu, 13 Mar 2025 17:21:49 +0530
Message-ID: <20250313115235.3707600-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WrTbWhHrAULdsVCOm_i9TIPrCHl6o_ox
X-Proofpoint-ORIG-GUID: WrTbWhHrAULdsVCOm_i9TIPrCHl6o_ox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=549 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130090

Hi,

This patchset contains total three patches.
The first patch helps protect debugfs attributes using q->elevator_lock
instead of q->sysfs_lock.
The second patch in the series removes the goto labels from the read
methods of debugfs attributes that improves code readability and reducing
complexity.
The third patch in the series protects debugfs attribute method hctx_
busy_show using q->elevator_lock.

Please note that this patchset was unit tested against blktests and quick
xfstests with lockdep enabled.
---
Changes from v1:
    - Split patch into smaller patches for bisectability. (hch)
    - Remove goto lable and return immediately upon failing to acquire
      the mutex lock. (Damien, hch)
    - Original patch in v1 is splitted into three patches
Link to v1: https://lore.kernel.org/all/20250312102903.3584358-1-nilay@linux.ibm.com/
---
Nilay Shroff (3):
  block: protect debugfs attrs using elevator_lock instead of sysfs_lock
  block: Remove unnecessary goto labels in debugfs attribute read
    methods
  block: protect debugfs attribute method hctx_busy_show

 block/blk-mq-debugfs.c | 41 +++++++++++++++++++++--------------------
 include/linux/blkdev.h |  6 +++---
 2 files changed, 24 insertions(+), 23 deletions(-)

-- 
2.47.1

