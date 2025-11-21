Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5372F25FB
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763721675; cv=none; b=PnKzhCy0iXaEqeF3D7ge+41ehNLws45j/wG8EzID408sa2sYyP2Q/UVS8EDXeJzPVJwNL+kETQ4iF5agF1bXgD7jdt15Qq+5PNWf6F23du/XYdqT2/OMvrKTiHJ1IAITPXqRfu7yAV0GpDVv8aSEf+4+U1Mw1vJY+CKlulR2CTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763721675; c=relaxed/simple;
	bh=kedrJrmXbHH4cu2zTbRBaF0UY9OTwlIbS1cV1/2BZn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=TlbyDxn18YbM44saX/BW131dlpEiohjMu9965KfT4nJk1iWpa8VJXARkMc8rxr7QxQ4IZhAgakvPbk9sVFQW17PWtnlvc8Y4hKMXePg2HUE8CO7DVN6HY2vemoARzKglORrPi0cHkuv2tdmuD5D+jhttLtSCFF0xxIRH+L36OJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nwFzokUb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nwFzokUb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKN1x1K013647;
	Fri, 21 Nov 2025 10:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Of8qft
	3PXEk6x56rsiV/UABfshcx1krCUvMMlOTnhvo=; b=nwFzokUbaN7aHCEhMKZerL
	xaXCMMDLuoFOwtLhwZ1vaC89HaFQ0Y4UPoEQ3XxG0Ya6NqofmydCApHahc5dXIEb
	N1z/2bR38wUi5Sw/64IUGyNnO6OnB97nak0yKSbwi5kBL0TYLM+vDoHSEBzWQDO6
	+NagQZmJ069elPFK79cPVcBKgtvclJljcwKMWPQYKYA4Nv+aJNLhjTfLdeK4HNvV
	b8KoTYtS++qkQ0jRcWLK3+kr6ipan8Uz5JwKJYbBAHVluk/0exyJy+bxe6QY2+Uu
	aBDAXhM3PWPJ4rAutA5fOcYR8Pm0M2RuSoA3MDgNyApjfcLTuVZggYu3Vh4gIFZA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejgx9w0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 10:40:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AL8KeSu022042;
	Fri, 21 Nov 2025 10:40:56 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4unbphx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 10:40:56 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ALAegMe61145396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 10:40:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5510C5805B;
	Fri, 21 Nov 2025 10:40:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBDC858059;
	Fri, 21 Nov 2025 10:40:52 +0000 (GMT)
Received: from [9.61.88.15] (unknown [9.61.88.15])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Nov 2025 10:40:52 +0000 (GMT)
Message-ID: <13eb8452-7629-4555-9380-8ba93b2241ab@linux.ibm.com>
Date: Fri, 21 Nov 2025 16:10:51 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] blk-rq-qos: fix possible debugfs_mutex deadlock
To: Yu Kuai <yukuai@fnnas.com>
References: <20251121062829.1433332-1-yukuai@fnnas.com>
 <20251121062829.1433332-3-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251121062829.1433332-3-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FrEBGbp_f674rLd5wEA0K27n6T_vqXzl
X-Authority-Analysis: v=2.4 cv=YqwChoYX c=1 sm=1 tr=0 ts=692041b9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=hH7Ni0ian1lt9pKBA_wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FrEBGbp_f674rLd5wEA0K27n6T_vqXzl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX4PvyTnC2PPOQ
 yEDtC8XUwO0w9WY+fw4ZU0KzBtn0D5hAzEx2FWPN+g9NFoeec+jZ9h/YXmfQKyOyef8pZPA2BrH
 WdnlCPkYF+BnotxewEsakuBBqOlTf4etMb0C9aHwtDfib9HFlAP8AllGOBq9M/a4ovt5VUW4jXV
 7ltsy42B2cieuZ2ChuOCxL6lDXGSLeqFcB7oZenQlZWeq8i57rTqAoO9EEfUfr08SC1SSHDstox
 U1lIvwq4Ki5m6TfyXn3kRwRLOVlcbPt30Pc5QTTIVdaJEKW2UVLsAqER35IUg45jhr8j1qHQGhl
 oboaURMTGh6UNiiK8lWH+4EGL14pF8xE5RWWgqFoN+ImjTvXTqS7JdaLbJbn400x07vMyRVMXal
 Z9uj9K1Ml1RNYYGyJUiU5fAFLszFzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032



On 11/21/25 11:58 AM, Yu Kuai wrote:
> +void blkg_conf_exit(struct blkg_conf_ctx *ctx)
> +{
> +	__blkg_conf_exit(ctx);
> +	if (ctx->bdev) {
> +		struct request_queue *q = ctx->bdev->bd_queue;
> +
> +		mutex_lock(&q->debugfs_mutex);
> +		blk_mq_debugfs_register_rq_qos(q);
> +		mutex_unlock(&q->debugfs_mutex);
> +
>  		ctx->bdev = NULL;
>  	}
>  }

Why do we need to add debugfs register from blkg_conf_exit() here?
Does any caller using above API, really registers/adds q->rqos? I
see blk-iococst, blk-iolatency and wbt don't use this API.


> @@ -724,8 +724,12 @@ void wbt_enable_default(struct gendisk *disk)
>  	if (!blk_queue_registered(q))
>  		return;
>  
> -	if (queue_is_mq(q) && enable)
> +	if (queue_is_mq(q) && enable) {
>  		wbt_init(disk);
> +		mutex_lock(&q->debugfs_mutex);
> +		blk_mq_debugfs_register_rq_qos(q);
> +		mutex_unlock(&q->debugfs_mutex);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(wbt_enable_default);

I see we do have still one code path left in which the debugfs register 
could be invoked while queue remains freezed:

ioc_qos_write:
blkg_conf_open_bdev_frozen        => freezs the queue
  wbt_enable_default
    blk_mq_debugfs_register_rq_qos
      
Thanks,
--Nilay

