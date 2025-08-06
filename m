Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6837635959
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 05:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754457247; cv=none; b=bGHpu528eRlMWjLRANJhufDowG/gr+qV+AvdsvhZhfpSIZmMRLWULQBit7rjBs0YMrP8h2Dl+zdtv1Zv2QFrYqgri8+xYbtS9d57HJAxtd7tz1z5ljQm4zsdcH7kuRiwW+5Yd9af3cu7u0IWkGkWDSkx3NoJOpd7SLCFxL/avdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754457247; c=relaxed/simple;
	bh=gWXhbzaPGV5nMYs1ci3bLRwBrwb69ACiwafzD/3Fmu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHd2i1IMxGplcF3yVN0OYM1G9v/k9yd7A263EDk4m8Wqis87ds2VjZnvDac7TZZPL2NXZlplx2Y0VMHERd8wdgiCLOdDkdaF5j4T4ALdVqcVhAj35L+3EKyCNRnAzk/Mm7dv8UDQiKHenn5Jh/yM9ipzBjnZCmTDcTR2Fg8J53A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z3zH+t3l; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z3zH+t3l"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575Io2ju018750;
	Wed, 6 Aug 2025 05:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wkhMos
	w8sJkQwvxEa0+ILtV9oKJ8AQ9Gmo0jLmSQXAA=; b=Z3zH+t3lWIBM63dKS3oxA3
	/BVCOabOgRQ4aLIWkywA0oeMJHa81uCLgLu9Y2JAuWVc/ik9ThKD21jqRyR4myKa
	SxnxS5946zlAB+A2a2zmB/2iinbzDjgA9/ykC2W2dksTW99WunsqvJiAvinTF3Ts
	0szymXkjom3e3ih5GzemNgtFFjBtrKV4kuBLvmzoizHJxGSGSvUTnPlc5FAVTleY
	/oBJGrerIIhu0ZntJKJ8XSg7JCU3/tG+yw0wOQ0eZEh8nH2zr75u055bHKGux8fi
	Fm9q26oPkVkQamZR9xYBxohdx5W/W36zN05JipWWTbAAltG7fl5ybU3JTT9GGO+Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq6326j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 05:13:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5763R7LJ025959;
	Wed, 6 Aug 2025 05:13:55 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwn240b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 05:13:55 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5765DtYk30016218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 05:13:55 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07CE058053;
	Wed,  6 Aug 2025 05:13:55 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C383D5805F;
	Wed,  6 Aug 2025 05:13:51 +0000 (GMT)
Received: from [9.43.92.22] (unknown [9.43.92.22])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Aug 2025 05:13:51 +0000 (GMT)
Message-ID: <cfe709a6-1122-4ea9-875f-aa2a34ab1477@linux.ibm.com>
Date: Wed, 6 Aug 2025 10:43:49 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: blk-rq-qos: replace static key with atomic
 bitop
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, kch@nvidia.com, shinichiro.kawasaki@wdc.com,
        hch@lst.de, gjoyce@ibm.com
References: <20250804122125.3271397-1-nilay@linux.ibm.com>
 <aJC4tDUsk42Nb9Df@fedora>
 <682f0f43-733a-4c04-91ed-5665815128bc@linux.ibm.com>
 <d4d21177-e49e-4959-b68c-707a15dccf73@kernel.dk>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <d4d21177-e49e-4959-b68c-707a15dccf73@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NInV+16g c=1 sm=1 tr=0 ts=6892e494 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ymlgizzNRXlfm_1EKkMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: q6mjMemOzLkaliYCstqyZqdqZS6iM0QC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAzMCBTYWx0ZWRfX+922zHPOOHXT
 cpPCEOc92L8Ep6YNwfBWbGVHaF4jQ8Gtg7atl/mO6LBlCBALVCkV1ICmaxiOmw1OJkT0BWjWCs7
 KtWPD0b27LR4t3eJoMJuCUJncfRajKBqvGjd6vD7Aq8OFvZxn2C15zgAfg/u5nG/AxMgYA2EQCf
 hiZ4VzKuVbVo0ObSuaiLHa2vHzbPRVmvconFUYJJaV9naTP8bQHAxB9oFuzvJOXCseDMeH+qLd0
 kC+evnRiMmikZKGY7pQUr92Dbd4Xy+fzHpeaHjRWJGfDx1N5OZE885144TWLh3omxKMF2CPzc5G
 rVm7vNqyctqvEJABYtnXOUtoV8E47LuMn6HMHZWKxacKq2C8h5vmdna2bvgx0iwotianXTq7/lf
 3+fzAUZy0SdM5rNLf8RVfXHIrdL1a0Tm/OgOHGwW82Pj6OBBacctYDctazSxBfDJZpxNORcs
X-Proofpoint-ORIG-GUID: q6mjMemOzLkaliYCstqyZqdqZS6iM0QC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060030



On 8/6/25 6:58 AM, Jens Axboe wrote:
> On 8/4/25 10:58 PM, Nilay Shroff wrote:
>>
>>
>> On 8/4/25 7:12 PM, Ming Lei wrote:
>>> On Mon, Aug 04, 2025 at 05:51:09PM +0530, Nilay Shroff wrote:
>>>> This patchset replaces the use of a static key in the I/O path (rq_qos_
>>>> xxx()) with an atomic queue flag (QUEUE_FLAG_QOS_ENABLED). This change
>>>> is made to eliminate a potential deadlock introduced by the use of static
>>>> keys in the blk-rq-qos infrastructure, as reported by lockdep during 
>>>> blktests block/005[1].
>>>>
>>>> The original static key approach was introduced to avoid unnecessary
>>>> dereferencing of q->rq_qos when no blk-rq-qos module (e.g., blk-wbt or
>>>> blk-iolatency) is configured. While efficient, enabling a static key at
>>>> runtime requires taking cpu_hotplug_lock and jump_label_mutex, which 
>>>> becomes problematic if the queue is already frozen — causing a reverse
>>>> dependency on ->freeze_lock. This results in a lockdep splat indicating
>>>> a potential deadlock.
>>>>
>>>> To resolve this, we now gate q->rq_qos access with a q->queue_flags
>>>> bitop (QUEUE_FLAG_QOS_ENABLED), avoiding the static key and the associated
>>>> locking altogether.
>>>>
>>>> I compared both static key and atomic bitop implementations using ftrace
>>>> function graph tracer over ~50 invocations of rq_qos_issue() while ensuring
>>>> blk-wbt/blk-iolatency were disabled (i.e., no QoS functionality). For
>>>> easy comparision, I made rq_qos_issue() noinline. The comparision was
>>>> made on PowerPC machine.
>>>>
>>>> Static Key (disabled : QoS is not configured):
>>>> 5d0: 00 00 00 60     nop    # patched in by static key framework (not taken)
>>>> 5d4: 20 00 80 4e     blr    # return (branch to link register)
>>>>
>>>> Only a nop and blr (branch to link register) are executed — very lightweight.
>>>>
>>>> atomic bitop (QoS is not configured):
>>>> 5d0: 20 00 23 e9     ld      r9,32(r3)     # load q->queue_flags
>>>> 5d4: 00 80 29 71     andi.   r9,r9,32768   # check QUEUE_FLAG_QOS_ENABLED (bit 15)
>>>> 5d8: 20 00 82 4d     beqlr                 # return if bit not set
>>>>
>>>> This performs an ld and and andi. before returning. Slightly more work, 
>>>> but q->queue_flags is typically hot in cache during I/O submission.
>>>>
>>>> With Static Key (disabled):
>>>> Duration (us): min=0.668 max=0.816 avg≈0.750
>>>>
>>>> With atomic bitop QUEUE_FLAG_QOS_ENABLED (bit not set):
>>>> Duration (us): min=0.684 max=0.834 avg≈0.759
>>>>
>>>> As expected, both versions are almost similar in cost. The added latency
>>>> from an extra ld and andi. is in the range of ~9ns.
>>>>
>>>> There're two patches in the series. The first patch replaces static key
>>>> with QUEUE_FLAG_QOS_ENABLED. The second patch ensures that we disable
>>>> the QUEUE_FLAG_QOS_ENABLED when the queue no longer has any associated
>>>> rq_qos policies.
>>>>
>>>> As usual, feedback and review comments are welcome!
>>>>
>>>> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>>
>>>
>>> Another approach is to call memalloc_noio_save() in cpu hotplug code...
>>>
>> Yes that would help fix this. However per the general usage of GFP_NOIO scope in 
>> kernel, it is used when we're performing memory allocations in a context where I/O
>> must not be initiated, because doing so could cause deadlocks or recursion. 
>>
>> So we typically, use GFP_NOIO in a code path that is already doing I/O, such as:
>> - In block layer context: during request submission 
>> - Filesystem writeback, or swap-out.
>> - Memory reclaim or writeback triggered by memory pressure.
>>
>> The cpu hotplug code may not be running in any of the above context. So
>> IMO, adding memalloc_noio_save() in the cpu hotplug code would not be 
>> a good idea, isn't it?
> 
> Please heed Ming's advice, moving this from a static key to an atomic
> queue flags ops is pointless, may as well kill it at that point.
> 
Yes I agree and personally I like static key very much as it's lightweight. 
And I also liked the way you used it in IO hotpath so that we avoid cost of
fetching q->rq_qos when not needed. 
Having said that, I also tried Ming's suggestion but that didn't work out
due to the fact that "cpu_hotplug_lock is widely used across various kernel
subsystems— not just in CPU hotplug-specific paths. There are several code
paths outside of the hotplug core that acquire cpu_hotplug_lock and subsequently
perform memory allocations using GFP_KERNEL". So essentially adopting to use
GFP_NOIO in cpu hotplug code may not help. You might have missed my reply to
Ming's suggestion, you may refer it here:
https://lore.kernel.org/all/897eaaa4-31c7-4661-b5d4-3e2bef1fca1e@linux.ibm.com/#t

> I see v2 is out now with the exact same approach.
> 
Yes I sent out v2 just for fixing minor things in the original patch as I
outlined it in the v2 changelog.


Thanks,
--Nilay

