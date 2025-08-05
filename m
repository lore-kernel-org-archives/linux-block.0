Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37EB21639B
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 04:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754369911; cv=none; b=XyF8cdRO4cmDJHj+w2GfV9ZtgPwka3Gc5Hb7VLYlfLyviP//Q0k1oTqnNhzI4Mvwe6q0QQpHsz+1Yxwm3tEvq8hOSEJoArK99keiVJguhwCGQSsyxcfqIJoYY4kGqmxEVTrISceG12f0yj30pYEYq9RmrvktpgpAaYWyEyiF70o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754369911; c=relaxed/simple;
	bh=ZtvTKS/PR9UevfZJiuCRiIvULE+Dv14tTA+EyCmpDbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PeoPqrXivh59kxal03wozjQLd9tphHwVD4OrZRhh6q+mYgD718ljE1N0VIlOLRInSHqe3Ms6+N77wZVHqWrtucyKKEMetBmuMkqZKDE1wNHFqoolyDSNdxxlWEv/N95mmiEZXCXRGsNwG9FAJP6/LR+CueUY6kwYYWLb+c5tMFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=plpArW3H; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="plpArW3H"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57518KUs001179;
	Tue, 5 Aug 2025 04:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CB7Z/7
	rB2td5ACdgmRFER7SI8cjIr7ffi9mNmsB/xeI=; b=plpArW3H1eRCC6crajx2h/
	+QhN+LRsilRhwM4T0s+0+JYuMy9DiSrzEP5wKCNpKKbjrxCcR6nofzdem82Uaomp
	Y2FiR1t2xsPIiJPCSIzB9m2OGqH6gWOUhwMHsj719RCrluaATrCkTTLPnA9/CJTl
	Pwvv24s8FtN+dS76QfPmmcFeEjG5r3xEmfUQ12Z3SYmmoZi+cLGFDE6lVKoNkDMd
	QWB8e/4vhufEsDKLwb+JiHgblr4rFh3anVCkEbeVroFDt7qal4q0vgtSeJfFrOPC
	IytluH5echSv3RjXyGabUZTvRVQlDhcfcjwB+391q8FPm75KTWzHex/vck3ILZDQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ac0vfhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 04:58:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5754fBjq006873;
	Tue, 5 Aug 2025 04:58:20 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489xgmgusx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 04:58:20 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5754wKHS13173276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 04:58:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AE9F58058;
	Tue,  5 Aug 2025 04:58:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0CB55805B;
	Tue,  5 Aug 2025 04:58:16 +0000 (GMT)
Received: from [9.43.82.116] (unknown [9.43.82.116])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 04:58:16 +0000 (GMT)
Message-ID: <682f0f43-733a-4c04-91ed-5665815128bc@linux.ibm.com>
Date: Tue, 5 Aug 2025 10:28:14 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: blk-rq-qos: replace static key with atomic
 bitop
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, kch@nvidia.com,
        shinichiro.kawasaki@wdc.com, hch@lst.de, gjoyce@ibm.com
References: <20250804122125.3271397-1-nilay@linux.ibm.com>
 <aJC4tDUsk42Nb9Df@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aJC4tDUsk42Nb9Df@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fcmiU-FZ4UJutFnVBXayNggy9byREt_i
X-Proofpoint-ORIG-GUID: fcmiU-FZ4UJutFnVBXayNggy9byREt_i
X-Authority-Analysis: v=2.4 cv=GNoIEvNK c=1 sm=1 tr=0 ts=68918f6d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=bAq5ikK-74QHLDIQB1sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDAzMyBTYWx0ZWRfX8WiXc8Mu/X5G
 xDVPGWo0nsmpf2l3oUA9gLpPE9KYuFHTP87Cbn5t4/02iOEi0+VrXsdc4qrksaeCHa4WuuaRCMT
 DRMQ/PYMWjXQ7Szcw760eg0zXF9gMnm6fmbYmVAOIFR5kgIFBgs/Xv9tPsQveWNr3w1mGZwHjqf
 PDrQhXShx9NzeBlde9Y3c7TT1cLJ+Dpc2icQoILikyCWuI9iQnh7rGqzAvKAQ2R3x6ktcWESKxF
 NKeAZvGtPVcWlBfFuAVkfISaQNnYaXPtpSc2tXqbfQt7iGQTrcRqcL6TXeuGsaxCVkf8TXyWbMz
 xT6mgfGhOSh6JILCSb2s4Pm3Y29XcQrdVfLRiZKKj6XMMQNdUfbaJZDu53Kfb1numCNQWwg3zCg
 +k9WG/sbvU7DFu2cq+teBEWpMLKGSq+ZZV2kY4mlDv/94bfVFWjelkhQfXRK70sRo886Towh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050033



On 8/4/25 7:12 PM, Ming Lei wrote:
> On Mon, Aug 04, 2025 at 05:51:09PM +0530, Nilay Shroff wrote:
>> This patchset replaces the use of a static key in the I/O path (rq_qos_
>> xxx()) with an atomic queue flag (QUEUE_FLAG_QOS_ENABLED). This change
>> is made to eliminate a potential deadlock introduced by the use of static
>> keys in the blk-rq-qos infrastructure, as reported by lockdep during 
>> blktests block/005[1].
>>
>> The original static key approach was introduced to avoid unnecessary
>> dereferencing of q->rq_qos when no blk-rq-qos module (e.g., blk-wbt or
>> blk-iolatency) is configured. While efficient, enabling a static key at
>> runtime requires taking cpu_hotplug_lock and jump_label_mutex, which 
>> becomes problematic if the queue is already frozen — causing a reverse
>> dependency on ->freeze_lock. This results in a lockdep splat indicating
>> a potential deadlock.
>>
>> To resolve this, we now gate q->rq_qos access with a q->queue_flags
>> bitop (QUEUE_FLAG_QOS_ENABLED), avoiding the static key and the associated
>> locking altogether.
>>
>> I compared both static key and atomic bitop implementations using ftrace
>> function graph tracer over ~50 invocations of rq_qos_issue() while ensuring
>> blk-wbt/blk-iolatency were disabled (i.e., no QoS functionality). For
>> easy comparision, I made rq_qos_issue() noinline. The comparision was
>> made on PowerPC machine.
>>
>> Static Key (disabled : QoS is not configured):
>> 5d0: 00 00 00 60     nop    # patched in by static key framework (not taken)
>> 5d4: 20 00 80 4e     blr    # return (branch to link register)
>>
>> Only a nop and blr (branch to link register) are executed — very lightweight.
>>
>> atomic bitop (QoS is not configured):
>> 5d0: 20 00 23 e9     ld      r9,32(r3)     # load q->queue_flags
>> 5d4: 00 80 29 71     andi.   r9,r9,32768   # check QUEUE_FLAG_QOS_ENABLED (bit 15)
>> 5d8: 20 00 82 4d     beqlr                 # return if bit not set
>>
>> This performs an ld and and andi. before returning. Slightly more work, 
>> but q->queue_flags is typically hot in cache during I/O submission.
>>
>> With Static Key (disabled):
>> Duration (us): min=0.668 max=0.816 avg≈0.750
>>
>> With atomic bitop QUEUE_FLAG_QOS_ENABLED (bit not set):
>> Duration (us): min=0.684 max=0.834 avg≈0.759
>>
>> As expected, both versions are almost similar in cost. The added latency
>> from an extra ld and andi. is in the range of ~9ns.
>>
>> There're two patches in the series. The first patch replaces static key
>> with QUEUE_FLAG_QOS_ENABLED. The second patch ensures that we disable
>> the QUEUE_FLAG_QOS_ENABLED when the queue no longer has any associated
>> rq_qos policies.
>>
>> As usual, feedback and review comments are welcome!
>>
>> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> 
> 
> Another approach is to call memalloc_noio_save() in cpu hotplug code...
> 
Yes that would help fix this. However per the general usage of GFP_NOIO scope in 
kernel, it is used when we're performing memory allocations in a context where I/O
must not be initiated, because doing so could cause deadlocks or recursion. 

So we typically, use GFP_NOIO in a code path that is already doing I/O, such as:
- In block layer context: during request submission 
- Filesystem writeback, or swap-out.
- Memory reclaim or writeback triggered by memory pressure.

The cpu hotplug code may not be running in any of the above context. So
IMO, adding memalloc_noio_save() in the cpu hotplug code would not be 
a good idea, isn't it?

Thanks,
--Nilay

