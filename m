Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8861DF994
	for <linux-block@vger.kernel.org>; Fri, 18 Jul 2025 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752818846; cv=none; b=dQlHdDQtrHttxWbhD/KfvYiIeJ4iOTIbattq4VZgElUj2W7tGclSr3jAYHfNk9VWKIoTSHjgfwc+HkrMl8cZ9ZjU3a0cBmE01UABCd2DQ1mCap2wD0PAy+moGXqaIpi3kk54Dwj4z7ItGSqfKuhSP6IS18RlTwIi84Nw+ZvZCwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752818846; c=relaxed/simple;
	bh=smusSjXW4PcHx9IWKZ7Lt1faswFszf6+PwyD7ibxEB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nF9XJLqiODQZCkEIn0lBn3KCHGpVM6R0tPWaWlDav+P425vEBZNPRwL7co9zrbKZPU6C3s/uuTGdOTT6WuiwIqjmI4gnCL/ZA1XGrAj0ozfkOq1eP6+7QkWh48YjPx9hDPv3TeW6zQYOjeGQuFoQ/kTlokZ2JpYDl5TqAdv52io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ps2E9dLl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ps2E9dLl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I3xYSt008271;
	Fri, 18 Jul 2025 06:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qZKi9O
	ozz5+rEwBdcCKlXRfurtDzZmdp+EIYqBIfEfk=; b=ps2E9dLlNeHHS3tDTfPvQn
	jqqVk5MfGYPOTlGTsrLPQXu1TDfEejvX+gcMzmYoZMKwALy313jngfm0ty56mS/8
	Y8zmZW+XCk+cyf+YvlAaejpXRLJvx2NsmCyQUzavsEX4i3Hl3k1ySmyLG4DuzH16
	tVu/aVsYk/r1u3XEgHrhGrQGU9gjEy1aw6ee0S07qryp3X7XYj04Ue/+uRcz7nY1
	p9KvMbMfoV1Ojk0N0eEfOGQ1ZfvP1wo7433idr9Kzy7cFPfQa5XXUfSxPGjXa74l
	Glvdk3/fvxcfdzWiABCpJJB/B3yrvpvf94Zgb1CngwPHqVmcfT/aJenyrP8wccnQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc7f2q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 06:06:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56I11ndG008941;
	Fri, 18 Jul 2025 06:06:57 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hmyswp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 06:06:57 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56I66uQA32178852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 06:06:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92BBA5805A;
	Fri, 18 Jul 2025 06:06:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED0A258051;
	Fri, 18 Jul 2025 06:06:52 +0000 (GMT)
Received: from [9.43.101.121] (unknown [9.43.101.121])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Jul 2025 06:06:52 +0000 (GMT)
Message-ID: <2ab5e3c6-a3fd-4016-9f9b-f207fc6cc59e@linux.ibm.com>
Date: Fri, 18 Jul 2025 11:36:51 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: restore two stage elevator switch while running
 nr_hw_queue update
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, yi.zhang@redhat.com, hch@lst.de,
        yukuai1@huaweicloud.com, axboe@kernel.dk, shinichiro.kawasaki@wdc.com,
        yukuai3@huawei.com, gjoyce@ibm.com
References: <20250717141155.473362-1-nilay@linux.ibm.com>
 <aHkMaZnEVEEQc5TL@fedora>
 <2d4dc1c3-2911-469a-95b6-6b482377a375@linux.ibm.com>
 <aHmq_8uMsdq49iZT@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aHmq_8uMsdq49iZT@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Je68rVKV c=1 sm=1 tr=0 ts=6879e481 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Y4NEFrYPjUX1ZyM50J4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA0MyBTYWx0ZWRfX0DkEoeIpJt6H gBZX6vuyLlh2/IIktD+xKeMxx+KAkFDGfjap4Ipdgm1YDSphZQJvXs1zAAsfLOCAfyGVf+3TH/t CN4gXDWgZWcwo/Z2vywZxdZ8xRB0u1xHt4dcGF8N8C55u6G20IFQDDHtMNx3btsb+VkY5yP4KQq
 k26IqGQWIovr0pGOYdnRcabZIdF06sEXGN6r1SSEHFXx25JuLmKiqArcYbbPWlx4OpJhv5aOgol vbklFzNkyYtvN6WmUGDnoyuNZLNO5YqYjtq3uke86Ct86BtRpzxjUK40ViUhey4pQ1J5l9oYLyW rpW3az4307ZI2DMkxP5nePLxxO75SFuo7riFx2EjpwQNrlBJ6OZc55zx/ir9OCDFtl045FlojRg
 59IMPN2v5A8MbMuksV1WIPXnCnHJUzsJY0BD1DCd+cu2Ap4yfiFs+/q3CbTODjFyZi5QYcLF
X-Proofpoint-GUID: jy-hqV8LVYtIjboQ2XpLqjSpySt-UUFQ
X-Proofpoint-ORIG-GUID: jy-hqV8LVYtIjboQ2XpLqjSpySt-UUFQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180043



On 7/18/25 7:31 AM, Ming Lei wrote:
> On Fri, Jul 18, 2025 at 12:13:25AM +0530, Nilay Shroff wrote:
>>
>>
>> On 7/17/25 8:14 PM, Ming Lei wrote:
>>
>>>> +static int blk_mq_elv_switch_none(struct request_queue *q,
>>>> +		struct xarray *elv_tbl)
>>>> +{
>>>> +	int ret = 0;
>>>> +
>>>> +	lockdep_assert_held_write(&q->tag_set->update_nr_hwq_lock);
>>>> +
>>>> +	/*
>>>> +	 * Accessing q->elevator without holding q->elevator_lock is safe here
>>>> +	 * because we're called from nr_hw_queue update which is protected by
>>>> +	 * set->update_nr_hwq_lock in the writer context. So, scheduler update/
>>>> +	 * switch code (which acquires the same lock in the reader context)
>>>> +	 * can't run concurrently.
>>>> +	 */
>>>> +	if (q->elevator) {
>>>> +		char *elevator_name = (char *)q->elevator->type->elevator_name;
>>>> +
>>>> +		ret = xa_insert(elv_tbl, q->id, elevator_name, GFP_KERNEL);
>>>
>>> This way isn't memory safe, because elevator module can be reloaded
>>> during updating nr_hw_queues. One solution is to build a string<->int mapping
>>> table, and store the (int) index of elevator type to xarray.
>>>
>> Yes good point! How about avoiding this issue by using __elevator_get() and
>> elevator_put()? We can take module reference while switching elevator to 'none'
>> and then put the module reference while we switch back elevator.
> 
> Yeah, that is another way.
> 
So I will update this way in the next patch.

>>
>>>> -void elv_update_nr_hw_queues(struct request_queue *q)
>>>> -{
>>>> -	struct elv_change_ctx ctx = {};
>>>> -	int ret = -ENODEV;
>>>> -
>>>> -	WARN_ON_ONCE(q->mq_freeze_depth == 0);
>>>> -
>>>> -	mutex_lock(&q->elevator_lock);
>>>> -	if (q->elevator && !blk_queue_dying(q) && blk_queue_registered(q)) {
>>>> -		ctx.name = q->elevator->type->elevator_name;
>>>> -
>>>> -		/* force to reattach elevator after nr_hw_queue is updated */
>>>> -		ret = elevator_switch(q, &ctx);
>>>> -	}
>>>> -	mutex_unlock(&q->elevator_lock);
>>>> -	blk_mq_unfreeze_queue_nomemrestore(q);
>>>> -	if (!ret)
>>>> -		WARN_ON_ONCE(elevator_change_done(q, &ctx));
>>>> -}
>>>> -
>>>>  /*
>>>>   * Use the default elevator settings. If the chosen elevator initialization
>>>>   * fails, fall back to the "none" elevator (no elevator).
>>>> diff --git a/block/elevator.h b/block/elevator.h
>>>> index a07ce773a38f..440b6e766848 100644
>>>> --- a/block/elevator.h
>>>> +++ b/block/elevator.h
>>>> @@ -85,6 +85,17 @@ struct elevator_type
>>>>  	struct list_head list;
>>>>  };
>>>>  
>>>> +/* Holding context data for changing elevator */
>>>> +struct elv_change_ctx {
>>>> +	const char *name;
>>>> +	bool no_uevent;
>>>> +
>>>> +	/* for unregistering old elevator */
>>>> +	struct elevator_queue *old;
>>>> +	/* for registering new elevator */
>>>> +	struct elevator_queue *new;
>>>> +};
>>>> +
>>>
>>> You may avoid the big chunk of code move for both `elv_change_ctx` and 
>>> `elv_update_nr_hw_queues()`, not sure why you did that in a bug fix patch.
>>>
>> This is because I’ve reintroduced the blk_mq_elv_switch_none and 
>> blk_mq_elv_switch_back functions. I replaced elv_update_nr_hw_queues with
>> blk_mq_elv_switch_back(), which was the approach used prior to commit 
>> 596dce110b7d ("block: simplify elevator reattachment for updating nr_hw_queues").
>>
>> Both blk_mq_elv_switch_none and blk_mq_elv_switch_back are defined in blk-mq.c
>> and use the elevator APIs for switching elevators. These APIs — namely 
>> elevator_switch and elevator_change_done — rely on the elv_change_ctx structure.
>> As a result, I had to move some code around to ensure elv_change_ctx is accessible
>> from within blk-mq.c.
>>
>> While it would be possible to avoid this code movement by continuing to use 
>> elv_update_nr_hw_queues, I felt it was cleaner to restore the two-stage elevator
>> switch more fully by reintroducing the blk_mq_elv_switch_none and blk_mq_elv_switch_back 
>> APIs, which were used prior to the simplification in the aforementioned commit.
>>
>> Do you see any concerns with this code movement? Or is such restructuring generally
>> avoided in a bug fix patch?
> 
> You still can add blk_mq_elv_switch_none() and blk_mq_elv_switch_back(),
> meantime call elv_update_nr_hw_queues() from blk_mq_elv_switch_back() by
> passing elevator type name.
> 
> If one bug fix is simpler, it may become easier to review & merge in -rc or
> backport.
> 
Okay will do this way in the next version.

Thanks,
--Nilay

