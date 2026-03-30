Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F53B4E95
	for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774866565; cv=none; b=RSS/zCs6SA/CCzYJKIGzkuM7r17hb2Thq/8/VOX1mZtsBneCNRgNFtHyhSxI05H7tvjv6nm+De1P2pXQbJM6GsVqBJnP+P7cf8tLT9uoidwcSTif0IK6ADZ0bkVtZ4Qxb6hyvPrAfk5cWoz8hMgIw6ctm1jbrhyXPsFIIqnlxt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774866565; c=relaxed/simple;
	bh=27DAYMsHiRQ2JXYdySFB2ZLgIzc5ho+XCQIZYVHeUQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/n+W8vHb+lfrPuI/8NnWyU42fYsbg1CeFnK7Zy7TOjyL9q57kVOiJC1/df1minkuVHXMuO4VAb41JoyOJDabbjmpShgCN2M0jw4nCnDsXViUFkD4ewi495P01URlMjdeGkYNtJEkS/Zd1rwHkJBl7GIYJwoeBqFlrz+ZIQGck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=exUIAZwA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="exUIAZwA"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TMSeYp523647;
	Mon, 30 Mar 2026 10:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lmFm0m
	WZcQ9fLesy2hkNR7RPQmBNWWBxil232QQpgnc=; b=exUIAZwA+AE6dgPAMCHjYQ
	bKS26ocLUtTnq+KvjBZW3DfMIfB2nhzKD4bm/eEaXcNq5D82O3f6POGL0Xo8hSZn
	vcg/XvWYg0LDK+k0hdAKiQcxnNHEnSSOVWAbQ6nb0AIGRwp4XBR98hyN5z7F6iGw
	l8tbPKfwf34wC8aMAPMGNWR7rlA1PG6g/+8URziCYcPPQAKfog6ObRXGcHbbxahC
	moA6NF8/MsTzer58wUbH05u66v+FBcqJk6CvygnYYqg9gJohWEUBAmXxEjRL0Llp
	UpobyLKt0tde9vqQdGbY3Bco5F3WGTkMnI8C1QMlXJjguwkyycXm0Fnfindpm10g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g1pbae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 10:23:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62U5rZAQ013919;
	Mon, 30 Mar 2026 10:23:36 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkcb67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 10:23:36 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62UANZ0657344460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 10:23:35 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52C5C5805A;
	Mon, 30 Mar 2026 10:23:35 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E92E358056;
	Mon, 30 Mar 2026 10:23:31 +0000 (GMT)
Received: from [9.123.2.203] (unknown [9.123.2.203])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 10:23:31 +0000 (GMT)
Message-ID: <b9cbbd2b-4c2a-497a-84f8-f1bda0e7c40f@linux.ibm.com>
Date: Mon, 30 Mar 2026 15:53:30 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/26] null_blk: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Kees Cook
 <kees@kernel.org>, Genjian Zhang <zhanggenjian@kylinos.cn>
References: <20260325214518.2854494-1-bvanassche@acm.org>
 <20260325214518.2854494-21-bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260325214518.2854494-21-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69ca4f29 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=N54-gffFAAAA:8
 a=3x_4u_fpsufModc6hdkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HvKnIXfIcU2C3V_C9bbHSVcvOsvPxm7g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4MSBTYWx0ZWRfX03z7Qf+C/SwR
 fdquvR8wSNMoJa/w4tuCYCOggdPm6dBP2tcDq+78/vhsofCRnonfsDL884sFI+VBS1ExSHTxrpW
 LDesBzw+gxFsm1hF9SdyG2WQtKZgWRra2HXw36kO/SZlS5luVSqcv79ZJGolNTK1+p4BIAcGY9d
 ovl+iv0aOIg7f+UWLFDvYmVvCb4WdFFBrf1cs21mJ8ktDeBXoMX6MHHp85G1eAR7LikgoxGDKsz
 tfx/CSsC+p7iSkq6VN8HjsYb/zw1SE/H7hZEprI4YnC0Fy+Y44uN8AGXCHqQGoCYZq5lPnX3zrm
 LBZznG04gGnwQguy15yR7P1LbMrdGnv5hjOJ3+SEBNXJrp9adSdXzi91L+7j76crxSXmm7P90QA
 iLP+PjM3W/4c1S08eAMEjwwpqpNVW0Vh9WVxvEXSqVD5EVuBYYeCOTnPeHAcq0MVI63LgkpWLRc
 URCZ0gmDSTmxwpHobjA==
X-Proofpoint-GUID: HvKnIXfIcU2C3V_C9bbHSVcvOsvPxm7g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300081

On 3/26/26 3:15 AM, Bart Van Assche wrote:
> Convert __releases() __acquires() into __must_hold(). Add __must_hold()
> annotations where these are missing. Annotate two functions that use
> conditional locking with __no_context_analysis. Enable lock context
> analysis in the Makefile.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/block/null_blk/Makefile | 2 ++
>   drivers/block/null_blk/main.c   | 7 +++++--
>   drivers/block/null_blk/zoned.c  | 2 ++
>   3 files changed, 9 insertions(+), 2 deletions(-)
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
> index f8c0fd57e041..677ac829ef80 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1004,8 +1004,7 @@ static struct nullb_page *null_lookup_page(struct nullb *nullb,
>   
>   static struct nullb_page *null_insert_page(struct nullb *nullb,
>   					   sector_t sector, bool ignore_cache)
> -	__releases(&nullb->lock)
> -	__acquires(&nullb->lock)
> +	__must_hold(&nullb->lock)

This function temporarily drops the &nullb->lock and requires it.
So why do we need to replace __releases/__acquires with __must_hold?
This is not clear.

[...]

> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index 384bdce6a9b7..a7f94e76034f 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -32,6 +32,7 @@ static inline void null_init_zone_lock(struct nullb_device *dev,
>   
>   static inline void null_lock_zone(struct nullb_device *dev,
>   				  struct nullb_zone *zone)
> +	__no_context_analysis /* conditional locking */

I see we already have __context_unsafe(comment) macro defined
which may be used instead for inline comment.

Thanks,
--Nilay

