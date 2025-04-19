Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FC713C3F2
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745073556; cv=none; b=IMAeUtENAQp71t8fADHGN1dD1ucp2v+Xd2fR+OYsq/ChjexDPmg6dYJdK8oDfgvde0aegJA8ElPdbdPWWWo33UcZoPvJ29bKXqGgColVitaX5K2T2urqR1irJk3tTq3u1epRNgsOfQ6thkVzeBbg9Q/ypsK9Fn/GYqflzxGwvMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745073556; c=relaxed/simple;
	bh=g8Xbl108gwjIyxL9FgGirbhQxTAZp2p3zss3X7MfIgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpiNG8LFEUxO+c2k2DEwJBZ9YdOTaekPlfw150hJW7doEk7mTWtBihH13DdO3y/b2qWgRTAxrp1qhu3Ury+NwFlgQXDFJsQp7DeZC5mnl4wkGaxJI7LYcoBEBtpr2NDjwPcnmgeDx/gd6+RkAZYvGQDgQjlO4cdSeX8cnoDjabc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bVdDhpI3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bVdDhpI3"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53JAgcco012432;
	Sat, 19 Apr 2025 14:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qPUdZ/
	2Ee0OUGhiiFaGwReSuQqbJ7+tAsd2sHCOaxpg=; b=bVdDhpI3J0nl73LgKDM185
	8rYjc6WBl1WOMtZROiO5VeBE3r/HtoGn+cRHCW65qhKl3sP/W/lOl+bf0cjyuObw
	f879hPmDdfKTe7PkN528hTDkkFohhzRZWCnX8AxNJzkzv3fGqFpsCJuDC3wElLF0
	iPO+Mj0WrKgUYDChLzy/yiF9nBE6dRHnc8Uv5yMVOKN3vZ5uE5igshfJWKxhJ7Ij
	wCZRd9nPiGxbth+rNL7CFxrKgbeV3IkW5Say3zHpT7NwOrrt/HWzUJZuo7fv33wU
	FCMsMKe4+75TCGWnJvmT4XoiAbG/ae5/dmfz+dkae4DF9nHjk4+HNaYI3DVtBWxg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 464a9rgh7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 14:39:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53JDTYOP004570;
	Sat, 19 Apr 2025 14:39:07 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46483ts23g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 14:39:07 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53JEd71u64291278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 14:39:07 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DF4958059;
	Sat, 19 Apr 2025 14:39:07 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6965958058;
	Sat, 19 Apr 2025 14:39:05 +0000 (GMT)
Received: from [9.111.34.38] (unknown [9.111.34.38])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Apr 2025 14:39:05 +0000 (GMT)
Message-ID: <261d7b81-e611-47f4-ad55-6f7716c278c7@linux.ibm.com>
Date: Sat, 19 Apr 2025 20:09:04 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 20/20] block: move wbt_enable_default() out of queue
 freezing from sched ->exit()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-21-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250418163708.442085-21-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cb9Rt80yS7DZAm9N-x_HqDoYuMdLbTYM
X-Authority-Analysis: v=2.4 cv=WJp/XmsR c=1 sm=1 tr=0 ts=6803b58c cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=ZI1uFMTUGSoLyCOsBAwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Cb9Rt80yS7DZAm9N-x_HqDoYuMdLbTYM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504190120



On 4/18/25 10:07 PM, Ming Lei wrote:
> scheduler's ->exit() is called with queue frozen and elevator lock is held, and
> wbt_enable_default() can't be called with queue frozen, otherwise the
> following lockdep warning is triggered:
> 
> 	#6 (&q->rq_qos_mutex){+.+.}-{4:4}:
> 	#5 (&eq->sysfs_lock){+.+.}-{4:4}:
> 	#4 (&q->elevator_lock){+.+.}-{4:4}:
> 	#3 (&q->q_usage_counter(io)#3){++++}-{0:0}:
> 	#2 (fs_reclaim){+.+.}-{0:0}:
> 	#1 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}:
> 	#0 (&q->debugfs_mutex){+.+.}-{4:4}:
> 
> Fix the issue by moving wbt_enable_default() out of bfq's exit(), and
> call it from elevator_change_done().
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/bfq-iosched.c | 2 +-
>  block/elevator.c    | 5 +++++
>  block/elevator.h    | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 40e4106a71e7..310ce1d8c41e 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -7211,7 +7211,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
>  
>  	blk_stat_disable_accounting(bfqd->queue);
>  	blk_queue_flag_clear(QUEUE_FLAG_DISABLE_WBT, bfqd->queue);
> -	wbt_enable_default(bfqd->queue->disk);
> +	set_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT, &e->flags);
>  
>  	kfree(bfqd);
>  }
> diff --git a/block/elevator.c b/block/elevator.c
> index 8652fe45a2db..378553fce5d8 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -687,8 +687,13 @@ int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx)
>  	int ret = 0;
>  
>  	if (ctx->old) {
> +		bool enable_wbt = test_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT,
> +				&ctx->old->flags);
> +
>  		elv_unregister_queue(q, ctx->old);
>  		kobject_put(&ctx->old->kobj);
> +		if (enable_wbt)
> +			wbt_enable_default(q->disk);
>  	}
>  	if (ctx->new) {
>  		ret = elv_register_queue(q, ctx->new, ctx->uevent);
> diff --git a/block/elevator.h b/block/elevator.h
> index 486be0690499..b14c611c74b6 100644
> --- a/block/elevator.h
> +++ b/block/elevator.h
> @@ -122,6 +122,7 @@ struct elevator_queue
>  
>  #define ELEVATOR_FLAG_REGISTERED	0
>  #define ELEVATOR_FLAG_DYING		1
> +#define ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT	2
>  
>  /* Holding context data for changing elevator */
>  struct elv_change_ctx {

It seems invoking wbt_enable_default from elevator_change_done could probably
still race with ioc_qos_write or queue_wb_lat_store. Both ioc_qos_write and 
queue_wb_lat_store run with ->freeze_lock and ->elevator_lock protection.

Thanks,
--Nilay

