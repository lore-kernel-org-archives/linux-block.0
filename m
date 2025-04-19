Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35708F77
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745061751; cv=none; b=ZrBWHLc9tdJOwuxzUrJjNYRacKOQBtiGQgRqMupNbPQA8qddvFdNpYSe269FzLhN1WSzehhERHVNr263+EZP6lKNiQgXr5CwHehLp3EZOe6Bxc7E3J76nyi02QpmIOFzZp1wlbeIiplpur0lolDUWrf38x8kqhGXuaUGdrJHXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745061751; c=relaxed/simple;
	bh=liZ+6vz1ifNmiO42O8hD1GQNBxIKwive8lxYbYE3BZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNKNj49A+WqaItiUFKWR2lAQyEorwftAKhTq2iRAR7KiH5OVkkKv7BnQ/bWiQVBtu6bZ2twS6WS8yfY2+sA6zVHD54E4RZugkTW6AvTAesTU/5prCgDjBqo3G5DrkaSFgogjHZhidUZ+RNXSizMoj1xerWPCArG63oEPCwhaTFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pWMT730I; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pWMT730I"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53JA43tA024034;
	Sat, 19 Apr 2025 11:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XYV5Ua
	wQUuVknD7Z9Hc7m4OYLs0/EhSk8/xIX3WsRjk=; b=pWMT730IiD+SBJ/cg08mhP
	leuW0Uwvxr4yXdVVSUJjwfTyDf3MZnJtzZGrMOlG7mwrpY/HWZRisDv0mmMc4Vo6
	6C4aIEot1HBZq0i3zy+vl3h12NW27CIP2E0vUMDPTGMf1f8fL83bYIAIvCZ3FSqe
	iYCNZbR1ePnPBsu4UflqpL1CTxh+tRSNK7gNBbbwV/qYZDUEzRc3SQArRwlr+93G
	58Kq3qxKoACLncfktZGT2eaHIBED8bTak7GG1Np0CY0umcnMNrmoT7fBOYr4cPSh
	6Hi4jY+1xCQChRvUrqhcSeun1wWY8vdksp2wy4frV/wFhbaWPj6PNNBKX4e+EZNQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4649rj06x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 11:22:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53J8C9nt004991;
	Sat, 19 Apr 2025 11:22:21 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46483trh62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 11:22:21 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53JBMKEN24183110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 11:22:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B638A5805D;
	Sat, 19 Apr 2025 11:22:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B758D5805B;
	Sat, 19 Apr 2025 11:22:18 +0000 (GMT)
Received: from [9.111.34.38] (unknown [9.111.34.38])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Apr 2025 11:22:18 +0000 (GMT)
Message-ID: <a49df1c8-7bdd-40d7-bc37-6728bb6209aa@linux.ibm.com>
Date: Sat, 19 Apr 2025 16:52:17 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 08/20] block: don't allow to switch elevator if
 updating nr_hw_queues is in-progress
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-9-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250418163708.442085-9-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QzfR4bp6so7Hcn9qIMz5XlfcaTI9ytfB
X-Proofpoint-GUID: QzfR4bp6so7Hcn9qIMz5XlfcaTI9ytfB
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=6803876e cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8 a=20KFwNOVAAAA:8 a=aubXXAuMy8ZKoot8LGgA:9
 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504190090



On 4/18/25 10:06 PM, Ming Lei wrote:
> Elevator switch code is another `nr_hw_queue` reader in non-fast-IO code
> path, so it can't be done if updating `nr_hw_queues` is in-progress.
> 
> Take same approach with not allowing add/del disk when updating
> nr_hw_queues is in-progress, by holding srcu lock & check
> set->updating_nr_hwq.
> 
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/mz4t4tlwiqjijw3zvqnjb7ovvvaegkqganegmmlc567tt5xj67@xal5ro544cnc/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/elevator.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index d25b9cc6c509..c23912652f96 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -720,9 +720,10 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>  {
>  	char elevator_name[ELV_NAME_MAX];
>  	char *name;
> -	int ret;
> +	int ret, idx;
>  	unsigned int memflags;
>  	struct request_queue *q = disk->queue;
> +	struct blk_mq_tag_set *set = q->tag_set;
>  
>  	/*
>  	 * If the attribute needs to load a module, do it before freezing the
> @@ -734,6 +735,12 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>  
>  	elv_iosched_load_module(name);
>  
> +	idx = srcu_read_lock(&set->update_nr_hwq_srcu);
> +	if (set->updating_nr_hwq) {
> +		ret = -EBUSY;
> +		goto exit;
> +	}
> +
>  	memflags = blk_mq_freeze_queue(q);
>  	mutex_lock(&q->elevator_lock);
>  	ret = elevator_change(q, name);
> @@ -741,6 +748,8 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>  		ret = count;
>  	mutex_unlock(&q->elevator_lock);
>  	blk_mq_unfreeze_queue(q, memflags);
> +exit:
> +	srcu_read_unlock(&set->update_nr_hwq_srcu, idx);
>  	return ret;
>  }
>  

I have same comment here as well as I mentioned in the previous patch.
(i.e. about using reader-writer lock instead of srcu).

Thanks,
--Nilay


