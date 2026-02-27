Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344FD355057
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179766; cv=none; b=lORjsRrfSyVDeamEQI6RhRtusJTlI7wAL4pUyJaDpRMr9cEj0YLQjUQxEy8SdeD6QRSVsZZx1hKqGcELlcYwJMaLHL82t0zQ4UpxbEpBpUbE0uu4SpepeMRGykcJmHHmD7EiZrUOPJRzW0gyLA+0ACPZb+atmgKvH91J9Aqdn38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179766; c=relaxed/simple;
	bh=2LE7NTD4jBG+I2FtSpgmhvHV9hK8SoHG+dkDYdSMlI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrMPS0x5a7BF+q5Bqdf0cwdxnFpwb3dP5oiLjZZT3eKl1tPUTwu289QTYBtQ+mJiEb6+CmcXUtS7/ZvWKv1dwB0Y/y0PgAyKDetW22/oDh/yZMu5O3tynoAfe1R2tkYmD9uld4RF5yWquURFEDZ0NZOg9OQFmuG+GJ6U26YBCFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K9zbnaBP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K9zbnaBP"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QMHIW52817486;
	Fri, 27 Feb 2026 08:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/BR8it
	HZVzqpnD1RqgYZzx8gwWicG/NjvQ8/ijxE+9c=; b=K9zbnaBPTUdhrwVrl6a+Tb
	/PiczJdaNhzx+Vsw2F2sRSHPUXQYdg08AKmeRc1Nbq/sTOfQGBY28tF9K/WZ3BRW
	xrU/ulMvBaVcR591EQhhh3cGfFd4M688P5n8iDab3fxTcKx8jjdE1W00Vv5HmxTF
	Zs0zRAQQWKa9FY39vaeEJPJYiFBdKkQcW4HTM7kw55ZjKqi9jK6DFKyiQtrVvDto
	DrXp18G3gAXVP21+SstozgQPudxJv+2C5+2kYylmLcLvwqvWo67ysgea3xblYNq5
	aD/iwuXhnWQ8lIKvp+X8Bz2JkTuDjnmPR68a8zDMtUARckjVx51bwnCcLnen2zng
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24gtth6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 08:09:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61R6agDs015758;
	Fri, 27 Feb 2026 08:09:10 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1t14n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 08:09:10 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61R88mQ628049982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 08:08:48 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D565658082;
	Fri, 27 Feb 2026 08:09:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9907158080;
	Fri, 27 Feb 2026 08:09:04 +0000 (GMT)
Received: from [9.43.3.109] (unknown [9.43.3.109])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Feb 2026 08:09:04 +0000 (GMT)
Message-ID: <8ec6d450-923e-4148-98f0-076cadba20f2@linux.ibm.com>
Date: Fri, 27 Feb 2026 13:39:01 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: break pcpu_alloc_mutex dependency on freeze_lock
To: Greg Joyce <gjoyce@ibm.com>, "yukuai@fnnas.com" <yukuai@fnnas.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
References: <20260225124556.1152510-1-nilay@linux.ibm.com>
 <1a2c39d4-5d39-42c6-89f9-3ec473b44b06@fnnas.com>
 <80246de3-f22e-46ba-8a78-17282190224c@linux.ibm.com>
 <CO1PR15MB496953C277EC8E15ED965D7FCE72A@CO1PR15MB4969.namprd15.prod.outlook.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CO1PR15MB496953C277EC8E15ED965D7FCE72A@CO1PR15MB4969.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=69a15127 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=rB26j734odGMIWOOWIYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: alubhoQVTCBqFAhD9mfwqa2QdUuedmlS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA2OCBTYWx0ZWRfX18lq0mhkKbbT
 8xTtPouqOStT/jLsdtWAMdao/MpAI2ZTwudAsQjsjWJx0/iVhKY8EFD/yDw3rNuu4fmD0x5wVZQ
 mb8kBKsm4emBPz/Lb3O51Xpc6BOeqE13Kn3vXozuQTK57sGQCzf6GyTECMN80q1FBJ3fn+/AwXg
 H2tQYjVJ+Mr5rJ82am5B/ukmUQaY8BgtQMu8kGQN5ht7/XT7jM5yPQvhBxTtqjeUJW5aOEWqR4x
 BCCNuLxqkD5eiNRoaXvexDboBNkzxSgwjDSyd07IRwhpua2nM/QYuwNL3wKrE+zH6eH4opzhC23
 fdPRhA0Zlv5rwiVbjc5haIU+fZ8nvq1f3kcfx3MbBoafPYfB1TFXC1bH9jYbijphOZfuvuQg0es
 nl1lamn7pNQRdKYXmm7t/T+fvU9ru505Z3wf9RpFLBu0RZWNw+e2nM0MAFg0MF4hZF3X1vxpzKJ
 NCquFKylEXz4hhlOYIA==
X-Proofpoint-ORIG-GUID: alubhoQVTCBqFAhD9mfwqa2QdUuedmlS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270068



On 2/27/26 1:45 AM, Greg Joyce wrote:
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index d5602ff62c7c..687fd47786a6 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -4793,10 +4793,10 @@ static void blk_mq_update_queue_map(struct blk_mq_tag_set *set)
>>>       }
>>>   }
>>>
>>> -static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
>>> -                                   int new_nr_hw_queues)
>>> +static int blk_mq_prealloc_tag_set_tags(struct blk_mq_tag_set *set,
>>> +                   int new_nr_hw_queues, struct blk_mq_tags ***tags)
>>>
>>> Personally I don't like the last parameter, since the return value is not
>>> used at all, I feel it's better to return the new_tags instead.
>>>
>> Hmm ok I could return new_tags and then use ERR_PTR when it fails to
>> alloc tags. Then at call site we could use IS_ERR to distinguish
>> between success vs fail case.
> I think this is a personal preference but I think it's better not using ERR_PTR since I think it's
> more error susceptible.

IMO, ERR_PTR()/IS_ERR() is widely used throughout the kernel and is fairly
idiomatic when a function needs to combine a pointer return value with an
error status. There are many thousands of instances of this pattern in the
kernel tree, so it’s a well-established convention.

As long as callers consistently use IS_ERR() (and not just a NULL check) to
evaluate the return value, this approach should be safe and clear.

Thanks,
--Nilay
