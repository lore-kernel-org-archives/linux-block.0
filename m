Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB1128B501;
	Tue,  9 Sep 2025 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410019; cv=none; b=ezfRGB5yIuY6H66tF5Fyq/l1u5r4iELnTcvCY5sBdwktOIOlMyACza1kGgGLaSY6s31lNboAXoRfNnvvC+CK6kzg8ZfIxDyinP5wTttsKC/WGn5RIEG3xxWIUb9yRt4FfcfbWMELbzcCDQVyTm4MDHQJtekT6vPY0cCg2sGUB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410019; c=relaxed/simple;
	bh=wZVMPTz+/Lyr60Wm1tPgUTPAkB7R6ztotSkkFtz9syk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdzeSrCmsr4z+qDHG99PO4Kw4cdr3Qfe6sGQSLEw6h7247/2HsJLQojNZK/LDLn8PGkcP6peshEOULrGXmRF/luRBdi9qXySCNZtadAnEq6HsGoRbwdn7RFgnJl+RGINcJJj3BoDDd2ho6DCmONieAmT2RIiXIBi48WkbEcoxsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iIhO0lOr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iIhO0lOr"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5892eHpF015943;
	Tue, 9 Sep 2025 09:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=keyUjr
	f1IVOVahNxGgWpLuP5wIdLjl5tGe+uFiwoYPA=; b=iIhO0lOr50yxRB0nEnNDxq
	fTffjf0ebPGs/DKHQBP98jy8K9LWOTteYiRFzBQzu5JqDunkESfC5bW10W7fdR6b
	R4czkaEhDLgT5VdmH6ByLE85n4bOwr6LlAgd+VR7gV4d9X7DrzZGNvH/EkTkad6i
	myspwFB/u7xYeWgJD8yig/ZiL9HBpykxXBdJ+Speq1HJSCKvZ1r2cdtX3vDz1KXx
	DM4pjxBBXdO6302yNEti/8aGybYZNjDPXkJkXNqteSJAxpLLQia3j9LdZButJtwc
	ChR0gKewM1bn8a4p5KYE8U8hlvaYJ+MjOnU9tFcT8uBC1CxiHHEu18YETGHDteTw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff6ufy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 09:26:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58994s2g011428;
	Tue, 9 Sep 2025 09:26:39 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9uam3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 09:26:39 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5899Qcr731261330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 09:26:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95FC158057;
	Tue,  9 Sep 2025 09:26:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF7EB58058;
	Tue,  9 Sep 2025 09:26:34 +0000 (GMT)
Received: from [9.43.86.190] (unknown [9.43.86.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 09:26:34 +0000 (GMT)
Message-ID: <d15faae0-40bb-41f0-bef1-f2ad48543110@linux.ibm.com>
Date: Tue, 9 Sep 2025 14:56:32 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 04/10] blk-mq: convert to serialize
 updating nr_requests with update_nr_hwq_lock
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-5-yukuai1@huaweicloud.com>
 <9708abeb-7677-4c0e-931b-7ca5fe0a0242@linux.ibm.com>
 <329ca336-21f6-e686-0446-b3ae9a46f4c9@huaweicloud.com>
 <f57ebcf8-9225-4e3d-86d2-cac7f9cacb54@linux.ibm.com>
 <43d25899-6b1a-c0e1-c3f5-8e2a560c93d5@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <43d25899-6b1a-c0e1-c3f5-8e2a560c93d5@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ugPRoQLWIMX-xUSzF2jVyEGjIRbEyCOb
X-Proofpoint-GUID: ugPRoQLWIMX-xUSzF2jVyEGjIRbEyCOb
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68bff2d0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=ARzOzOuAuFqv0pYd7hkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfXw0grLodflCW4
 EA+oL2eu0YQuSOXm5mMuDgzwE2jwRCIBo1g76vSgtFldkcPdSY9ZBoxEk8hKanmVl5VZPOITwL/
 QuhHyLzlxHdEGPwsSCpqkNr9xSFCe77dWWNcDElwbqQSbCG6obRteQFzXisOANlZysFPA1bebK9
 fhaaPtiT3nIiPtkFJHKcFvjZsWCdv3UGRnPp2hDk7l7L+59GfqRwHNI4hpuYMMIJ5zYKO6h4Pj8
 VAOSXubdJKved1S5rqwaarDwMqlFXsvue9GeUGC4cAG5V8w166KTHj8luSJGNPXYptxtdnDIaYd
 GIy22NZVOQy/eBVvn0gIaTsZckWXcgOfZA7gV2GW15oP4hNYEni15/dXvPPWvjMhzejCR0VXkHt
 rCPnWPG3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020



On 9/9/25 12:46 PM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/09/09 14:52, Nilay Shroff 写道:
>>
>>
>> On 9/9/25 12:08 PM, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2025/09/09 14:29, Nilay Shroff 写道:
>>>>
>>>>
>>>> On 9/8/25 11:45 AM, Yu Kuai wrote:
>>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>>
>>>>> request_queue->nr_requests can be changed by:
>>>>>
>>>>> a) switching elevator by update nr_hw_queues
>>>>> b) switching elevator by elevator sysfs attribute
>>>>> c) configue queue sysfs attribute nr_requests
>>>>>
>>>>> Current lock order is:
>>>>>
>>>>> 1) update_nr_hwq_lock, case a,b
>>>>> 2) freeze_queue
>>>>> 3) elevator_lock, cas a,b,c
>>>>>
>>>>> And update nr_requests is seriablized by elevator_lock() already,
>>>>> however, in the case c), we'll have to allocate new sched_tags if
>>>>> nr_requests grow, and do this with elevator_lock held and queue
>>>>> freezed has the risk of deadlock.
>>>>>
>>>>> Hence use update_nr_hwq_lock instead, make it possible to allocate
>>>>> memory if tags grow, meanwhile also prevent nr_requests to be changed
>>>>> concurrently.
>>>>>
>>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>>> ---
>>>>>    block/blk-sysfs.c | 12 +++++++++---
>>>>>    1 file changed, 9 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>>>>> index f99519f7a820..7ea15bf68b4b 100644
>>>>> --- a/block/blk-sysfs.c
>>>>> +++ b/block/blk-sysfs.c
>>>>> @@ -68,13 +68,14 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
>>>>>        int ret, err;
>>>>>        unsigned int memflags;
>>>>>        struct request_queue *q = disk->queue;
>>>>> +    struct blk_mq_tag_set *set = q->tag_set;
>>>>>          ret = queue_var_store(&nr, page, count);
>>>>>        if (ret < 0)
>>>>>            return ret;
>>>>>    -    memflags = blk_mq_freeze_queue(q);
>>>>> -    mutex_lock(&q->elevator_lock);
>>>>> +    /* serialize updating nr_requests with switching elevator */
>>>>> +    down_write(&set->update_nr_hwq_lock);
>>>>>    
>>>> For serializing update of nr_requests with switching elevator,
>>>> we should use disable_elv_switch(). So with this change we
>>>> don't need to acquire ->update_nr_hwq_lock in writer context
>>>> while running blk_mq_update_nr_requests but instead it can run
>>>> acquiring ->update_nr_hwq_lock in the reader context.
>>>>
>>>> So the code flow should be,
>>>>
>>>> disable_elv_switch  => this would set QUEUE_FLAG_NO_ELV_SWITCH
>>>> ...
>>>> down_read ->update_nr_hwq_lock
>>>> acquire ->freeze_lock
>>>> acquire ->elevator_lock;
>>>> ...
>>>> ...
>>>> release ->elevator_lock;
>>>> release ->freeze_lock
>>>>
>>>> clear QUEUE_FLAG_NO_ELV_SWITCH
>>>> up_read ->update_nr_hwq_lock
>>>>
>>>
>>> Yes, this make sense, however, there is also an implied condition that
>>> we should serialize queue_requests_store() with itself, what if a
>>> concurrent caller succeed the disable_elv_switch() before the
>>> down_read() in this way?
>>>
>>> t1:
>>> disable_elv_switch
>>>          t2:
>>>          disable_elv_switch
>>>
>>> down_read    down_read
>>>
>> I believe this is already protected with the kernfs internal
>> mutex locks. So you shouldn't be able to run two sysfs store
>> operations concurrently on the same attribute file.
>>
> 
> There really is no such internal lock, the call stack is:
> 
> kernfs_fop_write_iter
>  sysfs_kf_write
>   queue_attr_store
> 
> There is only a file level mutex kernfs_open_file->lock from the top
> function kernfs_fop_write_iter(), however, this lock is not the same
> if we open the same attribute file from different context.
> 
Oh yes this lock only protects if the same fd is being written
concurrently. However if we open the same sysfs file from different process
contexts then fd would be different and so this lock wouldn't protect
the simultaneous update of sysfs attribute. Having said that,
looking through the code again it seems that q->nr_requests update 
is protected with ->elevator_lock (including both the elevator switch
code and your proposed changes in this patchset). So my question is
do we really need to synchronize nr_requests update code with elevator
swiupdate_nr_hwq_locktch code? So in another words what if we don't at
all use ->update_nr_hwq_lock in queue_requests_store?

Thanks
--Nilay
