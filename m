Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CB32DFA25
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709855; cv=none; b=V4swrMHFuMIjwMT3QZPJ26xCCalS+YZWz9M6IX3lk/ozEc7tKAqHjA10PI3oX7ZBeBUNeijIbKQVjTrEsFFZv1AIg2Qng3lowjw/+SQChtUkdoeOHj5Qe0DgfOwL3mkKaJuArPZpjHrQ4nR/yx7cfd5erF9P6fmzr2be6IKI+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709855; c=relaxed/simple;
	bh=sA2cBD6u9o73ClQpUr3lqeicnB95OI1zovmfzJbmJWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9gOCyj9iCK+2hlmal9g4suM1RZ6Xi6JzkILrJzOajkeBmxJOus8O10eH33Kv2UYf5AzwwBPHh1Ac0FIq0tY/Cj5XJ0K76ZDQ6EnHjydr+MdpuSas3Do9jvEmR2wWsMQYt9ZTRxLIZVKuDY7bcO7HFfh7ziP2k+2FrLXfeoAb3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nS1lg1PS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nS1lg1PS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EL3SUl004459;
	Tue, 15 Apr 2025 09:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LGbb1v
	w1ujrgg/0iMkL7csv7y4FVDTAeoJ4CCV6x8zM=; b=nS1lg1PSD22oBmhZvt1GcB
	BPfgbw3TNLcZMJhp6d+GemdK+fvCIOtweNzqf9c0i1x+nH1lwD7DG78aSo0eGhe6
	WJbglAhLTGZTF//BCNOYG3bTPH/FTPhafEhUTcYcTt8Gt4DKdvES2J7ieWcsh9az
	qqnCnYQNZWVZcr2LwJxnWrwb2u5DLzDqYFXkbj4Z3dxMFQdiYs09EH/A4F6nlY/g
	3LxP1JrT0QTabnC91SRxR8uqnXcIuPN8kJ/V09Th27e3YmXQFJnmSvH8nYJfhcsZ
	YYZoyq0kSQ3bWPmyYwQyH4mHfQndDo9/1DaWvrraG4qWHBJ87AkXX/DX5H/+9YwQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4619xftucg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 09:37:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8hen9024888;
	Tue, 15 Apr 2025 09:37:22 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gtatcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 09:37:22 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53F9bLgF28508826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 09:37:22 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC9E258059;
	Tue, 15 Apr 2025 09:37:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A96D05805F;
	Tue, 15 Apr 2025 09:37:19 +0000 (GMT)
Received: from [9.179.13.11] (unknown [9.179.13.11])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 09:37:19 +0000 (GMT)
Message-ID: <96d870d2-19f2-489e-951f-b92a56b59bf6@linux.ibm.com>
Date: Tue, 15 Apr 2025 15:07:18 +0530
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z_xn-Zl5FDGdZ_Bk@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _PUhrqE0afrYSnY4gwHvqFtxEa-jFTO0
X-Proofpoint-GUID: _PUhrqE0afrYSnY4gwHvqFtxEa-jFTO0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150066



On 4/14/25 7:12 AM, Ming Lei wrote:
> On Fri, Apr 11, 2025 at 12:27:17AM +0530, Nilay Shroff wrote:
>>
>>
>> On 4/10/25 7:00 PM, Ming Lei wrote:
>>> Move debugfs/sysfs register out of freezing queue in
>>> __blk_mq_update_nr_hw_queues(), so that the following lockdep dependency
>>> can be killed:
>>>
>>> 	#2 (&q->q_usage_counter(io)#16){++++}-{0:0}:
>>> 	#1 (fs_reclaim){+.+.}-{0:0}:
>>> 	#0 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}: //debugfs
>>>
>>> And registering/un-registering debugfs/sysfs does not require queue to be
>>> frozen.
>>>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>  block/blk-mq.c | 20 ++++++++++----------
>>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 7219b01764da..0fb72a698d77 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -4947,15 +4947,15 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>>  	if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
>>>  		return;
>>>  
>>> -	memflags = memalloc_noio_save();
>>> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
>>> -		blk_mq_freeze_queue_nomemsave(q);
>>> -
>>>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>>  		blk_mq_debugfs_unregister_hctxs(q);
>>>  		blk_mq_sysfs_unregister_hctxs(q);
>>>  	}
>> As we removed hctx sysfs protection while un-registering it, this might
>> cause crash or other side-effect if simultaneously these sysfs attributes
>> are accessed. The read access of these attributes are still protected 
>> using ->elevator_lock. 
> 
> The ->elevator_lock in ->show() is useless except for reading the elevator
> internal data(sched tags, requests, ...), even for reading elevator data,
> it should have been relying on elevator reference, instead of lock, but
> that is another topic & improvement in future.
> 
> Also this patch does _not_ change ->elevator_lock for above debugfs/sysfs
> unregistering, does it? It is always done without holding ->elevator_lock.
> Also ->show() does not require ->q_usage_counter too.
> 
> As I mentioned, kobject/sysfs provides protection between ->show()/->store()
> and kobject_del(), isn't it the reason why you want to remove ->sys_lock?
> 
> https://lore.kernel.org/linux-block/20250226124006.1593985-1-nilay@linux.ibm.com/
> 
Yes you were correct, that was the reason we wanted to remove ->sysfs_lock.
However for these particular hctx sysfs attributes (nr_tags and nr_reserved_tags)
could be updated simultaneously from another blk-mq sysfs attribute named nr_requests.
Hence IMO, the default protection provided by sysfs/kernfs may not be sufficient and
so we need to protect those attributes using ->elevator_lock.

Consider this case: While blk_mq_update_nr_hw_queues removes hctx attributes,
and simultaneously if nr_requests is also updating num of tags, would that not 
cause any side effect? Maybe we also want to protect blk_mq_update_nr_requests
with srcu read lock (set->update_nr_hwq_srcu) so that it couldn't run while  
blk_mq_update_nr_hw_queues is in progress?

Thanks,
--Nilay





