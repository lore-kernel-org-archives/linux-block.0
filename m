Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2821F03EF
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744310269; cv=none; b=HqUfYnD+rKwOLkXhF71YyN+IztOd2v/hGNWfr7JmfWnu2N8IXJ+LvPjw+QTwTwU+bJHQmAEKKMaympBsGRU3sQwkCNz/5eZxsqzDHmfXVzw3yPhI0V+bdzQu701Bp/4ek2tKtK14LhjZdZ7HIhDOtV/jC9ohHwXj/Y/uTATZBDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744310269; c=relaxed/simple;
	bh=qNTlcDL07LtjOnPKttMmzreAa1rq1d60wUtEEwWwdus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgGtLSdYEGrzS9APIt5FWv9cINuvGxyhHEeX/y/AV6t31/38GqkwfKpUouOuy0cgoMzaXPNAAwJ/j5UxJAueL+71NQw1a3tNl7suX23LyU4iiHCq0UnZ5b+d+2Yp5LhA+FE38PljzVgCSos4uLmrZCcFDISwQ1xv/Lwy5joDfMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HFN1Qp8C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HFN1Qp8C"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ABMICw018446;
	Thu, 10 Apr 2025 18:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PUyQPt
	futjLaSXzwyQknc3lxG487OIQ8C53l29gICuU=; b=HFN1Qp8C9+K9VtxQyR+uMR
	MiN9XtJZGhQT+5RBYDDMlrorb30I46+ISAQgMwU36oeJ2zkBvyvuDaxCr8AIuQiW
	3jSR39NhSy4Ijqf5Ejtd2/SYs83ehvflSZsjKFyfy7eJy+5HpUfKaNRyyRQe0ugq
	qcBabt0Xdfj/TO0NHXmG7+nWIRbvlK7JmnuaHYX4hhjxLiiEoflnFrMac7Cg7gUw
	h6tZ5f/N4kQl827xgfecCnpKb0/PrDnqdh+kCDjMr/MAsEo7ahNzWUctom3XqOiV
	2jWv/n6hil9bqQs5kfiMhVwk5Nc30vyrsGhzwESmuLHR8BAYBU1q7BWmkDkEZn8w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x6ca4tf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 18:37:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53AFoE3e011522;
	Thu, 10 Apr 2025 18:37:39 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf7yykn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 18:37:39 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53AIbc6O16712218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 18:37:38 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63E8558054;
	Thu, 10 Apr 2025 18:37:38 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4218B5805A;
	Thu, 10 Apr 2025 18:37:36 +0000 (GMT)
Received: from [9.171.89.192] (unknown [9.171.89.192])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Apr 2025 18:37:35 +0000 (GMT)
Message-ID: <83f5e47a-8738-4776-ae23-7ff0cad7ba48@linux.ibm.com>
Date: Fri, 11 Apr 2025 00:07:34 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] block: unifying elevator change
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-10-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250410133029.2487054-10-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RQRAjFyx1WbjQN7mM6lmNcOLmfvZ5HmQ
X-Proofpoint-ORIG-GUID: RQRAjFyx1WbjQN7mM6lmNcOLmfvZ5HmQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100133



On 4/10/25 7:00 PM, Ming Lei wrote:
>  /*
>   * Use the default elevator settings. If the chosen elevator initialization
>   * fails, fall back to the "none" elevator (no elevator).
>   */
> -void elevator_init_mq(struct request_queue *q)
> +void elevator_set_default(struct request_queue *q)
>  {
> -	struct elevator_type *e;
> -	unsigned int memflags;
> +	struct elev_change_ctx ctx = { };
>  	int err;
>  
> -	WARN_ON_ONCE(blk_queue_registered(q));
> -
> -	if (unlikely(q->elevator))
> +	if (!queue_is_mq(q))
>  		return;
>  
> -	e = elevator_get_default(q);
> -	if (!e)
> +	ctx.name = use_default_elevator(q) ? "mq-deadline" : "none";
> +	if (!q->elevator && !strcmp(ctx.name, "none"))
>  		return;
> +	err = elevator_change(q, &ctx);
> +	if (err < 0)
> +		pr_warn("\"%s\" set elevator failed %d, "
> +			"falling back to \"none\"\n", ctx.name, err);
> +}
>  
If we fail to set the evator to default (mq-deadline) while registering queue, 
because nr_hw_queue update is simultaneously running then we may end up setting 
the queue elevator to none and that's not correct. Isn't it?

> +void elevator_set_none(struct request_queue *q)
> +{
> +	struct elev_change_ctx ctx = {
> +		.name	= "none",
> +		.uevent = 1,
> +	};
> +	int err;
>  
> -	blk_mq_unfreeze_queue(q, memflags);
> +	if (!queue_is_mq(q))
> +		return;
>  
> -	if (err) {
> -		pr_warn("\"%s\" elevator initialization failed, "
> -			"falling back to \"none\"\n", e->elevator_name);
> -	}
> +	if (!q->elevator)
> +		return;
>  
> -	elevator_put(e);
> +	err = elevator_change(q, &ctx);
> +	if (err < 0)
> +		pr_warn("%s: set none elevator failed %d\n", __func__, err);
>  }
>  
Here as well if we fail to disable/exit elevator while deleting disk 
because nr_hw_queue update is simultaneously running  then we may
leak elevator resource? 

> @@ -565,11 +559,7 @@ int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
>  	if (disk->major == BLOCK_EXT_MAJOR)
>  		blk_free_ext_minor(disk->first_minor);
>  out_exit_elevator:
> -	if (disk->queue->elevator) {
> -		mutex_lock(&disk->queue->elevator_lock);
> -		elevator_exit(disk->queue);
> -		mutex_unlock(&disk->queue->elevator_lock);
> -	}
> +	elevator_set_none(disk->queue);
Same comment as above here as well but this is in add_disk code path.

Thanks,
--Nilay

