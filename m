Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3810815F330
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744189939; cv=none; b=KsjpsQ9H9Vj4kJxAXwMHphDXyohZYVzRfad2hrrA+BXnK+57O77YPNS+CDI4H3KYlsPExTyS1DOS7E+aMYMt20l1D6KFjGQPMcMXXhBh4mnxLj90J4la8tuhIc8ypqYSN9WJnlASUWElDcDZi49ltUm2ToaIMSW7AkvJmva2p5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744189939; c=relaxed/simple;
	bh=wRVytjQdH+IOr5QZo+8ojkPWz7nMwShRpp0ddRhJyUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cir+cH5j3zrXf/fGUgs+mDNq7tV7IAvu96vxfdXCHe4NRPk/d4BuBcjQjdgjqS56QnGE6UAsJRSTvdtSPHOj06cP3ePu2jjDDJsageHtqbucOw4LTeOkTC/hBHxY8CYkMtZnC6exbqhfH2WMFR5RXuXkiR/Rv+HelDVH24GJDnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ErvoxCDg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ErvoxCDg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5399AcFF024819;
	Wed, 9 Apr 2025 09:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tpxcw+
	9mzU8cyc0FEJB12rMJLXqmjiRDjG4X06gUU98=; b=ErvoxCDgAQC3rNqYm4T60c
	PcQ/XkWRGDPFmv/qkQmFZRJwaAizpraKgO4dHOLwot+jd8uQLlMDhmUVvrpjnE2c
	V8oSmXzRDylAN3TRJvNJPjTffUY2XR0AYCWlYps3v5IKmTftz5Jmp0UeVe7BMDrR
	+i+6vYTrLipvHguBXliHFIq07YQH+31CUY2G860sHPrt/NK8gp2n5s97PXKeiSNb
	6CxlQ0Yxwj7Hn02vFxdFR0hJ5unzTYHTHFWj8+eXYpgfb3+7HyxbiTi42ZuNTndz
	iIJFqhuvMGg9Rt/upY9TryD7+7PB7maPlt7jLHSiXn4MxjCylXNMKT8/oMRb6CRw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wb10jk89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 09:12:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5395VDmb013932;
	Wed, 9 Apr 2025 09:12:10 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunpxa4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 09:12:10 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5399C95P30606040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 09:12:09 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8951B58052;
	Wed,  9 Apr 2025 09:12:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE02E58056;
	Wed,  9 Apr 2025 09:12:07 +0000 (GMT)
Received: from [9.171.27.28] (unknown [9.171.27.28])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 09:12:07 +0000 (GMT)
Message-ID: <ff08d88c-4680-40be-890a-19191e019419@linux.ibm.com>
Date: Wed, 9 Apr 2025 14:42:06 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't grab elevator lock during queue
 initialization
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
References: <20250403105402.1334206-1-ming.lei@redhat.com>
 <20250404091037.GB12163@lst.de>
 <92feba7e-84fc-4668-92c3-aba4e8320559@linux.ibm.com>
 <Z_NB2VA9D5eqf0yH@fedora>
 <ea09ea46-4772-4947-a9ad-195e83f1490d@linux.ibm.com>
 <Z_TSYOzPI3GwVms7@fedora>
 <c2c9e913-1c24-49c7-bfc5-671728f8dddc@linux.ibm.com>
 <Z_UpoiWlBnwaUW7B@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z_UpoiWlBnwaUW7B@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3C7WqC12Cb2ThLydGvEEFETpiahC8K0e
X-Proofpoint-GUID: 3C7WqC12Cb2ThLydGvEEFETpiahC8K0e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_03,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090046



On 4/8/25 7:20 PM, Ming Lei wrote:
> On Tue, Apr 08, 2025 at 06:55:26PM +0530, Nilay Shroff wrote:
>>
>>
>> On 4/8/25 1:08 PM, Ming Lei wrote:
>>> On Mon, Apr 07, 2025 at 01:59:48PM +0530, Nilay Shroff wrote:
>>>>
>>>>
>>>> On 4/7/25 8:39 AM, Ming Lei wrote:
>>>>> On Sat, Apr 05, 2025 at 07:44:19PM +0530, Nilay Shroff wrote:
>>>>>>
>>>>>>
>>>>>> On 4/4/25 2:40 PM, Christoph Hellwig wrote:
>>>>>>> On Thu, Apr 03, 2025 at 06:54:02PM +0800, Ming Lei wrote:
>>>>>>>> Fixes the following lockdep warning:
>>>>>>>
>>>>>>> Please spell the actual dependency out here, links are not permanent
>>>>>>> and also not readable for any offline reading of the commit logs.
>>>>>>>
>>>>>>>> +static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>>>>>>>> +				   struct request_queue *q, bool lock)
>>>>>>>> +{
>>>>>>>> +	if (lock) {
>>>>>>>
>>>>>>> bool lock(ed) arguments are an anti-pattern, and regularly get Linus
>>>>>>> screaming at you (in this case even for the right reason :))
>>>>>>>
>>>>>>>> +		/* protect against switching io scheduler  */
>>>>>>>> +		mutex_lock(&q->elevator_lock);
>>>>>>>> +		__blk_mq_realloc_hw_ctxs(set, q);
>>>>>>>> +		mutex_unlock(&q->elevator_lock);
>>>>>>>> +	} else {
>>>>>>>> +		__blk_mq_realloc_hw_ctxs(set, q);
>>>>>>>> +	}
>>>>>>>
>>>>>>> I think the problem here is again that because of all the other
>>>>>>> dependencies elevator_lock really needs to be per-set instead of
>>>>>>> per-queue which will allows us to have much saner locking hierarchies.
>>>>>>>
>>>>>> I believe you meant here q->tag_set->elevator_lock? 
>>>>>
>>>>> I don't know what locks you are planning to invent.
>>>>>
>>>>> For set->tag_list_lock, it has been very fragile:
>>>>>
>>>>> blk_mq_update_nr_hw_queues
>>>>> 	set->tag_list_lock
>>>>> 		freeze_queue
>>>>>
>>>>> If IO failure happens when waiting in above freeze_queue(), the nvme error
>>>>> handling can't provide forward progress any more, because the error
>>>>> handling code path requires set->tag_list_lock.
>>>>
>>>> I think you're referring here nvme_quiesce_io_queues and nvme_unquiesce_io_queues
>>>
>>> Yes.
>>>
>>>> which is called in nvme error handling path. If yes then I believe this function 
>>>> could be easily modified so that it doesn't require ->tag_list_lock. 
>>>
>>> Not sure it is easily, ->tag_list_lock is exactly for protecting the list of "set->tag_list".
>>>
>> Please see this, here nvme_quiesce_io_queues doen't require ->tag_list_lock:
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 777db89fdaa7..002d2fd20e0c 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -5010,10 +5010,19 @@ void nvme_quiesce_io_queues(struct nvme_ctrl *ctrl)
>>  {
>>         if (!ctrl->tagset)
>>                 return;
>> -       if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>> -               blk_mq_quiesce_tagset(ctrl->tagset);
>> -       else
>> -               blk_mq_wait_quiesce_done(ctrl->tagset);
>> +       if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags)) {
>> +               struct nvme_ns *ns;
>> +               int srcu_idx;
>> +
>> +               srcu_idx = srcu_read_lock(&ctrl->srcu);
>> +               list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
>> +                               srcu_read_lock_held(&ctrl->srcu)) {
>> +                       if (!blk_queue_skip_tagset_quiesce(ns->queue))
>> +                               blk_mq_quiesce_queue_nowait(ns->queue);
>> +               }
>> +               srcu_read_unlock(&ctrl->srcu, srcu_idx);
>> +       }
>> +       blk_mq_wait_quiesce_done(ctrl->tagset);
>>  }
>>  EXPORT_SYMBOL_GPL(nvme_quiesce_io_queues);
>>
>> Here we iterate through ctrl->namespaces instead of relying on tag_list
>> and so we don't need to acquire ->tag_list_lock.
> 
> How can you make sure all NSs are covered in this way? RCU/SRCU can't
> provide such kind of guarantee.
> 
Why is that so? In fact, nvme_wait_freeze also iterates through 
the same ctrl->namespaces to freeze the queue.

>>
>>> And the same list is iterated in blk_mq_update_nr_hw_queues() too.
>>>
>>>>
>>>>>
>>>>> So all queues should be frozen first before calling blk_mq_update_nr_hw_queues,
>>>>> fortunately that is what nvme is doing.
>>>>>
>>>>>
>>>>>> If yes then it means that we should be able to grab ->elevator_lock
>>>>>> before freezing the queue in __blk_mq_update_nr_hw_queues and so locking
>>>>>> order should be in each code path,
>>>>>>
>>>>>> __blk_mq_update_nr_hw_queues
>>>>>>     ->elevator_lock 
>>>>>>       ->freeze_lock
>>>>>
>>>>> Now tagset->elevator_lock depends on set->tag_list_lock, and this way
>>>>> just make things worse. Why can't we disable elevator switch during
>>>>> updating nr_hw_queues?
>>>>>
>>>> I couldn't quite understand this. As we already first disable the elevator
>>>> before updating sw to hw queue mapping in __blk_mq_update_nr_hw_queues().
>>>> Once mapping is successful we switch back the elevator.
>>>
>>> Yes, but user still may switch elevator from none to others during the
>>> period, right?
>>>
>> Yes correct, that's possible. So your suggestion was to disable elevator
>> update while we're running __blk_mq_update_nr_hw_queues? And that way user
>> couldn't update elevator through sysfs (elv_iosched_store) while we update
>> nr_hw_queues? If this is true then still how could it help solve lockdep
>> splat? 
> 
> Then why do you think per-set lock can solve the lockdep splat?
> 
> __blk_mq_update_nr_hw_queues is the only chance for tagset wide queues
> involved wrt. switching elevator. If elevator switching is not allowed
> when __blk_mq_update_nr_hw_queues() is started, why do we need per-set
> lock?
> 
Yes if elevator switch is not allowed then we probably don't need per-set lock. 
However my question was if we were to not allow elevator switch while 
__blk_mq_update_nr_hw_queues is running then how would we implement it?
Do we need to synchronize with ->tag_list_lock? Or in another words,
elv_iosched_store would now depends on ->tag_list_lock ? 

On another note, if we choose to make ->elevator_lock per-set then 
our locking sequence in blk_mq_update_nr_hw_queues() would be,

blk_mq_update_nr_hw_queues
  -> tag_list_lock
    -> elevator_lock
     -> freeze_lock 

elv_iosched_store
  -> elevator_lock
    -> freeze_lock

So now ->freeze_lock should not depend on ->elevator_lock and that shall
help avoid few of the recent lockdep splats reported with fs_reclaim.
What do you think?

Thanks,
--Nilay
 






