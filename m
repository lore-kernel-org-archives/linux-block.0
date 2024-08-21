Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9639D1531D2;
	Wed, 21 Aug 2024 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243389; cv=none; b=LKnD9g+OUkRSr+/Angr4qtP39JtMAz1fyPrY6+jDiIDHiJC8TyMr12bVUwINP/z22kdDoBDl3SA+ElM62jGVQ/BNBJqijybJDEulr/D54KsF8gqzmksRbmS8plPawlH17dEgnLytfyht0cxg74diwLi//TTX5j8+zWsH7IDFqQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243389; c=relaxed/simple;
	bh=D/AGG2kt2yzqivGXnvaNJ9VicDMyuX0Bw8P0G94eFKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BAPCpNLJ0WOXChK7l3MzZB7m9DlcpF94NstODW7NQDhoqG4IM/FAdroAHn5fajcfuO49FbspQaWSfmpIeHdkZLgggD7Kf2Jf9ypXRms5AU6QV31h5ppqpiiF0N5056ru3xkgRoGLGXpzRJEVNl6thg6QtJAV+P59qKCbn/N9XBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mx5CF9uK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mx5CF9uK"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LCGTTg028888;
	Wed, 21 Aug 2024 12:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GPaDfzzQ3JVIUlNdkkkRjL2d47hz3wFDbfKsX7Pz7KM=; b=mx5CF9uKURPTjVwA
	hVJQIcpQ9e8fHmz9vd1Z1DeqypQvi6qY0Wp/gAHJwyI+RositSZP8LhyaIXhf3s+
	22X+SU4Ha9dxcWha7/7PNKQzeQn0K4KCBXcoK6vBdjUilgxBhWqcqJtnCEU1DLqg
	x0JIWNj+5nFFmrOserfA6s7q+UbzjlNWvxP0xxE76kApyZkV9yWrQ/soUasWTluY
	vIwOyY4wLxj+J4OgpF2f2SRN6Wae1KH9aKvtUqc1ZMvDw+iVBaWDXioBK6Yjmjr2
	l+yZfF9gaR5y52T8ZD0akCBH1ql55T0iMO9Q0+Gbe9p22LsXC71XGMgBdM04X108
	TcKS0g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4159yj9m3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 12:29:18 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47LCTHco013057
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 12:29:17 GMT
Received: from [10.216.57.153] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 Aug
 2024 05:29:10 -0700
Message-ID: <ca78ada8-d68b-4759-a068-ac8f66c51b72@quicinc.com>
Date: Wed, 21 Aug 2024 17:59:06 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
To: Sandeep Dhavale <dhavale@google.com>,
        Dietmar Eggemann
	<dietmar.eggemann@arm.com>
CC: Bart Van Assche <bvanassche@acm.org>, Qais Yousef <qyousef@layalina.io>,
        Christian Loehle <christian.loehle@arm.com>, <axboe@kernel.dk>,
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
Content-Language: en-US
From: MANISH PANDEY <quic_mapa@quicinc.com>
In-Reply-To: <CAB=BE-RHwqmSRt-RbmuJ4j1bOFqv1DrYD9m-E1H99hYRnTiXLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: a-iliqz0atMkAHetXJiV3AQZhsufcLec
X-Proofpoint-GUID: a-iliqz0atMkAHetXJiV3AQZhsufcLec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408210091

Hi all,

We agree with the points like rq_affinity can vary from target to target.

But also please consider below use cases

1. Storage devices with single hardware queue (like UFS 2.x/ 3.x)
in a HMP system with shared LLC, not all the CPUs will be active and 
online. Hence for large amount (say ~1GB) of random IO transactions , if 
requester CPU is from
smaller cpu group, then due to capacity based grouping, Large cluster 
CPUs would be mostly unused /idle, as the completion would also happen 
on same capacity CPU. Again due to this, the smaller / mid capacity CPUs 
only would have to submit and complete the request. Actually we could 
have completed the requested on large capacity CPUs and could have 
better utilized the power of Large capacity CPUs.

But to move IO requests from S/M cluster CPUs to L cluster, scheduler 
would need to wait until a threshold IO hits, and by that time 
Performance application would spent some runtime and would report low 
performance as overall results.


On 08/02/24 10:03, Christian Loehle wrote:
 > So I'm assuming you're seeing something like the following:
 > Some CPU(s) (call them S) are submitting IO, hardirq triggers on
 > S.
 > Before the patch the completion softirq could run on a !S CPU,
 > now it runs on S. Am I then correct in assuming your workload
 > is CPU-bound on S? Would you share some details about the
 > workload, too?
 >
 > What's the capacity of CPU(s) S then?


Yes.. for few SoCs we follow the same.
Say an SoC with 3 clusters ( S/M/L), if M CPU(s) are submitting IO 
requests ( which is a large data transfer), then in this case since LLC 
is shared, we can allow L CPU(s) to complete the request via softirq / 
hardirq. This will make sure to avoid contention in submission and 
completion path.


Again consider an SoC with 2 clusters ( 4 cpus of small capacity  / 2 
CPUs of Mid capacity).
In such case, if M CPUs are used for IO submersion and completions, then 
these CPU would face heavy work load and hence Performance will be 
impacted.  Now if the new patch was not there, we could have moved few 
IO completions to S cluster CPUs.

 > If no matching is required, it makes sense to set rq_affinity to 0.

 > I don't get why irq_affinity=1 is compatible with this case? Isn't
 > this custom
 >setup is a fully managed system by you and means you want 
 >rq_affinity=0? What
 >do you lose if you move to rq_affinity=0?

actually rq_affinity=0 would help for few SoC's having MCQ like UFS 4.x, 
but even this won't be generic solution for us. As this won't considers 
an SoC which doesn't shares LLC, and thus would have significant 
performance issue. Also since the change is picked up in all the kernel 
branches, so it would be very difficult to experiment on older Socs and 
get the best solution for each target.

This won't work for many SoCs like above example of 2 clusters, as
rq_affinity to 0 would then complete the request on hardIRQ context, 
which may not be suited for all the SoCs.
Also not all SoCs are arm based and shares LLC.



2. Storage devices with MCQ (Like UFS 4.x / NVME), usages ESI/MSI 
interrupts, hence we would have opportunity to bind ESI IRQ associated 
with an CQ.


On 08/05/24 10:17, Bart Van Assche wrote:
 > On 8/4/24 7:07 PM, Qais Yousef wrote:
 > > irqbalancers usually move the interrupts, and I'm not sure we can
 > > make an assumption about the reason an interrupt is triggering on
 > > different capacity CPU.
 > User space software can't modify the affinity of managed interrupts.
 > From include/linux/irq.h:

 > > >True. But this is special case and was introduced for isolated
 > > > CPUs. I don't think drivers can request this themselves

There are drivers, which can manage the cpu affinty for IRQs
using irq_set_affinity_hint() based on the use case.
Since in the SoC's the LLC is shared ( M and L clusters). So if IO is 
submitted from M capacity CPU(s), and request is completed on L capacity 
cpu(s). Though the capacity of M and L is different, but since the LLC 
is shared, so completion can be done on L cluster without the need of 
IPI. With the new change, we may not get advantage of shared LLC.

Proposed solution:
We can have a solution which is backward compatible and a new control 
flag (QUEUE_FLAG_SAME_CAPACITY_FORCE) could be provided for this new 
change to maintain backward compatibly.

How about introducing a new rq_affinity ( may be rq_affinity = 3) for 
using cpus_equal_capacity() using new flag QUEUE_FLAG_SAME_CAPACITY.


if (cpu == rq->mq_ctx->cpu ||
	(!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
	  cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
+	  (test_bit(QUEUE_FLAG_CPU_CAPACITY, &rq->q->queue_flags))
	   && cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
		return false;



Could you please consider raising similar change, if this seems fine for 
all.


Regards
Manish
