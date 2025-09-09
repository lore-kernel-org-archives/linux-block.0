Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AB02D0C70;
	Tue,  9 Sep 2025 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418055; cv=none; b=dw0sO6X++I0yOj7fjwv83YKwFrV/PZiVfH4ERWpAneP+CHZ/Rb4/PrGet0PVXIB0929NYyR6bHEXLhscT3mlrF5Bl57ME6bmzrlc7IU/0oNCZZm6q8XbU6qTQZwFsIeCXhrgg2Akfj/4I+H9mKEAuu/aw4ESVzGj1zu/PijgNjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418055; c=relaxed/simple;
	bh=s9NY9uwMOTLbNgXNSfkPK1HPJxzJpqK+YQtSm1l6Pbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQLydV984ZCWROYtdF/BrW1vJiMNa4nv4RdbamvhkHrXN8XUKJc3WYmKqB6LDyQ3/fRSNisCJc2d1zU5WVLJzlk37Onx4u0kJBocY/aJp3s0+p564NifVaysVwrMsCuyrAu/PV8WVipig1Y7DU0dQu6Lv1lfPOIaiEQF0FBRJp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aMlfp729; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aMlfp729"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5897LS4M001202;
	Tue, 9 Sep 2025 11:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CHbk+J
	OaifgnyjxftWdKWmFE7PwKdQsRxmsglnKUgMQ=; b=aMlfp729AyqgLfMU0IMxhF
	Mh+lgs2pOZmtORVcH20Jl8mv2eSyInUIUpmun4fNWAn1flWQXZujGGPVcrAicLVa
	EcQeOqGVpFvkXH3ckKgVt1uuLpIb3+EqGSDf9EWNAP5Pf8lkEampFZRpqSppIm8B
	8XPtK9t7iYg2pEzG2wqtuxunMt5LNdk7W+0YF1INZkZcY7+cnOEBs0jLXMvM7JVY
	X/tiHXm3UHqD8yajkEJZEzqNXlvZQBA5IzJp7nrRPFDguTpAjHD3ObNTdt2B14fE
	eDsFoaKs/eKIh4fpeRTVStXC3r9lxPyJEhA4KIFfy17713ENvzSieK25shqXUZfA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acqyav5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 11:40:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 589AS2O8010613;
	Tue, 9 Sep 2025 11:40:37 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910smttpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 11:40:37 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589BeaaA41026166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 11:40:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84C5358057;
	Tue,  9 Sep 2025 11:40:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6C6F58058;
	Tue,  9 Sep 2025 11:40:32 +0000 (GMT)
Received: from [9.43.86.190] (unknown [9.43.86.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 11:40:32 +0000 (GMT)
Message-ID: <0d471fbc-ec63-4a96-a49a-1f54754c2432@linux.ibm.com>
Date: Tue, 9 Sep 2025 17:10:30 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 04/10] blk-mq: convert to serialize
 updating nr_requests with update_nr_hwq_lock
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-5-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250908061533.3062917-5-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: djP8IWlXhYx4U2A9tq2-i73u8opfIGbd
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68c01235 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=CTgejVLxCpRuXOwdBJ0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: djP8IWlXhYx4U2A9tq2-i73u8opfIGbd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX4XcTJHmS1hcV
 kWRYGHw97Nol8nYZ+jTZDD70XEBGy1Yq2AdwU9f1SHtAPQlq9Ydv4ujYJOWG8vttNdSmLI94suq
 4wlxSCU+GyzmqLZLQFtsD42pmM40NuTxTWVCTZ58FzMtguKwDTwvXgueDT6IfT3ov11f0V+weRl
 LibvEUjfmTCUtvt4z/4nbu/DhpXNYssVk3YmebfBg1dRByuCtPx7//xjuMBAoRima5lhi2qLpfE
 6m3QaVRIK8qYDEVaRgmj2P7ge+30QFMhKLgGJ6KwOHWTkSO1zXUY40aSJbEJ63RvK0nQ6vOeMcC
 xX7msHhQbY86jAJ4t8otMExsLrgflBREiHNvfK/gvrusGrEGgv1Ed+276/Bj0nqVxNh1eurEmYP
 26NwZ3/a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000



On 9/8/25 11:45 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> request_queue->nr_requests can be changed by:
> 
> a) switching elevator by update nr_hw_queues
> b) switching elevator by elevator sysfs attribute
> c) configue queue sysfs attribute nr_requests
> 
> Current lock order is:
> 
> 1) update_nr_hwq_lock, case a,b
> 2) freeze_queue
> 3) elevator_lock, cas a,b,c
> 
> And update nr_requests is seriablized by elevator_lock() already,
> however, in the case c), we'll have to allocate new sched_tags if
> nr_requests grow, and do this with elevator_lock held and queue
> freezed has the risk of deadlock.
> 
> Hence use update_nr_hwq_lock instead, make it possible to allocate
> memory if tags grow, meanwhile also prevent nr_requests to be changed
> concurrently.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-sysfs.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index f99519f7a820..7ea15bf68b4b 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -68,13 +68,14 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
>  	int ret, err;
>  	unsigned int memflags;
>  	struct request_queue *q = disk->queue;
> +	struct blk_mq_tag_set *set = q->tag_set;
>  
>  	ret = queue_var_store(&nr, page, count);
>  	if (ret < 0)
>  		return ret;
>  
> -	memflags = blk_mq_freeze_queue(q);
> -	mutex_lock(&q->elevator_lock);
> +	/* serialize updating nr_requests with switching elevator */
> +	down_write(&set->update_nr_hwq_lock);
>  
>  	if (nr == q->nr_requests)
>  		goto unlock;
> @@ -89,13 +90,18 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
>  		goto unlock;
>  	}
>  
> +	memflags = blk_mq_freeze_queue(q);
> +	mutex_lock(&q->elevator_lock);
> +
>  	err = blk_mq_update_nr_requests(disk->queue, nr);
>  	if (err)
>  		ret = err;
>  
> -unlock:
>  	mutex_unlock(&q->elevator_lock);
>  	blk_mq_unfreeze_queue(q, memflags);
> +
> +unlock:
> +	up_write(&set->update_nr_hwq_lock);
>  	return ret;
>  }
>  
As you moved ->elevtor_lock here and thus directly access q->elevator
without holding ->elevator_lock, please add a comment explaining why
is it safe to access q->elevator without holding ->elevator_lock. 
So with that change, please add:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>









