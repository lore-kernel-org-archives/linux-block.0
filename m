Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E327A919
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715732; cv=none; b=OF0GZ2nCFwqFazkZCxfzjwHrVkNDKAE+5mUC9f8jpsrbzYy9NZPmiOwURCXUkSLFVsHgPQpDq1tdMqzELOLCWFBdgzX9xvsOW8GasPt2IVUsD6TEQiR717UjkVqlqnfE+cZxK+WGcaoL0xL+6IhotlHM1mOluZw9hperZEA6fe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715732; c=relaxed/simple;
	bh=zHE8CN8igAM9FWXXStscQ14hJlhMIEGPz7NjZCDS/Xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aH0wec6TgM9p8rL4NlTIZ36K6WMKtln99/WhTln63Il+pGGvtxOKQ4wTv+w1vI1G/5n8YUe/H/MWFCQ+Mx6ckchjmjOqmkNt44AwPVullKczawZSQmkqZ86FfArGmgWXNGW7bxXZH+Efb4fm+bsJwlgBno8bbOl7GJxRNy0+3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bG9Nxn3j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bG9Nxn3j"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FA4hqR022835;
	Tue, 15 Apr 2025 11:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p6XsLn
	ZjKsPm6kD7lP2Tl8QPFAPVrsc3IHtx9ffQ0/o=; b=bG9Nxn3jndtSmMaOgazrQw
	UJfgJLyVRdmDCJqv/m7A5NRym93TfjWUMTr+Sa75FLh9Kbnna1j87q7WHNJ4Lw9i
	pnuNKeCh2V1lMo24+HSVqFXY536mavNOR8ynATQoaQGFL0PUbyxzEtrIVrxmPLIk
	mTRcmKR53PDlfBm7pUk7oB5Lonn2+3HkSMxLS31Gsh66kg2eD/CeTgk99UqhdLP4
	dgBZi0qM6OQCkIFVyVR6cOqm7jo4/kyO0VB1BBbF/37lVn0dKygpxOU5JAT4IS1R
	1mMZipyQka1udH0GzYgKmtTVsFM7jXIeo2MZ5KXkKJxjCvvVxsT1Toi+7LNACHLg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461ncfga57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 11:15:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53FAQTEf017183;
	Tue, 15 Apr 2025 11:15:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040ktpvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 11:15:21 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53FBFJ7E23200494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 11:15:19 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5105E58053;
	Tue, 15 Apr 2025 11:15:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D49C58059;
	Tue, 15 Apr 2025 11:15:19 +0000 (GMT)
Received: from [9.179.13.11] (unknown [9.179.13.11])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 11:15:19 +0000 (GMT)
Message-ID: <bf874ae8-d26c-4b00-92ac-acbd3e6f4c3c@linux.ibm.com>
Date: Tue, 15 Apr 2025 16:45:16 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] block: move debugfs/sysfs register out of freezing
 queue
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-13-ming.lei@redhat.com>
 <b28d98a6-b406-45b0-a5db-11bc600be75f@linux.ibm.com>
 <Z_xn-Zl5FDGdZ_Bk@fedora>
 <96d870d2-19f2-489e-951f-b92a56b59bf6@linux.ibm.com>
 <Z_4vwU7HMLCShZUO@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z_4vwU7HMLCShZUO@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jwArClMGhnuwo5tXxOoVuwwvplwuEUlE
X-Proofpoint-GUID: jwArClMGhnuwo5tXxOoVuwwvplwuEUlE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150077



On 4/15/25 3:36 PM, Ming Lei wrote:
> On Tue, Apr 15, 2025 at 03:07:18PM +0530, Nilay Shroff wrote:
>>
>>
>> On 4/14/25 7:12 AM, Ming Lei wrote:
>>> On Fri, Apr 11, 2025 at 12:27:17AM +0530, Nilay Shroff wrote:
>>>>
>>>>
>>>> On 4/10/25 7:00 PM, Ming Lei wrote:
>>>>> Move debugfs/sysfs register out of freezing queue in
>>>>> __blk_mq_update_nr_hw_queues(), so that the following lockdep dependency
>>>>> can be killed:
>>>>>
>>>>> 	#2 (&q->q_usage_counter(io)#16){++++}-{0:0}:
>>>>> 	#1 (fs_reclaim){+.+.}-{0:0}:
>>>>> 	#0 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}: //debugfs
>>>>>
>>>>> And registering/un-registering debugfs/sysfs does not require queue to be
>>>>> frozen.
>>>>>
>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>> ---
>>>>>  block/blk-mq.c | 20 ++++++++++----------
>>>>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>> index 7219b01764da..0fb72a698d77 100644
>>>>> --- a/block/blk-mq.c
>>>>> +++ b/block/blk-mq.c
>>>>> @@ -4947,15 +4947,15 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>>>>  	if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
>>>>>  		return;
>>>>>  
>>>>> -	memflags = memalloc_noio_save();
>>>>> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
>>>>> -		blk_mq_freeze_queue_nomemsave(q);
>>>>> -
>>>>>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>>>>  		blk_mq_debugfs_unregister_hctxs(q);
>>>>>  		blk_mq_sysfs_unregister_hctxs(q);
>>>>>  	}
>>>> As we removed hctx sysfs protection while un-registering it, this might
>>>> cause crash or other side-effect if simultaneously these sysfs attributes
>>>> are accessed. The read access of these attributes are still protected 
>>>> using ->elevator_lock. 
>>>
>>> The ->elevator_lock in ->show() is useless except for reading the elevator
>>> internal data(sched tags, requests, ...), even for reading elevator data,
>>> it should have been relying on elevator reference, instead of lock, but
>>> that is another topic & improvement in future.
>>>
>>> Also this patch does _not_ change ->elevator_lock for above debugfs/sysfs
>>> unregistering, does it? It is always done without holding ->elevator_lock.
>>> Also ->show() does not require ->q_usage_counter too.
>>>
>>> As I mentioned, kobject/sysfs provides protection between ->show()/->store()
>>> and kobject_del(), isn't it the reason why you want to remove ->sys_lock?
>>>
>>> https://lore.kernel.org/linux-block/20250226124006.1593985-1-nilay@linux.ibm.com/
>>>
>> Yes you were correct, that was the reason we wanted to remove ->sysfs_lock.
>> However for these particular hctx sysfs attributes (nr_tags and nr_reserved_tags)
>> could be updated simultaneously from another blk-mq sysfs attribute named nr_requests.
>> Hence IMO, the default protection provided by sysfs/kernfs may not be sufficient and
>> so we need to protect those attributes using ->elevator_lock.
> 
> Yes, what is why this patchset doesn't kill more ->elevator_lock uses, such
> as, the uses in blk-mq-debugs, update_nr_requests, but many of them can be
> replaced with grabbing elevator reference.
> 
> But with/without this patch, the touched register/unregisger code does not
> require ->elevator_lock:
> 
>                 blk_mq_debugfs_unregister_hctxs(q);
>                 blk_mq_sysfs_unregister_hctxs(q);
> 
> so I don't understand why you argue here about ->elevator_lock use?
> 
I am not arguing using ->elevator_lock wrt removal of hctx sysfs attributes
as you explained that sysfs/kernfs already provides the needed protection. 
But please see below my explanation.

>>
>> Consider this case: While blk_mq_update_nr_hw_queues removes hctx attributes,
>> and simultaneously if nr_requests is also updating num of tags, would that not 
>> cause any side effect?
> 
> Why is updating nr_requests related with removing hctx attributes?
> 
> Can you explain the side effect in details?
Thread 1:
writing-to-blk-mq-sysfs-attribute-nr_requests 
  -> queue_requests_store ==> freezes queue and acquires ->elevator_lock 
    -> blk_mq_update_nr_requests 
      -> blk_mq_tag_update_depth
        -> blk_mq_alloc_map_and_rqs
          -> blk_mq_alloc_rq_map
            -> blk_mq_init_tags ==> updates ->nr_tags and ->nr_reserved_tags 

Thread2:
blk_mq_update_nr_hw_queues
  -> __blk_mq_update_nr_hw_queues
    -> blk_mq_realloc_tag_set_tags
      -> __blk_mq_alloc_map_and_rqs
        -> blk_mq_alloc_map_and_rqs
          -> blk_mq_alloc_rq_map
            -> blk_mq_init_tags ==> updates ->nr_tags and ->nr_reserved_tags 

Thread 3:
reading-hctx-sysfs-attribute-nr_tags
  -> blk_mq_hw_sysfs_show ==> acquires ->elevaor_lock
    ->  blk_mq_hw_sysfs_nr_tags_show ==> access nr_tags 

Thread 4:
reading-hctx-sysfs-attribute-nr_reserved_tags
  -> blk_mq_hw_sysfs_show ==> acquires ->elevaor_lock
    -> blk_mq_hw_sysfs_nr_reserved_tags_show ==> access nr_reserved_tags

As we can see above, ->nr_tags and ->nr_reserved_tags are also exported 
to userspace using hctx sysfs attributes (nr_tags and nr_reserved_tags).

So my point was,
#1 For alleviating race between nr_hw_queues and nr_requests update,
   we need protection (probably using srcu lock) so that ->nr_tags 
   and ->nr_reserved_tags are not updated simultaneously.

#2 How could we protect race between thread 3 and thread 2 above or 
   race between thread 4 and thread 2 above?   

> 
>> Maybe we also want to protect blk_mq_update_nr_requests
>> with srcu read lock (set->update_nr_hwq_srcu) so that it couldn't run while  
>> blk_mq_update_nr_hw_queues is in progress?
> 
> Yeah, agree, and it can be one new patch for covering race between
> blk_mq_update_nr_requests and blk_mq_update_nr_hw_queues, the point is just
> that nr_hw_queues is being changed, and not related with removing hctx
> attributes, IMO.
> 
Please note that blk_mq_update_nr_requests also updates q->nr_requests, 
however looking at all code paths which updates this value is already
protected with ->elevator_lock. So the only thing which worries me
about updates of ->nr_tags and ->nr_reserved tags as shown above.

Thanks,
--Nilay

