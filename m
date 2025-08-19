Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F357C322DCE;
	Tue, 19 Aug 2025 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607544; cv=none; b=sl7SJ92oelVI6s9Xun/E2+iCV9BH6bwCDjQ/OPrGXpvwRziRZk0gx/rjQIQ+sKpJm+52TYnaAuLoKz73PAzg5PnUlPcfondIvCLOb6Wfc8KWOcfsxLK2hl+JuzkNmqGWzQZDK+O4HFN5nl9IzDqzrZL2emlsYO68PtKRnF4tw1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607544; c=relaxed/simple;
	bh=DOaYyY3dPlMZ19pDkvgFfb1JmZrW9p6/h1uFxNp39+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJgmmfhyEfd6XJUo/AYJf4ykiLg6FSE7dxv+x1wEjagF8EQzSt+crOnLhYV0JoyABQ8doge+NmYewM+hzALlHgsd7lL4g+MSGs4fTZb24geVNIJMU9bIBeYnheLLPrFkjQ914GvphdHtLRkMCTfDQLRwg/6IC0mrr1A73udTD6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HiWmWAzp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HiWmWAzp"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J4Cd9t015764;
	Tue, 19 Aug 2025 12:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/Ac+8j
	gBXJ+3OWDLmZUZDMI9qy2784/4c8K5U+a435k=; b=HiWmWAzpSrsdG8cQmeMEJ/
	CO1+C/XdFYbdREFyCjzfob0LKQCzVGf0XoFA7r6/lPadC4xn5TaXxJarz4NNxAM6
	+cK9mbFmi0Bp1s1ZSiOLiXijZquKhucfX6S6ctxKw9fl+Zl5btqddc3TzAqorC68
	qOIWKQE1p22gyqG6dV/tbDW61OFI2mEAAgS1fJoSYEGJE2XLSabGtChWwftRpwtF
	5id/TgwJQW17bOqa261wPgK9XVMh5ojBHyn9Dhk7kIbRzZujqcXaDah+bLiebYPm
	ms767yGiITWTBYN0hHLQ/w44M0ND249BQo2s/FDlZOcKMVKSdodun57quahbE6Rg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhn3xdmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 12:45:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57JBQ1Fh002362;
	Tue, 19 Aug 2025 12:45:10 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k7131y96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 12:45:10 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57JCj94J31982108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 12:45:09 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A17235805C;
	Tue, 19 Aug 2025 12:45:09 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D60EB5805D;
	Tue, 19 Aug 2025 12:45:05 +0000 (GMT)
Received: from [9.61.13.229] (unknown [9.61.13.229])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Aug 2025 12:45:05 +0000 (GMT)
Message-ID: <a9ebef3c-8e80-443d-9532-348aa93126a1@linux.ibm.com>
Date: Tue, 19 Aug 2025 18:15:04 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] blk-mq: fix blk_mq_tags double free while
 nr_requests grown
To: Yu Kuai <yukuai1@huaweicloud.com>, yukuai3@huawei.com, axboe@kernel.dk,
        bvanassche@acm.org, ming.lei@redhat.com, hare@suse.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250819012917.523272-1-yukuai1@huaweicloud.com>
 <20250819012917.523272-3-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250819012917.523272-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uujpvOiwfbr7jgpXCoEa_TuBisGAuzG5
X-Authority-Analysis: v=2.4 cv=L6wdQ/T8 c=1 sm=1 tr=0 ts=68a471d7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=Z-p53K9XzCp1Y_umpS0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uujpvOiwfbr7jgpXCoEa_TuBisGAuzG5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfXyBUa0SXy2Dlv
 /h0FuDuGgR/TB1NP8vtYTlBwRO30U9wB+IwTDIuxFuW8SObJrcBmsfazBNcx7FiKjpK60tCOSTz
 GZWfiq1Glsf2Vqkv7p3WX1V0QucJZTu9CA5c2RQhj2709TBWl8YlQZ92bBekecjovKRnLVgKDPP
 Vlu9e11X8ANPzBxs+a10x8RZFJ1tYtO2rgjpWoL8oQhh1v9S6MBqwrlUhwUXTlRjxEEOTTQR9Io
 Q98ZRkpoX999KN4JbvOqOdTbmfdb056LawpG0lY+XlpqVjAlrB1wkX670wLHnBwvaO+28/pFvQY
 rrzr5Ud8VCypvMWBCZs+Xng7O/ZRdzbaNJNeQX74RYEs2XT2kbaQwk5K7XDhFPlhEcKxwcfkBmA
 0pCl59Hk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160027



On 8/19/25 6:59 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> In the case user trigger tags grow by queue sysfs attribute nr_requests,
> hctx->sched_tags will be freed directly and replaced with a new
> allocated tags, see blk_mq_tag_update_depth().
> 
> The problem is that hctx->sched_tags is from elevator->et->tags, while
> et->tags is still the freed tags, hence later elevator exist will try to
nit: 's/exist/exit'

> free the tags again, causing kernel panic.
> 
> Fix this problem by replacing et->tags will new allocated tags as well.
nit: 's/will/with'

> 
> Noted there are still some long term problems that will require some
> refactor to be fixed thoroughly[1].
> 
> [1] https://lore.kernel.org/all/20250815080216.410665-1-yukuai1@huaweicloud.com/
> Fixes: f5a6604f7a44 ("block: fix lockdep warning caused by lock dependency in elv_iosched_store")
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-mq-tag.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index d880c50629d6..5cffa5668d0c 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -622,6 +622,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>  			return -ENOMEM;
>  
>  		blk_mq_free_map_and_rqs(set, *tagsptr, hctx->queue_num);
> +		hctx->queue->elevator->et->tags[hctx->queue_num] = new;
>  		*tagsptr = new;
>  	} else {
>  		/*
Except the above minor nitpicking this change looks good to me:

Reviewed-by: Nilay Shroff<nilay@linux.ibm.com>

