Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867FB291C23
	for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861605; cv=none; b=GbJZJ656eKqOVFHd4kHIs2+v3oe4pTwbTeZbE2lRtWnn0R31p5DTG1F0tToSWw/9YrRju2GIoxfELg1OlU22iMH7HDTCt7kTD9TNA6ULEtbwwOv4DyqP4g0W3srlGn/KwKUE/aw4jDQvyUItZi1TfxQMzA7A1eyjqlAlaVTHc7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861605; c=relaxed/simple;
	bh=zmn5Y9tJYPQoIkrFMpp5uJJQboKCyMyHKVS+fwqFN9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XYbYnEnMCud6Nel9NmI1QtLPky2aQXL5K3ck/bhEzDZAIJIafCNp3hmTcdSXVCmGmfa4hBTWyBN/+4F3BD5g2V5lAoTE0OmKP+V5yrR5RRDgrk2EC6BuIncbKJAMvzV5ZUWObqzY55jZvZo62AjmEBQaNVO0r4d57ZWX5lhAC0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WuWBNBl2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WuWBNBl2"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TN5nLQ015093;
	Wed, 30 Jul 2025 07:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ayX/dvFIW7N9VJokShGg9bn2Kxid
	G5IzIKwFF8lbWMQ=; b=WuWBNBl2y1fNE8gpa86FWKXluEarSNmQVDBf5OpxHcBF
	FDTiPVA/38MiL0x4PVhvV7lZ/oUGn3f4MR6O6QSi453qGqqEDVALcomRSDQEcRe2
	3HFAl7ccvLrBnDvnSvhLjfx2TOkw7U/vE38V0IhW6LVemIJMBzG1jHG8tIm1fDIo
	gayTM3vQwZi0UkuViFpvmbVSNzi7maQNDEw8pNtX8+Hlcp+O2v9jMWBCkEr3PtVB
	wu+nB3A6gxtO1Sb3b+ftYJ/XrphXw/qRDMX+bHUR4O1Lf90PVvsdbbTA4mJm08nu
	fk7mREx19adzQWNS6k55yLIKa6PxFTOiHivLwe0Jig==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfquanq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 07:46:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56U6qh27006192;
	Wed, 30 Jul 2025 07:46:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 485bjm67u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 07:46:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56U7kJuH59507138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 07:46:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EEA52004B;
	Wed, 30 Jul 2025 07:46:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D17B420043;
	Wed, 30 Jul 2025 07:46:16 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.45.161])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Jul 2025 07:46:16 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com, hare@suse.de,
        sth@linux.ibm.com, gjoyce@ibm.com, nilay@linux.ibm.com
Subject: [PATCHv8 0/3] block: move sched_tags allocation/de-allocation outside of locking context
Date: Wed, 30 Jul 2025 13:16:06 +0530
Message-ID: <20250730074614.2537382-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA1MyBTYWx0ZWRfX6KMOzy/jQsz3
 IoCSPHZeC6qXulvWnNDW2T9Fg3Q6LHDy7L4Fnn/IuAmq1F2acEwYjUJXHeYK45ZC85JEC93fwl/
 jW7vFZrQbNVX8RRw2LfkMiSuFIhHpNoHBIvGlehoed/zdhLsA0TpEXthPAWSQohLM4nmUkNoAbC
 w/OUWqvsD7gRV4ZAZWx96Chwsy2D777MnZ8p8HuJVLb/kkW8yAtQmZYOf5lza0zHg8e1WlUVVYU
 TiRqSV+PMr+r7IDJsTpaPjDartsm3kh7Xbeq6CP7o2oLDIX/k6fMsRXNp/o9NcS+b6moN/zXNcr
 F2jKS4igB7V9KkWYeaOneT5QU/14crNAaCSTh1WLaUX7eMT+0uHjuGMHO2sGN5KqhFQwJY6EmdG
 fEGkaxLWV0MPyERBSB1u0voj9aDElJBFxL/ebmyfGgcjt3kkWcgHLasors4K/lRa5rYe1e3w
X-Authority-Analysis: v=2.4 cv=Je28rVKV c=1 sm=1 tr=0 ts=6889cdd9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=QyXUC8HyAAAA:8 a=mP2AG4EPkgleVpjgma4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cnjxBFQMoOgtxz-4tSaTGdQj-H0VHzpa
X-Proofpoint-ORIG-GUID: cnjxBFQMoOgtxz-4tSaTGdQj-H0VHzpa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=799 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300053

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

Changes since v7:
    - Rebased code on top of block-6.17, commit 5421681bc3ef ("blk-ioc: don't
      hold queue_lock for ioc_lookup_icq()")
Link to v7: https://lore.kernel.org/all/20250701081954.57381-1-nilay@linux.ibm.com/      

Changes since v6:
    - Add warning when loading elevator tags from an xarray yields nothing
      (Hannes Reinecke)
    - Use elevator tags instead of xarray table as a function argument to
      elv_update_nr_hw_queues (Ming Lei)
Link to v6: https://lore.kernel.org/all/20250630054756.54532-1-nilay@linux.ibm.com/

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
 block/blk-mq-sched.c  | 223 ++++++++++++++++++++++++++++--------------
 block/blk-mq-sched.h  |  12 ++-
 block/blk-mq.c        |  16 ++-
 block/blk.h           |   4 +-
 block/elevator.c      |  38 +++++--
 block/elevator.h      |  16 ++-
 block/kyber-iosched.c |  11 +--
 block/mq-deadline.c   |  14 +--
 9 files changed, 228 insertions(+), 119 deletions(-)

-- 
2.50.1

