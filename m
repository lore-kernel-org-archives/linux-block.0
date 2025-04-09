Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623EC12CDAE
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206381; cv=none; b=bOtjEMXflegVLb3ZAfxWLIT5xsqKZgOiateEFTX4Hi0rhhkenOh/6Lv3rFLf4z/VW4A2xLXGvCpqDo6NQG+DVL+JTJrwe+jzAan2v54lL9ZPNExUCcBPgehE6mer29yLVWDTiuNo4qfoYPGK/NvCzOpyLFiJssFAfUx5hRVhMBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206381; c=relaxed/simple;
	bh=0NqAlFblxZkPU6tG/jtdxeXUjsMmIk+DPp6ULCUOOwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8VmrxDGoUmOLgxXkCm4/ieMWL2Mgwl5UuN+IzU5I6xBFgHqjxr3bfKj770MCtkxvYUP2fbuxqwlUYMTQKqtZJBEAIjEf8gX6t1y+6VbLRlqs7sB0tL5YwrXGMUYC9Tj3NGpGAycp9dPAZD8Y6zxHDC8vW2M19fzh28Ylvn7Uxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eSmq9dlV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eSmq9dlV"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539A5Os2013935;
	Wed, 9 Apr 2025 13:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oiYhn/
	a6PEWhwLu2LPH1/5wYs7u9w75Vg1LyUDcqi7k=; b=eSmq9dlVnQsqhhLoU0DoWc
	i0eJ53C8BJJU5NJb1qPD+0DKEIdm41kbJ69VnjZ3C5UU9k6+rPH2qyQct5s7OFn3
	fZfDQiP48PpGuUHDZeVO4gCH6//f1AxhDirm7FQdDcT+qwfNSzvIgxU9k3DsSDvX
	hIX8bl5yWobxJ9i+PxEtmqnRkPEScTXUe1FoRLuRFAOGHIywamllxlJ/AxX3Pugx
	T6Al+5VjoDCnHJP8P2rCyH5/7l4uDI8iAm7/Bo/pV2N3nPPqG27qKN7qedPCPf4e
	tevJtxpw+9N1GkNxq9KW/EA/2vuNkNbtJkmXKmDS9nwPlX9FX15uM4piOK2xFSDw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w57px4dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 13:46:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539A9lXo017447;
	Wed, 9 Apr 2025 13:46:08 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2kqqxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 13:46:08 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539Dk7JH262752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 13:46:07 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BBC55805F;
	Wed,  9 Apr 2025 13:46:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84D7858068;
	Wed,  9 Apr 2025 13:46:05 +0000 (GMT)
Received: from [9.171.27.28] (unknown [9.171.27.28])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 13:46:05 +0000 (GMT)
Message-ID: <03ba309d-b266-4596-83aa-1731c6cc1cfb@linux.ibm.com>
Date: Wed, 9 Apr 2025 19:16:03 +0530
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
 <ff08d88c-4680-40be-890a-19191e019419@linux.ibm.com>
 <Z_ZeEXyLLzrYcN3b@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z_ZeEXyLLzrYcN3b@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sKqk6TXWTF3uwnGRe0VEcIcfNDdEVa1q
X-Proofpoint-GUID: sKqk6TXWTF3uwnGRe0VEcIcfNDdEVa1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090082



On 4/9/25 5:16 PM, Ming Lei wrote:
>>>>> Not sure it is easily, ->tag_list_lock is exactly for protecting the list of "set->tag_list".
>>>>>
>>>> Please see this, here nvme_quiesce_io_queues doen't require ->tag_list_lock:
>>>>
>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>> index 777db89fdaa7..002d2fd20e0c 100644
>>>> --- a/drivers/nvme/host/core.c
>>>> +++ b/drivers/nvme/host/core.c
>>>> @@ -5010,10 +5010,19 @@ void nvme_quiesce_io_queues(struct nvme_ctrl *ctrl)
>>>>  {
>>>>         if (!ctrl->tagset)
>>>>                 return;
>>>> -       if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>>>> -               blk_mq_quiesce_tagset(ctrl->tagset);
>>>> -       else
>>>> -               blk_mq_wait_quiesce_done(ctrl->tagset);
>>>> +       if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags)) {
>>>> +               struct nvme_ns *ns;
>>>> +               int srcu_idx;
>>>> +
>>>> +               srcu_idx = srcu_read_lock(&ctrl->srcu);
>>>> +               list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
>>>> +                               srcu_read_lock_held(&ctrl->srcu)) {
>>>> +                       if (!blk_queue_skip_tagset_quiesce(ns->queue))
>>>> +                               blk_mq_quiesce_queue_nowait(ns->queue);
>>>> +               }
>>>> +               srcu_read_unlock(&ctrl->srcu, srcu_idx);
>>>> +       }
>>>> +       blk_mq_wait_quiesce_done(ctrl->tagset);
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(nvme_quiesce_io_queues);
>>>>
>>>> Here we iterate through ctrl->namespaces instead of relying on tag_list
>>>> and so we don't need to acquire ->tag_list_lock.
>>>
>>> How can you make sure all NSs are covered in this way? RCU/SRCU can't
>>> provide such kind of guarantee.
>>>
>> Why is that so? In fact, nvme_wait_freeze also iterates through 
>> the same ctrl->namespaces to freeze the queue.
> 
> It depends if nvme error handling needs to cover new coming NS,
> suppose it doesn't care, and you can change to srcu and bypass
> ->tag_list_lock.
> 
Yes new incoming NS may not be live yet when we iterate through 
ctrl->namespaces. So we don't need bother about it yet.
>>
>>>>
>>>>> And the same list is iterated in blk_mq_update_nr_hw_queues() too.
>>>>>
>>>>>>
>>>>>>>
>>>>>>> So all queues should be frozen first before calling blk_mq_update_nr_hw_queues,
>>>>>>> fortunately that is what nvme is doing.
>>>>>>>
>>>>>>>
>>>>>>>> If yes then it means that we should be able to grab ->elevator_lock
>>>>>>>> before freezing the queue in __blk_mq_update_nr_hw_queues and so locking
>>>>>>>> order should be in each code path,
>>>>>>>>
>>>>>>>> __blk_mq_update_nr_hw_queues
>>>>>>>>     ->elevator_lock 
>>>>>>>>       ->freeze_lock
>>>>>>>
>>>>>>> Now tagset->elevator_lock depends on set->tag_list_lock, and this way
>>>>>>> just make things worse. Why can't we disable elevator switch during
>>>>>>> updating nr_hw_queues?
>>>>>>>
>>>>>> I couldn't quite understand this. As we already first disable the elevator
>>>>>> before updating sw to hw queue mapping in __blk_mq_update_nr_hw_queues().
>>>>>> Once mapping is successful we switch back the elevator.
>>>>>
>>>>> Yes, but user still may switch elevator from none to others during the
>>>>> period, right?
>>>>>
>>>> Yes correct, that's possible. So your suggestion was to disable elevator
>>>> update while we're running __blk_mq_update_nr_hw_queues? And that way user
>>>> couldn't update elevator through sysfs (elv_iosched_store) while we update
>>>> nr_hw_queues? If this is true then still how could it help solve lockdep
>>>> splat? 
>>>
>>> Then why do you think per-set lock can solve the lockdep splat?
>>>
>>> __blk_mq_update_nr_hw_queues is the only chance for tagset wide queues
>>> involved wrt. switching elevator. If elevator switching is not allowed
>>> when __blk_mq_update_nr_hw_queues() is started, why do we need per-set
>>> lock?
>>>
>> Yes if elevator switch is not allowed then we probably don't need per-set lock. 
>> However my question was if we were to not allow elevator switch while 
>> __blk_mq_update_nr_hw_queues is running then how would we implement it?
> 
> It can be done easily by tag_set->srcu.
Ok great if that's possible! But I'm not sure how it could be done in this
case. I think both __blk_mq_update_nr_hw_queues and elv_iosched_store
run in the writer/updater context. So you may still need lock? Can you
please send across a (informal) patch with your idea ?

> 
>> Do we need to synchronize with ->tag_list_lock? Or in another words,
>> elv_iosched_store would now depends on ->tag_list_lock ? 
> 
> ->tag_list_lock isn't involved.
> 
>>
>> On another note, if we choose to make ->elevator_lock per-set then 
>> our locking sequence in blk_mq_update_nr_hw_queues() would be,
> 
> There is also add/del disk vs. updating nr_hw_queues, do you want to
> add the per-set lock in add/del disk path too?

Ideally no we don't need to acquire ->elevator_lock in this path.
Please see below.

>>
>> blk_mq_update_nr_hw_queues
>>   -> tag_list_lock
>>     -> elevator_lock
>>      -> freeze_lock 
> 
> Actually freeze lock is already held for nvme before calling
> blk_mq_update_nr_hw_queues, and it is reasonable to suppose queue
> frozen for updating nr_hw_queues, so the above order may not match
> with the existed code.
> 
> Do we need to consider nvme or blk_mq_update_nr_hw_queues now?
> 
I think we should consider (may be in different patch) updating
nvme_quiesce_io_queues and nvme_unquiesce_io_queues and remove
its dependency on ->tag_list_lock.

>>
>> elv_iosched_store
>>   -> elevator_lock
>>     -> freeze_lock
> 
> I understand that the per-set elevator_lock is just for avoiding the
> nested elvevator lock class acquire? If we needn't to consider nvme
> or blk_mq_update_nr_hw_queues(), this per-set lock may not be needed.
> 
> It is actually easy to sync elevator store vs. update nr_hw_queues.
> 
>>
>> So now ->freeze_lock should not depend on ->elevator_lock and that shall
>> help avoid few of the recent lockdep splats reported with fs_reclaim.
>> What do you think?
> 
> Yes, reordering ->freeze_lock and ->elevator_lock may avoid many fs_reclaim
> related splat.
> 
> However, in del_gendisk(), freeze_lock is still held before calling
> elevator_exit() and blk_unregister_queue(), and looks not easy to reorder.

Yes agreed, however elevator_exit() called from del_gendisk() or 
elv_unregister_queue() called from blk_unregister_queue() are called 
after we unregister the queue. And if queue has been already unregistered
while invoking elevator_exit or del_gensidk then ideally we don't need to
acquire ->elevator_lock. The same is true for elevator_exit() called 
from add_disk_fwnode(). So IMO, we should update these paths to avoid 
acquiring ->elevator_lock.

Thanks,
--Nilay
