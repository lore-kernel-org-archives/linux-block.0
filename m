Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9BC1411DE
	for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 05:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751262493; cv=none; b=PnlnSuDPlEgIDb/r99A0/duaQ4qd7QtIPX5HuoFm5jtz+miCeTW3j3ac1398VeZOprqfZjijMp6EIZO37mPGMZWkuzXbEoujEkpsUdzMQQB6oVB9J7o0boE892X4EsY82ZNjgn+Mw86hEWhThYiuJIwDqDTVsHDSELUUKY8CLH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751262493; c=relaxed/simple;
	bh=n/EesmY3LWI5YvsaobPncQ5c1dHxrkrdDZAOBlaZjLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Od4T+bhW8Us+dCSSEUc8z7XCW5IpV7c4pbF67OEbBLSnP3+G34VyfNe+k1NgmN+++HHfQ7Wz7VGk0DmzZNjaD91itA/utiKS4/4+A7zvBPBN/UewIYed+nn6XHaHklVn2qcIj+dfmkeM6AcnJ0drt/wdyRQCJ8QitvzeI/7l6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EaXd06rN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EaXd06rN"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TMlOgh011661;
	Mon, 30 Jun 2025 05:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=6CPmGPQZ9+hbq5Wo++PnGUliyOMV
	isWMkd5wtWX4fA4=; b=EaXd06rNPXISycZQ6dOkyOI0qsmNaw9Sd/Ibw7h0X7Gf
	opRYfyLqAA2hcN4kc2M4SyX2lik0OY590TN+B/fVUpAgHRow/BlwJ5bdn4ELKDLT
	74dh7XcZUCkWM+KCU/xYUZToTeBQpjJauLXwJ2AaHL3BqqfZvZnELIAsGFsUtATF
	e/DhUVrWzt7ceKvWX5c85jpDYbRK578g1B6cc7XBwEWa2saJxnf2//n+C26jozu5
	t4NiWgE+AAIsi3KapnBKw3UT/VTWFlqq9RB4KkFzj4oh7OKenGYRkX3xOnGUXtpH
	yPH6xwZNBc8OrNCJa2FLEBA4vXvpFkefvp9+dRdowg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5tsyr09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 05:48:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55U5DTC1021939;
	Mon, 30 Jun 2025 05:48:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47juqpcfkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 05:48:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55U5m3wc39125412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 05:48:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7A582004B;
	Mon, 30 Jun 2025 05:48:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B88820040;
	Mon, 30 Jun 2025 05:47:59 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.92.250])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 05:47:58 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
        lkp@intel.com, gjoyce@ibm.com
Subject: [PATCHv6 0/3] block: move sched_tags allocation/de-allocation outside of locking context
Date: Mon, 30 Jun 2025 10:51:53 +0530
Message-ID: <20250630054756.54532-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: undi7B7O2W-uQiKzjKi5pMlrLvDZYwQw
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=68622515 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=9FSKigjjmnWa1uaStcgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: undi7B7O2W-uQiKzjKi5pMlrLvDZYwQw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA0NiBTYWx0ZWRfX7/kvBb71N9nz 8nA8o93RRho2MbAjE9yJMwVHnOuMDYU9oZz0mmEnKNy6SbQe99qYnHeg/pKzA7ylEkn74wnraBy figqT68tHYQCvR9swoGjcsD3fmBcEHkjovWLnFBePbcU3U7w/NpTIzJZCMk3s3oz/baZ8e7nQzg
 QCAPZr53S+02RG/FIyy0kBg/+znrXw2xYz6WwiT1BERSJwPUZCFGOF9oPdalfdVXd4T9WLmCnfh xn1G63Xbx51VFNp4HkZ2bp/jMoF4577wwifXLkId/KX90kcZRgDiSUiRk1J3rp7gXrbNKHoUU3Y keQoikdQdnU9VuiRE/bG6KOKc4CLHi1x3mtkNodE+qXLLf4aM+M19gsTgmkfUcytbIb3Gpg6TJj
 AUspD4oqTuzonK1bvoP6xx31hO31BLB9fEtt9fv/U1qX/OPBSD7uAU6xWwKuh6btydAOFYos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=906
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300046

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

Changes since v5:
    - Fixed smatch warning reported by kernel test robot here:
      https://lore.kernel.org/all/202506300509.2S1tygch-lkp@intel.com/
Link to v5: https://lore.kernel.org/all/20250627175544.1063910-1-nilay@linux.ibm.com/

Changes since v4:
    - Define a local Xarray variable in __blk_mq_update_nr_hw_queues to store
      sched_tags, instead of storing it in an Xarray defined in 'struct elevator_tags'
      (Ming Lei)
Link to v4: https://lore.kernel.org/all/20250624131716.630465-1-nilay@linux.ibm.com/

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
 block/blk-mq-sched.c  | 220 ++++++++++++++++++++++++++++--------------
 block/blk-mq-sched.h  |  12 ++-
 block/blk-mq.c        |  11 ++-
 block/blk.h           |   2 +-
 block/elevator.c      |  50 ++++++++--
 block/elevator.h      |  16 ++-
 block/kyber-iosched.c |  11 +--
 block/mq-deadline.c   |  14 +--
 9 files changed, 234 insertions(+), 115 deletions(-)

-- 
2.49.0

