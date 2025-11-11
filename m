Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8934D23B61A
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 06:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843792; cv=none; b=OR01qetTCMHtSlyLPhufVq7CQR6DPCZfHGJycxUzaQQVmUITHfh/zOnHuEG119z1dpacs3y6NZwS0iMRzzEDGLqzkaVjXvXNA8Zk6xFDSwBdxNxRU6RPe6vxbb6W/AG6jDk42z8K7zPfaXOlKdZmotKzD1/begpgF/YW+n30TRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843792; c=relaxed/simple;
	bh=7P0nIObG7UWaSTTejXioh1yiuGepDfXD0TmBpx4a6KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icojRk0slKlxvfCfO1Uq4N2Ul+wy2dtDZz7vqnQ7RSsUnYE8ob6o5qlrOmrKlUj97VA6982r8OVikhuaAyIFGf3Rp5iTFIt4+6Ovp0nX7U19eHqw6e35EG21aiIOUCDVT4HEflVIVaSibfwlNz0RVes3lLJa4TQkfMVknUz/640=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MPX0YcRS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MPX0YcRS"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB3l7UE019248;
	Tue, 11 Nov 2025 06:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w44lE7
	7EWY8dFAcU/4qsbclwDCFhQhfRpHKi/IhmyKk=; b=MPX0YcRSFdL/vTokUSUvCT
	6MaRFbxpm/2d5FdvrAAOx2e1RzxXvAUmxLMhfBskq4cK4UqcfyfCT57fKarRGP+F
	ZIJeBamTnPlOiZ1+DsuoLUYYazKj+TJL7eCCofwfKh+mzjtiPWgILOtXjv3ZJlj8
	SbIeFjQB9HB4YZlu57Z0slSp/iyN59ij3VSugLVctaJXWMd/ceSMOOFeY1UcRYIc
	Zl/7rWwK9BFSNPN3qjzIi2gtyLYeJdqH1loyKxSnh1sgeoPOo8Qnt1bktAGP2Gt2
	f9zeVqcrpkkcj3SvzmooSzyqBJMEWI574nBvzp225Bgp9X1bZpcEGzkNG70wF4yA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgwtkvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 06:49:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB5Bdqr014859;
	Tue, 11 Nov 2025 06:49:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpk1f4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 06:49:37 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AB6na5f14156308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 06:49:36 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 366275804E;
	Tue, 11 Nov 2025 06:49:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 588235803F;
	Tue, 11 Nov 2025 06:49:33 +0000 (GMT)
Received: from [9.109.198.139] (unknown [9.109.198.139])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Nov 2025 06:49:33 +0000 (GMT)
Message-ID: <e614a4e4-2030-4edf-ae74-dcaebc71221a@linux.ibm.com>
Date: Tue, 11 Nov 2025 12:19:31 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 2/5] block: move elevator tags into struct
 elevator_resources
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
        yi.zhang@redhat.com, czhong@redhat.com, yukuai@fnnas.com,
        gjoyce@ibm.com
References: <20251110081457.1006206-1-nilay@linux.ibm.com>
 <20251110081457.1006206-3-nilay@linux.ibm.com> <aRKk5uz5altdiEil@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aRKk5uz5altdiEil@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ORPdQq2FxDsy3sLEX0s7g0zQpRiBRTQd
X-Proofpoint-ORIG-GUID: ORPdQq2FxDsy3sLEX0s7g0zQpRiBRTQd
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=6912dc81 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=wspqj8QR-kYkxBFrkRkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX3UINfB6/Pro5
 xCDAbUDwNe54Twb+GeYJj0vNmyvxNGZo+SOl5jrzRVeLTBQjgrF24QMrI6nxe5Mi70R/Hdb6483
 oR5Hflec5r/f7kxHWGWzq6k1I7erQLOgBEQisRQD8gy4bQtPid38f0NdBHWDU0oihgZABo6r4Mf
 KtIyN7xEBSzG5E72J9yEANKn4+kCp7TfBAGHfsBsMyWG25OCZHnKrwgFlLbvjotUBKAIsK/6JZy
 eIHy77dWhz/HslwudRO1CWYdtjDtM8JWd7GmoMTD8Q0SckagEs7AUKPlPr0Z4TSGqQDN7bKMibB
 dwmsj+dGxfeX3M3OXhALy9tTzPVeG0KfqPgVHHdg6gW4wfpiOBTuLPZdmiheqNHkOoAJIEvACQe
 sFCJMzInFLKXop/RiWaGZinODx+mEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022


>>  
>> -int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
>> +int blk_mq_alloc_sched_res(struct elevator_resources *res,
>> +		struct blk_mq_tag_set *set, unsigned int nr_hw_queues)
> 
> In patch 4, `struct request_queue *` is added to parameter of
> blk_mq_alloc_sched_res(), so why not add it from beginning?
> Then ` struct blk_mq_tag_set *set` can be avoided.
> 
> Similar with blk_mq_free_sched_res().
> 
> This way is more readable, because scheduler is request_queue
> wide.
> 
Yes this makes sense to me and good point! I'll spin 
another patch and address it.

>>  /* caller must have a reference to @e, will grab another one if successful */
>>  int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
>> -		struct elevator_tags *et)
>> +		struct elevator_resources *res)
>>  {
>>  	unsigned int flags = q->tag_set->flags;
>>  	struct blk_mq_hw_ctx *hctx;
>> @@ -588,23 +603,23 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
>>  	unsigned long i;
>>  	int ret;
>>  
>> -	eq = elevator_alloc(q, e, et);
>> +	eq = elevator_alloc(q, e, res->et);
>>  	if (!eq)
>>  		return -ENOMEM;
>>  
>> -	q->nr_requests = et->nr_requests;
>> +	q->nr_requests = res->et->nr_requests;
>>  
>>  	if (blk_mq_is_shared_tags(flags)) {
>>  		/* Shared tags are stored at index 0 in @et->tags. */
>> -		q->sched_shared_tags = et->tags[0];
>> -		blk_mq_tag_update_sched_shared_tags(q, et->nr_requests);
>> +		q->sched_shared_tags = res->et->tags[0];
>> +		blk_mq_tag_update_sched_shared_tags(q, res->et->nr_requests);
>>  	}
>>  
>>  	queue_for_each_hw_ctx(q, hctx, i) {
>>  		if (blk_mq_is_shared_tags(flags))
>>  			hctx->sched_tags = q->sched_shared_tags;
>>  		else
>> -			hctx->sched_tags = et->tags[i];
>> +			hctx->sched_tags = res->et->tags[i];
>>  	}
> 
> Adding one local variable of 'et' could kill all above changes, looks you like
> big patch, but up to you.
> 
Yeah, I see what you meant earlier — I think I misunderstood it the first time.
I’m on the same page now and will address this in the next version. 
By the way, I also like the slim patch :)

Thanks,
--Nilay

