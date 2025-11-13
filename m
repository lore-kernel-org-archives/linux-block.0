Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D423F286A4
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024800; cv=none; b=BXFNxTZeJ9IY81yvriv8oAlCdk7OSgic0H0mRi+nH+YVKsz7HEwIAkGBbs2cgYF75NC4YdEnWiUmRaXaZUk4xPFkp6KuL10Gg1aCffMaROM0dTumhUSRM6ygKF/E7Yesll/BcOmjzYlWdxY3FmskL+Jdu5qWHh+aQYbEm5aVTRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024800; c=relaxed/simple;
	bh=CMDGvn0xrL7nbhZIqGp0baE0+dQes9KdL9gbXLJ9+yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QBPdKK0cU1cwtamWAC3QFp300wFKd77t1A9A3JJhWcn8gdHuXukSz+vfvp5NCVlpEZqr9KRY8BhWjSRzuT1MaqslG6t+mKvZNAlm6LaDheGZsn8e2kJJ2gA5JGO0S+JR9X48KCvgTc//i5rqbqNCJX3qm0acxqtTX2NM12/Yj0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cCCy4nIF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cCCy4nIF"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACMa2ba018118;
	Thu, 13 Nov 2025 09:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=L5F98UKLt9WR/1GtIbfw5opZaATa
	CLCANNDNZaqiZz8=; b=cCCy4nIFNMFDHmHxeovO3XIZ+qWDCXLmKTtMxjeuFcep
	tBCYa+GJv/L6wrn/Sxb6px6rec+FMZL9qUPgKcpi3JuFFoQfWayL5OE9vOQA9Aim
	/m0TlUbAt+kNd4dke4AqG/5rCVQ/LClXO86IWq+TeCtkBPTM/tefBmUF0mxF0ING
	+a40CBJuq7XAxMABGhe1qr/3bRjzZMGy4Hkr0GCn5JtADGJ6oJZ6gRRRD7CR2tG7
	MMy3MmySGAIIoo/kLTMsSOpABKUMgVXDTNAimlqXTJci9/+IXSp/Q4cy8WTfXyYG
	FZ3TTJCvsKB+Z3PdgCIv24tZkiJJlyxMQZm30fvz8w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cjdu5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 09:06:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD8cetG008182;
	Thu, 13 Nov 2025 09:06:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aah6n4xjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 09:06:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AD96M8P56426786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 09:06:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0923B2004F;
	Thu, 13 Nov 2025 09:06:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45DCB20040;
	Thu, 13 Nov 2025 09:06:20 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 09:06:19 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, yukuai@fnnas.com, gjoyce@ibm.com
Subject: [PATCHv7 0/5] block: restructure elevator switch path and fix a lockdep splat
Date: Thu, 13 Nov 2025 14:28:17 +0530
Message-ID: <20251113090619.2030737-1-nilay@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=69159f91 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=5mTiuFpr0edpLGR4-ccA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfX4MbBWJJI+nsd
 btTwLPcLxeBt0sQL/ox347a6PmvGS/j0Ws0Haq/cmnx6kmUsVZGHEhbv/jd3SKBMkHY8KylrpT1
 kdoNZ6LekeyPei4p85tVqDY1yGGHBfkbBgYec603lo2m/7qNA7w5D/HiYvCDykge8CT2jaApSLD
 V0zL4ZoxfMgoD3bWiJIebOnI+we8nh3m4EOLupowuxgHWgwgCa2PRfGKiqgQ+z84YDYRmpbJFo3
 RIjK7tcm0MmlwiO/bzm6SJjiwg/blXem/PnFEl66qwchqgvi39wQzK343q/qn66n0AXsa+NZreN
 Q8Q+zUBJn9KsvJZTjain6aI9UjRqHVRH+LfK33IZO44VGyuAeLP/j7pzavQLNrvoCrEEYaX2Y27
 q+Rr1ZnVndBIeiXiCfuo2ZA2Asgqyg==
X-Proofpoint-GUID: g4dxgZ6pX2Au1Fprxz6IQVIu3oMe6Bn6
X-Proofpoint-ORIG-GUID: g4dxgZ6pX2Au1Fprxz6IQVIu3oMe6Bn6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095

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

This series therefore implements five patches:
The first perparatory patch unifies elevator tags and type xarrays. It
combines both xarrays into a single struct elv_change_ctx, simplifying
per-queue elevator state management.

The second patch is aimed to group together all elevator-related 
resources that share the same lifetime and as a first step we move the
elevator tags pointer from struct elv_change_ctx into the newly
inroduced struct elevator_resources. The subsequent patch extends the 
struct elevator_resources to include other elevator-related data.

The third patch introduce ->alloc_sched_data and ->free_sched_data
elevator ops which could be then used to safely allocate and free 
scheduler data.

The fourth patch now builds upon the previous patch and starts using the
newly introduced alloc/free sched data methods in the earlier patch
during elevator switch and nr_hw_queue update. And while doing so, it's
ensured that sched data allocation and free happens before we acquire
->freeze_lock and ->elevator_lock thus preventing its dependency on
pcpu_alloc_mutex.

The last patch of this series converts Kyber scheduler to use the new
methods inroduced in the previous patch. It hooks Kyber’s scheduler data
allocation and teardown logic from ->init_sched and ->exit_sched into
the new methods, ensuring memory operations are performed outside
locked sections.

Together, these changes simplify the elevator switch logic and prevent
the reported lockdep splat.

As always, feedback and suggestions are very welcome!

[1] https://lore.kernel.org/all/CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVyjO0=-D5+A@mail.gmail.com/

Thanks,
--Nilay

changes from v6:
  - Update blk_mq_alloc_sched_data() to return a NULL instead 
    of sentinel pointer when ->alloc_sched_data method is not
    defined. (Yu Kuai)

Link to v6: https://lore.kernel.org/all/20251112132249.1791304-1-nilay@linux.ibm.com/

changes from v5:
  - Update blk_mq_alloc_sched_data() to return a sentinel pointer
    when the ->alloc_sched_data method is not defined. Also update
    its caller accordingly to use the IS_ERR() macro to distinguish
    between success and failure cases.

Link to v5: https://lore.kernel.org/all/20251112052848.1433256-1-nilay@linux.ibm.com/

changes from v4:
  - Update the signature of blk_mq_alloc_sched_res() in patch #2
    and add a struct request_queue * parameter. This allows direct
    access to blk_mq_tag_set from the request queue, removing the
    need for a separate struct blk_mq_tag_set * argument. (Ming Lei)

  - Update blk_mq_init_sched() to add a local variable et of type
    struct elevator_tags *. This avoids additional code changes, 
    as we can avoid dereferencing struct elevator_resources *res
    to reach it. (Ming Lei)

  - Simplify blk_mq_alloc_sched_data() to return a pointer to the
    allocated scheduler data on success, or NULL on failure. Update
    the caller accordingly to use the return value directly instead
    of passing **sched_data as an additional argument. (Yu Kuai)

Link to v4: https://lore.kernel.org/all/20251110081457.1006206-1-nilay@linux.ibm.com/

changes from v3:
  - Split the third patch into two patches to separate the introduction
    of ->alloc_sched_data and ->free_sched_data methods from their users.
  - Free scheduler tags during sched resource allocation failures using
    blk_mq_free_sched_tags() instead of kfree() to avoid kmemleak
    (Ming Lei).
  - Delay the signature change of elevator_alloc() until the fourth
    patch, where we actually start allocating scheduler data during
    elevator switch and nr_hw_queue_update (Ming Lei).

Link to v3: https://lore.kernel.org/all/20251029103622.205607-1-nilay@linux.ibm.com/

changes fron v2:
  - Introduce helper functions blk_mq_alloc_sched_res_batch() and
    blk_mq_free_sched_res_batch() to encapsulate scheduler resource
    (tags and data) allocation and freeing in batch mode. (Ming Lei)

  - Introduce helper functions blk_mq_alloc_sched_res() and
    blk_mq_free_sched_res() to encapsulate scheduler resource
    allocation and freeing. (Ming Lei)

Link to v2: https://lore.kernel.org/all/20251027173631.1081005-1-nilay@linux.ibm.com/

changes from v1:
  - Keep blk_mq_free_sched_ctx_batch() and blk_mq_alloc_sched_ctx_batch()
    together in the same file (Ming Lei)
  - Since the ctx pointer is stored in xarray after it's dynamically
    allocated, if blk_mq_alloc_sched_ctx_batch() fails to allocate or
    insert ctx pointer in xarray then unwinding the allocation is not
    necessary. Instead looping over the xarray to retrieve the inserted
    ctx pointer and freeing it should be sufficibet. So invoke blk_mq_
    free_sched_ctx_batch() from the blk_mq_alloc_sched_ctx_batch()
    callsite on failure (Ming Lei)
  - As both elevator tags and elevator data shares the same lifetime
    and allocation constraints, abstract both into a new structure
    (Ming Lei)

Link to v1: https://lore.kernel.org/all/20251016053057.3457663-1-nilay@linux.ibm.com/

Nilay Shroff (5):
  block: unify elevator tags and type xarrays into struct elv_change_ctx
  block: move elevator tags into struct elevator_resources
  block: introduce alloc_sched_data and free_sched_data elevator methods
  block: use {alloc|free}_sched data methods
  block: define alloc_sched_data and free_sched_data methods for kyber

 block/blk-mq-sched.c  | 117 ++++++++++++++++++++++++++++++++++--------
 block/blk-mq-sched.h  |  40 +++++++++++++--
 block/blk-mq.c        |  50 ++++++++++--------
 block/blk.h           |   7 ++-
 block/elevator.c      |  80 +++++++++++++----------------
 block/elevator.h      |  26 +++++++++-
 block/kyber-iosched.c |  30 ++++++++---
 7 files changed, 248 insertions(+), 102 deletions(-)

-- 
2.51.0

