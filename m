Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02312FCC08;
	Thu, 14 Aug 2025 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174263; cv=none; b=NdV2O+S1wlkQCb0kUJulBpon2m/AQQMpvFKMemVyioxgALI+MbU0wCtXW2cIFUhIb/w8UcDK9dPN3Px8lvlO771YridbpEk+Hd1QDa3wTUFo1YoHVRxhJzGh4bBvotGZE4dWuJJRny4BHY+LBMxxFIXcHl2uu4ToULuHD1+76D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174263; c=relaxed/simple;
	bh=imRy9/rTS+jFrxLqrITG8ZbEaGjF1mQoJJavTC1P4Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+Yck8kqxxSZk5IAxchzg19czUZaXl+r2JCNLeJWxaQIiIRl661nUxBar0IUaGOqdA30IC3OVImVJKZ1/zAE+AJA2VqrssRjxqeYpde7IrnVH5d6Dojs+eM+ocSNJAewRsc9S4OKa/l4cH0d6hTMzm0Z5YvIbBG3fHhNTyr88I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KW7v5jn+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KW7v5jn+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E76EOO015639;
	Thu, 14 Aug 2025 12:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=M29KWk
	ElsUhvyscwf2ThVWTlfAT94DbC0gnGyRczS8E=; b=KW7v5jn+uerMv5rhR9MYGQ
	KOIqBl2Bp8MQ8U91UVP/sdRZAMQJh0OTgoNYYQMjCqrDFBsVUMegYVsfW/caYcLx
	aXvzMbYuICzTGR/WKmqoo7yHuY6BgLuijOPgZrblFmnHF8legwnsenONpkQHWqRY
	B3bAOJBFTOE5SU5fR18k2sSZxTAx5uu6fSNiEbVYUd+OPzAAI6VOE4eNSRgOkg06
	4/Fnj6an6U301BQ5wllOh06bh3ZcCnYqbkAdg9OqjMW8UEMOVd8p0KxeGCE0Fzo8
	Yb0k2ZoHNJ3w7MiwX2U93o1qxkRI0MBfJYMeLiyV/21LL6KTxUhWkGuuIoRAv8AQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48gypebxcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 12:23:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57EAx2KB017588;
	Thu, 14 Aug 2025 12:23:46 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3us93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 12:23:46 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57ECNk1u23593624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 12:23:46 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 321AD58057;
	Thu, 14 Aug 2025 12:23:46 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEC1858059;
	Thu, 14 Aug 2025 12:23:42 +0000 (GMT)
Received: from [9.109.198.214] (unknown [9.109.198.214])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Aug 2025 12:23:42 +0000 (GMT)
Message-ID: <97b63163-a122-48f0-805a-a06cf792903f@linux.ibm.com>
Date: Thu, 14 Aug 2025 17:53:41 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] blk-mq: remove useless checkings from
 blk_mq_update_nr_requests()
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, yukuai3@huawei.com,
        bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250814033522.770575-1-yukuai1@huaweicloud.com>
 <20250814033522.770575-4-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250814033522.770575-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=eaU9f6EH c=1 sm=1 tr=0 ts=689dd553 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=i0EeH86SAAAA:8 a=Ht_Kdwx_m2KS6Q0RhUUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: q75vbzp6xud_QhqAQ7zzK0-OtmOiOY6E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE2NyBTYWx0ZWRfX2qm4Bcdv8gsh
 9hGWMhYBBJxrg2Pqz0Uzft1b3i3lXDrzJwTOne6AhRwAaddGNRssiPVnUmrLaDMAUPO9no64RSt
 ZQNKBNuNGx2Hiw8r/anu2ARs+y+O21TUiyPcKr6I/ARJs+pLxBXIy3Zfgt5cC6PUCBQfn/1BgCz
 XRyD/RjzcmoU1vqwGDNdBLTcI50tKLc4N/HFj8q/tDDqadjUC49vNec35xLInT66kbQZNv52mVz
 iWh4X28kTGXCQ5qknGZzrp4S2NbFjLris1CI0vsowu4UmoeBcC6jSaNZE1fNBcnj2tsx2Zq+e1V
 qR3jAZ1wLI0xAUdYP0B1l70+M5z/GhrbA7Gu3k/h4znFJv169GTXKuyXOCsO02X+oh7HGhlqlA0
 2RKIVF79
X-Proofpoint-ORIG-GUID: q75vbzp6xud_QhqAQ7zzK0-OtmOiOY6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508130167



On 8/14/25 9:05 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> 1) queue_requests_store() is the only caller of
> blk_mq_update_nr_requests(), where queue is already freezed, no need to
> check mq_freeze_depth;
> 2) q->tag_set must be set for request_based device, and queue_is_mq() is
> already checked in blk_mq_queue_attr_visible(), no need to check
> q->tag_set.
> 3) During initialization, hctx->tags in initialized before queue
> kobject, and during del_gendisk, queue kobject is deleted before
> exiting hctx, hence checking hctx->tags is useless.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-mq.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b67d6c02eceb..3a219b7b3688 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4921,24 +4921,15 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>  {
>  	struct blk_mq_tag_set *set = q->tag_set;
>  	struct blk_mq_hw_ctx *hctx;
> -	int ret;
> +	int ret = 0;
>  	unsigned long i;
>  
> -	if (WARN_ON_ONCE(!q->mq_freeze_depth))
> -		return -EINVAL;
> -
> -	if (!set)
> -		return -EINVAL;
> -
>  	if (q->nr_requests == nr)
>  		return 0;
>  
>  	blk_mq_quiesce_queue(q);
>  
> -	ret = 0;
>  	queue_for_each_hw_ctx(q, hctx, i) {
> -		if (!hctx->tags)
> -			continue;
It's possible that hctx->tags is set to NULL in case no software 
queues are mapped to the hardware queue. So it seems that this
check is valid. Please see blk_mq_map_swqueue().

Thanks,
--Nilay

