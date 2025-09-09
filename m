Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A542248BD;
	Tue,  9 Sep 2025 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417604; cv=none; b=Is+h4VeSPLt3CWUaAkSagtqAa73HJCDjoCJegYgG7Knk1HOwDNpDyeWhP3z8/Nob0sJA7E1phaCjPIcQB3lAbxym/uGHtL9BW/wRwo4+7/jp1rX4I1vZ56BSGVK7oYAtP+0rytn7vbnd3eGpfkZ1gz/GpXdSeXWJssppMQypF9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417604; c=relaxed/simple;
	bh=O33gT+9vRMjzOMqnxO2FEfZvHVOeVPUlrkF9QVVgFA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oEjRmrgQge43aBx6Gt2wYHlcO2rOBbHRwVsGA3tGnR/8T3mh8iwWHsNJ7DIGB9jxp4OksorMbh3nte9MKuHJmnekpVjRuPemf+pxO5c2bvNHOe3W4QCdIIW6gxa6OBWRnOz8bOMpbaz0fyUlLcXkas2GcC5DU7AObj+ctvM1e68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B3cW6U4i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B3cW6U4i"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5896MABX024164;
	Tue, 9 Sep 2025 11:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=om9DNb
	Ti25sdMLfLe5lcDllQdtJM+Gt718Mb+gJ/upg=; b=B3cW6U4iSzkTjCVCEJ5mME
	zT0bDEZqlgL1FkXmozISV0YXgFhfdnI0LxrV5QaY+W5Ia9hulDCodYyoQk5lE0lQ
	ZXbZtzd55tniHpl2NW+olssP1QCeGDxvv7s58zy4NezqGQO2FFgU8iB1heE9YnHG
	PCNcrr9ILYeo83EaoAGnMGr5qGMBX9dmPx+K2I0GDMTv//HrMkEnGgrRVK88E1N+
	CBkDdeWpIxN4rCVBagp7t6ydOZjYUrDazuY25pbYOd80nsFq4v/FYDbR3hb3yhqD
	Is2QbCVBUMqLGjWsfFuLdlxISyM3cRW4vFybCpzJVV9PZxoZmNK33lFI14sulmnw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsq59j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 11:33:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 589B1r7R017187;
	Tue, 9 Sep 2025 11:33:01 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmap07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 11:33:01 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589BWppT22413966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 11:32:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBA0258061;
	Tue,  9 Sep 2025 11:33:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC7C758058;
	Tue,  9 Sep 2025 11:32:56 +0000 (GMT)
Received: from [9.43.86.190] (unknown [9.43.86.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 11:32:56 +0000 (GMT)
Message-ID: <e8292387-0589-4092-95db-921f89a912bc@linux.ibm.com>
Date: Tue, 9 Sep 2025 17:02:54 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 04/10] blk-mq: convert to serialize
 updating nr_requests with update_nr_hwq_lock
To: Yu Kuai <hailan@yukuai.org.cn>, Yu Kuai <yukuai1@huaweicloud.com>,
        ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-5-yukuai1@huaweicloud.com>
 <9708abeb-7677-4c0e-931b-7ca5fe0a0242@linux.ibm.com>
 <329ca336-21f6-e686-0446-b3ae9a46f4c9@huaweicloud.com>
 <f57ebcf8-9225-4e3d-86d2-cac7f9cacb54@linux.ibm.com>
 <43d25899-6b1a-c0e1-c3f5-8e2a560c93d5@huaweicloud.com>
 <d15faae0-40bb-41f0-bef1-f2ad48543110@linux.ibm.com>
 <7544e26c-502a-75fc-7147-721a98bb0e80@huaweicloud.com>
 <7fe7bfd3-d6c0-4485-aaa1-2c1629cb1784@linux.ibm.com>
 <b85a8730-78f0-4933-a415-815e6ceefe5f@yukuai.org.cn>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <b85a8730-78f0-4933-a415-815e6ceefe5f@yukuai.org.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfXzQUw/s8joVAb
 VBl/rczTDzMAnDqn9s61zmbwQK3hrSAkr7Iidy+8zH2tXAW8y2SYqX+SMpdNraTI2i4hUjQMw7r
 hiCt+UL/WtT0cCYAO7/x6XrII62tGYwCmeClX6s8iDMbbfWPnw/tUznmlLkJTBB6ha13HAI/k3M
 2jufGTZCzu6G3KnhftXJh+cabFz8UlSj76Ezw6OPH8PsWmtKFY8deDQoVxUpRt3eg4MCo6EudWq
 zH4C4aFLqEamU3JXazYRSvEYmTi0hF9Pdp2ZcevlvD/vlFIlCyTJxWXHysk2H5TM/PCm7nUBfUi
 iLAVtrcF5GCvitdVKSR9WLVPiVgq0xMA+3Gwo7MOQhg2raYSGZY07vVq5jmrFCqAblYMSnmL6K3
 QLwv0JGK
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c0106e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=HIyjCkgkKosTXwFiDQoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Gc_VThvcg52_AuoavNTLLsbc9s3nWSCy
X-Proofpoint-ORIG-GUID: Gc_VThvcg52_AuoavNTLLsbc9s3nWSCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010



On 9/9/25 4:12 PM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/9/9 18:11, Nilay Shroff 写道:
>>
>> On 9/9/25 3:06 PM, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2025/09/09 17:26, Nilay Shroff 写道:
>>>>
>>>> On 9/9/25 12:46 PM, Yu Kuai wrote:
>>>>> Hi,
>>>>>
>>>>> 在 2025/09/09 14:52, Nilay Shroff 写道:
>>>>>>
>>>>>> On 9/9/25 12:08 PM, Yu Kuai wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> 在 2025/09/09 14:29, Nilay Shroff 写道:
>>>>>>>>
>>>>>>>> On 9/8/25 11:45 AM, Yu Kuai wrote:
>>>>>>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>>>>>>
>>>>>>>>> request_queue->nr_requests can be changed by:
>>>>>>>>>
>>>>>>>>> a) switching elevator by update nr_hw_queues
>>>>>>>>> b) switching elevator by elevator sysfs attribute
>>>>>>>>> c) configue queue sysfs attribute nr_requests
>>>>>>>>>
>>>>>>>>> Current lock order is:
>>>>>>>>>
>>>>>>>>> 1) update_nr_hwq_lock, case a,b
>>>>>>>>> 2) freeze_queue
>>>>>>>>> 3) elevator_lock, cas a,b,c
>>>>>>>>>
>>>>>>>>> And update nr_requests is seriablized by elevator_lock() already,
>>>>>>>>> however, in the case c), we'll have to allocate new sched_tags if
>>>>>>>>> nr_requests grow, and do this with elevator_lock held and queue
>>>>>>>>> freezed has the risk of deadlock.
>>>>>>>>>
>>>>>>>>> Hence use update_nr_hwq_lock instead, make it possible to allocate
>>>>>>>>> memory if tags grow, meanwhile also prevent nr_requests to be changed
>>>>>>>>> concurrently.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>>>>>>> ---
>>>>>>>>>      block/blk-sysfs.c | 12 +++++++++---
>>>>>>>>>      1 file changed, 9 insertions(+), 3 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>>>>>>>>> index f99519f7a820..7ea15bf68b4b 100644
>>>>>>>>> --- a/block/blk-sysfs.c
>>>>>>>>> +++ b/block/blk-sysfs.c
>>>>>>>>> @@ -68,13 +68,14 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
>>>>>>>>>          int ret, err;
>>>>>>>>>          unsigned int memflags;
>>>>>>>>>          struct request_queue *q = disk->queue;
>>>>>>>>> +    struct blk_mq_tag_set *set = q->tag_set;
>>>>>>>>>            ret = queue_var_store(&nr, page, count);
>>>>>>>>>          if (ret < 0)
>>>>>>>>>              return ret;
>>>>>>>>>      -    memflags = blk_mq_freeze_queue(q);
>>>>>>>>> -    mutex_lock(&q->elevator_lock);
>>>>>>>>> +    /* serialize updating nr_requests with switching elevator */
>>>>>>>>> +    down_write(&set->update_nr_hwq_lock);
>>>>>>>>>      
>>>>>>>> For serializing update of nr_requests with switching elevator,
>>>>>>>> we should use disable_elv_switch(). So with this change we
>>>>>>>> don't need to acquire ->update_nr_hwq_lock in writer context
>>>>>>>> while running blk_mq_update_nr_requests but instead it can run
>>>>>>>> acquiring ->update_nr_hwq_lock in the reader context.
>>>>>>>>
>>>>>>>> So the code flow should be,
>>>>>>>>
>>>>>>>> disable_elv_switch  => this would set QUEUE_FLAG_NO_ELV_SWITCH
>>>>>>>> ...
>>>>>>>> down_read ->update_nr_hwq_lock
>>>>>>>> acquire ->freeze_lock
>>>>>>>> acquire ->elevator_lock;
>>>>>>>> ...
>>>>>>>> ...
>>>>>>>> release ->elevator_lock;
>>>>>>>> release ->freeze_lock
>>>>>>>>
>>>>>>>> clear QUEUE_FLAG_NO_ELV_SWITCH
>>>>>>>> up_read ->update_nr_hwq_lock
>>>>>>>>
>>>>>>> Yes, this make sense, however, there is also an implied condition that
>>>>>>> we should serialize queue_requests_store() with itself, what if a
>>>>>>> concurrent caller succeed the disable_elv_switch() before the
>>>>>>> down_read() in this way?
>>>>>>>
>>>>>>> t1:
>>>>>>> disable_elv_switch
>>>>>>>            t2:
>>>>>>>            disable_elv_switch
>>>>>>>
>>>>>>> down_read    down_read
>>>>>>>
>>>>>> I believe this is already protected with the kernfs internal
>>>>>> mutex locks. So you shouldn't be able to run two sysfs store
>>>>>> operations concurrently on the same attribute file.
>>>>>>
>>>>> There really is no such internal lock, the call stack is:
>>>>>
>>>>> kernfs_fop_write_iter
>>>>>    sysfs_kf_write
>>>>>     queue_attr_store
>>>>>
>>>>> There is only a file level mutex kernfs_open_file->lock from the top
>>>>> function kernfs_fop_write_iter(), however, this lock is not the same
>>>>> if we open the same attribute file from different context.
>>>>>
>>>> Oh yes this lock only protects if the same fd is being written
>>>> concurrently. However if we open the same sysfs file from different process
>>>> contexts then fd would be different and so this lock wouldn't protect
>>>> the simultaneous update of sysfs attribute. Having said that,
>>>> looking through the code again it seems that q->nr_requests update
>>>> is protected with ->elevator_lock (including both the elevator switch
>>>> code and your proposed changes in this patchset). So my question is
>>>> do we really need to synchronize nr_requests update code with elevator
>>>> swiupdate_nr_hwq_locktch code? So in another words what if we don't at
>>>> all use ->update_nr_hwq_lock in queue_requests_store?
>>> 1) lock update_nr_hwq_lock, then no one can change nr_queuests
>>> 2) checking input nr_reqeusts
>>> 3) if grow, allocate memory
>>>
>>> Main idea here is we can checking if nr_requests grow and then allocate
>>> mermory, without concern that nr_requests can be changed after memory
>>> allocation.
>>>
>> If nr_requests changes after memory allocation we're still good because
>> eventually we'd only have one consistent value of nr_requests. For
>> instance, if process A is updating nr_requests to 128 and sched switch
>> is updating nr_requests to 256 simultaneously then we'd either see
>> nr_requests set to 128 or 256 in the end depending on who runs last.
>> We wouldn't get into a situation where we find some inconsistent update
>> to nr_requests, isn't it?
> 
> Then we'll have to allocate memory for every input nr_requests now, we don't
> know for sure if tag will grow in advance this way. And even with this, we
> still have to hold read lock before allocating memory, to prevent nr hctxs
> to change.
> 
Hmm ok so we still have to acquire read lock and we can't avoid 
->update_nr_hwq_lock. And that should be okay, as typically the
semantics of rw_semaphore is a multiple readers and single writer
lock mechanism. 
With the proposed patch now we've two contexts acquiring 
->update_nr_hwq_lock in writer mode but for this particular case,
I'm okay just to avoid unnecessary complexities making nr_requests
update a reader context. And yes, as you mentioned, this code runs
in slow path and we may not starve reader or writer as the code 
it protects is not big or complex. So with that said,I'd add
review tag in another email.

Thanks,
--Nilay
