Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437922DF149
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862439; cv=none; b=f/Ks9gtdxw1FGP35swShqoiqT99eptRdZMDacqH4a/iV52P0zy34uxahazkhJ6Ql9eT3LNLu4P+7HBM5ys+Couso1vcewHwchUHYlf3FvK/q58QoywEOEzA414MijQqaticzcDkcgt7W8GulVn21nwnzZZ5jBzOwW6nh30OWBAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862439; c=relaxed/simple;
	bh=jRwFnScVjMDOoJGL9nxWjng63KciUOWp5QVWTP033/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOOQom+Q1csfOCBpEh/sCxjtwe7ji9XrhNKTolDU52nC128Kv3OGQpUL4vCwUpyiJrkkMvwtlOytGBkEl28g8OiatAWVBQV13gWzTAq4rkqceWuhUe6ijAvup3ChASeawEPRolrCtbv1n/AXFVljMAYUKMHUaiyW63BsFREEOuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FPDuQHYj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FPDuQHYj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB4jPOI016114;
	Tue, 11 Nov 2025 12:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FAq9Ly
	7HpXZMXkCjrk5/M5TMlimXHPYQMc6WxNY6ac8=; b=FPDuQHYjj2Clm4EC7qS2t4
	4vo46fu8sLL8CxigX5ekIp6/wO66MCJQrH2hpy82qZ0WC3oYlRVJA8pVnsIntgKO
	aJM+QzBpDAs6QCb+7pdUvxsyw0eLHn4FLMJQ7z/9gDaowI9QGqMzadoyuIXTyQA4
	5OBRkl0Y4UzNyO23wr9vy0eOIW4ZqiCRmrFdF2M9f3zeq/Ha9IYbUPBUgsRRjgHA
	MsXxrwFjbIq9bPlwlNTgpNr/myB/9cvyuiiKxDazFBmo6vL3QVkN+/bxdmMk44nt
	3AqA8R4PkkmgjpsM7/j2us+ldCBhR/lzZwvKel7OmdfGjEeQ4bFNRc7ay6GexZVg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc750mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 12:00:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB9jlme014762;
	Tue, 11 Nov 2025 12:00:21 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpk2j2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 12:00:21 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ABC0LD053936428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 12:00:21 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CEC85805F;
	Tue, 11 Nov 2025 12:00:21 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80ED15805C;
	Tue, 11 Nov 2025 12:00:18 +0000 (GMT)
Received: from [9.109.221.142] (unknown [9.109.221.142])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Nov 2025 12:00:18 +0000 (GMT)
Message-ID: <8a2aeb83-09c7-4bc9-aa77-8e4c16d3ad89@linux.ibm.com>
Date: Tue, 11 Nov 2025 17:30:16 +0530
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
 <edc689f9-b46a-44e3-bf8d-7bbc355b9a08@linux.ibm.com>
 <f287b65a-1321-4662-a3e3-a906f610e037@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <f287b65a-1321-4662-a3e3-a906f610e037@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfX0C0d2PWezHiM
 4vqNdMzEKn6lzavz6CxRHKNSP8Msy+Il6V9gKxvtEo9+zGYZYJ/KHoJLU+0qbAfrdRD9sgb1P3g
 SwiQ4+GLjFZIHuMa75yXKVibMfDKPU+bXvnXuK02HX2VvrteivlbgR02WCx4dGS+1jubH5IS8ot
 SaL4Uu07An3O9/vW5fCw6FzDcbfw3QKZm5FV/ytLCAcxmlSfxKF44MmEWAlG3UdP8BpMR3B8zqE
 YtWYYo8/ZbW3uU4pIMH/HX96yAL8eu4k/0sGHOxdeM96JdL/aHCxC91yFuhsOZg6tlwWHbTZK+f
 rK+MZG0NTvlC9QNYnVINcuIpgYwJen65kBCPTH05tcRvfXrHrX3AtpCxJPj47cUkzhqQ+TImJzT
 Hfdz27emjGQRn2LZx+Yj7cRTqDNSCQ==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=69132557 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=IsckQQNjH18xeav8FowA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: AQHWT7Ije5TZQBAr-E2JIJhUlMv84Uqz
X-Proofpoint-ORIG-GUID: AQHWT7Ije5TZQBAr-E2JIJhUlMv84Uqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018



On 11/11/25 3:32 PM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/11/11 16:37, Nilay Shroff 写道:
>>
>> On 11/11/25 12:25 PM, Yu Kuai wrote:
>>>> @@ -5055,11 +5062,12 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>>>    
>>>>    	memflags = memalloc_noio_save();
>>>>    
>>>> -	xa_init(&et_tbl);
>>>> -	if (blk_mq_alloc_sched_tags_batch(&et_tbl, set, nr_hw_queues) < 0)
>>>> -		goto out_memalloc_restore;
>>>> -
>>>>    	xa_init(&elv_tbl);
>>>> +	if (blk_mq_alloc_sched_ctx_batch(&elv_tbl, set) < 0)
>>>> +		goto out_free_ctx;
>>>> +
>>>> +	if (blk_mq_alloc_sched_tags_batch(&elv_tbl, set, nr_hw_queues) < 0)
>>>> +		goto out_free_ctx;
>>> I fell it's not necessary to separate two helpers above, just fold
>>> blk_mq_alloc_sched_tags_batch() into blk_mq_alloc_sched_ctx_batch(),
>>> since blk_mq_alloc_sched_tags_batch() is never called separately in
>>> following patches.
>>>
>> Hmm, as the name suggests, blk_mq_alloc_sched_ctx_batch() is meant to
>> allocate elevator_change_ctx structures in batches. So, folding
>> blk_mq_alloc_sched_tags_batch() into blk_mq_alloc_sched_ctx_batch()
>> doesn’t look correct, since the purpose of blk_mq_alloc_sched_tags_batch()
>> is to allocate scheduler tags in batches.
>>
>> That said, we’ve already folded blk_mq_alloc_sched_tags_batch() into
>> blk_mq_alloc_sched_res_batch(), in subsequent patch, whose purpose is
>> to allocate scheduler resources in batches.
>>
>> So, IMO, keeping blk_mq_alloc_sched_tags_batch() as-is in this patch
>> and folding it later into blk_mq_alloc_sched_res_batch() seems more
>> appropriate from a function naming and logical layering point of view.
> 
> I mean just remove the helper blk_mq_alloc_sched_tags_batch() and call
> blk_mq_alloc_sched_tags(or _res later) directly from
> blk_mq_alloc_sched_ctx_batch().
> 
> I think at least there will be less code lines :)
> 
> blk_mq_alloc_sched_ctx_batch
>   list_for_each_entry
>    ctx = kzalloc
>    xa_insert
>    blk_mq_alloc_sched_res
> 
> blk_mq_free_sched_ctx_batch
>   xa_for_each
>    xa_erash
>    blk_mq_free_sched_res
>    kfree
> 
> If you don't like the name, perhaps it's fine to use
> blk_mq_alloc_sched_ctx_and_res_batch.
> 

I understand what you’re proposing. However, I still think it’s better
to keep the allocation and release of the elevator context and resources
separate — not only for logical layering, but also for practical reasons.

For example, when switching the elevator, we may only need to free the
old elevator resources while keeping the context intact. Hence, IMO, it
seems cleaner and more flexible to maintain separate allocation and release
functions for both elevator context and resources, rather than tying them
together in a single API.

Thanks,
--Nilay

