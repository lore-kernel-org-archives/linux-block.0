Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0219328688D
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750771051; cv=none; b=Aw7zaDJtCDjVuEO3Bq6REMbScTq3QXmtT8Mj/wB9FDYTY5YF2i3Uxj5iFoY+fs+eX/RReE9RsobPqZadEJlBKhALoW25MzinO+w18q10awpdQiXJhNux41nzBwdqUrHkou5/TQv6a1ZbrjWAfggUXohSo+8WWEhV3P/OO+spshM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750771051; c=relaxed/simple;
	bh=Yz2wcVi8+oc1QTfFioy/8jf7hDpSrnOmTWEIEJbQmv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jHlTiYBYZzbhk9Rsi92PfkcNxbfRWHqk1zxv726+giJoc1Lv4C1JC5+ZsZYkUEpEYNJhjt9cFfwOHb/61un1vR3JeOaT9mwKAzwPboD/C8HQ3KNjVUfNUtPjhWvuCy8fp9ZDD3VD85szu5SL/8rFWUUrONI4DvO7cJ9E/Qpqt90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ks6eh98x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ks6eh98x"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O7P8mw012616;
	Tue, 24 Jun 2025 13:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=5WAvkUaR4nmHoBfNNaofny5IFa5M
	OqLMJnDVhsUK7M4=; b=ks6eh98xWAGsjzLUY9mhCje7I67KRBfQtzn90nl6zKBC
	6cc1nt/hjhhOUWKwe86wxzlt33PjeymLRf8VkpBOrhnvBnaqPcm2cjegrlnfNt6P
	S0dKo1aZ8/pw+G/+4odvBBaUnSVWooZIp0706mhBvLjcSzEVQ38q3prfNxbuYfcB
	S+YPZ2bMeriEj7BcCJ9F38ar2w1/rkRoy+ea1jSnbk5Khz+wDoIOR+HJeza1w+ZC
	Jo0jbx/upJbf1SldkeNeC49uCvKS8CPlvGHuNRxq/mrP5l0dgO94gmD5URZy9B7Z
	77WQ+juITeSZ2CGvdTTQpCK0S0g41kQm+2t37MZd5g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dme18san-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 13:17:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55OAglAd002502;
	Tue, 24 Jun 2025 13:17:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jm411y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 13:17:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55ODHIJw56492418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 13:17:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A52F72004B;
	Tue, 24 Jun 2025 13:17:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ACE820040;
	Tue, 24 Jun 2025 13:17:17 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.209])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Jun 2025 13:17:17 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
        gjoyce@ibm.com
Subject: [PATCHv4 0/3] block: move sched_tags allocation/de-allocation outside of locking context
Date: Tue, 24 Jun 2025 18:47:02 +0530
Message-ID: <20250624131716.630465-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Tc6WtQQh c=1 sm=1 tr=0 ts=685aa561 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=HH1qF7aN0NmPAd2FLvUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9D6QScFQO3lmzfk2_4ClS4OwScnAlNY2
X-Proofpoint-ORIG-GUID: 9D6QScFQO3lmzfk2_4ClS4OwScnAlNY2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExMiBTYWx0ZWRfX+v537+TdDoMN J89lI6A9wTgs5k7/IC4D4SK3T//eD/1FAj1GF59o1qOe3TMjCWYKyrutd2OXKpcZqNzOiv6V5BI CmWZO/jm9MjeNKopaPs/udnzxEqgPgLVJCsE+ZEQ7yO6PleOH+93+z/aN4eGTaJbirRjjYZtdE0
 eNllRl49O7d6gwJ74OllAXruzsQHKzukZ2TqxC3zapKDg/8B4Vd9K14J9OyXIFnbdkOo73ynM5+ TQTQxsdBfjMKmxGt6sqrARjiCj0VnMsdcZwPvlSHeBOPE7rObzafnbB6bSWY4VE1DckURN/OshA Qk9WDMsussUP8bozbkyDDYOQzzhLqljlr45vaEGssfeETR8cmANhQbz69KmcD0E3kMxXnGbP4OF
 R9zF3Qp8sSY4K7XVcwWbYfcgbJ4Rs0Ua/lKDbYvCP/e8iEoIyEgm5SbOul0nsdR5qpVOPvM2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240112

Hi,

There have been a few reports[1] indicating potential lockdep warnings due
to a lock dependency from the percpu allocator to the elevator lock. This
patch series aims to eliminate that dependency.

The series consists of three patches:
The first patch is preparatory patch and just move elevator queue
allocation logic from ->init_sched into blk_mq_init_sched.

The second patch in the series restructures sched_tags allocation and
deallocation during elevator update/switch operations to ensure these
actions are performed entirely outside the ->freeze_lock and ->elevator_
lock. This eliminates the percpu allocator’s lock dependency on the
elevator and freeze lock during scheduler transitions.

The third patch introduces batch allocation and deallocation helpers for
sched_tags. These helpers are used during __blk_mq_update_nr_hw_queues()
to decouple sched_tags memory management from both the elevator and freeze
locks, addressing the lockdep concerns in the nr_hw_queues update path.

[1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/

Changes since v3:
    - Further split the patchset into three patch series so that we can
      have a separate patch for sched_tags batch allocation/deallocation
      (Ming Lei)
    - Use Xarray to store and load the sched_tags (Ming Lei)
    - Unexport elevator_alloc() as we no longer need to use it outside
      of block layer core (hch)
    - unwind the sched_tags allocation and free tags when we it fails in
      the middle of allocation (hch)
    - Move struct elevator_queue header from commin header to elevator.c
      as there's no user of it outside elevator.c (Ming Lei, hch)
Link to v3: https://lore.kernel.org/all/20250616173233.3803824-1-nilay@linux.ibm.com/

Change since v2:
    - Split the patch into a two patch series. The first patch updates
      ->init_sched elevator API change and second patch handles the sched
      tags allocation/de-allocation logic (Ming Lei)
    - Address sched tags allocation/deallocation logic while running in the
      context of nr_hw_queue update so that we can handle all possible
      scenarios in a single patchest (Ming Lei)
Link to v2: https://lore.kernel.org/all/20250528123638.1029700-1-nilay@linux.ibm.com/

Changes since v1:
    - As the lifetime of elevator queue and sched tags are same, allocate
      and move sched tags under struct elevator_queue (Ming Lei)
Link to v1: https://lore.kernel.org/all/20250520103425.1259712-1-nilay@linux.ibm.com/

Nilay Shroff (3):
  block: move elevator queue allocation logic into blk_mq_init_sched
  block: fix lockdep warning caused by lock dependency in
    elv_iosched_store
  block: fix potential deadlock while running nr_hw_queue update

 block/bfq-iosched.c   |  13 +--
 block/blk-mq-sched.c  | 238 +++++++++++++++++++++++++++++-------------
 block/blk-mq-sched.h  |  19 +++-
 block/blk-mq.c        |  12 ++-
 block/blk.h           |   3 +-
 block/elevator.c      |  52 +++++++--
 block/elevator.h      |  21 +++-
 block/kyber-iosched.c |  11 +-
 block/mq-deadline.c   |  14 +--
 9 files changed, 267 insertions(+), 116 deletions(-)

-- 
2.49.0

