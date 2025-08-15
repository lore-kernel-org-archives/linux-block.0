Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B3D1A317D;
	Fri, 15 Aug 2025 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755286250; cv=none; b=CgKO0X3kAcIEs8Nyawkb1YZoAlSMlrpjEsARbK1Jxk202eJnNs8qiuuP3G9FVNRJl2X4P4zkAzWu8ILc/W3zAaU31j5/bY86e5PNvgQ140oHTu+1IiIa7/QQJb/8zqmDkO/CmLIDR1Qz1iLIcqM1fI5tC38lwRGlxTxvLGCzZzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755286250; c=relaxed/simple;
	bh=LIUN4h4yw4ft2qyCi6RNdF8GTba6nR+7b5pIW7QC51E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YP3jbNCAn9ZtSVm2G1E1ytzx81RgMGxOhVOQ+tpvTKlTTuHgXSzVLSalvr+WmZyk230ez0SX0Yr7b4a3iK2smrx/9BJ7M5ggMw+rqvnRMpnetJ2aYWvqxOZuEUpb8Xq1PjTpB56aN39q50F+8qM0bjZUH4dbLwHSXrPWukpO/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mlRANl1o; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mlRANl1o"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FHC94j009920;
	Fri, 15 Aug 2025 19:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=z1Lhoh
	abQ3gFlTR5qpmL3Ip+uGo4AF7+5RLqd2KVj1U=; b=mlRANl1o3Qp2twNhezdiMK
	FB8p2fzND8IUkdpf8hnwxbBQfuiWRQdH5Y30paMdjMFipCvIiVwa0ICEygmjODi/
	+p25yOeG5FCqBwCNiwYQsbY3brn6+uf23dJQQ13KNQMo/Jm31bXbgLntNfkLuJrN
	w9tVLhmx7MIddRyRa1EsFSz6H1q8uuRzWyVkUfMeWKzLgtnEUNDz3AJYrM7Gr4r5
	BVLUC/aQtmjmzZh3/fa54IkHgRfkemCl3wILRUrlqx3OHFyZVNmlKlw/7NZofEmn
	iGnrFb+gaj6QCkY/rr4Hu2HI3jpkSJmVQ5zroe/jmt600hJUdfVwg+X9jgSWVTXg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwuds438-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 19:30:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57FHu3NC017612;
	Fri, 15 Aug 2025 19:30:28 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc42219-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 19:30:28 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57FJURm928705196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 19:30:27 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90C785804E;
	Fri, 15 Aug 2025 19:30:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44E3B5803F;
	Fri, 15 Aug 2025 19:30:23 +0000 (GMT)
Received: from [9.61.100.151] (unknown [9.61.100.151])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Aug 2025 19:30:22 +0000 (GMT)
Message-ID: <c5e63966-e7f6-4d82-9d66-3a0abccc9d17@linux.ibm.com>
Date: Sat, 16 Aug 2025 01:00:21 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] blk-mq: fix blk_mq_tags double free while
 nr_requests grown
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, hare@suse.de,
        ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250815080216.410665-1-yukuai1@huaweicloud.com>
 <20250815080216.410665-9-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250815080216.410665-9-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfXxDUDD5G5N6kA
 tQKpMVOEqPBAOClyzClO6KAo2yewuYSQg2LuEisIYTIsjq151goe09g0XbVhPOlmxxvdgIOFXTz
 ynHKLse8sbTW9DOkd0zO3U9rx/EATEJKRD3ErUeGhSxLJmn48AzgNSRd8ll/kBRRWRqmZ1W83lW
 4VF+JNqCeTyw0MeUhAAuyAH+ulf5IEKSSTjS5fYK6g34mpPP5q2sXhVFAZWKZZ90tor4m0MAaP2
 MBd3h3fo4pzN46Bf6RSWgWhpT01MnSe0rHRjbkvT7hIzYiGaOxRug1KpDoTOyq/jtxD3YG25ync
 N22fEAzo5QkS/gshc5+3waUssZD+t/FnadB0ICFIJyEaDrBYv+ykAAk1jWCzgS+0sVIfEv4o4lz
 2xYUUbr4
X-Authority-Analysis: v=2.4 cv=d/31yQjE c=1 sm=1 tr=0 ts=689f8ad5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=i0EeH86SAAAA:8 a=6NI6H_c-a1oXmsWDywsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 22lrSZWapXlJoReEJI4Dqrs-y8PYy6id
X-Proofpoint-ORIG-GUID: 22lrSZWapXlJoReEJI4Dqrs-y8PYy6id
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_07,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224



On 8/15/25 1:32 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> In the case user trigger tags grow by queue sysfs attribute nr_requests,
> hctx->sched_tags will be freed directly and replaced with a new
> allocated tags, see blk_mq_tag_update_depth().
> 
> The problem is that hctx->sched_tags is from elevator->et->tags, while
> et->tags is still the freed tags, hence later elevator exist will try to
> free the tags again, causing kernel panic.
> 
> Fix this problem by using new allocated elevator_tags, also convert
> blk_mq_update_nr_requests to void since this helper will never fail now.
> 
> Meanwhile, there is a longterm problem can be fixed as well:
> 
> If blk_mq_tag_update_depth() succeed for previous hctx, then bitmap depth
> is updated, however, if following hctx failed, q->nr_requests is not
> updated and the previous hctx->sched_tags endup bigger than q->nr_requests.
> 
> Fixes: f5a6604f7a44 ("block: fix lockdep warning caused by lock dependency in elv_iosched_store")
> Fixes: e3a2b3f931f5 ("blk-mq: allow changing of queue depth through sysfs")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-mq.c    | 19 ++++++-------------
>  block/blk-mq.h    |  4 +++-
>  block/blk-sysfs.c | 21 ++++++++++++++-------
>  3 files changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 11c8baebb9a0..e9f037a25fe3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4917,12 +4917,12 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
>  }
>  EXPORT_SYMBOL(blk_mq_free_tag_set);
>  
> -int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
> +void blk_mq_update_nr_requests(struct request_queue *q,
> +			       struct elevator_tags *et, unsigned int nr)
>  {
>  	struct blk_mq_tag_set *set = q->tag_set;
>  	struct blk_mq_hw_ctx *hctx;
>  	unsigned long i;
> -	int ret = 0;
>  
>  	blk_mq_quiesce_queue(q);
>  
> @@ -4946,24 +4946,17 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>  				nr - hctx->sched_tags->nr_reserved_tags);
>  		}
>  	} else {
> -		queue_for_each_hw_ctx(q, hctx, i) {
> -			if (!hctx->tags)
> -				continue;
> -			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
> -						      nr);
> -			if (ret)
> -				goto out;
> -		}
> +		blk_mq_free_sched_tags(q->elevator->et, set);

I think you also need to ensure that elevator tags are freed after we unfreeze
queue and release ->elevator_lock otherwise we may get into the lockdep splat
for pcpu_lock dependency on ->freeze_lock and/or ->elevator_lock. Please note 
that blk_mq_free_sched_tags internally invokes sbitmap_free which invokes 
free_percpu which acquires pcpu_lock. 
 
Thanks,
--Nilay


