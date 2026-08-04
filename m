Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF012E8B64
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 05:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785820219; cv=none; b=eqkRGYWJqWZlKuz6RbfH/lY6oBM73VCXGxyLofEVhqoxQ+M4Y99YX5jG1nblia4niiLIYU2XCRYtEHzv8yaug96SkC5rYTMgWMsE6kMfBfS9safLVfUAd/e/c1rXtNNt6V3CrSOediab1j8u6+lR/3iskj2PQhgmeABfwilfknw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785820219; c=relaxed/simple;
	bh=OC3YVMmLnIp2/V5FWclKtKOqrxoSOajcxf5hLg6LAP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwQaslRGqIceLNh8CCj/YVKVPcY+MgQ3Tvx+GuSoZ/OqFwO+aaFFDPU7bq2wXtw0pZHKgcfM9oBVWbHcpvZ8fM4BRnuWVvD8h1lMQ49CRot012i4DsWzrnSvyIdKdeBFr1cSZh64SKPjhMFfXzjLiQhrG9Fv31U7bCjZJZ9fHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WYgonwR1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WYgonwR1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741IFrj3577892;
	Tue, 4 Aug 2026 05:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i14fjg
	aEdUB5OCgG0YMbmF/XpxZCfkxC3MrY/Pixlis=; b=WYgonwR10pqInGRB/qvro5
	i4pFYrpL4M1w7yQsBzIb6nMhGnDGS7/UhhwJSyndRfq0jxcx3LjVYk5Qo6pkfFV9
	klG+u6Wz5X2w9wgdGTAL/bK6579Q776jceZkwRhB8vVzuYdyzXRSXXJlIfV0ZCKn
	+Uohdir1nBB5004xL4x7JAt89/3Kk61brA2ghHsDv9qrAnBawVsqkKpyOoAGVgUy
	5Cblkn26wIQ19uvtkZR7wA5OnrgEijtmj0ALK1e/KaaFS1vBI9wusmPDjXoJZprt
	Sb93yV3RAGmjPPza6tROt6wsN3Hgh58R0BeGAnRYieok6RPkcmRR0apPbTx3OkiQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g3y8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 05:10:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6744uHKw006545;
	Tue, 4 Aug 2026 05:10:03 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh8epb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 05:10:03 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6745A2tH7537632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 05:10:02 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 527C958056;
	Tue,  4 Aug 2026 05:10:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 768D458052;
	Tue,  4 Aug 2026 05:09:59 +0000 (GMT)
Received: from [9.43.105.125] (unknown [9.43.105.125])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 05:09:59 +0000 (GMT)
Message-ID: <7c3545fd-0d87-47a3-9c31-59449d2ffdf5@linux.ibm.com>
Date: Tue, 4 Aug 2026 10:39:57 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] aoe: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
        Christoph Hellwig <hch@lst.de>, Justin Sanders <justin@coraid.com>
References: <cover.1785440858.git.bvanassche@acm.org>
 <a5fdc2b4d52006c20e2519f2c395d5d5102cb52b.1785440858.git.bvanassche@acm.org>
 <38edbd6c-c0bc-4d87-af0b-ec5f6be27f0d@linux.ibm.com>
 <7f909bdc-b151-4aca-8602-434685ddc9a5@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <7f909bdc-b151-4aca-8602-434685ddc9a5@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDAzNSBTYWx0ZWRfX2bIO9SbzHQKf
 KLZhftumPXnTZbIswPFmVlJcvLxDf5V94xI2dwpgS/Z4LoJv69zJqRwv3LLby+JXNXh5c7ihmxv
 3wxuZJGvAFd6hC203tnW66ROWwulVSeKcKrpqH6Znvu0TyUWfCgECYvQrjbY3gvi9UvCG2IT9zl
 sNUnlmUVymKXX5KHpaPx8aiF5XW/1S8QvT6mGE9rSGP8y+xeP+43PiUE+e8hVjQL6YbtpVpSL8P
 ziYJSKGCrJUAJpxPiy7zn2c0iHHCZjPBkirFpn/d2hcNDnRO8bsal1ryk+xslzDsv+52ouS0C8u
 SSxQGTq4lSSpS1E9J1F0/5KK8FoWnx8xvjC8U+sh3YL8Q/byaPighLXBbCK+yNnHpXBB4CCKv1k
 s68qcSjyPVh1uaijVapwbO1/VDBfsOt2cvqVIocT6aul7QxS6T44+A0VWgxYGMx/cR3bQhU+lpd
 8Idro33Xz2O3fCROrFA==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a71742b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=mFanlTgfplDdO0xbXqEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6n3YcZK4JzFgZ9KA21_LIkmESrE8XT4j
X-Proofpoint-ORIG-GUID: 8uFti_haxGftHVxp-WhigBsqqy6aTysK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDAzNSBTYWx0ZWRfX/014I0uQjr/X
 RC69Ytx8bIE1a16MQCdYAWHeLldLnflakqYyZ0M9MhpY7RMfX4DD0QoXrQkgXssJQ069qamcPtG
 gIMfSCoQjs2Z0tnBW9QYqxIB9QDiEVM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040035

On 8/3/26 10:54 PM, Bart Van Assche wrote:
> On 8/3/26 5:53 AM, Nilay Shroff wrote:
>> As I see, iocq->lock guards iocq->head. So shouldn't we annotate
>> iocq->head with __guarded_by(iocq->lock)? For instance,
>>
>> struct iocq_ktio {
>>      struct list_head head;
>>                  __guarded_by(&lock);
>>      spinlock_t lock;
>> };
> 
> How about integrating the change below into this patch?
> 
> diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
> index 54c57b9f8894..7ceda4ee4e55 100644
> --- a/drivers/block/aoe/aoecmd.c
> +++ b/drivers/block/aoe/aoecmd.c
> @@ -51,8 +51,8 @@ static struct ktstate *kts;
> 
>   /* io completion queue */
>   struct iocq_ktio {
> -    struct list_head head;
>       spinlock_t lock;
> +    struct list_head head __guarded_by(&lock);
>   };
>   static struct iocq_ktio *iocq;
> 
> @@ -1717,8 +1717,8 @@ aoecmd_init(void)
>       }
> 
>       for (i = 0; i < ncpus; i++) {
> -        INIT_LIST_HEAD(&iocq[i].head);
> -        spin_lock_init(&iocq[i].lock);
> +        scoped_guard(spinlock_init, &iocq[i].lock)
> +            INIT_LIST_HEAD(&iocq[i].head);

This looks good to me, except for the use of scoped_guard() here.
Christoph has previously expressed a preference against using
scoped_guard():
https://lore.kernel.org/all/20260626063738.GD10731@lst.de/

So lets just see what's his opinion on this change.

Thanks,
--Nilay


