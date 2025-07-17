Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9B2116E9
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777835; cv=none; b=Gs4Bck2zPrKCEML8m0qEZdFUPt9QPyMtGlC9C9z+WUhh/g8PVD/+zsHJ2iDGfsWllFBDge44QsllFPf/JxHjkos9wJfdj4jfXoh/HT/97lxLJ2EulYmIwUFS5liJnfLREna6yjOh7QB/85b86da4su62dm5R4mLCgVIUzS4IXMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777835; c=relaxed/simple;
	bh=feN31mBuhx8DuT4I72NZd+CeRzVqpSZF9wci8wt4blg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkCj6xMJHCJRi6jrgVYpfNiCzfxtClqrhrlBDZDpp4ew4VjA26fiEvAuam9wnvgTREEVm62ALU6LSqyuTX8bCbueattr4U/FbZYKspgb6qQpP2qQ6kF8jYrcLqfcYVavmLzkDNqwtpQ566nFY81ktOklUEEvnyWO2suQEpJqRBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F5JDm5OA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F5JDm5OA"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HDaC7W028062;
	Thu, 17 Jul 2025 18:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KZo7pj
	u6J3yYBQSfHvKuptlrktSPmItWm1rwEHegGTg=; b=F5JDm5OA6uDjz4EJaqng8N
	Ku3kRHfsmurF8OJ+DIMvjf0+g2t9recO5bwB3zj0Gz8Y8P5bIbHE16h095D/crsY
	ZrdxNTBLTeCxtH3cj/36bHmqHZ2GoldpyKWkUrhFlz4LBoqXYTZ5eFPtbpd1hqek
	L0Ej/WkV6PfbnECyVqsatBILQzorgWGAEpnSy5Ybk+41L0FEsnv8dbStpFgmNs5h
	4bSl2EQrgaROMzOAUsSYRtIQmf20KJcp/318/FF8OWrIZtsTal09V4123IuHhp++
	lHhNdizU5V+xsxZSW/AqCyx6QE7VEvOJIVkT2d0TTofCE27yLoh6Qz2AT10Q6jdw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vamu8ayv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 18:43:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGNAEH025788;
	Thu, 17 Jul 2025 18:43:32 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v31pwv6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 18:43:32 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56HIhV7C9700786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 18:43:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8457B5805C;
	Thu, 17 Jul 2025 18:43:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8487F5805A;
	Thu, 17 Jul 2025 18:43:27 +0000 (GMT)
Received: from [9.43.101.121] (unknown [9.43.101.121])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Jul 2025 18:43:27 +0000 (GMT)
Message-ID: <2d4dc1c3-2911-469a-95b6-6b482377a375@linux.ibm.com>
Date: Fri, 18 Jul 2025 00:13:25 +0530
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aHkMaZnEVEEQc5TL@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0itJ3f4qsWv2nYAP2XTpKuIbfPR8NDMY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE2MiBTYWx0ZWRfX2ykOs5zP+yFu op/zenJQsyKCPFBXoQE1gn7TsTT5cVN2zdHRm3ThOo3RsbDoRvRb+4X8tGcxsB7DsYGo8YVt0uB pYKI1qgfAYSpw2BNWsfo2VzV3SSziJ4Zfi2D5rgx5JFONwNOrDHUwYTCk+2W4SId36BMN2oMIIf
 twABc6rF6HV9fiHSlZt8ZhHlvDEwoqWLBP3qMMkW8UcyC1D0qocgz7ajkwjY97178v6Nid85d32 bZLhU5yDrWubsl1t+EhdWdwCDg6YUA6j+XTbXeI++corC5+ddF4g9vto7m1GOzms/fKvNY0vF0g VyU8El8rOHG9tvsbKnyxed62lNsXK11v+BX6VsnsMy1axnusZbaNPZVNgXSHAAhIvyDjSO0hpDa
 LyZ93pDxzkl5s/g9dhTsKMVokjllBmPaK/pKhpsGPRQkAQRm5H3p/CNZkF9sSPLMVqWv+1Qb
X-Proofpoint-ORIG-GUID: 0itJ3f4qsWv2nYAP2XTpKuIbfPR8NDMY
X-Authority-Analysis: v=2.4 cv=dNSmmPZb c=1 sm=1 tr=0 ts=68794455 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=XavNmLzDz9nI7Ap6eRYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170162



On 7/17/25 8:14 PM, Ming Lei wrote:

>> +static int blk_mq_elv_switch_none(struct request_queue *q,
>> +		struct xarray *elv_tbl)
>> +{
>> +	int ret = 0;
>> +
>> +	lockdep_assert_held_write(&q->tag_set->update_nr_hwq_lock);
>> +
>> +	/*
>> +	 * Accessing q->elevator without holding q->elevator_lock is safe here
>> +	 * because we're called from nr_hw_queue update which is protected by
>> +	 * set->update_nr_hwq_lock in the writer context. So, scheduler update/
>> +	 * switch code (which acquires the same lock in the reader context)
>> +	 * can't run concurrently.
>> +	 */
>> +	if (q->elevator) {
>> +		char *elevator_name = (char *)q->elevator->type->elevator_name;
>> +
>> +		ret = xa_insert(elv_tbl, q->id, elevator_name, GFP_KERNEL);
> 
> This way isn't memory safe, because elevator module can be reloaded
> during updating nr_hw_queues. One solution is to build a string<->int mapping
> table, and store the (int) index of elevator type to xarray.
> 
Yes good point! How about avoiding this issue by using __elevator_get() and
elevator_put()? We can take module reference while switching elevator to 'none'
and then put the module reference while we switch back elevator.

>> -void elv_update_nr_hw_queues(struct request_queue *q)
>> -{
>> -	struct elv_change_ctx ctx = {};
>> -	int ret = -ENODEV;
>> -
>> -	WARN_ON_ONCE(q->mq_freeze_depth == 0);
>> -
>> -	mutex_lock(&q->elevator_lock);
>> -	if (q->elevator && !blk_queue_dying(q) && blk_queue_registered(q)) {
>> -		ctx.name = q->elevator->type->elevator_name;
>> -
>> -		/* force to reattach elevator after nr_hw_queue is updated */
>> -		ret = elevator_switch(q, &ctx);
>> -	}
>> -	mutex_unlock(&q->elevator_lock);
>> -	blk_mq_unfreeze_queue_nomemrestore(q);
>> -	if (!ret)
>> -		WARN_ON_ONCE(elevator_change_done(q, &ctx));
>> -}
>> -
>>  /*
>>   * Use the default elevator settings. If the chosen elevator initialization
>>   * fails, fall back to the "none" elevator (no elevator).
>> diff --git a/block/elevator.h b/block/elevator.h
>> index a07ce773a38f..440b6e766848 100644
>> --- a/block/elevator.h
>> +++ b/block/elevator.h
>> @@ -85,6 +85,17 @@ struct elevator_type
>>  	struct list_head list;
>>  };
>>  
>> +/* Holding context data for changing elevator */
>> +struct elv_change_ctx {
>> +	const char *name;
>> +	bool no_uevent;
>> +
>> +	/* for unregistering old elevator */
>> +	struct elevator_queue *old;
>> +	/* for registering new elevator */
>> +	struct elevator_queue *new;
>> +};
>> +
> 
> You may avoid the big chunk of code move for both `elv_change_ctx` and 
> `elv_update_nr_hw_queues()`, not sure why you did that in a bug fix patch.
> 
This is because I’ve reintroduced the blk_mq_elv_switch_none and 
blk_mq_elv_switch_back functions. I replaced elv_update_nr_hw_queues with
blk_mq_elv_switch_back(), which was the approach used prior to commit 
596dce110b7d ("block: simplify elevator reattachment for updating nr_hw_queues").

Both blk_mq_elv_switch_none and blk_mq_elv_switch_back are defined in blk-mq.c
and use the elevator APIs for switching elevators. These APIs — namely 
elevator_switch and elevator_change_done — rely on the elv_change_ctx structure.
As a result, I had to move some code around to ensure elv_change_ctx is accessible
from within blk-mq.c.

While it would be possible to avoid this code movement by continuing to use 
elv_update_nr_hw_queues, I felt it was cleaner to restore the two-stage elevator
switch more fully by reintroducing the blk_mq_elv_switch_none and blk_mq_elv_switch_back 
APIs, which were used prior to the simplification in the aforementioned commit.

Do you see any concerns with this code movement? Or is such restructuring generally
avoided in a bug fix patch?

Thanks,
--Nilay
