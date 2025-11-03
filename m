Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0596A298CA2
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762153422; cv=none; b=tdQJELXUWMRC6JN7QOuZhVpdNISaxY4YNbD+EK7OmjnJGIK+oP0O6HofCSfZeYS4DGHEnckUTmnLiuOl1xlLqoakL/7ltkWFevIwfYsynwObiJO2aB9yRbiSfeeYJmEiZ3EJ3fo6nbJLiBIO0Yd9R3IUzYk7P9M9BYNUKfvJ6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762153422; c=relaxed/simple;
	bh=WKvdrgpIoXtnUy5RsRPtlXhM4urKekJy7HDJU/iVP5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8J4EXGH7c18ltk7/zBWy+GPgxzyN6KU7qhmnL0Z70+bCFmX3otQ1yfuV6riZerlQ1psvqZ2ndI0PnJKbWnopsV4f1hcRwnWdWfbfrpto8BEWOQzTCIFfKokIRjS0ejlBBO52PmiyEFJqbapcDKL/TazayrKC/38scDVB2DSfhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oFce1bSg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oFce1bSg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2NlMbY008410;
	Mon, 3 Nov 2025 07:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5HuXZ3
	9dKVIIg9lPb7H25rpyeg0Bg6as+BjX4BZfnWI=; b=oFce1bSgSqjeIhaN458Lhk
	KcN2X3JXfbIdK9fo+w+3zUdS57G13Gmc9beDL5TXEd/nDigmOARYt2g6mD/qRy8L
	ofYjaMHM8KirPmOhuxmeNYUYuCtg8p9NJ11B4YXqJd1CiIYrailvRCrVWJOY/ir2
	ifqOzM3MA+BoZjPtrpDgfzhw6eAqXWamBHDo2C4B+MQ0frYsyeaPLuD2YmAA6vh8
	haYxUmYyua+UddO0QgfZCg6xYc/me01QwOF93O5HJ6ildxkeNrBIdNZIlIGC5Cti
	tz67dySFZbXUCsYsdMb/n7qHQyDqm8oKBjcFMIdcPfSYHCNXhXWOgxGBoQavx0dQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a58mknbc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 07:03:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A32imi6009869;
	Mon, 3 Nov 2025 07:03:35 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5x1k4878-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 07:03:35 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A373ZmB30737110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 07:03:35 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B0AC58052;
	Mon,  3 Nov 2025 07:03:35 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93AC45805E;
	Mon,  3 Nov 2025 07:03:32 +0000 (GMT)
Received: from [9.61.101.239] (unknown [9.61.101.239])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Nov 2025 07:03:32 +0000 (GMT)
Message-ID: <d4c86b29-4b5e-4a85-82b9-8b80f66ed24c@linux.ibm.com>
Date: Mon, 3 Nov 2025 12:33:31 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/4] block: move elevator tags into struct
 elevator_resources
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
        yi.zhang@redhat.com, czhong@redhat.com, gjoyce@ibm.com
References: <20251029103622.205607-1-nilay@linux.ibm.com>
 <20251029103622.205607-3-nilay@linux.ibm.com> <aQgmckPkiAtr8LzM@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aQgmckPkiAtr8LzM@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eMTnVhRIBYSGJ2Q7e-TNPlCufxCQb5Kg
X-Proofpoint-GUID: eMTnVhRIBYSGJ2Q7e-TNPlCufxCQb5Kg
X-Authority-Analysis: v=2.4 cv=SqidKfO0 c=1 sm=1 tr=0 ts=690853c8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=wspqj8QR-kYkxBFrkRkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwOSBTYWx0ZWRfX9ZV9pgstYybH
 wAow2GhAI4Y9GIMXFztuLkapKLcEQqJU92e+JFjwZzKY4jT7IwSxzw5eZKjyTtdTFezP6oNkgZj
 g5+dYp7qCIonjusbLqdmP0r2muWr1lvKW8FrpbezOHfmQlZy+0IC4uti50KUOn+h8+OChNAfudq
 y/m60FHm7HurqfK/yB+dXoPO21JdGTUz+fbEvG+VXqN3XjlJyVZkBa6o8y1Uyuwd/xI4npsz0OP
 eiiofd9WBQG4RWQU/mLQpUJeR3YR+XKnNDBnyDehTXwPuuG8fSOWlRkd9NJaIvFZOP9tgT4wXTm
 jJMZx+tBz+QqTwv95DWBxp+cd9on/lCscJVq6OReyomTbT2Df2SPwdgx3GFwUthYuRXITPMtaIm
 Qd4ykAGK/wOi+3d9RjO3i/c5hwiixg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010009



On 11/3/25 9:20 AM, Ming Lei wrote:
>> @@ -580,7 +595,7 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
>>  
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
>> +	eq = elevator_alloc(q, e, res);
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
> The above change(include elevator_alloc() signature change) can be avoided if
> you add one local variable `et`.

Yes, we can avoid changing the prototype in this patch. However, in the subsequent
patch, we’ll still need to update the prototype of elevator_alloc() so that we can
pass ->res as an argument. This will allow us to access and update both ->data and
->et within the elevator_alloc() method using a single argument, which is more
convenient. Otherwise, we would have to pass both ->data and ->et as separate
arguments. That said, I'd update this patch so we don't change elevator_alloc()
prototype in this patch but then update it in the subsequent patch. Let me know
if you think otherwise.

Thanks,
--Nilay

