Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33E26F2B2
	for <linux-block@vger.kernel.org>; Thu, 21 Aug 2025 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778787; cv=none; b=NsLuWbqBv9GI9rWmR1YXoEwRWCJHPD7rdN/xEhQsLlEG765fvMoWKNPzKlroxE6SVoy3jwgDS88UGTSYyyQ/E7/LxyMWMGcEHaflulH/vypxM0Yn7W5wer5cxdo0QDMJy+Z/9kYpA254eeqS/7yRaGq0KRHM13QDxFrxz08vwvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778787; c=relaxed/simple;
	bh=jn/OMOHyJQdmvUJWvF6/HVjX8FhF67a/OjsQokAbHt0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rsz/e6IgY51o/QyfoAiUUU8mwUbnhBj63bvCdbQ7E2Y3Kk8j/MzpDHu38y7J1mujCy9BkEJcx8BPTmHxu4KUD3+PGSD6vL+sZTRDeP6lWbaLAZ1zNK87lg3W5YOrg7pj/FExG5FLuFvH/haTkDA3ERwGfFSu7LAQ5FzcgB0m2+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sgweSxR7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sgweSxR7"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L87U1w012755;
	Thu, 21 Aug 2025 12:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LijD2I
	x75LEol3dHs0AdSg9n/5xiFEJSxnD42MlfSAs=; b=sgweSxR7I1jLxX25JTop0j
	iRmRIAw3ulRDK0KOzhhLCVMVeusBvX/sATcYehf1J3WzATQFONMWO4z/8D6PQUR7
	sAnAIdpJERVe5/vlGPw91IBxfJanYqveNzJuTqWkhR47mZmL49b1ZR/8JtvewPd5
	5InN0p4tt7k053xGEc+sn4TbKbG3IhcamZFNgZF0X8c350n9pw6l5AU0vO3EnYPy
	Y1sWqOOzAuYJxZzAilNvgm8vEcd5tuCCr6pIh0gNpJHrzJM1xP0vO3WYncwL5ehV
	+7m+tngPRtPW1t1y9ZZXy4U6wHQljBaOkgoTGgf6mGAExYewdUd41mUevNTJUnJQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vrd2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 12:19:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57LB10Yw024204;
	Thu, 21 Aug 2025 12:19:26 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my43r6s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 12:19:26 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LCJPMw25362970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 12:19:26 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A77FF58045;
	Thu, 21 Aug 2025 12:19:25 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE91458050;
	Thu, 21 Aug 2025 12:19:22 +0000 (GMT)
Received: from [9.109.198.214] (unknown [9.109.198.214])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Aug 2025 12:19:22 +0000 (GMT)
Message-ID: <1c23ef53-b96b-4891-a1af-af32328139e8@linux.ibm.com>
Date: Thu, 21 Aug 2025 17:49:21 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/3] block: blk-rq-qos: replace static key with atomic
 bitop
From: Nilay Shroff <nilay@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: ming.lei@redhat.com, yukuai1@huaweicloud.com, hch@lst.de,
        shinichiro.kawasaki@wdc.com, kch@nvidia.com, gjoyce@ibm.com,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250814082612.500845-1-nilay@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250814082612.500845-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX0yOoBW0OWJaj
 /8dChz2sQz9dgarAHd92oFic4ulVoNi3xmQZG7jZbT/DzQbTOXkCGoIAOzIXSeW28hDTqYceNNs
 VtqYV+Rij5ynNlQspzBJ4dWZRIPAb6d5lwZZH8B7OTudlC+iIHOjQXJuqJBJbXhNMpaRnizmof8
 wU4rKwgVjXgpybrVkasu3vVI+8V8fsJwd3Cz+Ui+zpOicpBsVVGBLTXkmWRjuwpY74HRpfyTfae
 K2BUN0WZ240ml/zNuBZ7cxuGWSStlI20ZpwDi9tajJDF3iQrqPnMEbgMZc0/jlwaljrQoXQUWw4
 oDYy6Esm35De4lsnmo4kk2Egu90SOkwiP/yU80qeKwClx6mgeFeokSRMEa85VlxJAae6fqEXx4a
 9364VsN2nL2VcD5b6WUWhoC9oDD2ow==
X-Proofpoint-ORIG-GUID: lznDnT-Y691-3P-vEE9Fd6VE5ORXj2lc
X-Authority-Analysis: v=2.4 cv=T9nVj/KQ c=1 sm=1 tr=0 ts=68a70ecf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=G0k_kDK5FgH4ecXK0ogA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: lznDnT-Y691-3P-vEE9Fd6VE5ORXj2lc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

Hi Jens,

Just a gentle ping on this patchset. There have been a couple of recent
reports[1][2] highlighting this issue. Could you please consider pulling it?

[1] https://lore.kernel.org/all/4f2bd603-dbd9-434c-9dfe-f2d4f1becd82@linux.ibm.com/
[2] https://lore.kernel.org/all/36e552a1-8e8e-4b6f-894b-e7e04e17196e@linux.ibm.com/

Thanks,
--Nilay

On 8/14/25 1:54 PM, Nilay Shroff wrote:
> Hi,
> 
> This patchset replaces the use of a static key in the I/O path (rq_qos_
> xxx()) with an atomic queue flag (QUEUE_FLAG_QOS_ENABLED). This change
> is made to eliminate a potential deadlock introduced by the use of static
> keys in the blk-rq-qos infrastructure, as reported by lockdep during
> blktests block/005[1].
> 
> The original static key approach was introduced to avoid unnecessary
> dereferencing of q->rq_qos when no blk-rq-qos module (e.g., blk-wbt or
> blk-iolatency) is configured. While efficient, enabling a static key at
> runtime requires taking cpu_hotplug_lock and jump_label_mutex, which
> becomes problematic if the queue is already frozen — causing a reverse
> dependency on ->freeze_lock. This results in a lockdep splat indicating
> a potential deadlock.
> 
> To resolve this, we now gate q->rq_qos access with a q->queue_flags
> bitop (QUEUE_FLAG_QOS_ENABLED), avoiding the static key and the associated
> locking altogether.
> 
> I compared both static key and atomic bitop implementations using ftrace
> function graph tracer over ~50 invocations of rq_qos_issue() while ensuring
> blk-wbt/blk-iolatency were disabled (i.e., no QoS functionality). For
> easy comparision, I made rq_qos_issue() noinline. The comparision was
> made on PowerPC machine.
> 
> Static Key disabled (QoS is not configured):
> 5d0: 00 00 00 60     nop    # patched in by static key framework
> 5d4: 20 00 80 4e     blr    # return (branch to link register)
> 
> Only a nop and blr (branch to link register) are executed — very lightweight.
> 
> atomic bitop (QoS is not configured):
> 5d0: 20 00 23 e9     ld      r9,32(r3)     # load q->queue_flags
> 5d4: 00 80 29 71     andi.   r9,r9,32768   # check QUEUE_FLAG_QOS_ENABLED (bit 15)
> 5d8: 20 00 82 4d     beqlr                 # return if bit not set
> 
> This performs an ld and andi. before returning. Slightly more work,
> but q->queue_flags is typically hot in cache during I/O submission.
> 
> With Static Key (disabled):
> Duration (us): min=0.668 max=0.816 avg≈0.750
> 
> With atomic bitop QUEUE_FLAG_QOS_ENABLED (bit not set):
> Duration (us): min=0.684 max=0.834 avg≈0.759
> 
> As expected, both versions are almost similar in cost. The added latency
> from an extra ld and andi. is in the range of ~9ns.
> 
> There're three patches in the series:
> - First patch is a minor optimization which skips evaluating q->rq_qos
>   check in the re_qos_done_bio() as it's not needed.
> - Second patch fixes a subtle issue in rq_qos_del() to ensure that
>   we decrement the block_rq_qos static key in rq_qos_del() when a 
>   QoS policy is detached from the queue.
> - Third patch replaces usage of block_rq_qos static key with atomic flag
>   QUEUE_FLAG_QOS_ENABLED and thus helps break cpu_hotplug_lock depedency
>   on freeze_lock and that eventually help to fix the lockdep splat.
> 
> As usual, feedback and review comments are welcome!
> 
> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> 
> Changes from v2:
>   - Added a change to skip the q->rq_qos check in rq_qos_done_bio().
>     This is now part of the first patch in this series. (Yu Kuai)
>   - Added a separate patch to ensure block_rq_qos is decremented when
>     detaching a QoS policy in rq_qos_del(). This is now the second 
>     patch in this series. (Yu Kuai)
>   - Folded the third patch from v2 into the new third patch, as patch
>     ordering changed (the second patch from v2 is now the third patch
>     in v3).
> 
> Link to v2: https://lore.kernel.org/all/20250805171749.3448694-1-nilay@linux.ibm.com/
> 
> Changes from v1:
>   - For debugging I made rq_qos_issue() noinline in my local workspace,
>     but then inadvertently it slipped through the patchset upstream. So
>     reverted it and made rq_qos_issue() inline again as earlier.
>   - Added Reported-by and Closes tags in the first patch, which I
>     obviously missed to add in the first version.
> 
> Link to v1: https://lore.kernel.org/all/20250804122125.3271397-1-nilay@linux.ibm.com/
> 
> Nilay Shroff (3):
>   block: skip q->rq_qos check in rq_qos_done_bio()
>   block: decrement block_rq_qos static key in rq_qos_del()
>   block: avoid cpu_hotplug_lock depedency on freeze_lock
> 
>  block/blk-mq-debugfs.c |  1 +
>  block/blk-rq-qos.c     |  8 +++----
>  block/blk-rq-qos.h     | 48 +++++++++++++++++++++++++++---------------
>  include/linux/blkdev.h |  1 +
>  4 files changed, 37 insertions(+), 21 deletions(-)
> 

