Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23FE2571B3
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310101; cv=none; b=sKCieVwd8BPtqLAKd2Ii+bmrWa+t51QE2HwYsEWefuOdexTRoF56sBclqBwJN0vkbjAsuRlDviggN0hbgPqkyqE3XP/cmlSYQvd/W50/EJcPSCgN7jYd2SYRSnMZPTfYcC5cq6FHqD1PIOfj/ob53ekgJ1GoEjbyC4Q4LF5mcW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310101; c=relaxed/simple;
	bh=ZQBMm6leTkwtzrKWhKYvBb2lK7oRxiQKb9bXy2ijlkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KI05D1KVTnS6F9Qz9hjbRoQY2PZ75e4zndL5Eu412Snwb65iMxUS1C+8x6hfocENMbNgFQ5QabrpbPPNTLXyvG4zXqtm3AKRy+mDCUOC4LzDMmUR8vHCYhZWVxU0iDrwJbWO96B1Re6YQfPt7G9V9le74GQDPnaj5/8nKZdEmTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o1PjerVv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o1PjerVv"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5745V0A3005693;
	Mon, 4 Aug 2025 12:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=X/mHxUfJ+4XVj66WWYqv/oT6Y1M2
	gy9AwFR8ZfFeHjU=; b=o1PjerVv2qvokhc2x4pGSScmk1s6YLFNVQ1TGwsJhsuf
	A3E7uEjrHg5nAKpFsA8Oq5yaR9SV/XyBVEnUoLF2tPwieY5pEJYODq4IpRAZuYdT
	JMWrWb4Na0aumzeXNYm1lkc3uKPubtXnNQhIK0WIb6IUWgW+Mkegi2Y0Av0zeYMD
	GZmRorLCGtLDvJ+lqpZG9M192RcJ1IPAmpCZlxW+OQqnMJwgm+7XDQEVJHmGZK7D
	oYSl/LvCwD7PQJQjbaZv1euNIfIhJy8Sc4cEYKuouuDttvssKSK0OEtGbd5Za3BU
	hBzIa+Y7oHiT6nR0H3XBUIWCb9jlN47MB7CphrI8Lw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ab3gv4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 12:21:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 574B5CD6004558;
	Mon, 4 Aug 2025 12:21:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 489yq2dh92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 12:21:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 574CLReg53412328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 12:21:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 751D42004B;
	Mon,  4 Aug 2025 12:21:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1099020040;
	Mon,  4 Aug 2025 12:21:26 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.209])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Aug 2025 12:21:25 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, kch@nvidia.com, shinichiro.kawasaki@wdc.com, hch@lst.de,
        ming.lei@redhat.com, gjoyce@ibm.com
Subject: [PATCH 0/2] block: blk-rq-qos: replace static key with atomic bitop
Date: Mon,  4 Aug 2025 17:51:09 +0530
Message-ID: <20250804122125.3271397-1-nilay@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Z+jsHGRA c=1 sm=1 tr=0 ts=6890a5ca cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=vvz3QAfDn3xu6RP1wAUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DXxVMMAwZmLpWqmJaeQS9QX02etvx9eD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2OCBTYWx0ZWRfXzgEtpmDG2mCE
 NEG25Z3fMV45Bpp82e80mhEMkl+UeD2HCtfQkGGX+mzynrdSgdmsf8UKPFW83aZ9uuTTma/WLIF
 u2X/hkS/aDT+6AaAyRcNo+k4Yz07kQ5h8kri/wYXJAicNtAFXhniShtTzPLeS5eAKEqd70RRrSA
 U48qHLH0kzFlYjXemMxc+0mXlAA7bwuSQVdc/zcEWIWh7yGRyqdTciJTj1Ogd+5/rJuE5d09/B0
 MICiDNuBaEQbDvtgP6sV0JyP4U8JTeq50neApzL87h51npAlYVBP/GmLm1wGskwWBYQsLCu3nxW
 oVPRiDAY4yV3ibuZEwtH+HHUghlWrh/8n5p1DZgIZ+ULPCn5fHgk1cUu67iTXdEZ+gcdWTVaNHy
 t4YjbJIXD22yRT5LK6WULHuPS1Ugqx8wb6lWDIGzb5WYLIoQORZg+3JpDBN3YcCTpgQXEcyz
X-Proofpoint-GUID: DXxVMMAwZmLpWqmJaeQS9QX02etvx9eD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 mlxlogscore=908 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040068

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

Static Key (disabled : QoS is not configured):
5d0: 00 00 00 60     nop    # patched in by static key framework (not taken)
5d4: 20 00 80 4e     blr    # return (branch to link register)

Only a nop and blr (branch to link register) are executed — very lightweight.

atomic bitop (QoS is not configured):
5d0: 20 00 23 e9     ld      r9,32(r3)     # load q->queue_flags
5d4: 00 80 29 71     andi.   r9,r9,32768   # check QUEUE_FLAG_QOS_ENABLED (bit 15)
5d8: 20 00 82 4d     beqlr                 # return if bit not set

This performs an ld and and andi. before returning. Slightly more work, 
but q->queue_flags is typically hot in cache during I/O submission.

With Static Key (disabled):
Duration (us): min=0.668 max=0.816 avg≈0.750

With atomic bitop QUEUE_FLAG_QOS_ENABLED (bit not set):
Duration (us): min=0.684 max=0.834 avg≈0.759

As expected, both versions are almost similar in cost. The added latency
from an extra ld and andi. is in the range of ~9ns.

There're two patches in the series. The first patch replaces static key
with QUEUE_FLAG_QOS_ENABLED. The second patch ensures that we disable
the QUEUE_FLAG_QOS_ENABLED when the queue no longer has any associated
rq_qos policies.

As usual, feedback and review comments are welcome!

[1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/

Nilay Shroff (2):
  block: avoid cpu_hotplug_lock depedency on freeze_lock
  block: clear QUEUE_FLAG_QOS_ENABLED in rq_qos_del()

 block/blk-mq-debugfs.c |  1 +
 block/blk-rq-qos.c     |  8 ++++----
 block/blk-rq-qos.h     | 45 +++++++++++++++++++++++++-----------------
 include/linux/blkdev.h |  1 +
 4 files changed, 33 insertions(+), 22 deletions(-)

-- 
2.50.1

