Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9359E2DF3CF
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750436044; cv=none; b=gZMT2xi1hTE9XkksOplxhnA/RfRC0Rb9AbJClpcW7vrTRGwzLyjFC3er4WYaGNk6SO8M+EvcRYUvxkHDJdt45h+QE+DFabsonmo51JDduNFgxcr7sSCfNRS4kgKJhn9EeVPsa3rjZsOZNL4QuA0/rNLpn8+Kfz5miOKFDs/Jsv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750436044; c=relaxed/simple;
	bh=dNRwtGARTf80nzNBfRtwY3LqFc3CxiBpqxpJRoJKpXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=leJwmnEox5BuCU18NiiwEVc4eff7FZ1lHegvT5a1no3gTEdh4my5wudYYkTMMHgARdfxMVKr9O/akrvfK8lS8T+E/vlZ9EUxrixXcTPBk2WaYL1g9XQkRB5DJLNoGrOWvjiFFKIlrxEcDRYBgjhufkX9uWJea6ySMK3V4mbL9AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=annjDTwp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="annjDTwp"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K8RIwv028388;
	Fri, 20 Jun 2025 16:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zRCBxf
	zzW8xHQkhcF4kWDF7KtK+7r3cHGnV2XyufIw4=; b=annjDTwpz6VijWjFpRqEB5
	NnoG6rtXQLNu95Jc28lpgTPEOY4bWF9BMdEe+6AIImT2KasqKBwNRaIDTKloBwEf
	gZOT/eanGjo1qWoco9U8xLAF1HU4kXLLeFjlYCpVL/BjA3zZ6wdFwWdMma7R53gI
	w35P0MP63gw4291HttgLwS/mXQ4JCeDDf3ZzNzOBXYi8WrX1loWNoEQbUvXiKb8W
	aUKzm3glsdUTurLybcanYQKtYKM6LOUn6/+Z/Ei2rEP8dq0XeZ+8z9Eu57eIUGnZ
	hUbIOiJRxUVb6a/1d1sly5f9QOAwN6P3zGrx1oooDa1C/M6N+rLyYc52l797ny7g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r2ky5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 16:13:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55KDLOWx027480;
	Fri, 20 Jun 2025 16:13:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479kt0c4bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 16:13:56 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55KGDtkf57147852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 16:13:55 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24F4F5803F;
	Fri, 20 Jun 2025 16:13:55 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D22245804E;
	Fri, 20 Jun 2025 16:13:52 +0000 (GMT)
Received: from [9.61.191.218] (unknown [9.61.191.218])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Jun 2025 16:13:52 +0000 (GMT)
Message-ID: <cc62b691-b034-419e-ac24-6c90061d8572@linux.ibm.com>
Date: Fri, 20 Jun 2025 21:43:51 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/2] block: move elevator queue allocation logic into
 blk_mq_init_sched
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
        sth@linux.ibm.com, gjoyce@ibm.com
References: <20250616173233.3803824-1-nilay@linux.ibm.com>
 <20250616173233.3803824-2-nilay@linux.ibm.com> <aFGEzN5c0-b5VdcM@fedora>
 <a1644c15-2a9a-4fc1-a762-b153d167cd1f@linux.ibm.com>
 <aFV7iSUpCdgqX1Sh@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aFV7iSUpCdgqX1Sh@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EIdjmm6vzIdgKtQprs5Ek8sH9ZP3xRcj
X-Proofpoint-ORIG-GUID: EIdjmm6vzIdgKtQprs5Ek8sH9ZP3xRcj
X-Authority-Analysis: v=2.4 cv=AqTu3P9P c=1 sm=1 tr=0 ts=685588c5 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=wZl93I-Y6oexVpGIjmQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDExMiBTYWx0ZWRfX70Q+svpfa5kK VT+hFCZz0Z/XbQPsjwbmujrEcGTpVV/7V/g9XLUhOJlU3GP+I7C80UJAGkEP+5JOmd+SQ2zC3vV ZnTeXh2w7LCzqg9RxQzozq0Jj+vHpwinuxu6wL87is85j0GQb02EsDrD88GRwX9d2dOsuU/ajVs
 hzaFSTsNj/LHDX8J2Q2rQGyUe6mLQrbqwSIKp/IKUm6l+XJ1ggBT57C0CigZ0Oc2D4az6dGENO2 v753Ri0yYczmzITJJcrz3R/VmW91H3EQ2UBpB0biFNXnq96NZZDF72FmIdES2tqRWXyFfVXcGc4 WqFtHa8fJr6Fktv5/2pQR/hkjHQtzf/EsR1A8MNZ9dVAZ7GgVHsIGYzMTMvn9+zBd03fo+FJTJX
 sObJRQ/xDsCBBiFZLj/AAh3mP3F3T5aV4284O/yrZ/aVQnKQVvVTsW1nfF+iU05r42ApveGD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200112



On 6/20/25 8:47 PM, Ming Lei wrote:
> On Fri, Jun 20, 2025 at 08:09:01PM +0530, Nilay Shroff wrote:
>>
>>
>> On 6/17/25 8:37 PM, Ming Lei wrote:
>>> On Mon, Jun 16, 2025 at 11:02:25PM +0530, Nilay Shroff wrote:
>>>> In preparation for allocating sched_tags before freezing the request
>>>> queue and acquiring ->elevator_lock, move the elevator queue allocation
>>>> logic from the elevator ops ->init_sched callback into blk_mq_init_sched.
>>>>
>>>> This refactoring provides a centralized location for elevator queue
>>>> initialization, which makes it easier to store pre-allocated sched_tags
>>>> in the struct elevator_queue during later changes.
>>>>
>>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>>> ---
>>
>> [...]
>>
>>>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>>>> index 55a0fd105147..d914eb9d61a6 100644
>>>> --- a/block/blk-mq-sched.c
>>>> +++ b/block/blk-mq-sched.c
>>>> @@ -475,6 +475,10 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
>>>>  	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
>>>>  				   BLKDEV_DEFAULT_RQ);
>>>>  
>>>> +	eq = elevator_alloc(q, e);
>>>> +	if (!eq)
>>>> +		return -ENOMEM;
>>>> +
>>>>  	if (blk_mq_is_shared_tags(flags)) {
>>>>  		ret = blk_mq_init_sched_shared_tags(q);
>>>>  		if (ret)
>>>
>>> The above failure needs to be handled by kobject_put(&eq->kobj).
>>
>> I think here the elevator_alloc() failure occurs before we initialize 
>> eq->kobj. So we don't need to handle it with kobject_put(&eq->kobj)
>> and instead simply returning -ENOMEM should be sufficient. Agree?
> 
> I meant the failure from blk_mq_init_sched_shared_tags(), which has to
> call kobject_put() for correct cleanup.
> 
Oh I see... yes we need to call kobject_put() here. 
Will do it in the next series.

Thanks,
--Nilay

