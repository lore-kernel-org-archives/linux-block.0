Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882C1990A2
	for <linux-block@vger.kernel.org>; Fri,  7 Feb 2025 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738951373; cv=none; b=kytEFPbuyj2fkfc4vRclHgvUksf8m30RqQZ5Z17Ubxzhw049sSNJEgi3YQiamFJit5onp6iX542VZuzLVlnGGsj4W9TeYbcAT1Pb3Ezx7CnJnP5jqcNialeYbgC1WPa0B45zkdz1az8e2FPWfdCjEYfLozQAHHf7yjigLflZhaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738951373; c=relaxed/simple;
	bh=0p7IgJ0rIYv7ZJPhRSgxogBlfbhRdNgfKwPJM+OLjng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9luViigiMHadcAd+FX7wl8Vk8JX+HcdCEbeOWrGH6iO8TmhxcXsLAqDQ1srcwTgtJT0tEMedP7mW227cMeQVJY7B6lJKQe2xv6aVDIW1juaNI8lW1XoGMeLB9cZosvvZ4Yk/4OPKTDD+tEsy1BASLniQwMQ+ZbEpYqMOu4FUgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b/ZpRg6U; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b/ZpRg6U"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517BVFOn027661;
	Fri, 7 Feb 2025 18:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yIpQp1
	2FTZ/2uHY1soGCDp2OsIbMPf+vb5Dpc83DTI8=; b=b/ZpRg6Uk1CrxbtXFOgEon
	MOIN7DLPHYzus7kbb3ZHANX7gnB5WVSiELBcY5bHOja4v8sk7A2l61uwQ54Skb7c
	pJgCVOF4xjSaiL+W8880xdETUoccuS/9L/9cTuounxrzZYRcTzxwEELQzF6Br1IS
	Tp1neetwZPvNL3B4tyBqjMV1Y3Vb+bGCMv7VnA9G+suGd7qN5lpTLeVlAzOB7JaE
	6BS/fety6UDxopqulLeM/Bx5ZxAB2kEUKGKUCTuUes3KghDuYqre0TE97d1qjgYz
	+ramJ5ik51+UaxjSXWA+4t2YgBWSn1V9bRhrsdGJXkdmKwnlu2oSAMGAWTd8l6JQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44n910c8vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 18:02:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 517FEB2B007130;
	Fri, 7 Feb 2025 18:02:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxb04uty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 18:02:43 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517I2gM925166414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 18:02:42 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA2385804B;
	Fri,  7 Feb 2025 18:02:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 121CF58055;
	Fri,  7 Feb 2025 18:02:40 +0000 (GMT)
Received: from [9.171.18.147] (unknown [9.171.18.147])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 18:02:39 +0000 (GMT)
Message-ID: <fee9de06-e235-43c1-b756-b10e9fa2c68e@linux.ibm.com>
Date: Fri, 7 Feb 2025 23:32:37 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: fix lock ordering between the queue
 ->sysfs_lock and freeze-lock
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
References: <20250205144506.663819-1-nilay@linux.ibm.com>
 <20250205144506.663819-2-nilay@linux.ibm.com> <20250205155952.GB14133@lst.de>
 <715ba1fd-2151-4c39-9169-2559176e30b5@linux.ibm.com>
 <Z6X1hbzI4euK_r-S@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z6X1hbzI4euK_r-S@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LUR9AntVGEjvPmghVcxFskwjAiCUWL3W
X-Proofpoint-GUID: LUR9AntVGEjvPmghVcxFskwjAiCUWL3W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_08,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070134



On 2/7/25 5:29 PM, Ming Lei wrote:
> On Thu, Feb 06, 2025 at 06:52:36PM +0530, Nilay Shroff wrote:
>>
>>
>> On 2/5/25 9:29 PM, Christoph Hellwig wrote:
>>> On Wed, Feb 05, 2025 at 08:14:47PM +0530, Nilay Shroff wrote:
>>>>  
>>>>  static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>>> @@ -5006,8 +5008,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>>>  		return;
>>>>  
>>>>  	memflags = memalloc_noio_save();
>>>> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
>>>> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>>> +		mutex_lock(&q->sysfs_lock);
>>>
>>> This now means we hold up to number of request queues sysfs_lock
>>> at the same time.  I doubt lockdep will be happy about this.
>>> Did you test this patch with a multi-namespace nvme device or
>>> a multi-LU per host SCSI setup?
>>>
>> Yeah I tested with a multi namespace NVMe disk and lockdep didn't 
>> complain. Agreed we need to hold up q->sysfs_lock for multiple 
>> request queues at the same time and that may not be elegant, but 
>> looking at the mess in __blk_mq_update_nr_hw_queues we may not
>> have other choice which could help correct the lock order.
> 
> All q->sysfs_lock instance actually shares same lock class, so this way
> should have triggered double lock warning, please see mutex_init().
> 
Well, my understanding about lockdep is that even though all q->sysfs_lock
instances share the same lock class key, lockdep differentiates locks 
based on their memory address. Since each instance of &q->sysfs_lock has 
got different memory address, lockdep treat each of them as distinct locks 
and IMO, that avoids triggering double lock warning.

> The ->sysfs_lock involved in this patch looks only for sync elevator
> switch with reallocating hctxs, so I am wondering why not add new
> dedicated lock for this purpose only?
> 
> Then we needn't to worry about its dependency with q->q_usage_counter(io)?
> 
Yes that should be possible but then as Christoph suggested, __blk_mq_update_
nr_hw_queues already runs holding tag_list_lock and so why shouldn't we use
the same tag_list_lock even for sched/elevator updates? That way we may avoid
adding another new lock.

Thanks,
--Nilay
