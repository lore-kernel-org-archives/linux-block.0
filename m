Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C7F3C65F2
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694507; cv=none; b=sbRC9cRPuI7KcPKL/TXPmlMGWM8DHZVGCm5vuAxvm3crEdco31NxuZrrDFAViFimtY9PcrtG6ksdgvaw3DiIkkD/HLz1hyIjGMvP228+C0pE4jbXx2JnE8QjC/5PmjiJPqUbV5gjorR/6wCk7ARMo1k4+7MhmiH2lebNCyK3v58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694507; c=relaxed/simple;
	bh=JlrXCi5kjziRCq3qzXPHpy9PSkO+K6oRxcAz/OffJTE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sMZ1MbIdcrndEoliJLtnxGDl5Tw5gwIyY446U+YYHbvConj6XfsBW2GgORPnhZYnW7npAaeAZk2S/6BiZt6Acp2KcpXSqFNYh0c9pSZl7mFwuggqjPyuldqQXPxrMDUn2Etkw7AxpiMLZuae/EOiX2ddZsuxk52l2E8EM32w/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mYN8evJO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mYN8evJO"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8mUYj4003145;
	Wed, 17 Jun 2026 11:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DnMHbp
	QfP3o11FHImxlk8eWkzn/2IszUSATvlfggb+c=; b=mYN8evJOvMHTCkafFrAiBQ
	hbpGH1o1ASHyASM2cH8967BGsDaxhh464/ABUkI7fpL5SHvmJn/8Wg8jiuZYtCpO
	T3YqBaL96tXtmoafvlWozLXbkNP1YOcKZ1vQOSu9epGCm99pdzlJD8epl4/WZW5o
	rF3eS0oJsYEIPfvd/5fnEvVM3Z3cKAA+9I/5WBOoCjuBJmvCPgbGW39DE6/cd112
	+u4xvVRjdIPtZ2txqKcL5TOIKMqu9FxXYIexnQCFlFpBmOdLwFHZV/AVFVUGgYxy
	6ZRIbfUqFxYrazEGQXsrZhHfu8sednRjckb8nRr91QMCjihkAYCDxUEBiXRhyAsg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx2gvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 11:08:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65HB4eb4007071;
	Wed, 17 Jun 2026 11:08:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva2ts0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 11:08:22 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65HB8MiV11665954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 11:08:22 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D483582A6;
	Wed, 17 Jun 2026 11:08:22 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C224582A3;
	Wed, 17 Jun 2026 11:08:20 +0000 (GMT)
Received: from [9.43.94.246] (unknown [9.43.94.246])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jun 2026 11:08:19 +0000 (GMT)
Message-ID: <2371227f-43ef-4a0d-ad8f-da23eea43357@linux.ibm.com>
Date: Wed, 17 Jun 2026 16:38:18 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH RFC 0/1] block: fix concurrent elevator change failure
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20260611074200.474676-1-shinichiro.kawasaki@wdc.com>
 <aiqaXfTqCLMu2DwF@fedora> <aivMxPCd305WbBsk@shinmob>
 <aivoHk4DE_pkKkDm@fedora>
 <3db036fe-747f-44eb-93c3-595350278297@linux.ibm.com>
 <ajCa9GrGoB4uXRpS@shinmob>
Content-Language: en-US
In-Reply-To: <ajCa9GrGoB4uXRpS@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: GPYBGOG_Mlmz2kGmGymmCJdD0Pf-rkN7
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a328027 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=ifpdS2MJElTPYOAgnVsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwMiBTYWx0ZWRfX/UYh3CvwQvfe
 JxuDw7Pc5rLvukPxQZ4e9M9sNbqhkDjrerdfIsi5YNe1nxQJzjbA7TA4jjiIwmqze9BEFER/GHF
 NBuogBO8BWDK2rfrD2QdHZ/n1bGcZ60=
X-Proofpoint-ORIG-GUID: rzmsy2v9VgGuMtbRiS-L2xhUKv_69MUj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwMiBTYWx0ZWRfX4aNVg+lQzeAr
 NS8vwcMbNCVjywj17IrMCddKicik4xqiWeYxmgT2NYti9mUW54ACwgmt+aE54kGDhsy3+M6LaIF
 vdJXYg4ukfZCDRSA20JKsTpIp6WCm8oH9jw1H2WobRy6viQZERbiU+UfAsN9s3e3VKbGtYe6ALt
 zA9WoaVA/3dixGjRQqhJrzq9dLR1WAxJOtELevXkfxwiotCrIVf2z4lVCv7sqN82o2ZGa9iqTKt
 /yaDv+tdmEpVV4SLSCvw7LaUjnSacVr9g3VIr8EsVY7JQCszDL8QA83ReVoRvMBHHEyW0cCpJnV
 lkBL7d7pybcFeWHzOhm1krLSEb7VJPOcaafQgDPF29Mu4gKygG+J6DqqCnMiIJbwq5RsCkX1wYE
 a0TZqbbLnrhJb50OYRAY/rtbh3HwizFIf0vwKHrxJOo0CO8KuRCBvPwDZ95EH8yxBvsKGOAuNq1
 RV7NPZfdMmFWzI3ChAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170102

On 6/16/26 6:50 AM, Shin'ichiro Kawasaki wrote:
> On Jun 12, 2026 / 17:15, Nilay Shroff wrote:
>> On 6/12/26 4:36 PM, Ming Lei wrote:
>>> On Fri, Jun 12, 2026 at 06:47:50PM +0900, Shin'ichiro Kawasaki wrote:
>>>> On Jun 11, 2026 / 06:22, Ming Lei wrote:
>>>>> Hi Shin'ichiro,
>>>>
>>>> Hi Ming, thanks for the comments.
>>>>
>>>>>
>>>>> On Thu, Jun 11, 2026 at 04:41:59PM +0900, Shin'ichiro Kawasaki wrote:
>>>>>> I observed that the blktests test case block/005 hangs on a specific
>>>>>> server hardware using a specific HDD as a block device. During the test
>>>>>> case run, the kernel reported a KASAN null-ptr-deref (and other memory
>>>>>> corruption symptoms) [2]. This failure looked sporadic and hardware-
>>>>>> dependent.
>>>>>>
>>>>>>   From the kernel message, I noticed that udev-worker wrote to the
>>>>>> queue/scheduler sysfs attribute to change the IO scheduler, or elevator.
>>>>>> The test case block/005 also wrote to the same sysfs attribute, which
>>>>>
>>>>> sysfs write is supposed to be serialized...
>>>>
>>>> I checked the sysfs write handler elv_iosched_store() in block/elevator.c.
>>>> I found elevator_change() call is guarded with the rw_semaphore
>>>> "set->update_nr_hwq_lock", but the guard is not the writer lock but the reader
>>>> lock. This does not serialize the sysfs writes.
>>>
>>> Please see kernfs_fop_write_iter(), in which mutex is held before calling
>>> ->write().
>>>
>> I think you're referring to @of->mutex here; however of->mutex is per struct
>> kernfs_open_file, which is associated with an open instance of the sysfs file.
>> The important point is that two separate opens can have different kernfs_open_file
>> instances and therefore different mutexes. Thus, concurrent write to same sysfs
>> attribute from two different processes may still be possible.
> 
> Thanks Nilay, I added debug prints to print @of->mutex address, and it observed
> the address is different for each process and each file open. So, I don't think
> sysfs write is serialized.
> 
>>
>>
>>>>
>>>> I tried the patch below to replace the reader lock with the writer lock. With
>>>> a quick trial, it looks working. The kernel message is no longer observed and
>>>> the new test case does not cause hangs. I will do further testing to confirm
>>>> that this change does not trigger other new lockdep WARNs. Assuming it does not
>>>> have such side effects, I hope this fix approach is acceptable. It doesn't add
>>>> the new lock, so I think it's the better.
>>>>
>>>> diff --git a/block/elevator.c b/block/elevator.c
>>>> index 3bcd37c2aa34..b03185a217ff 100644
>>>> --- a/block/elevator.c
>>>> +++ b/block/elevator.c
>>>> @@ -813,7 +813,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>>>>    	 *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
>>>>    	 *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
>>>>    	 */
>>>> -	if (!down_read_trylock(&set->update_nr_hwq_lock)) {
>>>> +	if (!down_write_trylock(&set->update_nr_hwq_lock)) {
>>>>    		ret = -EBUSY;
>>>>    		goto out;
>>>>    	}
>>>> @@ -824,7 +824,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>>>>    	} else {
>>>>    		ret = -ENOENT;
>>>>    	}
>>>> -	up_read(&set->update_nr_hwq_lock);
>>>> +	up_write(&set->update_nr_hwq_lock);
>>>>    out:
>>>>    	if (ctx.type)
>>>>
>>>> [...]
>>>>
>>>>> blk_mq_sched_reg_debugfs already includes debugfs lock, so I feel the proper
>>>>> fix could be check & avoid the null-ptr-deref.
>>>>
>>>> Actually, null-ptr-deref is one of the failure symptoms. KASAN slab-user-after
>>>> free is also observed [3]. Then I'm guessing adding null checks may not be
>>>> enough.
>>>>
>>>>> Adding new lock should be the last straw usually, especially this one is
>>>>> depended by queue freeze.
>>>>
>>>> Got it, thanks.
>>>>
>>>>
>>>> [3] KASAN slab-use-after-free
>>>
>>> Then you need to figure out the exact slab type and check if the pointer is cleared
>>> during free.
>>>
>>> Anyway, there is guard already, not see reason to add new lock for covering
>>> it.
>>>
>> Regarding the observed failure, my understanding is that blk_mq_debugfs_register_sched()
>> and blk_mq_debugfs_register_sched_hctx() access q->elevator without holding q->elevator_lock.
>> If multiple scheduler update paths run concurrently, one path can replace and free the
>> elevator while another path is still using it, which would explain the observed KASAN
>> use-after-free and NULL pointer dereference reports.
> 
> I have the same view. I think the use-after-free and the null-ptr-deref indicate
> that elevator_queue object address in q->elevator is the problem. The references
> of the object is also kept in the struct elv_change_ctx as ctx->old and
> ctx->new. These multiple references are used concurrently, then I'm not sure if
> adding pointer clears and null checks would fix the problem.
> 
>>
>> With the proposed change, upgrading update_nr_hwq_lock from a reader lock to a writer
>> lock in elv_iosched_store() would serialize concurrent scheduler updates and therefore
>> prevent multiple elevator switch operations from running at the same time.
>>
>> The another way to fix this might be to acquire q->elevator_lock in blk_mq_sched_reg_debugfs()
>> and thus serialize access to q->elevator in blk_mq_debugfs_register_sched() and
>> blk_mq_debugfs_register_sched_hctx().
> 
> Thanks for the idea. I tried the patch below [X], but it triggered WARN in
> debugfs_create_files() in block/blk-mq-debufs.c [Y]. Then I'm afraid, this
> approach does not look working.
> 
> At this moment, the writer lock in elv_iosched_store() looks like the solution
> to me, but further comments on other solution possibility will be welcomed.
> 
> 
> [X]
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 0a00f5a76f5a..12c582b6c713 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -394,9 +394,11 @@ void blk_mq_sched_reg_debugfs(struct request_queue *q)
>   	unsigned long i;
>   
>   	memflags = blk_debugfs_lock(q);
> +	mutex_lock(&q->elevator_lock);
>   	blk_mq_debugfs_register_sched(q);
>   	queue_for_each_hw_ctx(q, hctx, i)
>   		blk_mq_debugfs_register_sched_hctx(q, hctx);
> +	mutex_unlock(&q->elevator_lock);
>   	blk_debugfs_unlock(q, memflags);
>   }
>   
> 
> [Y]
> 
>   612 static void debugfs_create_files(struct request_queue *q, struct dentry *parent,|
>   613                                  void *data,                                    |
>   614                                  const struct blk_mq_debugfs_attr *attr)        |
>   615 {                                                                               |
>   616         lockdep_assert_held(&q->debugfs_mutex);                                 |
>   617         /*                                                                      |
>   618          * debugfs_mutex should not be nested under other locks that can be     |
>   619          * grabbed while queue is frozen.                                       |
>   620          */                                                                     |
>   621         lockdep_assert_not_held(&q->elevator_lock);                             | <----
>   622         lockdep_assert_not_held(&q->rq_qos_mutex);                              |
>   623                                                                                 |
> 

Yeah, I recall that assertion was added to avoid potential circular lockdep dependencies
when reclaim recurses back into the block layer. The concern is that ->elevator_lock and
  ->rq_qos_mutex can be acquired in code paths after the queue has been frozen. Consider
a scenario where one task freezes the queue and then attempts to acquire ->elevator_lock,
while another task already holds ->elevator_lock and subsequently triggers memory reclaim.
If reclaim recurses into the block layer, it may require forward progress on the same
frozen queue, which cannot happen until the freeze is lifted. This creates a circular
dependency involving queue freeze, reclaim, and ->elevator_lock (or ->rq_qos_mutex).

Given the above, I'm fine with the earlier approach of upgrading update_nr_hwq_lock from
a reader lock to a writer lock in elv_iosched_store(). That directly serializes concurrent
scheduler updates and avoids the race on q->elevator without introducing additional lock
ordering concerns.

Thanks,
--Nilay
