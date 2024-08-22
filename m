Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0670B149DFD;
	Thu, 22 Aug 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724323609; cv=none; b=nH9AZp73rrfO1KsDln5GzNPldbLqNKtcyr1rLgdZRYnCW2dR3cw3rXUMpOsZncotxCeXADbz/dlNrORuf25oqeQKznfNwfOzetS12f/PlSUfMrS+zPHSnRT5K4ekGkP28V4IaMPx+Q3/RFoufRwt7i7I0Exy1duMBEB8Qb4wizo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724323609; c=relaxed/simple;
	bh=3GdhEK3KthQRHzd1qGeTOLt099FG/J8g/4JutJARSzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lH1fqzeiPkbXMFiFd0EkljfYolN5mOcZwkbP9Bg9ZPuRDvPJZwr5PVHrYESVMcFnyH1icI7de2EWDV0elOmjbSWpQ3IeYOs7G3kmGI8KlezAAgX/fjn5CwG4hapfRVUWkTGSA1AZSZ9Tw6qta5BLNncwZVwE+J1wnQ6TfDJoRwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Kw+hgXoJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kw+hgXoJ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MAP4Te027868;
	Thu, 22 Aug 2024 10:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RnSs2fCnHqGNQUdVyPDQqtWajASwUgx/EBp+1AMY6DM=; b=Kw+hgXoJ/wZnA6LY
	tJm6tz+lBWWcNFM31OU3GuadHLNlSJFUdB5OBHtMfs9w4p5RcFd4UHPpiAw4LKrW
	OGaBkP5qcE4K62IIVB7lzDAHgXtC0/HEm1qUKcICrdNM3FbSvl+KHvUoYpATTg6G
	JTwqJD33MT6+YR0XW77voe2oYl6FaGy4TWtjfvLlxZe8ZcIztxIolsqIKpYyqdOl
	AjV+4d7BypypMF7uPI7RBpaXvAQigTDP6Ol0mU0lxhkAErcbEv3Kv72DzyaLTUFi
	T/OAVxSBSJhVSng3OeQ52sGCp5a8M+bpbUo+jm3qKXW5wrLvfukO0Urt8ICOMmQz
	6ru4nQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414v5cehb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 10:46:31 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47MAkUlF012375
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 10:46:30 GMT
Received: from [10.216.41.123] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 Aug
 2024 03:46:24 -0700
Message-ID: <688ead11-c1c0-48b2-b4d1-feeb1278c692@quicinc.com>
Date: Thu, 22 Aug 2024 16:16:20 +0530
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
Content-Language: en-US
From: MANISH PANDEY <quic_mapa@quicinc.com>
In-Reply-To: <12a6f001-813e-4bc4-90c2-9f9ef7dc72e6@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tD19fjYyjhLufL6dnsZvLsArdI74DqmX
X-Proofpoint-ORIG-GUID: tD19fjYyjhLufL6dnsZvLsArdI74DqmX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_03,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408220080



On 8/21/2024 10:52 PM, Bart Van Assche wrote:
> On 8/21/24 5:29 AM, MANISH PANDEY wrote:
>> How about introducing a new rq_affinity ( may be rq_affinity = 3) for 
>> using cpus_equal_capacity() using new flag QUEUE_FLAG_SAME_CAPACITY.
>>
>> if (cpu == rq->mq_ctx->cpu ||
>>      (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
>>        cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
>> +      (test_bit(QUEUE_FLAG_CPU_CAPACITY, &rq->q->queue_flags))
>>         && cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
>>          return false;
>>
>> Could you please consider raising similar change, if this seems fine 
>> for all.
> 
> I'm not sure that a change like the above would be acceptable.
> 
> What is the performance impact of the above change? Redirecting
> completion interrupts from a slow core to a fast core causes additional
> cache misses if the I/O was submitted from a slow core. Are there
> perhaps use cases for which the above change slows down I/O?
> 
> Thanks,
> 
> Bart.

Hi Bart,


 > What is the performance impact of the above change?
No impact at all, as we are not changing the logic, we are just 
proposing an on/off switch and give flexibility to users. Let the user 
choose what's the best for their system.

Intention behind proposing a new flag is like we shouldn't break the 
backward compatibility, as the change is also included in stable release 
branches.

	/* same CPU or cache domain and capacity?  Complete locally */
	if (cpu == rq->mq_ctx->cpu ||
	    (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
	     cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
+	     (test_bit(QUEUE_FLAG_CPU_CAPACITY, &rq->q->queue_flags) ||
	      cpus_equal_capacity(cpu, rq->mq_ctx->cpu))))
		return false;

So basically below would act as on/ off switch
QUEUE_FLAG_CPU_CAPACITY - with rq_affinity=1 , it will be clear
                         - with rq_affinity=3 , it will be set.


Regards
Mansih

