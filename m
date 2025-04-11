Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0598A279353
	for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744399224; cv=none; b=V8fYGefFnE2am/kzAPI1P1fQzqyG6kXrAUyaSjVT94uvsl7+dXsntti27m9+hfgnSmxY4yteOdmB1P8Jaf6JhXpFiDDiH+YPeDgy6tdBSOibTGGTkhbv1uLbtKbSwJtMWEwAFbbUj8eib7bH7VwC0Y5/+dxFmH8dKbLK0Y/6SC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744399224; c=relaxed/simple;
	bh=BVugfkeJ+RbdocPfbsBYRTWkjfxTkrc7yaDc9axCdIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NlXvsK8C/50VDiqQjuPTVaIOVxw4VwQlKX1F/BH0yKPeKj+ihwJkHwT2BMIfDU5MK0CqZ+SyI32bJesFZMSYBuxzGvLf338Fdg3pBpuQMqZh+yWlucrXyCx7IJMjD6oE/UapzLs+Fbm49DD2UH3oEbOnNwUoJabPpXnbt/Wf20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tWgJh7N4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tWgJh7N4"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BII4mg022333;
	Fri, 11 Apr 2025 19:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YXpyT7
	UX0FILtKsPv5N8X7u7URn4ddDzLZgDmuF0Gjs=; b=tWgJh7N4ZjqxAqzQZIPHUV
	enoHpAtnOdO7bz7Edi3cStrEeiX/jArjsATNTGMleo9Gs3yGWjxjCsoHug2MEbFX
	onvpqIZHMLiDPlX2n+rH4h/u+ggPwreIFi3qEgRDKucGKuow9TWiUGd5fuO1FDzM
	weZXIfHBUsAjV1yfAgjC4UPjKzGc+6mkuXJnKZt3z78KiC4RCltpVxFNYpITWdmn
	28wNOIHMWdVKI6yaVEmlBRjSZUhJ+u5WMvdCQ8l4/Mxp1QaSAaj8YK63MxAeKylr
	4dbBipF7TiXt1crts1h3mgvP6U7yQbOAOkCNgoyHYOCPsE7PZEXg+pzaf5V4gfvg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45y343t3yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 19:20:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BHwWTZ011062;
	Fri, 11 Apr 2025 19:20:14 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf804nem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 19:20:14 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BJKD6h32113272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 19:20:13 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71DFB58056;
	Fri, 11 Apr 2025 19:20:13 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C35A58052;
	Fri, 11 Apr 2025 19:20:11 +0000 (GMT)
Received: from [9.171.63.249] (unknown [9.171.63.249])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 19:20:11 +0000 (GMT)
Message-ID: <43e99891-94f2-4b31-a073-f7e717afbdd7@linux.ibm.com>
Date: Sat, 12 Apr 2025 00:50:10 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] block: move elv_register[unregister]_queue out of
 elevator_lock
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-12-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250410133029.2487054-12-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W_vK6bbLmxQV_zU3LNd_2qV06-KrOSKf
X-Proofpoint-ORIG-GUID: W_vK6bbLmxQV_zU3LNd_2qV06-KrOSKf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=773
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110122



On 4/10/25 7:00 PM, Ming Lei wrote:
> +int elevator_change_done(struct request_queue *q, struct elev_change_ctx *ctx)
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
We could have sysf elevator attributes simultaneously accessed while this function 
adds/removes sysfs elevator attributes without any protection. In fact, the show/store
methods of elevator attributes runs with e->sysfs_lock held. So it seems moving 
the above function out of lock protection might cause crash or other side effects?

Thanks,
--Nilay


