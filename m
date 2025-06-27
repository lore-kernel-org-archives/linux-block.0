Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92582EE5FA
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046967; cv=none; b=ZihBMqyW4jPNf1KU+Cdub9kI3zmh8A3FaV3vBbp/Z1WddJlZy+PucWKa8RDmekL1JfIU7DBL7Jnq8xt53XFkgmrm/jmcZ9fdckhxaskmElcY2r9hctvntsRbq2z1ixRO94KSrOr5QPrEFZoDJT9xKa6ZQ0w64Dg4AbMB8YM743Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046967; c=relaxed/simple;
	bh=lVJciQkPZ3wUj0P/T780xc4XyiDPPyeY3l6w6ieppPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g3D54hQrCVx31h/l/RWwzAba5aUL4dGkZ/SXx7+dEuBZJ/XZ/puEOfe6y7cyyfnCmSRZBiKc1xT249eJ0UZPT9BRQ/ZEn/vC7gJ44AHzzasIxTGoJDUYSiMjREZTKrL9qtY9Y8lxs57y4jbsbuguUO6Vjv7DyK4+8o/kzHGoy84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PxmqHn+r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PxmqHn+r"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R9V2uK020561;
	Fri, 27 Jun 2025 17:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=RNaIn12sTZPD3CRI/QPGPP6X6ue+
	TLndofFLED0b7LM=; b=PxmqHn+rgp07K6Btuw4m3PLi1pLbbYmcKNZ7+SryXLPQ
	h4foCL1E0BjMmIysTjTVjrLSCm5LDD4DF+3fLg9Mp/t0aTx8hQk/Jse6vmhkEWuN
	BPtjZxlipfiVSKmUfMVw7fwYskSWMxuCssastDsFdy15GuzsDyE/48p6Ws96T2AA
	UA+/Xp0izts2hNpdBP18Iagqo++B458SCvmBAYsgSsnY3Qz/OM2zPCmWwp8UxukY
	nR18Zv6lSWSbx++7KjgUQwww7zkX5QLDMHkfuEiC5hH40X4zH3j/S+js44JcGomM
	2URQfuPmLrS6peYC6402G2gWMzONAUukY0q9SQP+Dg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf3phhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 17:55:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55RH0JO1006408;
	Fri, 27 Jun 2025 17:55:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82pnbgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 17:55:53 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55RHtpq021955004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 17:55:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62BDB20043;
	Fri, 27 Jun 2025 17:55:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F05620040;
	Fri, 27 Jun 2025 17:55:48 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.18.63])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Jun 2025 17:55:47 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
        gjoyce@ibm.com
Subject: [PATCHv5 0/3] block: move sched_tags allocation/de-allocation outside of locking context
Date: Fri, 27 Jun 2025 23:25:18 +0530
Message-ID: <20250627175544.1063910-1-nilay@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=685edb2a cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=9FSKigjjmnWa1uaStcgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDE0NCBTYWx0ZWRfX04TNt3tAdUZ2 vdKVm1UD9AG25IVKdogvDZmwV7F9R2f7M+Wxq2P2RdAm+6cKbUx7Ll/JrHcX0k3OeH3XOvP6+C8 B5f3yn7gUngxxlr1rOb45J3ToQIBA/EiexEB4pt/E2tF6nBRNyYrwb9P/TNy91jA6Ci72lVjMdC
 /kCSEiV9S5pkFb3SJTOQ1aPymwHWIGgRGVGHRnbv6VKYoMyzEL+iT2zB9UPDbvtHaAdtUtoNeXw 6Dz+9LYeqibrDfiFdmhe20RobWSjtBwSzv+dhripuJCrTImmhXhScIeVQlPYyq/dqXzyrW6C+sF LMo3ztoomu/r9N0j1+vwb0TNSBiCTHRW/6o4xvj0AcUE+IMnHhU/ZR1944eYmGM0KPRRqVFEaGg
 +D/O1vafEwzk7iZZWPvsIVSSgBS7SdgeozFfpGUYM54TtQdD8jjetYTnW4t2uQLACKGewMGm
X-Proofpoint-GUID: -To47KHRJlwbCSF67ywg_lTB8lJ0eusP
X-Proofpoint-ORIG-GUID: -To47KHRJlwbCSF67ywg_lTB8lJ0eusP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 mlxlogscore=969 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270144

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

