Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0ED18AFF;
	Tue,  9 Sep 2025 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757400818; cv=none; b=WGkTGw4gj2IiSFYoVFqCNAFTE80+d7+2EB4ev49OYgJVsKNgx3IUv2QmSYuPdejuG6S2RwPfcjuyKPQsWdXEEaDVTAoc12i/z085WNE8wU1ZsGZWLf73qTjfacfmbNL2q+AJTGcTz93KJ7EZjwSUYWqwyQU4lvhLvkJzNofcRpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757400818; c=relaxed/simple;
	bh=21bDY95k2nDB0Q2IB8iXNEu9mmp3+L54yjY63hBRBjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACeBihOQPRPMVUUjF4TAYdaVQ9k44MLGmUsBSfAocARAsB85U5du5yfVNOcLro53HvZ5joWTSS0cr3ScaPY6SZm0ynxP8GoCJJ+TOaCwpTgvzq+QLxy9a9njwAMYM0lj9UBHaVL0AI1/egNebWnaDs97T6Fbu9e12TsTGiP25sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rKCMx7u6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rKCMx7u6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588J3AAu009279;
	Tue, 9 Sep 2025 06:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=M2njxS
	Gn1k/TaZw9Cl8545vulRC9DNBVQU/IC0/cj7A=; b=rKCMx7u6YcaE344AOpWXHY
	u1QD4EZF/7CEcl0hNyNi5sM1O87+dzTdf3TY75xxv9CsoxshrHdCGkNbE2YCc110
	q/JFQP3TO+MdpT94GLZrygAhHWlK87zdKZ5z2r1zob2qw1TRJWZU540n8QxzUN0f
	huEfeGJQ4zhWfKDnGNvOrnXutTt/T1uNZuOuONINBNCgK/ca69ae6dmiNTNuP+bW
	yPKWlmC2+jjXZn2AtF03CjZQkhKuUnpEzkBxEfVT+05eU2oAnOlUFaj2ucEF6BoC
	yR9L7p52YOYuvrSQFpT7waG34veHHp36fT5mZCyJG5bvxpQcEqIJ8fiA8KDS3z7g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff616d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:53:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5892iNtP017172;
	Tue, 9 Sep 2025 06:53:11 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gm9jy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:53:11 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5896rAlD16515764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 06:53:10 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AC31582BC;
	Tue,  9 Sep 2025 06:52:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6487558268;
	Tue,  9 Sep 2025 06:52:51 +0000 (GMT)
Received: from [9.43.113.79] (unknown [9.43.113.79])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 06:52:50 +0000 (GMT)
Message-ID: <f57ebcf8-9225-4e3d-86d2-cac7f9cacb54@linux.ibm.com>
Date: Tue, 9 Sep 2025 12:22:49 +0530
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <329ca336-21f6-e686-0446-b3ae9a46f4c9@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k-rbBzYtrpefH5p53gWVV-A3w0uzCIuN
X-Proofpoint-GUID: k-rbBzYtrpefH5p53gWVV-A3w0uzCIuN
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68bfced8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=fbS70rplHMDwEZbDWOYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX0vs/TF6Vifqw
 YD8/3Lx3IqMrs2lH1Rwx/RSy49r2JrJ2rsE7fc9sWaGzHbsqdVQqcjRK+d/XMHDCRmUJiQfYIKf
 ym4vElS4Tl+2TUM3x849zzGD2dczvjuyxXPrT7hP2dwXd1aXHg31Ch7EQ9LzNjcbTEpfRV7TIcE
 s4XAms29cYVM2/8EEu1XrZqcDxdDjMt9QQMrJpAtfU2MbZ4IqKChGU5U5wFgQDkIsvnIrXNgcLP
 zm9NVmdqrvyWNviwYoWSzbR8/dcAMfiBz78LrWkYtYw9xjVUXtw6/+EY5TF5qamWcewRMcSywGN
 yoX8UKOlMMVraVUQXpN1ffBNHg+dOIf31r4k6q2/P4F+6VL6OBgpoNmdJZy7GJMXJfjQpcGMDJk
 Q5Rwcg0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020



On 9/9/25 12:08 PM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/09/09 14:29, Nilay Shroff 写道:
>>
>>
>> On 9/8/25 11:45 AM, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> request_queue->nr_requests can be changed by:
>>>
>>> a) switching elevator by update nr_hw_queues
>>> b) switching elevator by elevator sysfs attribute
>>> c) configue queue sysfs attribute nr_requests
>>>
>>> Current lock order is:
>>>
>>> 1) update_nr_hwq_lock, case a,b
>>> 2) freeze_queue
>>> 3) elevator_lock, cas a,b,c
>>>
>>> And update nr_requests is seriablized by elevator_lock() already,
>>> however, in the case c), we'll have to allocate new sched_tags if
>>> nr_requests grow, and do this with elevator_lock held and queue
>>> freezed has the risk of deadlock.
>>>
>>> Hence use update_nr_hwq_lock instead, make it possible to allocate
>>> memory if tags grow, meanwhile also prevent nr_requests to be changed
>>> concurrently.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   block/blk-sysfs.c | 12 +++++++++---
>>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>>> index f99519f7a820..7ea15bf68b4b 100644
>>> --- a/block/blk-sysfs.c
>>> +++ b/block/blk-sysfs.c
>>> @@ -68,13 +68,14 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
>>>       int ret, err;
>>>       unsigned int memflags;
>>>       struct request_queue *q = disk->queue;
>>> +    struct blk_mq_tag_set *set = q->tag_set;
>>>         ret = queue_var_store(&nr, page, count);
>>>       if (ret < 0)
>>>           return ret;
>>>   -    memflags = blk_mq_freeze_queue(q);
>>> -    mutex_lock(&q->elevator_lock);
>>> +    /* serialize updating nr_requests with switching elevator */
>>> +    down_write(&set->update_nr_hwq_lock);
>>>   
>> For serializing update of nr_requests with switching elevator,
>> we should use disable_elv_switch(). So with this change we
>> don't need to acquire ->update_nr_hwq_lock in writer context
>> while running blk_mq_update_nr_requests but instead it can run
>> acquiring ->update_nr_hwq_lock in the reader context.
>>
>> So the code flow should be,
>>
>> disable_elv_switch  => this would set QUEUE_FLAG_NO_ELV_SWITCH
>> ...
>> down_read ->update_nr_hwq_lock
>> acquire ->freeze_lock
>> acquire ->elevator_lock;
>> ...
>> ...
>> release ->elevator_lock;
>> release ->freeze_lock
>>
>> clear QUEUE_FLAG_NO_ELV_SWITCH
>> up_read ->update_nr_hwq_lock
>>
> 
> Yes, this make sense, however, there is also an implied condition that
> we should serialize queue_requests_store() with itself, what if a
> concurrent caller succeed the disable_elv_switch() before the
> down_read() in this way?
> 
> t1:
> disable_elv_switch
>         t2:
>         disable_elv_switch
> 
> down_read    down_read
> 
I believe this is already protected with the kernfs internal
mutex locks. So you shouldn't be able to run two sysfs store 
operations concurrently on the same attribute file.

Thanks,
--Nilay

