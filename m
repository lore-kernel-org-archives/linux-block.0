Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA6C253F39
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734204; cv=none; b=WyxGC59cHZIi+q3EFBUV4EO3dCw+MlZMeSk55W3z6SiY1hBGGO2FD+X4PEQwSPZjQ15Kba3mHTn+0c/nVPLxXNVlppJsmytrXs+dd50ghZXq+VHKT+WTWVea5LFRACbyiuAm7WVoxQJNj5+uokFfO7ALywaFLlTv9u1NzOaJMBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734204; c=relaxed/simple;
	bh=gd1aHIu4DxPOmi1O3sYNgIJBsVXnuUcqomtdfI10Z7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gVHd0+iaGsHXaFWEZITmPYTXuQSL2fRa4WfbTBKCR2QMMyoctj0dKE8XoL4pSGPxdGzxd9UtFA7xvOyLIE2IcRoGb0I6022ch7hz4Ku/hnKtgKBRdg9+9mmlW0KnDRVNnjDExYKAifWLT9dee+RSgSZxwDMBfefCiIpz2mTvIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tsAGpe81; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tsAGpe81"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SJmIOq008805;
	Wed, 29 Oct 2025 10:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=UWZOA8JqbpzIG0ndM9DxlSX3k7+d
	Lb4btc+ed3fakRM=; b=tsAGpe81AVXYO7KzVeLIAms/x2D8hLn6X2ZS3Gne5Wv/
	bvcGU1gJ9/Kh0HAeRxfYj0z+dlBzGHkHZviVHDKj7SOg6vTdW8OrjFMhM6RC4A9+
	QnKfI4QVotzua1Up3pCbqER2mrphziSB9JCEcq8dU7pPTImKr3cRLweN5Jvf3CuD
	lnIbtXIu14eaCV6rkLggXeWAJMJy+MbMPsZv8C9+VFuTkiBaSjN+woO2ICHXktP3
	gK2pww/xdj835aAx3LIJE2wAIGSp2lYn6QG8mb1ByonnrFZjDMVq50+VbDa3rA2f
	1aIXj1bP6uiEmFNu1pssrRrxWhcnFf1HBxNtxL2UAg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34afarmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 10:36:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T9fnID019545;
	Wed, 29 Oct 2025 10:36:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xy2vb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 10:36:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59TAaWrK36765956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 10:36:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 640A520040;
	Wed, 29 Oct 2025 10:36:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20BE32004D;
	Wed, 29 Oct 2025 10:36:27 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.159.127])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Oct 2025 10:36:26 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, gjoyce@ibm.com
Subject: [PATCHv3 0/4] block: restructure elevator switch path and fix a lockdep splat
Date: Wed, 29 Oct 2025 16:06:13 +0530
Message-ID: <20251029103622.205607-1-nilay@linux.ibm.com>
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
X-Proofpoint-GUID: fOrRu6F6NZYRvtQOV5PTy7-onYB9oeui
X-Authority-Analysis: v=2.4 cv=WPhyn3sR c=1 sm=1 tr=0 ts=6901ee33 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=y2R_jqRpL2hJ2ppOSVcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX1Q8KigkcbJ8P
 3W5wT0xwGUyEv7TZ0RCGtacWZeOV9/NNY+G/mpu8grixJSMMhp4iO07SfjGzGhNUlHu7jw7Kv7R
 GZeiiMSZXniCajSaC5I0EABvggmkCe6+R7eF+pnaizWfx0f0WeyHZtxVoMfzIyx70fn2M3RjRqQ
 klVgfRfVnG/ayEhx05aKBqw+NCkgHARYEk8XtOwPcwX6S4plaEzs0dpxdbGHFd0S0Ln/EM0aDO2
 7SfEjItf2fQapro4nOt+2PpNDBB3sQGW3B+62f2UUhvEC5/PKJ0Dn2QsuG7bEhM1KDVhigsV/JG
 9wL9IcF4qdGZqBedqcCDhMUfMxNX4HbXs4CLsze+omnck6RbXNBbvNcOhweObD4baf5Z2kwYPNc
 WeBebZgurjImnH+lmGdicD3vF0U6dQ==
X-Proofpoint-ORIG-GUID: fOrRu6F6NZYRvtQOV5PTy7-onYB9oeui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

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

This series therefore implements four patches:
The first perparatory patch unifies elevator tags and type xarrays. It
combines both xarrays into a single struct elv_change_ctx, simplifying
per-queue elevator state management.

The second patch is aimed to group together all elevator-related 
resources that share the same lifetime and as a first step we move the
elevator tags pointer from struct elv_change_ctx into the newly
inroduced struct elevator_resources. The subsequent patch extends the 
struct elevator_resources to include other elevator-related data.

The third patch introduce ->alloc_sched_data and ->free_sched_data
elevator ops to safely allocate and free scheduler data before acquiring
->freeze_lock and ->elevator_lock, preventing the dependency on pcpu_
alloc_mutex. In this patch we add elevator-data into the struct 
elevator_resources, which is introduced in the previous patch.

The fourth patch converts Kyber scheduler to use the new methods
inroduced in the previous patch. It hooks Kyber’s scheduler data
allocation and teardown logic from ->init_sched and ->exit_sched into
the new methods, ensuring memory operations are performed outside
locked sections.

Together, these changes simplify the elevator switch logic and prevent
the reported lockdep splat.

As always, feedback and suggestions are very welcome!

[1] https://lore.kernel.org/all/CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVyjO0=-D5+A@mail.gmail.com/

Thanks,
--Nilay

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

Nilay Shroff (4):
  block: unify elevator tags and type xarrays into struct elv_change_ctx
  block: move elevator tags into struct elevator_resources
  block: introduce alloc_sched_data and free_sched_data elevator methods
  block: define alloc_sched_data and free_sched_data methods for kyber

 block/blk-mq-sched.c  | 123 +++++++++++++++++++++++++++++++++---------
 block/blk-mq-sched.h  |  34 ++++++++++--
 block/blk-mq.c        |  50 +++++++++--------
 block/blk.h           |   7 ++-
 block/elevator.c      |  85 +++++++++++++++--------------
 block/elevator.h      |  26 ++++++++-
 block/kyber-iosched.c |  30 ++++++++---
 7 files changed, 249 insertions(+), 106 deletions(-)

-- 
2.51.0

