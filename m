Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C511DE4E5
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754414293; cv=none; b=DSu4yO0RQDjWMx+VIeVqwbWpXOIEsc4BKTl0lda6PbjR8ByEtvBXBF3qRR3H3o6qLaRDH7oxittZP2QlIY8svA/Ks2BJ/eMnkBwkwy/RnvU/BDOQZMHOTYe66naHT2tyZWtoQka/HTdZtOSu3m7pSm4dloOLTjTIl9STUn1gFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754414293; c=relaxed/simple;
	bh=GuRPo4GdzC5nhigK05TL/xnfgGrVKnhez5AXqkAdQaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=srALT+xcsDkWC86Bsk64UhQglgCsIKWXkB7/1uJw+LevTABgi35MtPAiQqxGhqBmBYDsKnWHykTWIJQXU6orj4DOO+Ka3UcM4izZmSyLqjpUaxFp+WBbdDDG8LyInqD2UfTPY95j0usEyJDjT0dXAM7Gy2pKa4X5aF92TGJQpp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EPUdB3PT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EPUdB3PT"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575GPkQ7001100;
	Tue, 5 Aug 2025 17:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Cm4Ma2eiP4jZROqr+C9NW6fLkyT8
	6gAScRLXDelPaBE=; b=EPUdB3PTrInRzo5T0o5RDbKBpY7oWPiXu0rrQNRYIc7r
	OoOgV0x4Eg03wjMfw0R7FJmLY4+P246snIoovzeAaf8NexMbxt4fXLpI6+vGgSPC
	OrRdUUU1PYjSAPX8OEQawCijKGVnWlqtFYYq4UXl7Nqaj5jaRrogFn1UkF5VV8SS
	0k3Lr13WldaihFu7uETLgxAvz/upHWn6C3Swu9Q9SqyByTVeHGyyg4pd5wIsc3JT
	RZeZoF3n4zD2dslt8k91qQ1hj1yCqH1rqXDb4jQOViZ/DLIhxQAxqKOKngUD4RpT
	iGnK1USFd5jGKUdiyDl/AIdJ1FeIpWkoPg536fBgEg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ac0yvep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 17:17:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 575GTv3M009798;
	Tue, 5 Aug 2025 17:17:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 489w0tkkq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 17:17:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575HHr4u45416736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 17:17:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D397120043;
	Tue,  5 Aug 2025 17:17:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F333120040;
	Tue,  5 Aug 2025 17:17:50 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.35.190])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 17:17:50 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, yukuai1@huaweicloud.com, axboe@kernel.dk, hch@lst.de,
        kch@nvidia.com, shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
Subject: [PATCHv2 0/2] block: blk-rq-qos: replace static key with atomic bitop
Date: Tue,  5 Aug 2025 22:47:39 +0530
Message-ID: <20250805171749.3448694-1-nilay@linux.ibm.com>
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
X-Proofpoint-GUID: hMRTnQkERzPVyT8ZSrVyjpnVg1gX7FmL
X-Proofpoint-ORIG-GUID: hMRTnQkERzPVyT8ZSrVyjpnVg1gX7FmL
X-Authority-Analysis: v=2.4 cv=GNoIEvNK c=1 sm=1 tr=0 ts=68923cc4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=WcU6xNbzdLa3NCkNu6gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDExOCBTYWx0ZWRfX80SJR29fwez2
 61mqYumyLf3UwSoPGrmtp81LmGD2zavHJxH0WcYk56UgPcE9GiDpC4h03aYW+LQfmJAojVB0+u/
 1/01VBBF4Hw6U6MMjmDpaygED81iXOx6i9zNtuIAj1SP9g7Q8d+hVjU3CGS79MFbC+H3QgHhdYe
 SXh2J9nEwns+uLADDgyXPDcml+Piz758IsFXwg4YXVcbYoLzAGjkOwSHLyAX3iTfl29bOUBDvEz
 +A1eMywrrJM0aQ2i7X43kvZlDwGlH896eqZjDo3X0TKcd5VSVzTG+ncPBlgjJ3nKCD33ymUCu63
 paHowFaRnHc6XrNuvy0+PLtvY/pvMjbiMoy3g7U2g0g0DvSQnhnkN6Zu9UERiB4DVucY1+ooXBx
 VLM5tFVcjGqaFCyw/4XUXyhjO1tTSmrsQtB1dUrdmj6CGhv5m1EGTzr/1yXMBDobNpDCVaqI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=898 impostorscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050118

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

There're two patches in the series. The first patch replaces static key
with QUEUE_FLAG_QOS_ENABLED. The second patch ensures that we disable
the QUEUE_FLAG_QOS_ENABLED when the queue no longer has any associated
rq_qos policies.

As usual, feedback and review comments are welcome!

[1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/


Changes from v1:
  - For debugging I made rq_qos_issue() noinline in my local workspace,
    but then inadvertently it slipped through the patchset upstream. So
    reverted it and made rq_qos_issue() inline again as earlier.
  - Added Reported-by and Closes tags in the first patch, which I
    obviously missed to add in the first version.

Nilay Shroff (2):
  block: avoid cpu_hotplug_lock depedency on freeze_lock
  block: clear QUEUE_FLAG_QOS_ENABLED in rq_qos_del()

 block/blk-mq-debugfs.c |  1 +
 block/blk-rq-qos.c     |  8 ++++----
 block/blk-rq-qos.h     | 43 +++++++++++++++++++++++++-----------------
 include/linux/blkdev.h |  1 +
 4 files changed, 32 insertions(+), 21 deletions(-)

-- 
2.50.1

