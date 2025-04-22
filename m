Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53281F4CBC
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745314041; cv=none; b=qjqZYt8Xm6FChuc2Vl63ZNTotb1h2Fu0tkQsaWgn64Nw9r0ie13vjB3A7Ui1jLVmEJI11KkEMUuvpf7siOkGaHW2x849JqYMSIeCoFhckg8NkThcgSuYBXmWvEJ73IqqKLxMSGbzLF03CzH5sMDaO3krDXjuUtyqfDxe8Rv1tZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745314041; c=relaxed/simple;
	bh=ZWftxP4AejusnD/C0iul7XcZji/8v471XK6/eBOI9WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKLQRNvwQHhIB0crFnJ0w0Lho+1uHWBi8J4niPUP12Pfq7uAWTNc4YKKwdR/Z7zGCTuD9Mll8oooH0tsaSAKJEitNbthjLmg8m2ztHca9tOmSFbRccHYg6wuxzAPCNsJO2qt6/plxBjDRdMB3D6RKwqdaf0gSlQLakUqzlYZUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cJJe2i65; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cJJe2i65"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M8bWbY007669;
	Tue, 22 Apr 2025 09:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zJUR82
	pITx5xoLCtkvzSv5Bdttrt92NfFcNzrmN4Oas=; b=cJJe2i65dtjwXo1ic87UXk
	avOF0spPWsBJnjpO7d6LaBMLmpuJnBXJjvjwWI5T454eiygcGgb6KLSMlFFEgI9n
	CWiux/0CIdeuNmr0aWdenwC6GPIY/uvJ7YZeCqTmZ+IF2oxi/M7XFT4pq44BUKwy
	K4mHJt3N27vSTIZL8vuQZS8LrkZVYOcvy1Hp7h5F90S7hqwhP/gJyk+quZqEtJMl
	/eEHV7e6PMkLgCk5jtKuy/tqDP4pY+80FLWYOBoXj+6LBlet2KWJwPLx0rmj15NC
	N70pwL8jRzTnGBbrUwxHBRiQK39dXtYJT2CtdLAoRFebo/a3XMNEVcsJu6C+Cg1w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4667rq87cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 09:27:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53M5pvtP032541;
	Tue, 22 Apr 2025 09:27:07 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 464phyjc2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 09:27:07 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53M9R6S524314574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 09:27:06 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3648358045;
	Tue, 22 Apr 2025 09:27:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D66A58050;
	Tue, 22 Apr 2025 09:27:03 +0000 (GMT)
Received: from [9.43.46.43] (unknown [9.43.46.43])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Apr 2025 09:27:02 +0000 (GMT)
Message-ID: <8c07d251-bafc-4601-b14d-5771c4615703@linux.ibm.com>
Date: Tue, 22 Apr 2025 14:57:01 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 20/20] block: move wbt_enable_default() out of queue
 freezing from sched ->exit()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-21-ming.lei@redhat.com>
 <261d7b81-e611-47f4-ad55-6f7716c278c7@linux.ibm.com>
 <aAXzToqtIlAoUP7t@fedora>
 <286f9d0e-b782-4062-b0eb-cba6fa81e388@linux.ibm.com>
 <aAdPn-47ctywQGIT@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aAdPn-47ctywQGIT@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7TEij9kgy8QMwBjLxPSKyYezYBM9oAnz
X-Proofpoint-ORIG-GUID: 7TEij9kgy8QMwBjLxPSKyYezYBM9oAnz
X-Authority-Analysis: v=2.4 cv=D59HKuRj c=1 sm=1 tr=0 ts=680760eb cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=LXY3n85dFm4ncY1G1qQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220067



On 4/22/25 1:43 PM, Ming Lei wrote:
> On Tue, Apr 22, 2025 at 11:44:59AM +0530, Nilay Shroff wrote:
>>
>>
>> On 4/21/25 12:57 PM, Ming Lei wrote:
>>> On Sat, Apr 19, 2025 at 08:09:04PM +0530, Nilay Shroff wrote:
>>>>
>>>>
>>>> On 4/18/25 10:07 PM, Ming Lei wrote:
>>>>> scheduler's ->exit() is called with queue frozen and elevator lock is held, and
>>>>> wbt_enable_default() can't be called with queue frozen, otherwise the
>>>>> following lockdep warning is triggered:
>>>>>
>>>>> 	#6 (&q->rq_qos_mutex){+.+.}-{4:4}:
>>>>> 	#5 (&eq->sysfs_lock){+.+.}-{4:4}:
>>>>> 	#4 (&q->elevator_lock){+.+.}-{4:4}:
>>>>> 	#3 (&q->q_usage_counter(io)#3){++++}-{0:0}:
>>>>> 	#2 (fs_reclaim){+.+.}-{0:0}:
>>>>> 	#1 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}:
>>>>> 	#0 (&q->debugfs_mutex){+.+.}-{4:4}:
>>>>>
>>>>> Fix the issue by moving wbt_enable_default() out of bfq's exit(), and
>>>>> call it from elevator_change_done().
>>>>>
>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>> ---
>>>>>  block/bfq-iosched.c | 2 +-
>>>>>  block/elevator.c    | 5 +++++
>>>>>  block/elevator.h    | 1 +
>>>>>  3 files changed, 7 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>>>> index 40e4106a71e7..310ce1d8c41e 100644
>>>>> --- a/block/bfq-iosched.c
>>>>> +++ b/block/bfq-iosched.c
>>>>> @@ -7211,7 +7211,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
>>>>>  
>>>>>  	blk_stat_disable_accounting(bfqd->queue);
>>>>>  	blk_queue_flag_clear(QUEUE_FLAG_DISABLE_WBT, bfqd->queue);
>>>>> -	wbt_enable_default(bfqd->queue->disk);
>>>>> +	set_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT, &e->flags);
>>>>>  
>>>>>  	kfree(bfqd);
>>>>>  }
>>>>> diff --git a/block/elevator.c b/block/elevator.c
>>>>> index 8652fe45a2db..378553fce5d8 100644
>>>>> --- a/block/elevator.c
>>>>> +++ b/block/elevator.c
>>>>> @@ -687,8 +687,13 @@ int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx)
>>>>>  	int ret = 0;
>>>>>  
>>>>>  	if (ctx->old) {
>>>>> +		bool enable_wbt = test_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT,
>>>>> +				&ctx->old->flags);
>>>>> +
>>>>>  		elv_unregister_queue(q, ctx->old);
>>>>>  		kobject_put(&ctx->old->kobj);
>>>>> +		if (enable_wbt)
>>>>> +			wbt_enable_default(q->disk);
>>>>>  	}
>>>>>  	if (ctx->new) {
>>>>>  		ret = elv_register_queue(q, ctx->new, ctx->uevent);
>>>>> diff --git a/block/elevator.h b/block/elevator.h
>>>>> index 486be0690499..b14c611c74b6 100644
>>>>> --- a/block/elevator.h
>>>>> +++ b/block/elevator.h
>>>>> @@ -122,6 +122,7 @@ struct elevator_queue
>>>>>  
>>>>>  #define ELEVATOR_FLAG_REGISTERED	0
>>>>>  #define ELEVATOR_FLAG_DYING		1
>>>>> +#define ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT	2
>>>>>  
>>>>>  /* Holding context data for changing elevator */
>>>>>  struct elv_change_ctx {
>>>>
>>>> It seems invoking wbt_enable_default from elevator_change_done could probably
>>>> still race with ioc_qos_write or queue_wb_lat_store. Both ioc_qos_write and 
>>>> queue_wb_lat_store run with ->freeze_lock and ->elevator_lock protection.
>>>
>>> Actually wbt_enable_default() and wbt_init() needn't the above protection,
>>> especially since the patch 2/20 removes q->elevator use in
>>> wbt_enable_default().
>>>
>> Yes agreed, and as I understand XXX_FLAG_DISABLE_WBT was earlier elevator_queue->flags 
>> but now (with patch 2/20) it has been moved to request_queue->flags. As elevator_change_done 
>> first puts elevator_queue object which would potentially releases/frees the  elevator_queue 
>> object. Next while we enable wbt (in elevator_change_done)  we may not have access to the 
>> elevator_queue object and so now we reference  QUEUE_FLAG_DISABLE_WBT using request_queue->flags. 
>> That's, I believe, the purpose of patch 2/20.
>>
>> However even with patch 2/20 change, both elevator_change_done and ioc_qos_write or
>> queue_wb_lat_store may run in parallel, isn't it?
>>
>> therad1:
>> blk_mq_update_nr_hw_queues
>>   -> __blk_mq_update_nr_hw_queues
>>     -> elevator_change_done
>>       -> wbt_enable_default
>>         -> wbt_init
>>          -> wbt_update_limits
> 
> Here wbt_update_limits() is called on un-attached `struct rq_wb` instance,
> which is just allocated from heap.
> 
>>
>> therad2:
>> queue_wb_lat_store
>>   -> wbt_set_min_lat
>>    -> wbt_update_limits
> 
> The above one is run on attached `struct rq_wb` instance.
> 
> And there can only be one attached `struct rq_wb` instance, so the above
> race doesn't exist because attaching wbt to queue/disk is covered by `q->rq_qos_mutex`.
> 
Yes you were correct, however, what if throttling is already enabled/attached to 
the queue? In that case we'd race updating rq_wb->enable_state, no? For instance,

thread1:
blk_mq_update_nr_hw_queues
  -> elevator_change_done
    -> wbt_enable_default ==> (updates ->enable_state)

thread2: 
queue_wb_lat_store
  -> wbt_set_min_lat ==> (updates ->enable_state)

thread3:
ioc_qos_write
  -> wbt_disable_default ==> (updates ->enable_state)

Thanks,
--Nilay
