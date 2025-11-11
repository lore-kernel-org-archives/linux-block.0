Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33FD23AE9A
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762850293; cv=none; b=UqK0gQocS+qesDeq5AkPQKgXcVCCqA1hihmRwuSyYnXd0HlgpajKuoSW3LWUfOr24HnQ6Q5FECo6GbKY9PgbnxAiABuEWNLI1FtVl5MqegeGw7/x0m4yrRneC9zhSzZ+Oav5h6OWu2S95wVajx8mAptFPAuiZmV0jT+Fa1gMRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762850293; c=relaxed/simple;
	bh=tHcPFQqrDhCHhj+T2XnzBcmIGPcnQ8wFlvGeEN+PU9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEfYERghBAjLG0et6BFbfJ3lqelfQtnrOkvIiJ0QpAaE35d8bpHkPppXVr03gzOimExUOhYUcMPqkLq8t0GhBVdVOoJWS85aE6VJ958F2w7dhk1lbLUjiHJavX9FSG+0BaDo3HefpEwABX4rkznCZeS5mI2MD2XiH4bJWXupUFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GK+Pgk7t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GK+Pgk7t"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB53SNY016768;
	Tue, 11 Nov 2025 08:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NXnQ/m
	i1H7RYCJjKETo/U+4b7iegsHOx3Z07fDCojsg=; b=GK+Pgk7tWUnX8QRq+KrNij
	2pW2bW22q+NMDFrgupjJAATmex9WeS3UG0P90kVwKBSgP8jRJ+GThvZdWvVjuaBH
	bzu6NQAIoH7pxGDs3ZwAvKXY1IMmLQY5G2gmF94dFagjsgkomOP+PAKqdDcnoKnp
	4yqwGgANYq3OGbvjRthnVHvybHzUCELqOBMtYjXXHLlG8oOyPwwNlmeqpbwV+OVr
	hNWzsffBxMBuREAER3/GpNJh4BRyMmfCvYLfPCpWdC1e091Xu6bM/Zc0nkESLQWu
	Eszlz3x14N1wZjM4yOosRLlzmovEMTDo2LOwsDnhvFEbaPmYv2cENosKnrjwaKwg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc7482h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 08:37:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB5h0qM008239;
	Tue, 11 Nov 2025 08:37:54 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aah6msv9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 08:37:54 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AB8brtU30933512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 08:37:53 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6855858055;
	Tue, 11 Nov 2025 08:37:53 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A87555805B;
	Tue, 11 Nov 2025 08:37:50 +0000 (GMT)
Received: from [9.109.221.142] (unknown [9.109.221.142])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Nov 2025 08:37:50 +0000 (GMT)
Message-ID: <edc689f9-b46a-44e3-bf8d-7bbc355b9a08@linux.ibm.com>
Date: Tue, 11 Nov 2025 14:07:47 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 1/5] block: unify elevator tags and type xarrays into
 struct elv_change_ctx
To: yukuai@fnnas.com, linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, gjoyce@ibm.com
References: <20251110081457.1006206-1-nilay@linux.ibm.com>
 <20251110081457.1006206-2-nilay@linux.ibm.com>
 <c02eddd8-1776-4d1b-b5ef-c99a5fedc996@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <c02eddd8-1776-4d1b-b5ef-c99a5fedc996@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfX0m4mXyiO0U8c
 zb0qX54Cp1fMFemvyr2eKIzDelp2Np3OZSGotdQU65QsO1DRUv2mQelLECixMDYkt8boWumCRIX
 GwxlOmmrOrx3seEMF2iyPjNLbXSQ2xMZYuPr5gQWDnCrvB9v+SQNd6xRqxt4/TKwq/n5GB96U5m
 Tksa0Erm50Me/XnwoMX8X/5wnZSK3HWcFXjPfh6otQxoNfV08vEtLlAWnYVne9KaBk08vTmvznz
 uPez744xj93/9DdQ0MhEpGoCm0jEcA7SYxGXGyi+Iy4JE6DOx2eJC0nYIM7j2PO+aCDN8LIZNxO
 ZFsMtyqUQm8vruL4OU1iUMJ23UiJGxD8qI3WeKDmpiq2FjekveKxzME8eCVc4JjpvjNLR5lAMwQ
 hMsTCgzxioX58bxsU0DaMnQiP4vzQA==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=6912f5e3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=UY113N40aZtOLPQUpqMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: EfixWWpBquwEuFwP6PDvmVbCZgAO4YaK
X-Proofpoint-ORIG-GUID: EfixWWpBquwEuFwP6PDvmVbCZgAO4YaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018



On 11/11/25 12:25 PM, Yu Kuai wrote:
>> @@ -5055,11 +5062,12 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>   
>>   	memflags = memalloc_noio_save();
>>   
>> -	xa_init(&et_tbl);
>> -	if (blk_mq_alloc_sched_tags_batch(&et_tbl, set, nr_hw_queues) < 0)
>> -		goto out_memalloc_restore;
>> -
>>   	xa_init(&elv_tbl);
>> +	if (blk_mq_alloc_sched_ctx_batch(&elv_tbl, set) < 0)
>> +		goto out_free_ctx;
>> +
>> +	if (blk_mq_alloc_sched_tags_batch(&elv_tbl, set, nr_hw_queues) < 0)
>> +		goto out_free_ctx;
> I fell it's not necessary to separate two helpers above, just fold
> blk_mq_alloc_sched_tags_batch() into blk_mq_alloc_sched_ctx_batch(),
> since blk_mq_alloc_sched_tags_batch() is never called separately in
> following patches.
> 
Hmm, as the name suggests, blk_mq_alloc_sched_ctx_batch() is meant to 
allocate elevator_change_ctx structures in batches. So, folding
blk_mq_alloc_sched_tags_batch() into blk_mq_alloc_sched_ctx_batch()
doesn’t look correct, since the purpose of blk_mq_alloc_sched_tags_batch()
is to allocate scheduler tags in batches.

That said, we’ve already folded blk_mq_alloc_sched_tags_batch() into
blk_mq_alloc_sched_res_batch(), in subsequent patch, whose purpose is
to allocate scheduler resources in batches.

So, IMO, keeping blk_mq_alloc_sched_tags_batch() as-is in this patch
and folding it later into blk_mq_alloc_sched_res_batch() seems more
appropriate from a function naming and logical layering point of view.

Thanks,
--Nilay
