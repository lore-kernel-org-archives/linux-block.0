Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550023164BC
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764601915; cv=none; b=FFeIOw/5f7p07RV1pibdzlrgcYGKkrMGeaVmb03+sKE5NQzEUe6d5Tw+zNRbbFn16OP5tcYabYVeGxetJTZwUVdzNPbErJt4n9AdurkauTAock9tofPk1Dnk5TR9aEgUDGvlT+RlhNw9pPt8TXXIPxoEc1rdoSm7dvIBXUczOaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764601915; c=relaxed/simple;
	bh=OVlB7DDsd26rSiJyk9echjTZSTdGVbWDoO1w1zOmvh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FF8RhizaocEZ2+CIkYcvMz/2Isa2x87IzYMy7zB1TASJu/ki8ZPbNZvFsel4LnlCicUaZjc9V/PROJCQ2gmagO4QTYr+SAjaJYk2UOADJfuo8vHiPtfejrrzj/OwUhzHudQnR9gxwsEmJwbneGCT1s/CbjD9MHaMzT7yB4q5o/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E/rGvdC0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E/rGvdC0"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1AbimI024775;
	Mon, 1 Dec 2025 15:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a0Ik/g
	FrVx4R/GwZdMwMPt2n5WS/4PIiMlwcQDLQUzM=; b=E/rGvdC0Bq4BoeggAGRY7S
	5oVHOl4TgwFAZr8Pt5AhjAw/ycdGy+O1exxMZGvp5nkweMliVTr6gNULgLrPNHv2
	4mVRPoV2VbGDs5Wtu9S5mtErnn6wqqLH5/1oSTHEo4nw4qt1RkTQuSbnrwYVBYL0
	H2WHlIYsRE/9zHQJre79rIYMGpLhk1lWI3IB8gcG3duEqxbi10HlmaJxlz281ZGW
	oUATAgH4bF6SW6zYQHHU9KerNlY/i7n/aiTkJ0atueP0WeIt5F3kuqaLlmixJlHM
	wcCi+kWw42kBvPEBM6hOWe9IOFaXEJ9+/5Gfsd5NfC6iSqzyaHjSKkckY2SMuRoA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg57nxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 15:11:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1Cj6Cw010292;
	Mon, 1 Dec 2025 15:11:38 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arcnjy1j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 15:11:38 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B1FBb5Z29098496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 15:11:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D963C58056;
	Mon,  1 Dec 2025 15:11:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0121C5805D;
	Mon,  1 Dec 2025 15:11:36 +0000 (GMT)
Received: from [9.61.57.8] (unknown [9.61.57.8])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Dec 2025 15:11:35 +0000 (GMT)
Message-ID: <b6868832-a66a-4953-b6d3-afd0677c7319@linux.ibm.com>
Date: Mon, 1 Dec 2025 20:41:34 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] blk-wbt: fix possible deadlock to nest
 pcpu_alloc_mutex under q_usage_counter
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com, bvanassche@acm.org
References: <20251201083415.2407888-1-yukuai@fnnas.com>
 <20251201083415.2407888-3-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251201083415.2407888-3-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nCwRkTPmqiRr7t6ogYV66TiHOas_Uhet
X-Authority-Analysis: v=2.4 cv=Ir0Tsb/g c=1 sm=1 tr=0 ts=692db02b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=niCqs-AOtF3_HumQ8qEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX7EObgsueLR+u
 4njoJ2NxcmseAfdphwLOD/CachJGvErojxP8Xc/YPAduWo+e/LwA40c9ZQFrv/WIuzSJV1rPSTr
 YRYOPed4Ohu+ajsjbFqPzjd5ou/ZZirpbS7R4671tTO6noVDl9OzdP90iuTg8kh8JhjRw+45EpK
 S4kmVYI3VOOAMK9n80bQf5p+zvTmP4eWYOLLifqjwubvvF1amqstICFYRxhWQJNj9e8pgsAL5s6
 yydq/w6RV9DvWMu0QTzdVoy542myPbtDYNFi1Xe7mrNjGLDhlHhDaB7Ju80Z8wWGy/euzSps5lI
 O4NyLOqVSKHQA2Ob83fOprlBxNWLMtQNVVWf+fDI1msIcHRqQyMsvz+9iwL0Wv6vbZowYWU4505
 bouRB/cTnD4CUflqRpztE80eNscTkw==
X-Proofpoint-GUID: nCwRkTPmqiRr7t6ogYV66TiHOas_Uhet
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290020

>  
> -static int wbt_init(struct gendisk *disk)
> +static int wbt_init(struct gendisk *disk, struct rq_wb *rwb)
>  {
>  	struct request_queue *q = disk->queue;
> -	struct rq_wb *rwb;
> -	int i;
>  	int ret;
> -
> -	rwb = kzalloc(sizeof(*rwb), GFP_KERNEL);
> -	if (!rwb)
> -		return -ENOMEM;
> -
> -	rwb->cb = blk_stat_alloc_callback(wb_timer_fn, wbt_data_dir, 2, rwb);
> -	if (!rwb->cb) {
> -		kfree(rwb);
> -		return -ENOMEM;
> -	}
> +	int i;
>  
>  	for (i = 0; i < WBT_NUM_RWQ; i++)
>  		rq_wait_init(&rwb->rq_wait[i]);
> @@ -934,19 +948,24 @@ static int wbt_init(struct gendisk *disk)
>  	return 0;
>  
>  err_free:
> -	blk_stat_free_callback(rwb->cb);
> -	kfree(rwb);
> +	wbt_free(rwb);
>  	return ret;
> -
>  }
As we moved the allocation of @rwb out of wbt_init() function,
it looks bit odd to still keep the release of @rwb, in case of
failure, in wbt_init(). IMO, we should handle the failure (release
of @rwb) in the respective callers of wbt_init() where we actually
allocate @rwb.

>  
>  int wbt_set_lat(struct gendisk *disk, s64 val)
>  {
>  	struct request_queue *q = disk->queue;
> +	struct rq_qos *rqos = wbt_rq_qos(q);
> +	struct rq_wb *rwb = NULL;
>  	unsigned int memflags;
> -	struct rq_qos *rqos;
>  	int ret = 0;
>  
> +	if (!rqos) {
> +		rwb = wbt_alloc();
> +		if (!rwb)
> +			return -ENOMEM;
> +	}
> +
>  	/*
>  	 * Ensure that the queue is idled, in case the latency update
>  	 * ends up either enabling or disabling wbt completely. We can't
> @@ -956,9 +975,11 @@ int wbt_set_lat(struct gendisk *disk, s64 val)
>  
>  	rqos = wbt_rq_qos(q);

Hmm, we have already evaluated wbt_rq_qos() above, so then
why do we re-evaluate it here again? Can't we directly instead
re-use the value of @rqos here?

>  	if (!rqos) {
> -		ret = wbt_init(disk);
> +		ret = wbt_init(disk, rwb);
>  		if (ret)
>  			goto out;
> +	} else if (rwb) {
> +		wbt_free(rwb);
>  	}
>  
As @rwb is allocated outside of ->freeze_lock, I think wbt_free()
should be also called after we unfreeze the queue.

Thanks,
--Nilay
