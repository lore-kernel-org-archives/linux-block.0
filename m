Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D3BC8FE
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762152916; cv=none; b=LVocXtI30w9JQRCIb2MJcC0nf039+IZ0m8PX8n7bEnyRcmDGNCG0gblPp3d61JRphGZ+zhu+gdsexOjHVgi+RuvtTUSfK2X6GPstlypsQvkKRvK2cFwO1jvGq8gtL4QgtYqmPRIYFhvDVXw4904wsAqkXkMClFpVnAliKmtORE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762152916; c=relaxed/simple;
	bh=p8yxp5/+EJSTMAUXo1GLbkETyfhQIavskwBEODWjoiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guFuxj3iLlkVS1819+VDv+YUBu54NYNFAHfPXLxuhFt930QDPOm8HWjWujdlqyxjn8makd01UoczgPwlrY/JSgFOmOzUnRbVIHXeWFqkG19SaL7651rUKUdMYTQTaW2WAqwanHMzN/3JB2f2OfZ59HM8qxBrXER21CDHG/IE9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UC8TVTd1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UC8TVTd1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2Hlc7h021158;
	Mon, 3 Nov 2025 06:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eMWuHB
	XdDI7s+zR5WL9VSb14k5vTeSZT38EQVr4mWTo=; b=UC8TVTd1Peq9wz3EY6Rw9d
	YesJS0wmKxG+L+5vYh3bNzmisDRLl7gV1PlpJVA2VIs3sB2D99GezFVV5+e29rE0
	U7aBajMlJYDZNWe1FegiW0I2L+KTY3IarJqxyCiLeif9p4kbhJjFMkTbe2uA+kPG
	e0a7WFOQKavvRo8CgJzup1jSWXkG1QHjNiWpdDCwoBexWLzSEt+Kc5r7C28EDxCZ
	j6/VnyEOErneZt9i0UMZ8Ousby837UHYSWurt7dGuRoIKbx9mnSrAuk3u7eF2j4r
	7P0iC6VXrqMHW/hXN7LnVVwYaYdAIE/+jHDH7wAdg2AE7loofhYHgyKcNpt/TD+w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a58mknafh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 06:55:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A32i24p018659;
	Mon, 3 Nov 2025 06:55:08 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5whn48cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 06:55:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A36t7pW22807256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 06:55:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79F0958062;
	Mon,  3 Nov 2025 06:55:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F46058052;
	Mon,  3 Nov 2025 06:55:05 +0000 (GMT)
Received: from [9.61.101.239] (unknown [9.61.101.239])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Nov 2025 06:55:04 +0000 (GMT)
Message-ID: <512a4b9d-ca74-4465-8945-ae2d958611a3@linux.ibm.com>
Date: Mon, 3 Nov 2025 12:25:03 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 3/4] block: introduce alloc_sched_data and
 free_sched_data elevator methods
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
        yi.zhang@redhat.com, czhong@redhat.com, gjoyce@ibm.com
References: <20251029103622.205607-1-nilay@linux.ibm.com>
 <20251029103622.205607-4-nilay@linux.ibm.com> <aQgqw-DX1A3R3wuN@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aQgqw-DX1A3R3wuN@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZHmaC6saNvT9B2W_8s29V9ij9nBnnF2A
X-Proofpoint-GUID: ZHmaC6saNvT9B2W_8s29V9ij9nBnnF2A
X-Authority-Analysis: v=2.4 cv=SqidKfO0 c=1 sm=1 tr=0 ts=690851cc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ph5sbopXde0_WqADPKQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwOSBTYWx0ZWRfX7VyZcClAp+SE
 cYabtMLAbfb7K5A8wNnN9T3dhhNlEdkfieQArwA4+zsjWOsuhN1cgINiLzhMNL81xARiOT3EdhM
 Q1LTl6+ExHC+bVXQbjlvhXnrxscI9hhWgN0rZEEHeN27+rWJfBTbYaeaRAi/XttxVbB6DSctef/
 H4rDNn0lBpFrPjH2URpmexhiRYh3e1mugmIfS6/zP+qH+TEsfbBKI/3BspyNWMFZkRBfXskv54p
 QWCX73FNUxJzBKhNOQADz22eONm0As9zfICxhwnGsayCXt+nBRCgfoP0YUa4qxJUzT9lMqAQeo3
 pOS+OBhdG22GlcrrKIQC6ewDKF9brBSsVGlYJg1KrmvShV56XR/WZACZCgDXw2vA1TCmf7afbvI
 WqKL7enGDzctOWjpKjbZw3QB+FzJ/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010009


>>  
>> -int blk_mq_alloc_sched_res(struct elevator_resources *res,
>> -		struct blk_mq_tag_set *set, unsigned int nr_hw_queues)
>> +int blk_mq_alloc_sched_res(struct request_queue *q,
>> +		struct elevator_type *type,
>> +		struct elevator_resources *res,
>> +		struct blk_mq_tag_set *set,
>> +		unsigned int nr_hw_queues)
>>  {
>> +	int ret;
>> +
>>  	res->et = blk_mq_alloc_sched_tags(set, nr_hw_queues,
>>  			blk_mq_default_nr_requests(set));
>>  	if (!res->et)
>>  		return -ENOMEM;
>>  
>> -	return 0;
>> +	ret = blk_mq_alloc_sched_data(q, type, &res->data);
>> +	if (ret)
>> +		kfree(res->et);
> 
> use blk_mq_free_sched_res() instead of kfree() for avoiding memleak.
> 
Yeah will do.

>> @@ -681,11 +686,15 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
>>  	blk_mq_unfreeze_queue(q, memflags);
>>  	if (!ret)
>>  		ret = elevator_change_done(q, ctx);
>> +
>> +	if (ctx->new) /* switching to new elevator is successful */
>> +		return ret;
>> +
> 
> Not necessary.
> 
Agreed...

>> @@ -711,11 +720,14 @@ void elv_update_nr_hw_queues(struct request_queue *q,
>>  	blk_mq_unfreeze_queue_nomemrestore(q);
>>  	if (!ret)
>>  		WARN_ON_ONCE(elevator_change_done(q, ctx));
>> +
>> +	if (ctx->new) /* switching to new elevator is successful */
>> +		return;
> 
> Not necessary.
Agreed...> 
>>  	/*
>>  	 * Free sched resource if it's allocated but we couldn't switch elevator.
>>  	 */
>>  	if (!ctx->new)
>> -		blk_mq_free_sched_res(&ctx->res, set);
>> +		blk_mq_free_sched_res(&ctx->res, ctx->type, set);
>>  }
>>  
>>  /*
>> @@ -729,7 +741,6 @@ void elevator_set_default(struct request_queue *q)
>>  		.no_uevent = true,
>>  	};
>>  	int err;
>> -	struct elevator_type *e;
>>  
>>  	/* now we allow to switch elevator */
>>  	blk_queue_flag_clear(QUEUE_FLAG_NO_ELV_SWITCH, q);
>> @@ -742,8 +753,8 @@ void elevator_set_default(struct request_queue *q)
>>  	 * have multiple queues or mq-deadline is not available, default
>>  	 * to "none".
>>  	 */
>> -	e = elevator_find_get(ctx.name);
>> -	if (!e)
>> +	ctx.type = elevator_find_get(ctx.name);
>> +	if (!ctx.type)
>>  		return;
>>  
>>  	if ((q->nr_hw_queues == 1 ||
>> @@ -753,7 +764,7 @@ void elevator_set_default(struct request_queue *q)
>>  			pr_warn("\"%s\" elevator initialization, failed %d, falling back to \"none\"\n",
>>  					ctx.name, err);
>>  	}
>> -	elevator_put(e);
>> +	elevator_put(ctx.type);
>>  }
>>  
>>  void elevator_set_none(struct request_queue *q)
>> @@ -802,6 +813,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>>  	ctx.name = strstrip(elevator_name);
>>  
>>  	elv_iosched_load_module(ctx.name);
>> +	ctx.type = elevator_find_get(ctx.name);
>>  
>>  	down_read(&set->update_nr_hwq_lock);
>>  	if (!blk_queue_no_elv_switch(q)) {
>> @@ -812,6 +824,9 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>>  		ret = -ENOENT;
>>  	}
>>  	up_read(&set->update_nr_hwq_lock);
>> +
>> +	if (ctx.type)
>> +		elevator_put(ctx.type);
>>  	return ret;
> 
> The above change can be unified into elevator_change() by one standalone
> patch, so elv_iosched_store() can be covered too.
> 

Hmm, I think it’s not possible to create a standalone patch here, because this
change modifies the prototypes of blk_mq_alloc_sched_res() and blk_mq_free_sched_res().
As a result, both the nr_hw_queues update path and the elevator_change() code paths
need to be updated in the same patch. That said, it might still be possible to split
this work into two patches:
Patch 1: Introduce the new ->alloc_sched_data and ->free_sched_data methods in 
         struct elevator_mq_ops, and add the helper functions blk_mq_alloc_sched_data()
         and blk_mq_free_sched_data().
Patch 2: Update the nr_hw_queues update path and the elevator switch code paths to make
         use of these new methods.

Let me know what you think about this approach.

Thanks,
--Nilay

