Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4292F0693
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755084350; cv=none; b=U9RPBDcwHNDOKqah4xWXSL9UV0iGUkwBKDXzVwInIuG9k5y7GV2KSiaaHJzgLlfW/bo2Nmjq+/EaGbRC260TUS//dva20IXE+CYob/f1irFy2PtefIn5kuSZGM39ooaMBabD+VM29/PsH69/eXzhWDMVBj6/y7w0IMBQVu+0dTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755084350; c=relaxed/simple;
	bh=UuMlu3HdT8K5CVfY5H0bpPBnHQxks7tLzPVHDGc+JBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBRsgpG90d5TeVydL1u4ELvbuXBqVXn4C5KQ/lJPwpHo4bvM9DFLxbtvcbhuCUC4+YE8RRUkXLTMfa4ELMeVPuUmXNNmDrmB534QQpi3Ion3VPE/4ebrzOo7dnZqH3LAndphPc4+fpLbLZS5AkcVeVxu8GG2sSQ2w93oDtczwoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DegzgVLB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DegzgVLB"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CNQKvY008652;
	Wed, 13 Aug 2025 11:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=J6ykv+
	YkrdoqPgB6sqcwM/YmQCWtTyLCrAWfNZwXS6A=; b=DegzgVLB9M6Z4JTtTMDPMq
	SgrQAu3lEhLXRplwNqYOeOCyOy8x09VJk1lkNqLfJI//XAVoOZds4kpblZQOEPr4
	jibQ2sjD6Ihac33qvdG2tCXqdMoc1bn+kTp2r+tqoSZ0AR8K0xf4YmN5AVlfO3ey
	jboR45YaWO2PPZG4emOE6hJwtBCZzukAM56Rf8mPZ0iLvE33aXBln2JZ61r7dEMV
	oC43waCLCJqejG6S427P6Ly5bUOaYb0Q5wP0I6o81fmqSkKzoOYQLnCUcqoQFelk
	3GfMEQzAH9bglyoG0Iodqmqm3Evca798NJzWN5RF5BMfT5ysOurHl2E87uyY3Maw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48duruc2yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 11:20:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57DAvPwZ026302;
	Wed, 13 Aug 2025 11:20:25 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh21757n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 11:20:25 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57DBKPeZ30277982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 11:20:25 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B84E58043;
	Wed, 13 Aug 2025 11:20:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26F8958059;
	Wed, 13 Aug 2025 11:20:22 +0000 (GMT)
Received: from [9.61.63.67] (unknown [9.61.63.67])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Aug 2025 11:20:21 +0000 (GMT)
Message-ID: <06b0f3f6-1419-4b01-85a5-fe3bb38a6c63@linux.ibm.com>
Date: Wed, 13 Aug 2025 16:50:20 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: blk-rq-qos: replace static key with atomic
 bitop
To: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, kch@nvidia.com, shinichiro.kawasaki@wdc.com,
        hch@lst.de, gjoyce@ibm.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250804122125.3271397-1-nilay@linux.ibm.com>
 <aJC4tDUsk42Nb9Df@fedora>
 <682f0f43-733a-4c04-91ed-5665815128bc@linux.ibm.com>
 <d4d21177-e49e-4959-b68c-707a15dccf73@kernel.dk>
 <e00a3951-2cc8-3634-788e-8a174bdc6a8f@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <e00a3951-2cc8-3634-788e-8a174bdc6a8f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Nh7M1b8kfXhMXnnmZzUAPx3aIulkX7ih
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfXxJej3/ziYNsu
 CbaZNxEcKUe1ghW/2BAr2jx6aUu2o6UCEXGRNvotb9cng7KU5Mi0d4iZchgmSZ4OC0ucX1B6qCq
 Ho186CB8Qs4l0Ez47IgEnmYkr3LkPYFjF4rCLPFJZo8uLTFtd4QWgDe69Zd+WV32PXBgXPNjfuJ
 CWBwSn7JWA0SHZKsVvaXrIpIqBETmnOjGWxvxUEkqjkYQspe/vrOcRGbgpP7hDNtm/sa5LLhfPt
 bu/M8kSn/8p/hH1G/sgy1+9XMhnLum82S7SqkFmeAlf70b6cTv5F/3rGtCKYu0z9cnHucOp+WEp
 wZO4fejM7viv7hffrUebDBCiSEEP+9Hy+F81sHSFCJ65ZsEEGDSzl2dympJsd0aXe4DA/FpvIY4
 xJVXPJXo
X-Authority-Analysis: v=2.4 cv=QtNe3Uyd c=1 sm=1 tr=0 ts=689c74fa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=SGIgXFZVcngrNucamzcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Nh7M1b8kfXhMXnnmZzUAPx3aIulkX7ih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224

Hi Jens,

On 8/6/25 7:14 AM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/06 9:28, Jens Axboe 写道:
>> On 8/4/25 10:58 PM, Nilay Shroff wrote:
>>>
>>>
>>> On 8/4/25 7:12 PM, Ming Lei wrote:
>>>> On Mon, Aug 04, 2025 at 05:51:09PM +0530, Nilay Shroff wrote:
>>>>> This patchset replaces the use of a static key in the I/O path (rq_qos_
>>>>> xxx()) with an atomic queue flag (QUEUE_FLAG_QOS_ENABLED). This change
>>>>> is made to eliminate a potential deadlock introduced by the use of static
>>>>> keys in the blk-rq-qos infrastructure, as reported by lockdep during
>>>>> blktests block/005[1].
>>>>>
>>>>> The original static key approach was introduced to avoid unnecessary
>>>>> dereferencing of q->rq_qos when no blk-rq-qos module (e.g., blk-wbt or
>>>>> blk-iolatency) is configured. While efficient, enabling a static key at
>>>>> runtime requires taking cpu_hotplug_lock and jump_label_mutex, which
>>>>> becomes problematic if the queue is already frozen — causing a reverse
>>>>> dependency on ->freeze_lock. This results in a lockdep splat indicating
>>>>> a potential deadlock.
>>>>>
>>>>> To resolve this, we now gate q->rq_qos access with a q->queue_flags
>>>>> bitop (QUEUE_FLAG_QOS_ENABLED), avoiding the static key and the associated
>>>>> locking altogether.
>>>>>
>>>>> I compared both static key and atomic bitop implementations using ftrace
>>>>> function graph tracer over ~50 invocations of rq_qos_issue() while ensuring
>>>>> blk-wbt/blk-iolatency were disabled (i.e., no QoS functionality). For
>>>>> easy comparision, I made rq_qos_issue() noinline. The comparision was
>>>>> made on PowerPC machine.
>>>>>
>>>>> Static Key (disabled : QoS is not configured):
>>>>> 5d0: 00 00 00 60     nop    # patched in by static key framework (not taken)
>>>>> 5d4: 20 00 80 4e     blr    # return (branch to link register)
>>>>>
>>>>> Only a nop and blr (branch to link register) are executed — very lightweight.
>>>>>
>>>>> atomic bitop (QoS is not configured):
>>>>> 5d0: 20 00 23 e9     ld      r9,32(r3)     # load q->queue_flags
>>>>> 5d4: 00 80 29 71     andi.   r9,r9,32768   # check QUEUE_FLAG_QOS_ENABLED (bit 15)
>>>>> 5d8: 20 00 82 4d     beqlr                 # return if bit not set
>>>>>
>>>>> This performs an ld and and andi. before returning. Slightly more work,
>>>>> but q->queue_flags is typically hot in cache during I/O submission.
>>>>>
>>>>> With Static Key (disabled):
>>>>> Duration (us): min=0.668 max=0.816 avg≈0.750
>>>>>
>>>>> With atomic bitop QUEUE_FLAG_QOS_ENABLED (bit not set):
>>>>> Duration (us): min=0.684 max=0.834 avg≈0.759
>>>>>
>>>>> As expected, both versions are almost similar in cost. The added latency
>>>>> from an extra ld and andi. is in the range of ~9ns.
>>>>>
>>>>> There're two patches in the series. The first patch replaces static key
>>>>> with QUEUE_FLAG_QOS_ENABLED. The second patch ensures that we disable
>>>>> the QUEUE_FLAG_QOS_ENABLED when the queue no longer has any associated
>>>>> rq_qos policies.
>>>>>
>>>>> As usual, feedback and review comments are welcome!
>>>>>
>>>>> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>>>
>>>>
>>>> Another approach is to call memalloc_noio_save() in cpu hotplug code...
>>>>
>>> Yes that would help fix this. However per the general usage of GFP_NOIO scope in
>>> kernel, it is used when we're performing memory allocations in a context where I/O
>>> must not be initiated, because doing so could cause deadlocks or recursion.
>>>
>>> So we typically, use GFP_NOIO in a code path that is already doing I/O, such as:
>>> - In block layer context: during request submission
>>> - Filesystem writeback, or swap-out.
>>> - Memory reclaim or writeback triggered by memory pressure.
>>>
>>> The cpu hotplug code may not be running in any of the above context. So
>>> IMO, adding memalloc_noio_save() in the cpu hotplug code would not be
>>> a good idea, isn't it?
>>
>> Please heed Ming's advice, moving this from a static key to an atomic
>> queue flags ops is pointless, may as well kill it at that point.
> 
> Nilay already tested and replied this is a dead end :(
> 
> I don't quite understand why it's pointless, if rq_qos is never enabled,
> an atmoic queue_flag is still minor optimization, isn't it?
> 
>>
>> I see v2 is out now with the exact same approach.
>>
As mentioned earlier, I tried Ming's original recommendation, but it didn’t
resolve the issue. In a separate thread, Ming agreed that using an atomic queue
flag is a reasonable approach and would avoid the lockdep problem while still
keeping a minor fast-path optimization.

That leaves us with two options:
- Use an atomic queue flag, or
- Remove the static key entirely.

So before I send v3, do you prefer the atomic queue flag approach, or would you rather
see the static key removed altogether? My preference is for the atomic queue flag, 
as it maintains a lightweight check without the static key’s locking concerns. 

Thanks,
--Nilay
