Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243EC202960
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744311451; cv=none; b=T13zr6nIWxm65ES3eJ5VT9b+eXciJe47H0srb37JRtvLgRj1NSpp0gN/dGfeBv25zRQ2/vvhfufRvHHM/lqMu6Da9L1kcr6Z/ngSoeQSx02EzHvs18D7KlGVr2Cgf8QoCcuV75SZv8xbLneBQc4tt66uiPWkfvEVSBDxDudDV/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744311451; c=relaxed/simple;
	bh=/T/SdLBTQyUre92K9B0cZl+uqLO/B2iOcdOJWsz6gTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8rGfmd3R4H0SNdVdmE0/8/WSfcZZfLPY2J6ksQKUgbE67pKvxq1Q37yjRu4hJS5x+hPtZI9BqTthTDZp3oYcG2pJ32Xty6Z4SSlEz8bmXfL77eK2HHynLM0XgVOxOB+G+TZ0tV12alldOKaPemeOGg2j5Q+NT9G/mL24PcyJ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C4FvQzsy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C4FvQzsy"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AEetXG003298;
	Thu, 10 Apr 2025 18:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xvR4XU
	waqPVDD6n2eHtf99unAkZa/wihcKKPNwOcCx4=; b=C4FvQzsyM4YqcyVsT8zq3p
	pGnUKECC+tggALo748oyjdqZq4IhngHSQ47ituBt9PjZPGNAhxGHiyonGjtGAEz8
	J+aKwoq2OLH6jsIJM1v0um11ghAeKhP9eSD1rx5hMVCQ5rUj59WAlDsRCTr6xu/w
	ZR0/7mwWhxW5gLGqxXOD95xkEdRewO2nVjwFtwNMnMU2hIOr2B1dnl72cnHM42gO
	yWt1muSIJTV8kRV2X6Pp8Fp3WXMLJ6TqEAP+ETufcmwLlwRwYNvxA63pEwlMaXK8
	fTI7LV3rBs3BQgscFsVRz9NLz29TjakmBHFkeKLAGJJa/2UOyBprocSfp+CC0ymg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x0406n7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 18:57:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53AG05LI011518;
	Thu, 10 Apr 2025 18:57:22 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf7yyngs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 18:57:22 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53AIvLWA29426402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 18:57:21 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 695775805A;
	Thu, 10 Apr 2025 18:57:21 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A0735805F;
	Thu, 10 Apr 2025 18:57:19 +0000 (GMT)
Received: from [9.171.89.192] (unknown [9.171.89.192])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Apr 2025 18:57:18 +0000 (GMT)
Message-ID: <b28d98a6-b406-45b0-a5db-11bc600be75f@linux.ibm.com>
Date: Fri, 11 Apr 2025 00:27:17 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] block: move debugfs/sysfs register out of freezing
 queue
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-13-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250410133029.2487054-13-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hQnU3JbmpRlEAp14Lqg96EjSrzLH5dY6
X-Proofpoint-GUID: hQnU3JbmpRlEAp14Lqg96EjSrzLH5dY6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100137



On 4/10/25 7:00 PM, Ming Lei wrote:
> Move debugfs/sysfs register out of freezing queue in
> __blk_mq_update_nr_hw_queues(), so that the following lockdep dependency
> can be killed:
> 
> 	#2 (&q->q_usage_counter(io)#16){++++}-{0:0}:
> 	#1 (fs_reclaim){+.+.}-{0:0}:
> 	#0 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}: //debugfs
> 
> And registering/un-registering debugfs/sysfs does not require queue to be
> frozen.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7219b01764da..0fb72a698d77 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4947,15 +4947,15 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  	if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
>  		return;
>  
> -	memflags = memalloc_noio_save();
> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
> -		blk_mq_freeze_queue_nomemsave(q);
> -
>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>  		blk_mq_debugfs_unregister_hctxs(q);
>  		blk_mq_sysfs_unregister_hctxs(q);
>  	}
As we removed hctx sysfs protection while un-registering it, this might
cause crash or other side-effect if simultaneously these sysfs attributes
are accessed. The read access of these attributes are still protected 
using ->elevator_lock. 

Thanks,
--Nilay

