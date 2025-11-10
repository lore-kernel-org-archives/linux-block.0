Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5612557A
	for <linux-block@vger.kernel.org>; Mon, 10 Nov 2025 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762523; cv=none; b=tFPGysLEtYuyn5fJSLhvSQa8ngrRHMMrolmjAxxb8SqFAdv1Ugq8THesqjD6GNEa7ps7ixRhOccytc56uN264jTVMW20ITP3FYlBULVWOtIqMKVc5O31093lZjahj9pu0oeKj9q0bCK2gfGVTwS2RpwxAKEDxm/x2nBrIFYA8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762523; c=relaxed/simple;
	bh=WRyNDsvMptYoVKor9lwd98rNrVbNTjUC4LKFFkE0yoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nOkeVIR1EmFNaP4iR5wa5aoh273P+P1ES86lFzuU9/hqF0GXLVVL3vQEIjjM9eL8BWz6sAN6D5TWTywOqjQkbbw2ic40vZTsXHyM7kadB+3Nupl3mN49Fma4+GewhNbZIVAjtWmSzBVQogoyewzWxF35ILuPO70AI+I7R+XZ9ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G37CvUKQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G37CvUKQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9AI4Ov000443;
	Mon, 10 Nov 2025 08:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Jn4AAJb4J1zpQflKTMdZ/RpWbAB3
	SFwJPEyJPxxRBds=; b=G37CvUKQSa2QGOsfXg0VDmcK0kVYY3Ua7f13NVX0FZwY
	YP3HA7yNAwAtJmGswJDKXNG//ObJ+25J8S291v8bQixViPe+lbH0ueBqYhsiW/EY
	C5LvBFhQa++iXkhlNynVpGzjAHD9RNC1nD9gzlliZIiQZFVUmuv+R65k8Sb/OkHx
	jue6hpe1CrvHjdb1pKpfVVjiso/Y8OerqGJV8KIrJbwfk5JJnmGHikIL2uZ/xcrD
	HOabP7SR/UMCvSLhExdGRJQ8ao5YKU2UDR5sB8pVnz4P31Z3fmM0stmXnN6uBgyD
	PEnSfKSpMiJeEDABsTyKy7tSyeJXZ1pe9cIzsTmfwQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m7we04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 08:15:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA4pcbt011441;
	Mon, 10 Nov 2025 08:15:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw14a3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 08:15:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AA8F4qo53936616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 08:15:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADF242004B;
	Mon, 10 Nov 2025 08:15:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B861920040;
	Mon, 10 Nov 2025 08:15:00 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.93.35])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 08:15:00 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, yukuai@fnnas.com, gjoyce@ibm.com
Subject: [PATCHv4 0/5] block: restructure elevator switch path and fix a lockdep splat
Date: Mon, 10 Nov 2025 13:44:47 +0530
Message-ID: <20251110081457.1006206-1-nilay@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=69119f0b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=NKmVwkrdNWel0eFzVGEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: ee-J7aJjhDnLKFfPOJKGl8n8IFhG1CCi
X-Proofpoint-ORIG-GUID: ee-J7aJjhDnLKFfPOJKGl8n8IFhG1CCi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfXyP/SVikKYTuM
 SqDgWJL0GuAFanQJCr6UDYYaLNaPIvlaKxE16gwkIulquWNTUBrRLcW+GlGTMIFfNZU8WBHsTTO
 K31ZahWw9DpwkzyH+IJUq1WxxHkalLSBQPVfHJlJiQdOxhr1L85ZIXyroj2N1rtOuRFWxIBWA6E
 W15GiM3IQ4U3C2my7ZKLbWuXMAdURfoEMtsOKOXzyDNC7qWVCH0xM8x+su389SwzAKEzr6FIEWA
 XmuS1ltU3bJBFB1Px9hI2avOFeHwS/LFz6F7wwWDZL1jLvOmtiPPW6LxLckrtvRNSPqG7O8XvHt
 y5FdnCPjy9HNnsFiTMM9KYqyItnkA9qjS4ZmdSCOBliWhpo1HUQfBoq+U+vhZZIRdxt+h4fx0dK
 BWvDBAQUR6wXGnr7U1UgszVuydx6eQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079

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

 block/blk-mq-sched.c  | 123 +++++++++++++++++++++++++++++++++---------
 block/blk-mq-sched.h  |  34 ++++++++++--
 block/blk-mq.c        |  50 +++++++++--------
 block/blk.h           |   7 ++-
 block/elevator.c      |  80 +++++++++++++--------------
 block/elevator.h      |  26 ++++++++-
 block/kyber-iosched.c |  30 ++++++++---
 7 files changed, 244 insertions(+), 106 deletions(-)

-- 
2.51.0

