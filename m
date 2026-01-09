Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392FA3321C2
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949785; cv=none; b=Xhzn4D8BLXLFyoemSlCA0sjcF6GTH93zX3i+G81h/o1xIoutYHJGHpO0zhN5ekZFcJKPzArN75mR21SUuTh85TNCeyDZBO1RdFbVZBMc6Ifqiq+1RBoL+sZhiqwMCetopTzEuK0/nRmG50jI8zT8icyoArvRu2naCSA+uv+2XuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949785; c=relaxed/simple;
	bh=XaeEQFc6al9X5QNRp4+nVnB3Hl03bJ8oXAtmiIn1T70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2KnVEqL8BlteFHvtLYfu+Ssq+MA5sfE3DaQYDXZ0gpCG2JWl4H9Y8JrVOfQ6b+Ugtvqv0TM0pl0AjAkyvuVbUSvQPpgSdAEC/f3r3uCOKTDvvw+/ERmcg7v/YvFWchXKk1PjejvMBwKVeIhNN+4o6CO2RdZqyElRn87fX+Kt2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sUc8SPeA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sUc8SPeA"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 608NLEf4012338;
	Fri, 9 Jan 2026 09:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6jGdI1
	uzfofTlX2+4F3Dx9Ak++DVJFdrG+bw8P7cMsg=; b=sUc8SPeAaCYuEKRt6U2T7o
	NjchHzID36YZYY4BPxm1WYqEDrdEqDyW49g56D0irIDEkUt6Mute5kZhPINjslFA
	HzDVJwtr1itidEDne35UqQLjHzSmzxjupCMfTCqs5JvlbeFXTCTVQW8ga4CoqDkQ
	v9pQ9tZa/3RJErja8PMwT9Sycw2hNU61Ra+o+ighZFiprSe6LnBz1xafc1RVpiAD
	1e7UgidMNpdKtNs8MbaSKx4WM4tkpkQ2f6D5HfmgUb/CB5xS/YMrtnbCfLgACZ4T
	3AMag4Oui5RXCgSHDtLD2/QjLVop2PYtREXVngezB8yMkW6sm7Tuh3rdrpz5b7yg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betsqjju7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 09:09:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 609680RN005206;
	Fri, 9 Jan 2026 09:09:29 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfexkkw0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 09:09:29 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60999Spm34013832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Jan 2026 09:09:28 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63C3C5805E;
	Fri,  9 Jan 2026 09:09:28 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8CF258056;
	Fri,  9 Jan 2026 09:09:25 +0000 (GMT)
Received: from [9.111.28.68] (unknown [9.111.28.68])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Jan 2026 09:09:25 +0000 (GMT)
Message-ID: <924c838e-130b-42a4-8dcd-8c5f5675de53@linux.ibm.com>
Date: Fri, 9 Jan 2026 14:39:23 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/16] blk-throttle: fix possible deadlock for fs
 reclaim under rq_qos_mutex
To: yukuai@fnnas.com, Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-10-yukuai@fnnas.com> <aV5L25KZkM4dvzLD@fedora>
 <e2054693-7100-4bdc-95eb-9e70d9d3231e@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <e2054693-7100-4bdc-95eb-9e70d9d3231e@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jh7fsh4FQOqbXd9ESU3Kz8vVCxLAdwLc
X-Authority-Analysis: v=2.4 cv=Jvf8bc4C c=1 sm=1 tr=0 ts=6960c5ca cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=fxnl6WdKYTAMltaicvQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-ORIG-GUID: Jh7fsh4FQOqbXd9ESU3Kz8vVCxLAdwLc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2MiBTYWx0ZWRfX61Ix0RAjoBmX
 NglQFi2uznZ8mYg/Ryph1JZ0G/vVSYKkMgUZZfDK8Ori5NO0PTRU9iSNsMAnD+1RFyU1Pe6mknQ
 9HE4uRLuB28TP8Mb2bBS6np/W8jA5Hpo0bivzVYHEdBIlC4vOkjPu96iU4N8b+kbz3L61QSHzqK
 VyvFTnugyWo4Uijc3pwgXXDGzzVWmd2CyZbKsqoI7QwIMvs+6Jsr650ooDJlCCvsDOFFXPvbzxF
 hCBLU6/4uEymi5lgLKawLWd92Zlb12wMpEQZwDHetgQL5qB+9/S5Ed3O7Fe0T3pvCZp9T6P5m/V
 6hr3gpJDhGpug/eoQhd2JbVldHKlPfXdBt7PuCC+pyZEY13/bRysXOW0sCEW/sAvQNeflghdenl
 d+GRbjpISZ4xa5OFFk2wPXeiXIwl87loJDVsttnSqkkLjtftelJbZ3HTNikHzgJf4dRo7UMhOYZ
 61aWJbmr54kORuSnu3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601090062



On 1/8/26 10:26 PM, Yu Kuai wrote:
> Hi,
> 
> 在 2026/1/7 20:04, Ming Lei 写道:
>> On Wed, Dec 31, 2025 at 04:51:19PM +0800, Yu Kuai wrote:
>>> blk_throtl_init() can be called with rq_qos_mutex held from blkcg
>>> configuration, and fs reclaim can be triggered because GFP_KERNEL is used
>>> to allocate memory. This can deadlock because rq_qos_mutex can be held
>>> with queue frozen.
>>>
>>> Fix the problem by using blkg_conf_open_bdev_frozen(), also remove
>>> useless queue frozen from blk_throtl_init().
>>>
>>> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
>>> ---
>> I think this patch goes toward wrong direction by enlarging queue freeze
>> scope, and blkg_conf_prep() may run into percpu allocation, then new
>> lockdep warning could be triggered.
>>
>> IMO, we should try to reduce blkg_conf_open_bdev_frozen() uses, instead of
>> adding more.
> 
> Fortunately, blk_throtl_init() doesn't have percpu allocation, so this is
> safe now. Unfortunately, blk-iocost and blk-iolatency do have percpu allocation
> and they're already problematic for a long time. The queue is already frozen from
> blkcg_activate_policy() and then the pd_alloc_fn() will try percpu allocation.
> 
> To be honest, I feel it's too complicated to move all the percpu allocation out of
> queue frozen, will it be possible to fix this the other way by passing another gfp
> into pcpu_alloc_noprof() that it'll be atomic to work around the pcpu_alloc_mutex.
> 

I agree that in some cases, when percpu allocation occurs deep within complex call
chains, it can be quite challenging to move the allocation ahead of ->freeze_lock
without significantly restructuring the code.

Looking back at the history of percpu allocation behavior, commit 28307d938fb2
(“percpu: make pcpu_alloc() aware of current gfp context”) changed pcpu_alloc()
semantics such that allocations were treated as atomic if the current GFP context
did not include GFP_KERNEL. As a result, GFP_NOIO and GFP_NOFS allocations were
also treated as atomic. This change was merged in kernel v5.10.

Later, commit 9a5b183941b5 (“mm, percpu: do not consider sleepable allocations
atomic”) refined this behavior further. With this change, percpu allocations are
considered atomic only if the the caller explicitly marked the calling context
atomic (probably using GFP_ATOMIC or GFP_NOWAIT).

While commit 9a5b183941b5 ("mm, percpu: do not consider sleepable allocations
atomic”) does the right thing conceptually, it has resulted in a number of lockdep
warnings reporting potential deadlocks when code paths attempt to allocate percpu
memory while a request queue is frozen.

Given this history, and the recent lockdep splats involving percpu allocation and
queue freezing, I would suggest using GFP_ATOMIC for pcpu allocations that are
invoked while the queue is already frozen, where feasible. By “feasible,” I mean
cases where the allocation size is small enough that using GFP_ATOMIC is reasonable—
typically only a few tens or hundreds of bytes per CPU. In such cases, the risk and
cost associated with atomic allocations are minimal and acceptable.

For example, struct latency_stat, which requires approximately 40 bytes per CPU, and
struct iocg_pcpu_stat, which requires only 8 bytes per CPU, are good candidates for
this approach.

Using GFP_ATOMIC in these limited, well-defined cases could help avoid lockdep warnings
and potential deadlocks, without requiring invasive refactoring to move percpu allocations
outside the queue-freeze window.

Thanks,
--Nilay
