Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F07134A8
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159995; cv=none; b=XeH7k3vkb4/kyb2PBTfhzpJhmMc2GMxRsmekN4TPP2w6K6ARmNJKqRcid2EHCKwtPEPrpjPEf0gyRgXks4/vEYOeydog0GMveSeshRkLbyviYquYYqbC6qsF4+7Ara0xaZ7/qOSTu6hXPPiQA1CAX9dBqEv8O4c+7zELU/DWoKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159995; c=relaxed/simple;
	bh=/W4BJipi8fP04j5e9wGFQm+oZyM0IJ0PKOvF2AVX2/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mAzGaSDH8US4ohWwU9mlNmeDP8zpKLgV3E0bmPj+1tlHUmcV2328aIEkSMccO2QPw/jQcwul1s77SbwS9dpz+TlATfx9zbtvkk0L4QqXuzV7vnml/l/oBnVopHvEmQg8P8gigJxG4t7KFXRfxWF78zyV+f/UABUxSgw92D9eWb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T84B/aCa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T84B/aCa"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E78r6x016395;
	Thu, 14 Aug 2025 08:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=qQQPo578uKbv+Axrb4hRa9+tVQ3s
	pDYiojQcgUdFVaU=; b=T84B/aCas6iDsv4WZa89xvgOXCulniR53FQVhyYkLrcj
	M8lu4QMq/nEfSPaJIwF10L4R+0lfysjwU7TtFFH7tpFsJ/+bgwbxTtdTH3vk3du3
	tUEDCrRsLeVU9NlMxm59D79Yw5adgshSyfx1kGuGGjf/BN0XP2dIA0DwboPVeI7o
	FBb9G72vHg2wXn9cVbfJCPsqIm/9+on/wA8vA/O+LoO5UrB/slwgKcX37HdSHuzi
	vvDDXSNHaLD+MbzfIxtu5KlHW79S9Zs5lrzpdQh0r8FSVbxhtPG7+AyCEhznJdiB
	HAmo/+jevMNKWWeH05MSEGOcOOXGhkuOK46CRbmJpA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48gypeayk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:26:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57E5jCxj028571;
	Thu, 14 Aug 2025 08:26:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5nb7xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:26:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57E8QF3q51380668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 08:26:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A54320040;
	Thu, 14 Aug 2025 08:26:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2F4920049;
	Thu, 14 Aug 2025 08:26:13 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.214])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Aug 2025 08:26:13 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, ming.lei@redhat.com, yukuai1@huaweicloud.com, hch@lst.de,
        shinichiro.kawasaki@wdc.com, kch@nvidia.com, gjoyce@ibm.com
Subject: [PATCHv3 0/3] block: blk-rq-qos: replace static key with atomic bitop
Date: Thu, 14 Aug 2025 13:54:56 +0530
Message-ID: <20250814082612.500845-1-nilay@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=eaU9f6EH c=1 sm=1 tr=0 ts=689d9daa cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hv0hV1e24HwJ_90aazIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1pi6F1w6dDBMzCSc5gnhUnp4sdjLX8tr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE2NyBTYWx0ZWRfX//zMOOju390L
 tRjV5trTjw0/Zq6XmMdkaIid54B4VGuWQ7pt0pUsLAW4FMy8SkeYKrXI8/Q9zgVJXm1bU5qXpok
 EsSe6uGQQA9RamLK3sq7bkNQrMPG0xhbm8TIIzmnfSEfzFyg54Ydu0K2GaXhzL5GA20FWxzgzHf
 j8hcyNoJnBQ481f1m3K+eWeJCLhg6DUrzFWauuB7jQInenERs/mmTOiNni3yqXK+AvVlgpL4QUh
 UcM/MJNEIzm79rwZDfnq9fhFy9lq+K6WPvdUfuHzmiP878S+1ImngZcfhZIXgqVO51uAwWh6A9g
 UOnL5Ik/90bpBuXc8+ab/dQL3X7e/CYL2AneBCASbePCzaThXcAc+h0t7WBrDFZtoa2kVxtMbHf
 E1+E3w2t
X-Proofpoint-ORIG-GUID: 1pi6F1w6dDBMzCSc5gnhUnp4sdjLX8tr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508130167

Hi,

This patchset replaces the use of a static key in the I/O path (rq_qos_
xxx()) with an atomic queue flag (QUEUE_FLAG_QOS_ENABLED). This change
is made to eliminate a potential deadlock introduced by the use of static
keys in the blk-rq-qos infrastructure, as reported by lockdep during
blktests block/005[1].

The original static key approach was introduced to avoid unnecessary
dereferencing of q->rq_qos when no blk-rq-qos module (e.g., blk-wbt or
blk-iolatency) is configured. While efficient, enabling a static key at
runtime requires taking cpu_hotplug_lock and jump_label_mutex, which
becomes problematic if the queue is already frozen — causing a reverse
dependency on ->freeze_lock. This results in a lockdep splat indicating
a potential deadlock.

To resolve this, we now gate q->rq_qos access with a q->queue_flags
bitop (QUEUE_FLAG_QOS_ENABLED), avoiding the static key and the associated
locking altogether.

I compared both static key and atomic bitop implementations using ftrace
function graph tracer over ~50 invocations of rq_qos_issue() while ensuring
blk-wbt/blk-iolatency were disabled (i.e., no QoS functionality). For
easy comparision, I made rq_qos_issue() noinline. The comparision was
made on PowerPC machine.

Static Key disabled (QoS is not configured):
5d0: 00 00 00 60     nop    # patched in by static key framework
5d4: 20 00 80 4e     blr    # return (branch to link register)

Only a nop and blr (branch to link register) are executed — very lightweight.

atomic bitop (QoS is not configured):
5d0: 20 00 23 e9     ld      r9,32(r3)     # load q->queue_flags
5d4: 00 80 29 71     andi.   r9,r9,32768   # check QUEUE_FLAG_QOS_ENABLED (bit 15)
5d8: 20 00 82 4d     beqlr                 # return if bit not set

This performs an ld and andi. before returning. Slightly more work,
but q->queue_flags is typically hot in cache during I/O submission.

With Static Key (disabled):
Duration (us): min=0.668 max=0.816 avg≈0.750

With atomic bitop QUEUE_FLAG_QOS_ENABLED (bit not set):
Duration (us): min=0.684 max=0.834 avg≈0.759

As expected, both versions are almost similar in cost. The added latency
from an extra ld and andi. is in the range of ~9ns.

There're three patches in the series:
- First patch is a minor optimization which skips evaluating q->rq_qos
  check in the re_qos_done_bio() as it's not needed.
- Second patch fixes a subtle issue in rq_qos_del() to ensure that
  we decrement the block_rq_qos static key in rq_qos_del() when a 
  QoS policy is detached from the queue.
- Third patch replaces usage of block_rq_qos static key with atomic flag
  QUEUE_FLAG_QOS_ENABLED and thus helps break cpu_hotplug_lock depedency
  on freeze_lock and that eventually help to fix the lockdep splat.

As usual, feedback and review comments are welcome!

[1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/

Changes from v2:
  - Added a change to skip the q->rq_qos check in rq_qos_done_bio().
    This is now part of the first patch in this series. (Yu Kuai)
  - Added a separate patch to ensure block_rq_qos is decremented when
    detaching a QoS policy in rq_qos_del(). This is now the second 
    patch in this series. (Yu Kuai)
  - Folded the third patch from v2 into the new third patch, as patch
    ordering changed (the second patch from v2 is now the third patch
    in v3).

Link to v2: https://lore.kernel.org/all/20250805171749.3448694-1-nilay@linux.ibm.com/

Changes from v1:
  - For debugging I made rq_qos_issue() noinline in my local workspace,
    but then inadvertently it slipped through the patchset upstream. So
    reverted it and made rq_qos_issue() inline again as earlier.
  - Added Reported-by and Closes tags in the first patch, which I
    obviously missed to add in the first version.

Link to v1: https://lore.kernel.org/all/20250804122125.3271397-1-nilay@linux.ibm.com/

Nilay Shroff (3):
  block: skip q->rq_qos check in rq_qos_done_bio()
  block: decrement block_rq_qos static key in rq_qos_del()
  block: avoid cpu_hotplug_lock depedency on freeze_lock

 block/blk-mq-debugfs.c |  1 +
 block/blk-rq-qos.c     |  8 +++----
 block/blk-rq-qos.h     | 48 +++++++++++++++++++++++++++---------------
 include/linux/blkdev.h |  1 +
 4 files changed, 37 insertions(+), 21 deletions(-)

-- 
2.50.1

