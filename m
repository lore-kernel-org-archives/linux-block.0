Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA51850A4
	for <linux-block@vger.kernel.org>; Thu,  8 Aug 2024 06:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723097545; cv=none; b=rqzgxdgTGopLyJaeUXknFXDJPDdzO1LteCpIgnn6IvYv3xEGiUhBG7q0ud9qCz9UCk/0PySDD3kV+Z+2SMm68iJUC6piDfz13FrSpnDeMxDFBTN69fY2RqwuIAtUwB4/XOPMuRPr/HcpWC3gV6mbIm+ANJjRDtfbvgaOFWRzU2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723097545; c=relaxed/simple;
	bh=hG4ElTXG+Ym2/4T+KvuSOCqFBC0VT2g0dY4NQQh1S04=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iFh3dwaCEMVydXkb8x1SENyztUL3n1fDFK1SvRyM75+zBfdtoyoPk3DIQ4I0iQEXFytWQBJ+2yVh9LMuh4g1QhrDZb11sZFna3h/gA37nlENuSRfTLfBq7uIcNsXGS7Ww+JSSYT/eem7fkBSjIOgldi6rrIqwwdbBm7RFzAK6do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B1gC//Cl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B1gC//Cl"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477K9O2q015709;
	Thu, 8 Aug 2024 06:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IhSTooxuXdyGvWy2XjTH/6q/gpIuArgp6FGXqefNjc0=; b=B1gC//ClbFSMvPT+
	Db1VVSSECb6lWql2M4U51n9wlj59vw5YFNA0y+O7fwLntDvEmRz0msRr17e4PKbz
	pJJu/mXkitYGHmaobBXi+bzHkic0z/B0JgliTv+JKSuJWJf3gXAfa41ell1XWz+q
	mkB6EeHRjFd8VXiVbJqCum/IncM0F9b/JAyPyQo0zf0P497p9uaAtmWEOp3RQ35m
	IJwtzlE8xfOcVcnx0mFmIYsr3w8SjPsMo4m6XcJWU1TEjY6Ue8PLGP3zXpUcwhGw
	auFl2pxIiWDaBtDR4yGcVYmejBqFgYcSWFBZ0a3+zn0ohfcfj6SMGsSqLIbgyuJP
	AFdjbw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sc4ycrcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 06:05:36 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 47865SMr004735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Aug 2024 06:05:28 GMT
Received: from [10.217.217.229] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 7 Aug 2024
 23:05:22 -0700
Message-ID: <e2c19f3a-13b0-4e88-ba44-7674f3a1ea87@quicinc.com>
Date: Thu, 8 Aug 2024 11:35:20 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
To: Bart Van Assche <bvanassche@acm.org>, Qais Yousef <qyousef@layalina.io>,
        Christian Loehle <christian.loehle@arm.com>
CC: <axboe@kernel.dk>, <mingo@kernel.org>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <linux-block@vger.kernel.org>, <sudeep.holla@arm.com>,
        Jaegeuk Kim
	<jaegeuk@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, <kailash@google.com>,
        <tkjos@google.com>, <dhavale@google.com>, <bvanassche@google.com>,
        <quic_nitirawa@quicinc.com>, <quic_cang@quicinc.com>,
        <quic_rampraka@quicinc.com>, <quic_narepall@quicinc.com>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
 <25909f08-12a5-4625-839d-9e31df4c9c72@acm.org>
 <1d9c27b2-77c7-462f-bde9-1207f931ea9f@quicinc.com>
 <17bf99ad-d64d-40ef-864f-ce266d3024c7@acm.org>
Content-Language: en-US
From: MANISH PANDEY <quic_mapa@quicinc.com>
In-Reply-To: <17bf99ad-d64d-40ef-864f-ce266d3024c7@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i-arfSxbmDjSJPINnP0sEVfFz0gdXOHk
X-Proofpoint-GUID: i-arfSxbmDjSJPINnP0sEVfFz0gdXOHk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_06,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408080043



On 8/5/2024 11:22 PM, Bart Van Assche wrote:
> On 8/5/24 10:35 AM, MANISH PANDEY wrote:
>> In our SoC's we manage Power and Perf balancing by dynamically 
>> changing the IRQs based on the load. Say if we have more load, we 
>> assign UFS IRQs on Large cluster CPUs and if we have less load, we 
>> affine the IRQs on Small cluster CPUs.
> 
> I don't think that this is compatible with the command completion code
> in the block layer core. The blk-mq code is based on the assumption that
> the association of a completion interrupt with a CPU core does not
> change. See also the blk_mq_map_queues() function and its callers.
> 
IRQ <-> CPU bonded before the start of the operation and it makes sure 
that completion interrupt CPU doesn't change.

> Is this mechanism even useful? If completion interrupts are always sent 
> to the CPU core that submitted the I/O, no interrupts will be sent to
> the large cluster if no code that submits I/O is running on that
> cluster. Sending e.g. all completion interrupts to the large cluster can
> be achieved by migrating all processes and threads to the large cluster.
> 
 >> migrating all completion interrupts to the large cluster can
 >> be achieved by migrating all processes and threads to the large
 >> cluster.

Agree, this can be achieved, but then for this all the process and 
threads have to be migrated to large cluster and this will have power 
impacts. Hence to balance power and perf, it is not preferred way for 
vendors.

>> This issue is more affecting UFS MCQ devices, which usages ESI/MSI 
>> IRQs and have distributed ESI IRQs for CQs.
>> Mostly we use Large cluster CPUs for binding IRQ and CQ and hence 
>> completing more completions on Large cluster which won't be from same 
>> capacity CPU as request may be from S/M clusters.
> 
> Please use an approach that is supported by the block layer. I don't
> think that dynamically changing the IRQ affinity is compatible with the
> block layer.

For UFS with MCQ, ESI IRQs are bounded at the time of initialization.
so basically i would like to use High Performance cluster CPUs to 
migrate few completions from Mid clusters and take the advantage of high 
capacity CPUs. The new change takes away this opportunity from driver.
So basically we should be able to use High Performance CPUs like below

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c3c0c21b55..a4a2500c4ef6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1164,7 +1164,7 @@ static inline bool blk_mq_complete_need_ipi(struct 
request *rq)
         if (cpu == rq->mq_ctx->cpu ||
             (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
              cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
-            cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
+            arch_scale_cpu_capacity(cpu) >= 	 
arch_scale_cpu_capacity(rq->mq_ctx->cpu)))
                 return false;

This way driver can use best possible CPUs for it's use case.
> 
> Thanks,
> 
> Bart.
> 
