Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E02178372;
	Tue,  9 Sep 2025 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420318; cv=none; b=OpPUfGe4Tk7Laa1S3XaZFXdB+t4SE2IzMyHwZ8vVRThausjCZHU4sOvDFhorAAGQFTY4D6NZe8c3mqNA7ANWvrk7AzCAHvldUSMzRoa7FDBDPtAlXxCRXSmEJt7P/UXLpm5O/6OKHC5ZWd45b4vc2IOmKYvCEiglESjABXYRFK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420318; c=relaxed/simple;
	bh=cujoFsE14JCXkibMkpAZKReEWmC+fx7hcUGG6TbJl/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYgJpyRQ9EhuajDa81OZCQT0yvf+ivoVjMaLaKUwH9qCLo9uGu0I6GJxYxOr9C7nopIngHE6rzi0QLhDOZqVnVCsnyYG02aMmgQHWuWOXHp7h5EegKsZUzaDDHLGWObdyS7gHsfdgFZ6noqwfzb/l3w29k+zb+C88SLDTiqqbHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SR/ypT/p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SR/ypT/p"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5897q4Is004056;
	Tue, 9 Sep 2025 12:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0aq9qy
	nCOp09Dq7+Yq/H42psMJpkJ9bgJFemLz3ZpxQ=; b=SR/ypT/pbB0koYYDbcrd3e
	Tn2DoGCEqdb7RN2LOcppqyFHZE5A69wwt8tJ2Dl60UFs624vbnqN4HqsiuIVE6cs
	DghpLHsyc09uKF2GLFY3mwGtIWFjBIDy6oDxRsYLNKomd+gFgDD+gC0C51pcMntu
	tMmjKbAtxybwCK8hAgqEMxdoht5PemKAaq25tUa09mEviFYnJs85Mj3BaWZoSh1m
	QYOS9Y2VuDtKhTBdUBWh5bDgEBWuuut7y9TfqJ+b9/KTvQqYfc0a72IWfGORz9BY
	wK/ThFWKD0isMHjn5WPpEMkpBb9S4ZZTBOWwVXx8Ov4IuRaIcFVUH0vjAA4ZcNBA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff7pjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 12:18:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 589ACt4Z010618;
	Tue, 9 Sep 2025 12:18:20 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910smtypv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 12:18:20 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589CIJpw18743890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 12:18:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59C9F58062;
	Tue,  9 Sep 2025 12:18:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A957758061;
	Tue,  9 Sep 2025 12:18:15 +0000 (GMT)
Received: from [9.43.86.190] (unknown [9.43.86.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 12:18:15 +0000 (GMT)
Message-ID: <85259339-d832-468a-a9b0-0c326c896370@linux.ibm.com>
Date: Tue, 9 Sep 2025 17:48:13 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 06/10] blk-mq: split bitmap grow and resize
 case in blk_mq_update_nr_requests()
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-7-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250908061533.3062917-7-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1B8PF_wVN8RcG8Lq__XAL6089s8Fs_cU
X-Proofpoint-GUID: 1B8PF_wVN8RcG8Lq__XAL6089s8Fs_cU
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c01b0d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=e6Q6uKZYdjjBcYIfd34A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX9sxGlS63whNm
 EsuoyGv8XvVk7rc6u++V7MdWrFC+8NnW7ymGBd6vD8dpffSYMtn1Jruv4LlP/ZRu0tyiDiVgtSo
 k2UMBiKLOD62R5GG5jZY07tQhh1KeMSHAHGWul/U1PWbSRdN7i1MSygHJQwM7iFQv6p6a3mfUiZ
 b8GhD2xq55696oiVXMSSIFib9ysz2cgrngq+XScZW4qiiszPKFHUYLGjlOTGBl8PB/zy9eKCxmL
 NSIozAZE/mj/2fB0JqgEZarNdvQIlyWzExHOanphigdUHIKNUT26pMk66sT1bkRFzrlYOvfOKYN
 SnP7ybbiXecBGqXWvMp6ktbijKjT8WhJGjFJEZ+xigSchx6IYCehN54m20y3P4XzfTicmJ8rx2Z
 0DjPxHKs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020



On 9/8/25 11:45 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> No functional changes are intended, make code cleaner and prepare to fix
> the grow case in following patches.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-mq.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1ff6370f7314..82fa81036115 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4931,21 +4931,25 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>  			blk_mq_tag_update_sched_shared_tags(q);
>  		else
>  			blk_mq_tag_resize_shared_tags(set, nr);
> -	} else {
> +	} else if (!q->elevator) {
>  		queue_for_each_hw_ctx(q, hctx, i) {
>  			if (!hctx->tags)
>  				continue;
> -			/*
> -			 * If we're using an MQ scheduler, just update the
> -			 * scheduler queue depth. This is similar to what the
> -			 * old code would do.
> -			 */
> -			if (hctx->sched_tags)
> -				ret = blk_mq_tag_update_depth(hctx,
> -							&hctx->sched_tags, nr);
> -			else
> -				ret = blk_mq_tag_update_depth(hctx,
> -							&hctx->tags, nr);
> +			sbitmap_queue_resize(&hctx->tags->bitmap_tags,
> +				nr - hctx->tags->nr_reserved_tags);
> +		}
> +	} else if (nr <= q->elevator->et->nr_requests) {
> +		queue_for_each_hw_ctx(q, hctx, i) {
> +			if (!hctx->sched_tags)
> +				continue;
> +			sbitmap_queue_resize(&hctx->sched_tags->bitmap_tags,
> +				nr - hctx->sched_tags->nr_reserved_tags);
> +		}
> +	} else {
> +		queue_for_each_hw_ctx(q, hctx, i) {
> +			if (!hctx->sched_tags)
> +				continue;
> +			blk_mq_tag_update_depth(hctx, &hctx->sched_tags, nr);
>  			if (ret)
>  				goto out;
>  		}

The above code is good however can this be bit simplified? 
It's a bit difficult to follow through all nesting and so
could it be simplified as below:

if (shared-tags) {
    if (elevator) 
       // resize sched-shared-tags bitmap
    else
       // resize shared-tags bitmap
} else { 
    // non-shared tags
    if (elevator) {
        if (new-depth-is-less-than-the-current-depth)
            // resize sched-tags bitmap
        else
            // handle sched tags grow
    } else
        // resize tags bitmap    
}

Thanks,
--Nilay

