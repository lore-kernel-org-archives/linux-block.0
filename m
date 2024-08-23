Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA43B13B7AE;
	Fri, 23 Aug 2024 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724399911; cv=none; b=VPktP0MnhRzvkbXLgm9AsE9hUVLisgv5ICqQGqAURk91ir5EXMNKI0jI7fjO+8oL4bp1ce17pkyWiunAIpnaHtV5k7RXi4cZRq4GlAGFfCOeDXomWemGRpyH+bCNSA8qWG8GBiiRHVwVeu8rQJO80SViKw5u/0vKc9QiuKSCLYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724399911; c=relaxed/simple;
	bh=fK5ZmFBlWTJYgBYkbk/5dlfPfIlLqM3OIa6Bt9Fbtao=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eof+9KGuub5l4UlBYVZzPBDWGPyy9V0hXZ43jy9M7EL16MRa262K/bhQrih0zbTB2lg/iqoUnToGU/nZrYxjnsgmJnsnFyYUaP0phZUvrCkiQa4akob0Zj7HMkQ1YGN+8oo075wz0yunEMecv9jMLXtsvlQF9NaDaaC5mi7SCZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nx5yl7UL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nx5yl7UL"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N3uJaI019087;
	Fri, 23 Aug 2024 07:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9iyXjDITZDHZD41isJPa8xb6yhA5z746YMVADCKjcJg=; b=nx5yl7UL7O4Ch8LE
	U6Y9d6Ib+EngZoM2s0lEpWhEVM4xjkUiOhTcKV4oIECYVmt59RmN/86juO7KLJfk
	TWzpWenn6HNkPo/1FfeNGLE9IErrc3Jfiu6D3QrltkpfMkqCD38lusUEvCaeh1O+
	BgCE0elZvU/utwT/jmMAZL0mU3yuhXt5M0fvq+bieiM16v44DMuBUohgETiYTBuk
	88yZU1pITWaePveHaC+DIDgD2yFEvUZjzUgS5yQ9VByYPIoOgpZdpOg18S9ldS/Q
	KLkmG875fPgFwbUMVRI4xFJrqSG4mUUftvo6KKbt5lO1JkVrnSxsSCsJXOTGirC1
	0JqDVw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 415vsakwqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 07:58:05 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47N7w4oE022299
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 07:58:04 GMT
Received: from [10.216.54.20] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 23 Aug
 2024 00:57:57 -0700
Message-ID: <66912a22-540d-4b9a-bd06-cce55b9ad304@quicinc.com>
Date: Fri, 23 Aug 2024 13:27:54 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
To: Bart Van Assche <bvanassche@acm.org>,
        Sandeep Dhavale
	<dhavale@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Qais Yousef <qyousef@layalina.io>,
        Christian Loehle
	<christian.loehle@arm.com>, <axboe@kernel.dk>,
        <mingo@kernel.org>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <linux-block@vger.kernel.org>,
        <sudeep.holla@arm.com>, Jaegeuk Kim
	<jaegeuk@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, <kailash@google.com>,
        <tkjos@google.com>, <bvanassche@google.com>,
        <quic_nitirawa@quicinc.com>, <quic_cang@quicinc.com>,
        <quic_rampraka@quicinc.com>, <quic_narepall@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
 <25909f08-12a5-4625-839d-9e31df4c9c72@acm.org>
 <1d9c27b2-77c7-462f-bde9-1207f931ea9f@quicinc.com>
 <17bf99ad-d64d-40ef-864f-ce266d3024c7@acm.org>
 <e2c19f3a-13b0-4e88-ba44-7674f3a1ea87@quicinc.com>
 <c151b6d5-7e02-48ee-951f-c23594f6be6f@arm.com>
 <CAB=BE-RHwqmSRt-RbmuJ4j1bOFqv1DrYD9m-E1H99hYRnTiXLw@mail.gmail.com>
 <ca78ada8-d68b-4759-a068-ac8f66c51b72@quicinc.com>
 <12a6f001-813e-4bc4-90c2-9f9ef7dc72e6@acm.org>
 <688ead11-c1c0-48b2-b4d1-feeb1278c692@quicinc.com>
 <1a95a60c-730a-4bb7-80c9-98b8a70f6521@acm.org>
Content-Language: en-US
From: MANISH PANDEY <quic_mapa@quicinc.com>
In-Reply-To: <1a95a60c-730a-4bb7-80c9-98b8a70f6521@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iMXXL9bXgGOJnd8F8PmWVEkv9xnFTXkb
X-Proofpoint-ORIG-GUID: iMXXL9bXgGOJnd8F8PmWVEkv9xnFTXkb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_05,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408230056



On 8/22/2024 7:54 PM, Bart Van Assche wrote:
> On 8/22/24 3:46 AM, MANISH PANDEY wrote:
>> On 8/21/2024 10:52 PM, Bart Van Assche wrote:
>> > What is the performance impact of the above change?
>  >
>> No impact at all
> Is this a good summary of this email thread?
> * The first email in this thread reports an important performance
>    regression.
> * In your previous email there is a candidate fix for the performance
>    regression.
> * Above I read that the proposed fix has no performance impact at all
>    on any setup.
> 
> Is this a good summary of this email thread? If so, do you agree that
> this must be confusing everyone who is following this email thread?
> 
> Thanks,
> 
> Bart.

Hi Bart,

Performance impact due to addition of cpu capacity check 
(https://lore.kernel.org/all/20240223155749.2958009-3-qyousef@layalina.io/) 
...[1]
is already mentioned in the first email.

But let me summarize it again:

We are not able to get advantage of affining the IRQ in different 
capacity CPU(s)/clusters and complete the request in higher cluster 
cpu(s), even though the LLC is shared between these clusters as it is 
causing the block completion to happen on SOFTIRQ context, if requester 
and completion clusters are different.

Below is the performance impact with the current patch [1]

1. For MCQ capable UFS host (paired with UFS 4.x), we are observing ~20% 
random R/W performance drop.

2. For single doorbell ufs hosts (paired with UFS 2.x/ UFS 3.x), we are 
observing ~7-10% random R/W performance drop.


Also in previous emails on this thread, below were few suggestions to 
add check for equal or greater capacity cpus by @Christian Loehle
https://lore.kernel.org/all/3feb5226-7872-432b-9781-29903979d34a@arm.com/

 > From: Christian Loehle @ 2024-08-02  9:03 UTC (permalink / raw)
 > [......]
 > diff --git a/block/blk-mq.c b/block/blk-mq.c
 > index e3c3c0c21b55..a4a2500c4ef6 100644
 > --- a/block/blk-mq.c
 > +++ b/block/blk-mq.c
 > @@ -1164,7 +1164,7 @@ static inline bool
 > blk_mq_complete_need_ipi(struct request *rq)
 >        if (cpu == rq->mq_ctx->cpu ||
 >            (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
 >             cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
 > -            cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
 > +            arch_scale_cpu_capacity(cpu) >=
 >              arch_scale_cpu_capacity(rq->mq_ctx->cpu)))
 >                return false;
 >
 >       /* don't try to IPI to an offline CPU */


There can be SoCs with different CPU cluster configurations and to have 
optimal IO load balancing or to avoid contention b/w submission path and 
completion path, we may need to complete IO request of large capacity 
CPU(s) on small cluster cpus. So the above propose solution may not be 
suffice to all the use cases.

Hence with below proposed solution, we are trying to propose a new rq 
flag QUEUE_FLAG_CPU_CAPACITY. The proposed solution will provide us a 
way such that users who are benefited with CPU capacity check [1] would 
be able to use the fix as it is, and if a user (including us) want to 
bypass cpu capacity fix [1], they can set rq_affinity to 3 and would be 
able to retain performance drop as mentioned in first email. This would 
give flexibility to user to choose what's the best for their system.

if (cpu == rq->mq_ctx->cpu ||
	    (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
	     cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
+	     (test_bit(QUEUE_FLAG_CPU_CAPACITY, &rq->q->queue_flags) ||
	      cpus_equal_capacity(cpu, rq->mq_ctx->cpu))))
		return false;


Regards
Manish


