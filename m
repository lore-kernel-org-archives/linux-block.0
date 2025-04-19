Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC294A47
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745070945; cv=none; b=czqCH8aml0XJrBkehOoSfpyaw0DlLAoMtSz3Zff6x07uYcahlSQJ5ukDTE4VS/QZd/tASaSm7GkBxyqe5G+i+/Nt2OeXtYYcEWVPCvdRzhal51toWkJZCOdRgLZc4yqHB4sruL2/cLsLBDZaReTrNAAo/NutrO8FuWC/ro76hwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745070945; c=relaxed/simple;
	bh=WjSC+CS5OjpteQff/aBDzLQyZfL5NdZtef08XD1MdFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bITpxINVVEzXtJofce2zDb/GT2ui+e45EUsGG1IzI9BS8cp8UdYLFa+ICvGmPnD49SxNj5x/0TxhN1i6qVd+PXoeGhDnlnB9s/qgaL2BwPqCUoU8l2c/WMQADYnsKGXnl7/+CNc7ho+TG4vubmkQzBlHSxarMtrWiH2puKfdIps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VFxN7Td1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VFxN7Td1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53J4TVae017998;
	Sat, 19 Apr 2025 13:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=k5cwzJ
	bJO3VWmJ570P5ueTAemwnugq0yGNlXJCPyA88=; b=VFxN7Td15HHQPKEc7kM4RD
	/R/ezm5zScWI3Jjk0hJdWhMDdOxl1exOTByYLlJQLVyfzoyz3V+nRWK4tvbQo0z3
	vIVTt6TF6+jJwcZUz/F93I/lVpTFrioosIJFYMtTROObIjVzjONN3oWhR9qwjRVh
	6CJkfFxPmz9U6+mHR5iZqpeYv7MPzftCWTO2ijy6nBVZwXYkwUzIQ111Zy2RiPi3
	qpFXwr2/x0M+VfExj872CdoMnssI3LfQQS6rLhHBknnnCHZ5basH8lUyz4pOZ+ih
	fB5CUMtOpy1KnNeJMyy4ChEGfhyboGSNFt0JJEfI/eYJuDY2p6F4aQSrpHrdxeFA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4643g09f4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 13:55:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53J8suNE031061;
	Sat, 19 Apr 2025 13:55:35 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gp7q77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 13:55:35 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53JDtZ8912714512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 13:55:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F2FF58058;
	Sat, 19 Apr 2025 13:55:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AD2558059;
	Sat, 19 Apr 2025 13:55:33 +0000 (GMT)
Received: from [9.111.34.38] (unknown [9.111.34.38])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Apr 2025 13:55:32 +0000 (GMT)
Message-ID: <9d15a519-c0bb-492f-9602-f3840b85dbe1@linux.ibm.com>
Date: Sat, 19 Apr 2025 19:25:31 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 16/20] block: move elv_register[unregister]_queue out
 of elevator_lock
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-17-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250418163708.442085-17-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rPRNCBdqx0NitKQV-x-6YgaYpgd1KjLQ
X-Proofpoint-GUID: rPRNCBdqx0NitKQV-x-6YgaYpgd1KjLQ
X-Authority-Analysis: v=2.4 cv=cPHgskeN c=1 sm=1 tr=0 ts=6803ab58 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=bUXBClHPQDoksmv-mlcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504190111



On 4/18/25 10:06 PM, Ming Lei wrote:
> Move elv_register[unregister]_queue out of ->elevator_lock & queue freezing,
> so we can kill many lockdep warnings.
> 
> elv_register[unregister]_queue() is serialized, and just dealing with sysfs/
> debugfs things, no need to be done with queue frozen.
> 
> With this change, elevator's ->exit() is called before calling
> elv_unregister_queue, then user may call into ->show()/store() of elevator's
> sysfs attributes, and we have covered this issue by adding `ELEVATOR_FLAG_DYNG`.
> 
> For blk-mq debugfs, hctx->sched_tags is always checked with ->elevator_lock by
> debugfs code, meantime hctx->sched_tags is updated with ->elevator_lock, so
> there isn't such issue.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c   |  9 ++++----
>  block/blk.h      |  1 +
>  block/elevator.c | 58 ++++++++++++++++++++++++++++++++++--------------
>  block/elevator.h |  5 +++++
>  4 files changed, 52 insertions(+), 21 deletions(-)
> 

[...]

> +static void elevator_exit(struct request_queue *q)
> +{
> +	__elevator_exit(q);
> +	kobject_put(&q->elevator->kobj);
>  }

[...]  
> +int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx)
> +{
> +	int ret = 0;
> +
> +	if (ctx->old) {
> +		elv_unregister_queue(q, ctx->old);
> +		kobject_put(&ctx->old->kobj);
> +	}
> +	if (ctx->new) {
> +		ret = elv_register_queue(q, ctx->new, ctx->uevent);
> +		if (ret) {
> +			unsigned memflags = blk_mq_freeze_queue(q);
> +
> +			mutex_lock(&q->elevator_lock);
> +			elevator_exit(q);
> +			mutex_unlock(&q->elevator_lock);
> +			blk_mq_unfreeze_queue(q, memflags);
> +		}
> +	}
> +	return 0;
> +}
> +
It seems that we're still leaking ->elevator_lock in sysfs/kernfs with
the above elevator_exit call. I think we probably want to move out 
kobject_put(&q->elevator->kobj) from elevator_exit and invoke it 
after we release ->elevator_lock in elevator_change_done.

Thanks,
--Nilay
