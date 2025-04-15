Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC382610B
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744720269; cv=none; b=fisWT8elbc/7G45S9BlaFoCCpl/klLRz+l8aN6tsBLEDwaenA9a8v8f9s24sDM/a4eLAe/5aAwJAqaidxreE2n1vgsKZ1hLqHA+n5Fwkc65eCX4sVloR62n4PgguByMYXkLHEhmK1ArS42P0cZ9BEGoP/eh606NTVDjGp+6QvsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744720269; c=relaxed/simple;
	bh=wTvw4/NLRfEE12H+cVHYOrfyt8XJomnjNaq4Y9YoEFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzQ46bS16XuaYeZIOE8Mb5/S/bxAF3JyL3qVXXF5MKASwnZ6rzR+Zju+GUVGaS4db6v2smRL/yYBIgHWWfqBmiUUs0qTdZRUTXwXCNtwlk3RRWpjGvbU79T85hTCBmvHDPvbEhLDy1Wq3YZmKs+sAX6ukeZFHxcFW6OY5Vqk0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UCJorv4t; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UCJorv4t"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FCCTW9003551;
	Tue, 15 Apr 2025 12:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZNSS4I
	qfwgAtRHi/MW7LJ8hkNYUa2GnW5J7KXcQa4K4=; b=UCJorv4tubqgec7CYmSaXQ
	4OOzv8S/4i2SKVvr8MhilefawL/f1GmNlovatBfJLsyyTNs8LdZSpLYWosrhW0Mj
	XUc12kEa1PYdUX+aupDV/9myhj5ACR5OzACLHDu8EyRQeHdGxf0P1qZdqUrKsKqx
	zT/O0si0X/2DLMQDOtIA3YUnn1YDEWVlkk9eifNgM/5PbJ1ex3Sib95Rb722ECQZ
	/Q6avEuhlhsgrGIO/hgqJk9ohGbGjvZn6mZY/jLqy5tSAZJ1Kr4H1e/eLiabHFLu
	Gxq2OofQF2RQqTPuhdI6BXG4NKx9km3+JJg29oVMSX3lOlLmbCwd0VdEA97yY4cA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461cax2y2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 12:30:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53FC2Ge3016689;
	Tue, 15 Apr 2025 12:30:51 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4605722rgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 12:30:51 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53FCUpHt24117882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:30:51 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1437A58053;
	Tue, 15 Apr 2025 12:30:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0719B58043;
	Tue, 15 Apr 2025 12:30:49 +0000 (GMT)
Received: from [9.179.13.11] (unknown [9.179.13.11])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 12:30:48 +0000 (GMT)
Message-ID: <a5896cdb-a59a-4a37-9f99-20522f5d2987@linux.ibm.com>
Date: Tue, 15 Apr 2025 18:00:47 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] block: unifying elevator change
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-10-ming.lei@redhat.com>
 <83f5e47a-8738-4776-ae23-7ff0cad7ba48@linux.ibm.com>
 <Z_xjQ3djcyF39F_w@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z_xjQ3djcyF39F_w@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7odtm6R7hgEKp04zrGvbQa7wdHo9-o-1
X-Proofpoint-GUID: 7odtm6R7hgEKp04zrGvbQa7wdHo9-o-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504150089



On 4/14/25 6:52 AM, Ming Lei wrote:
> On Fri, Apr 11, 2025 at 12:07:34AM +0530, Nilay Shroff wrote:
>>
>>
>> On 4/10/25 7:00 PM, Ming Lei wrote:
>>>  /*
>>>   * Use the default elevator settings. If the chosen elevator initialization
>>>   * fails, fall back to the "none" elevator (no elevator).
>>>   */
>>> -void elevator_init_mq(struct request_queue *q)
>>> +void elevator_set_default(struct request_queue *q)
>>>  {
>>> -	struct elevator_type *e;
>>> -	unsigned int memflags;
>>> +	struct elev_change_ctx ctx = { };
>>>  	int err;
>>>  
>>> -	WARN_ON_ONCE(blk_queue_registered(q));
>>> -
>>> -	if (unlikely(q->elevator))
>>> +	if (!queue_is_mq(q))
>>>  		return;
>>>  
>>> -	e = elevator_get_default(q);
>>> -	if (!e)
>>> +	ctx.name = use_default_elevator(q) ? "mq-deadline" : "none";
>>> +	if (!q->elevator && !strcmp(ctx.name, "none"))
>>>  		return;
>>> +	err = elevator_change(q, &ctx);
>>> +	if (err < 0)
>>> +		pr_warn("\"%s\" set elevator failed %d, "
>>> +			"falling back to \"none\"\n", ctx.name, err);
>>> +}
>>>  
>> If we fail to set the evator to default (mq-deadline) while registering queue, 
>> because nr_hw_queue update is simultaneously running then we may end up setting 
>> the queue elevator to none and that's not correct. Isn't it?
> 
> It still works with none.
> 
> I think it isn't one big deal. And if it is really one issue in future, we can
> set one flag in elevator_set_default(), and let blk_mq_update_nr_hw_queues set
> default sched for us.
> 
>>
>>> +void elevator_set_none(struct request_queue *q)
>>> +{
>>> +	struct elev_change_ctx ctx = {
>>> +		.name	= "none",
>>> +		.uevent = 1,
>>> +	};
>>> +	int err;
>>>  
>>> -	blk_mq_unfreeze_queue(q, memflags);
>>> +	if (!queue_is_mq(q))
>>> +		return;
>>>  
>>> -	if (err) {
>>> -		pr_warn("\"%s\" elevator initialization failed, "
>>> -			"falling back to \"none\"\n", e->elevator_name);
>>> -	}
>>> +	if (!q->elevator)
>>> +		return;
>>>  
>>> -	elevator_put(e);
>>> +	err = elevator_change(q, &ctx);
>>> +	if (err < 0)
>>> +		pr_warn("%s: set none elevator failed %d\n", __func__, err);
>>>  }
>>>  
>> Here as well if we fail to disable/exit elevator while deleting disk 
>> because nr_hw_queue update is simultaneously running  then we may
>> leak elevator resource? 
> 
> When blk_mq_update_nr_hw_queues() observes that queue is dying, it
> forces to change elevator to none, so there isn't elevator leak issue.
> 
Yes if we get into blk_mq_update_nr_hw_queues after dying flag is set.
But what if blk_mq_update_nr_hw_queues doesn't see dying flag and starts 
running __elevator_change. However later we set dying flag from del_gendisk
and starts running elevator_set_none simultaneously on another cpu? 
In this case elevator_set_none would fail to set the elevator to "none" as 
blk_mq_update_nr_hw_queues is running on another cpu. Isn't it?

>>
>>> @@ -565,11 +559,7 @@ int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
>>>  	if (disk->major == BLOCK_EXT_MAJOR)
>>>  		blk_free_ext_minor(disk->first_minor);
>>>  out_exit_elevator:
>>> -	if (disk->queue->elevator) {
>>> -		mutex_lock(&disk->queue->elevator_lock);
>>> -		elevator_exit(disk->queue);
>>> -		mutex_unlock(&disk->queue->elevator_lock);
>>> -	}
>>> +	elevator_set_none(disk->queue);
>> Same comment as above here as well but this is in add_disk code path.
> 
> We can avoid it by forcing to change to none in blk_mq_update_nr_hw_queues() for
> !blk_queue_registered()
> 
Here as well there's a thin race window possible assuming add_disk fails 
after we registered queue. Assuming nr_hw_queue update starts running
and it sees queue is registered however on another cpu add_disk fails 
just after registering queue. So in this case still it might be possible
that elevator_set_none might fail to set elevator to "none" just because
nr_hw_queue update is running on another cpu. What do you think?

Thanks,
--Nilay



