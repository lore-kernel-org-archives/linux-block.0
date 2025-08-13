Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D68613D521
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097630; cv=none; b=U0BLD5mq0rXYutrfAQy7DBt+iRBHxLSwzQaTV35/B27NZzo0yLnGKTRzHdqw4bfJv8xnIiMsg0Zqc3nlmka3ZCMvyGYrYuasRuhvSiTELqq/poOCI7UVRAzc1Y1eaJ7ueIu/a4yqU13v4LQp1sSoA9io0YttDuI8QVJ9GoL3Gw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097630; c=relaxed/simple;
	bh=D0KW1laVSUYkHKPl9Rjf1dAKr4rTEfDfrA+ukWfElsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3GeDB1c1eFIP1FZ2beqKzFKtsYoldXOEucaEUaSb/8B+RH1CrU5wRWa+WaVGlyf7lTS3j4qJr608FcDN6o7fPOtgWp9w+WC8sJfj46X3tuyPu9yOWnhM8RehYwZr52FiD8uX53nwqQXY00kgrtWrZig+7zOvU1jsLmYESN64xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MYtEUiV2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MYtEUiV2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBK9G8011513;
	Wed, 13 Aug 2025 15:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pPG7tw
	ov34Dym1N57yZ5lOD6s4DM6SHfMFFbc1gSmac=; b=MYtEUiV2oz89GuVh6gKmN+
	PJXIXmRR8ROjDSvaQThFRP8uPeEwowmiDThdtguHvqNmGx+QQl1ytHnzbuzIrp8E
	6zQqEcCiFqKxxRHbaTpS2YmVC31bzacAAYGwdSMUSyZ3U2L+C/nQap+aDLRL8L/S
	3Zr3UouYtKLKWdu5wGKJucY20vjNL8zbAIywtOZ5ssJBQBDK6MZUCq0Uv8mrLOzz
	2F8Hxot1sqJ7kl9uhKPxBecF2wQSbQBizWQFlVF1i+Al0lLcxcuw3OWybswh+CP+
	Ag8ERGPo4T4nUfB6qCsCEv+Xw6ODLwwDV7iWypInEtTFz3UuGJ8hG2xzvkqjVhrw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx2d55kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 15:01:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57DCuu4A025667;
	Wed, 13 Aug 2025 15:01:32 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvmfhv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 15:01:32 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57DF1WxO15401492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 15:01:32 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AE2258063;
	Wed, 13 Aug 2025 15:01:32 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14CA458059;
	Wed, 13 Aug 2025 15:01:29 +0000 (GMT)
Received: from [9.61.63.67] (unknown [9.61.63.67])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Aug 2025 15:01:28 +0000 (GMT)
Message-ID: <b1d8c1ac-880d-49ca-8c63-f3e4a502ba8b@linux.ibm.com>
Date: Wed, 13 Aug 2025 20:31:27 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: blk-rq-qos: replace static key with atomic
 bitop
To: Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai1@huaweicloud.com>,
        Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, kch@nvidia.com, shinichiro.kawasaki@wdc.com,
        hch@lst.de, gjoyce@ibm.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250804122125.3271397-1-nilay@linux.ibm.com>
 <aJC4tDUsk42Nb9Df@fedora>
 <682f0f43-733a-4c04-91ed-5665815128bc@linux.ibm.com>
 <d4d21177-e49e-4959-b68c-707a15dccf73@kernel.dk>
 <e00a3951-2cc8-3634-788e-8a174bdc6a8f@huaweicloud.com>
 <06b0f3f6-1419-4b01-85a5-fe3bb38a6c63@linux.ibm.com>
 <d8fcf9bf-6b90-444a-8a26-658cee9e7f58@kernel.dk>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <d8fcf9bf-6b90-444a-8a26-658cee9e7f58@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX4p/zaYulikLq
 gerxj1u9KxFlnPN2Ed4gdsspfqGzJEgCc3QKkD32EB12hN2HTeDG4JBded55sAKarxqS5Y9/AlO
 4OxmSf1+g+hbPEE5UE1QjgOZ9icz8AzYu4IPlRgv6QUGl/d/B/iYVzJO5bwd55heU4Ox+E6ddZ7
 UgIXRC9GVh26LpDqBNkoIym7czgNKNBsYH+FUyQ/ZLmqFvOZzeF61O3I9d4LEQSljEPPKUkM+0C
 srbboArF3PkCEJckqV/bBHPacMx9Yf+1hUwOoeLFAKY3loMbFkzsED1gIVgd5PyGTuLlsjbOu43
 mfnT+SqT+tV+qzoSHwhWaN55o3aDydFH4m9Pd9jD6P9H7VTiykZP+qjqRBmmxOuQx0leYap/cDh
 lwiE7RX/
X-Proofpoint-GUID: z3KmKwUIzH04cDasdXyEQJhYfk4uuC1e
X-Authority-Analysis: v=2.4 cv=C9zpyRP+ c=1 sm=1 tr=0 ts=689ca8ce cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=nAMe7bFlgokCNBs75zgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: z3KmKwUIzH04cDasdXyEQJhYfk4uuC1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120224



On 8/13/25 5:46 PM, Jens Axboe wrote:
> On 8/13/25 5:20 AM, Nilay Shroff wrote:
>> Hi Jens,
>>
>> On 8/6/25 7:14 AM, Yu Kuai wrote:
>>> Hi,
>>>
>>> ? 2025/08/06 9:28, Jens Axboe ??:
>>>> On 8/4/25 10:58 PM, Nilay Shroff wrote:
>>>>>
>>>>>
>>>>> On 8/4/25 7:12 PM, Ming Lei wrote:
>>>>>> On Mon, Aug 04, 2025 at 05:51:09PM +0530, Nilay Shroff wrote:
>>>>>>> This patchset replaces the use of a static key in the I/O path (rq_qos_
>>>>>>> xxx()) with an atomic queue flag (QUEUE_FLAG_QOS_ENABLED). This change
>>>>>>> is made to eliminate a potential deadlock introduced by the use of static
>>>>>>> keys in the blk-rq-qos infrastructure, as reported by lockdep during
>>>>>>> blktests block/005[1].
>>>>>>>
>>>>>>> The original static key approach was introduced to avoid unnecessary
>>>>>>> dereferencing of q->rq_qos when no blk-rq-qos module (e.g., blk-wbt or
>>>>>>> blk-iolatency) is configured. While efficient, enabling a static key at
>>>>>>> runtime requires taking cpu_hotplug_lock and jump_label_mutex, which
>>>>>>> becomes problematic if the queue is already frozen ? causing a reverse
>>>>>>> dependency on ->freeze_lock. This results in a lockdep splat indicating
>>>>>>> a potential deadlock.
>>>>>>>
>>>>>>> To resolve this, we now gate q->rq_qos access with a q->queue_flags
>>>>>>> bitop (QUEUE_FLAG_QOS_ENABLED), avoiding the static key and the associated
>>>>>>> locking altogether.
>>>>>>>
>>>>>>> I compared both static key and atomic bitop implementations using ftrace
>>>>>>> function graph tracer over ~50 invocations of rq_qos_issue() while ensuring
>>>>>>> blk-wbt/blk-iolatency were disabled (i.e., no QoS functionality). For
>>>>>>> easy comparision, I made rq_qos_issue() noinline. The comparision was
>>>>>>> made on PowerPC machine.
>>>>>>>
>>>>>>> Static Key (disabled : QoS is not configured):
>>>>>>> 5d0: 00 00 00 60     nop    # patched in by static key framework (not taken)
>>>>>>> 5d4: 20 00 80 4e     blr    # return (branch to link register)
>>>>>>>
>>>>>>> Only a nop and blr (branch to link register) are executed ? very lightweight.
>>>>>>>
>>>>>>> atomic bitop (QoS is not configured):
>>>>>>> 5d0: 20 00 23 e9     ld      r9,32(r3)     # load q->queue_flags
>>>>>>> 5d4: 00 80 29 71     andi.   r9,r9,32768   # check QUEUE_FLAG_QOS_ENABLED (bit 15)
>>>>>>> 5d8: 20 00 82 4d     beqlr                 # return if bit not set
>>>>>>>
>>>>>>> This performs an ld and and andi. before returning. Slightly more work,
>>>>>>> but q->queue_flags is typically hot in cache during I/O submission.
>>>>>>>
>>>>>>> With Static Key (disabled):
>>>>>>> Duration (us): min=0.668 max=0.816 avg?0.750
>>>>>>>
>>>>>>> With atomic bitop QUEUE_FLAG_QOS_ENABLED (bit not set):
>>>>>>> Duration (us): min=0.684 max=0.834 avg?0.759
>>>>>>>
>>>>>>> As expected, both versions are almost similar in cost. The added latency
>>>>>>> from an extra ld and andi. is in the range of ~9ns.
>>>>>>>
>>>>>>> There're two patches in the series. The first patch replaces static key
>>>>>>> with QUEUE_FLAG_QOS_ENABLED. The second patch ensures that we disable
>>>>>>> the QUEUE_FLAG_QOS_ENABLED when the queue no longer has any associated
>>>>>>> rq_qos policies.
>>>>>>>
>>>>>>> As usual, feedback and review comments are welcome!
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>>>>>
>>>>>>
>>>>>> Another approach is to call memalloc_noio_save() in cpu hotplug code...
>>>>>>
>>>>> Yes that would help fix this. However per the general usage of GFP_NOIO scope in
>>>>> kernel, it is used when we're performing memory allocations in a context where I/O
>>>>> must not be initiated, because doing so could cause deadlocks or recursion.
>>>>>
>>>>> So we typically, use GFP_NOIO in a code path that is already doing I/O, such as:
>>>>> - In block layer context: during request submission
>>>>> - Filesystem writeback, or swap-out.
>>>>> - Memory reclaim or writeback triggered by memory pressure.
>>>>>
>>>>> The cpu hotplug code may not be running in any of the above context. So
>>>>> IMO, adding memalloc_noio_save() in the cpu hotplug code would not be
>>>>> a good idea, isn't it?
>>>>
>>>> Please heed Ming's advice, moving this from a static key to an atomic
>>>> queue flags ops is pointless, may as well kill it at that point.
>>>
>>> Nilay already tested and replied this is a dead end :(
>>>
>>> I don't quite understand why it's pointless, if rq_qos is never enabled,
>>> an atmoic queue_flag is still minor optimization, isn't it?
>>>
>>>>
>>>> I see v2 is out now with the exact same approach.
>>>>
>> As mentioned earlier, I tried Ming's original recommendation, but it didn?t
>> resolve the issue. In a separate thread, Ming agreed that using an atomic queue
>> flag is a reasonable approach and would avoid the lockdep problem while still
>> keeping a minor fast-path optimization.
>>
>> That leaves us with two options:
>> - Use an atomic queue flag, or
>> - Remove the static key entirely.
>>
>> So before I send v3, do you prefer the atomic queue flag approach, or
>> would you rather see the static key removed altogether? My preference
>> is for the atomic queue flag, as it maintains a lightweight check
>> without the static key?s locking concerns. 
> 
> Atomic test is still going to be better than pointless calls into
> rq-qos, so that's still a win. Hence retaining it is better than simply
> killing it off entirely.
> 
> I wonder if it makes sense to combine with IS_ENABLED() as well. Though
> with how distros enable everything under the sun, probably not going to
> be that useful.
> 
Yes agreed, in my RHEL distro CONFIG_BLK_WBT, CONFIG_BLK_CGROUP_IOCOST
and CONFIG_BLK_CGROUP_IOLATENCY are all default enabled. So IS_ENABLED()
may not be that helpful. I'd send out v3 with some minor changes (per 
review comments) using atomic queue flag now.

Thanks,
--Nilay
