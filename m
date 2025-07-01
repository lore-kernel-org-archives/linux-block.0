Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7913B26B0B2
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751358011; cv=none; b=Z9KV+SURGA8XgjgjC40o3tyzs9BzinGKZlsBF5AC1JIDS8mDJakMkorVIpJvfBlynQff/4mN4eKzMqMafenUvEl+S4lSkV24m5gbUv+UiFsvvGsb3CqmVy51Wo8/gHELS0zulutnd6qVa4zouqjTb75O10q6TLjXdkOF0VFTSOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751358011; c=relaxed/simple;
	bh=2MWlZ+rnnQySfjO31dgt1/gTxqK3JLD4TRNwUu/yqn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GkzXMD8w5r91E+YaeN79W7OIXSnwNht5vyi7rxi+8P5VeDuPY1j2s1vc0ADsAjbazjFzxTnhijHMB8R0XaMhOKsmCkF5cQ7yoWE3FyLtAwbqPHYTmrNdtOy9KqjFcdW9cc7lY/4fPMRaZptePDIaDqnivy8T1EwVyNPtR9B6V5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hSM2cWAm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hSM2cWAm"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5614Pci1012358;
	Tue, 1 Jul 2025 08:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=psW02rwFdUiMYOQ1yMOrqwR5Y63E
	BoI6xKHAEzTYldI=; b=hSM2cWAmijDd8v2f4vM6OQA8np//2TLg/6qYd4zRWkHa
	xFLQCjsjZd3VFf0na56zL+XDpH3Pk5njOxUZvpuxdkqQTUx53SVl+/4IVtoQGImk
	QS+gEbliKJUU7fWaaxLvavAoEHwtov3DF/EnrrqkWvsVVY1Td9nc3P6kBS4U2sT+
	dNmhgPCadEXm5HHyJrD9yoXhxZh+Wh4a3KvlxTZuQ+1PBU7791tiFb5vhLJEccT+
	9nL3Awvc4w9jL6sLbajnzc7c20VhtKH8hQIfu5cIx3z706pGOwp/hQo/OcCqvKkp
	4NUKqLDX/4zn2TThFUizj0YDZGfg8wsEm2wJHT3JGA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830p3yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 08:19:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5614w0e7021407;
	Tue, 1 Jul 2025 08:19:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jwe39ept-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 08:19:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5618Jvo652167108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Jul 2025 08:19:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34B3C2006A;
	Tue,  1 Jul 2025 08:19:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EF9D2005A;
	Tue,  1 Jul 2025 08:19:55 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Jul 2025 08:19:55 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, axboe@kernel.dk,
        sth@linux.ibm.com, gjoyce@ibm.com
Subject: [PATCHv7 0/3] block: move sched_tags allocation/de-allocation outside of locking context
Date: Tue,  1 Jul 2025 13:48:57 +0530
Message-ID: <20250701081954.57381-1-nilay@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: LyKDroHTQoFRojdpiFGv5aYy-6F7Aanj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA0NyBTYWx0ZWRfX/g3NUhK9nDpd nVe/XfS9tqtV1bwVASswO/UOSE2Kkma5bMEfr0m5zPWhDsXquehU8Wzc8EpMbNdbN16IFjWiMuF IFjzDfHgxtehbc3Kh/+eJ2/Mw8/n6PnfExoq62C68/n583F3zYGVWW1W3b70UsVIIspYnVngslg
 YLJpPVFnrH3mlTCnVhyvqQHzolDbkJVOK9NYYLLq5c6N7uO8T1HSmsVAYBNB4dNj+W/YgjQ0Hbn HfhngxloQTqqXWad5wGNmt4YDlDKRUDoZeu65MBy+MLLTTxrMMkV1P0p7EiGbW4n9hqERoHmgZI aTNdUyEBThzT6lVsp9Lp8HFEiRMj+mwGjBwfeZggpz18ZId+K3fwCw5Bd2bLUSWt7HL4QyEW87w
 zJhSGeAchMcJx4xHvXMCioP4YRX5VMIq94sk2BYFDEH359ITnCyr+U4FHGjdVae04vshmIdy
X-Authority-Analysis: v=2.4 cv=MOlgmNZl c=1 sm=1 tr=0 ts=68639a30 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=tONhe7rmRp15F2rhOksA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LyKDroHTQoFRojdpiFGv5aYy-6F7Aanj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxlogscore=891 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010047

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
 block/blk.h           |   2 +-
 block/elevator.c      |  50 ++++++++--
 block/elevator.h      |  16 ++-
 block/kyber-iosched.c |  11 +--
 block/mq-deadline.c   |  14 +--
 9 files changed, 241 insertions(+), 116 deletions(-)

-- 
2.50.0

