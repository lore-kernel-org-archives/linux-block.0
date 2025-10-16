Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9681B6CE9
	for <linux-block@vger.kernel.org>; Thu, 16 Oct 2025 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760592680; cv=none; b=hz/We1zuXw3NdkpJ00MhEkh8gCitzlRL7uXOVfmNsYOTbhcDPjAcvRZVj1WMTD0td2ATE0ovIxBHfd6NxtL7RL1GVFc57QGhytzN9oOKg9UHSD0Ty9KeZ/44zs85MgAsoaIShAhmye9YKEOnWrjvyGyYvBN2tLFee4wwwS0CXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760592680; c=relaxed/simple;
	bh=J8rITPbUcHbWGCXaVDEwNbg0/DY6vZySE0Nb3qCOOmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HKVtzHOppBi1h8TS/wtki+VWwaUV8qpiiMtqramg/kGMcBYPDcLqrT88rpT/KsXIo3fx1OVFN2/uBkZ8asaAE5DfG86Q1c7HRXsRPp5uz/IcKAegCay/ktSUcybxR5svY2ZMyD8SGqr73LtzVrs1KCANTYP4gFXw2Ff4u19OWPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U4ApId91; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U4ApId91"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FLut9u021094;
	Thu, 16 Oct 2025 05:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=3bWYIglzDWrZuD+myBlpztiQ3q1r
	HI6gXVKl0RbUdQ0=; b=U4ApId91Ziw8PsXaXfFh6o6rpaTI8xMtQApaZWwOqgxx
	CyIn2XgOvKKhQmpiwakDXeFcIonLO9haVdSzkWaMfCF4AJ92jFeLdmxtdMcWJ88w
	yuCzEwPQubwA0ARJZYW2JVic7DsgoNrde1VBfg7LGztIJdEOuQhinzEq6UlmRoNz
	HUgIj9lkEYKsfCBiOZ7A7yRGMWGasoVlp4iTUQSR3t29J53ZOsoAZdhtpSIQKx0R
	n45rDZqBcfj8EZ3LugX9jB9IqGraEzYgu6mi91YcaNNnGztQ/tdypZ8lniM9FtN5
	Zm49U/B06JIPolmhpQ/xYkQsGflWTD9GmREitv0e6w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew07jmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 05:31:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59G1UZWN003603;
	Thu, 16 Oct 2025 05:31:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy4699-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 05:31:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59G5Ux2h52625834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 05:30:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAD3520043;
	Thu, 16 Oct 2025 05:30:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08CD320040;
	Thu, 16 Oct 2025 05:30:58 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.148])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 05:30:57 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, yukuai1@huaweicloud.com, axboe@kernel.dk,
        yi.zhang@redhat.com, czhong@redhat.com, gjoyce@ibm.com
Subject: [PATCH 0/3] block: restructure elevator switch path and fix a lockdep splat
Date: Thu, 16 Oct 2025 11:00:46 +0530
Message-ID: <20251016053057.3457663-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6batIf_lzH2rAfmhvY5sy1jip4NMO2_W
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f08316 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=x5zcrRF_My3Oqs6tCGAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfXxEk6TDIEm+N+
 g0/QfjgQIZTsgKmXskZC50XXL6t+nsdnljcKa5BDoyt6Mja/pKEAtVD7fJQ/yTHW9WkQG4aoryr
 AmUNpwJo0Riee5ICjZy6lG+sfi7e+BrmtcSTjo4nClshIJCeUeOOKNIbVAPdHa2BagrUZ8SDLWd
 dRgymk1Ho4bIohXsWmYTMeDMvK99R0/KudDcuzM+rGInFT4Z6aZFQ3xTRj3MP4Sy33MvUZ2Ychi
 YnfFmMZVL5IOJZuWTeKiM/S3w6ITwOwoBUtmFohcxe7Ryl3p1qPcaS1DdCok2WrlVmuUEtREEDC
 ggy9ltEPHG9mSGabuM6RFlKVwWO4kRXc7k2bBDRvU/qv9dkmj4nCb4gXdhaIT6Xr/mdUybkaee2
 WVZig1NDUFAuN6/PmmV9yR1BgboJeg==
X-Proofpoint-GUID: 6batIf_lzH2rAfmhvY5sy1jip4NMO2_W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

Hi,

This patchset reorganizes the elevator switch path used during both
nr_hw_queues update and elv_iosched_store() operations to address a
recently reported lockdep splat [1].

The warning highlights a locking dependency between ->freeze_lock and
->elevator_lock on pcpu_alloc_mutex, triggered when the Kyber scheduler
dynamically allocates its private scheduling data. The fix is to ensure
that such allocations occur outside the locked sections, thus eliminating
the dependency chain.

While working on this, it also became evident that the nr_hw_queue update
code maintains two disjoint xarrays—one for elevator tags and another
for elevator type—both serving the same purpose. Unifying these into a
single elv_change_ctx structure improves clarity and maintainability.

This series therefore implements three patches:
The first perparatory patch unifies elevator tags and type xarrays. It
combines both xarrays into a single struct elv_change_ctx, simplifying
per-queue elevator state management.

The second patch introduce ->alloc_sched_data and ->free_sched_data 
elevator ops to safely allocate and free scheduler data before acquiring
->freeze_lock and ->elevator_lock, preventing the dependency on pcpu_
alloc_mutex.

The third patch converts Kyber scheduler to use the new methods inroduced
in the previous patch. It hooks Kyber’s scheduler data allocation and 
teardown logic from ->init_sched and ->exit_sched into the new methods, 
ensuring memory operations are performed outside locked sections.

Together, these changes simplify the elevator switch logic and prevent
the reported lockdep splat.

As always, feedback and suggestions are very welcome!

[1] https://lore.kernel.org/all/CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVyjO0=-D5+A@mail.gmail.com/

Thanks,
--Nilay

Nilay Shroff (3):
  block: unify elevator tags and type xarrays into struct elv_change_ctx
  block: introduce alloc_sched_data and free_sched_data elevator methods
  block: define alloc_sched_data and free_sched_data methods for kyber

 block/blk-mq-sched.c  | 104 ++++++++++++++++++++++++++++++++++++++----
 block/blk-mq-sched.h  |  35 +++++++++++++-
 block/blk-mq.c        |  56 ++++++++++++++---------
 block/blk.h           |   7 ++-
 block/elevator.c      |  76 ++++++++++++++++--------------
 block/elevator.h      |  23 +++++++++-
 block/kyber-iosched.c |  30 ++++++++----
 7 files changed, 252 insertions(+), 79 deletions(-)

-- 
2.51.0

