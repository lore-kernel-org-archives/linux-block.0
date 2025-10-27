Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1815C2E1F08
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586620; cv=none; b=WchX6QcCRXqBmnTRN5VtFO4f+PbdqvJl81BnFQdHixTFdnKVxwXtMiTxduZ12KB6QYI6NuEs0XwhfL1Iyg9MrSS586rAJKjkzbYUwDc/J5WhT2kbReGUaswgga6TKFtdPhc8df2wxbXXOoFI/02aNuifKhHoavQ7aPmHIE0NP7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586620; c=relaxed/simple;
	bh=1Q7N60CTiOubRmF6Krr1m8NDfQyultk6hUANYrtVduc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DmGrTssFcSluQ9GDaLfGtOrW1xfdeWM01VSD/KsRX/PtDyEBNXSiejeY0A6HdLsvYN4ReJx1x9EbzDxhcguLIyRCD7f648Ihlu0Tay5Ey8glzOGjbfA4WM9Jpkmk43+c6ZlfHL2PgO3/qpoQcPJtPEzU5CZC3cLSlDCqBceCj4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nuV7PZgd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nuV7PZgd"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RDpIwV019017;
	Mon, 27 Oct 2025 17:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=INkd+nWqqXd9kN10uA3PAgu28q1z
	GRfd/jRZLei/pIk=; b=nuV7PZgdnjWlM6An5855+S3X5o6tRm3pDPaZ1rwD0RpU
	9gb75dXjJrFMs5JqGYg2M7xDoiyFxOkBdCgo/3dc0hZV5aul+4PcG9AQQFTZt7H3
	xRqtT1nBHQXMEds8ZXpVO6iUCC0J2EwkGD+6eqCNPnw4Mcj5bO+/V/ReXWqKQiky
	Wkh3jOiaN+89ZX91vys1PZIP3Nugb0YhYYcl74b+nPELz8Sie5sN9y1xjLFvF82U
	ncxFheMq6QpV5youelC2APQQLXjVuV0uPp3zhh4dgmCbLKVjAE5wazPujO95YzIg
	z435fbserMRmPU4KBVMv7PV9okNPzLKjzjKVSUab0Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p71yyb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 17:36:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59RF2HTg030179;
	Mon, 27 Oct 2025 17:36:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a19vmet3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 17:36:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59RHad3S25625190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 17:36:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19FEE2004B;
	Mon, 27 Oct 2025 17:36:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6A5B20043;
	Mon, 27 Oct 2025 17:36:34 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.186.32])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 17:36:34 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, yukuai1@huaweicloud.com, axboe@kernel.dk,
        yi.zhang@redhat.com, czhong@redhat.com, gjoyce@ibm.com
Subject: [PATCHv2 0/4] block: restructure elevator switch path and fix a lockdep splat
Date: Mon, 27 Oct 2025 23:05:55 +0530
Message-ID: <20251027173631.1081005-1-nilay@linux.ibm.com>
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
X-Proofpoint-GUID: RrIS2USo4SIrwDYEuNCwyLh28sLkLu5R
X-Proofpoint-ORIG-GUID: RrIS2USo4SIrwDYEuNCwyLh28sLkLu5R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfXxOWGh/jEYwoW
 Lax72O/Ngoc/dZkT8c6vLtFTh/ouLOrSWBK14hbQM1RXUN/YBgLrWxVn2O36a1PssPlqoVTk/Mt
 rXTL0KESZmVQAJOyR/4CVWmM/A8qJEgWkAxxt5TEuUkLnU9q0ImyOeo9f+W4NAWK2LYFJFhjs2d
 GZd/h6MYqeOFOK5gpFDonbZMr7qWMaVzKe4nOVSIGJqacwnEGXr/XQYqz5laK9jXpkS2t23LZX6
 w+d3GYo2Pc1ONh4vXe65zd/dXUm4epqE8DAVjTpdlXZ0uJtL/bPWEVpzWSw46/58oHWAzIYIOyr
 zZX0kr1sVBFTHNXo/w8tJyLI3cNgqYlD91gWVNdLhfZhzp+lJ6d1+6RhYKBVaX6FtVQ8fXLJRQk
 6f/lACbZJm5UzTCwqPRuIKSBY+0xig==
X-Authority-Analysis: v=2.4 cv=G/gR0tk5 c=1 sm=1 tr=0 ts=68ffada9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=yNWxtuLgjR4ficX-EogA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024

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

 block/blk-mq-sched.c  | 122 ++++++++++++++++++++++++++++++++++++++----
 block/blk-mq-sched.h  |  26 ++++++++-
 block/blk-mq.c        |  55 +++++++++++--------
 block/blk.h           |   7 ++-
 block/elevator.c      |  81 +++++++++++++++-------------
 block/elevator.h      |  28 +++++++++-
 block/kyber-iosched.c |  30 ++++++++---
 7 files changed, 269 insertions(+), 80 deletions(-)

-- 
2.51.0

