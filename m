Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1893F293B42
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750430356; cv=none; b=lkaoMThjXKgk3pIAvEre58T58/VNYGrtjBQ5BIHtL5aMXvZM1bOeTUWRGdQIsUPEcEuQUbk/vf9cYUgP4kAA2Nh56zqJX0VkBKGAr5LUp0BliBkzhA95VPJX71BDT0AH4XJL3CVicNavLsEWENZJ/GvacDizkqFuu7uIWXP8N3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750430356; c=relaxed/simple;
	bh=H3kMZwujEA3C5/ERdd4iRZ4IVqhcNjpSajUNMLNdh10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QClTK02pNUFQVV4x7Qm3SelJKDsplisix22s627DCREYvUFg94HX+i1EM+R1IaAPCeaMguI82ulI49z6ctbS7SMmDz5R7uF97a4Fv/srzCTNl7tSZAbzNxuJhfbLPi1TeY2ET6HU7ZBwehVNySdjYT7oXhFPRTDxHA8xcnx6wpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WdG/NOX8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WdG/NOX8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KDmXIx004659;
	Fri, 20 Jun 2025 14:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MG+KGc
	mHfqWHodR9js8pcJ270N5h2zpOUteSbVa9T6g=; b=WdG/NOX8xgi/3CDt5Iab+z
	GOE5ETmXmojSvuHumSH7ykktLlatnVUdVMS8UTWJuYtYqCdvXq08zInLcESn9z13
	hL8BixsXvDOTglkA8LEVbxMMJ/soWX+RIJu7bY0gYFDLv8r7t1ZdLJyDpdjVO8hj
	yYJweAqh3CxObP1RkBL0VQT4dalJgBP3d5z/O0XUGkO+2zZxk0asKObe1ZvfUpg6
	OIbzTPESiFSb7znk7kcaWk1ejSoWWyJ61g1FRoe0EgmUcuP/0ApRcH9AXrDfC4eJ
	ga9ikxYApidIsC2zKU2mafdyvJnQK/djDQdkvEeVup1UFmdMowZzEnv9cCiOVfbw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47cy4jua40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 14:39:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55KDCOlF027466;
	Fri, 20 Jun 2025 14:39:07 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479kt0bqph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 14:39:07 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55KEd6us59834784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 14:39:06 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 010A158064;
	Fri, 20 Jun 2025 14:39:06 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8501258055;
	Fri, 20 Jun 2025 14:39:03 +0000 (GMT)
Received: from [9.61.191.218] (unknown [9.61.191.218])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Jun 2025 14:39:03 +0000 (GMT)
Message-ID: <a1644c15-2a9a-4fc1-a762-b153d167cd1f@linux.ibm.com>
Date: Fri, 20 Jun 2025 20:09:01 +0530
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aFGEzN5c0-b5VdcM@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wllElTPpAt1NH6ibpd1r6bOkVZGaN3aQ
X-Authority-Analysis: v=2.4 cv=a7ww9VSF c=1 sm=1 tr=0 ts=6855728c cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=aK0vNgL49R0hWWOO1ycA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDEwMiBTYWx0ZWRfX1j6EniGvmgOV EmS5RV4wT6Jpv0d7ne0IiMkKil2XZYO5ZU3CjWxif0IsrTlTSHG5pNzIVBhtgL3Asr4ZcjtnfBg j0EU9uuyXADM7VjChy2iz0d/SAaq+uFPoobvfcxQDqg/ZjIwShDvZzXDEJrbIAID3WBFBXzN193
 7clJB5VFwEoQiMTiTMhZLyX3nvlsLZTyBpawFdrLR793GkHW3Ma7kH9bG+vy8l7l4Zb4cPkaphY CppzmQXBhMPB0otp79hNr3o0ZlSfCsV0HWlEYtsk5KnpSNY0yGpECu4lNtD7JJKGyueTfpvmY4M kOdoBACcvRmluVTWkbFfz56BELudqDi0rKXNLJ9Etca/5xhr579kNsXeOMoCTiR6MBdnGGYZjby
 eOMVP1mcX05E5a9oVjK+s0NyKb9uu1+vFbo+kqfHnjCMziTPQ+w9BZiFjIyMyA8gckBab7hA
X-Proofpoint-ORIG-GUID: wllElTPpAt1NH6ibpd1r6bOkVZGaN3aQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_05,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200102



On 6/17/25 8:37 PM, Ming Lei wrote:
> On Mon, Jun 16, 2025 at 11:02:25PM +0530, Nilay Shroff wrote:
>> In preparation for allocating sched_tags before freezing the request
>> queue and acquiring ->elevator_lock, move the elevator queue allocation
>> logic from the elevator ops ->init_sched callback into blk_mq_init_sched.
>>
>> This refactoring provides a centralized location for elevator queue
>> initialization, which makes it easier to store pre-allocated sched_tags
>> in the struct elevator_queue during later changes.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---

[...]

>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>> index 55a0fd105147..d914eb9d61a6 100644
>> --- a/block/blk-mq-sched.c
>> +++ b/block/blk-mq-sched.c
>> @@ -475,6 +475,10 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
>>  	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
>>  				   BLKDEV_DEFAULT_RQ);
>>  
>> +	eq = elevator_alloc(q, e);
>> +	if (!eq)
>> +		return -ENOMEM;
>> +
>>  	if (blk_mq_is_shared_tags(flags)) {
>>  		ret = blk_mq_init_sched_shared_tags(q);
>>  		if (ret)
> 
> The above failure needs to be handled by kobject_put(&eq->kobj).

I think here the elevator_alloc() failure occurs before we initialize 
eq->kobj. So we don't need to handle it with kobject_put(&eq->kobj)
and instead simply returning -ENOMEM should be sufficient. Agree?

> 
> Otherwise, feel free to add:
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 

Thanks,
--Nilay


