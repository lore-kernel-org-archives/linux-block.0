Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89891B043A
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530752; cv=none; b=S+zRgAEviez4lcUgtyOm7T2R/MeIRyuKAt8tFaOiLxi4G6my/O0DWXoV9QTn1oFBixNdHC7QfJ++ryF0GCnmPymnRIqtnqJZ6TQg2bR7ZE/68QUhQW4gti5pJOfjsCsd7PyIhDlhfH6bWSSy59GjxsAVLLsZblXdT9RmhFsimtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530752; c=relaxed/simple;
	bh=POUHfU1M+foAw9yypt/16Cc/3wV/6CGEcW5vDwh5T/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aURcnWdwZCpAWQ54HYgR6H2Svfg1YsctvrSVlI/gwZekiCxs8vpH2lA2/WbXqhTQo4pYc8kExXNxfImOXPuIXys3jQd5FWIr2C74f2sBKILjp/oFqIMxG/eGucGzHgrkG6TRgOOXRDPAWQ85lC2omyBwzRkhZUdKVlXdsh+wci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vz6hLCFz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vz6hLCFz"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIE2mk6029644;
	Wed, 18 Dec 2024 14:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DD1Zb2
	0RIHStWtCmA5cjzdO6EP5VavSuwyn152rFvGY=; b=Vz6hLCFzcU/l7ko6xE9rUy
	Qj1y0y2t0StNgwfjGboXN3vIRdirTjIXyXbvZkQE9E5b6zONk8nVWcGC0QMfMzdt
	TeQqp3mBbp/iwSzGUx6yipDBgd//CMFEkLgfK13M8TlPz8JbwtXlqFH3PCO2OOZa
	NIYC3PWsGAgFKHCPGANCQXJH71T++pOqHLeZm8cdcBLNXkx+eF9AZWUD+jgApDp/
	Nof54KxgDVqlejh2W51pM6vcdgEnh/uV0Tc8JAvP/yZ8xl+sFOwSpg1cdFwBag71
	r1n3loM249tWnRoo18cKE3spIcY4lIU98ejk8TWOERUsHJxlOP2ASw9FPJrCOqVw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kpvbak3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 14:05:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIC46qU005501;
	Wed, 18 Dec 2024 14:05:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbn86fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 14:05:40 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIE5d4l28049936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 14:05:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C81AC5805E;
	Wed, 18 Dec 2024 14:05:39 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 117EE5805D;
	Wed, 18 Dec 2024 14:05:38 +0000 (GMT)
Received: from [9.109.198.241] (unknown [9.109.198.241])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Dec 2024 14:05:37 +0000 (GMT)
Message-ID: <0fdf7af6-9401-4853-8536-4295a614e6d2@linux.ibm.com>
Date: Wed, 18 Dec 2024 19:35:36 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs for
 atomic update queue limits
To: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20241216080206.2850773-2-ming.lei@redhat.com>
 <20241216154901.GA23786@lst.de> <Z2DZc1cVzonHfMIe@fedora>
 <20241217044056.GA15764@lst.de> <Z2EizLh58zjrGUOw@fedora>
 <20241217071928.GA19884@lst.de> <Z2Eog2mRqhDKjyC6@fedora>
 <a032a3a0-0784-4260-92fd-90feffe1fe20@kernel.org> <Z2Iu1CAAC-nE-5Av@fedora>
 <f34f179a-4eaf-4f73-93ff-efb1ff9fe482@linux.ibm.com>
 <Z2LQ0PYmt3DYBCi0@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z2LQ0PYmt3DYBCi0@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8YfB3FbK6BfxBcRDwCq3bgkIclvC1i7t
X-Proofpoint-ORIG-GUID: 8YfB3FbK6BfxBcRDwCq3bgkIclvC1i7t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180109



On 12/18/24 19:10, Ming Lei wrote:
> On Wed, Dec 18, 2024 at 05:03:00PM +0530, Nilay Shroff wrote:
>>
>>
>> On 12/18/24 07:39, Ming Lei wrote:
>>> On Tue, Dec 17, 2024 at 08:07:06AM -0800, Damien Le Moal wrote:
>>>> On 2024/12/16 23:30, Ming Lei wrote:
>>>>> On Tue, Dec 17, 2024 at 08:19:28AM +0100, Christoph Hellwig wrote:
>>>>>> On Tue, Dec 17, 2024 at 03:05:48PM +0800, Ming Lei wrote:
>>>>>>> On Tue, Dec 17, 2024 at 05:40:56AM +0100, Christoph Hellwig wrote:
>>>>>>>> On Tue, Dec 17, 2024 at 09:52:51AM +0800, Ming Lei wrote:
>>>>>>>>> The local copy can be updated in any way with any data, so does another
>>>>>>>>> concurrent update on q->limits really matter?
>>>>>>>>
>>>>>>>> Yes, because that means one of the updates get lost even if it is
>>>>>>>> for entirely separate fields.
>>>>>>>
>>>>>>> Right, but the limits are still valid anytime.
>>>>>>>
>>>>>>> Any suggestion for fixing this deadlock?
>>>>>>
>>>>>> What is "this deadlock"?
>>>>>
>>>>> The commit log provides two reports:
>>>>>
>>>>> - lockdep warning
>>>>>
>>>>> https://lore.kernel.org/linux-block/Z1A8fai9_fQFhs1s@hovoldconsulting.com/
>>>>>
>>>>> - real deadlock report
>>>>>
>>>>> https://lore.kernel.org/linux-scsi/ZxG38G9BuFdBpBHZ@fedora/
>>>>>
>>>>> It is actually one simple ABBA lock:
>>>>>
>>>>> 1) queue_attr_store()
>>>>>
>>>>>       blk_mq_freeze_queue(q);					//queue freeze lock
>>>>>       res = entry->store(disk, page, length);
>>>>> 	  			queue_limits_start_update		//->limits_lock
>>>>> 				...
>>>>> 				queue_limits_commit_update
>>>>>       blk_mq_unfreeze_queue(q);
>>>>
>>>> The locking + freeze pattern should be:
>>>>
>>>> 	lim = queue_limits_start_update(q);
>>>> 	...
>>>> 	blk_mq_freeze_queue(q);
>>>> 	ret = queue_limits_commit_update(q, &lim);
>>>> 	blk_mq_unfreeze_queue(q);
>>>>
>>>> This pattern is used in most places and anything that does not use it is likely
>>>> susceptible to a similar ABBA deadlock. We should probably look into trying to
>>>> integrate the freeze/unfreeze calls directly into queue_limits_commit_update().
>>>>
>>>> Fixing queue_attr_store() to use this pattern seems simpler than trying to fix
>>>> sd_revalidate_disk().
>>>
>>> This way looks good, just commit af2814149883 ("block: freeze the queue in
>>> queue_attr_store") needs to be reverted, and freeze/unfreeze has to be
>>> added to each queue attribute .store() handler.
>>>
>> Wouldn't it be feasible to add blk-mq freeze in queue_limits_start_update()
>> and blk-mq unfreeze in queue_limits_commit_update()? If we do this then 
>> the pattern would be, 
>>
>> queue_limits_start_update(): limit-lock + freeze
>> queue_limits_commit_update() : unfreeze + limit-unlock  
>>
>> Then in queue_attr_store() we shall just remove freeze/unfreeze.
>>
>> We also need to fix few call sites where we've code block,
>>
>> {
>>     blk_mq_freeze_queue()
>>     ...
>>     queue_limits_start_update()
>>     ...    
>>     queue_limits_commit_update()
>>     ...
>>     blk_mq_unfreeze_queue()
>>     
>> }
>>
>> In the above code block, we may then replace blk_mq_freeze_queue() with
>> queue_limits_commit_update() and similarly replace blk_mq_unfreeze_queue() 
>> with queue_limits_commit_update().
>>
>> {
>>     queue_limits_start_update()
>>     ...
>>     ...
>>     ...
>>     queue_limits_commit_update()
> 
> In sd_revalidate_disk(), blk-mq request is allocated under queue_limits_start_update(),
> then ABBA deadlock is triggered since blk_queue_enter() implies same lock(freeze lock)
> from blk_mq_freeze_queue().
> 
Yeah agreed but I see sd_revalidate_disk() is probably the only exception 
which allocates the blk-mq request. Can't we fix it? 

One simple way I could think of would be updating queue_limit_xxx() APIs and
then use it,

queue_limits_start_update(struct request_queue *q, bool freeze) 
{
    ...
    mutex_lock(&q->limits_lock);
    if(freeze)
        blk_mq_freeze_queue(q);
    ...
}

queue_limits_commit_update(struct request_queue *q,
		struct queue_limits *lim, bool unfreeze)
{
    ...
    ...
    if(unfreeze)
        blk_mq_unfreeze_queue(q);
    mutex_unlock(&q->limits_lock);
}

sd_revalidate_disk()
{
    ...
    ...
    queue_limits_start_update(q, false);

    ...
    ...

    blk_mq_freeze_queue(q);
    queue_limits_commit_update(q, lim, true);        
}

Thanks,
--Nilay

