Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7189A4252BB
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785829261; cv=none; b=ijxKftIk85jMNfxhWqL1eo3qj6c3fTU2bmcBUvK+BHD/WNCIwu5DIAsl0cq/pnyX4sWTWAVmFwzSr3xaz4sAuZj/H2lwNS3o2Lap2II/U6Wu1iyuSh3dFGjZuylC5QUvh4PcDeLH0gBeGLEX9nJpAaiWCMV32H+hKsvm5H21JBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785829261; c=relaxed/simple;
	bh=FaXPnRuDNOQgn7nATJ3/i3WwKQZi0FkB2tho+BPlBoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C68SOzwOCp3Ho1hU9mmPrezYgb6SiqADjvEE/NjDQKQ3xU9nTT9FI8PFmkwrEL5sHu/dU33f9yUKPzAS/ZoIfD7TGESB7ST7ziyhSYnKy/D50uy6hizNuhcIOnKEa7BYjRyF7C/rN+rJHzEZVjiapnOjTFphS6u+lx+W6BagYHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hTKaJ0FN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hTKaJ0FN"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741HZuU3631235;
	Tue, 4 Aug 2026 07:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vSinZR
	WpfNfGTHrYlCfpKiTlH67Gb5YVYUG85GnpS+s=; b=hTKaJ0FNwEmchgFjP/T5uC
	QO9uKqmXbn6yXv4JMx67881hAiS48R+d7BFsacPTRDr+95W1N3S0BOFNtfnyeilG
	sd4rN10NAP1kZ7FmaoBaYhzgxS11sQ/v1SvqB6AnsgXniEgyb8k7TqEMSUakHExc
	awtV+J5V5IAu+QuKjjDkJYcrqWAe4a3hmMflqXd+oqGDmP+uqItGxxv+gkcRw0XP
	iwmPq7U1266R8EDcGIk4j8c13n+Svb1kpdS6iQmRtiEq0t6gd3d6P7Jprh3L1rXn
	gbIICOQR3Iy3P6HuFVlE2YipsU7gapvc7d8KvpBPrCtFQaK1swzMeF8d8l8E0ovA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3vqqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:40:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6747QR9b020994;
	Tue, 4 Aug 2026 07:40:31 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh8wmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:40:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6747eUEQ57672062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 07:40:31 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB99D5805A;
	Tue,  4 Aug 2026 07:40:30 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AB1658063;
	Tue,  4 Aug 2026 07:40:26 +0000 (GMT)
Received: from [9.43.105.125] (unknown [9.43.105.125])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 07:40:26 +0000 (GMT)
Message-ID: <2db07e75-0e92-438f-89e7-85189a017a62@linux.ibm.com>
Date: Tue, 4 Aug 2026 13:10:23 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] null_blk: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kees Cook <kees@kernel.org>
References: <cover.1785440858.git.bvanassche@acm.org>
 <55886b395224068987cec253192ae6257e61c960.1785440858.git.bvanassche@acm.org>
 <42987b15-44e2-4a45-bbd8-b791bbb56b6c@linux.ibm.com>
 <4fdcc4f4-819c-4878-96ee-9493ce4c5886@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <4fdcc4f4-819c-4878-96ee-9493ce4c5886@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a719771 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=ucqiiBkzb3YHjCTxxScA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EaoEtgs0qtZAvKEiGloeS11EGiCenLb3
X-Proofpoint-GUID: a3bzueKnTizsdNtQLBXvD4yuH_9PAI9i
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfXyDxMUkvEbxQ5
 J/IYIkvbvDGwFH5dDJGJKB79GpWDgXbNLr4PijbNmHKKAcOLX5qNi09RV1OjMft0yUP6M0+PHra
 gWK7kEMHKh90fUdjqmpI/BVw4ObXyq8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfX5tkJK8W1s8Ky
 KdBoR3iWoyneKOHOwFt8qkWqxFBshqo+vjWEgOYqJzPvuQHWkAfwSOOY6WaKH3a5Bzzn0hex7N3
 c0BVQsSIk1V8zZXcI9AGKvHsmSVMjLKr0FBtQo+JWOYvx0vK0IqgVckqF/Tm0LG8z+T9nCxDQ3f
 B0sZuTxD095bURDJK65TXG94DOZV/uZR/12lu25D6S7ZzPpAWy0xK2VwDDNIHse7sIXcKqPtSpy
 dlK9CpWJcefdx1Rjed4VF+w6+geQjxdgg+pI8h+p63TVvc7oY4hl84zzlhYOdluk663KuFlTTlu
 9rvDPlInuliJlClT8turiuAss4T6N4jOOTciGIupW3iP8YeezLRyu2GPdeQ3o/e6/vUaqEfzA0L
 bFnNsACDrNpS+5KHFq2y5JVDzZZ4Isj3LQJOG1j3Ccp5Y1BiL9VK5fxuNEOVnYAqlg2HMeDX0Qo
 HrQ2CbxUTErRgTOZ5tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040057

On 8/3/26 11:39 PM, Bart Van Assche wrote:
> 
> On 8/3/26 6:35 AM, Nilay Shroff wrote:
>> On 7/31/26 1:28 AM, Bart Van Assche wrote:
>>> +DEFINE_CLASS(null_zone, struct nullb_dev_and_zone, ({
>>> +             if (!_T.dev->memory_backed)
>>> +                 spin_unlock_irq(&_T.zone->spinlock);
>>> +             else
>>> +                 mutex_unlock(&_T.zone->mutex);
>>> +         }), ({
>>> +             if (!dev->memory_backed)
>>> +                 spin_lock_irq(&zone->spinlock);
>>> +             else
>>> +                 mutex_lock(&zone->mutex);
>>> +             (struct nullb_dev_and_zone){ dev, zone };
>>> +         }),
>>> +         struct nullb_device *dev, struct nullb_zone *zone)
>>> +
>>> +DEFINE_CLASS_IS_UNCONDITIONAL(null_zone)
>>
>> What do we gain by introducing a guard class here?
> 
> What we gain is that __context_unsafe() annotations are avoided
> entirely. __context_unsafe() is a big hammer that shouldn't be used
> unless absolutely necessary. Additionally, introducing this class makes
> it possible to convert multiple goto statements into return statements.
> I think that's a significant improvement.
> 
That's a fair statement.

>> Since both the constructor and destructor are marked
>> __context_unsafe, the lock context analysis still
>> won't reason about the conditional locking.
> 
> Such reasoning is not needed when using guard() or scoped_guard() since
> these macro's make it impossible to leave a scope without releasing the
> acquired synchronization object.
> 
Okay got it.

>> I'm not opposed to using a guard class here, but it does make the
>> code a bit more complex to follow.
> 
> Hmm ... I think this means that you are not familiar yet with
> DEFINE_CLASS(). The code that uses the null_zone class becomes simpler.
> 
Yes, I may just need to get more familiar with DEFINE_CLASS() :-)

Regarding the proposed null_zone class implementation, could we at least
move the constructor and destructor logic into separate helper functions
instead of embedding it directly in the DEFINE_CLASS() arguments?

I understand that DEFINE_CLASS() supports statement expressions for these
arguments, but with the conditional spinlock/mutex handling here, I find
separate helpers easier to read and follow. For example, the class definition
itself would then remain fairly compact while the locking logic is kept in
regular functions. What do you think?

Thanks,
--Nilay

