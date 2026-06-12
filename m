Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CF93E92BB
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264716; cv=none; b=u9tJuIaGPy8cL3mgIpe9/v75cGgJYkqwXj5/58n9SO9fXytdVr5ItZoAQUSOshqBzyEUUnJ8o/8QoL/ADWWlQxPrU86LulQHY5uV1TPxXXzJPdVC/YwySBv2sLV1ioiS9s0s3/lGqJZXJYOzjeTdjnHazlUJtJN3Gccuj6jF2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264716; c=relaxed/simple;
	bh=ZQPyJbBW0QFkTiDLhiIaP1AiN0IFcSytjsG8GG3//aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gkdf9LkSoUEx9TphYIroII1co+zw10k6ZH3C2yeOcr2APzVo8Xq0FpKJJEINH7HhSBcS428mDdE/DheezEQhcz1l9Y+HbGyEKAu6V4zDLdTuzatGUqy/IywdurhFEfZoqTH6612cS7PpFwSd6niCWNqc+dXV1oNS9KVQlfSok2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aHOFHuQg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aHOFHuQg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BLOqk6677689;
	Fri, 12 Jun 2026 11:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VDnsJV
	ffIDVZyF1MDB9FzH97BgVo4gcj8+G+yH/ZGXg=; b=aHOFHuQgr/JqH/DKBmVFM5
	1eQDkNgRRYpT0WMpnu9blKmFmWsJTLxiZKQoITreF5Gk8SddYG7g/evMBU2izL41
	HYG5bxTyni4eFOwcAsAvPEJSEAuGC23R9lo08I6c0VDjjLAwqOA2x8ZK0fyGsGdI
	xlYl0+QvjLD4DsiQgvmvsHABIFHzW00cO9L9ytaxF8juUjJ+x+lekOQjOWJByN8+
	KmTWBfrAS/u0AqhNPh7oXDwUTqdkIPT/Ofhhy5WA9RYZr4pztUX2g30EjC3roBvZ
	iBqAiKsXg2r99L6mawpr796eQ+/hjTjJZA9ldlr7q8O+9LsLoSlgBP8E0xj5QyzQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8arcpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 11:45:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CBYvDI010924;
	Fri, 12 Jun 2026 11:45:11 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09ymdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 11:45:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65CBjBcC63504772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 11:45:11 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AAAD58060;
	Fri, 12 Jun 2026 11:45:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 621B85805C;
	Fri, 12 Jun 2026 11:45:09 +0000 (GMT)
Received: from [9.43.60.77] (unknown [9.43.60.77])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jun 2026 11:45:08 +0000 (GMT)
Message-ID: <3db036fe-747f-44eb-93c3-595350278297@linux.ibm.com>
Date: Fri, 12 Jun 2026 17:15:07 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/1] block: fix concurrent elevator change failure
To: Ming Lei <tom.leiming@gmail.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20260611074200.474676-1-shinichiro.kawasaki@wdc.com>
 <aiqaXfTqCLMu2DwF@fedora> <aivMxPCd305WbBsk@shinmob>
 <aivoHk4DE_pkKkDm@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aivoHk4DE_pkKkDm@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: N_ORbv4FgwFbJUhemhUbWFQ_89uq7TX4
X-Authority-Analysis: v=2.4 cv=TdKmcxQh c=1 sm=1 tr=0 ts=6a2bf148 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=-5OKdyvLZ9Tln4FY6lIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEwNiBTYWx0ZWRfX9VhnAwBMrbO0
 A2PenQIf/VnrS3L8Jvorq7LmbGnBTWviZvJ0twovZchCHTl22cHm8/2WNwpFKiwzqB1ZSN4gxyD
 RnLOS7I+yluKN411AKDXFFYbemvN+vFkuE3rcVGuP8XspT5sYcO9x/hS85jr9Bsz7ZSzVnXssmC
 wJtQEA54bJaD4BHlGCmBuFrVNQrGLqOgAs6r4SscKE6m5k93AHxwLSMMWx6bcbPpv0NVYxl0d7M
 Io4bX41RQIYiN2NgHgY+ARWAxj+M2zzHgJBN/Yr87+Mt4Rrjm4W2u9AXTQ7zkiLyDwGmxWwoYlz
 XfWMMr9N+fY5k17uxmz0RzgEw2BdkePTGjxMo0wXwLzmk/O7WKG3b1V22B6OHTmrblU8Y35HMDm
 jxP801PV1b5sTUSOsbl3q1+vKpHzunY2y/T8WTi5+5Z1Y6uaP9T80lsvPG5iw2B35aUVxNX3/e5
 D5EK1jqetYMs4/HQ/5A==
X-Proofpoint-GUID: IPzIJf5Det9ltkEWryYRIMi9tHqdaETt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEwNiBTYWx0ZWRfX+SmE0o9nbrsy
 4/EK+2+SCG1rX+X+4U3rELdc/UzbokQljUYegsjTRAS3xoZMCe177nJdY+5scIOIFxlUrQwCZaV
 JcwfufQyzVRvdv61FmZoDJrcXInj3OM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120106

On 6/12/26 4:36 PM, Ming Lei wrote:
> On Fri, Jun 12, 2026 at 06:47:50PM +0900, Shin'ichiro Kawasaki wrote:
>> On Jun 11, 2026 / 06:22, Ming Lei wrote:
>>> Hi Shin'ichiro,
>>
>> Hi Ming, thanks for the comments.
>>
>>>
>>> On Thu, Jun 11, 2026 at 04:41:59PM +0900, Shin'ichiro Kawasaki wrote:
>>>> I observed that the blktests test case block/005 hangs on a specific
>>>> server hardware using a specific HDD as a block device. During the test
>>>> case run, the kernel reported a KASAN null-ptr-deref (and other memory
>>>> corruption symptoms) [2]. This failure looked sporadic and hardware-
>>>> dependent.
>>>>
>>>>  From the kernel message, I noticed that udev-worker wrote to the
>>>> queue/scheduler sysfs attribute to change the IO scheduler, or elevator.
>>>> The test case block/005 also wrote to the same sysfs attribute, which
>>>
>>> sysfs write is supposed to be serialized...
>>
>> I checked the sysfs write handler elv_iosched_store() in block/elevator.c.
>> I found elevator_change() call is guarded with the rw_semaphore
>> "set->update_nr_hwq_lock", but the guard is not the writer lock but the reader
>> lock. This does not serialize the sysfs writes.
> 
> Please see kernfs_fop_write_iter(), in which mutex is held before calling
> ->write().
> 
I think you're referring to @of->mutex here; however of->mutex is per struct
kernfs_open_file, which is associated with an open instance of the sysfs file.
The important point is that two separate opens can have different kernfs_open_file
instances and therefore different mutexes. Thus, concurrent write to same sysfs
attribute from two different processes may still be possible.


>>
>> I tried the patch below to replace the reader lock with the writer lock. With
>> a quick trial, it looks working. The kernel message is no longer observed and
>> the new test case does not cause hangs. I will do further testing to confirm
>> that this change does not trigger other new lockdep WARNs. Assuming it does not
>> have such side effects, I hope this fix approach is acceptable. It doesn't add
>> the new lock, so I think it's the better.
>>
>> diff --git a/block/elevator.c b/block/elevator.c
>> index 3bcd37c2aa34..b03185a217ff 100644
>> --- a/block/elevator.c
>> +++ b/block/elevator.c
>> @@ -813,7 +813,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>>   	 *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
>>   	 *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
>>   	 */
>> -	if (!down_read_trylock(&set->update_nr_hwq_lock)) {
>> +	if (!down_write_trylock(&set->update_nr_hwq_lock)) {
>>   		ret = -EBUSY;
>>   		goto out;
>>   	}
>> @@ -824,7 +824,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>>   	} else {
>>   		ret = -ENOENT;
>>   	}
>> -	up_read(&set->update_nr_hwq_lock);
>> +	up_write(&set->update_nr_hwq_lock);
>>   
>>   out:
>>   	if (ctx.type)
>>
>> [...]
>>
>>> blk_mq_sched_reg_debugfs already includes debugfs lock, so I feel the proper
>>> fix could be check & avoid the null-ptr-deref.
>>
>> Actually, null-ptr-deref is one of the failure symptoms. KASAN slab-user-after
>> free is also observed [3]. Then I'm guessing adding null checks may not be
>> enough.
>>
>>> Adding new lock should be the last straw usually, especially this one is
>>> depended by queue freeze.
>>
>> Got it, thanks.
>>
>>
>> [3] KASAN slab-use-after-free
> 
> Then you need to figure out the exact slab type and check if the pointer is cleared
> during free.
> 
> Anyway, there is guard already, not see reason to add new lock for covering
> it.
> 
Regarding the observed failure, my understanding is that blk_mq_debugfs_register_sched()
and blk_mq_debugfs_register_sched_hctx() access q->elevator without holding q->elevator_lock.
If multiple scheduler update paths run concurrently, one path can replace and free the
elevator while another path is still using it, which would explain the observed KASAN
use-after-free and NULL pointer dereference reports.

With the proposed change, upgrading update_nr_hwq_lock from a reader lock to a writer
lock in elv_iosched_store() would serialize concurrent scheduler updates and therefore
prevent multiple elevator switch operations from running at the same time.

The another way to fix this might be to acquire q->elevator_lock in blk_mq_sched_reg_debugfs()
and thus serialize access to q->elevator in blk_mq_debugfs_register_sched() and
blk_mq_debugfs_register_sched_hctx().

Thanks,
--Nilay
