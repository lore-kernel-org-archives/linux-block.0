Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A00D1A304A
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764177; cv=none; b=C3WQc8qaACLOPVwy2d4UW0ToBwvghaEpGSPqopgDgjKAYsjlcZSuQ2lnMmCvCy7FqiixQMGG+zrbwdgHQN3sEjQw2rNHpVCw2eh1KPOb41tWcC0ezUr3mEk1+8+xYZ/uYjLHA6MtX2IRTBIUobQyYMfItbW6OO9VNfpiIok5exM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764177; c=relaxed/simple;
	bh=ITAcpbsfd9Qhfq3ipDaYfGKvgc//8fR2CtCSNvUzx+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kspgb+LjtC4CkU0XsAtkCFJxTOE8s3fLwnzhZ7W06Mef7SKk3RFtidIvW7MlC4eEuiVKLBtSoll7Nw4USORDEEZ+gSCuJKinYF9teVyUDUZi6ou3e+MdYa39TEgTawyMIiIn9VlBEG1SicjWNjCFsdRLSzA46pDF/AGKswGOADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BY4wgSkU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BY4wgSkU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CHrcW1999346;
	Mon, 3 Aug 2026 13:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=L4LQoZ
	C2Fjf00+Np4u19YG8Dk9WBoTb96dKsDFjpOC4=; b=BY4wgSkUH6Fz2bdTqT9q22
	ljS1vTu+W+7xnmzqsQhb+gpjJVXLo9LYmgiVkDDnqxdrnVjSe6dr093+G4frOXDk
	Qv2yYIZhYRxMO9LOBDVm3qtJu6wKgaD5LczvPzFdPn/I3iS7w9Gt8eIXgezTbX76
	PPX6OJuM9J+A80htwOYUCAPyhlYV4Rn8AU6ES6d6oeq60Za6AsD3vqIRqfQL5uYL
	HVoS3xgQrG5DdNGA5uMw4JkDVesRUYg2pP3j6rweM1oNDJpT1cfJYHmjRl31uH6k
	8CgwTrRrAMCJpB093hDUBLUytilH8q72B81GS1C4G18jZAY2mPtpohHToYkNmYDw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3s1b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 13:36:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673DT6ZI002933;
	Mon, 3 Aug 2026 13:36:02 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg5c37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 13:36:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673Da1nY32899586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 13:36:01 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5E0958059;
	Mon,  3 Aug 2026 13:36:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5BBE58043;
	Mon,  3 Aug 2026 13:35:57 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 13:35:57 +0000 (GMT)
Message-ID: <42987b15-44e2-4a45-bbd8-b791bbb56b6c@linux.ibm.com>
Date: Mon, 3 Aug 2026 19:05:56 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] null_blk: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kees Cook <kees@kernel.org>
References: <cover.1785440858.git.bvanassche@acm.org>
 <55886b395224068987cec253192ae6257e61c960.1785440858.git.bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <55886b395224068987cec253192ae6257e61c960.1785440858.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a709943 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=N54-gffFAAAA:8
 a=tTwrCLm7-eW9NPs9uKkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GU5tx3ks88m7FBc0ryXEEe35p3t-Bbs8
X-Proofpoint-GUID: -fhJ5fx_yzAis5MEy-hwQ9S9-4bxM0n_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExOSBTYWx0ZWRfXxVqAslk4vgP4
 e16G00+6BAk+XCF3wkUn1RGLH0lWrdIQGSze9KlTMLvHfOehiFt8RTbVkdECH3KILl7UJJzE2DK
 U3T++QagBNKb+kwTnHQ0DvVMyaEgksE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExOSBTYWx0ZWRfX7hoUAdS2q8yA
 jkrVCDvWi3SZfp1NEel772Dz61Vx52tIWpsIhKWWcGFi6pzPMnGvmgDXShIJMosYwnuEKhd9tiw
 3zqlxJnSngx04bsF0OGi/4d02WlP32TCECrpuyvxDAjQ3asZS+Csk337xm1TWaJDnVogNB9OIMb
 iSH1s6NLePkTBGaEFcHyWMDMfd2cOnTrQADxmU/N511ZXeXOT+LNbZfg5tZkSpySaixDaDK/Mmq
 +b1Uy/nAihS5C/+FFgQ6Rf+gnT7/Px0t7b+NcRUaC9ydvXES0r6jAB1gS6LfmSBokTHKSD9k6RB
 aaHCd7pxeKHW3HX77SzOFBBuTTc7wU1EHLRN/CEx3pxi+slfpO7/fgMijjiAVlpWYrlnTqSPLtI
 DK28vgPh4SZag7MVDc/kicgBNeelmZ7UQHGd7Y/344OLuANLnTLHFrnthlD6IXbawFEjoUhzgOZ
 tCZx2JjHD5J42cC7Iuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030119

On 7/31/26 1:28 AM, Bart Van Assche wrote:
> Add __must_hold() annotations where these are missing. Because
> null_lock_zone() and null_unlock_zone() use conditional locking, instead
> of annotating these functions, introduce guard class null_zone. Replace
> null_lock_zone() and null_unlock_zone() calls with scoped_guard(null_zone,
> ...). Enable lock context analysis in the Makefile.
> 
> Signed-off-by: Bart Van Assche<bvanassche@acm.org>
> ---
>   drivers/block/null_blk/Makefile |   2 +
>   drivers/block/null_blk/main.c   |   4 ++
>   drivers/block/null_blk/zoned.c  | 120 ++++++++++++++------------------
>   3 files changed, 57 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/block/null_blk/Makefile b/drivers/block/null_blk/Makefile
> index 84c36e512ab8..282b0d51a477 100644
> --- a/drivers/block/null_blk/Makefile
> +++ b/drivers/block/null_blk/Makefile
> @@ -1,5 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
> +CONTEXT_ANALYSIS := y
> +
>   # needed for trace events
>   ccflags-y			+= -I$(src)
>   
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index f8c0fd57e041..baffc6c61178 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1038,6 +1038,7 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
>   }
>   
>   static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
> +	__must_hold(&nullb->lock)
>   {
>   	int i;
>   	unsigned int offset;
> @@ -1087,6 +1088,7 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
>   }
>   
>   static int null_make_cache_space(struct nullb *nullb, unsigned long n)
> +	__must_hold(&nullb->lock)
>   {
>   	int i, err, nr_pages;
>   	struct nullb_page *c_pages[FREE_BATCH];
> @@ -1141,6 +1143,7 @@ static int null_make_cache_space(struct nullb *nullb, unsigned long n)
>   
>   static blk_status_t copy_to_nullb(struct nullb *nullb, void *source,
>   				  loff_t pos, size_t n, bool is_fua)
> +	__must_hold(&nullb->lock)
>   {
>   	size_t temp, count = 0;
>   	struct nullb_page *t_page;
> @@ -1242,6 +1245,7 @@ static blk_status_t null_handle_flush(struct nullb *nullb)
>   static blk_status_t null_transfer(struct nullb *nullb, struct page *page,
>   	unsigned int len, unsigned int off, bool is_write, loff_t pos,
>   	bool is_fua)
> +	__must_hold(&nullb->lock)
>   {
>   	struct nullb_device *dev = nullb->dev;
>   	blk_status_t err = BLK_STS_OK;
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index 384bdce6a9b7..dbae748c90ba 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -30,23 +30,26 @@ static inline void null_init_zone_lock(struct nullb_device *dev,
>   		mutex_init(&zone->mutex);
>   }
>   
> -static inline void null_lock_zone(struct nullb_device *dev,
> -				  struct nullb_zone *zone)
> -{
> -	if (!dev->memory_backed)
> -		spin_lock_irq(&zone->spinlock);
> -	else
> -		mutex_lock(&zone->mutex);
> -}
> -
> -static inline void null_unlock_zone(struct nullb_device *dev,
> -				    struct nullb_zone *zone)
> -{
> -	if (!dev->memory_backed)
> -		spin_unlock_irq(&zone->spinlock);
> -	else
> -		mutex_unlock(&zone->mutex);
> -}
> +struct nullb_dev_and_zone {
> +	struct nullb_device *dev;
> +	struct nullb_zone *zone;
> +};
> +
> +DEFINE_CLASS(null_zone, struct nullb_dev_and_zone, ({
> +		     if (!_T.dev->memory_backed)
> +			     spin_unlock_irq(&_T.zone->spinlock);
> +		     else
> +			     mutex_unlock(&_T.zone->mutex);
> +	     }), ({
> +		     if (!dev->memory_backed)
> +			     spin_lock_irq(&zone->spinlock);
> +		     else
> +			     mutex_lock(&zone->mutex);
> +		     (struct nullb_dev_and_zone){ dev, zone };
> +	     }),
> +	     struct nullb_device *dev, struct nullb_zone *zone)
> +
> +DEFINE_CLASS_IS_UNCONDITIONAL(null_zone)

What do we gain by introducing a guard class here? Since both the constructor
and destructor are marked __context_unsafe, the lock context analysis still
won't reason about the conditional locking.

In the previous series, we annotated null_lock_zone() and null_unlock_zone()
with __context_unsafe, and from that perspective the semantics seem unchanged
by introducing the guard class.

I'm not opposed to using a guard class here, but it does make the code a bit
more complex to follow. Unless there is a specific benefit (beyond using
scoped_guard()), I think the previous approach was simpler.

Thanks,
--Nilay


