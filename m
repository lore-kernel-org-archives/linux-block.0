Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B3A28BA9F
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746645648; cv=none; b=sxNA12BqIWg7RlhrML/Qg/nkvfA3waLIcn6N/a7VBCdlHIAhE16pC2V11LqZR+g/KDUxkjYgB1w2LvFBwLS1HtrMwrl0N2ceILSwtSQbOgwuiLJbq2+aGS6dstrsz6L2ZB3VTXwp8Lm6qXwfOIh7H0PL2Ynqnfh3mHL0TLD76Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746645648; c=relaxed/simple;
	bh=cdF4+j7u6RRvO6sPBSe8dQl01eYChcOZiHRduCADhd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMtyc7re02IHB1AhEO1U1deT/SiMVH1reWRAmGsi90NTPPSoMq21qO6i0TI/0CKZNIfMGOG7p9wXt6Yx/BcHdVbslTdiZm8CET+W7W6Kat/J28KvkZgz9mW9lyOZoErFhKW73m0WPNn+RdGrCSfivdyMZTGrV39Hqo9jwNdpPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dbX61Npb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dbX61Npb"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547CHYOW016760;
	Wed, 7 May 2025 19:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pITswT
	J2jnnGh/wlalZO20jHgv7WTXf8T66pAedR0v0=; b=dbX61NpbDV2cKKpd5kQNmj
	PYmppqBFmIUbU9K5RACCNoADKj7V6gITdCI5Iuf2jukDP1wTZTpPK5KlxLn/lFaP
	Z9RikIPruU9hlZ3DuWtGMsKrTGiVPtjB+KCg2PJZkq+FBXJfdFRd5yqj1sPk+7aS
	ZkcRuMu7Br9VSZAxY/x7Y+S6W5Fq3lEjGhi1MO+tkgjhTaCPo9oqDhESXqWHn0JN
	jV8lPkg/tAmXU9NR0KGiQPKu+JO4HlpccLKyg3oBMuNX+icoKWFgkWgoQ59gZY4v
	B3rBbvYN1qU1WHuoY5SBoB8zcQIEYeQLbIzLI2x7HPBXS4sLmgDtf/YAdMTkqhOQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fvd0n1qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 19:20:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 547ImQ5B013765;
	Wed, 7 May 2025 19:20:41 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46e062htwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 19:20:41 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 547JKf5428312248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 May 2025 19:20:41 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F0F858055;
	Wed,  7 May 2025 19:20:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C574358043;
	Wed,  7 May 2025 19:20:39 +0000 (GMT)
Received: from [9.67.78.42] (unknown [9.67.78.42])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 May 2025 19:20:39 +0000 (GMT)
Message-ID: <5ae53e40-b4d0-4f64-af40-7f86abb41547@linux.ibm.com>
Date: Thu, 8 May 2025 00:50:37 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: avoid unnecessary queue freeze in
 elevator_set_none()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20250507120406.3028670-1-ming.lei@redhat.com>
 <20250507120406.3028670-3-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250507120406.3028670-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6QFBlDpL4KgHy_D6_zoBuY9s2D5s48sy
X-Proofpoint-GUID: 6QFBlDpL4KgHy_D6_zoBuY9s2D5s48sy
X-Authority-Analysis: v=2.4 cv=LYc86ifi c=1 sm=1 tr=0 ts=681bb28a cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=9Pzygc1LrLfXtXmLMKgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE3NCBTYWx0ZWRfX+a76lkXsOllR Ajt51Ir+hO9UDrVqe8tYAqrOqo7fI8rr//CA1gqjayl/V6LkI6Y8j2UrVFKFEjcAI4x/LgQVdbl XePc3Q6bzDaH8mVhQgYwKvUKHF/fkCVSpKpoZMRORLfXQECRFROvX05lBExLR4DWpAK0U/mYxNO
 dft503ttrecc3neKNppQm0lvJQTrw5rqMiPg0gcVY1R4QlVQyBfXm9zuACAdJjbDCiFIBjto3+6 xzZbzBxxhtoMJ5r942FKkNM+sIobtsvrNWDSpJbnzIb/tEjpvSm0hajUH5jBJx3pCtxxp/y0f+j nP3CHq5EzgJ+hcZdCVQBL9XRdRbKq+gvG+61r0dcfVIc1EBGycVfw7D4OgvfqW3AWFZ/pn0Dny8
 WbMtFdghWlrh35gFQvhmGrqM05wUYmD550bzmhe+4v53vmpQt5R/SgirEKxL/MrJASY/BG2u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070174



On 5/7/25 5:34 PM, Ming Lei wrote:
> elevator_set_none() is called when deleting disk, in which queue has been
> un-registered, and elevator switch can't happen any more.
> 
> So if q->elevator is NULL, it is not necessary to freeze queue and drain
> IO any more.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/elevator.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index e1386b84a415..35f4de749dcd 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -754,8 +754,18 @@ void elevator_set_none(struct request_queue *q)
>  		.name	= "none",
>  		.quiesce_queue = true,
>  	};
> +	bool need_change;
>  	int err;
>  
> +	WARN_ON_ONCE(blk_queue_registered(q));
> +
> +	/* queue has been unregisted, elevator can't be switched anymore */
> +	mutex_lock(&q->elevator_lock);
> +	need_change = !!q->elevator;
> +	mutex_unlock(&q->elevator_lock);
> +	if (!need_change)
> +		return;
> +
>  	err = elevator_change(q, &ctx);
>  	if (err < 0)
>  		pr_warn("%s: set none elevator failed %d\n", __func__, err);

What in case blk_unregister_queue/elevator_set_none is called from
__add_disk ? The __add_disk and elv_iosched_store may run concurrently.
So I think we should remove sysfs entries (i.e. delete disk->queue_kobj)
before calling elevator_set_none() from blk_unregister_queue().

Thanks,
--Nilay 
