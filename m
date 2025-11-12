Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A91F2C1580
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952725; cv=none; b=R/7EYrpRooH/mufvkL2ijd/emophN2iIzx/Xg21aYXOMELy5nX92WWOLOGqGsUeF310d7ukOh6990MlXSJamzS+gwKmvx8+d5ewn+K6f0UhB0NZEK74LmuM8Hx1VEV6lVO+TexuSX7+Ut2ZfGbBm+J6m2mwAqEGDQ7Dka6pbuxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952725; c=relaxed/simple;
	bh=JZHRWJ0VXR7589q4YvpdkIKz3+SIFx/pa/SBbMDVTlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJRvOf1uNh8VWfja4yItW3CzkE6RUgaaycY2ui8htQ59Oc74fb4AfELOIeh07/oh4+dM3SjYhH6ydzYKtc8kPR8CquerZz/CbJK8i0SY0+YeC1HrhUx0gbpgBbdm6MCykHhUTCWQ9JqWGPlteKj76Ide11F9grGEP1jraTFwgfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WAqEaF6O; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WAqEaF6O"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC8GGFs018831;
	Wed, 12 Nov 2025 13:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WK6jGg
	FyTbO6HWDcEwyojgPTfdSb8Aeb1Xlp6pO2nhg=; b=WAqEaF6OL+P1e7lfQmBc0y
	Acjokk54LGaUIkluewisMA4NLfm9eJbMRjFCJPCO4vgbLe6RBF4oLG9h0zXJtb9r
	LCpxySTEGUf0UuSgRdQwRQsmGaQNkhjecdxtiLZUOaBisFNO6LGWWRLXSzm4zJ1u
	UjFlZ60EDSLfb9jrZrHw6IRIwdxT4F0EMHK5Un7Okcr+dfGGxsTNHleb8KYYyoB0
	aXPQnoHw+KUT5YJfjExpiWC9sHgUHsxgerDgRDRVvoSk+ibw+LuCxuOxlr7iPsq5
	lVBSkG1WthFbSeoQokVt6un3Ump+RnSXEUlXcSoVdMmdtBQgqPgDUF0mEzgoMUEA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m88e9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 13:05:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC9ghCQ014841;
	Wed, 12 Nov 2025 13:05:08 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpk88x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 13:05:08 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACD57V532113304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 13:05:07 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A545B58050;
	Wed, 12 Nov 2025 13:05:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AB4258045;
	Wed, 12 Nov 2025 13:05:03 +0000 (GMT)
Received: from [9.43.41.49] (unknown [9.43.41.49])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 13:05:02 +0000 (GMT)
Message-ID: <5dd4d03e-d988-4dfe-8c6d-d7ee18d321a4@linux.ibm.com>
Date: Wed, 12 Nov 2025 18:35:00 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 3/5] block: introduce alloc_sched_data and
 free_sched_data elevator methods
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
        yi.zhang@redhat.com, czhong@redhat.com, yukuai@fnnas.com,
        gjoyce@ibm.com
References: <20251112052848.1433256-1-nilay@linux.ibm.com>
 <20251112052848.1433256-4-nilay@linux.ibm.com> <aRRiwBMmLzkD6bag@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aRRiwBMmLzkD6bag@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=69148604 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=91t--V6Uq9am7j5nezsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: XptJL04Um1HsSaV_oube8ysSExq_o8lq
X-Proofpoint-ORIG-GUID: XptJL04Um1HsSaV_oube8ysSExq_o8lq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfX4xP9ALsDSqlE
 sIKSAn9ztX3ihzhqsg3bpj0aYn0JhCfmpDUzrFZval4rXwas66Mw7kuigA02BxNO7PRZppN33OK
 WXjTQtTipLFJS2eoTWmL88hz9yidiKqRW66ns+xc00+PDmdchtMqrwFLNoYwQ4f6WPelvmIpcKS
 oyRFghdm9PJ6xVIhGtgFz2W1StdxYp20fulP4luUha6zdyNbIt6tcv3vIClySUP77QLz/P/NEe+
 R0ZLxQBYQUWtgu2jafTaZG+/plsmbHqwTw4lO1kQJin0TEkNYbEqID2IBVqoYsHL06+8S4L5aye
 w3O8iqejUQlK9OzWKWjOR/OFRf+Ky1i2pCm10It5ZBApo60UcUsb60FAlZ7RaBy64VcLYG2p3UW
 256rKlzcPMXfZH8ZKgE1Rhg6g7/LlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079



On 11/12/25 4:04 PM, Ming Lei wrote:
> On Wed, Nov 12, 2025 at 10:56:04AM +0530, Nilay Shroff wrote:
>> The recent lockdep splat [1] highlights a potential deadlock risk
>> involving ->elevator_lock and ->freeze_lock dependencies on -pcpu_alloc_
>> mutex. The trace shows that the issue occurs when the Kyber scheduler
>> allocates dynamic memory for its elevator data during initialization.
>>
>> To address this, introduce two new elevator operation callbacks:
>> ->alloc_sched_data and ->free_sched_data. The subsequent patch would
>> build upon these newly introduced methods to suppress lockdep splat[1].
>>
>> [1] https://lore.kernel.org/all/CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVyjO0=-D5+A@mail.gmail.com/
>>
>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>  block/blk-mq-sched.h | 15 +++++++++++++++
>>  block/elevator.h     |  2 ++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
>> index 1f8e58dd4b49..3ac64b66176a 100644
>> --- a/block/blk-mq-sched.h
>> +++ b/block/blk-mq-sched.h
>> @@ -39,6 +39,21 @@ void blk_mq_free_sched_res(struct elevator_resources *res,
>>  void blk_mq_free_sched_res_batch(struct xarray *et_table,
>>  		struct blk_mq_tag_set *set);
>>  
>> +static inline void *blk_mq_alloc_sched_data(struct request_queue *q,
>> +		struct elevator_type *e)
>> +{
>> +	if (e && e->ops.alloc_sched_data)
>> +		return e->ops.alloc_sched_data(q);
>> +
>> +	return 0;
> 
> s/0/NULL
> 
Thanks, but it seems replacing 0 with NULL doesn’t quite work here because that
would make the caller assume that allocation of the scheduler data has failed.
We need to handle two cases:
- If ->alloc_sched_data is defined, then return the value it provides.
- If ->alloc_sched_data is not defined, we should still treat it as a success
  case and return a sentinel pointer that the caller can interpret as “success,
  but no allocation required.”

I'll send out the above change. 

Thanks,
--Nilay
