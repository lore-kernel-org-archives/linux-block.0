Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECCF3DEFF2
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775037288; cv=none; b=RlWrSHdHuEMq7JtQcfknoWS7eCe+VU8EOjs5hFhK8stqgn7kfFWtezAD3xwdECxlZiaQyAQgBsWz761Q1uSqqz0T0KgGtYq/R43ruJDEWS21sRpe7LZnhmIAF7WIYSI+idYbvTFGlsmPEGejFdzNFjk92VFgVGXgOszlfvPe5n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775037288; c=relaxed/simple;
	bh=zcvLMq3cHCvCKJoNnJfTHjzOpPK7O+Z+BsyrkVBngzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlsPmOFwR1puBL2yyyc1iKxyG1OtDDA3BEGx2EDr1zwHmHRh2yB72a+ZHaM5c8RyPvsDqoRTkWEhig7DItqrNx4U4BCCfgh057lPRLHtVUtR+dBU77660nBnTd5KEXhxvAxGO3l+J4LYVmtbxMpz8r4saLPesdtv6dZTMK3v4vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qT17mCYQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qT17mCYQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6318ZL853518860;
	Wed, 1 Apr 2026 09:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eowej0
	6pmCb7+ukLA8qSnddqOsF2skralMBF6wRJbRU=; b=qT17mCYQQ6B10gUg3kibUn
	qt+RGjd8eZKs3ZTTz+B2hbCs/sVJJC/IkpScVN01AjiLFYgW2tmGrNXkS43vS/gH
	qOKvdD7rKMH+I++2crpAT0y9ZzrrAi/d17zR36QsICRQc23fQYr8Tu1NDz+8tisx
	KYVh0JNr8VpWJfRObEtDvbWOXtFqqSMOWTyhHocglDPWh9Tn0F3jxrjSX9Wng9gc
	fLBjThmvpb0Z3TTA1DmWesju+6VQBfD0LlNx8Lx9kYod0KEV5ehe6VRIep1d5S4U
	z8vQbFzTYp+CRmRADAKw8KtZeTQS/26/waX/G77UK/UX8cM4JPeqJ5Cx1dFnf5Aw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q37fun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 09:54:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6316udpJ013919;
	Wed, 1 Apr 2026 09:54:19 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkmwu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 09:54:19 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6319sIg630737094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 09:54:18 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A80258056;
	Wed,  1 Apr 2026 09:54:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3EAB58050;
	Wed,  1 Apr 2026 09:54:14 +0000 (GMT)
Received: from [9.123.2.203] (unknown [9.123.2.203])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 09:54:14 +0000 (GMT)
Message-ID: <25eea754-304c-4693-a2aa-0df47f1d1e0d@linux.ibm.com>
Date: Wed, 1 Apr 2026 15:24:13 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/26] null_blk: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Kees Cook
 <kees@kernel.org>, Genjian Zhang <zhanggenjian@kylinos.cn>,
        Marco Elver <elver@google.com>
References: <20260325214518.2854494-1-bvanassche@acm.org>
 <20260325214518.2854494-21-bvanassche@acm.org>
 <b9cbbd2b-4c2a-497a-84f8-f1bda0e7c40f@linux.ibm.com>
 <3820ca93-bcdc-419e-92a9-251b8d430cec@acm.org>
 <746b98bb-d56b-468b-a59e-6de6ea5282f1@linux.ibm.com>
 <b2160b6a-8857-4496-9453-2fcf394e9e4d@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <b2160b6a-8857-4496-9453-2fcf394e9e4d@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 15V4LtR5pgqWkGiD1o-PolOSh9p5wK9X
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cceb4c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Twlkf-z8AAAA:8
 a=Ukabrd6Y2uHJcgio7wMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-74SuR6ZdpOK_LpdRCUo:22
X-Proofpoint-ORIG-GUID: ufXP-WZlbz3EKPXYJ19S51ljJ0_T5fz-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA4OSBTYWx0ZWRfX8WrtursbvY2W
 UvEzdUr5TKQbKJhJGrKyu4J/ErvfBk3grsjtX6o/d8IG33rRd+EVwZh15kaoRM6ie6c+sVoMYNT
 8w5SEQ03XfShlBjhOh4lsiAIdXp63npKN9ztCa1hSooNdRZ/xOSyrlywj9Xlz8qpIH/H/um2kht
 gCV+5YCls1azu6ZIjh8CF+XsYN1zFnFh7lw0AUNSBCZUbp155BmVODNkgKVQg//qxlhaFHTPhzK
 EmonDq62L6FkbyObHttHwHmtjYt3/R/JN91c4J/3WhkWR96F1qKozEX3zLkuePWc9wrx/s0TWL2
 MwyJUG7gX3Ov1XBQJ4UUs6Xp/eQ61+VnHd665darCa77FHgMzfxFBGAFoK2BtqTWLw52QCALFSf
 5ouu/s+wk+bT/oCkfCBT6WtuPaQzJyrJK1UxGi+BwOMnQrJZCTcLQAjPCqia3H5X74yVxDvNgm2
 8UMqpFQiMoMbXpMSYUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010089

On 4/1/26 1:32 AM, Bart Van Assche wrote:
> 
> On 3/30/26 10:37 PM, Nilay Shroff wrote:
>> On 3/30/26 9:55 PM, Bart Van Assche wrote:
>>> (+Marco)
>>>
>>> On 3/30/26 3:23 AM, Nilay Shroff wrote:
>>>> On 3/26/26 3:15 AM, Bart Van Assche wrote:
>>>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/ main.c
>>>>> index f8c0fd57e041..677ac829ef80 100644
>>>>> --- a/drivers/block/null_blk/main.c
>>>>> +++ b/drivers/block/null_blk/main.c
>>>>> @@ -1004,8 +1004,7 @@ static struct nullb_page *null_lookup_page(struct nullb *nullb,
>>>>>   static struct nullb_page *null_insert_page(struct nullb *nullb,
>>>>>                          sector_t sector, bool ignore_cache)
>>>>> -    __releases(&nullb->lock)
>>>>> -    __acquires(&nullb->lock)
>>>>> +    __must_hold(&nullb->lock)
>>>>
>>>> This function temporarily drops the &nullb->lock and requires it.
>>>> So why do we need to replace __releases/__acquires with __must_hold?
>>>> This is not clear.
>>>
>>> __must_hold() has the same meaning as __releases() + __acquires(). The
>>> only difference between these two annotations is that __must_hold() is
>>> more compact. I can leave out this change if this change is considered
>>> confusing.
>>>
>> Hmm, but per the documentation of __must_hold() it seems that this attribute signifies the caller of the function must hold the exclusive context lock. On contrary, __releases() attribute is meant to be used when function releases a context lock exclusively and __acquires() should be used when function acquires context lock exclusively. From the above rational, it seems that
>> null_insert_page() should have all the above three attributes
>> applicable, isn't it?
> 
> __must_hold() is defined as __attribute__((requires_capability(...)))
> In the Clang documentation this capability is called REQUIRES(). From
> https://clang.llvm.org/docs/ThreadSafetyAnalysis.html: "REQUIRES is an attribute on functions, methods or function parameters of reference to
> SCOPED_CAPABILITY-annotated type, which declares that the calling thread
> must have exclusive access to the given capabilities. More than one
> capability may be specified. The capabilities must be held on entry to
> the function, and must still be held on exit."
> 
> To me the above text means that the __must_hold() annotation is sufficient.
> 

Okay, that makes sense — using only __must_hold() is reasonable.
That said, since this function temporarily releases and then re-acquires
the lock, it may not be entirely redundant to also annotate it with
__releases() and __acquires(). Those annotations more explicitly describe
the lock transitions happening within the function body.

Still, I’m fine with keeping just __must_hold() if we prefer a more concise
annotation.

>> I am not sure why did compiler generate the above errors? If I look at the
>> macro definition then it seems __context_unsafe(/* comment */) should simply
>> expand to __no_context_analysis.
>>
>> // From include/linux/compiler-context-analysis.h:
>>
>> #define __context_unsafe(comment) __no_context_analysis
> 
> I misread your previous comment. The output I shared is produced when the function body is surrounded with context_unsafe() (no leading
> underscores). Your request was to annotate the function with
> __context_unsafe() (with two leading underscores).
> 
> I will consider to use __context_unsafe() instead of __no_context_analysis and a comment.
> 

Thanks,
--Nilay

