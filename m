Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE421F09A8
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 05:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459040; cv=none; b=ovBowsE8DKqLoCnoQdpTFHfWUAHNtSuE3aZs1d0/FXeBuJBrvNIc40Y5KqQXBXFdfcLp0UPaJRTSII+Nzd5ui6isrmRlhAn9yE3tYPyGyv0OHXspXMcYohUUwDEz9w32NwoZQN/iBghph8IR4LOSPaUw7qBdobEsHIS44Ei+kbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459040; c=relaxed/simple;
	bh=lBzPwLJTMiMR/HZbBJK3y6sLhxqrXvOmrExVih36hyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StoEIMFaBd3p4ntEGLFPQeG6oT8HkJHxJlNja+JrJg3Ega/BlU4LWNkPdQCZyiQvdXRzzB8rugsdKP2+47kEY1yg2nuSGduS4EWggLoxOc8Q6uOJTnPL1XrXoKwi7PYDfkIdfGJoxwue+4rvPOLm0u76FmdSSVfH1WnKjsDbdpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kREtJa1s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kREtJa1s"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575IpPjo017923;
	Wed, 6 Aug 2025 05:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xiFG2j
	vcN7GmebB/4qvkI8eFGM7AFCS3cLQVfD4uCUE=; b=kREtJa1sKUDd9tXCU0Ht/5
	yTeSg6S1hX0KzjEeYPhiPLPzAsmFfQg701OayfxwxrYHxLTaXSQL2nYe6SdRc7Lf
	WvQYZT9AQRWFx3pEoLbxcRjtKKZZv20HHPvrmfWAiMEQbsvG2zcO+YUpDAM6x6BZ
	WKs9VcCYWzKbW4VEorXjlAEpYvYzrLim3ww/jkpO7q4kr+QBERFnpowXOcVYScMS
	FofVqEZ9Rhum4KEP/GABIiuy6RDjhFD87Is2Wn7m04/WphWAi2WLGs/TNu9ccn+b
	oCaE+9lk2j0XdOGApX/cdEe4P7Exxg+pvgItJJUgkRWhVu9cCXg4EchwLx0wZoSw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq632a38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 05:43:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5763Ipmf001627;
	Wed, 6 Aug 2025 05:43:32 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwqt66s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 05:43:32 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5765hVvN22937972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 05:43:31 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91B535805B;
	Wed,  6 Aug 2025 05:43:31 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B2675804B;
	Wed,  6 Aug 2025 05:43:27 +0000 (GMT)
Received: from [9.43.92.22] (unknown [9.43.92.22])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Aug 2025 05:43:26 +0000 (GMT)
Message-ID: <0133f954-2602-476f-bfb8-4850d7ea84d9@linux.ibm.com>
Date: Wed, 6 Aug 2025 11:13:25 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/2] block: avoid cpu_hotplug_lock depedency on
 freeze_lock
To: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, axboe@kernel.dk, hch@lst.de, kch@nvidia.com,
        shinichiro.kawasaki@wdc.com, gjoyce@ibm.com,
        "yukuai (C)"
 <yukuai3@huawei.com>
References: <20250805171749.3448694-1-nilay@linux.ibm.com>
 <20250805171749.3448694-2-nilay@linux.ibm.com>
 <5820a0d3-3035-6d4e-8c96-45154d8a1cd5@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <5820a0d3-3035-6d4e-8c96-45154d8a1cd5@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAzMCBTYWx0ZWRfXxFE/ELbLwLeO
 BjFEO+7S3qlfDa0kUI0MemyDjhfamCDYm5YIm1IG45qPiAPX5vFJ0ELoEBxuQY3RBvSBVy6lZ3R
 MSjAl+yYQL9Ylr2vMtud8HD8zF1Dwg182w1Q+OFUrVscj7x7XRAXONNHeLOjgVCI44Z+PhZg4TF
 ZYBv3wzBPnHfbf7xJEPV1WxVrzxaaHp6v3M2SMQQbBjKLwvaFUyDy7X1cAxfr/CpMi5CCIybBVJ
 Z+8rVQ0oUy/mVY4w7rUgZTVehedWk8rzAB/sePRHt141+cjfym/EITRBsdnmxC8pUILUOiRdEAj
 u0joP1Q2ekdcBeRJAJ3nh0OwD1wXee1wPpzQPiUvq/EF55E8tx/joL0zHII4vPbH/vBOzq5+IZV
 ll4deNTUuivst8Co0fVcXw0QUkeWzVIlsTQlCCQCNDzgd5Ib1DGxw+yEIcRm1KE7VOrUy9z4
X-Proofpoint-GUID: 29g0D_0Gr09IYf28WMYRRz1onP1ZYhi5
X-Authority-Analysis: v=2.4 cv=PoCTbxM3 c=1 sm=1 tr=0 ts=6892eb85 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=idVIW64ZpmwOt8P26EYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 29g0D_0Gr09IYf28WMYRRz1onP1ZYhi5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060030



On 8/6/25 6:48 AM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/06 1:17, Nilay Shroff 写道:
>>     static inline void rq_qos_done_bio(struct bio *bio)
>>   {
>> -    if (static_branch_unlikely(&block_rq_qos) &&
>> -        bio->bi_bdev && (bio_flagged(bio, BIO_QOS_THROTTLED) ||
>> -                 bio_flagged(bio, BIO_QOS_MERGED))) {
>> -        struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>> -        if (q->rq_qos)
>> -            __rq_qos_done_bio(q->rq_qos, bio);
>> -    }
>> +    struct request_queue *q;
>> +
>> +    if (!bio->bi_bdev || (!bio_flagged(bio, BIO_QOS_THROTTLED) &&
>> +                 !bio_flagged(bio, BIO_QOS_MERGED)))
>> +        return;
>> +
>> +    q = bdev_get_queue(bio->bi_bdev);
>> +    if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
>> +            q->rq_qos)
> This unlinkey doesn't make sense, BIO_QOS_THROTTLED or BIO_QOS_MERGED
> already indicates rq_qos is enabled while issuing IO, and rq_qos should
> still be valid until this IO is done.
> 
Yes good point! Agreed that having BIO_QOS_THROTTLED or BIO_QOS_MERGED set,
implicitly implies that q->rq_qos must not be NULL.

> Perhaps a prep cleanup patch to remove this checking?
Yes I'd do that but lets wait for Jens or Ming if in case they have any
further comment before I spin v3.

Thanks,
--Nilay
